Return-Path: <linux-wireless+bounces-18999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BFA3738F
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618B316D0F1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86699195F0D;
	Sun, 16 Feb 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TecldZaC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826ED18DB3A
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699055; cv=none; b=S3zikMFQkGyBPfBwkwJh9NHZTyuwk980CoDLva9P1UWdQZ0IfUNnkGMRnRkxxW410403XRaEcdbSEmjuMEsyJ0J2TJeWrGX7DvkYx5fXjg8ZD7Vffs+MNNHicvY9+4vODifg6mxWeqzMbyJaRL69joLvlDtaii40JgGvKdJKu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699055; c=relaxed/simple;
	bh=RO6y179h29UQzkuU/sXZHUiwKxJ/mmtJYkJ7b+F77rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oaleaglwXW1lKaTVIab22Xmsul4bjtod0p3EPdWbGiwMgtAXNmOEGqv4pz2Cn3URmrGMRqv/QIUPce45jbNZh+r/1LiTJ7v5rijsMmqXtbRmaGbfuWRPQHL3tjGuTcgTo6JuZlh9vQobZZOMNwOGm2e/KolaI5o2Ia+bxbV6gVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TecldZaC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699053; x=1771235053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RO6y179h29UQzkuU/sXZHUiwKxJ/mmtJYkJ7b+F77rI=;
  b=TecldZaCjRplS+Q2t0hcMQNeCSIGxHTXQO7HRMQ/zSIske6Xyjr/a6tP
   fKwYnm32tfTq+2hRNOqm0Z/fKTBUpd2Acgy+mLvI6Zm/gwmvNNqbNzTS8
   qmPr5maoFRvL9hwZ5ktEcKwY9e2hWsGQFkx9rz7mgV+NgU8LzADgMQRIz
   215zPNqj7wLJ3RNajlbRX23N/ShkVKfG3bUDBnz5N99sJ9nDspShRLmV3
   T5RimePBtBCUU4PmCFlOUiIreb4VIh7fdan4F3Gt38PcMDBvtpDT2u1FD
   /cBdKoD4MbL4ZD7fQoVoai77E+zziO4uQ4CAMbWDqtgRatRs7JyodQWmv
   w==;
X-CSE-ConnectionGUID: vcxnPai7QSmeAy+mIvlNgQ==
X-CSE-MsgGUID: Z/HKklajRiyUvx/EjYjwEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323412"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323412"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:12 -0800
X-CSE-ConnectionGUID: K5G+kP59Rq6k/GrE4n3QlA==
X-CSE-MsgGUID: 64lYdJorScyNdviIz7ZFAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785261"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 28/42] wifi: iwlwifi: mld: add file sta.h/c
Date: Sun, 16 Feb 2025 11:43:07 +0200
Message-Id: <20250216111648.4b1b2293f5b1.I9265eabfa4f280fc2068f6e89733600d32e95369@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

this file is handling a link object

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 1265 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/sta.h |  266 ++++
 2 files changed, 1531 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/sta.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/sta.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
