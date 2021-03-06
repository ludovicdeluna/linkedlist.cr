require "./spec_helper.cr"

describe "Singly" do
  describe "#new" do
    ll = Linkedlist::Singly(Int32).new

    it "should have zero length" do
      ll.length.should eq(0)
    end

    it "should have head as nil" do
      ll.head.should be_nil
    end

    it "should have tail as nil" do
      ll.tail.should be_nil
    end
  end

  describe "#insert_head" do
    ll = Linkedlist::Singly(Int32).new

    context "when inserting in empty linked list" do
      ll.insert_head(1)

      it "should have length 1" do
        ll.length.should eq(1)
      end

      it "should have non-nil head" do
        ll.head.should_not be_nil
      end

      it "should have head with data as 1" do
        head = ll.head
        head.should_not be_nil
        if head
          head.data.should eq(1)
        end
      end

      it "should have tail with data as 1" do
        tail = ll.tail
        tail.should_not be_nil
        if tail
          tail.data.should eq(1)
        end
      end
    end

    context "when inserting in non-empty linked list " do
      ll.insert_head(2)

      it "should have length 2" do
        ll.length.should eq(2)
      end

      it "should have head with data as 2" do
        head = ll.head
        head.should_not be_nil
        if head
          head.data.should eq(2)
        end
      end

      it "should have tail with data as 1" do
        tail = ll.tail
        tail.should_not be_nil
        if tail
          tail.data.should eq(1)
        end
      end
    end

    context "when traversing" do
      it "should traverse forward with correct values" do
        curr = ll.head
        expected = [2, 1]
        testIndex = 0
        while curr
          curr.data.should eq(expected[testIndex])
          testIndex += 1
          curr = curr.next
        end
      end
    end
  end

  describe "#insert_tail" do
    ll = Linkedlist::Singly(Int32).new

    context "when inserting in empty linked list" do
      ll.insert_tail(1)

      it "should have length 1" do
        ll.length.should eq(1)
      end

      it "should have tail with data as 1" do
        tail = ll.tail
        tail.should_not be_nil
        if tail
          tail.data.should eq(1)
        end
      end

      it "should have head with data as 1" do
        head = ll.head
        head.should_not be_nil
        if head
          head.data.should eq(1)
        end
      end
    end

    context "when inserting in non-empty linked list" do
      ll.insert_tail(2)

      it "should have length 1" do
        ll.length.should eq(2)
      end

      it "should have non-nil head" do
        ll.head.should_not be_nil
      end

      it "should have head with data as 1" do
        head = ll.head
        head.should_not be_nil
        if head
          head.data.should eq(1)
        end
      end

      it "should have tail with data as 2" do
        tail = ll.tail
        tail.should_not be_nil
        if tail
          tail.data.should eq(2)
        end
      end
    end

    context "when traversing" do
      it "should traverse forward with correct values" do
        curr = ll.head
        expected = [1, 2]
        testIndex = 0
        while curr
          curr.data.should eq(expected[testIndex])
          testIndex += 1
          curr = curr.next
        end
      end
    end
  end

  describe "#remove" do
    ll = Linkedlist::Singly(Int32).new

    context "when removing at head till empty" do
      10.times do |i|
        ll.insert_head(i + 1)
      end

      it "should remove head" do
        head = ll.head
        while head
          ll.remove(head).should eq(head.data)
          head = ll.head
        end

        ll.head.should be_nil
        ll.tail.should be_nil
      end
    end

    context "when removing at tail till empty" do
      10.times do |i|
        ll.insert_head(i + 1)
      end

      it "should remove head" do
        tail = ll.tail
        while tail
          ll.remove(tail).should eq(tail.data)
          tail = ll.tail
        end

        ll.tail.should be_nil
        ll.head.should be_nil
      end
    end
  end

  describe "#find_element" do
    ll = Linkedlist::Singly(Int32).new

    context "when trying to find in empty list" do
      it "should raise exception" do
        expect_raises { ll.find_element(2) }

        nonMember = Linkedlist::SinglyNode(Int32).new(1, nil)
        expect_raises { ll.find_element(nonMember) }
      end
    end

    context "when trying to find non-empty list" do
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      it "should raise exception if not found" do
        expect_raises { ll.find_element(20) }

        nonMember = Linkedlist::SinglyNode(Int32).new(1, nil)
        expect_raises { ll.find_element(nonMember) }
      end

      it "should return element if found" do
        found = ll.find_element(8)
        found.should_not be_nil

        if found
          nextElement = found.next
          nextElement.should_not be_nil

          if nextElement
            nextElement.data.should eq(9)
          end
        end

        to_find = ll.find_element(2)
        to_find.should_not be_nil

        found = ll.find_element(to_find)
        if found
          nextElement = found.next
          nextElement.should_not be_nil

          if nextElement
            nextElement.data.should eq(3)
          end
        end
      end
    end
  end

  describe "#find_element?" do
    ll = Linkedlist::Singly(Int32).new

    context "when trying to find in empty list" do
      it "should return nil" do
        ll.find_element?(2).should be_nil

        nonMember = Linkedlist::SinglyNode(Int32).new(1, nil)
        ll.find_element?(nonMember).should be_nil
      end
    end

    context "when trying to find non-empty list" do
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      it "should return nil if not found" do
        ll.find_element?(20).should be_nil

        nonMember = Linkedlist::SinglyNode(Int32).new(20, nil)
        ll.find_element?(nonMember).should be_nil

        nonMember = Linkedlist::SinglyNode(Int32).new(1, nil)
        ll.find_element?(nonMember).should be_nil
      end

      it "should return element if found" do
        found = ll.find_element?(8)
        found.should_not be_nil

        if found
          nextElement = found.next
          nextElement.should_not be_nil

          if nextElement
            nextElement.data.should eq(9)
          end
        end
      end
    end
  end

  describe "#insert_after" do
    context "inside list with single element" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)

      context "when trying to insert after non-existing element" do
        it "should raise exception" do
          nonMember = Linkedlist::SinglyNode.new(11, nil)
          expect_raises { ll.insert_after(2, nonMember) }
        end
      end

      context "when trying to insert after existing element" do
        it "should return back inserted element" do
          member = ll.find_element(1)
          inserted = ll.insert_after(2, member)

          next_element = inserted.next
          next_element.should be_nil
          ll.tail.should eq(inserted)
        end
      end
    end

    context "inside list with multiple elements" do
      ll = Linkedlist::Singly(Int32).new
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      context "when trying to insert after non-existing element" do
        it "should raise exception" do
          nonMember = Linkedlist::SinglyNode.new(11, nil)
          expect_raises { ll.insert_after(1, nonMember) }
        end
      end

      context "when trying to insert after existing element" do
        it "should return back inserted element" do
          member = ll.find_element(8)
          inserted = ll.insert_after(1, member)

          next_element = inserted.next
          if next_element
            next_element.data.should eq(9)
          end
        end
      end
    end
  end

  describe "#insert_after?" do
    context "inside list with single element" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)

      context "when trying to insert after non-existing element" do
        it "should raise exception" do
          nonMember = Linkedlist::SinglyNode.new(11, nil)
          ll.insert_after?(2, nonMember).should be_nil
        end
      end

      context "when trying to insert after existing element" do
        it "should return back inserted element" do
          member = ll.find_element(1)
          inserted = ll.insert_after?(2, member)

          inserted.should_not be_nil
          if inserted
            next_element = inserted.next
            next_element.should be_nil
            ll.tail.should eq(inserted)
          end
        end
      end
    end

    context "inside list with multiple elements" do
      ll = Linkedlist::Singly(Int32).new
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      context "when trying to insert after non-existing element" do
        it "should raise exception" do
          nonMember = Linkedlist::SinglyNode.new(11, nil)
          ll.insert_after?(1, nonMember).should be_nil
        end
      end

      context "when trying to insert after existing element" do
        it "should return back inserted element" do
          member = ll.find_element(8)
          inserted = ll.insert_after?(1, member)

          inserted.should_not be_nil

          if inserted
            next_element = inserted.next
            if next_element
              next_element.data.should eq(9)
            end
          end
        end
      end
    end
  end

  describe "#previous_element?" do
    ll = Linkedlist::Singly(Int32).new

    context "when finding in empty list" do
      it "should return nil" do
        nonMember = Linkedlist::SinglyNode(Int32).new(10, nil)
        ll.previous_element?(nonMember).should be_nil
      end
    end

    context "when finding in non-empty list" do
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      it "should return nil for non-existing member" do
        nonMember = Linkedlist::SinglyNode(Int32).new(10, nil)
        ll.previous_element?(nonMember).should be_nil
      end

      it "should return previous element for existing member" do
        member = ll.find_element(10)
        prev = ll.previous_element?(member)
        prev.should_not be_nil
        prev.should eq(ll.find_element(9))
      end
    end
  end

  describe "#insert_before?" do
    context "inside list with single element" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)

      context "when trying to insert before non-existing element" do
        it "should raise exception" do
          nonMember = Linkedlist::SinglyNode.new(11, nil)
          ll.insert_before?(2, nonMember).should be_nil
        end
      end

      context "when trying to insert before existing element" do
        it "should return back inserted element" do
          member = ll.find_element(1)
          inserted = ll.insert_before?(2, member)

          inserted.should_not be_nil
          if inserted
            next_element = inserted.next
            next_element.should eq(member)
            ll.head.should eq(inserted)
          end
        end
      end
    end

    context "inside list with multiple elements" do
      ll = Linkedlist::Singly(Int32).new
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      context "when trying to insert before non-existing element" do
        it "should raise exception" do
          nonMember = Linkedlist::SinglyNode.new(11, nil)
          ll.insert_before?(1, nonMember).should be_nil
        end
      end

      context "when trying to insert before existing element" do
        it "should return back inserted element" do
          member = ll.find_element(8)
          inserted = ll.insert_before?(1, member)

          inserted.should_not be_nil

          if inserted
            next_element = inserted.next
            next_element.should eq(member)
          end
        end
      end
    end
  end

  describe "#insert_before" do
    context "inside list with single element" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)

      context "when trying to insert before non-existing element" do
        it "should raise exception" do
          nonMember = Linkedlist::SinglyNode.new(11, nil)
          expect_raises { ll.insert_before(2, nonMember) }
        end
      end

      context "when trying to insert before existing element" do
        it "should return back inserted element" do
          member = ll.find_element(1)
          inserted = ll.insert_before(2, member)

          if inserted
            next_element = inserted.next
            next_element.should eq(member)
            ll.head.should eq(inserted)
          end
        end
      end
    end

    context "inside list with multiple elements" do
      ll = Linkedlist::Singly(Int32).new
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      context "when trying to insert before non-existing element" do
        it "should raise exception" do
          nonMember = Linkedlist::SinglyNode.new(11, nil)
          expect_raises { ll.insert_before(1, nonMember) }
        end
      end

      context "when trying to insert before existing element" do
        it "should return back inserted element" do
          member = ll.find_element(8)
          inserted = ll.insert_before(1, member)

          if inserted
            next_element = inserted.next
            next_element.should eq(member)
          end
        end
      end
    end
  end

  describe "#move_to_front" do
    context "inside an empty list" do
      ll = Linkedlist::Singly(Int32).new

      it "should not do anything" do
        non_member = Linkedlist::SinglyNode(Int32).new(1, nil)
        ll.move_to_front(non_member)
      end
    end

    context "inside list with one element" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)

      it "should preserve the same head" do
        prev_head = ll.head
        if prev_head
          ll.move_to_front(prev_head)
        end
        prev_head.should eq(ll.head)
      end
    end

    context "inside list with multiple elements" do
      ll = Linkedlist::Singly(Int32).new
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      it "should not do anything for non-member" do
        prev_head = ll.head
        non_member = Linkedlist::SinglyNode(Int32).new(11, nil)
        ll.move_to_front(non_member)
        prev_head.should eq(ll.head)

        curr = ll.head
        expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        testIndex = 0
        while curr
          curr.data.should eq(expected[testIndex])
          curr = curr.next
          testIndex += 1
        end
      end

      it "should move to front for member" do
        five = ll.find_element(5)
        ll.move_to_front(five)

        curr = ll.head
        if curr
          curr.should eq(five)
        end
        expected = [5, 1, 2, 3, 4, 6, 7, 8, 9, 10]
        testIndex = 0
        while curr
          curr.data.should eq(expected[testIndex])
          curr = curr.next
          testIndex += 1
        end
      end
    end
  end

  describe "#move_to_back" do
    context "inside an empty list" do
      ll = Linkedlist::Singly(Int32).new

      it "should not do anything" do
        non_member = Linkedlist::SinglyNode(Int32).new(1, nil)
        ll.move_to_back(non_member)
      end
    end

    context "inside list with one element" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)

      it "should preserve the same tail" do
        prev_tail = ll.tail
        if prev_tail
          ll.move_to_back(prev_tail)
        end
        prev_tail.should eq(ll.tail)
      end
    end

    context "inside list with multiple elements" do
      ll = Linkedlist::Singly(Int32).new
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      it "should not do anything for non-member" do
        prev_tail = ll.tail
        non_member = Linkedlist::SinglyNode(Int32).new(11, nil)
        ll.move_to_back(non_member)
        prev_tail.should eq(ll.tail)

        curr = ll.head
        expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        testIndex = 0
        while curr
          curr.data.should eq(expected[testIndex])
          curr = curr.next
          testIndex += 1
        end
      end

      it "should move to back for member" do
        five = ll.find_element(5)
        ll.move_to_back(five)

        curr = ll.head
        expected = [1, 2, 3, 4, 6, 7, 8, 9, 10, 5]
        testIndex = 0
        while curr
          curr.data.should eq(expected[testIndex])
          curr = curr.next
          testIndex += 1
        end

        ll.tail.should eq(five)
      end
    end
  end

  describe "#move_before" do
    context "inside an empty list" do
      ll = Linkedlist::Singly(Int32).new

      it "should do nothing" do
        non_member_1 = Linkedlist::SinglyNode(Int32).new(1, nil)
        non_member_2 = Linkedlist::SinglyNode(Int32).new(2, nil)
        ll.move_before(non_member_2, non_member_1)

        ll.head.should be_nil
        ll.tail.should be_nil
      end
    end

    context "inside list with one element" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)

      it "should do nothing" do
        prev_head = ll.head
        prev_tail = ll.tail

        non_member = Linkedlist::SinglyNode(Int32).new(1, nil)
        if prev_head
          ll.move_before(non_member, prev_head)
        end

        ll.head.should eq(prev_head)
        ll.tail.should eq(prev_tail)
      end
    end

    context "inside list with two elements" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)
      ll.insert_tail(2)

      it "should not move before if already in position" do
        one = ll.find_element(1)
        two = ll.find_element(2)
        ll.move_before(one, two)

        ll.head.should eq(one)
        ll.tail.should eq(two)
        one.next.should eq(two)
        two.next.should be_nil
      end

      it "should move before if both found" do
        one = ll.find_element(1)
        two = ll.find_element(2)
        ll.move_before(two, one)

        ll.head.should eq(two)
        ll.tail.should eq(one)
        one.next.should be_nil
        two.next.should eq(one)
      end
    end

    context "inside list with multiple elements" do
      ll = Linkedlist::Singly(Int32).new
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      it "should move before if both found" do
        five = ll.find_element(5)
        six = ll.find_element(6)
        ll.move_before(six, five)

        four = ll.find_element(4)
        seven = ll.find_element(7)
        four.next.should eq(six)
        six.next.should eq(five)
        five.next.should eq(seven)
      end
    end
  end

  describe "#move_after" do
    context "inside an empty list" do
      ll = Linkedlist::Singly(Int32).new

      it "should do nothing" do
        non_member_1 = Linkedlist::SinglyNode(Int32).new(1, nil)
        non_member_2 = Linkedlist::SinglyNode(Int32).new(2, nil)
        ll.move_after(non_member_2, non_member_1)

        ll.head.should be_nil
        ll.tail.should be_nil
      end
    end

    context "inside list with one element" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)

      it "should do nothing" do
        prev_head = ll.head
        prev_tail = ll.tail

        non_member = Linkedlist::SinglyNode(Int32).new(1, nil)
        if prev_head
          ll.move_after(non_member, prev_head)
        end

        ll.head.should eq(prev_head)
        ll.tail.should eq(prev_tail)
      end
    end

    context "inside list with two elements" do
      ll = Linkedlist::Singly(Int32).new
      ll.insert_tail(1)
      ll.insert_tail(2)

      it "should not move after if already in position" do
        one = ll.find_element(1)
        two = ll.find_element(2)
        ll.move_after(two, one)

        ll.head.should eq(one)
        ll.tail.should eq(two)
        one.next.should eq(two)
        two.next.should be_nil
      end

      it "should move after if both found" do
        one = ll.find_element(1)
        two = ll.find_element(2)
        ll.move_after(one, two)

        ll.head.should eq(two)
        ll.tail.should eq(one)
        one.next.should be_nil
        two.next.should eq(one)
      end
    end

    context "inside list with multiple elements" do
      ll = Linkedlist::Singly(Int32).new
      10.times do |i|
        ll.insert_tail(i + 1)
      end

      it "should move after if both found" do
        five = ll.find_element(5)
        six = ll.find_element(6)
        ll.move_after(five, six)

        four = ll.find_element(4)
        seven = ll.find_element(7)
        four.next.should eq(six)
        six.next.should eq(five)
        five.next.should eq(seven)
      end
    end
  end
end
