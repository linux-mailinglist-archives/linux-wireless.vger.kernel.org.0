Return-Path: <linux-wireless+bounces-29819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4514ACC44AA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54D8B3025712
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A32C11C5;
	Tue, 16 Dec 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MT0Y+N3U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2428642B
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902272; cv=none; b=n0+llOV2xlU9qu7MjYKWPR3H7Rf5mTQNk4D9ImK0jz3j116vQpznaMhKVa1IsZmBn7sU8s0njpv+RXKB6FCF+R7kUZ7F2py83SbRcavI93EmLx6vhWpEEeYmFT8UOlYbdTJVL0a/ILVPhI938Gmo8Q2G+GhUIO/UX0756DkE7vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902272; c=relaxed/simple;
	bh=+0kFGIVn08atMWITQuH45NIzNPiPr5ihLwo9cqJ7EMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9HQbQF82CtWCjkcujV+3hZpJYZlt/KX7tSBHXpzlo3TKyA8CgqJOrxlLF+3y34c/1Z02iysiRvmpCNu395j3AE+HVVmienff6DrofXT2ZjXRVjFkqAwZ/nlI+vceLtGdSRcyfFdX4OUESR7IWQ+Esm8RI7hXo7TvUVwUMKNgFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MT0Y+N3U; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UPBqQH0a/ezvhQdMk9UuLQNsrTd0gHDWsiRHHiMTiF8=;
	t=1765902269; x=1767111869; b=MT0Y+N3UsQ7Hi6LHyifGchwMepy9arHi0DIeMboxf+Spl24
	/iz/QhdPUf2egtyf71rnf7433jxSfjWfBfSNCYMc1q91lOTROUTz7m0V4hVOOBfEy5YI3eVmli7nE
	1JDgIFOriL5f3btjHcfPEQr1ukng1tBAQB2SXGLxYQ6F5GjYYdT615FRiIa1i8MSfeQgn2b+chR2o
	siLKGlRVCxAvng1LoRxOiHco2tYgUVJg6PZOELCA/I7dxNTIDUpgmOCpXW5VP4SmsY7kgvPDU/DW9
	7WfsqJIYhbKp9h34M0wo0frb8vAvy52UYJawO6PI3Si4KH2bVh6V+ex757534F7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVXqb-0000000AaUr-0zyl;
	Tue, 16 Dec 2025 17:24:25 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC v2 wireless-next 1/3] wifi: ieee80211: add some initial UHR definitions
