Return-Path: <linux-wireless+bounces-31322-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BChMHNXe2k0EAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31322-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:49:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD49B0253
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 13:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06B74300DA59
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D7D3815C8;
	Thu, 29 Jan 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nREWGPji"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDDC3446D0
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690991; cv=none; b=o2pY1I43dHis20HoRaQjmy64yKAW3GozVjqpNgP++rxgwx42b5IBH03touLS8cKsBqzSnFgKwaFoOiRkoePwyE9dwND3f6NEd27cxdA6Sxsr4/r3bhIFtVvt3nlPbtFRVdATYbUylpF/ssTZspJw/xt18tiSJSzs1OvHWopuBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690991; c=relaxed/simple;
	bh=5m8d9Aalbf7DZprFNObGTyNi2KO7KpZTyPEQjnJY9cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7ytCp59k5wjgQRQOLRAUHRjqRKObMUvnGyZr5t5mx15Oz7CpDCIHcSMpWHYraue5XPICKFvlNXFZhaiBVI/sNA7JMWrTvO/UfixESMTqINpQ/IbldVe1r5uJTmO3okFxBODG3jBHG1DgmdbAyA9jJkGSr+hIsnggeshpSI2g/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nREWGPji; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=x8KLIei+mVXYDR/yelXfM7m21VXmrqwcZPSybbgarg0=; t=1769690989; x=1770900589; 
	b=nREWGPjiTEJlVk+I8Gc6uLJE5l3dTbEPN3yb6PkkVSZ2iNWQrgOI1xsAfN1W73w3U1HzEC2ZUIu
	V/XkTwb1KUNlZ7y9apM3JTEkw26McS5XgrnMjtMkTv+Wh0qSkC7OCIWYwTAH7ggsNpxuaHohbXUcv
	ABHcLweaZQ63EDJT9UccB2JKm1y259t8TeMuGLxLVF2CzQtp5MZ2YucS2giIcySugKVt1jtn/aDcp
	hKwNQrnXFBHpeH9IFyHj/QcELQIFY3/f/O7jm+PbrdGCv/wGHrPeeCURQGDxk4fy//2bkBNilEShV
	q3wKuvH+o3M1uAFxI6vKtgLcIZmNUCjJMuZg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlRT0-00000006rFP-2UbU;
	Thu, 29 Jan 2026 13:49:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v6 1/3] wifi: ieee80211: add some initial UHR definitions
Date: Thu, 29 Jan 2026 13:49:44 +0100
Message-ID: <20260129134944.a84420ec58d6.I5b11fb0345a933bf497fd802aecc72932d58dd68@changeid>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31322-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 1BD49B0253
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

This is based on Draft P802.11bn_D1.2, but that's still very
incomplete, so don't handle a number of things and make some
local decisions such as using 40 bits for MAC capabilities
and 8 bits for PHY capabilities.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v6:
  - add 'ap' argument to ieee80211_uhr_phy_cap()
v5:
  - use correct EHT MCS len (24 bits, not 24 bytes)
  - handle DBE AP/non-AP in ieee80211_uhr_capa_size_ok()
v4:
  - update to D1.2, including DBE in UHR capabilities
  - fold in suggestions from Pablo