new file mode 100644
index 000000000000..f266a81dd29b
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -0,0 +1,1265 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#include <linux/ieee80211.h>
+#include <kunit/static_stub.h>
+
+#include "sta.h"
+#include "hcmd.h"
+#include "iface.h"
+#include "mlo.h"
+#include "key.h"
+#include "agg.h"
+#include "tlc.h"
+#include "fw/api/sta.h"
+#include "fw/api/mac.h"
+#include "fw/api/rx.h"
+
+int iwl_mld_fw_sta_id_from_link_sta(struct iwl_mld *mld,
+				    struct ieee80211_link_sta *link_sta)
+{
+	struct iwl_mld_link_sta *mld_link_sta;
+
+	/* This function should only be used with the wiphy lock held,
+	 * In other cases, it is not guaranteed that the link_sta will exist
+	 * in the driver too, and it is checked here.
+	 */
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* This is not meant to be called with a NULL pointer */
+	if (WARN_ON(!link_sta))
+		return -ENOENT;
+
+	mld_link_sta = iwl_mld_link_sta_from_mac80211(link_sta);
+	if (!mld_link_sta) {
+		WARN_ON(!iwl_mld_error_before_recovery(mld));
+		return -ENOENT;
+	}
+
+	return mld_link_sta->fw_id;
+}
+
+static void
+iwl_mld_fill_ampdu_size_and_dens(struct ieee80211_link_sta *link_sta,
+				 struct ieee80211_bss_conf *link,
+				 __le32 *tx_ampdu_max_size,
+				 __le32 *tx_ampdu_spacing)
+{
+	u32 agg_size = 0, mpdu_dens = 0;
+
+	if (WARN_ON(!link_sta || !link))
+		return;
+
+	/* Note that we always use only legacy & highest supported PPDUs, so
+	 * of Draft P802.11be D.30 Table 10-12a--Fields used for calculating
+	 * the maximum A-MPDU size of various PPDU types in different bands,
+	 * we only need to worry about the highest supported PPDU type here.
+	 */
+
+	if (link_sta->ht_cap.ht_supported) {
+		agg_size = link_sta->ht_cap.ampdu_factor;
+		mpdu_dens = link_sta->ht_cap.ampdu_density;
+	}
+
+	if (link->chanreq.oper.chan->band == NL80211_BAND_6GHZ) {
+		/* overwrite HT values on 6 GHz */
+		mpdu_dens =
+			le16_get_bits(link_sta->he_6ghz_capa.capa,
+				      IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START);
+		agg_size =
+			le16_get_bits(link_sta->he_6ghz_capa.capa,
+				      IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
+	} else if (link_sta->vht_cap.vht_supported) {
+		/* if VHT supported overwrite HT value */
+		agg_size =
+			u32_get_bits(link_sta->vht_cap.cap,
+				     IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK);
+	}
+
+	/* D6.0 10.12.2 A-MPDU length limit rules
+	 * A STA indicates the maximum length of the A-MPDU preEOF padding
+	 * that it can receive in an HE PPDU in the Maximum A-MPDU Length
+	 * Exponent field in its HT Capabilities, VHT Capabilities,
+	 * and HE 6 GHz Band Capabilities elements (if present) and the
+	 * Maximum AMPDU Length Exponent Extension field in its HE
+	 * Capabilities element
+	 */
+	if (link_sta->he_cap.has_he)
+		agg_size +=
+			u8_get_bits(link_sta->he_cap.he_cap_elem.mac_cap_info[3],
+				    IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK);
+
+	if (link_sta->eht_cap.has_eht)
+		agg_size +=
+			u8_get_bits(link_sta->eht_cap.eht_cap_elem.mac_cap_info[1],
+				    IEEE80211_EHT_MAC_CAP1_MAX_AMPDU_LEN_MASK);
+
+	/* Limit to max A-MPDU supported by FW */
+	agg_size = min_t(u32, agg_size,
+			 STA_FLG_MAX_AGG_SIZE_4M >> STA_FLG_MAX_AGG_SIZE_SHIFT);
+
+	*tx_ampdu_max_size = cpu_to_le32(agg_size);
+	*tx_ampdu_spacing = cpu_to_le32(mpdu_dens);
+}
+
+static u8 iwl_mld_get_uapsd_acs(struct ieee80211_sta *sta)
+{
+	u8 uapsd_acs = 0;
+
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK)
+		uapsd_acs |= BIT(AC_BK);
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE)
+		uapsd_acs |= BIT(AC_BE);
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI)
+		uapsd_acs |= BIT(AC_VI);
+	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO)
+		uapsd_acs |= BIT(AC_VO);
+
+	return uapsd_acs | uapsd_acs << 4;
+}
+
+static u8 iwl_mld_he_get_ppe_val(u8 *ppe, u8 ppe_pos_bit)
+{
+	u8 byte_num = ppe_pos_bit / 8;
+	u8 bit_num = ppe_pos_bit % 8;
+	u8 residue_bits;
+	u8 res;
+
+	if (bit_num <= 5)
+		return (ppe[byte_num] >> bit_num) &
+		       (BIT(IEEE80211_PPE_THRES_INFO_PPET_SIZE) - 1);
+
+	/* If bit_num > 5, we have to combine bits with next byte.
+	 * Calculate how many bits we need to take from current byte (called
+	 * here "residue_bits"), and add them to bits from next byte.
+	 */
+
+	residue_bits = 8 - bit_num;
+
+	res = (ppe[byte_num + 1] &
+	       (BIT(IEEE80211_PPE_THRES_INFO_PPET_SIZE - residue_bits) - 1)) <<
+	      residue_bits;
+	res += (ppe[byte_num] >> bit_num) & (BIT(residue_bits) - 1);
+
+	return res;
+}
+
+static void iwl_mld_parse_ppe(struct iwl_mld *mld,
+			      struct iwl_he_pkt_ext_v2 *pkt_ext, u8 nss,
+			      u8 ru_index_bitmap, u8 *ppe, u8 ppe_pos_bit,
+			      bool inheritance)
+{
+	/* FW currently supports only nss == MAX_HE_SUPP_NSS
+	 *
+	 * If nss > MAX: we can ignore values we don't support
+	 * If nss < MAX: we can set zeros in other streams
+	 */
+	if (nss > MAX_HE_SUPP_NSS) {
+		IWL_DEBUG_INFO(mld, "Got NSS = %d - trimming to %d\n", nss,
+			       MAX_HE_SUPP_NSS);
+		nss = MAX_HE_SUPP_NSS;
+	}
+
+	for (int i = 0; i < nss; i++) {
+		u8 ru_index_tmp = ru_index_bitmap << 1;
+		u8 low_th = IWL_HE_PKT_EXT_NONE, high_th = IWL_HE_PKT_EXT_NONE;
+
+		for (u8 bw = 0;
+		     bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
+		     bw++) {
+			ru_index_tmp >>= 1;
+
+			/* According to the 11be spec, if for a specific BW the PPE Thresholds
+			 * isn't present - it should inherit the thresholds from the last
+			 * BW for which we had PPE Thresholds. In 11ax though, we don't have
+			 * this inheritance - continue in this case
+			 */
+			if (!(ru_index_tmp & 1)) {
+				if (inheritance)
+					goto set_thresholds;
+				else
+					continue;
+			}
+
+			high_th = iwl_mld_he_get_ppe_val(ppe, ppe_pos_bit);
+			ppe_pos_bit += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
+			low_th = iwl_mld_he_get_ppe_val(ppe, ppe_pos_bit);
+			ppe_pos_bit += IEEE80211_PPE_THRES_INFO_PPET_SIZE;
+
+set_thresholds:
+			pkt_ext->pkt_ext_qam_th[i][bw][0] = low_th;
+			pkt_ext->pkt_ext_qam_th[i][bw][1] = high_th;
+		}
+	}
+}
+
+static void iwl_mld_set_pkt_ext_from_he_ppe(struct iwl_mld *mld,
+					    struct ieee80211_link_sta *link_sta,
+					    struct iwl_he_pkt_ext_v2 *pkt_ext,
+					    bool inheritance)
+{
+	u8 nss = (link_sta->he_cap.ppe_thres[0] &
+		  IEEE80211_PPE_THRES_NSS_MASK) + 1;
+	u8 *ppe = &link_sta->he_cap.ppe_thres[0];
+	u8 ru_index_bitmap =
+		u8_get_bits(*ppe,
+			    IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK);
+	/* Starting after PPE header */
+	u8 ppe_pos_bit = IEEE80211_HE_PPE_THRES_INFO_HEADER_SIZE;
+
+	iwl_mld_parse_ppe(mld, pkt_ext, nss, ru_index_bitmap, ppe, ppe_pos_bit,
+			  inheritance);
+}
+
+static int
+iwl_mld_set_pkt_ext_from_nominal_padding(struct iwl_he_pkt_ext_v2 *pkt_ext,
+					 u8 nominal_padding)
+{
+	int low_th = -1;
+	int high_th = -1;
+
+	/* all the macros are the same for EHT and HE */
+	switch (nominal_padding) {
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_0US:
+		low_th = IWL_HE_PKT_EXT_NONE;
+		high_th = IWL_HE_PKT_EXT_NONE;
+		break;
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_8US:
+		low_th = IWL_HE_PKT_EXT_BPSK;
+		high_th = IWL_HE_PKT_EXT_NONE;
+		break;
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_16US:
+	case IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_20US:
+		low_th = IWL_HE_PKT_EXT_NONE;
+		high_th = IWL_HE_PKT_EXT_BPSK;
+		break;
+	}
+
+	if (low_th < 0 || high_th < 0)
+		return -EINVAL;
+
+	/* Set the PPE thresholds accordingly */
+	for (int i = 0; i < MAX_HE_SUPP_NSS; i++) {
+		for (u8 bw = 0;
+			bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
+			bw++) {
+			pkt_ext->pkt_ext_qam_th[i][bw][0] = low_th;
+			pkt_ext->pkt_ext_qam_th[i][bw][1] = high_th;
+		}
+	}
+
+	return 0;
+}
+
+static void iwl_mld_get_optimal_ppe_info(struct iwl_he_pkt_ext_v2 *pkt_ext,
+					 u8 nominal_padding)
+{
+	for (int i = 0; i < MAX_HE_SUPP_NSS; i++) {
+		for (u8 bw = 0; bw < ARRAY_SIZE(pkt_ext->pkt_ext_qam_th[i]);
+		     bw++) {
+			u8 *qam_th = &pkt_ext->pkt_ext_qam_th[i][bw][0];
+
+			if (nominal_padding >
+			    IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_8US &&
+			    qam_th[1] == IWL_HE_PKT_EXT_NONE)
+				qam_th[1] = IWL_HE_PKT_EXT_4096QAM;
+			else if (nominal_padding ==
+				 IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_8US &&
+				 qam_th[0] == IWL_HE_PKT_EXT_NONE &&
+				 qam_th[1] == IWL_HE_PKT_EXT_NONE)
+				qam_th[0] = IWL_HE_PKT_EXT_4096QAM;
+		}
+	}
+}
+
+static void iwl_mld_fill_pkt_ext(struct iwl_mld *mld,
+				 struct ieee80211_link_sta *link_sta,
+				 struct iwl_he_pkt_ext_v2 *pkt_ext)
+{
+	if (WARN_ON(!link_sta))
+		return;
+
+	/* Initialize the PPE thresholds to "None" (7), as described in Table
+	 * 9-262ac of 80211.ax/D3.0.
+	 */
+	memset(pkt_ext, IWL_HE_PKT_EXT_NONE, sizeof(*pkt_ext));
+
+	if (link_sta->eht_cap.has_eht) {
+		u8 nominal_padding =
+			u8_get_bits(link_sta->eht_cap.eht_cap_elem.phy_cap_info[5],
+				    IEEE80211_EHT_PHY_CAP5_COMMON_NOMINAL_PKT_PAD_MASK);
+
+		/* If PPE Thresholds exists, parse them into a FW-familiar
+		 * format.
+		 */
+		if (link_sta->eht_cap.eht_cap_elem.phy_cap_info[5] &
+		    IEEE80211_EHT_PHY_CAP5_PPE_THRESHOLD_PRESENT) {
+			u8 nss = (link_sta->eht_cap.eht_ppe_thres[0] &
+				IEEE80211_EHT_PPE_THRES_NSS_MASK) + 1;
+			u8 *ppe = &link_sta->eht_cap.eht_ppe_thres[0];
+			u8 ru_index_bitmap =
+				u16_get_bits(*ppe,
+					     IEEE80211_EHT_PPE_THRES_RU_INDEX_BITMASK_MASK);
+			 /* Starting after PPE header */
+			u8 ppe_pos_bit = IEEE80211_EHT_PPE_THRES_INFO_HEADER_SIZE;
+
+			iwl_mld_parse_ppe(mld, pkt_ext, nss, ru_index_bitmap,
+					  ppe, ppe_pos_bit, true);
+		/* EHT PPE Thresholds doesn't exist - set the API according to
+		 * HE PPE Tresholds
+		 */
+		} else if (link_sta->he_cap.he_cap_elem.phy_cap_info[6] &
+			   IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			/* Even though HE Capabilities IE doesn't contain PPE
+			 * Thresholds for BW 320Mhz, thresholds for this BW will
+			 * be filled in with the same values as 160Mhz, due to
+			 * the inheritance, as required.
+			 */
+			iwl_mld_set_pkt_ext_from_he_ppe(mld, link_sta, pkt_ext,
+							true);
+
+			/* According to the requirements, for MCSs 12-13 the
+			 * maximum value between HE PPE Threshold and Common
+			 * Nominal Packet Padding needs to be taken
+			 */
+			iwl_mld_get_optimal_ppe_info(pkt_ext, nominal_padding);
+
+		/* if PPE Thresholds doesn't present in both EHT IE and HE IE -
+		 * take the Thresholds from Common Nominal Packet Padding field
+		 */
+		} else {
+			iwl_mld_set_pkt_ext_from_nominal_padding(pkt_ext,
+								 nominal_padding);
+		}
+	} else if (link_sta->he_cap.has_he) {
+		/* If PPE Thresholds exist, parse them into a FW-familiar format. */
+		if (link_sta->he_cap.he_cap_elem.phy_cap_info[6] &
+			IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
+			iwl_mld_set_pkt_ext_from_he_ppe(mld, link_sta, pkt_ext,
+							false);
+		/* PPE Thresholds doesn't exist - set the API PPE values
+		 * according to Common Nominal Packet Padding field.
+		 */
+		} else {
+			u8 nominal_padding =
+				u8_get_bits(link_sta->he_cap.he_cap_elem.phy_cap_info[9],
+					    IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_MASK);
+			if (nominal_padding != IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_RESERVED)
+				iwl_mld_set_pkt_ext_from_nominal_padding(pkt_ext,
+									 nominal_padding);
+		}
+	}
+
+	for (int i = 0; i < MAX_HE_SUPP_NSS; i++) {
+		for (int bw = 0;
+		     bw < ARRAY_SIZE(*pkt_ext->pkt_ext_qam_th[i]);
+		     bw++) {
+			u8 *qam_th =
+				&pkt_ext->pkt_ext_qam_th[i][bw][0];
+
+			IWL_DEBUG_HT(mld,
+				     "PPE table: nss[%d] bw[%d] PPET8 = %d, PPET16 = %d\n",
+				     i, bw, qam_th[0], qam_th[1]);
+		}
+	}
+}
+
+static u32 iwl_mld_get_htc_flags(struct ieee80211_link_sta *link_sta)
+{
+	u8 *mac_cap_info =
+		&link_sta->he_cap.he_cap_elem.mac_cap_info[0];
+	u32 htc_flags = 0;
+
+	if (mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_HTC_HE)
+		htc_flags |= IWL_HE_HTC_SUPPORT;
+	if ((mac_cap_info[1] & IEEE80211_HE_MAC_CAP1_LINK_ADAPTATION) ||
+	    (mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_LINK_ADAPTATION)) {
+		u8 link_adap =
+			((mac_cap_info[2] &
+			  IEEE80211_HE_MAC_CAP2_LINK_ADAPTATION) << 1) +
+			 (mac_cap_info[1] &
+			  IEEE80211_HE_MAC_CAP1_LINK_ADAPTATION);
+
+		if (link_adap == 2)
+			htc_flags |=
+				IWL_HE_HTC_LINK_ADAP_UNSOLICITED;
+		else if (link_adap == 3)
+			htc_flags |= IWL_HE_HTC_LINK_ADAP_BOTH;
+	}
+	if (mac_cap_info[2] & IEEE80211_HE_MAC_CAP2_BSR)
+		htc_flags |= IWL_HE_HTC_BSR_SUPP;
+	if (mac_cap_info[3] & IEEE80211_HE_MAC_CAP3_OMI_CONTROL)
+		htc_flags |= IWL_HE_HTC_OMI_SUPP;
+	if (mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
+		htc_flags |= IWL_HE_HTC_BQR_SUPP;
+
+	return htc_flags;
+}
+
+static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
+				const struct iwl_sta_cfg_cmd *cmd)
+{
+	int ret = iwl_mld_send_cmd_pdu(mld,
+				       WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD),
+				       cmd);
+	if (ret)
+		IWL_ERR(mld, "STA_CONFIG_CMD send failed, ret=0x%x\n", ret);
+	return ret;
+}
+
+static int
+iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
+			   struct ieee80211_link_sta *link_sta)
+{
+	struct ieee80211_sta *sta = link_sta->sta;
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct ieee80211_bss_conf *link;
+	struct iwl_mld_link *mld_link;
+	struct iwl_sta_cfg_cmd cmd = {};
+	int fw_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	link = link_conf_dereference_protected(mld_sta->vif,
+					       link_sta->link_id);
+
+	mld_link = iwl_mld_link_from_mac80211(link);
+
+	if (WARN_ON(!link || !mld_link) || fw_id < 0)
+		return -EINVAL;
+
+	cmd.sta_id = cpu_to_le32(fw_id);
+	cmd.station_type = cpu_to_le32(mld_sta->sta_type);
+	cmd.link_id = cpu_to_le32(mld_link->fw_id);
+
+	memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
+	memcpy(&cmd.peer_link_address, link_sta->addr, ETH_ALEN);
+
+	if (mld_sta->sta_state >= IEEE80211_STA_ASSOC)
+		cmd.assoc_id = cpu_to_le32(sta->aid);
+
+	if (sta->mfp || mld_sta->sta_state < IEEE80211_STA_AUTHORIZED)
+		cmd.mfp = cpu_to_le32(1);
+
+	switch (link_sta->rx_nss) {
+	case 1:
+		cmd.mimo = cpu_to_le32(0);
+		break;
+	case 2 ... 8:
+		cmd.mimo = cpu_to_le32(1);
+		break;
+	}
+
+	switch (link_sta->smps_mode) {
+	case IEEE80211_SMPS_AUTOMATIC:
+	case IEEE80211_SMPS_NUM_MODES:
+		WARN_ON(1);
+		break;
+	case IEEE80211_SMPS_STATIC:
+		/* override NSS */
+		cmd.mimo = cpu_to_le32(0);
+		break;
+	case IEEE80211_SMPS_DYNAMIC:
+		cmd.mimo_protection = cpu_to_le32(1);
+		break;
+	case IEEE80211_SMPS_OFF:
+		/* nothing */
+		break;
+	}
+
+	iwl_mld_fill_ampdu_size_and_dens(link_sta, link,
+					 &cmd.tx_ampdu_max_size,
+					 &cmd.tx_ampdu_spacing);
+
+	if (sta->wme) {
+		cmd.sp_length =
+			cpu_to_le32(sta->max_sp ? sta->max_sp * 2 : 128);
+		cmd.uapsd_acs = cpu_to_le32(iwl_mld_get_uapsd_acs(sta));
+	}
+
+	if (link_sta->he_cap.has_he) {
+		cmd.trig_rnd_alloc =
+			cpu_to_le32(link->uora_exists ? 1 : 0);
+
+		/* PPE Thresholds */
+		iwl_mld_fill_pkt_ext(mld, link_sta, &cmd.pkt_ext);
+
+		/* HTC flags */
+		cmd.htc_flags =
+			cpu_to_le32(iwl_mld_get_htc_flags(link_sta));
+
+		if (link_sta->he_cap.he_cap_elem.mac_cap_info[2] &
+		    IEEE80211_HE_MAC_CAP2_ACK_EN)
+			cmd.ack_enabled = cpu_to_le32(1);
+	}
+
+	return iwl_mld_send_sta_cmd(mld, &cmd);
+}
+
+IWL_MLD_ALLOC_FN(link_sta, link_sta)
+
+static int
+iwl_mld_add_link_sta(struct iwl_mld *mld, struct ieee80211_link_sta *link_sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
+	struct iwl_mld_link_sta *mld_link_sta;
+	int ret;
+	u8 fw_id;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* We will fail to add it to the FW anyway */
+	if (iwl_mld_error_before_recovery(mld))
+		return -ENODEV;
+
+	mld_link_sta = iwl_mld_link_sta_from_mac80211(link_sta);
+
+	/* We need to preserve the fw sta ids during a restart, since the fw
+	 * will recover SN/PN for them, this is why the mld_link_sta exists.
+	 */
+	if (mld_link_sta) {
+		/* But if we are not restarting, this is not OK */
+		WARN_ON(!mld->fw_status.in_hw_restart);
+
+		/* Avoid adding a STA that is already in FW to avoid an assert */
+		if (WARN_ON(mld_link_sta->in_fw))
+			return -EINVAL;
+
+		fw_id = mld_link_sta->fw_id;
+		goto add_to_fw;
+	}
+
+	/* Allocate a fw id and map it to the link_sta */
+	ret = iwl_mld_allocate_link_sta_fw_id(mld, &fw_id, link_sta);
+	if (ret)
+		return ret;
+
+	if (link_sta == &link_sta->sta->deflink) {
+		mld_link_sta = &mld_sta->deflink;
+	} else {
+		mld_link_sta = kzalloc(sizeof(*mld_link_sta), GFP_KERNEL);
+		if (!mld_link_sta)
+			return -ENOMEM;
+	}
+
+	mld_link_sta->fw_id = fw_id;
+	rcu_assign_pointer(mld_sta->link[link_sta->link_id], mld_link_sta);
+
+add_to_fw:
+	ret = iwl_mld_add_modify_sta_cmd(mld, link_sta);
+	if (ret) {
+		RCU_INIT_POINTER(mld->fw_id_to_link_sta[fw_id], NULL);
+		RCU_INIT_POINTER(mld_sta->link[link_sta->link_id], NULL);
+		if (link_sta != &link_sta->sta->deflink)
+			kfree(mld_link_sta);
+		return ret;
+	}
+	mld_link_sta->in_fw = true;
+
+	return 0;
+}
+
+static int iwl_mld_rm_sta_from_fw(struct iwl_mld *mld, u8 fw_sta_id)
+{
+	struct iwl_remove_sta_cmd cmd = {
+		.sta_id = cpu_to_le32(fw_sta_id),
+	};
+	int ret;
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(MAC_CONF_GROUP, STA_REMOVE_CMD),
+				   &cmd);
+	if (ret)
+		IWL_ERR(mld, "Failed to remove station. Id=%d\n", fw_sta_id);
+
+	return ret;
+}
+
+static void
+iwl_mld_remove_link_sta(struct iwl_mld *mld,
+			struct ieee80211_link_sta *link_sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
+	struct iwl_mld_link_sta *mld_link_sta =
+		iwl_mld_link_sta_from_mac80211(link_sta);
+
+	if (WARN_ON(!mld_link_sta))
+		return;
+
+	iwl_mld_rm_sta_from_fw(mld, mld_link_sta->fw_id);
+	mld_link_sta->in_fw = false;
+
+	/* Now that the STA doesn't exist in FW, we don't expect any new
+	 * notifications for it. Cancel the ones that are already pending
+	 */
+	iwl_mld_cancel_notifications_of_object(mld, IWL_MLD_OBJECT_TYPE_STA,
+					       mld_link_sta->fw_id);
+
+	/* This will not be done upon reconfig, so do it also when
+	 * failed to remove from fw
+	 */
+	RCU_INIT_POINTER(mld->fw_id_to_link_sta[mld_link_sta->fw_id], NULL);
+	RCU_INIT_POINTER(mld_sta->link[link_sta->link_id], NULL);
+	if (mld_link_sta != &mld_sta->deflink)
+		kfree_rcu(mld_link_sta, rcu_head);
+}
+
+int iwl_mld_update_all_link_stations(struct iwl_mld *mld,
+				     struct ieee80211_sta *sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
+	int link_id;
+
+	for_each_sta_active_link(mld_sta->vif, sta, link_sta, link_id) {
+		int ret = iwl_mld_add_modify_sta_cmd(mld, link_sta);
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static void iwl_mld_destroy_sta(struct ieee80211_sta *sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+
+	kfree(mld_sta->dup_data);
+	kfree(mld_sta->mpdu_counters);
+}
+
+static int
+iwl_mld_alloc_dup_data(struct iwl_mld *mld, struct iwl_mld_sta *mld_sta)
+{
+	struct iwl_mld_rxq_dup_data *dup_data;
+
+	if (mld->fw_status.in_hw_restart)
+		return 0;
+
+	dup_data = kcalloc(mld->trans->num_rx_queues, sizeof(*dup_data),
+			   GFP_KERNEL);
+	if (!dup_data)
+		return -ENOMEM;
+
+	/* Initialize all the last_seq values to 0xffff which can never
+	 * compare equal to the frame's seq_ctrl in the check in
+	 * iwl_mld_is_dup() since the lower 4 bits are the fragment
+	 * number and fragmented packets don't reach that function.
+	 *
+	 * This thus allows receiving a packet with seqno 0 and the
+	 * retry bit set as the very first packet on a new TID.
+	 */
+	for (int q = 0; q < mld->trans->num_rx_queues; q++)
+		memset(dup_data[q].last_seq, 0xff,
+		       sizeof(dup_data[q].last_seq));
+	mld_sta->dup_data = dup_data;
+
+	return 0;
+}
+
+static void iwl_mld_alloc_mpdu_counters(struct iwl_mld *mld,
+					struct ieee80211_sta *sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct ieee80211_vif *vif = mld_sta->vif;
+
+	if (mld->fw_status.in_hw_restart)
+		return;
+
+	/* MPDUs are counted only when EMLSR is possible */
+	if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION ||
+	    sta->tdls || !ieee80211_vif_is_mld(vif))
+		return;
+
+	mld_sta->mpdu_counters = kcalloc(mld->trans->num_rx_queues,
+					 sizeof(*mld_sta->mpdu_counters),
+					 GFP_KERNEL);
+	if (!mld_sta->mpdu_counters)
+		return;
+
+	for (int q = 0; q < mld->trans->num_rx_queues; q++)
+		spin_lock_init(&mld_sta->mpdu_counters[q].lock);
+}
+
+static int
+iwl_mld_init_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
+		 struct ieee80211_vif *vif, enum iwl_fw_sta_type type)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+
+	mld_sta->vif = vif;
+	mld_sta->sta_type = type;
+	mld_sta->mld = mld;
+
+	if (!mld->fw_status.in_hw_restart)
+		for (int i = 0; i < ARRAY_SIZE(sta->txq); i++)
+			iwl_mld_init_txq(iwl_mld_txq_from_mac80211(sta->txq[i]));
+
+	iwl_mld_alloc_mpdu_counters(mld, sta);
+
+	iwl_mld_toggle_tx_ant(mld, &mld_sta->data_tx_ant);
+
+	return iwl_mld_alloc_dup_data(mld, mld_sta);
+}
+
+int iwl_mld_add_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
+		    struct ieee80211_vif *vif, enum iwl_fw_sta_type type)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
+	int link_id;
+	int ret;
+
+	ret = iwl_mld_init_sta(mld, sta, vif, type);
+	if (ret)
+		return ret;
+
+	/* We could have add only the deflink link_sta, but it will not work
+	 * in the restart case if the single link that is active during
+	 * reconfig is not the deflink one.
+	 */
+	for_each_sta_active_link(mld_sta->vif, sta, link_sta, link_id) {
+		ret = iwl_mld_add_link_sta(mld, link_sta);
+		if (ret)
+			goto destroy_sta;
+	}
+
+	return 0;
+
+destroy_sta:
+	iwl_mld_destroy_sta(sta);
+
+	return ret;
+}
+
+void iwl_mld_flush_sta_txqs(struct iwl_mld *mld, struct ieee80211_sta *sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
+	int link_id;
+
+	for_each_sta_active_link(mld_sta->vif, sta, link_sta, link_id) {
+		int fw_sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
+
+		if (fw_sta_id < 0)
+			continue;
+
+		iwl_mld_flush_link_sta_txqs(mld, fw_sta_id);
+	}
+}
+
+void iwl_mld_wait_sta_txqs_empty(struct iwl_mld *mld, struct ieee80211_sta *sta)
+{
+	/* Avoid a warning in iwl_trans_wait_txq_empty if are anyway on the way
+	 * to a restart.
+	 */
+	if (iwl_mld_error_before_recovery(mld))
+		return;
+
+	for (int i = 0; i < ARRAY_SIZE(sta->txq); i++) {
+		struct iwl_mld_txq *mld_txq =
+			iwl_mld_txq_from_mac80211(sta->txq[i]);
+
+		if (!mld_txq->status.allocated)
+			continue;
+
+		iwl_trans_wait_txq_empty(mld->trans, mld_txq->fw_id);
+	}
+}
+
+void iwl_mld_remove_sta(struct iwl_mld *mld, struct ieee80211_sta *sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct ieee80211_vif *vif = mld_sta->vif;
+	struct ieee80211_link_sta *link_sta;
+	u8 link_id;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* Tell the HW to flush the queues */
+	iwl_mld_flush_sta_txqs(mld, sta);
+
+	/* Wait for trans to empty its queues */
+	iwl_mld_wait_sta_txqs_empty(mld, sta);
+
+	/* Now we can remove the queues */
+	for (int i = 0; i < ARRAY_SIZE(sta->txq); i++)
+		iwl_mld_remove_txq(mld, sta->txq[i]);
+
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		/* Mac8011 will remove the groupwise keys after the sta is
+		 * removed, but FW expects all the keys to be removed before
+		 * the STA is, so remove them all here.
+		 */
+		if (vif->type == NL80211_IFTYPE_STATION)
+			iwl_mld_remove_ap_keys(mld, vif, sta, link_id);
+
+		/* Remove the link_sta */
+		iwl_mld_remove_link_sta(mld, link_sta);
+	}
+
+	iwl_mld_destroy_sta(sta);
+}
+
+u32 iwl_mld_fw_sta_id_mask(struct iwl_mld *mld, struct ieee80211_sta *sta)
+{
+	struct ieee80211_vif *vif = iwl_mld_sta_from_mac80211(sta)->vif;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
+	u32 result = 0;
+
+	KUNIT_STATIC_STUB_REDIRECT(iwl_mld_fw_sta_id_mask, mld, sta);
+
+	/* This function should only be used with the wiphy lock held,
+	 * In other cases, it is not guaranteed that the link_sta will exist
+	 * in the driver too, and it is checked in
+	 * iwl_mld_fw_sta_id_from_link_sta.
+	 */
+	lockdep_assert_wiphy(mld->wiphy);
+
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		int fw_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
+
+		if (!(fw_id < 0))
+			result |= BIT(fw_id);
+	}
+
+	return result;
+}
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_fw_sta_id_mask);
+
+static void iwl_mld_count_mpdu(struct ieee80211_link_sta *link_sta, int queue,
+			       u32 count, bool tx)
+{
+	struct iwl_mld_per_q_mpdu_counter *queue_counter;
+	struct iwl_mld_per_link_mpdu_counter *link_counter;
+	struct iwl_mld_vif *mld_vif;
+	struct iwl_mld_sta *mld_sta;
+	struct iwl_mld_link *mld_link;
+	struct iwl_mld *mld;
+	int total_mpdus = 0;
+
+	if (WARN_ON(!link_sta))
+		return;
+
+	mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
+	if (!mld_sta->mpdu_counters)
+		return;
+
+	mld_vif = iwl_mld_vif_from_mac80211(mld_sta->vif);
+	mld_link = iwl_mld_link_dereference_check(mld_vif, link_sta->link_id);
+
+	if (WARN_ON_ONCE(!mld_link))
+		return;
+
+	queue_counter = &mld_sta->mpdu_counters[queue];
+
+	mld = mld_vif->mld;
+
+	/* If it the window is over, first clear the counters.
+	 * When we are not blocked by TPT, the window is managed by check_tpt_wk
+	 */
+	if ((mld_vif->emlsr.blocked_reasons & IWL_MLD_EMLSR_BLOCKED_TPT) &&
+	    time_is_before_jiffies(queue_counter->window_start_time +
+					IWL_MLD_TPT_COUNT_WINDOW)) {
+		memset(queue_counter->per_link, 0,
+		       sizeof(queue_counter->per_link));
+		queue_counter->window_start_time = jiffies;
+
+		IWL_DEBUG_INFO(mld, "MPDU counters are cleared\n");
+	}
+
+	link_counter = &queue_counter->per_link[mld_link->fw_id];
+
+	spin_lock_bh(&queue_counter->lock);
+
+	/* Update the statistics for this TPT measurement window */
+	if (tx)
+		link_counter->tx += count;
+	else
+		link_counter->rx += count;
+
+	/*
+	 * Next, evaluate whether we should queue an unblock,
+	 * skip this if we are not blocked due to low throughput.
+	 */
+	if (!(mld_vif->emlsr.blocked_reasons & IWL_MLD_EMLSR_BLOCKED_TPT))
+		goto unlock;
+
+	for (int i = 0; i <= IWL_FW_MAX_LINK_ID; i++)
+		total_mpdus += tx ? queue_counter->per_link[i].tx :
+				    queue_counter->per_link[i].rx;
+
+	/* Unblock is already queued if the threshold was reached before */
+	if (total_mpdus - count >= IWL_MLD_ENTER_EMLSR_TPT_THRESH)
+		goto unlock;
+
+	if (total_mpdus >= IWL_MLD_ENTER_EMLSR_TPT_THRESH)
+		wiphy_work_queue(mld->wiphy, &mld_vif->emlsr.unblock_tpt_wk);
+
+unlock:
+	spin_unlock_bh(&queue_counter->lock);
+}
+
+/* must be called under rcu_read_lock() */
+void iwl_mld_count_mpdu_rx(struct ieee80211_link_sta *link_sta, int queue,
+			   u32 count)
+{
+	iwl_mld_count_mpdu(link_sta, queue, count, false);
+}
+
+/* must be called under rcu_read_lock() */
+void iwl_mld_count_mpdu_tx(struct ieee80211_link_sta *link_sta, u32 count)
+{
+	/* use queue 0 for all TX */
+	iwl_mld_count_mpdu(link_sta, 0, count, true);
+}
+
+static int iwl_mld_allocate_internal_txq(struct iwl_mld *mld,
+					 struct iwl_mld_int_sta *internal_sta,
+					 u8 tid)
+{
+	u32 sta_mask = BIT(internal_sta->sta_id);
+	int queue, size;
+
+	size = max_t(u32, IWL_MGMT_QUEUE_SIZE,
+		     mld->trans->cfg->min_txq_size);
+
+	queue = iwl_trans_txq_alloc(mld->trans, 0, sta_mask, tid, size,
+				    IWL_WATCHDOG_DISABLED);
+
+	if (queue >= 0)
+		IWL_DEBUG_TX_QUEUES(mld,
+				    "Enabling TXQ #%d for sta mask 0x%x tid %d\n",
+				    queue, sta_mask, tid);
+	return queue;
+}
+
+static int iwl_mld_send_aux_sta_cmd(struct iwl_mld *mld,
+				    const struct iwl_mld_int_sta *internal_sta)
+{
+	struct iwl_aux_sta_cmd cmd = {
+		.sta_id = cpu_to_le32(internal_sta->sta_id),
+		/* TODO: CDB - properly set the lmac_id */
+		.lmac_id = cpu_to_le32(IWL_LMAC_24G_INDEX),
+	};
+
+	return iwl_mld_send_cmd_pdu(mld, WIDE_ID(MAC_CONF_GROUP, AUX_STA_CMD),
+				    &cmd);
+}
+
+static int
+iwl_mld_add_internal_sta_to_fw(struct iwl_mld *mld,
+			       const struct iwl_mld_int_sta *internal_sta,
+			       u8 fw_link_id,
+			       const u8 *addr)
+{
+	struct iwl_sta_cfg_cmd cmd = {};
+
+	if (internal_sta->sta_type == STATION_TYPE_AUX)
+		return iwl_mld_send_aux_sta_cmd(mld, internal_sta);
+
+	cmd.sta_id = cpu_to_le32((u8)internal_sta->sta_id);
+	cmd.link_id = cpu_to_le32(fw_link_id);
+	cmd.station_type = cpu_to_le32(internal_sta->sta_type);
+
+	/* FW doesn't allow to add a IGTK/BIGTK if the sta isn't marked as MFP.
+	 * On the other hand, FW will never check this flag during RX since
+	 * an AP/GO doesn't receive protected broadcast management frames.
+	 * So, we can set it unconditionally.
+	 */
+	if (internal_sta->sta_type == STATION_TYPE_BCAST_MGMT)
+		cmd.mfp = cpu_to_le32(1);
+
+	if (addr) {
+		memcpy(cmd.peer_mld_address, addr, ETH_ALEN);
+		memcpy(cmd.peer_link_address, addr, ETH_ALEN);
+	}
+
+	return iwl_mld_send_sta_cmd(mld, &cmd);
+}
+
+static int iwl_mld_add_internal_sta(struct iwl_mld *mld,
+				    struct iwl_mld_int_sta *internal_sta,
+				    enum iwl_fw_sta_type sta_type,
+				    u8 fw_link_id, const u8 *addr, u8 tid)
+{
+	int ret, queue_id;
+
+	ret = iwl_mld_allocate_link_sta_fw_id(mld,
+					      &internal_sta->sta_id,
+					      ERR_PTR(-EINVAL));
+	if (ret)
+		return ret;
+
+	internal_sta->sta_type = sta_type;
+
+	ret = iwl_mld_add_internal_sta_to_fw(mld, internal_sta, fw_link_id,
+					     addr);
+	if (ret)
+		goto err;
+
+	queue_id = iwl_mld_allocate_internal_txq(mld, internal_sta, tid);
+	if (queue_id < 0) {
+		iwl_mld_rm_sta_from_fw(mld, internal_sta->sta_id);
+		ret = queue_id;
+		goto err;
+	}
+
+	internal_sta->queue_id = queue_id;
+
+	return 0;
+err:
+	iwl_mld_free_internal_sta(mld, internal_sta);
+	return ret;
+}
+
+int iwl_mld_add_bcast_sta(struct iwl_mld *mld,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	const u8 bcast_addr[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+	const u8 *addr;
+
+	if (WARN_ON(!mld_link))
+		return -EINVAL;
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_AP &&
+		    vif->type != NL80211_IFTYPE_ADHOC))
+		return -EINVAL;
+
+	addr = vif->type == NL80211_IFTYPE_ADHOC ? link->bssid : bcast_addr;
+
+	return iwl_mld_add_internal_sta(mld, &mld_link->bcast_sta,
+					STATION_TYPE_BCAST_MGMT,
+					mld_link->fw_id, addr,
+					IWL_MGMT_TID);
+}
+
+int iwl_mld_add_mcast_sta(struct iwl_mld *mld,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+	const u8 mcast_addr[] = {0x03, 0x00, 0x00, 0x00, 0x00, 0x00};
+
+	if (WARN_ON(!mld_link))
+		return -EINVAL;
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_AP &&
+		    vif->type != NL80211_IFTYPE_ADHOC))
+		return -EINVAL;
+
+	return iwl_mld_add_internal_sta(mld, &mld_link->mcast_sta,
+					STATION_TYPE_MCAST,
+					mld_link->fw_id, mcast_addr, 0);
+}
+
+int iwl_mld_add_aux_sta(struct iwl_mld *mld,
+			struct iwl_mld_int_sta *internal_sta)
+{
+	return iwl_mld_add_internal_sta(mld, internal_sta, STATION_TYPE_AUX,
+					0, NULL, IWL_MAX_TID_COUNT);
+}
+
+static void iwl_mld_remove_internal_sta(struct iwl_mld *mld,
+					struct iwl_mld_int_sta *internal_sta,
+					bool flush, u8 tid)
+{
+	if (WARN_ON_ONCE(internal_sta->sta_id == IWL_INVALID_STA ||
+			 internal_sta->queue_id == IWL_MLD_INVALID_QUEUE))
+		return;
+
+	if (flush)
+		iwl_mld_flush_link_sta_txqs(mld, internal_sta->sta_id);
+
+	iwl_mld_free_txq(mld, BIT(internal_sta->sta_id),
+			 tid, internal_sta->queue_id);
+
+	iwl_mld_rm_sta_from_fw(mld, internal_sta->sta_id);
+
+	iwl_mld_free_internal_sta(mld, internal_sta);
+}
+
+void iwl_mld_remove_bcast_sta(struct iwl_mld *mld,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+
+	if (WARN_ON(!mld_link))
+		return;
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_AP &&
+		    vif->type != NL80211_IFTYPE_ADHOC))
+		return;
+
+	iwl_mld_remove_internal_sta(mld, &mld_link->bcast_sta, true,
+				    IWL_MGMT_TID);
+}
+
+void iwl_mld_remove_mcast_sta(struct iwl_mld *mld,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+
+	if (WARN_ON(!mld_link))
+		return;
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_AP &&
+		    vif->type != NL80211_IFTYPE_ADHOC))
+		return;
+
+	iwl_mld_remove_internal_sta(mld, &mld_link->mcast_sta, true, 0);
+}
+
+void iwl_mld_remove_aux_sta(struct iwl_mld *mld,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
+
+	if (WARN_ON(!mld_link))
+		return;
+
+	/* TODO: Hotspot 2.0 */
+	if (WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE))
+		return;
+
+	iwl_mld_remove_internal_sta(mld, &mld_link->aux_sta, false,
+				    IWL_MAX_TID_COUNT);
+}
+
+static int iwl_mld_update_sta_resources(struct iwl_mld *mld,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					u32 old_sta_mask,
+					u32 new_sta_mask)
+{
+	int ret;
+
+	ret = iwl_mld_update_sta_txqs(mld, sta, old_sta_mask, new_sta_mask);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_update_sta_keys(mld, vif, sta, old_sta_mask, new_sta_mask);
+	if (ret)
+		return ret;
+
+	return iwl_mld_update_sta_baids(mld, old_sta_mask, new_sta_mask);
+}
+
+int iwl_mld_update_link_stas(struct iwl_mld *mld,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta,
+			     u16 old_links, u16 new_links)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct iwl_mld_link_sta *mld_link_sta;
+	unsigned long links_to_add = ~old_links & new_links;
+	unsigned long links_to_rem = old_links & ~new_links;
+	unsigned long old_links_long = old_links;
+	unsigned long sta_mask_added = 0;
+	u32 current_sta_mask = 0, sta_mask_to_rem = 0;
+	unsigned int link_id, sta_id;
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	for_each_set_bit(link_id, &old_links_long,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		mld_link_sta =
+			iwl_mld_link_sta_dereference_check(mld_sta, link_id);
+
+		if (WARN_ON(!mld_link_sta))
+			return -EINVAL;
+
+		current_sta_mask |= BIT(mld_link_sta->fw_id);
+		if (links_to_rem & BIT(link_id))
+			sta_mask_to_rem |= BIT(mld_link_sta->fw_id);
+	}
+
+	if (sta_mask_to_rem) {
+		ret = iwl_mld_update_sta_resources(mld, vif, sta,
+						   current_sta_mask,
+						   current_sta_mask &
+							~sta_mask_to_rem);
+		if (ret)
+			return ret;
+
+		current_sta_mask &= ~sta_mask_to_rem;
+	}
+
+	for_each_set_bit(link_id, &links_to_rem, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta =
+			link_sta_dereference_protected(sta, link_id);
+
+		if (WARN_ON(!link_sta))
+			return -EINVAL;
+
+		iwl_mld_remove_link_sta(mld, link_sta);
+	}
+
+	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta =
+			link_sta_dereference_protected(sta, link_id);
+		struct ieee80211_bss_conf *link;
+
+		if (WARN_ON(!link_sta))
+			return -EINVAL;
+
+		ret = iwl_mld_add_link_sta(mld, link_sta);
+		if (ret)
+			goto remove_added_link_stas;
+
+		mld_link_sta =
+			iwl_mld_link_sta_dereference_check(mld_sta,
+							   link_id);
+
+		link = link_conf_dereference_protected(mld_sta->vif,
+						       link_sta->link_id);
+		iwl_mld_config_tlc_link(mld, vif, link, link_sta);
+
+		sta_mask_added |= BIT(mld_link_sta->fw_id);
+	}
+
+	if (sta_mask_added) {
+		ret = iwl_mld_update_sta_resources(mld, vif, sta,
+						   current_sta_mask,
+						   current_sta_mask |
+							sta_mask_added);
+		if (ret)
+			goto remove_added_link_stas;
+	}
+
+	/* We couldn't activate the links before it has a STA. Now we can */
+	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link =
+			link_conf_dereference_protected(mld_sta->vif, link_id);
+
+		if (WARN_ON(!link))
+			continue;
+
+		iwl_mld_activate_link(mld, link);
+	}
+
+	return 0;
+
+remove_added_link_stas:
+	for_each_set_bit(sta_id, &sta_mask_added, mld->fw->ucode_capa.num_stations) {
+		struct ieee80211_link_sta *link_sta =
+			wiphy_dereference(mld->wiphy,
+					  mld->fw_id_to_link_sta[sta_id]);
+
+		if (WARN_ON(!link_sta))
+			continue;
+
+		iwl_mld_remove_link_sta(mld, link_sta);
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
new file mode 100644
index 000000000000..63809b0d4132
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#ifndef __iwl_mld_sta_h__
+#define __iwl_mld_sta_h__
+
+#include <net/mac80211.h>
+
+#include "mld.h"
+#include "tx.h"
+
+/**
+ * struct iwl_mld_rxq_dup_data - Duplication detection data, per STA & Rx queue
+ * @last_seq: last sequence per tid.
+ * @last_sub_frame_idx: the index of the last subframe in an A-MSDU. This value
+ *	will be zero if the packet is not part of an A-MSDU.
+ */
+struct iwl_mld_rxq_dup_data {
+	__le16 last_seq[IWL_MAX_TID_COUNT + 1];
+	u8 last_sub_frame_idx[IWL_MAX_TID_COUNT + 1];
+} ____cacheline_aligned_in_smp;
+
+/**
+ * struct iwl_mld_link_sta - link-level station
+ *
+ * This represents the link-level sta - the driver level equivalent to the
+ * ieee80211_link_sta
+ *
+ * @last_rate_n_flags: rate_n_flags from the last &iwl_tlc_update_notif
+ * @signal_avg: the signal average coming from the firmware
+ * @in_fw: whether the link STA is uploaded to the FW (false during restart)
+ * @rcu_head: RCU head for freeing this object
+ * @fw_id: the FW id of this link sta.
+ */
+struct iwl_mld_link_sta {
+	/* Add here fields that need clean up on restart */
+	struct_group(zeroed_on_hw_restart,
+		u32 last_rate_n_flags;
+		bool in_fw;
+		s8 signal_avg;
+	);
+	/* And here fields that survive a fw restart */
+	struct rcu_head rcu_head;
+	u32 fw_id;
+};
+
+#define iwl_mld_link_sta_dereference_check(mld_sta, link_id)		\
+	rcu_dereference_check((mld_sta)->link[link_id],			\
+			      lockdep_is_held(&mld_sta->mld->wiphy->mtx))
+
+#define for_each_mld_link_sta(mld_sta, link_sta, link_id)		\
+	for (link_id = 0; link_id < ARRAY_SIZE((mld_sta)->link);	\
+	     link_id++)							\
+		if ((link_sta =						\
+			iwl_mld_link_sta_dereference_check(mld_sta, link_id)))
+
+#define IWL_NUM_DEFAULT_KEYS 4
+
+/* struct iwl_mld_ptk_pn - Holds Packet Number (PN) per TID.
+ * @rcu_head: RCU head for freeing this data.
+ * @pn: Array storing PN for each TID.
+ */
+struct iwl_mld_ptk_pn {
+	struct rcu_head rcu_head;
+	struct {
+		u8 pn[IWL_MAX_TID_COUNT][IEEE80211_CCMP_PN_LEN];
+	} ____cacheline_aligned_in_smp q[];
+};
+
+/**
+ * struct iwl_mld_per_link_mpdu_counter - per-link TX/RX MPDU counters
+ *
+ * @tx: Number of TX MPDUs.
+ * @rx: Number of RX MPDUs.
+ */
+struct iwl_mld_per_link_mpdu_counter {
+	u32 tx;
+	u32 rx;
+};
+
+/**
+ * struct iwl_mld_per_q_mpdu_counter - per-queue MPDU counter
+ *
+ * @lock: Needed to protect the counters when modified from statistics.
+ * @per_link: per-link counters.
+ * @window_start_time: timestamp of the counting-window start
+ */
+struct iwl_mld_per_q_mpdu_counter {
+	spinlock_t lock;
+	struct iwl_mld_per_link_mpdu_counter per_link[IWL_FW_MAX_LINK_ID + 1];
+	unsigned long window_start_time;
+} ____cacheline_aligned_in_smp;
+
+/**
+ * struct iwl_mld_sta - representation of a station in the driver.
+ *
+ * This represent the MLD-level sta, and will not be added to the FW.
+ * Embedded in ieee80211_sta.
+ *
+ * @vif: pointer the vif object.
+ * @sta_state: station state according to enum %ieee80211_sta_state
+ * @sta_type: type of this station. See &enum iwl_fw_sta_type
+ * @mld: a pointer to the iwl_mld object
+ * @dup_data: per queue duplicate packet detection data
+ * @data_tx_ant: stores the last TX antenna index; used for setting
+ *	TX rate_n_flags for injected data frames (toggles on every TX failure).
+ * @tid_to_baid: a simple map of TID to Block-Ack fw id
+ * @deflink: This holds the default link STA information, for non MLO STA all
+ *	link specific STA information is accessed through @deflink or through
+ *	link[0] which points to address of @deflink. For MLO Link STA
+ *	the first added link STA will point to deflink.
+ * @link: reference to Link Sta entries. For Non MLO STA, except 1st link,
+ *	i.e link[0] all links would be assigned to NULL by default and
+ *	would access link information via @deflink or link[0]. For MLO
+ *	STA, first link STA being added will point its link pointer to
+ *	@deflink address and remaining would be allocated and the address
+ *	would be assigned to link[link_id] where link_id is the id assigned
+ *	by the AP.
+ * @ptk_pn: Array of pointers to PTK PN data, used to track the Packet Number
+ *	per key index and per queue (TID).
+ * @mpdu_counters: RX/TX MPDUs counters for each queue.
+ */
+struct iwl_mld_sta {
+	/* Add here fields that need clean up on restart */
+	struct_group(zeroed_on_hw_restart,
+		enum ieee80211_sta_state sta_state;
+		enum iwl_fw_sta_type sta_type;
+	);
+	/* And here fields that survive a fw restart */
+	struct iwl_mld *mld;
+	struct ieee80211_vif *vif;
+	struct iwl_mld_rxq_dup_data *dup_data;
+	u8 tid_to_baid[IWL_MAX_TID_COUNT];
+	u8 data_tx_ant;
+
+	struct iwl_mld_link_sta deflink;
+	struct iwl_mld_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
+	struct iwl_mld_ptk_pn __rcu *ptk_pn[IWL_NUM_DEFAULT_KEYS];
+	struct iwl_mld_per_q_mpdu_counter *mpdu_counters;
+};
+
+static inline struct iwl_mld_sta *
+iwl_mld_sta_from_mac80211(struct ieee80211_sta *sta)
+{
+	return (void *)sta->drv_priv;
+}
+
+static inline void
+iwl_mld_cleanup_sta(void *data, struct ieee80211_sta *sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct iwl_mld_link_sta *mld_link_sta;
+	u8 link_id;
+
+	for (int i = 0; i < ARRAY_SIZE(sta->txq); i++)
+		CLEANUP_STRUCT(iwl_mld_txq_from_mac80211(sta->txq[i]));
+
+	for_each_mld_link_sta(mld_sta, mld_link_sta, link_id) {
+		CLEANUP_STRUCT(mld_link_sta);
+
+		if (!ieee80211_vif_is_mld(mld_sta->vif)) {
+			/* not an MLD STA; only has the deflink with ID zero */
+			WARN_ON(link_id);
+			continue;
+		}
+
+		if (mld_sta->vif->active_links & BIT(link_id))
+			continue;
+
+		/* Should not happen as link removal should always succeed */
+		WARN_ON(1);
+		RCU_INIT_POINTER(mld_sta->link[link_id], NULL);
+		RCU_INIT_POINTER(mld_sta->mld->fw_id_to_link_sta[mld_link_sta->fw_id],
+				 NULL);
+		if (mld_link_sta != &mld_sta->deflink)
+			kfree_rcu(mld_link_sta, rcu_head);
+	}
+
+	CLEANUP_STRUCT(mld_sta);
+}
+
+static inline struct iwl_mld_link_sta *
+iwl_mld_link_sta_from_mac80211(struct ieee80211_link_sta *link_sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
+
+	return iwl_mld_link_sta_dereference_check(mld_sta, link_sta->link_id);
+}
+
+int iwl_mld_add_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
+		    struct ieee80211_vif *vif, enum iwl_fw_sta_type type);
+void iwl_mld_remove_sta(struct iwl_mld *mld, struct ieee80211_sta *sta);
+int iwl_mld_fw_sta_id_from_link_sta(struct iwl_mld *mld,
+				    struct ieee80211_link_sta *link_sta);
+u32 iwl_mld_fw_sta_id_mask(struct iwl_mld *mld, struct ieee80211_sta *sta);
+int iwl_mld_update_all_link_stations(struct iwl_mld *mld,
+				     struct ieee80211_sta *sta);
+void iwl_mld_flush_sta_txqs(struct iwl_mld *mld, struct ieee80211_sta *sta);
+void iwl_mld_wait_sta_txqs_empty(struct iwl_mld *mld,
+				 struct ieee80211_sta *sta);
+void iwl_mld_count_mpdu_rx(struct ieee80211_link_sta *link_sta, int queue,
+			   u32 count);
+void iwl_mld_count_mpdu_tx(struct ieee80211_link_sta *link_sta, u32 count);
+
+/**
+ * struct iwl_mld_int_sta - representation of an internal station
+ * (a station that exist in FW and in driver, but not in mac80211)
+ *
+ * @sta_id: the index of the station in the fw
+ * @queue_id: the if of the queue used by the station
+ * @sta_type: station type. One of &iwl_fw_sta_type
+ */
+struct iwl_mld_int_sta {
+	u8 sta_id;
+	u32 queue_id;
+	enum iwl_fw_sta_type sta_type;
+};
+
+static inline void
+iwl_mld_init_internal_sta(struct iwl_mld_int_sta *internal_sta)
+{
+	internal_sta->sta_id = IWL_INVALID_STA;
+	internal_sta->queue_id = IWL_MLD_INVALID_QUEUE;
+}
+
+static inline void
+iwl_mld_free_internal_sta(struct iwl_mld *mld,
+			  struct iwl_mld_int_sta *internal_sta)
+{
+	if (WARN_ON(internal_sta->sta_id == IWL_INVALID_STA))
+		return;
+
+	RCU_INIT_POINTER(mld->fw_id_to_link_sta[internal_sta->sta_id], NULL);
+	iwl_mld_init_internal_sta(internal_sta);
+}
+
+int iwl_mld_add_bcast_sta(struct iwl_mld *mld,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link);
+
+int iwl_mld_add_mcast_sta(struct iwl_mld *mld,
+			  struct ieee80211_vif *vif,
+			  struct ieee80211_bss_conf *link);
+
+int iwl_mld_add_aux_sta(struct iwl_mld *mld,
+			struct iwl_mld_int_sta *internal_sta);
+
+void iwl_mld_remove_bcast_sta(struct iwl_mld *mld,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link);
+
+void iwl_mld_remove_mcast_sta(struct iwl_mld *mld,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link);
+
+void iwl_mld_remove_aux_sta(struct iwl_mld *mld,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link);
+
+int iwl_mld_update_link_stas(struct iwl_mld *mld,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta,
+			     u16 old_links, u16 new_links);
+#endif /* __iwl_mld_sta_h__ */
-- 
2.34.1