Date: Tue, 16 Dec 2025 17:23:35 +0100
Message-ID: <20251216172421.e8f2778b5ce6.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216162421.40066-5-johannes@sipsolutions.net>
References: <20251216162421.40066-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is based on Draft P802.11bn_D1.0, but that's still very
incomplete, so don't handle a number of things and make some
local decisions such as 40 bits for MAC capabilities etc.
Also, I fixed the NPCA channel to be 8 instead of 4 bits.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211-uhr.h | 176 ++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     |  31 +++++-
 2 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/ieee80211-uhr.h

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
new file mode 100644
index 000000000000..e57181ba0182
--- /dev/null
+++ b/include/linux/ieee80211-uhr.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * IEEE 802.11 UHR definitions
+ *
+ * Copyright (c) 2025 Intel Corporation
+ */
+#ifndef LINUX_IEEE80211_UHR_H
+#define LINUX_IEEE80211_UHR_H
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+
+#define IEEE80211_UHR_OPER_PARAMS_DPS_ENA		0x0001
+#define IEEE80211_UHR_OPER_PARAMS_NPCA_ENA		0x0002
+#define IEEE80211_UHR_OPER_PARAMS_DBE_ENA		0x0004
+#define IEEE80211_UHR_OPER_PARAMS_PEDCA_ENA		0x0008
+
+struct ieee80211_uhr_oper {
+	__le16 params;
+	u8 basic_mcs_nss_set[4];
+	u8 variable[];
+} __packed;
+
+#define IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN		0x000000FF
+#define IEEE80211_UHR_NPCA_PARAMS_MIN_DUR_THRESH	0x00000F00
+#define IEEE80211_UHR_NPCA_PARAMS_SWITCH_DELAY		0x0003F000
+#define IEEE80211_UHR_NPCA_PARAMS_SWITCH_BACK_DELAY	0x00FC0000
+#define IEEE80211_UHR_NPCA_PARAMS_INIT_QSRC		0x03000000
+#define IEEE80211_UHR_NPCA_PARAMS_MOPLEN		0x04000000
+#define IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES	0x08000000
+
+struct ieee80211_uhr_npca_info {
+	__le32 params;
+	__le16 dis_subch_bmap[];
+} __packed;
+
+static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
+					      bool beacon)
+{
+	const struct ieee80211_uhr_oper *oper = (const void *)data;
+	u8 needed = sizeof(*oper);
+
+	if (len < needed)
+		return false;
+
+	/* nothing else present in beacons */
+	if (beacon)
+		return true;
+
+	/* FIXME: DPS, DBE, P-EDCA (consider order, also relative to NPCA) */
+
+	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)) {
+		const struct ieee80211_uhr_npca_info *npca =
+			(const void *)oper->variable;
+
+		needed += sizeof(*npca);
+
+		if (len < needed)
+			return false;
+
+		if (npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES))
+			needed += sizeof(npca->dis_subch_bmap[0]);
+	}
+
+	return len >= needed;
+}
+
+/*
+ * Note: cannot call this on the element coming from a beacon,
+ * must ensure ieee80211_uhr_oper_size_ok(..., false) first
+ */
+static inline const struct ieee80211_uhr_npca_info *
+ieee80211_uhr_npca_info(const struct ieee80211_uhr_oper *oper)
+{
+	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)))
+		return NULL;
+
+	/* FIXME: DPS */
+
+	return (const void *)oper->variable;
+}
+
+static inline const __le16 *
+ieee80211_uhr_npca_dis_subch_bitmap(const struct ieee80211_uhr_oper *oper)
+{
+	const struct ieee80211_uhr_npca_info *npca;
+
+	npca = ieee80211_uhr_npca_info(oper);
+	if (!npca)
+		return NULL;
+	if (!(npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES)))
+		return NULL;
+	return npca->dis_subch_bmap;
+}
+
+#define IEEE80211_UHR_MAC_CAP0_DPS_SUPP			0x01
+#define IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP		0x02
+#define IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP	0x04
+#define IEEE80211_UHR_MAC_CAP0_ML_PM_SUPP		0x08
+#define IEEE80211_UHR_MAC_CAP0_NPCA_SUPP		0x10
+#define IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP		0x20
+#define IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP		0x40
+#define IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP		0x80
+
+#define IEEE80211_UHR_MAC_CAP1_DSO_SUPP			0x01
+#define IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP		0x02
+#define IEEE80211_UHR_MAC_CAP1_DBE_SUPP			0x04
+#define IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP		0x08
+#define IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP		0x10
+#define IEEE80211_UHR_MAC_CAP1_PUO_SUPP			0x20
+#define IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP		0x40
+#define IEEE80211_UHR_MAC_CAP1_DUO_SUPP			0x80
+
+#define IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP	0x01
+#define IEEE80211_UHR_MAC_CAP2_AOM_SUPP			0x02
+#define IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP		0x04
+#define IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP		0x08
+#define IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP		0x10
+#define IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG	0x20
+#define IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW		0xC0
+
+#define IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH	0x03
+#define IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV	0x1C
+#define IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTVL_LOW	0xE0
+
+#define IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTVL_LOW	0x03
+#define IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE		0x04
+
+struct ieee80211_uhr_capa_mac {
+	u8 mac_cap[5];
+} __packed;
+
+struct ieee80211_uhr_capa {
+	struct ieee80211_uhr_capa_mac mac;
+	u8 variable[];
+} __packed;
+
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_LE80		0x01
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_MU_LE80	0x02
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_160		0x04
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_MU_160		0x08
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_320		0x10
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_MU_320		0x20
+#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x40
+#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x80
+
+struct ieee80211_uhr_capa_phy {
+	u8 cap;
+} __packed;
+
+static inline bool ieee80211_uhr_capa_size_ok(const u8 *data, u8 len)
+{
+	/* FIXME - DBE */
+	return len >= sizeof(struct ieee80211_uhr_capa) +
+		      sizeof(struct ieee80211_uhr_capa_phy);
+}
+
+static inline const struct ieee80211_uhr_capa_phy *
+ieee80211_uhr_phy_cap(const struct ieee80211_uhr_capa *cap)
+{
+	/* FIXME - skip variable DBE stuff, assume not present for now */
+	return (const void *)&cap->variable;
+}
+
+#define IEEE80211_SMD_INFO_CAPA_DL_DATA_FWD		0x01
+#define IEEE80211_SMD_INFO_CAPA_MAX_NUM_PREP		0x0E
+#define IEEE80211_SMD_INFO_CAPA_TYPE			0x10
+#define IEEE80211_SMD_INFO_CAPA_PTK_PER_AP_MLD		0x20
+
+struct ieee80211_smd_info {
+	u8 id[ETH_ALEN];
+	u8 capa;
+	__le16 timeout;
+} __packed;
+
+#endif /* LINUX_IEEE80211_UHR_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 96439de55f07..4aa0bfc515d0 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1200,8 +1200,9 @@ struct ieee80211_mgmt {
 #define BSS_MEMBERSHIP_SELECTOR_SAE_H2E 123
 #define BSS_MEMBERSHIP_SELECTOR_HE_PHY	122
 #define BSS_MEMBERSHIP_SELECTOR_EHT_PHY	121
