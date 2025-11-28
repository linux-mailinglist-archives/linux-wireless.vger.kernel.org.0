Return-Path: <linux-wireless+bounces-29410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA155C924CB
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 15:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 957A234E351
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA7A2749F2;
	Fri, 28 Nov 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C32dAl8m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A96330D50
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339676; cv=none; b=lqZlG7xbaxpzV69pBFJdEWJRe2XvxlgdXu5k0ucrHIZFjKs1EDc3aJjWLylTGWxsO+DXLWlHDR0+vTFrOBc+Yzwzha3ozu47sRT02++q6dQCxn3FizCVWLkzFg4+JG5Pxf6E6oCXrj9jyArhO2BZXcc7fByd1pmeEjaXlPulDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339676; c=relaxed/simple;
	bh=jRZH+FZFWeHO/DR4boDbpX+BrO4QFUMYZfdeTr/jzTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xux0HyYnl9vtgiGqygpVckKyHTRuMi25NF5zhD7Dq+OgNjLgioPmEn7Bwql70Mihl6fzwzqpmCcpc2sErLyf6gAEmWUja4sTuvat6WEZOPhPCi0GMTZXlKoGz0fj57gux5lzzaB3Kvf5pemldGQ4aP6uPUnDLogMEqhykacJ0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C32dAl8m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BKxvmCe037f2qMjJ6jCr9xOaz/OrhOLD2afrA/EjYyg=;
	t=1764339674; x=1765549274; b=C32dAl8mrVpE/bwZmVH+ibg/RQrSDupSuRREE3IBpXPakTY
	ff40rYNaGIiD2RrNYj/TtvLN0LoSSYxCcWiXFkC64DvLgMe9sWoWyyPjrYk2uotaHfB6JxfoDdibm
	eBmP49xoHaiCmr1rGVBqA6LFlMBvcfxEvTjR9dtij0EX7vxeM7W5478CWgNNRS0mtWtSa+WOQ7p7g
	k6OjNNGK2oTocDGdEQRE8gt9FLak7V7EcnijXa5fTQgVklePAIlOi93bfrpHuFSpTN23oasPEk4Jx
	NjgVRgJBtS3p2YYx/GmdvjHZgV9V3vv47209v+vAS8zNnUt7Wz6jdTHuk8Be8DgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vOzLT-00000003926-0ihe;
	Fri, 28 Nov 2025 15:21:11 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 10/18] wifi: mac80211_hwsim: switch to use TXQs
Date: Fri, 28 Nov 2025 15:15:48 +0100
Message-ID: <20251128151537.26cddfb23c81.Id3e629770663c44de00faa3ff9bac9c6b87459c6@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128141537.287627-20-benjamin@sipsolutions.net>
References: <20251128141537.287627-20-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Simply immediately TX all available packets on the corresponding queue.

This removes the HWSIM_TM_CMD_STOP_QUEUES/HWSIM_TM_CMD_RESUME_QUEUES
feature for now. It should be reasonably simple to add it back if it is
needed.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index d6b4a80452b5..8bfd6f984f1c 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -2062,6 +2062,17 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	ieee80211_tx_status_irqsafe(hw, skb);
 }
 
+static void ieee80211_hwsim_wake_tx_queue(struct ieee80211_hw *hw,
+					  struct ieee80211_txq *txq)
+{
+	struct ieee80211_tx_control control = {
+		.sta = txq->sta,
+	};
+	struct sk_buff *skb;
+
+	while ((skb = ieee80211_tx_dequeue(hw, txq)))
+		mac80211_hwsim_tx(hw, &control, skb);
+}
 
 static int mac80211_hwsim_start(struct ieee80211_hw *hw)
 {
@@ -2805,11 +2816,7 @@ static int mac80211_hwsim_testmode_cmd(struct ieee80211_hw *hw,
 			goto nla_put_failure;
 		return cfg80211_testmode_reply(skb);
 	case HWSIM_TM_CMD_STOP_QUEUES:
-		ieee80211_stop_queues(hw);
-		return 0;
 	case HWSIM_TM_CMD_WAKE_QUEUES:
-		ieee80211_wake_queues(hw);
-		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3896,7 +3903,7 @@ static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
 
 #define HWSIM_COMMON_OPS					\
 	.tx = mac80211_hwsim_tx,				\
-	.wake_tx_queue = ieee80211_handle_wake_tx_queue,	\
+	.wake_tx_queue = ieee80211_hwsim_wake_tx_queue,		\
 	.start = mac80211_hwsim_start,				\
 	.stop = mac80211_hwsim_stop,				\
 	.add_interface = mac80211_hwsim_add_interface,		\
@@ -5331,6 +5338,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, STRICT);
+	ieee80211_hw_set(hw, BUFF_MMPDU_TXQ);
+	ieee80211_hw_set(hw, STA_MMPDU_TXQ);
 
 	if (param->mlo) {
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
@@ -5380,6 +5389,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	hw->vif_data_size = sizeof(struct hwsim_vif_priv);
 	hw->sta_data_size = sizeof(struct hwsim_sta_priv);
 	hw->chanctx_data_size = sizeof(struct hwsim_chanctx_priv);
+	hw->txq_data_size = 0;
 
 	memcpy(data->channels_2ghz, hwsim_channels_2ghz,
 		sizeof(hwsim_channels_2ghz));
-- 
2.51.1


