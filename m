Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A9BACB87
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfIHIUt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:20:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfIHIUt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:20:49 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B992489C33
        for <linux-wireless@vger.kernel.org>; Sun,  8 Sep 2019 08:20:48 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id c2so6212859edy.18
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 01:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDUlvgh3TJNH+HOn7EG167U749zEBUbsuQdh4Cjmd8A=;
        b=VsG4YVk7MIEXrIkRuUsjOvRMGrW//fxQdsW0JTcjPQL2xSGLaDaRGYMrPimh6QOef0
         xzfuwB6fYYfYKkrY2Dc+JoBNCAP6agQY9AyGn67Wk11B0k4WG2KEDZhMetM8hwV39S/1
         96CvCtymOA2Q3XTsNPJDqgZyIIOYSj7bwEj2a5OS/s38CrWUXbjIzUkHrhPhs+dYfFVE
         zyOYBN2FEqotbBzOVu3L5lK9Oe87/8s1DS/5UXjK0re352jZgOiEc/eswJTA8fMapGXT
         SazQTUx3RvZ5RhBpP1P3y76CUuBzwQBg4MHqKrWnySGfpLfghhdlodnwDAnGy34l7Is2
         N9ng==
X-Gm-Message-State: APjAAAW32ZsclU7fIlPrObfTkbX7qA1RURn9Ql4JU2g/cbXjTWiQHt0u
        EZ3cuijf6eiRbYDor3thGJS3Fi5QEesPNm7ONRIoMBh5eSkQQJe6BBaAa9P6BCfVpxvVYqriEcd
        +3h2nOzWsitpK9dPTMHerHf5Uf1w=
X-Received: by 2002:aa7:da18:: with SMTP id r24mr18610345eds.37.1567930847461;
        Sun, 08 Sep 2019 01:20:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyUine6UkF8vYruWsm1TkYCnL+NgjVhuiXx0uWhrtbmqhr23a4HHNDbcMc+Zio0U1jaFUENZQ==
X-Received: by 2002:aa7:da18:: with SMTP id r24mr18610313eds.37.1567930847128;
        Sun, 08 Sep 2019 01:20:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id t21sm1364896ejs.37.2019.09.08.01.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 01:20:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0F739180615; Sun,  8 Sep 2019 09:20:44 +0100 (WEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        syzbot+4e7a85b1432052e8d6f8@syzkaller.appspotmail.com
Subject: [PATCH bpf-next] xdp: Fix race in dev_map_hash_update_elem() when replacing element
Date:   Sun,  8 Sep 2019 09:20:16 +0100
Message-Id: <20190908082016.17214-1-toke@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <0000000000005091a70591d3e1d9@google.com>
References: <0000000000005091a70591d3e1d9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot found a crash in dev_map_hash_update_elem(), when replacing an
element with a new one. Jesper correctly identified the cause of the crash
as a race condition between the initial lookup in the map (which is done
before taking the lock), and the removal of the old element.

Rather than just add a second lookup into the hashmap after taking the
lock, fix this by reworking the function logic to take the lock before the
initial lookup.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Reported-and-tested-by: syzbot+4e7a85b1432052e8d6f8@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9af048a932b5..d27f3b60ff6d 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -650,19 +650,22 @@ static int __dev_map_hash_update_elem(struct net *net, struct bpf_map *map,
 	u32 ifindex = *(u32 *)value;
 	u32 idx = *(u32 *)key;
 	unsigned long flags;
+	int err = -EEXIST;
 
 	if (unlikely(map_flags > BPF_EXIST || !ifindex))
 		return -EINVAL;
 
+	spin_lock_irqsave(&dtab->index_lock, flags);
+
 	old_dev = __dev_map_hash_lookup_elem(map, idx);
 	if (old_dev && (map_flags & BPF_NOEXIST))
-		return -EEXIST;
+		goto out_err;
 
 	dev = __dev_map_alloc_node(net, dtab, ifindex, idx);
-	if (IS_ERR(dev))
-		return PTR_ERR(dev);
-
-	spin_lock_irqsave(&dtab->index_lock, flags);
+	if (IS_ERR(dev)) {
+		err = PTR_ERR(dev);
+		goto out_err;
+	}
 
 	if (old_dev) {
 		hlist_del_rcu(&old_dev->index_hlist);
@@ -683,6 +686,10 @@ static int __dev_map_hash_update_elem(struct net *net, struct bpf_map *map,
 		call_rcu(&old_dev->rcu, __dev_map_entry_free);
 
 	return 0;
+
+out_err:
+	spin_unlock_irqrestore(&dtab->index_lock, flags);
+	return err;
 }
 
 static int dev_map_hash_update_elem(struct bpf_map *map, void *key, void *value,
-- 
2.23.0

