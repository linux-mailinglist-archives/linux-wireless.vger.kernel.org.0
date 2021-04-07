Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0196535615D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 04:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbhDGCT1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Apr 2021 22:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbhDGCTY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Apr 2021 22:19:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B9FC06174A
        for <linux-wireless@vger.kernel.org>; Tue,  6 Apr 2021 19:19:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso445510pji.3
        for <linux-wireless@vger.kernel.org>; Tue, 06 Apr 2021 19:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5ftgXbb+KVQyjP80P099SNuu0mSDE7rKZztUK1dnRA=;
        b=UyeUjla4ieFbQqjOxbSY05+00qAZd85yaru96bjvYehszGSV+0hFYr60pGvTsDwAN0
         JSZmQumxkyZKRLOWjk6BYnJ3aZvPXth3VJe658MniHOi/6/udyciSv0pMK079YUvNNbJ
         OpgQmtoZS7zgDCXVcmmUKH0cN06BzzfAZFIDWU7FWq9ZBpB/DHAtfknCbiGK6V5im9nv
         EFYuTT0QQNBm5xVtPrsxlkluCnN0TKJu84xJ7OSFHIK0jZr3OklG/Gj7Ur0C0xoO2lzn
         KnnvWJ43xV9eTApjkz1ZirszypMkJSXeE/jbNxeal5+2rPAA5Poz3MxbuTJDE+vrEXIE
         RGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5ftgXbb+KVQyjP80P099SNuu0mSDE7rKZztUK1dnRA=;
        b=TVwWoH7P6V7VVJDvQV8zdRalrzLVggatGQidD04U+Y+KWdeDnzmeoyEENBKiIDE3F/
         hsCcCZmyzZRHNxBwh5SbQ3AKrat3GKYKCt79LWlsZ1cS/hKu0BW2t1RH2Cb5IY7ApUxn
         Fw7IbnRiZDRRkjhmKXHM2iZLVE/FExqy5Ewi3j2HOJbzRyX/9Xd0/prMDsa6iLk6mlOb
         RvEcwKNhWSiidJyeRrZqwzwRXr9z/5bJ/t0Myvjzqwzi6F+4qdgmORsADNRKsWtdcxJj
         jE3YUfVjupT16HM/kq1jnhbvG0GfOUsbMK6A2jYcbH9o43xVivRfLtUBe1cY5blj6ybL
         63jQ==
X-Gm-Message-State: AOAM532NeZx5cZ0eO2bTgy2uR/ltRxIHDevAxaUSefSbnhsPJFeoOt+7
        2vnfIXRwDpEKffFf3Qg/fCc=
X-Google-Smtp-Source: ABdhPJx2jqHEyz6IEgoskIPB+kMbJaFUfBG6g33ZoBchF8Omyk/zAHFGJQ85ZA5VuHuHKce0LKPv9A==
X-Received: by 2002:a17:902:bc89:b029:e9:2cd7:382e with SMTP id bb9-20020a170902bc89b02900e92cd7382emr1061664plb.68.1617761954814;
        Tue, 06 Apr 2021 19:19:14 -0700 (PDT)
Received: from nuc.c.rabbit-hole-integration-007.internal ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id x19sm19646288pfc.152.2021.04.06.19.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 19:19:13 -0700 (PDT)
From:   Du Cheng <ducheng2@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Du Cheng <ducheng2@gmail.com>,
        syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Subject: [PATCH] net: wireless: convert WARN_ON() to pr_warn() in cfg80211_sme_connect
Date:   Wed,  7 Apr 2021 10:19:03 +0800
Message-Id: <20210407021903.384158-1-ducheng2@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A WARN_ON(wdev->conn) would trigger in cfg80211_sme_connect(), if
multiple send_msg() system calls are made from the userland, which
should be anticipated and handled by the wireless driver. Convert this
WARN() to pr_warn to prevent a kernel panic if kernel is configured to
"panic on warn".

Bug reported by syzbot.

Reported-by: syzbot+5f9392825de654244975@syzkaller.appspotmail.com
Signed-off-by: Du Cheng <ducheng2@gmail.com>
---
link to syzkaller:
https://syzkaller.appspot.com/bug?extid=5f9392825de654244975
this patch has passed syzbot test.
 net/wireless/sme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 07756ca5e3b5..87a65a4c40ae 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -529,8 +529,10 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
 		cfg80211_sme_free(wdev);
 	}
 
-	if (WARN_ON(wdev->conn))
+	if (wdev->conn) {
+		pr_warn("%s: wdev->conn != NULL, sme connect in progress", __func__);
 		return -EINPROGRESS;
+	}
 
 	wdev->conn = kzalloc(sizeof(*wdev->conn), GFP_KERNEL);
 	if (!wdev->conn)
-- 
2.30.2