---
 include/linux/ieee80211-uhr.h | 219 ++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     |  33 ++++-
 2 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/ieee80211-uhr.h

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
new file mode 100644
index 000000000000..8fd0c1e558ed
--- /dev/null
+++ b/include/linux/ieee80211-uhr.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * IEEE 802.11 UHR definitions
+ *
+ * Copyright (c) 2025-2026 Intel Corporation
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
+#define IEEE80211_UHR_NPCA_PARAMS_PRIMARY_CHAN_OFFS	0x0000000F
+#define IEEE80211_UHR_NPCA_PARAMS_MIN_DUR_THRESH	0x000000F0
+#define IEEE80211_UHR_NPCA_PARAMS_SWITCH_DELAY		0x00003F00
+#define IEEE80211_UHR_NPCA_PARAMS_SWITCH_BACK_DELAY	0x000FC000
+#define IEEE80211_UHR_NPCA_PARAMS_INIT_QSRC		0x00300000
+#define IEEE80211_UHR_NPCA_PARAMS_MOPLEN		0x00400000
+#define IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES	0x00800000
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
+#define IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW	0xE0
+
+#define IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH	0x03
+#define IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS		0x04
+#define IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE		0x08
+#define IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP		0x10
+
+#define IEEE80211_UHR_MAC_CAP_DBE_MAX_BW		0x07
+#define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES	0x08
+#define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES	0x10
+
+struct ieee80211_uhr_capa_mac {
+	u8 mac_cap[5];
+} __packed;
+
+struct ieee80211_uhr_capa {
+	struct ieee80211_uhr_capa_mac mac;
+	/* DBE, PHY capabilities */
+	u8 variable[];
+} __packed;
+
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80	0x01
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80	0x02
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160	0x04
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160	0x08
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320	0x10
+#define IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320	0x20
+#define IEEE80211_UHR_PHY_CAP_ELR_RX			0x40
+#define IEEE80211_UHR_PHY_CAP_ELR_TX			0x80
+
+struct ieee80211_uhr_capa_phy {
+	u8 cap;
+} __packed;
+
+static inline bool ieee80211_uhr_capa_size_ok(const u8 *data, u8 len, bool ap)
+{
+	const struct ieee80211_uhr_capa *cap = (const void *)data;
+	size_t needed = sizeof(*cap) + sizeof(struct ieee80211_uhr_capa_phy);
+
+	if (len < needed)
+		return false;
+
+	/*
+	 * A non-AP STA does not include the DBE Capability Parameters field
+	 * in the UHR MAC Capabilities Information field.
+	 */
+	if (ap && cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
+		u8 dbe;
+
+		needed += 1;
+		if (len < needed)
+			return false;
+
+		dbe = cap->variable[0];
+
+		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
+			needed += 3;
+
+		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
+			needed += 3;
+	}
+
+	return len >= needed;
+}
+
+static inline const struct ieee80211_uhr_capa_phy *
+ieee80211_uhr_phy_cap(const struct ieee80211_uhr_capa *cap, bool ap)
+{
+	u8 offs = 0;
+
+	if (ap && cap->mac.mac_cap[1] & IEEE80211_UHR_MAC_CAP1_DBE_SUPP) {
+		u8 dbe = cap->variable[0];
+
+		offs += 1;
+
+		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES)
+			offs += 3;
+
+		if (dbe & IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES)
+			offs += 3;
+	}
+
+	return (const void *)&cap->variable[offs];
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
index fbde215c25aa..82d797be95b9 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2025 Intel Corporation
+ * Copyright (c) 2018 - 2026 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_H
@@ -1200,8 +1200,9 @@ struct ieee80211_mgmt {
 #define BSS_MEMBERSHIP_SELECTOR_SAE_H2E 123
 #define BSS_MEMBERSHIP_SELECTOR_HE_PHY	122
 #define BSS_MEMBERSHIP_SELECTOR_EHT_PHY	121
+#define BSS_MEMBERSHIP_SELECTOR_UHR_PHY	120
 
-#define BSS_MEMBERSHIP_SELECTOR_MIN	BSS_MEMBERSHIP_SELECTOR_EHT_PHY
+#define BSS_MEMBERSHIP_SELECTOR_MIN	BSS_MEMBERSHIP_SELECTOR_UHR_PHY
 
 /* mgmt header + 1 byte category code */
 #define IEEE80211_MIN_ACTION_SIZE offsetof(struct ieee80211_mgmt, u.action.u)
@@ -1802,6 +1803,15 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
 	WLAN_EID_EXT_KNOWN_STA_IDENTIFCATION = 136,
 	WLAN_EID_EXT_NON_AP_STA_REG_CON = 137,
+	WLAN_EID_EXT_UHR_OPER = 151,
+	WLAN_EID_EXT_UHR_CAPA = 152,
+	WLAN_EID_EXT_MACP = 153,
+	WLAN_EID_EXT_SMD = 154,
+	WLAN_EID_EXT_BSS_SMD_TRANS_PARAMS = 155,
+	WLAN_EID_EXT_CHAN_USAGE = 156,
+	WLAN_EID_EXT_UHR_MODE_CHG = 157,
+	WLAN_EID_EXT_UHR_PARAM_UPD = 158,
+	WLAN_EID_EXT_TXPI = 159,
 };
 
 /* Action category code */
@@ -2745,6 +2755,22 @@ static inline bool for_each_element_completed(const struct element *element,
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
@@ -2763,6 +2789,7 @@ static inline bool for_each_element_completed(const struct element *element,
 #define IEEE80211_RNR_TBTT_PARAMS_COLOC_ESS			0x10
 #define IEEE80211_RNR_TBTT_PARAMS_PROBE_ACTIVE			0x20
 #define IEEE80211_RNR_TBTT_PARAMS_COLOC_AP			0x40
+#define IEEE80211_RNR_TBTT_PARAMS_SAME_SMD			0x80
 
 #define IEEE80211_RNR_TBTT_PARAMS_PSD_NO_LIMIT			127
 #define IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED			-128
@@ -2815,12 +2842,14 @@ struct ieee80211_tbtt_info_ge_11 {
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


