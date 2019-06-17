Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92884490B9
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 22:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfFQUCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 16:02:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34669 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfFQUCY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 16:02:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id y198so7501455lfa.1;
        Mon, 17 Jun 2019 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4P8y1ay39d+E4yB3whFfRjMbB7BKe2MvBm/2WeUpIM=;
        b=of2v7ANgL9ex0bkfxQas0p6u4QAhgHfu5y1Y/3T039pKxnMxEKpETvUBNF+8c1SwzE
         6jM+sSE/03uQiaK5khEyZjMn2Ut7hPZRVxfcfuB5s8/czVUudhGS8uBNby58nmRYHg69
         jn8kPcsad2kZqqBr1UrtE+dhV6vvELpupT3ZxTaA8dppC/XbeeaIzyWX9rxSinYJr/AP
         VuwG/cZSBh4kCIVhDAUFubuU7NFQ5//HE1i5I30jy3VIVYvNes3Ea6emUDfNfZbnW9gS
         coS2IUV+LeoGPjZ/uwVAQAvVVDy6x/tYs5jZx5qfrHDh+buF7MNVzMCuWil7YJPZqgus
         iXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4P8y1ay39d+E4yB3whFfRjMbB7BKe2MvBm/2WeUpIM=;
        b=RsV6ksv+6p+LaMAaWrhNTiYTpF7Ga08Q3+AFHyiVtB1KVaeNZ8Y2wOwS69ZHnTlZx9
         oztz0G3g+UJvmOGaB7gi75UbiJKW9ls4q3XtX/QFGoEgAR0EUlHEL51kbUjMZ22GNmXT
         BD0s9orMUx3522lkbdE0KdI8jRhl/6QdGLD/I7JWDyFfOYrpupXx0z5ujWVgl8WKEWg0
         eb3AmLuEb2D9il1+FIVkHEwE9YDFFB3I8z7smexQ8gHpCqi7ItcKy9/EQchh1bk0Fi3a
         mfCQnUnafZinhhHskgc+wtUTvUGgH4fwMEowVSsm6k2XnrDwgkjS+dUglbe81dNOqLdC
         LXhA==
X-Gm-Message-State: APjAAAWnpYFXRnb/4iTO0Gq4t7BMnjxn6oUizsdzWi9Uew97utt37qoW
        cqhjQOm3cuu+NcAX1zy/+oA=
X-Google-Smtp-Source: APXvYqzALujpPOG2xk/DqMQhHr3m6lA+WF68otalfSbL7+uhlJM7kYppPXRpUxk4fkH0Eui/GOj7vg==
X-Received: by 2002:a19:5007:: with SMTP id e7mr60072377lfb.76.1560801742672;
        Mon, 17 Jun 2019 13:02:22 -0700 (PDT)
Received: from localhost.localdomain (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id j90sm2245780ljb.29.2019.06.17.13.02.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 13:02:22 -0700 (PDT)
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org,
        davem@davemloft.net, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: [PATCH 1/2] mac80211: add tx dequeue function for process context
Date:   Mon, 17 Jun 2019 22:01:39 +0200
Message-Id: <20190617200140.6189-1-erik.stromdahl@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since ieee80211_tx_dequeue() must not be called with softirqs enabled
(i.e. from process context without proper disable of bottom halves),
we add a wrapper that disables bottom halves before calling
ieee80211_tx_dequeue()

The new function is named ieee80211_tx_dequeue_ni() just as all other
from-process-context versions found in mac80211.

The documentation of ieee80211_tx_dequeue() is also updated so it
mentions that the function should not be called from process context.

Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
---
 include/net/mac80211.h | 26 ++++++++++++++++++++++++++
 net/mac80211/tx.c      |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 72080d9d617e..c47990d8db79 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6251,10 +6251,36 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *sta, u8 tid);
  * but for the duration of the frame handling.
  * However, also note that while in the wake_tx_queue() method,
  * rcu_read_lock() is already held.
+ *
+ * softirqs must also be disabled when this function is called.
+ * In process context, use ieee80211_tx_dequeue_ni() instead.
  */
 struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 				     struct ieee80211_txq *txq);
 
+/**
+ * ieee80211_tx_dequeue_ni - dequeue a packet from a software tx queue
+ * (in process context)
+ *
+ * Like ieee80211_tx_dequeue() but can be called in process context
+ * (internally disables bottom halves).
+ *
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @txq: pointer obtained from station or virtual interface, or from
+ *	ieee80211_next_txq()
+ */
+static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw *hw,
+						      struct ieee80211_txq *txq)
+{
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	skb = ieee80211_tx_dequeue(hw, txq);
+	local_bh_enable();
+
+	return skb;
+}
+
 /**
  * ieee80211_next_txq - get next tx queue to pull packets from
  *
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index dd220b977025..4bd0066ea7cd 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3550,6 +3550,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	ieee80211_tx_result r;
 	struct ieee80211_vif *vif = txq->vif;
 
+	WARN_ON_ONCE(softirq_count() == 0);
+
 begin:
 	spin_lock_bh(&fq->lock);
 
-- 
2.22.0