+#define BSS_MEMBERSHIP_SELECTOR_UHR_PHY	120
 
-#define BSS_MEMBERSHIP_SELECTOR_MIN	BSS_MEMBERSHIP_SELECTOR_EHT_PHY
+#define BSS_MEMBERSHIP_SELECTOR_MIN	BSS_MEMBERSHIP_SELECTOR_UHR_PHY
 
 /* mgmt header + 1 byte category code */
 #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
@@ -1801,6 +1802,15 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
 	WLAN_EID_EXT_KNOWN_STA_IDENTIFCATION = 136,
 	WLAN_EID_EXT_NON_AP_STA_REG_CON = 137,
+	WLAN_EID_EXT_UHR_OPER = 151,
+	WLAN_EID_EXT_UHR_CAPA = 152,
+	WLAN_EID_EXT_MACP = 153,
+	WLAN_EID_EXT_SMD = 154,
+	WLAN_EID_EXT_BSS_TRANS_PARAMS = 155,
+	WLAN_EID_EXT_CHAN_USAGE = 156,
+	WLAN_EID_EXT_UHR_MODE_CHG = 157,
+	WLAN_EID_EXT_UHR_PARAM_UPD = 158,
+	WLAN_EID_EXT_TXPI = 159,
 };
 
 /* Action category code */
@@ -2744,6 +2754,22 @@ static inline bool for_each_element_completed(const struct element *element,
 #define WLAN_RSNX_CAPA_PROTECTED_TWT BIT(4)
 #define WLAN_RSNX_CAPA_SAE_H2E BIT(5)
 
+/* EBPCC = Enhanced BSS Parameter Change Count */
+#define IEEE80211_ENH_CRIT_UPD_EBPCC		0x0F
+#define IEEE80211_ENH_CRIT_UPD_TYPE		0x70
+#define IEEE80211_ENH_CRIT_UPD_TYPE_NO_UHR	0
+#define IEEE80211_ENH_CRIT_UPD_TYPE_UHR		1
+#define IEEE80211_ENH_CRIT_UPD_ALL		0x80
+
+/**
+ * struct ieee80211_enh_crit_upd - enhanced critical update (UHR)
+ * @v: value of the enhanced critical update data,
+ *	see %IEEE80211_ENH_CRIT_UPD_* to parse the bits
+ */
+struct ieee80211_enh_crit_upd {
+	u8 v;
+} __packed;
+
 /*
  * reduced neighbor report, based on Draft P802.11ax_D6.1,
  * section 9.4.2.170 and accepted contributions.
@@ -2762,6 +2788,7 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_RNR_TBTT_PARAMS_COLOC_ESS			0x10
 #define IEEE80211_RNR_TBTT_PARAMS_PROBE_ACTIVE			0x20
 #define IEEE80211_RNR_TBTT_PARAMS_COLOC_AP			0x40
+#define IEEE80211_RNR_TBTT_PARAMS_SAME_SMD			0x80
 
 #define IEEE80211_RNR_TBTT_PARAMS_PSD_NO_LIMIT			127
 #define IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED			-128
@@ -2814,12 +2841,14 @@ struct ieee80211_tbtt_info_ge_11 {
 	u8 bss_params;
 	s8 psd_20;
 	struct ieee80211_rnr_mld_params mld_params;
+	struct ieee80211_enh_crit_upd enh_crit_upd;
 } __packed;
 
 #include "ieee80211-ht.h"
 #include "ieee80211-vht.h"
 #include "ieee80211-he.h"
 #include "ieee80211-eht.h"
+#include "ieee80211-uhr.h"
 #include "ieee80211-mesh.h"
 #include "ieee80211-s1g.h"
 #include "ieee80211-p2p.h"
-- 
2.52.0


