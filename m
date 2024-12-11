Return-Path: <linux-wireless+bounces-16262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F869ED02A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95CA280C49
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB91DE3A8;
	Wed, 11 Dec 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ80JkXI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA71DE2D2
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931848; cv=none; b=BP/k0ossmXwsnpt7LJRCcgzhpcPoRhNjWHZ4P2Il1USceV05+kXKtEto69OgT8iZLZi1AEXq8JW/Mj8wqy4EjU83mYnDbbzmHo8Q6NdEbdML6TIk4jEbpWVtB/5EyNxCvLFsBLh0u2p8efRyZUbEFLWBxCwRxPnnn7zShNdHnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931848; c=relaxed/simple;
	bh=DqTLVZV8zhZm7A0j4ZOugixaSJ2bB+fdZrrezCoitM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfZMhbNBoHuoZP9ZXo6jXutThCOnoxVaQxBO9DvdjwjdIWBYM99Sr8O8SGeaRMOiTehUH7pypekOutZvBIrrPsAhwR+VnUv/GLOdGS7Da8L1+1T4oA3dFma4LFz02ctiVFMY7ExPW78pbcThI17CK8LBWpfss+213KJhF8g33S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ80JkXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD36C4CED2;
	Wed, 11 Dec 2024 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931848;
	bh=DqTLVZV8zhZm7A0j4ZOugixaSJ2bB+fdZrrezCoitM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZ80JkXIANerCjMjx2RphwRXmPF3UmXgh4OF0iXi1G81SZ8RqOhD+TJtlKcXqQ1J9
	 3Z+mfDJXfEx+hPZHI2JBsM9729ox5LkSrqzo+4RnvPcQOIMBeV6GHChTPOscnUjepI
	 ZSZ2qn5zOWeLEuhxqnD6WHDgRzxUo1qHuC01fHrE0qxz9wjs835NN68mRBQxzaJjYz
	 PJjwXieUgXX8iu0IAmbar57/xlJVa++E68TWTFrIahs6Kdqwe8yvtQH9B6d4zJNsRW
	 gdNeI64ixHbuSyuXXF5aJNaj6vaA3H5AMfO1rVu9x46qZG4YrJO9VL9+bxtHyTA0Yc
	 nfxxPiDdmJ2Cw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 7/7] wifi: ath12k: advertise MLO support and capabilities
Date: Wed, 11 Dec 2024 17:43:58 +0200
Message-Id: <20241211154358.776279-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211154358.776279-1-kvalo@kernel.org>
References: <20241211154358.776279-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

Now everything in ath12k is in place and we can enable Multi-Link Operation
(MLO) in the driver. For now it's only enabled for QCN9274 with firmware having
ATH12K_FW_FEATURE_MLO feature bit set.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c  | 13 ++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.c  |  3 +++
 drivers/net/wireless/ath/ath12k/wmi.h  |  2 ++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index d07b54f441c3..ec61ad3d82c3 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -773,6 +773,8 @@ struct ath12k_pdev_cap {
 	u32 tx_chain_mask_shift;
 	u32 rx_chain_mask_shift;
 	struct ath12k_band_cap band[NUM_NL80211_BANDS];
+	u32 eml_cap;
+	u32 mld_cap;
 };
 
 struct mlo_timestamp {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 7962bfa955ba..6c20c71ada62 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10693,7 +10693,7 @@ static const u8 ath12k_if_types_ext_capa_ap[] = {
 	[10] = WLAN_EXT_CAPA11_EMA_SUPPORT,
 };
 
-static const struct wiphy_iftype_ext_capab ath12k_iftypes_ext_capa[] = {
+static struct wiphy_iftype_ext_capab ath12k_iftypes_ext_capa[] = {
 	{
 		.extended_capabilities = ath12k_if_types_ext_capa,
 		.extended_capabilities_mask = ath12k_if_types_ext_capa,
@@ -10710,6 +10710,8 @@ static const struct wiphy_iftype_ext_capab ath12k_iftypes_ext_capa[] = {
 		.extended_capabilities_mask = ath12k_if_types_ext_capa_ap,
 		.extended_capabilities_len =
 				sizeof(ath12k_if_types_ext_capa_ap),
+		.eml_capabilities = 0,
+		.mld_capa_and_ops = 0,
 	},
 };
 
@@ -10919,6 +10921,15 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	 */
 	wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
 
+	/* Copy over MLO related capabilities received from
+	 * WMI_SERVICE_READY_EXT2_EVENT if single_chip_mlo_supp is set.
+	 */
+	if (ab->ag->mlo_capable) {
+		ath12k_iftypes_ext_capa[2].eml_capabilities = cap->eml_cap;
+		ath12k_iftypes_ext_capa[2].mld_capa_and_ops = cap->mld_cap;
+		wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+	}
+
 	hw->queues = ATH12K_HW_MAX_QUEUES;
 	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
 	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index cf5c3efec4b7..7b3597061b34 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4662,6 +4662,9 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
 					  caps->eht_cap_info_internal);
 	}
 
+	pdev->cap.eml_cap = le32_to_cpu(caps->eml_capability);
+	pdev->cap.mld_cap = le32_to_cpu(caps->mld_capability);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index cd3de0a65543..b6a197389277 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2716,6 +2716,8 @@ struct ath12k_wmi_caps_ext_params {
 	__le32 eht_cap_info_internal;
 	__le32 eht_supp_mcs_ext_2ghz[WMI_MAX_EHT_SUPP_MCS_2G_SIZE];
 	__le32 eht_supp_mcs_ext_5ghz[WMI_MAX_EHT_SUPP_MCS_5G_SIZE];
+	__le32 eml_capability;
+	__le32 mld_capability;
 } __packed;
 
 /* 2 word representation of MAC addr */
-- 
2.39.5


