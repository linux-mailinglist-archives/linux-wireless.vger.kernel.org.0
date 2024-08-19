Return-Path: <linux-wireless+bounces-11599-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A0995640B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 08:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EC31F21116
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 06:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F68155C80;
	Mon, 19 Aug 2024 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gNnG7N4K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D117C77
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050774; cv=none; b=Lr57JyWbBhY4A9yljMbC1w9eGAYhSYUrTjoEyXIQJl+vAJCJHrb5C60OZyxBMpSMMHTO3NMzW3utpKaNXC+vtIw44FiwlMNcZO23wh6xKXitkRcLlMkScYyN3BwljcXBTid62pvMpwJUjUJWilEIgIly84J5ZSfuYgOzxNNQrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050774; c=relaxed/simple;
	bh=fcNLOzXnz+/CeMT6nDvqaVnsxe/HBfJNl+qvHWSHGto=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I8xLlYS5kzUZc0a3FSAfr86s/QB+fBPCHH4cWrqDGxcFjF3NsVYbSzigOca3M5JeclsYgXtuSdyHYRaWWXVtXHZdRHfYK4U8nlBSWgdSU/Dzk2RHvpSEQKDkFhnhWGz12vT/uwugyrjQ2ygxTF+h9t/eOJNjHFIwNnqjDpKXCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gNnG7N4K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J6x9LX14007538, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724050750; bh=fcNLOzXnz+/CeMT6nDvqaVnsxe/HBfJNl+qvHWSHGto=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=gNnG7N4KTEexMta8oCQBxZebd8HINOPifA/Z3RiAavLlxYZMdQPtBb3g/gCgxYZji
	 DBKYpTkmMvNVbUBaDZ/cVlEq+0TkdduoIroZI1IPKZGZYhGDkhaQ/D8bdjQ6AWner5
	 JpEqphk2ZTB+svo68oMUAMjFRVrvcIkuX17aYaK9TiT7cU1MTzXjo9Zo8hj6fMK3Dx
	 CIbktAZBbhDfn6dp59uHliozJA0nyWN9m97KH4m28LN1Nzr5zk60XHOMjXn8HEfxwN
	 hzZcgi8xjViA0PyT4MxXgFmOs/qKMWws3KZ4nRM4T7OhCW20FLNH8rB2TS13/1v3Fk
	 QMcles7c/bvwQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J6x9LX14007538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:59:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 14:59:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 14:59:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC: <pbrobinson@gmail.com>
Subject: [PATCH 1/2] wifi: mac80211: export ieee80211_purge_tx_queue() for drivers
Date: Mon, 19 Aug 2024 14:58:54 +0800
Message-ID: <20240819065855.25678-1-pkshih@realtek.com>
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

Drivers need to purge TX SKB when stopping. Use skb_queue_purge() can't
report TX status to mac80211, causing ieee80211_free_ack_frame() warns
"Have pending ack frames!".

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Hi Johannes,

If this patch is accepted, please merge it ahead and I will merge the
second patch via rtw tree after pulling wireless-next tree. I think this
can reduce possible conflicts.

---
 include/net/mac80211.h | 11 +++++++++++
 net/mac80211/status.c  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0a04eaf5343c..f11844f0c80f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3180,6 +3180,17 @@ ieee80211_get_alt_retry_rate(const struct ieee80211_hw *hw,
  */
 void ieee80211_free_txskb(struct ieee80211_hw *hw, struct sk_buff *skb);
 
+/**
+ * ieee80211_purge_tx_queue - purge TX skb queue
+ * @hw: the hardware
+ * @skbs: the skbs
+ *
+ * Free a set of transmit skbs. Use this function when device is going to stop
+ * but some transmit skbs without TX status are still queued.
+ */
+void ieee80211_purge_tx_queue(struct ieee80211_hw *hw,
+			      struct sk_buff_head *skbs);
+
 /**
  * DOC: Hardware crypto acceleration
  *
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


