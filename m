Return-Path: <linux-wireless+bounces-10603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF393EEEF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 09:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB89280E12
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDB126F2A;
	Mon, 29 Jul 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cpVG+w1C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCD12BF25
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239324; cv=none; b=U0SrIABbcgmdyafgeGhT5lJSJ4lSxAnfxS+1aU+lO6wG2P4tzWj2CisSHx/+XsMhpJpfibTTg0RLtPczHCUgcWM9mJFI+munUdLRiunJt5gFeJj51KvdHxAuOjMbIs81vxUhiriFCtSJSRDj0XdUtd6HtZ2gq9X/sqSEHtNQZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239324; c=relaxed/simple;
	bh=nMEoiC+5kl4Tal9N/7gG+vmNS/jnhK4N3vlnx3v6jJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTWK1UEGcyuLuTPDpXUR1/iauP2RMltkoKzpU+qUWxtDLGAt1x2a4EG9eQZKNSsdy8KLQtox35S0z5Y0zwGg+tXhLrvRQ0ojFUtXRnDtqMnCKQjcdDHphEqPlmGI2BXXjpV9N5PGee+lb4ajfbZP8zGyq63XgAFuuxVkqjb0vqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cpVG+w1C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46T7mQJO13673723, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722239306; bh=nMEoiC+5kl4Tal9N/7gG+vmNS/jnhK4N3vlnx3v6jJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=cpVG+w1CdoyOl1kB23bH+61UkqL9HYCHj4h4e4vaLe/EGM3XxQrjj4dc8zydESzHi
	 IQn+L92Kjk5Wcko6Av9xPcXevJvgJoI0zQQZzg5qrPxvMQ3/7RFYJ66p780BTYCqjd
	 KhX8Mw84gRxchhsBWa68HSDoSSDf2W5CIeniosOV5On+0XhZFf4eHe3IK6iItSyn4c
	 bOwYd4xsDDW53vJkrXhI43jRo9YyLvfoo267sMZyNTo2EyzIkC83/JAaEYZKluZ87e
	 YCXDo7aX9TErQeiM9j277HPM/l0znWu4WVhqVr/Iz5YFBFHiTZbuuHNMv1xhMS5SKB
	 gps1CS8pGOUNQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46T7mQJO13673723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 15:48:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 15:48:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Jul
 2024 15:48:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: mac80211: don't use rate mask for offchannel TX neither
Date: Mon, 29 Jul 2024 15:48:16 +0800
Message-ID: <20240729074816.20323-1-pkshih@realtek.com>
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

Like the commit ab9177d83c04 ("wifi: mac80211: don't use rate mask for
scanning"), ignore incorrect settings to avoid no supported rate warning
reported by syzbot.

The syzbot did bisect and found cause is commit 9df66d5b9f45 ("cfg80211:
fix default HE tx bitrate mask in 2G band"), which however corrects
bitmask of HE MCS and recognizes correctly settings of empty legacy rate
plus HE MCS rate instead of returning -EINVAL.

As suggestions [1], follow the change of SCAN TX to consider this case of
offchannel TX as well.

[1] https://lore.kernel.org/linux-wireless/6ab2dc9c3afe753ca6fdcdd1421e7a1f47e87b84.camel@sipsolutions.net/T/#m2ac2a6d2be06a37c9c47a3d8a44b4f647ed4f024

Reported-by: syzbot+8dd98a9e98ee28dc484a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-wireless/000000000000fdef8706191a3f7b@google.com/
Fixes: 9df66d5b9f45 ("cfg80211: fix default HE tx bitrate mask in 2G band")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - change along with suggestions like SCAN_TX flag
---
 include/net/mac80211.h    | 7 ++++---
 net/mac80211/offchannel.c | 1 +
 net/mac80211/rate.c       | 2 +-
 net/mac80211/scan.c       | 2 +-
 net/mac80211/tx.c         | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 45ad37adbe32..7b3f56d862de 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -953,8 +953,9 @@ enum mac80211_tx_info_flags {
  *	of their QoS TID or other priority field values.
  * @IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX: first MLO TX, used mostly internally
  *	for sequence number assignment
- * @IEEE80211_TX_CTRL_SCAN_TX: Indicates that this frame is transmitted
- *	due to scanning, not in normal operation on the interface.
+ * @IEEE80211_TX_CTRL_DONT_USE_RATE_MASK: Don't use rate mask for this frame
+ *	which is transmitted due to scanning or offchannel TX, not in normal
+ *	operation on the interface.
  * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
  *	frame should be transmitted on the specific link. This really is
  *	only relevant for frames that do not have data present, and is
@@ -975,7 +976,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 	IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX	= BIT(9),
-	IEEE80211_TX_CTRL_SCAN_TX		= BIT(10),
+	IEEE80211_TX_CTRL_DONT_USE_RATE_MASK	= BIT(10),
 	IEEE80211_TX_CTRL_MLO_LINK		= 0xf0000000,
 };
 
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 65e1e9e971fd..5810d938edc4 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -964,6 +964,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	}
 
 	IEEE80211_SKB_CB(skb)->flags = flags;
+	IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
 
 	skb->dev = sdata->dev;
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 4dc1def69548..3dc9752188d5 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -890,7 +890,7 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	if (ieee80211_is_tx_data(skb))
 		rate_control_apply_mask(sdata, sta, sband, dest, max_rates);
 
-	if (!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX))
+	if (!(info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK))
 		mask = sdata->rc_rateidx_mask[info->band];
 
 	if (dest[0].idx < 0)
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index b5f2df61c7f6..1c5d99975ad0 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -649,7 +649,7 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
-		IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_SCAN_TX;
+		IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
 		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f861d99e5f05..f14a2a388e60 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -699,7 +699,7 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	txrc.skb = tx->skb;
 	txrc.reported_rate.idx = -1;
 
-	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX)) {
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_DONT_USE_RATE_MASK)) {
 		txrc.rate_idx_mask = ~0;
 	} else {
 		txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
-- 
2.25.1


