Return-Path: <linux-wireless+bounces-30473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39743CFF6C1
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 19:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C0AC3079D15
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947C33CEB2;
	Wed,  7 Jan 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="V9HhS1Xc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD433A712
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795826; cv=none; b=Bd/7dz8Ir1YPMWfmIGRmgAmk07p/na0OEWvlwxwKyBiN03Q0lM07yslPkjESS4A2TXo9W74N9/fFlYsSZY5YwiJDwrflGZHMU++sayxzaMn6OlpyUkcm7mXmZv6dYIXx8znFDzLezGamRwVDqeQiQyGV7/Q9/ab44usvNwVafeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795826; c=relaxed/simple;
	bh=idi/gW/EtS0BRdj/zVlD87HkGmzv7053qYF3wVfGEXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJe+vIT9eiX4ElCtqXC6CMRfQszAbk3gZef5x0cJBmba5REUCR9dMTRl89guD5qfE0fPrWfHDsluNlR5qRHCi+ZbqHoFtlvfLfCvKMatzROTOZ/IF0YOd6WWxXgGYixMVXkz2WXLe3Aw2daG9LsFTKa3qVbTWmzlnQKMzxEvcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=V9HhS1Xc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0uXYvSfsg+bdurXCnB0UPmm7G3hNTETgEPssVKS/YnQ=;
	t=1767795824; x=1769005424; b=V9HhS1Xc7JANlkPGKEtgSNicyM72c4917AKjlNqvzw5kUES
	dT69P/1pzm442xqzmWAvI1S9M6RaEgv2eDohiDpenPlUGGmhcZG04TQ0FE0zH6cJuP7qJtz7HM223
	5GweDzcP26c9cz23qKK10EhgBw07yqogKKea9iUSIjJFhCpWIOoH4k/487G4/4Hh61LgUdC2rKZZj
	FbcFAWvv7jR3VR7oQe6OVvkRH4lkjKOesswNsKoFgpSw53owKm4usZUDIUu3uZOip0L316ah8ZDCn
	g9H+3sStHPRSt2tyrOwkAs+6SCCnMJSG54t4G5BvxfAWPjZwi4c3XD326hd0s6WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURq-00000005agF-25UI;
	Wed, 07 Jan 2026 15:23:42 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC wireless-next 11/46] wifi: mac80211_hwsim: switch to use TXQs
Date: Wed,  7 Jan 2026 15:22:10 +0100
Message-ID: <20260107152324.5e0844d860a7.Id3e629770663c44de00faa3ff9bac9c6b87459c6@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
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
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index e3b02d24a7d5..5a5caa614cb8 100644
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
2.52.0


