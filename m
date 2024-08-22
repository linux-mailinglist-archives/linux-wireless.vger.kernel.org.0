Return-Path: <linux-wireless+bounces-11770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC35095AAA1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 03:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DA71F2221A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 01:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07FEBA45;
	Thu, 22 Aug 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="D1uyNYV7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5D8BF3
	for <linux-wireless@vger.kernel.org>; Thu, 22 Aug 2024 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290998; cv=none; b=kcKwCS8D5hhvlKc0axRU5q2TWtI4n0t5yYGoySAX2KcQPSkEFI2HbUt9p9sDkYw3+zL9TekRJubFg8WKkr+iKlOTsLKL/UT8/2iYATFcVJ3scVIeJBkOMlYd7IN6XU9W46uCY0PRMDAtuCaQO+tZjaGJ1L2XYIPeNehf10+DdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290998; c=relaxed/simple;
	bh=w9YKJXrFRaWWljw14zsYcgT20mHtPKVnHfZ5XzW3Y0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SWe9ew7++r72s832aSp427lAYYlynIJSbVlZm+rfml4X6G1mNuyIRX5ZxhxPBvVOOUhYMO3DCsfvVZ+vUJ/nwXTnK4ZwXWW8JZwIxRKHDtAh9DZ3sQDoLQFsjSk5ejI8mjwhOh/EccGkDOQ1/H/SXRkyPbwk1QE14h4kS2RM/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=D1uyNYV7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47M1h2oT53389715, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724290982; bh=w9YKJXrFRaWWljw14zsYcgT20mHtPKVnHfZ5XzW3Y0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=D1uyNYV77NhOIKE0qf/fUf0XZmG7jUHEpqtl73vd+GICpoKr2vV/x2jRB1E2QoyfC
	 6IIYFv45Qsxr8w9odMZdv8uST7/gH2NQTFoEM3jTmW0GNXjJYGVNU1fUh9DKCpSSRp
	 1syRCYVMuJ5GooantpzZq857hyI/G0XleHADKiUC1jtJ5aUxgXh9ZIhpOwbZrHGhMw
	 /z5EA4MbG7r3PGNMC4RVVQSdnN2WOVWWaW8vN6NqpgsAaYH2hCHX+3CnY1OexQ8cQv
	 a4MBfkmTjN6HaLcBq/m5cDcNPNsBk5RInulOgEHPydqk9oOBpq7kMjeFqdApDnMmNN
	 mH0kciq8DGT+A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47M1h2oT53389715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 09:43:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:43:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 22 Aug
 2024 09:43:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC: <pbrobinson@gmail.com>
Subject: [PATCH v2 1/2] wifi: mac80211: export ieee80211_purge_tx_queue() for drivers
Date: Thu, 22 Aug 2024 09:42:54 +0800
Message-ID: <20240822014255.10211-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Drivers need to purge TX SKB when stopping. Using skb_queue_purge() can't
report TX status to mac80211, causing ieee80211_free_ack_frame() warns
"Have pending ack frames!". Export ieee80211_purge_tx_queue() for drivers
to not have to reimplement it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - correct wording in commit message, and mention reason why we export
    the symbol
  - add comment to note ieee80211_purge_tx_queue() doesn't take locks
  - remove prototype from net/mac80211/ieee80211_i.h 
---
 include/net/mac80211.h     | 13 +++++++++++++
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/status.c      |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0a04eaf5343c..651fa926c94a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3180,6 +3180,19 @@ ieee80211_get_alt_retry_rate(const struct ieee80211_hw *hw,
  */
 void ieee80211_free_txskb(struct ieee80211_hw *hw, struct sk_buff *skb);
 
+/**
+ * ieee80211_purge_tx_queue - purge TX skb queue
+ * @hw: the hardware
+ * @skbs: the skbs
+ *
+ * Free a set of transmit skbs. Use this function when device is going to stop
+ * but some transmit skbs without TX status are still queued.
+ * This function does not take the list lock and the caller must hold the
+ * relevant locks to use it.
+ */
+void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
+			      struct sk_buff_head *skbs);
+
 /**
  * DOC: Hardware crypto acceleration
  *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a3485e4c6132..da705bf50d93 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2072,8 +2072,6 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  u32 info_flags,
 				  u32 ctrl_flags,
 				  u64 *cookie);
-void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
-			      struct sk_buff_head *skbs);
 struct sk_buff *
 ieee80211_build_data_template(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, u32 info_flags);
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index dd8f857a1fbc..d1cf987de13b 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1301,3 +1301,4 @@ void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
 	while ((skb = __skb_dequeue(skbs)))
 		ieee80211_free_txskb(hw, skb);
 }
+EXPORT_SYMBOL(ieee80211_purge_tx_queue);
-- 
2.25.1


