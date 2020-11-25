Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07D32C450F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 17:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgKYQZn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 11:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbgKYQZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 11:25:42 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73339C061A52
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 08:25:40 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id lz20so932247ejb.13
        for <linux-wireless@vger.kernel.org>; Wed, 25 Nov 2020 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ns+ALaUjBfFLyzcgXQh+NiEv1r+gQQ1waIohWFLeGG4=;
        b=BVtZZrYK8UoweuFZ6q9VwAcATSuAzjAo90G0FD6sKkmM+oSnR/7UUi1aS/HtPqcWfv
         xyjX43XNUWmXRA0cQAF/pegFrqQhniaDA0QWdf4XZe9m+rje7y6mPpCSF68r+fXrqpS/
         jibZCQP/45ZmCH4GZHeBqybqm3KrgrAvYCEO2DaNyN0Sp3tlcEa3v6I6S+xLXcspbWob
         EE3W3Eywnh8beo2ISlC4shjwdbc2GhXuXTtJB5VqcbBnDLrjDG6dDJ0+zcEGOVIZk/iN
         c/tZzHO6FFY/AEKumD3urgQqeVBPPLsnSmuvcx3gR2a+y+0wK7iOIGWhNQtUpGkuPCpH
         96aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ns+ALaUjBfFLyzcgXQh+NiEv1r+gQQ1waIohWFLeGG4=;
        b=pA4vJPz77MpfdV07Qdi5Rhfu6SU/My+hvKMHPAPym5SxVzKXuKgUc4VduTL8z4u4Ck
         TbpQUYTwzvydPiVkX6UcyZBzW+QIxkzK5xL/P9Zs55wT4nhtNNenKxJY3q4P7Y2QjAnP
         71sAiIUseMf5wlhY3mSEqv/BvkjEnqalYKk2mX3FuPqlfePkPGhdz5EpGCTIJ70jETnz
         RI9u7AGoKEtIzdCozV3we/MBKMdgY0cLPrrM32VFPMOT8i+aTqp5Tlu48tRTRXg0tFiD
         UGJvXQ69RaxRi9LqvRp9vJXKsR6fTfn5HdLO+28aTlkt8Vq6uoIBCROv4fwMFGdOBdNR
         YCBQ==
X-Gm-Message-State: AOAM530Exxy90vVQMOSsgp8mdRUE7A7m2+eg3u3oQVW3Y1IVA8DzVbTk
        uIJavzd/t11PSxjFIKSWtsrpQWG2VQ==
X-Google-Smtp-Source: ABdhPJzl6SL1b2GM2ZIg1Swr5cqBB5jmFSLWXFilIZCgmO/PbKagnh7GePGNgx32CZOFvWwMmfGNCu3rPQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a17:906:d102:: with SMTP id
 b2mr3829579ejz.52.1606321538854; Wed, 25 Nov 2020 08:25:38 -0800 (PST)
Date:   Wed, 25 Nov 2020 17:24:55 +0100
In-Reply-To: <20201125162455.1690502-1-elver@google.com>
Message-Id: <20201125162455.1690502-4-elver@google.com>
Mime-Version: 1.0
References: <20201125162455.1690502-1-elver@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v6 3/3] mac80211: add KCOV remote annotations to incoming
 frame processing
From:   Marco Elver <elver@google.com>
To:     elver@google.com, davem@davemloft.net, kuba@kernel.org,
        johannes@sipsolutions.net
Cc:     akpm@linux-foundation.org, a.nogikh@gmail.com, edumazet@google.com,
        andreyknvl@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, idosch@idosch.org, fw@strlen.de,
        willemb@google.com, Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aleksandr Nogikh <nogikh@google.com>

Add KCOV remote annotations to ieee80211_iface_work() and
ieee80211_rx_list(). This will enable coverage-guided fuzzing of
mac80211 code that processes incoming 802.11 frames.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
---
 net/mac80211/iface.c |  2 ++
 net/mac80211/rx.c    | 16 +++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1be775979132..56a1bcea2c1c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1356,6 +1356,7 @@ static void ieee80211_iface_work(struct work_struct *work)
 	while ((skb = skb_dequeue(&sdata->skb_queue))) {
 		struct ieee80211_mgmt *mgmt = (void *)skb->data;
 
+		kcov_remote_start_common(skb_get_kcov_handle(skb));
 		if (ieee80211_is_action(mgmt->frame_control) &&
 		    mgmt->u.action.category == WLAN_CATEGORY_BACK) {
 			int len = skb->len;
@@ -1465,6 +1466,7 @@ static void ieee80211_iface_work(struct work_struct *work)
 		}
 
 		kfree_skb(skb);
+		kcov_remote_stop();
 	}
 
 	/* then other type-dependent work */
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1e2e5a406d58..09d1c9fb8872 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4742,6 +4742,8 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 
 	status->rx_flags = 0;
 
+	kcov_remote_start_common(skb_get_kcov_handle(skb));
+
 	/*
 	 * Frames with failed FCS/PLCP checksum are not returned,
 	 * all other frames are returned without radiotap header
@@ -4749,15 +4751,15 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	 * Also, frames with less than 16 bytes are dropped.
 	 */
 	skb = ieee80211_rx_monitor(local, skb, rate);
-	if (!skb)
-		return;
-
-	ieee80211_tpt_led_trig_rx(local,
-			((struct ieee80211_hdr *)skb->data)->frame_control,
-			skb->len);
+	if (skb) {
+		ieee80211_tpt_led_trig_rx(local,
+					  ((struct ieee80211_hdr *)skb->data)->frame_control,
+					  skb->len);
 
-	__ieee80211_rx_handle_packet(hw, pubsta, skb, list);
+		__ieee80211_rx_handle_packet(hw, pubsta, skb, list);
+	}
 
+	kcov_remote_stop();
 	return;
  drop:
 	kfree_skb(skb);
-- 
2.29.2.454.gaff20da3a2-goog

