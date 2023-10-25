Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998E7D6896
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjJYKdV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 06:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjJYKdU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 06:33:20 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C90E93
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 03:33:18 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce2c5b2154so3495956a34.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698229998; x=1698834798; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/jW19Zl0nJ+Ipw8Dhf5UrW3WWEvdDseK6Y4qJa5yBw=;
        b=SAN5dGLmTB4BC6c2dFR4x7AK0cn9QtMvWVlIXBJiyEbOeLqygPlkPHQvZJrlJgsmxa
         1hYjiu6Y1ve/W/DHbSPjq5kn+IYA9JEz+7bZSgpJUo78xk9cxSKmpLXRrBqEkhl5H9IM
         OSTQq36vMTA5hj8gLYs0Re4I/WsjXiFF2dKaOAOv96GBwuQZ5PB/i8xU2jGPNTmaosvS
         KUEuahdhmE+Jb18cHD2ij2qayyDegQWVl7Sc9HO0+F7QTLvh4LxuoRkSr1jhaToks9FK
         Du/esXw4N0YX+Qdp7nNVjn7xvnAN6J+zB8/sBP6wfS7CNHqk9ppBSbh7fXdEKtQ+5+w9
         oDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698229998; x=1698834798;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/jW19Zl0nJ+Ipw8Dhf5UrW3WWEvdDseK6Y4qJa5yBw=;
        b=q/lh7uskvpl840KU8HZroIjeQAtbj/YJLuKJSoqBx6RxlnhwhBLC5YKJ9LSAvFvhR3
         0tpGOuKLBkyJRpKJNwOMguEwuQiLA+ArqglE83Fdj/MGgIvxAgiP46qmhahmqJ1iM5p2
         C5pKvtugLDB565SMVtRumIVePhWab1/72/jH+20d5db0lAk2pQlh3THVrYofOd7bGpUF
         BfpKJpfyVlk1NewCyf56lcO+EFozjyQWbnyExHMgP9tnishtv15B/RNCQD4H2cc8jnOC
         GoMX58H/JiDGmek6mP2+BIRzlu0TP457KSdCXgeSKUr2mgrgKQ53ugdpR4F75LoO/cLE
         YCeg==
X-Gm-Message-State: AOJu0YxViHWBb8LMSvjXQaPUqQkbE6uR4sWhThQAfpRAJZkg1pGLYuYP
        dg4BQ9rUdI61OGnTl9jKMg0=
X-Google-Smtp-Source: AGHT+IHQlrRjFdrWhosRMONx9nfDo0zD1Wry6BcSdA+OqqxB1gOsTJvK1RJHfF6ejuPMvsbk6DFzqA==
X-Received: by 2002:a05:6830:410c:b0:6b5:ee8f:73af with SMTP id w12-20020a056830410c00b006b5ee8f73afmr21513870ott.5.1698229997875;
        Wed, 25 Oct 2023 03:33:17 -0700 (PDT)
Received: from localhost ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b00690daae925bsm9024808pfl.51.2023.10.25.03.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Oct 2023 03:33:17 -0700 (PDT)
From:   Jiazi Li <jqqlijiazi@gmail.com>
X-Google-Original-From: Jiazi Li <jiazi.li@transsion.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jiazi Li <jiazi.li@transsion.com>, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: fix bss rbn double erase issue
Date:   Wed, 25 Oct 2023 18:33:04 +0800
Message-Id: <20231025103304.22082-1-jiazi.li@transsion.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If cfg80211_update_assoc_bss_entry call rb_insert_bss re-insert bss
failed because cmp_bss return 0, this bss->rbn will continue to hold
expired data, such as __rd_parent_color.
And this bss still in rdev->bss_list, maybe double erase in
__cfg80211_bss_expire later.
Double erase a rbtree node(with expired parent and color data) maybe
corrupt rbtree, so add a in_rbtree flag to fix this issue.

Signed-off-by: Jiazi Li <jiazi.li@transsion.com>
---
 net/wireless/core.h |  1 +
 net/wireless/scan.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 79b1c6d17847..36dc1e9de6b9 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -178,6 +178,7 @@ struct cfg80211_internal_bss {
 	unsigned long ts;
 	unsigned long refcount;
 	atomic_t hold;
+	bool in_rbtree;
 
 	/* time at the start of the reception of the first octet of the
 	 * timestamp field of the last beacon/probe received for this BSS.
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 8d114faf4842..d54cb47c1be6 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -202,7 +202,8 @@ static bool __cfg80211_unlink_bss(struct cfg80211_registered_device *rdev,
 
 	list_del_init(&bss->list);
 	list_del_init(&bss->pub.nontrans_list);
-	rb_erase(&bss->rbn, &rdev->bss_tree);
+	if (bss->in_rbtree)
+		rb_erase(&bss->rbn, &rdev->bss_tree);
 	rdev->bss_entries--;
 	WARN_ONCE((rdev->bss_entries == 0) ^ list_empty(&rdev->bss_list),
 		  "rdev bss entries[%d]/list[empty:%d] corruption\n",
@@ -1563,6 +1564,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 
 		if (WARN_ON(!cmp)) {
 			/* will sort of leak this BSS */
+			bss->in_rbtree = false;
 			return;
 		}
 
@@ -1572,6 +1574,7 @@ static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 			p = &(*p)->rb_right;
 	}
 
+	bss->in_rbtree = true;
 	rb_link_node(&bss->rbn, parent, p);
 	rb_insert_color(&bss->rbn, &rdev->bss_tree);
 }
@@ -3061,7 +3064,8 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 			rdev->bss_generation++;
 	}
 
-	rb_erase(&cbss->rbn, &rdev->bss_tree);
+	if (cbss->in_rbtree)
+		rb_erase(&cbss->rbn, &rdev->bss_tree);
 	rb_insert_bss(rdev, cbss);
 	rdev->bss_generation++;
 
@@ -3070,7 +3074,8 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 				 nontrans_list) {
 		bss = bss_from_pub(nontrans_bss);
 		bss->pub.channel = chan;
-		rb_erase(&bss->rbn, &rdev->bss_tree);
+		if (bss->in_rbtree)
+			rb_erase(&bss->rbn, &rdev->bss_tree);
 		rb_insert_bss(rdev, bss);
 		rdev->bss_generation++;
 	}
-- 
2.17.1

