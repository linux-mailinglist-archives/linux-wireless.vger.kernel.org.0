Return-Path: <linux-wireless+bounces-15559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857089D504B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B47B29D45
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137E1A01D8;
	Thu, 21 Nov 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpja58ga"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF31A01C6
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204695; cv=none; b=r1RsjTgJefU5j/4Oh+Yd9ChXkRmAQnnpmWGv3RAMVg4po5ZECXwc+xqZec502jCbc2as19nWZUaoHG6gyOdjxKcrzciffsjDLSDMGsr059zQwRFLzfXzEke/9A32p4rbvBIhg88/KBbyGVVYaDXk+E12BLzQV4XjHRi5JF97jQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204695; c=relaxed/simple;
	bh=NpdhGLFa8MrtWbe6x2SbAI+aznIf9wCLJufcsr3ViPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C60TJqffkjjqCnL/h2K9KyBmhWoQawvzuc8AS7awO53w2hT1TeUpxs/L9KdP4omvXRlAofgGPMixkSCfXBQJ0zbok9skcuPB3LOc0FdPTGcMbJJbzIZwRAQ7/kdsvlpaDCE13MYtzKEr8HlBt1aqCYBMnpAS0S9FulTJ11mI5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpja58ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BE6C4CECD;
	Thu, 21 Nov 2024 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732204694;
	bh=NpdhGLFa8MrtWbe6x2SbAI+aznIf9wCLJufcsr3ViPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jpja58gaaepFVGXlZqhsZw6+I2Cn5JsBN/1aP9c1JazsbaNF6sdncpza3jyuDevOl
	 a+j7EZVBj9+ptg7QJiujdCGhBJP/Ga/5kquPigZN0ZO6PdYYWBTqaiWGoDAQWV/5Dk
	 /gE2StMJ3VlrnEsE04IZKMgHHgBru4Y50AsHGyP0T/DYkRkTraod/itxqLxDIWpm8f
	 yVMWW06w97jL+fITnT2o0v3PibXBMxWzfagsWuYIBJAntQpcUFUqrlOPLPAanUmUEH
	 5KYoTkAoHB3YaIzp/wi3CayZqszA+np16PXPxdblUNqEf1ryYopJD2J6nKSmIgL9jp
	 bfvKmeVO5tgWg==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 6/8] wifi: ath12k: modify chanctx iterators for MLO
Date: Thu, 21 Nov 2024 17:58:04 +0200
Message-Id: <20241121155806.1862733-7-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121155806.1862733-1-kvalo@kernel.org>
References: <20241121155806.1862733-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Currently ath12k's chanctx iterator functions use deflink of given ahvif and
bss_conf of corresponding vif to make sure the iterator returns intended vif.
An ML vif can have multiple affiliated links each having its own channel
context, hence iterate through the links of the given ahvif and use the link
objects (arvif and link_conf) to make sure the chan ctx iterator returns
intended link of the given vif.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 80 +++++++++++++++++++--------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 01932aeab4f3..956d43520510 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8309,19 +8309,32 @@ ath12k_mac_change_chanctx_cnt_iter(void *data, u8 *mac,
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_mac_change_chanctx_arg *arg = data;
+	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_link_vif *arvif;
+	unsigned long links_map;
+	u8 link_id;
 
 	lockdep_assert_wiphy(ahvif->ah->hw->wiphy);
 
-	arvif = &ahvif->deflink;
+	links_map = ahvif->links_map;
+	for_each_set_bit(link_id, &links_map, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(ahvif->ah->hw->wiphy, ahvif->link[link_id]);
+		if (WARN_ON(!arvif))
+			continue;
 
-	if (arvif->ar != arg->ar)
-		return;
+		if (arvif->ar != arg->ar)
+			continue;
 
-	if (rcu_access_pointer(vif->bss_conf.chanctx_conf) != arg->ctx)
-		return;
+		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,
+					      vif->link_conf[link_id]);
+		if (WARN_ON(!link_conf))
+			continue;
 
-	arg->n_vifs++;
+		if (rcu_access_pointer(link_conf->chanctx_conf) != arg->ctx)
+			continue;
+
+		arg->n_vifs++;
+	}
 }
 
 static void
