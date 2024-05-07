Return-Path: <linux-wireless+bounces-7303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC028BF064
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089122825D8
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6828175B;
	Tue,  7 May 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrqi1D3V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30057EF1F;
	Tue,  7 May 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122753; cv=none; b=U7sl7JS6TR1QE1UGSg9DzNwfDF8/7AppxOmgLMlSSHSyGYfktYMKE5sjBYPyIUlm+YPR6hqPXfd2M/+M+J/EmUpUJaqe9wnX3MbUtXo+/dgeqHUQm7K0dFyyrcPhJRLr6AT8iexGQ6FhBzEAByy3oPTtIzcn/JjF11qBLDCvNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122753; c=relaxed/simple;
	bh=/gwbIbp8a6r+iZdpA5zQG/OUP6iPP5MDBaszErJJRTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLcMq/okezmOzVHcedp67ze0SSMnivzbXVaKmmGeyGtZ2kwG/SeVTRFJyzD0vSgEa3I2teNdxc1oMN8EA74WCnc7Fj7ZFMloNUp5ssYqGW4DHcoik12qHTmw4rJpH5gPfS0Aefr5NRAK5fO5iWTDCJTqJ4qE5gt3C97Bibzord8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrqi1D3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FFDC2BBFC;
	Tue,  7 May 2024 22:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122752;
	bh=/gwbIbp8a6r+iZdpA5zQG/OUP6iPP5MDBaszErJJRTc=;
	h=From:To:Cc:Subject:Date:From;
	b=qrqi1D3VeFaMkwIAuHvC8P38YmjVDrtjFy66quQHTMIFEWZ1FuFs/t+cUyJl9zAV9
	 WspF+Ou+C5rvbO57l0JwQEfe4AmxfE1F3CCfl9WAiOrGq8v+tdwVMOR+RFINBWa86u
	 tk6qVFGtEJyipC8DmGfeSuZn3k1yyQ+k3QCxaRqdU+KIjACvaBlAbee+N7wAKxIifu
	 nAwZHAxYdAPMNlwh0o2QBASNfMSYkjJiRCpJ21EO20n2SBOCBzjL66ta8tSRGEyyYg
	 7+sJZQGpUoCkjsTAA3wsB4eSkge/PMiW4WBkPFrlIM8KhMWb/1gBVAyMQWzhB5ImCl
	 dU3gTpc/u9uHQ==
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
Subject: [PATCH AUTOSEL 6.6 01/19] wifi: mac80211: don't use rate mask for scanning
Date: Tue,  7 May 2024 18:58:23 -0400
Message-ID: <20240507225910.390914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index 7c707358d15c8..a39bd4169f292 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -936,6 +936,8 @@ enum mac80211_tx_info_flags {
  *	of their QoS TID or other priority field values.
  * @IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX: first MLO TX, used mostly internally
  *	for sequence number assignment
+ * @IEEE80211_TX_CTRL_SCAN_TX: Indicates that this frame is transmitted
+ *	due to scanning, not in normal operation on the interface.
  * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
  *	frame should be transmitted on the specific link. This really is
  *	only relevant for frames that do not have data present, and is
@@ -956,6 +958,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 	IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX	= BIT(9),
+	IEEE80211_TX_CTRL_SCAN_TX		= BIT(10),
 	IEEE80211_TX_CTRL_MLO_LINK		= 0xf0000000,
 };
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 9d33fd2377c88..a2bc9c5d92b8b 100644
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
index a52813f2b08cb..b68214f159838 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -636,6 +636,7 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
+		IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_SCAN_TX;
 		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 5c6c5254d987f..46b02a6ae0a36 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -705,11 +705,16 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
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


