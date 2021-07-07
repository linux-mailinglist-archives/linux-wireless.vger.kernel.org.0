Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CBD3BF171
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jul 2021 23:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhGGVlI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jul 2021 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGGVlI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jul 2021 17:41:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B8C061574
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jul 2021 14:38:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c28so8022633lfp.11
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jul 2021 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mosenkovs.lv; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OwlJWrunZUH5AmTk/sBj6uUkPRnYkvBou32/lBV+qHU=;
        b=LOKi2+KLdVMQvqqienx//zUtH+DUyDZYdiKb0ikIQUoZ7gZsE9SnnocaTks64aM1GG
         RwwgGt6DVDihaYmWuHFtN/9zNSrcN9cEeKjiX7O3LG6HSUnmBJ1+Etldsr0pRuZJuGhQ
         I8N8S1BpFABjLEmb5wcegIGhLz97MQatoavIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OwlJWrunZUH5AmTk/sBj6uUkPRnYkvBou32/lBV+qHU=;
        b=MNo7TcVCU0xz5Bi2n6sBjHmpJjC+Uz1/9bb9PkdIXuap+3K2eZ0aENADbXkTCdWaoX
         r70biV+WbiRkl68hbgj4UfNJfP4piTFMpWtistqy9lFTlsI/uwoLyKiqFJLYjY2TaZR6
         93zGinBydHAAUMjnnS9Ewku/Xgi1L4vZurYQOLsIiM8s+IzwjmmiVtQ4N3PLnXmK4tQ0
         Ztq4g28VxEuTmoyrsdD3+pNmvOPBP/oIVITOqtAKt1vYKmwHrygoe8Z8q9CVWhFLcaoU
         fcj+aqYNTK6Hp25lKCuxFqQb5m96KeK7lNCSEY2NPLOVCKOUJJ6zc3A9KsdUqTgs4Y40
         Nr9w==
X-Gm-Message-State: AOAM530QcOcE+Zui0fJAaoQ1dMVnt9964Gyt5As1NRtPAi0LMf88H0Ji
        Jv/RldkrsLEH9yTr+9paJJzByg==
X-Google-Smtp-Source: ABdhPJw1/p9BscOJUdpSz9UOUu7/fdjvJSOAUgtu1nrFlyxqwY+L9WRqmJly5KTf2H/qkqTesjPQyQ==
X-Received: by 2002:a2e:a7c7:: with SMTP id x7mr20251520ljp.442.1625693905335;
        Wed, 07 Jul 2021 14:38:25 -0700 (PDT)
Received: from ubuntu.ciemini.majas.lan (balticom-135-235.balticom.lv. [83.99.135.235])
        by smtp.gmail.com with ESMTPSA id u26sm22173lju.53.2021.07.07.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 14:38:24 -0700 (PDT)
From:   Davis Mosenkovs <davis@mosenkovs.lv>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Davis Mosenkovs <davis@mosenkovs.lv>
Subject: [PATCH 4.9] mac80211: fix memory corruption in EAPOL handling
Date:   Thu,  8 Jul 2021 00:38:20 +0300
Message-Id: <20210707213820.1088026-1-davis@mosenkovs.lv>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 5551cb1c68d4 ("mac80211: do not accept/forward invalid EAPOL
frames") uses skb_mac_header() before eth_type_trans() is called
leading to incorrect pointer, the pointer gets written to. This issue
has appeared during backporting to 4.4, 4.9 and 4.14.

Fixes: 5551cb1c68d4 ("mac80211: do not accept/forward invalid EAPOL frames")
Link: https://lore.kernel.org/r/CAHQn7pKcyC_jYmGyTcPCdk9xxATwW5QPNph=bsZV8d-HPwNsyA@mail.gmail.com
Signed-off-by: Davis Mosenkovs <davis@mosenkovs.lv>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 3a069cb188b7..b40e71a5d795 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2380,7 +2380,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 #endif
 
 	if (skb) {
-		struct ethhdr *ehdr = (void *)skb_mac_header(skb);
+		struct ethhdr *ehdr = (struct ethhdr *)skb->data;
 
 		/* deliver to local stack */
 		skb->protocol = eth_type_trans(skb, dev);
-- 
2.25.1

