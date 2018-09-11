class ScratchWorker

    def self.get_longest_post
        m = 0
        id = 0
        Post.all.each do |post|
            if post.text.length > m
                m = post.text.length
                id = post.id
            end
        end

        puts id
    end

end