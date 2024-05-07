Return-Path: <linux-wireless+bounces-7300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8481A8BF001
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 00:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A3C1C21BD8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 22:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1F8061C;
	Tue,  7 May 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwV24nBV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182F8005B;
	Tue,  7 May 2024 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122652; cv=none; b=DhLgwx+PpX8kCxkDwbgK6aIxcvWmH/SXgvmihvrASgn5M0wApDrGpcGfy1F2C8Wovj9Qf4sUuAZV9lM5ATW0ipP5MWlwbN/p9Y3iVAk1UKtIOyGBPF9E8jsHHjPt458ERx+zfc0KoYU1yDA71u5fdGPlLmjILGMokJMPQE3wH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122652; c=relaxed/simple;
	bh=8bDog2FA7TR5Y7WUOIjON4ql2FcHX0KHwgbRQpXs17o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMneF02vdwJphK168FXe+W/fNwVCcvIBzyhQLdF+IGBL8DmcDAOMghVKXC9/01IQoXBEpMso1o5gTudPIv8xrTA4gHjP9ozW//8J965CNeXHGFs7DMw363JNXVgPpPMvxVqgq8mNs6ZXXnZdG290PWhEP6esA36/pb+xr7eHvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwV24nBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11FDC4AF17;
	Tue,  7 May 2024 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122652;
	bh=8bDog2FA7TR5Y7WUOIjON4ql2FcHX0KHwgbRQpXs17o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DwV24nBV1DngUB/bsJ60L7ecX80OhBxEdD9WSmZdENhlbf9WE7OhoiYsHHLGJ8MWC
	 XUJIP40GBXdXRIljsSWi4OBjvCtJ0iTU1A5f3G+tZFOACpcCsaQxrhclR9nbaYKunl
	 AALZQT08wsD5d5hZKQaGpKbOTU2CUuDrwAyr5I/r8lMPOx0DAnDL/VDMT2bw8dWlDb
	 QXBZPtEV3E6lHXFVf6F2CPK4aupuBA4ATAPcEAiUGzE58t+KPGVll7VH2OJRYywvDG
	 k/whYX/dX4TW/Wy1IgH3N14+cuVMURCFOOax2/TOIimc2pYn75nfE76VOsWx+ja1Ej
	 Fyp17bJGARIBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 03/23] wifi: mac80211: don't use rate mask for scanning
Date: Tue,  7 May 2024 18:56:29 -0400
Message-ID: <20240507225725.390306-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit ab9177d83c040eba58387914077ebca56f14fae6 ]

The rate mask is intended for use during operation, and
can be set to only have masks for the currently active
band. As such, it cannot be used for scanning which can
be on other bands as well.

Simply ignore the rate masks during scanning to avoid
warnings from incorrect settings.

Reported-by: syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
Co-developed-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://msgid.link/20240326220854.9594cbb418ca.I7f86c0ba1f98cf7e27c2bacf6c2d417200ecea5c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mac80211.h |  3 +++
 net/mac80211/rate.c    |  6 +++++-
 net/mac80211/scan.c    |  1 +
 net/mac80211/tx.c      | 13 +++++++++----
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d400fe2e8668d..df9b578e58bb2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -932,6 +932,8 @@ enum mac80211_tx_info_flags {
  *	of their QoS TID or other priority field values.
  * @IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX: first MLO TX, used mostly internally
  *	for sequence number assignment
+ * @IEEE80211_TX_CTRL_SCAN_TX: Indicates that this frame is transmitted
+ *	due to scanning, not in normal operation on the interface.
  * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
  *	frame should be transmitted on the specific link. This really is
  *	only relevant for frames that do not have data present, and is
@@ -952,6 +954,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 	IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX	= BIT(9),
+	IEEE80211_TX_CTRL_SCAN_TX		= BIT(10),
 	IEEE80211_TX_CTRL_MLO_LINK		= 0xf0000000,
 };
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 0efdaa8f2a92e..3cf252418bd38 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -877,6 +877,7 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_supported_band *sband;
+	u32 mask = ~0;
 
 	rate_control_fill_sta_table(sta, info, dest, max_rates);
 
@@ -889,9 +890,12 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	if (ieee80211_is_tx_data(skb))
 		rate_control_apply_mask(sdata, sta, sband, dest, max_rates);
 
+	if (!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX))
+		mask = sdata->rc_rateidx_mask[info->band];
+
 	if (dest[0].idx < 0)
 		__rate_control_send_low(&sdata->local->hw, sband, sta, info,
-					sdata->rc_rateidx_mask[info->band]);
+					mask);
 
 	if (sta)
 		rate_fixup_ratelist(vif, sband, info, dest, max_rates);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index f9d5842601fa9..dd0ec34a3f8a8 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -638,6 +638,7 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
+		IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_SCAN_TX;
 		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6fbb15b65902c..a8a4912bf2cb4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -701,11 +701,16 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	txrc.bss_conf = &tx->sdata->vif.bss_conf;
 	txrc.skb = tx->skb;
 	txrc.reported_rate.idx = -1;
-	txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
 
-	if (tx->sdata->rc_has_mcs_mask[info->band])
-		txrc.rate_idx_mcs_mask =
-			tx->sdata->rc_rateidx_mcs_mask[info->band];
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX)) {
+		txrc.rate_idx_mask = ~0;
+	} else {
+		txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
+
+		if (tx->sdata->rc_has_mcs_mask[info->band])
+			txrc.rate_idx_mcs_mask =
+				tx->sdata->rc_rateidx_mcs_mask[info->band];
+	}
 
 	txrc.bss = (tx->sdata->vif.type == NL80211_IFTYPE_AP ||
 		    tx->sdata->vif.type == NL80211_IFTYPE_MESH_POINT ||
-- 
2.43.0