@@ -8330,27 +8343,41 @@ ath12k_mac_change_chanctx_fill_iter(void *data, u8 *mac,
 {
 	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
 	struct ath12k_mac_change_chanctx_arg *arg = data;
+	struct ieee80211_bss_conf *link_conf;
 	struct ieee80211_chanctx_conf *ctx;
 	struct ath12k_link_vif *arvif;
+	unsigned long links_map;
+	u8 link_id;
 
 	lockdep_assert_wiphy(ahvif->ah->hw->wiphy);
 
-	arvif = &ahvif->deflink;
+	links_map = ahvif->links_map;
+	for_each_set_bit(link_id, &links_map, IEEE80211_MLD_MAX_NUM_LINKS) {
+		arvif = wiphy_dereference(ahvif->ah->hw->wiphy, ahvif->link[link_id]);
+		if (WARN_ON(!arvif))
+			continue;
 
-	if (arvif->ar != arg->ar)
-		return;
+		if (arvif->ar != arg->ar)
+			continue;
 
-	ctx = rcu_access_pointer(vif->bss_conf.chanctx_conf);
-	if (ctx != arg->ctx)
-		return;
+		link_conf = wiphy_dereference(ahvif->ah->hw->wiphy,
+					      vif->link_conf[arvif->link_id]);
+		if (WARN_ON(!link_conf))
+			continue;
 
-	if (WARN_ON(arg->next_vif == arg->n_vifs))
-		return;
+		ctx = rcu_access_pointer(link_conf->chanctx_conf);
+		if (ctx != arg->ctx)
+			continue;
 
-	arg->vifs[arg->next_vif].vif = vif;
-	arg->vifs[arg->next_vif].old_ctx = ctx;
-	arg->vifs[arg->next_vif].new_ctx = ctx;
-	arg->next_vif++;
+		if (WARN_ON(arg->next_vif == arg->n_vifs))
+			return;
+
+		arg->vifs[arg->next_vif].vif = vif;
+		arg->vifs[arg->next_vif].old_ctx = ctx;
+		arg->vifs[arg->next_vif].new_ctx = ctx;
+		arg->vifs[arg->next_vif].link_conf = link_conf;
+		arg->next_vif++;
+	}
 }
 
 static u32 ath12k_mac_nlwidth_to_wmiwidth(enum nl80211_chan_width width)
@@ -8410,10 +8437,12 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   int n_vifs)
 {
 	struct ath12k_wmi_vdev_up_params params = {};
+	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_link_vif *arvif;
 	struct ieee80211_vif *vif;
 	struct ath12k_vif *ahvif;
+	u8 link_id;
 	int ret;
 	int i;
 	bool monitor_vif = false;
@@ -8423,7 +8452,10 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 	for (i = 0; i < n_vifs; i++) {
 		vif = vifs[i].vif;
 		ahvif = ath12k_vif_to_ahvif(vif);
-		arvif = &ahvif->deflink;
+		link_conf = vifs[i].link_conf;
+		link_id = link_conf->link_id;
+		arvif = wiphy_dereference(ath12k_ar_to_hw(ar)->wiphy,
+					  ahvif->link[link_id]);
 
 		if (vif->type == NL80211_IFTYPE_MONITOR)
 			monitor_vif = true;
@@ -8476,13 +8508,13 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		params.aid = ahvif->aid;
 		params.bssid = arvif->bssid;
 		if (vif->mbssid_tx_vif) {
-			struct ath12k_vif *ahvif =
+			struct ath12k_vif *tx_ahvif =
 				ath12k_vif_to_ahvif(vif->mbssid_tx_vif);
-			struct ath12k_link_vif *arvif = &ahvif->deflink;
+			struct ath12k_link_vif *tx_arvif = &tx_ahvif->deflink;
 
-			params.tx_bssid = arvif->bssid;
-			params.nontx_profile_idx = vif->bss_conf.bssid_index;
-			params.nontx_profile_cnt = 1 << vif->bss_conf.bssid_indicator;
+			params.tx_bssid = tx_arvif->bssid;
+			params.nontx_profile_idx = link_conf->bssid_index;
+			params.nontx_profile_cnt = 1 << link_conf->bssid_indicator;
 		}
 		ret = ath12k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
-- 
2.39.5


