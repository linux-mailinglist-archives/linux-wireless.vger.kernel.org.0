Return-Path: <linux-wireless+bounces-28057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E85D7BEE0E6
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF43034A817
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE626F296;
	Sun, 19 Oct 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pfa6lnHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFCC22A1D4
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863535; cv=none; b=GX7I1F0DR28AWulSzZqmeoahdVw7QgyPvHG3dMro6uwf9FXBc0I1FN2bY+/x32HnVZyFVLi97liGd99kRa7OD4jKsywlGAx8sYpOiBQcS2DZNUqpb64gRlLpvMjpkyOBI8KPYEC8WW4wxOmIut8Q2fLDrnC+wMCCFeRDXTBwyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863535; c=relaxed/simple;
	bh=FCi22Zsq9MLZrFnpv4BvdiUrhvo9fj523/GxvjUWeto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZShPfis5GLpJ7uDcMwUOMl30DsSD0ozeb4b3Yb7xlPYuTeVyodCkf5VP+tGpqb/qMnlqOfELZ+ZR6nxCYpR8O3sjbL+4BnrG4c0oNYMwPx1hwmPtqeOl1jSW+Bk5pq/0w/4yjgcQ3e8MtUcQQXen6p8JK/Z5VCJQ0UFrO91Srk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pfa6lnHm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863531; x=1792399531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FCi22Zsq9MLZrFnpv4BvdiUrhvo9fj523/GxvjUWeto=;
  b=Pfa6lnHm3QseeMiLHG+LP+ujon7slbfm3B+Bjo+dLSyjlssVx9IMhK8Q
   Yjt2vizev4CauDt+ol6vmuMPTXbcAN6yw/K1PHy5NJXCoN3bazenL/ywS
   3Tk6AVvl5nnw+KjxKBktA5IgGAxeYV7GCe6ajoIbUIcrYebWEVhSt8UFG
   NuVURUq23P40ldJ4ciSZtP32IHlo2DJQKLHx1pkdrsPFazqRvG496ARPI
   3ogjAehOcXsJqdUOQWH5vT7ghkUVaL1hLCuVDLJQZta7SkhPS4+hTVI1N
   V/zBf8r9RZlG50f4EXU22coUz/LPprQC8BXt8uHrchBNWNIUSwrEpmifz
   Q==;
X-CSE-ConnectionGUID: Id75hXvRT2qRlezp5VuV5w==
X-CSE-MsgGUID: 4CYRTaA1SFqReu4YmY8ZUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363179"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363179"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:30 -0700
X-CSE-ConnectionGUID: UUBisAtoSJGUsZux3wgKJg==
X-CSE-MsgGUID: 7OKUZpYWRQ+2Ryr93jZkdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279855"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: update to new sniffer API
Date: Sun, 19 Oct 2025 11:45:02 +0300
Message-Id: <20251019114304.85b75a084a2f.I4a18b2043703c1f9a8f55c108dcaaeca7891e19c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This will break current sniffer functionality for firmware
versions that don't have the new API, but supporting both
would be very complex. Convert the code to use only the new
sniffer notification.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |    5 +
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  286 +++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |    1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   10 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   | 1649 +++++++++--------
 drivers/net/wireless/intel/iwlwifi/mld/rx.h   |    5 +-
 8 files changed, 1171 insertions(+), 795 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index b1c6ee8ae2df..6a6e11a57dbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -123,6 +123,11 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	BEACON_FILTER_IN_NOTIF = 0xF8,
 
+	/**
+	 * @PHY_AIR_SNIFFER_NOTIF: &struct iwl_rx_phy_air_sniffer_ntfy
+	 */
+	PHY_AIR_SNIFFER_NOTIF = 0xF9,
+
 	/**
 	 * @STA_PM_NOTIF: &struct iwl_mvm_pm_state_notification
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index d751789998ac..3ed7e0807b90 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -262,6 +262,7 @@ enum iwl_rx_mpdu_reorder_data {
 };
 
 enum iwl_rx_mpdu_phy_info {
+	IWL_RX_MPDU_PHY_EOF_INDICATION	= BIT(0),
 	IWL_RX_MPDU_PHY_AMPDU		= BIT(5),
 	IWL_RX_MPDU_PHY_AMPDU_TOGGLE	= BIT(6),
 	IWL_RX_MPDU_PHY_SHORT_PREAMBLE	= BIT(7),
@@ -1041,4 +1042,289 @@ struct iwl_beacon_filter_notif {
 	__le32 link_id;
 } __packed; /* BEACON_FILTER_IN_NTFY_API_S_VER_2 */
 
+union iwl_legacy_sig {
+#define OFDM_RX_LEGACY_LENGTH				0x00000fff
+#define OFDM_RX_RATE					0x0000f000
+	__le32 ofdm;
+#define CCK_CRFR_SHORT_PREAMBLE				0x00000040
+	__le32 cck;
+};
+
+struct iwl_ht_sigs {
+#define OFDM_RX_FRAME_HT_MCS				0x0000007f
+#define OFDM_RX_FRAME_HT_BANDWIDTH			0x00000080
+#define OFDM_RX_FRAME_HT_LENGTH				0x03ffff00
+	__le32 a1;
+	__le32 a2;
+};
+
+struct iwl_vht_sigs {
+#define OFDM_RX_FRAME_VHT_NUM_OF_DATA_SYM		0x000007ff
+#define OFDM_RX_FRAME_VHT_NUM_OF_DATA_SYM_VALID		0x80000000
+	__le32 a0;
+	__le32 a1, a2;
+};
+
+struct iwl_he_sigs {
+#define OFDM_RX_FRAME_HE_BEAM_CHANGE			0x00000001
+#define OFDM_RX_FRAME_HE_UL_FLAG			0x00000002
+#define OFDM_RX_FRAME_HE_MCS				0x0000003c
+#define OFDM_RX_FRAME_HE_DCM				0x00000040
+#define OFDM_RX_FRAME_HE_BSS_COLOR			0x00001f80
+#define OFDM_RX_FRAME_HE_SPATIAL_REUSE			0x0001e000
+#define OFDM_RX_FRAME_HE_BANDWIDTH			0x00060000
+#define OFDM_RX_FRAME_HE_SU_EXT_BW10			0x00080000
+#define OFDM_RX_FRAME_HE_GI_LTF_TYPE			0x00700000
+#define OFDM_RX_FRAME_HE_NSTS				0x03800000
+#define OFDM_RX_FRAME_HE_PRMBL_PUNC_TYPE		0x0c000000
+	__le32 a1;
+#define OFDM_RX_FRAME_HE_TXOP_DURATION			0x0000007f
+#define OFDM_RX_FRAME_HE_CODING				0x00000080
+#define OFDM_RX_FRAME_HE_CODING_EXTRA_SYM		0x00000100
+#define OFDM_RX_FRAME_HE_STBC				0x00000200
+#define OFDM_RX_FRAME_HE_BF				0x00000400
+#define OFDM_RX_FRAME_HE_PRE_FEC_PAD_FACTOR		0x00001800
+#define OFDM_RX_FRAME_HE_PE_DISAMBIG			0x00002000
+#define OFDM_RX_FRAME_HE_DOPPLER			0x00004000
+#define OFDM_RX_FRAME_HE_TYPE				0x00038000
+#define OFDM_RX_FRAME_HE_MU_NUM_OF_SIGB_SYM_OR_USER_NUM 0x003c0000
+#define OFDM_RX_FRAME_HE_MU_SIGB_COMP			0x00400000
+#define OFDM_RX_FRAME_HE_MU_NUM_OF_LTF_SYM		0x03800000
+	__le32 a2;
+#define OFDM_RX_FRAME_HE_NUM_OF_DATA_SYM		0x000007ff
+#define OFDM_RX_FRAME_HE_PE_DURATION			0x00003800
+#define OFDM_RX_FRAME_HE_NUM_OF_DATA_SYM_VALID		0x80000000
+	__le32 a3;
+#define OFDM_RX_FRAME_HE_SIGB_STA_ID_FOUND		0x00000001
+#define OFDM_RX_FRAME_HE_SIGB_STA_ID_INDX		0x0000000e
+#define OFDM_RX_FRAME_HE_SIGB_NSTS			0x00000070
+#define OFDM_RX_FRAME_HE_SIGB_BF			0x00000080
+#define OFDM_RX_FRAME_HE_SIGB_MCS			0x00000f00
+#define OFDM_RX_FRAME_HE_SIGB_DCM			0x00001000
+#define OFDM_RX_FRAME_HE_SIGB_CODING			0x00002000
+#define OFDM_RX_FRAME_HE_SIGB_SPATIAL_CONFIG		0x0003c000
+#define OFDM_RX_FRAME_HE_SIGB_STA_RU			0x03fc0000
+#define OFDM_RX_FRAME_HE_SIGB_NUM_OF_SYM		0x3c000000
+#define OFDM_RX_FRAME_HE_SIGB_CRC_OK			0x40000000
+	__le32 b;
+/* index 0 */
+#define OFDM_RX_FRAME_HE_RU_ALLOC_0_A1			0x000000ff
+#define OFDM_RX_FRAME_HE_RU_ALLOC_0_A2			0x0000ff00
+#define OFDM_RX_FRAME_HE_RU_ALLOC_0_B1			0x00ff0000
+#define OFDM_RX_FRAME_HE_RU_ALLOC_0_B2			0xff000000
+/* index 1 */
+#define OFDM_RX_FRAME_HE_RU_ALLOC_1_C1			0x000000ff
+#define OFDM_RX_FRAME_HE_RU_ALLOC_1_C2			0x0000ff00
+#define OFDM_RX_FRAME_HE_RU_ALLOC_1_D1			0x00ff0000
+#define OFDM_RX_FRAME_HE_RU_ALLOC_1_D2			0xff000000
+/* index 2 */
+#define OFDM_RX_FRAME_HE_CENTER_RU_CC1			0x00000001
+#define OFDM_RX_FRAME_HE_CENTER_RU_CC2			0x00000002
+#define OFDM_RX_FRAME_HE_COMMON_CC1_CRC_OK		0x00000004
+#define OFDM_RX_FRAME_HE_COMMON_CC2_CRC_OK		0x00000008
+	__le32 cmn[3];
+};
+
+struct iwl_he_tb_sigs {
+#define OFDM_RX_HE_TRIG_FORMAT				0x00000001
+#define OFDM_RX_HE_TRIG_BSS_COLOR			0x0000007e
+#define OFDM_RX_HE_TRIG_SPATIAL_REUSE_1			0x00000780
+#define OFDM_RX_HE_TRIG_SPATIAL_REUSE_2			0x00007800
+#define OFDM_RX_HE_TRIG_SPATIAL_REUSE_3			0x00078000
+#define OFDM_RX_HE_TRIG_SPATIAL_REUSE_4			0x00780000
+#define OFDM_RX_HE_TRIG_BANDWIDTH			0x03000000
+	__le32 a1;
+#define OFDM_RX_HE_TRIG_TXOP_DURATION			0x0000007f
+#define OFDM_RX_HE_TRIG_SIG2_RESERVED			0x0000ff80
+#define OFDM_RX_HE_TRIG_FORMAT_ERR			0x08000000
+#define OFDM_RX_HE_TRIG_BW_ERR				0x10000000
+#define OFDM_RX_HE_TRIG_LEGACY_LENGTH_ERR		0x20000000
+#define OFDM_RX_HE_TRIG_CRC_OK				0x40000000
+	__le32 a2;
+#define OFDM_UCODE_TRIG_BASE_RX_LGCY_LENGTH		0x00000fff
+#define OFDM_UCODE_TRIG_BASE_RX_BANDWIDTH		0x00007000
+#define OFDM_UCODE_TRIG_BASE_PS160			0x00008000
+#define OFDM_UCODE_EHT_TRIG_CONTROL_CHANNEL		0x000f0000
+	__le32 tb_rx0;
+#define OFDM_UCODE_TRIG_BASE_RX_MCS			0x0000000f
+#define OFDM_UCODE_TRIG_BASE_RX_DCM			0x00000010
+#define OFDM_UCODE_TRIG_BASE_RX_GI_LTF_TYPE		0x00000060
+#define OFDM_UCODE_TRIG_BASE_RX_NSTS			0x00000380
+#define OFDM_UCODE_TRIG_BASE_RX_CODING			0x00000400
+#define OFDM_UCODE_TRIG_BASE_RX_CODING_EXTRA_SYM	0x00000800
+#define OFDM_UCODE_TRIG_BASE_RX_STBC			0x00001000
+#define OFDM_UCODE_TRIG_BASE_RX_PRE_FEC_PAD_FACTOR	0x00006000
+#define OFDM_UCODE_TRIG_BASE_RX_PE_DISAMBIG		0x00008000
+#define OFDM_UCODE_TRIG_BASE_RX_DOPPLER			0x00010000
+#define OFDM_UCODE_TRIG_BASE_RX_RU			0x01fe0000
+#define OFDM_UCODE_TRIG_BASE_RX_RU_P80			0x00020000
+#define OFDM_UCODE_TRIG_BASE_RX_NUM_OF_LTF_SYM		0x0e000000
+#define OFDM_UCODE_TRIG_BASE_RX_LTF_PILOT_TYPE		0x10000000
+#define OFDM_UCODE_TRIG_BASE_RX_LOWEST_SS_ALLOCATION	0xe0000000
+	__le32 tb_rx1;
+};
+
+struct iwl_eht_sigs {
+#define OFDM_RX_FRAME_ENHANCED_WIFI_VER_ID		0x00000007
+#define OFDM_RX_FRAME_ENHANCED_WIFI_BANDWIDTH		0x00000038
+#define OFDM_RX_FRAME_ENHANCED_WIFI_UL_FLAG		0x00000040
+#define OFDM_RX_FRAME_ENHANCED_WIFI_BSS_COLOR		0x00001f80
+#define OFDM_RX_FRAME_ENHANCED_WIFI_TXOP_DURATION	0x000fe000
+#define OFDM_RX_FRAME_EHT_USIG1_DISREGARD		0x01f00000
+#define OFDM_RX_FRAME_EHT_USIG1_VALIDATE		0x02000000
+#define OFDM_RX_FRAME_EHT_BW320_SLOT			0x04000000
+#define OFDM_RX_FRAME_EHT_TYPE				0x18000000
+#define OFDM_RX_FRAME_ENHANCED_ER_NO_STREAMS		0x20000000
+	__le32 usig_a1;
+#define OFDM_RX_FRAME_EHT_PPDU_TYPE			0x00000003
+#define OFDM_RX_FRAME_EHT_USIG2_VALIDATE_B2		0x00000004
+#define OFDM_RX_FRAME_EHT_PUNC_CHANNEL			0x000000f8
+#define OFDM_RX_FRAME_EHT_USIG2_VALIDATE_B8		0x00000100
+#define OFDM_RX_FRAME_EHT_SIG_MCS			0x00000600
+#define OFDM_RX_FRAME_EHT_SIG_SYM_NUM			0x0000f800
+#define OFDM_RX_FRAME_EHT_TRIG_SPATIAL_REUSE_1		0x000f0000
+#define OFDM_RX_FRAME_EHT_TRIG_SPATIAL_REUSE_2		0x00f00000
+#define OFDM_RX_FRAME_EHT_TRIG_USIG2_DISREGARD		0x1f000000
+#define OFDM_RX_FRAME_EHT_TRIG_NO_STREAMS		0x20000000
+#define OFDM_RX_USIG_CRC_OK				0x40000000
+	__le32 usig_a2_eht;
+#define OFDM_RX_FRAME_EHT_SPATIAL_REUSE			0x0000000f
+#define OFDM_RX_FRAME_EHT_GI_LTF_TYPE			0x00000030
+#define OFDM_RX_FRAME_EHT_NUM_OF_LTF_SYM		0x000001c0
+#define OFDM_RX_FRAME_EHT_CODING_EXTRA_SYM		0x00000200
+#define OFDM_RX_FRAME_EHT_PRE_FEC_PAD_FACTOR		0x00000c00
+#define OFDM_RX_FRAME_EHT_PE_DISAMBIG			0x00001000
+#define OFDM_RX_FRAME_EHT_USIG_OVF_DISREGARD		0x0001e000
+#define OFDM_RX_FRAME_EHT_NUM_OF_USERS			0x000e0000
+#define OFDM_RX_FRAME_EHT_NSTS				0x00f00000
+#define OFDM_RX_FRAME_EHT_BF				0x01000000
+#define OFDM_RX_FRAME_EHT_USIG_OVF_NDP_DISREGARD	0x06000000
+#define OFDM_RX_FRAME_EHTSIG_COMM_CC1_CRC_OK		0x08000000
+#define OFDM_RX_FRAME_EHTSIG_COMM_CC2_CRC_OK		0x10000000
+#define OFDM_RX_FRAME_EHT_NON_VALID_RU_ALLOC		0x20000000
+#define OFDM_RX_FRAME_EHT_NO_STREAMS			0x40000000
+	__le32 b1;
+#define OFDM_RX_FRAME_EHT_MATCH_ID_FOUND		0x00000001
+#define OFDM_RX_FRAME_EHT_ID_INDX			0x0000000e
+#define OFDM_RX_FRAME_EHT_MCS				0x000000f0
+#define OFDM_RX_FRAME_EHT_CODING			0x00000100
+#define OFDM_RX_FRAME_EHT_SPATIAL_CONFIG		0x00007e00
+#define OFDM_RX_FRAME_EHT_STA_RU			0x007f8000
+#define OFDM_RX_FRAME_EHT_STA_RU_P80			0x00008000
+#define OFDM_RX_FRAME_EHT_STA_RU_PS160			0x00800000
+#define OFDM_RX_FRAME_EHT_USER_FIELD_CRC_OK		0x40000000
+	__le32 b2;
+#define OFDM_RX_FRAME_EHT_NUM_OF_DATA_SYM		0x000007ff
+#define OFDM_RX_FRAME_EHT_PE_DURATION			0x00003800
+#define OFDM_RX_FRAME_EHT_NUM_OF_DATA_SYM_VALID		0x80000000
+	__le32 sig2;
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_0_A1			0x000001ff
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_0_A2			0x0003fe00
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_0_A3			0x07fc0000
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_1_B1			0x000001ff
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_1_B2			0x0003fe00
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_1_B3			0x07fc0000
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_2_C1			0x000001ff
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_2_C2			0x0003fe00
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_2_C3			0x07fc0000
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_3_D1			0x000001ff
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_3_D2			0x0003fe00
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_3_D3			0x07fc0000
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_4_A4			0x000001ff
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_4_B4			0x0003fe00
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_5_C4			0x000001ff
+#define OFDM_RX_FRAME_EHT_RU_ALLOC_5_D4			0x0003fe00
+	__le32 cmn[6];
+#define OFDM_RX_FRAME_EHT_USER_FIELD_ID			0x000007ff
+	__le32 user_id;
+};
+
+struct iwl_eht_tb_sigs {
+	/* same as non-TB above */
+	__le32 usig_a1, usig_a2_eht;
+	/* same as HE TB above */
+	__le32 tb_rx0, tb_rx1;
+};
+
+struct iwl_uhr_sigs {
+	__le32 usig_a1, usig_a1_uhr, usig_a2_uhr, b1, b2;
+	__le32 sig2;
+	__le32 cmn[6];
+	__le32 user_id;
+};
+
+struct iwl_uhr_tb_sigs {
+	__le32 usig_a1, usig_a2_uhr, tb_rx0, tb_rx1;
+};
+
+struct iwl_uhr_elr_sigs {
+	__le32 usig_a1, usig_a2_uhr;
+	__le32 uhr_sig_elr1, uhr_sig_elr2;
+};
+
+union iwl_sigs {
+	struct iwl_ht_sigs ht;
+	struct iwl_vht_sigs vht;
+	struct iwl_he_sigs he;
+	struct iwl_he_tb_sigs he_tb;
+	struct iwl_eht_sigs eht;
+	struct iwl_eht_tb_sigs eht_tb;
+	struct iwl_uhr_sigs uhr;
+	struct iwl_uhr_tb_sigs uhr_tb;
+	struct iwl_uhr_elr_sigs uhr_elr;
+};
+
+enum iwl_sniffer_status {
+	IWL_SNIF_STAT_PLCP_RX_OK	= 0,
+	IWL_SNIF_STAT_AID_NOT_FOR_US	= 1,
+	IWL_SNIF_STAT_PLCP_RX_LSIG_ERR	= 2,
+	IWL_SNIF_STAT_PLCP_RX_SIGA_ERR	= 3,
+	IWL_SNIF_STAT_PLCP_RX_SIGB_ERR	= 4,
+	IWL_SNIF_STAT_UNEXPECTED_TB	= 5,
+	IWL_SNIF_STAT_UNSUPPORTED_RATE	= 6,
+	IWL_SNIF_STAT_UNKNOWN_ERROR	= 7,
+}; /* AIR_SNIFFER_STATUS_E_VER_1 */
+
+enum iwl_sniffer_flags {
+	IWL_SNIF_FLAG_VALID_TB_RX	= BIT(0),
+	IWL_SNIF_FLAG_VALID_RU		= BIT(1),
+}; /* AIR_SNIFFER_FLAGS_E_VER_1 */
+
+/**
+ * struct iwl_rx_phy_air_sniffer_ntfy - air sniffer notification
+ *
+ * @status: &enum iwl_sniffer_status
+ * @flags: &enum iwl_sniffer_flags
+ * @reserved1: reserved
+ * @rssi_a: energy chain-A in negative dBm, measured at FINA time
+ * @rssi_b: energy chain-B in negative dBm, measured at FINA time
+ * @channel: channel number
+ * @band: band information, PHY_BAND_*
+ * @on_air_rise_time: GP2 at on air rise
+ * @frame_time: frame time in us
+ * @rate: RATE_MCS_*
+ * @bytecount: byte count for legay and HT, otherwise number of symbols
+ * @legacy_sig: CCK signal information if %RATE_MCS_MOD_TYPE_MSK in @rate is
+ *	%RATE_MCS_MOD_TYPE_CCK, otherwise OFDM signal information
+ * @sigs: PHY signal information, depending on %RATE_MCS_MOD_TYPE_MSK in @rate
+ * @reserved2: reserved
+ *
+ * Sent for every frame and before the normal RX command if data is included.
+ */
+struct iwl_rx_phy_air_sniffer_ntfy {
+	u8 status;
+	u8 flags;
+	u8 reserved1[2];
+	u8 rssi_a, rssi_b;
+	u8 channel, band;
+	__le32 on_air_rise_time;
+	__le32 frame_time;
+	/* note: MCS in rate is not valid for MU-VHT */
+	__le32 rate;
+	__le32 bytecount;
+	union iwl_legacy_sig legacy_sig;
+	union iwl_sigs sigs;
+	__le32 reserved2;
+}; /* RX_PHY_AIR_SNIFFER_NTFY_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_rx_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 5323c73ac827..55b484c16280 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -397,11 +397,9 @@ static int iwl_mld_hw_verify_preconditions(struct iwl_mld *mld)
 					 TLC_MNG_UPDATE_NOTIF, 0) >= 4) +
 		(iwl_fw_lookup_notif_ver(mld->fw, LEGACY_GROUP,
 					 REPLY_RX_MPDU_CMD, 0) >= 6) +
-		(iwl_fw_lookup_notif_ver(mld->fw, DATA_PATH_GROUP,
-					 RX_NO_DATA_NOTIF, 0) >= 4) +
 		(iwl_fw_lookup_notif_ver(mld->fw, LONG_GROUP, TX_CMD, 0) >= 9);
 
-	if (ratecheck != 0 && ratecheck != 5) {
+	if (ratecheck != 0 && ratecheck != 4) {
 		IWL_ERR(mld, "Firmware has inconsistent rates\n");
 		return -EINVAL;
 	}
@@ -684,6 +682,8 @@ void iwl_mld_mac80211_remove_interface(struct ieee80211_hw *hw,
 #endif
 
 	iwl_mld_rm_vif(mld, vif);
+
+	mld->monitor.phy.valid = false;
 }
 
 struct iwl_mld_mc_iter_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index a6962256bdd1..8a4c96385640 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -259,6 +259,7 @@ static const struct iwl_hcmd_names iwl_mld_data_path_names[] = {
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(TLC_MNG_UPDATE_NOTIF),
 	HCMD_NAME(BEACON_FILTER_IN_NOTIF),
+	HCMD_NAME(PHY_AIR_SNIFFER_NOTIF),
 	HCMD_NAME(MU_GROUP_MGMT_NOTIF),
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index ceda12c1672d..22efe8e10f53 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -118,7 +118,11 @@
  * @monitor.cur_bssid: current bssid tracked by the sniffer
  * @monitor.ptp_time: set the Rx mactime using the device's PTP clock time
  * @monitor.p80: primary channel position relative to he whole bandwidth, in
- * steps of 80 MHz
+ *	steps of 80 MHz
+ * @monitor.phy: PHY data information
+ * @monitor.phy.data: PHY data (&struct iwl_rx_phy_air_sniffer_ntfy) received
+ * @monitor.phy.valid: PHY data is valid (was received)
+ * @monitor.phy.used: PHY data was used by an RX
  * @fw_id_to_link_sta: maps a fw id of a sta to the corresponding
  *	ieee80211_link_sta. This is not cleaned up on restart since we want to
  *	preserve the fw sta ids during a restart (for SN/PN restoring).
@@ -209,6 +213,10 @@ struct iwl_mld {
 			u32 ampdu_ref;
 			bool ampdu_toggle;
 			u8 p80;
+			struct {
+				struct iwl_rx_phy_air_sniffer_ntfy data;
+				u8 valid:1, used:1;
+			} phy;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 			__le16 cur_aid;
 			u8 cur_bssid[ETH_ALEN];
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index 884973d0b344..4cf3920b005f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -589,8 +589,8 @@ void iwl_mld_rx(struct iwl_op_mode *op_mode, struct napi_struct *napi,
 	else if (unlikely(cmd_id == WIDE_ID(DATA_PATH_GROUP,
 					    RX_QUEUES_NOTIFICATION)))
 		iwl_mld_handle_rx_queues_sync_notif(mld, napi, pkt, 0);
-	else if (cmd_id == WIDE_ID(DATA_PATH_GROUP, RX_NO_DATA_NOTIF))
-		iwl_mld_rx_monitor_no_data(mld, napi, pkt, 0);
+	else if (cmd_id == WIDE_ID(DATA_PATH_GROUP, PHY_AIR_SNIFFER_NOTIF))
+		iwl_mld_handle_phy_air_sniffer_notif(mld, napi, pkt);
 	else
 		iwl_mld_rx_notif(mld, rxb, pkt);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 20d866dd92c2..052a19bb85b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -18,41 +18,32 @@
 
 /* stores relevant PHY data fields extracted from iwl_rx_mpdu_desc */
 struct iwl_mld_rx_phy_data {
-	enum iwl_rx_phy_info_type info_type;
-	__le32 data0;
-	__le32 data1;
-	__le32 data2;
-	__le32 data3;
-	__le32 eht_data4;
-	__le32 data5;
-	__le16 data4;
+	struct iwl_rx_phy_air_sniffer_ntfy *ntfy;
 	bool first_subframe;
 	bool with_data;
-	__le32 rx_vec[4];
 	u32 rate_n_flags;
 	u32 gp2_on_air_rise;
+	/* phy_info is only valid when we have a frame, i.e. with_data=true */
 	u16 phy_info;
 	u8 energy_a, energy_b;
 };
 
 static void
-iwl_mld_fill_phy_data(struct iwl_mld *mld,
-		      struct iwl_rx_mpdu_desc *desc,
-		      struct iwl_mld_rx_phy_data *phy_data)
+iwl_mld_fill_phy_data_from_mpdu(struct iwl_mld *mld,
+				struct iwl_rx_mpdu_desc *desc,
+				struct iwl_mld_rx_phy_data *phy_data)
 {
+	if (unlikely(mld->monitor.phy.valid)) {
+		mld->monitor.phy.used = true;
+		phy_data->ntfy = &mld->monitor.phy.data;
+	}
+
 	phy_data->phy_info = le16_to_cpu(desc->phy_info);
 	phy_data->rate_n_flags = iwl_v3_rate_from_v2_v3(desc->v3.rate_n_flags,
 							mld->fw_rates_ver_3);
 	phy_data->gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
 	phy_data->energy_a = desc->v3.energy_a;
 	phy_data->energy_b = desc->v3.energy_b;
-	phy_data->data0 = desc->v3.phy_data0;
-	phy_data->data1 = desc->v3.phy_data1;
-	phy_data->data2 = desc->v3.phy_data2;
-	phy_data->data3 = desc->v3.phy_data3;
-	phy_data->data4 = desc->phy_data4;
-	phy_data->eht_data4 = desc->phy_eht_data4;
-	phy_data->data5 = desc->v3.phy_data5;
 	phy_data->with_data = true;
 }
 
@@ -217,26 +208,19 @@ static void iwl_mld_fill_signal(struct iwl_mld *mld, int link_id,
 }
 
 static void
-iwl_mld_decode_he_phy_ru_alloc(struct iwl_mld_rx_phy_data *phy_data,
-			       struct ieee80211_radiotap_he *he,
-			       struct ieee80211_radiotap_he_mu *he_mu,
-			       struct ieee80211_rx_status *rx_status)
+iwl_mld_he_set_ru_alloc(struct ieee80211_rx_status *rx_status,
+			struct ieee80211_radiotap_he *he,
+			u8 ru_with_p80)
 {
-	/* Unfortunately, we have to leave the mac80211 data
-	 * incorrect for the case that we receive an HE-MU
-	 * transmission and *don't* have the HE phy data (due
-	 * to the bits being used for TSF). This shouldn't
-	 * happen though as management frames where we need
-	 * the TSF/timers are not be transmitted in HE-MU.
-	 */
-	u8 ru = le32_get_bits(phy_data->data1, IWL_RX_PHY_DATA1_HE_RU_ALLOC_MASK);
-	u32 rate_n_flags = phy_data->rate_n_flags;
-	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
+	u8 ru = ru_with_p80 >> 1;
+	u8 p80 = ru_with_p80 & 1;
 	u8 offs = 0;
 
 	rx_status->bw = RATE_INFO_BW_HE_RU;
 
 	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN);
+	he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET_KNOWN);
 
 	switch (ru) {
 	case 0 ... 36:
@@ -266,227 +250,262 @@ iwl_mld_decode_he_phy_ru_alloc(struct iwl_mld_rx_phy_data *phy_data,
 		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
 		break;
 	}
+
 	he->data2 |= le16_encode_bits(offs,
 				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
-	he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_KNOWN |
-				 IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET_KNOWN);
-	if (phy_data->data1 & cpu_to_le32(IWL_RX_PHY_DATA1_HE_RU_ALLOC_SEC80))
-		he->data2 |=
-			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_SEC);
-
-#define CHECK_BW(bw) \
-	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_ ## bw ## MHZ != \
-		     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS); \
-	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_ ## bw ## MHZ != \
-		     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS)
-	CHECK_BW(20);
-	CHECK_BW(40);
-	CHECK_BW(80);
-	CHECK_BW(160);
 
-	if (he_mu)
-		he_mu->flags2 |=
-			le16_encode_bits(u32_get_bits(rate_n_flags,
-						      RATE_MCS_CHAN_WIDTH_MSK),
-					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
-	else if (he_type == RATE_MCS_HE_TYPE_TRIG)
-		he->data6 |=
-			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_KNOWN) |
-			le16_encode_bits(u32_get_bits(rate_n_flags,
-						      RATE_MCS_CHAN_WIDTH_MSK),
-					 IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW);
+	he->data2 |= le16_encode_bits(p80, IEEE80211_RADIOTAP_HE_DATA2_PRISEC_80_SEC);
 }
 
+#define RTAP_ENC_HE(src, src_msk, dst_msk)			\
+	le16_encode_bits(le32_get_bits(src, src_msk), dst_msk)
+
 static void
-iwl_mld_decode_he_mu_ext(struct iwl_mld_rx_phy_data *phy_data,
-			 struct ieee80211_radiotap_he_mu *he_mu)
+iwl_mld_decode_he_mu(struct iwl_mld_rx_phy_data *phy_data,
+		     struct ieee80211_radiotap_he *he,
+		     struct ieee80211_radiotap_he_mu *he_mu,
+		     struct ieee80211_rx_status *rx_status)
 {
-	u32 phy_data2 = le32_to_cpu(phy_data->data2);
-	u32 phy_data3 = le32_to_cpu(phy_data->data3);
-	u16 phy_data4 = le16_to_cpu(phy_data->data4);
 	u32 rate_n_flags = phy_data->rate_n_flags;
 
-	if (u32_get_bits(phy_data4, IWL_RX_PHY_DATA4_HE_MU_EXT_CH1_CRC_OK)) {
+	he_mu->flags1 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.b,
+				     OFDM_RX_FRAME_HE_SIGB_DCM,
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM);
+	he_mu->flags1 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.b,
+				     OFDM_RX_FRAME_HE_SIGB_MCS,
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS);
+	he_mu->flags2 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a1,
+				     OFDM_RX_FRAME_HE_PRMBL_PUNC_TYPE,
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW);
+	he_mu->flags2 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
+				     OFDM_RX_FRAME_HE_MU_NUM_OF_SIGB_SYM_OR_USER_NUM,
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_SYMS_USERS);
+	he_mu->flags2 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.b,
+				     OFDM_RX_FRAME_HE_MU_SIGB_COMP,
+				     IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_COMP);
+
+	if (phy_data->ntfy->flags & IWL_SNIF_FLAG_VALID_RU &&
+	    le32_get_bits(phy_data->ntfy->sigs.he.cmn[2],
+			  OFDM_RX_FRAME_HE_COMMON_CC1_CRC_OK)) {
 		he_mu->flags1 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_RU_KNOWN |
 				    IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU_KNOWN);
 
 		he_mu->flags1 |=
-			le16_encode_bits(u32_get_bits(phy_data4,
-						      IWL_RX_PHY_DATA4_HE_MU_EXT_CH1_CTR_RU),
-					 IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU);
-
-		he_mu->ru_ch1[0] = u32_get_bits(phy_data2,
-						IWL_RX_PHY_DATA2_HE_MU_EXT_CH1_RU0);
-		he_mu->ru_ch1[1] = u32_get_bits(phy_data3,
-						IWL_RX_PHY_DATA3_HE_MU_EXT_CH1_RU1);
-		he_mu->ru_ch1[2] = u32_get_bits(phy_data2,
-						IWL_RX_PHY_DATA2_HE_MU_EXT_CH1_RU2);
-		he_mu->ru_ch1[3] = u32_get_bits(phy_data3,
-						IWL_RX_PHY_DATA3_HE_MU_EXT_CH1_RU3);
+			RTAP_ENC_HE(phy_data->ntfy->sigs.he.cmn[2],
+				    OFDM_RX_FRAME_HE_CENTER_RU_CC1,
+				    IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH1_CTR_26T_RU);
+
+		he_mu->ru_ch1[0] = le32_get_bits(phy_data->ntfy->sigs.he.cmn[0],
+						 OFDM_RX_FRAME_HE_RU_ALLOC_0_A1);
+		he_mu->ru_ch1[1] = le32_get_bits(phy_data->ntfy->sigs.he.cmn[1],
+						 OFDM_RX_FRAME_HE_RU_ALLOC_1_C1);
+		he_mu->ru_ch1[2] = le32_get_bits(phy_data->ntfy->sigs.he.cmn[0],
+						 OFDM_RX_FRAME_HE_RU_ALLOC_0_A2);
+		he_mu->ru_ch1[3] = le32_get_bits(phy_data->ntfy->sigs.he.cmn[1],
+						 OFDM_RX_FRAME_HE_RU_ALLOC_1_C2);
 	}
 
-	if (u32_get_bits(phy_data4, IWL_RX_PHY_DATA4_HE_MU_EXT_CH2_CRC_OK) &&
+	if (phy_data->ntfy->flags & IWL_SNIF_FLAG_VALID_RU &&
+	    le32_get_bits(phy_data->ntfy->sigs.he.cmn[2],
+			  OFDM_RX_FRAME_HE_COMMON_CC2_CRC_OK) &&
 	    (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) != RATE_MCS_CHAN_WIDTH_20) {
 		he_mu->flags1 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_RU_KNOWN |
 				    IEEE80211_RADIOTAP_HE_MU_FLAGS1_CH2_CTR_26T_RU_KNOWN);
 
 		he_mu->flags2 |=
-			le16_encode_bits(u32_get_bits(phy_data4,
-						      IWL_RX_PHY_DATA4_HE_MU_EXT_CH2_CTR_RU),
-					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_CH2_CTR_26T_RU);
-
-		he_mu->ru_ch2[0] = u32_get_bits(phy_data2,
-						IWL_RX_PHY_DATA2_HE_MU_EXT_CH2_RU0);
-		he_mu->ru_ch2[1] = u32_get_bits(phy_data3,
-						IWL_RX_PHY_DATA3_HE_MU_EXT_CH2_RU1);
-		he_mu->ru_ch2[2] = u32_get_bits(phy_data2,
-						IWL_RX_PHY_DATA2_HE_MU_EXT_CH2_RU2);
-		he_mu->ru_ch2[3] = u32_get_bits(phy_data3,
-						IWL_RX_PHY_DATA3_HE_MU_EXT_CH2_RU3);
+			RTAP_ENC_HE(phy_data->ntfy->sigs.he.cmn[2],
+				    OFDM_RX_FRAME_HE_CENTER_RU_CC2,
+				    IEEE80211_RADIOTAP_HE_MU_FLAGS2_CH2_CTR_26T_RU);
+
+		he_mu->ru_ch2[0] = le32_get_bits(phy_data->ntfy->sigs.he.cmn[0],
+						 OFDM_RX_FRAME_HE_RU_ALLOC_0_B1);
+		he_mu->ru_ch2[1] = le32_get_bits(phy_data->ntfy->sigs.he.cmn[1],
+						 OFDM_RX_FRAME_HE_RU_ALLOC_1_D1);
+		he_mu->ru_ch2[2] = le32_get_bits(phy_data->ntfy->sigs.he.cmn[0],
+						 OFDM_RX_FRAME_HE_RU_ALLOC_0_B2);
+		he_mu->ru_ch2[3] = le32_get_bits(phy_data->ntfy->sigs.he.cmn[1],
+						 OFDM_RX_FRAME_HE_RU_ALLOC_1_D2);
 	}
+
+#define CHECK_BW(bw) \
+	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_ ## bw ## MHZ != \
+		     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS)
+	CHECK_BW(20);
+	CHECK_BW(40);
+	CHECK_BW(80);
+	CHECK_BW(160);
+#undef CHECK_BW
+
+	he_mu->flags2 |=
+		le16_encode_bits(u32_get_bits(rate_n_flags, RATE_MCS_CHAN_WIDTH_MSK),
+				 IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW);
+
+	iwl_mld_he_set_ru_alloc(rx_status, he,
+				le32_get_bits(phy_data->ntfy->sigs.he.b,
+					      OFDM_RX_FRAME_HE_SIGB_STA_RU));
+}
+
+static void
+iwl_mld_decode_he_tb_phy_data(struct iwl_mld_rx_phy_data *phy_data,
+			      struct ieee80211_radiotap_he *he,
+			      struct ieee80211_rx_status *rx_status)
+{
+	u32 rate_n_flags = phy_data->rate_n_flags;
+	u32 nsts;
+
+	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE2_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE3_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE4_KNOWN);
+
+	he->data4 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.a1,
+				 OFDM_RX_HE_TRIG_SPATIAL_REUSE_1,
+				 IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE1);
+	he->data4 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.a1,
+				 OFDM_RX_HE_TRIG_SPATIAL_REUSE_2,
+				 IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE2);
+	he->data4 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.a1,
+				 OFDM_RX_HE_TRIG_SPATIAL_REUSE_3,
+				 IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE3);
+	he->data4 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.a1,
+				 OFDM_RX_HE_TRIG_SPATIAL_REUSE_4,
+				 IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE4);
+	he->data3 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.a1,
+				 OFDM_RX_HE_TRIG_BSS_COLOR,
+				 IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR);
+
+#define CHECK_BW(bw) \
+	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_ ## bw ## MHZ != \
+		     RATE_MCS_CHAN_WIDTH_##bw >> RATE_MCS_CHAN_WIDTH_POS)
+	CHECK_BW(20);
+	CHECK_BW(40);
+	CHECK_BW(80);
+	CHECK_BW(160);
+#undef CHECK_BW
+
+	he->data6 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW_KNOWN) |
+		     le16_encode_bits(u32_get_bits(rate_n_flags, RATE_MCS_CHAN_WIDTH_MSK),
+				      IEEE80211_RADIOTAP_HE_DATA6_TB_PPDU_BW);
+
+	if (!(phy_data->ntfy->flags & IWL_SNIF_FLAG_VALID_TB_RX))
+		return;
+
+	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_LDPC_XSYMSEG_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_DOPPLER_KNOWN);
+	he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_NUM_LTF_SYMS_KNOWN);
+
+	he->data3 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.tb_rx1,
+				 OFDM_UCODE_TRIG_BASE_RX_CODING_EXTRA_SYM,
+				 IEEE80211_RADIOTAP_HE_DATA3_LDPC_XSYMSEG);
+	he->data6 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.tb_rx1,
+				 OFDM_UCODE_TRIG_BASE_RX_DOPPLER,
+				 IEEE80211_RADIOTAP_HE_DATA6_DOPPLER);
+	he->data5 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.tb_rx1,
+				 OFDM_UCODE_TRIG_BASE_RX_PRE_FEC_PAD_FACTOR,
+				 IEEE80211_RADIOTAP_HE_DATA5_PRE_FEC_PAD);
+	he->data5 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.tb_rx1,
+				 OFDM_UCODE_TRIG_BASE_RX_PE_DISAMBIG,
+				 IEEE80211_RADIOTAP_HE_DATA5_PE_DISAMBIG);
+	he->data5 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.tb_rx1,
+				 OFDM_UCODE_TRIG_BASE_RX_NUM_OF_LTF_SYM,
+				 IEEE80211_RADIOTAP_HE_DATA5_NUM_LTF_SYMS);
+	he->data6 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he_tb.a2,
+				 OFDM_RX_HE_TRIG_TXOP_DURATION,
+				 IEEE80211_RADIOTAP_HE_DATA6_TXOP);
+
+	iwl_mld_he_set_ru_alloc(rx_status, he,
+				le32_get_bits(phy_data->ntfy->sigs.he_tb.tb_rx1,
+					      OFDM_UCODE_TRIG_BASE_RX_RU));
+
+	nsts = le32_get_bits(phy_data->ntfy->sigs.he_tb.tb_rx1,
+			     OFDM_UCODE_TRIG_BASE_RX_NSTS) + 1;
+	rx_status->nss = nsts >> !!(rate_n_flags & RATE_MCS_STBC_MSK);
 }
 
 static void
 iwl_mld_decode_he_phy_data(struct iwl_mld_rx_phy_data *phy_data,
 			   struct ieee80211_radiotap_he *he,
 			   struct ieee80211_radiotap_he_mu *he_mu,
-			   struct ieee80211_rx_status *rx_status,
-			   int queue)
+			   struct ieee80211_rx_status *rx_status)
 {
-	switch (phy_data->info_type) {
-	case IWL_RX_PHY_INFO_TYPE_NONE:
-	case IWL_RX_PHY_INFO_TYPE_CCK:
-	case IWL_RX_PHY_INFO_TYPE_OFDM_LGCY:
-	case IWL_RX_PHY_INFO_TYPE_HT:
-	case IWL_RX_PHY_INFO_TYPE_VHT_SU:
-	case IWL_RX_PHY_INFO_TYPE_VHT_MU:
-	case IWL_RX_PHY_INFO_TYPE_EHT_MU:
-	case IWL_RX_PHY_INFO_TYPE_EHT_TB:
-	case IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT:
-	case IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT:
-		return;
-	case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
-		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN |
-					 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE2_KNOWN |
-					 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE3_KNOWN |
-					 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE4_KNOWN);
-		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->data2,
-							    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE1),
-					      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE1);
-		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->data2,
-							    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE2),
-					      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE2);
-		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->data2,
-							    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE3),
-					      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE3);
-		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->data2,
-							    IWL_RX_PHY_DATA2_HE_TB_EXT_SPTL_REUSE4),
-					      IEEE80211_RADIOTAP_HE_DATA4_TB_SPTL_REUSE4);
-		fallthrough;
-	case IWL_RX_PHY_INFO_TYPE_HE_SU:
-	case IWL_RX_PHY_INFO_TYPE_HE_MU:
-	case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
-	case IWL_RX_PHY_INFO_TYPE_HE_TB:
-		/* HE common */
-		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_LDPC_XSYMSEG_KNOWN |
-					 IEEE80211_RADIOTAP_HE_DATA1_DOPPLER_KNOWN |
-					 IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN);
-		he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN |
-					 IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN |
-					 IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN |
-					 IEEE80211_RADIOTAP_HE_DATA2_NUM_LTF_SYMS_KNOWN);
-		he->data3 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_BSS_COLOR_MASK),
-					      IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR);
-		if (phy_data->info_type != IWL_RX_PHY_INFO_TYPE_HE_TB &&
-		    phy_data->info_type != IWL_RX_PHY_INFO_TYPE_HE_TB_EXT) {
-			he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_UL_DL_KNOWN);
-			he->data3 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_UPLINK),
-						      IEEE80211_RADIOTAP_HE_DATA3_UL_DL);
-		}
-		he->data3 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_LDPC_EXT_SYM),
-					      IEEE80211_RADIOTAP_HE_DATA3_LDPC_XSYMSEG);
-		he->data5 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_PRE_FEC_PAD_MASK),
-					      IEEE80211_RADIOTAP_HE_DATA5_PRE_FEC_PAD);
-		he->data5 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_PE_DISAMBIG),
-					      IEEE80211_RADIOTAP_HE_DATA5_PE_DISAMBIG);
-		he->data5 |= le16_encode_bits(le32_get_bits(phy_data->data1,
-							    IWL_RX_PHY_DATA1_HE_LTF_NUM_MASK),
-					      IEEE80211_RADIOTAP_HE_DATA5_NUM_LTF_SYMS);
-		he->data6 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_TXOP_DUR_MASK),
-					      IEEE80211_RADIOTAP_HE_DATA6_TXOP);
-		he->data6 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_DOPPLER),
-					      IEEE80211_RADIOTAP_HE_DATA6_DOPPLER);
-		break;
-	}
+	u32 rate_n_flags = phy_data->rate_n_flags;
+	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
+	u32 nsts;
 
-	switch (phy_data->info_type) {
-	case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
-	case IWL_RX_PHY_INFO_TYPE_HE_MU:
-	case IWL_RX_PHY_INFO_TYPE_HE_SU:
-		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN);
-		he->data4 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_SPATIAL_REUSE_MASK),
-					      IEEE80211_RADIOTAP_HE_DATA4_SU_MU_SPTL_REUSE);
-		break;
-	default:
-		/* nothing here */
-		break;
-	}
+	switch (he_type) {
+	case RATE_MCS_HE_TYPE_TRIG:
+		iwl_mld_decode_he_tb_phy_data(phy_data, he, rx_status);
+		/* that's it, below is only for SU/MU */
+		return;
+	case RATE_MCS_HE_TYPE_MU:
+		iwl_mld_decode_he_mu(phy_data, he, he_mu, rx_status);
 
-	switch (phy_data->info_type) {
-	case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
-		he_mu->flags1 |=
-			le16_encode_bits(le16_get_bits(phy_data->data4,
-						       IWL_RX_PHY_DATA4_HE_MU_EXT_SIGB_DCM),
-					 IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM);
-		he_mu->flags1 |=
-			le16_encode_bits(le16_get_bits(phy_data->data4,
-						       IWL_RX_PHY_DATA4_HE_MU_EXT_SIGB_MCS_MASK),
-					 IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS);
-		he_mu->flags2 |=
-			le16_encode_bits(le16_get_bits(phy_data->data4,
-						       IWL_RX_PHY_DATA4_HE_MU_EXT_PREAMBLE_PUNC_TYPE_MASK),
-					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW);
-		iwl_mld_decode_he_mu_ext(phy_data, he_mu);
-		fallthrough;
-	case IWL_RX_PHY_INFO_TYPE_HE_MU:
-		he_mu->flags2 |=
-			le16_encode_bits(le32_get_bits(phy_data->data1,
-						       IWL_RX_PHY_DATA1_HE_MU_SIBG_SYM_OR_USER_NUM_MASK),
-					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_SYMS_USERS);
-		he_mu->flags2 |=
-			le16_encode_bits(le32_get_bits(phy_data->data1,
-						       IWL_RX_PHY_DATA1_HE_MU_SIGB_COMPRESSION),
-					 IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_COMP);
-		fallthrough;
-	case IWL_RX_PHY_INFO_TYPE_HE_TB:
-	case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
-		iwl_mld_decode_he_phy_ru_alloc(phy_data, he, he_mu, rx_status);
+		nsts = le32_get_bits(phy_data->ntfy->sigs.he.b,
+				     OFDM_RX_FRAME_HE_SIGB_NSTS) + 1;
 		break;
-	case IWL_RX_PHY_INFO_TYPE_HE_SU:
+	case RATE_MCS_HE_TYPE_SU:
+	case RATE_MCS_HE_TYPE_EXT_SU:
 		he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BEAM_CHANGE_KNOWN);
-		he->data3 |= le16_encode_bits(le32_get_bits(phy_data->data0,
-							    IWL_RX_PHY_DATA0_HE_BEAM_CHNG),
-					      IEEE80211_RADIOTAP_HE_DATA3_BEAM_CHANGE);
-		break;
-	default:
-		/* nothing */
+		he->data3 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a1,
+					 OFDM_RX_FRAME_HE_BEAM_CHANGE,
+					 IEEE80211_RADIOTAP_HE_DATA3_BEAM_CHANGE);
+
+		nsts = le32_get_bits(phy_data->ntfy->sigs.he.a1,
+				     OFDM_RX_FRAME_HE_NSTS) + 1;
 		break;
 	}
+
+	rx_status->nss = nsts >> !!(rate_n_flags & RATE_MCS_STBC_MSK);
+
+	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_LDPC_XSYMSEG_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_DOPPLER_KNOWN);
+	he->data2 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_PRE_FEC_PAD_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_PE_DISAMBIG_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_TXOP_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA2_NUM_LTF_SYMS_KNOWN);
+
+	he->data3 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
+				 OFDM_RX_FRAME_HE_CODING_EXTRA_SYM,
+				 IEEE80211_RADIOTAP_HE_DATA3_LDPC_XSYMSEG);
+	he->data5 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
+				 OFDM_RX_FRAME_HE_PRE_FEC_PAD_FACTOR,
+				 IEEE80211_RADIOTAP_HE_DATA5_PRE_FEC_PAD);
+	he->data5 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
+				 OFDM_RX_FRAME_HE_PE_DISAMBIG,
+				 IEEE80211_RADIOTAP_HE_DATA5_PE_DISAMBIG);
+	he->data5 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
+				 OFDM_RX_FRAME_HE_MU_NUM_OF_LTF_SYM,
+				 IEEE80211_RADIOTAP_HE_DATA5_NUM_LTF_SYMS);
+	he->data6 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
+				 OFDM_RX_FRAME_HE_TXOP_DURATION,
+				 IEEE80211_RADIOTAP_HE_DATA6_TXOP);
+	he->data6 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
+				 OFDM_RX_FRAME_HE_DOPPLER,
+				 IEEE80211_RADIOTAP_HE_DATA6_DOPPLER);
+
+	he->data1 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_UL_DL_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_BSS_COLOR_KNOWN |
+				 IEEE80211_RADIOTAP_HE_DATA1_SPTL_REUSE_KNOWN);
+
+	he->data3 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a1,
+				 OFDM_RX_FRAME_HE_BSS_COLOR,
+				 IEEE80211_RADIOTAP_HE_DATA3_BSS_COLOR);
+	he->data3 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a1,
+				 OFDM_RX_FRAME_HE_UL_FLAG,
+				 IEEE80211_RADIOTAP_HE_DATA3_UL_DL);
+	he->data4 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a1,
+				 OFDM_RX_FRAME_HE_SPATIAL_REUSE,
+				 IEEE80211_RADIOTAP_HE_DATA4_SU_MU_SPTL_REUSE);
 }
 
-static void iwl_mld_rx_he(struct iwl_mld *mld, struct sk_buff *skb,
-			  struct iwl_mld_rx_phy_data *phy_data,
-			  int queue)
+static void iwl_mld_rx_he(struct sk_buff *skb,
+			  struct iwl_mld_rx_phy_data *phy_data)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_radiotap_he *he = NULL;
@@ -510,48 +529,28 @@ static void iwl_mld_rx_he(struct iwl_mld *mld, struct sk_buff *skb,
 		.flags2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN |
 				      IEEE80211_RADIOTAP_HE_MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN),
 	};
-	u16 phy_info = phy_data->phy_info;
 
 	he = skb_put_data(skb, &known, sizeof(known));
 	rx_status->flag |= RX_FLAG_RADIOTAP_HE;
 
-	if (phy_data->info_type == IWL_RX_PHY_INFO_TYPE_HE_MU ||
-	    phy_data->info_type == IWL_RX_PHY_INFO_TYPE_HE_MU_EXT) {
-		he_mu = skb_put_data(skb, &mu_known, sizeof(mu_known));
-		rx_status->flag |= RX_FLAG_RADIOTAP_HE_MU;
-	}
-
-	/* report the AMPDU-EOF bit on single frames */
-	if (!queue && !(phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
-		rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
-		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
-		if (phy_data->data0 & cpu_to_le32(IWL_RX_PHY_DATA0_HE_DELIM_EOF))
-			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
-	}
-
-	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
-		iwl_mld_decode_he_phy_data(phy_data, he, he_mu, rx_status,
-					   queue);
-
-	/* update aggregation data for monitor sake on default queue */
-	if (!queue && (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) &&
-	    (phy_info & IWL_RX_MPDU_PHY_AMPDU) && phy_data->first_subframe) {
-		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
-		if (phy_data->data0 & cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
-			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
-	}
-
-	if (he_type == RATE_MCS_HE_TYPE_EXT_SU &&
-	    rate_n_flags & RATE_MCS_HE_106T_MSK) {
-		rx_status->bw = RATE_INFO_BW_HE_RU;
-		rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
-	}
-
-	/* actually data is filled in mac80211 */
-	if (he_type == RATE_MCS_HE_TYPE_SU ||
-	    he_type == RATE_MCS_HE_TYPE_EXT_SU)
+	switch (he_type) {
+	case RATE_MCS_HE_TYPE_EXT_SU:
+		/*
+		 * Except for this special case we won't have
+		 * HE RU allocation info outside of monitor mode
+		 * since we don't get the PHY notif.
+		 */
+		if (rate_n_flags & RATE_MCS_HE_106T_MSK) {
+			rx_status->bw = RATE_INFO_BW_HE_RU;
+			rx_status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		}
+		fallthrough;
+	case RATE_MCS_HE_TYPE_SU:
+		/* actual data is filled in mac80211 */
 		he->data1 |=
 			cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN);
+		break;
+	}
 
 #define CHECK_TYPE(F)							\
 	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA1_FORMAT_ ## F !=	\
@@ -567,8 +566,7 @@ static void iwl_mld_rx_he(struct iwl_mld *mld, struct sk_buff *skb,
 	if (rate_n_flags & RATE_MCS_BF_MSK)
 		he->data5 |= cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA5_TXBF);
 
-	switch ((rate_n_flags & RATE_MCS_HE_GI_LTF_MSK) >>
-		RATE_MCS_HE_GI_LTF_POS) {
+	switch (u32_get_bits(rate_n_flags, RATE_MCS_HE_GI_LTF_MSK)) {
 	case 0:
 		if (he_type == RATE_MCS_HE_TYPE_TRIG)
 			rx_status->he_gi = NL80211_RATE_INFO_HE_GI_1_6;
@@ -609,37 +607,52 @@ static void iwl_mld_rx_he(struct iwl_mld *mld, struct sk_buff *skb,
 
 	he->data5 |= le16_encode_bits(ltf,
 				      IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+
+	if (likely(!phy_data->ntfy))
+		return;
+
+	if (he_type == RATE_MCS_HE_TYPE_MU) {
+		he_mu = skb_put_data(skb, &mu_known, sizeof(mu_known));
+		rx_status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+	}
+
+	iwl_mld_decode_he_phy_data(phy_data, he, he_mu, rx_status);
 }
 
 static void iwl_mld_decode_lsig(struct sk_buff *skb,
 				struct iwl_mld_rx_phy_data *phy_data)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+	u32 format = phy_data->rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 	struct ieee80211_radiotap_lsig *lsig;
+	u32 lsig_len, rate;
 
-	switch (phy_data->info_type) {
-	case IWL_RX_PHY_INFO_TYPE_HT:
-	case IWL_RX_PHY_INFO_TYPE_VHT_SU:
-	case IWL_RX_PHY_INFO_TYPE_VHT_MU:
-	case IWL_RX_PHY_INFO_TYPE_HE_TB_EXT:
-	case IWL_RX_PHY_INFO_TYPE_HE_SU:
-	case IWL_RX_PHY_INFO_TYPE_HE_MU:
-	case IWL_RX_PHY_INFO_TYPE_HE_MU_EXT:
-	case IWL_RX_PHY_INFO_TYPE_HE_TB:
-	case IWL_RX_PHY_INFO_TYPE_EHT_MU:
-	case IWL_RX_PHY_INFO_TYPE_EHT_TB:
-	case IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT:
-	case IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT:
-		lsig = skb_put(skb, sizeof(*lsig));
-		lsig->data1 = cpu_to_le16(IEEE80211_RADIOTAP_LSIG_DATA1_LENGTH_KNOWN);
-		lsig->data2 = le16_encode_bits(le32_get_bits(phy_data->data1,
-							     IWL_RX_PHY_DATA1_LSIG_LEN_MASK),
-					       IEEE80211_RADIOTAP_LSIG_DATA2_LENGTH);
-		rx_status->flag |= RX_FLAG_RADIOTAP_LSIG;
-		break;
-	default:
-		break;
-	}
+	if (likely(!phy_data->ntfy))
+		return;
+
+	/*
+	 * Technically legacy CCK/OFDM frames don't have an L-SIG
+	 * since that's the compat format for HT (non-greenfield)
+	 * and up. However, it's meant to be compatible with the
+	 * LENGTH and RATE fields in Clause 17 and 18 OFDM frames
+	 * so include the field for any non-CCK frame. For CCK it
+	 * cannot work, since the LENGTH field for them is 16-bit
+	 * and the radiotap field only has 12 bits.
+	 */
+	if (format == RATE_MCS_MOD_TYPE_CCK)
+		return;
+
+	lsig_len = le32_get_bits(phy_data->ntfy->legacy_sig.ofdm,
+				 OFDM_RX_LEGACY_LENGTH);
+	rate = le32_get_bits(phy_data->ntfy->legacy_sig.ofdm, OFDM_RX_RATE);
+
+	lsig = skb_put(skb, sizeof(*lsig));
+	lsig->data1 = cpu_to_le16(IEEE80211_RADIOTAP_LSIG_DATA1_LENGTH_KNOWN) |
+		      cpu_to_le16(IEEE80211_RADIOTAP_LSIG_DATA1_RATE_KNOWN);
+	lsig->data2 = le16_encode_bits(lsig_len,
+				       IEEE80211_RADIOTAP_LSIG_DATA2_LENGTH) |
+		      le16_encode_bits(rate, IEEE80211_RADIOTAP_LSIG_DATA2_RATE);
+	rx_status->flag |= RX_FLAG_RADIOTAP_LSIG;
 }
 
 /* Put a TLV on the skb and return data pointer
@@ -667,209 +680,144 @@ iwl_mld_radiotap_put_tlv(struct sk_buff *skb, u16 type, u16 len)
 	(_usig)->value |= LE32_DEC_ENC(in_value, dec_bits, _enc_bits); \
 } while (0)
 
-#define __IWL_MLD_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru) \
-	eht->data[(rt_data)] |= \
-		(cpu_to_le32 \
-		 (IEEE80211_RADIOTAP_EHT_DATA ## rt_data ## _RU_ALLOC_CC_ ## rt_ru ## _KNOWN) | \
-		 LE32_DEC_ENC(data ## fw_data, \
-			      IWL_RX_PHY_DATA ## fw_data ## _EHT_MU_EXT_RU_ALLOC_ ## fw_ru, \
-			      IEEE80211_RADIOTAP_EHT_DATA ## rt_data ## _RU_ALLOC_CC_ ## rt_ru))
+static void iwl_mld_decode_eht_usig_tb(struct iwl_mld_rx_phy_data *phy_data,
+				       struct ieee80211_radiotap_eht_usig *usig)
+{
+	__le32 usig_a1 = phy_data->ntfy->sigs.eht_tb.usig_a1;
+	__le32 usig_a2 = phy_data->ntfy->sigs.eht_tb.usig_a2_eht;
+
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a1,
+				    OFDM_RX_FRAME_EHT_USIG1_DISREGARD,
+				    IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_PPDU_TYPE,
+				    IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_USIG2_VALIDATE_B2,
+				    IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_TRIG_SPATIAL_REUSE_1,
+				    IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_TRIG_SPATIAL_REUSE_2,
+				    IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_TRIG_USIG2_DISREGARD,
+				    IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD);
+}
 
-#define _IWL_MLD_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru)	\
-	__IWL_MLD_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru)
+static void iwl_mld_decode_eht_usig_non_tb(struct iwl_mld_rx_phy_data *phy_data,
+					   struct ieee80211_radiotap_eht_usig *usig)
+{
+	__le32 usig_a1 = phy_data->ntfy->sigs.eht.usig_a1;
+	__le32 usig_a2 = phy_data->ntfy->sigs.eht.usig_a2_eht;
+
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a1,
+				    OFDM_RX_FRAME_EHT_USIG1_DISREGARD,
+				    IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a1,
+				    OFDM_RX_FRAME_EHT_USIG1_VALIDATE,
+				    IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_PPDU_TYPE,
+				    IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_USIG2_VALIDATE_B2,
+				    IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_PUNC_CHANNEL,
+				    IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_USIG2_VALIDATE_B8,
+				    IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_SIG_MCS,
+				    IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS);
+	IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
+				    OFDM_RX_FRAME_EHT_SIG_SYM_NUM,
+				    IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS);
+}
 
-#define IEEE80211_RADIOTAP_RU_DATA_1_1_1	1
-#define IEEE80211_RADIOTAP_RU_DATA_2_1_1	2
-#define IEEE80211_RADIOTAP_RU_DATA_1_1_2	2
-#define IEEE80211_RADIOTAP_RU_DATA_2_1_2	2
-#define IEEE80211_RADIOTAP_RU_DATA_1_2_1	3
-#define IEEE80211_RADIOTAP_RU_DATA_2_2_1	3
-#define IEEE80211_RADIOTAP_RU_DATA_1_2_2	3
-#define IEEE80211_RADIOTAP_RU_DATA_2_2_2	4
+static void iwl_mld_decode_eht_usig(struct iwl_mld_rx_phy_data *phy_data,
+				    struct sk_buff *skb)
+{
+	u32 he_type = phy_data->rate_n_flags & RATE_MCS_HE_TYPE_MSK;
+	__le32 usig_a1 = phy_data->ntfy->sigs.eht.usig_a1;
+	__le32 usig_a2 = phy_data->ntfy->sigs.eht.usig_a2_eht;
+	struct ieee80211_radiotap_eht_usig *usig;
+	u32 bw;
 
-#define IWL_RX_RU_DATA_A1			2
-#define IWL_RX_RU_DATA_A2			2
-#define IWL_RX_RU_DATA_B1			2
-#define IWL_RX_RU_DATA_B2			4
-#define IWL_RX_RU_DATA_C1			3
-#define IWL_RX_RU_DATA_C2			3
-#define IWL_RX_RU_DATA_D1			4
-#define IWL_RX_RU_DATA_D2			4
+	usig = iwl_mld_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT_USIG,
+					sizeof(*usig));
 
-#define IWL_MLD_ENC_EHT_RU(rt_ru, fw_ru)				\
-	_IWL_MLD_ENC_EHT_RU(IEEE80211_RADIOTAP_RU_DATA_ ## rt_ru,	\
-			    rt_ru,					\
-			    IWL_RX_RU_DATA_ ## fw_ru,			\
-			    fw_ru)
+	BUILD_BUG_ON(offsetof(union iwl_sigs, eht.usig_a1) !=
+		     offsetof(union iwl_sigs, eht_tb.usig_a1));
+	BUILD_BUG_ON(offsetof(union iwl_sigs, eht.usig_a2_eht) !=
+		     offsetof(union iwl_sigs, eht_tb.usig_a2_eht));
 
-static void iwl_mld_decode_eht_ext_mu(struct iwl_mld *mld,
-				      struct iwl_mld_rx_phy_data *phy_data,
-				      struct ieee80211_rx_status *rx_status,
-				      struct ieee80211_radiotap_eht *eht,
-				      struct ieee80211_radiotap_eht_usig *usig)
-{
-	if (phy_data->with_data) {
-		__le32 data1 = phy_data->data1;
-		__le32 data2 = phy_data->data2;
-		__le32 data3 = phy_data->data3;
-		__le32 data4 = phy_data->eht_data4;
-		__le32 data5 = phy_data->data5;
-		u32 phy_bw = phy_data->rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK;
-
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, data5,
-					    IWL_RX_PHY_DATA5_EHT_TYPE_AND_COMP,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, data5,
-					    IWL_RX_PHY_DATA5_EHT_MU_PUNC_CH_CODE,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, data4,
-					    IWL_RX_PHY_DATA4_EHT_MU_EXT_SIGB_MCS,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS);
-		IWL_MLD_ENC_USIG_VALUE_MASK
-			(usig, data1, IWL_RX_PHY_DATA1_EHT_MU_NUM_SIG_SYM_USIGA2,
-			 IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS);
+	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
+				    IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN |
+				    IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_CHECKED |
+				    IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN |
+				    IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN);
 
-		eht->user_info[0] |=
-			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN) |
-			LE32_DEC_ENC(data5, IWL_RX_PHY_DATA5_EHT_MU_STA_ID_USR,
-				     IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID);
+#define CHECK_BW(bw) \
+	BUILD_BUG_ON(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_ ## bw ## MHZ != \
+		     RATE_MCS_CHAN_WIDTH_ ## bw ## _VAL)
+	CHECK_BW(20);
+	CHECK_BW(40);
+	CHECK_BW(80);
+	CHECK_BW(160);
+#undef CHECK_BW
+	BUILD_BUG_ON(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_320MHZ_1 !=
+		     RATE_MCS_CHAN_WIDTH_320_VAL);
+	bw = u32_get_bits(phy_data->rate_n_flags, RATE_MCS_CHAN_WIDTH_MSK);
+	/* specific handling for 320MHz-1/320MHz-2 */
+	if (bw == RATE_MCS_CHAN_WIDTH_320_VAL)
+		bw += le32_get_bits(usig_a1, OFDM_RX_FRAME_EHT_BW320_SLOT);
+	usig->common |= le32_encode_bits(bw,
+					 IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW);
 
-		eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_NR_NON_OFDMA_USERS_M);
-		eht->data[7] |= LE32_DEC_ENC
-			(data5, IWL_RX_PHY_DATA5_EHT_MU_NUM_USR_NON_OFDMA,
-			 IEEE80211_RADIOTAP_EHT_DATA7_NUM_OF_NON_OFDMA_USERS);
+	usig->common |= LE32_DEC_ENC(usig_a1, OFDM_RX_FRAME_ENHANCED_WIFI_UL_FLAG,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL);
+	usig->common |= LE32_DEC_ENC(usig_a1, OFDM_RX_FRAME_ENHANCED_WIFI_BSS_COLOR,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR);
 
-		/*
-		 * Hardware labels the content channels/RU allocation values
-		 * as follows:
-		 *           Content Channel 1		Content Channel 2
-		 *   20 MHz: A1
-		 *   40 MHz: A1				B1
-		 *   80 MHz: A1 C1			B1 D1
-		 *  160 MHz: A1 C1 A2 C2		B1 D1 B2 D2
-		 *  320 MHz: A1 C1 A2 C2 A3 C3 A4 C4	B1 D1 B2 D2 B3 D3 B4 D4
-		 *
-		 * However firmware can only give us A1-D2, so the higher
-		 * frequencies are missing.
-		 */
+	if (le32_get_bits(usig_a1, OFDM_RX_FRAME_EHT_USIG1_VALIDATE) &&
+	    le32_get_bits(usig_a2, OFDM_RX_FRAME_EHT_USIG2_VALIDATE_B2) &&
+	    le32_get_bits(usig_a2, OFDM_RX_FRAME_EHT_USIG2_VALIDATE_B8))
+		usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_OK);
 
-		switch (phy_bw) {
-		case RATE_MCS_CHAN_WIDTH_320:
-			/* additional values are missing in RX metadata */
-			fallthrough;
-		case RATE_MCS_CHAN_WIDTH_160:
-			/* content channel 1 */
-			IWL_MLD_ENC_EHT_RU(1_2_1, A2);
-			IWL_MLD_ENC_EHT_RU(1_2_2, C2);
-			/* content channel 2 */
-			IWL_MLD_ENC_EHT_RU(2_2_1, B2);
-			IWL_MLD_ENC_EHT_RU(2_2_2, D2);
-			fallthrough;
-		case RATE_MCS_CHAN_WIDTH_80:
-			/* content channel 1 */
-			IWL_MLD_ENC_EHT_RU(1_1_2, C1);
-			/* content channel 2 */
-			IWL_MLD_ENC_EHT_RU(2_1_2, D1);
-			fallthrough;
-		case RATE_MCS_CHAN_WIDTH_40:
-			/* content channel 2 */
-			IWL_MLD_ENC_EHT_RU(2_1_1, B1);
-			fallthrough;
-		case RATE_MCS_CHAN_WIDTH_20:
-			IWL_MLD_ENC_EHT_RU(1_1_1, A1);
-			break;
-		}
-	} else {
-		__le32 usig_a1 = phy_data->rx_vec[0];
-		__le32 usig_a2 = phy_data->rx_vec[1];
-
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a1,
-					    IWL_RX_USIG_A1_DISREGARD,
-					    IEEE80211_RADIOTAP_EHT_USIG1_MU_B20_B24_DISREGARD);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a1,
-					    IWL_RX_USIG_A1_VALIDATE,
-					    IEEE80211_RADIOTAP_EHT_USIG1_MU_B25_VALIDATE);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_PPDU_TYPE,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B0_B1_PPDU_TYPE);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_USIG2_VALIDATE_B2,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B2_VALIDATE);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_PUNC_CHANNEL,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B3_B7_PUNCTURED_INFO);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_USIG2_VALIDATE_B8,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B8_VALIDATE);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_SIG_MCS,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B9_B10_SIG_MCS);
-		IWL_MLD_ENC_USIG_VALUE_MASK
-			(usig, usig_a2, IWL_RX_USIG_A2_EHT_SIG_SYM_NUM,
-			 IEEE80211_RADIOTAP_EHT_USIG2_MU_B11_B15_EHT_SIG_SYMBOLS);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_CRC_OK,
-					    IEEE80211_RADIOTAP_EHT_USIG2_MU_B16_B19_CRC);
-	}
-}
+	usig->common |= LE32_DEC_ENC(usig_a1,
+				     OFDM_RX_FRAME_ENHANCED_WIFI_TXOP_DURATION,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
 
-static void iwl_mld_decode_eht_ext_tb(struct iwl_mld *mld,
-				      struct iwl_mld_rx_phy_data *phy_data,
-				      struct ieee80211_rx_status *rx_status,
-				      struct ieee80211_radiotap_eht *eht,
-				      struct ieee80211_radiotap_eht_usig *usig)
-{
-	if (phy_data->with_data) {
-		__le32 data5 = phy_data->data5;
-
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, data5,
-					    IWL_RX_PHY_DATA5_EHT_TYPE_AND_COMP,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, data5,
-					    IWL_RX_PHY_DATA5_EHT_TB_SPATIAL_REUSE1,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1);
-
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, data5,
-					    IWL_RX_PHY_DATA5_EHT_TB_SPATIAL_REUSE2,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2);
-	} else {
-		__le32 usig_a1 = phy_data->rx_vec[0];
-		__le32 usig_a2 = phy_data->rx_vec[1];
-
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a1,
-					    IWL_RX_USIG_A1_DISREGARD,
-					    IEEE80211_RADIOTAP_EHT_USIG1_TB_B20_B25_DISREGARD);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_PPDU_TYPE,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B0_B1_PPDU_TYPE);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_USIG2_VALIDATE_B2,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B2_VALIDATE);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_TRIG_SPATIAL_REUSE_1,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B3_B6_SPATIAL_REUSE_1);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_TRIG_SPATIAL_REUSE_2,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B7_B10_SPATIAL_REUSE_2);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_TRIG_USIG2_DISREGARD,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B11_B15_DISREGARD);
-		IWL_MLD_ENC_USIG_VALUE_MASK(usig, usig_a2,
-					    IWL_RX_USIG_A2_EHT_CRC_OK,
-					    IEEE80211_RADIOTAP_EHT_USIG2_TB_B16_B19_CRC);
-	}
+	if (!le32_get_bits(usig_a2, OFDM_RX_USIG_CRC_OK))
+		usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
+
+	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN);
+	usig->common |= LE32_DEC_ENC(usig_a1,
+				     OFDM_RX_FRAME_ENHANCED_WIFI_VER_ID,
+				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER);
+
+	if (he_type == RATE_MCS_HE_TYPE_TRIG)
+		iwl_mld_decode_eht_usig_tb(phy_data, usig);
+	else
+		iwl_mld_decode_eht_usig_non_tb(phy_data, usig);
 }
 
-static void iwl_mld_decode_eht_ru(struct iwl_mld *mld,
-				  struct ieee80211_rx_status *rx_status,
-				  struct ieee80211_radiotap_eht *eht)
+static void
+iwl_mld_eht_set_ru_alloc(struct ieee80211_rx_status *rx_status,
+			 u32 ru_with_p80)
 {
-	u32 ru = le32_get_bits(eht->data[8],
-			       IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B7_B1);
 	enum nl80211_eht_ru_alloc nl_ru;
+	u32 ru = ru_with_p80 >> 1;
 
-	/* Using D1.5 Table 9-53a - Encoding of PS160 and RU Allocation subfields
-	 * in an EHT variant User Info field
+	/*
+	 * HW always uses trigger frame format:
+	 *
+	 * Draft PIEEE802.11be D7.0 Table 9-46l - Encoding of the PS160 and
+	 * RU Allocation subfields in an EHT variant User Info field
 	 */
 
 	switch (ru) {
@@ -929,135 +877,228 @@ static void iwl_mld_decode_eht_ru(struct iwl_mld *mld,
 	rx_status->eht.ru = nl_ru;
 }
 
-static void iwl_mld_decode_eht_phy_data(struct iwl_mld *mld,
-					struct iwl_mld_rx_phy_data *phy_data,
-					struct ieee80211_rx_status *rx_status,
-					struct ieee80211_radiotap_eht *eht,
-					struct ieee80211_radiotap_eht_usig *usig)
-
+static void iwl_mld_decode_eht_tb(struct iwl_mld_rx_phy_data *phy_data,
+				  struct ieee80211_rx_status *rx_status,
+				  struct ieee80211_radiotap_eht *eht)
 {
-	__le32 data0 = phy_data->data0;
-	__le32 data1 = phy_data->data1;
-	__le32 usig_a1 = phy_data->rx_vec[0];
-	u8 info_type = phy_data->info_type;
-
-	/* Not in EHT range */
-	if (info_type < IWL_RX_PHY_INFO_TYPE_EHT_MU ||
-	    info_type > IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT)
+	if (!(phy_data->ntfy->flags & IWL_SNIF_FLAG_VALID_TB_RX))
 		return;
 
-	usig->common |= cpu_to_le32
-		(IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
-		 IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN);
-	if (phy_data->with_data) {
-		usig->common |= LE32_DEC_ENC(data0,
-					     IWL_RX_PHY_DATA0_EHT_UPLINK,
-					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL);
-		usig->common |= LE32_DEC_ENC(data0,
-					     IWL_RX_PHY_DATA0_EHT_BSS_COLOR_MASK,
-					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR);
-	} else {
-		usig->common |= LE32_DEC_ENC(usig_a1,
-					     IWL_RX_USIG_A1_UL_FLAG,
-					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL);
-		usig->common |= LE32_DEC_ENC(usig_a1,
-					     IWL_RX_USIG_A1_BSS_COLOR,
-					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR);
-	}
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_RU_ALLOC_TB_FMT |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_LDPC_EXTRA_SYM_OM |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_PRE_PADD_FACOR_OM |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_PE_DISAMBIGUITY_OM |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_PRIMARY_80);
 
-	usig->common |=
-		cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_CHECKED);
-	usig->common |=
-		LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_VALIDATE,
-			     IEEE80211_RADIOTAP_EHT_USIG_COMMON_VALIDATE_BITS_OK);
-
-	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE);
-	eht->data[0] |= LE32_DEC_ENC(data0,
-				     IWL_RX_PHY_DATA0_ETH_SPATIAL_REUSE_MASK,
-				     IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
-
-	/* All RU allocating size/index is in TB format */
-	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_RU_ALLOC_TB_FMT);
-	eht->data[8] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PS160,
+	eht->data[8] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht_tb.tb_rx0,
+				     OFDM_UCODE_TRIG_BASE_PS160,
 				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_PS_160);
-	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_RU_ALLOC_B0,
-				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B0);
-	eht->data[8] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_RU_ALLOC_B1_B7,
+	eht->data[8] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht_tb.tb_rx1,
+				     OFDM_UCODE_TRIG_BASE_RX_RU,
+				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B0 |
 				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B7_B1);
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht_tb.tb_rx1,
+				     OFDM_UCODE_TRIG_BASE_RX_CODING_EXTRA_SYM,
+				     IEEE80211_RADIOTAP_EHT_DATA0_LDPC_EXTRA_SYM_OM);
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht_tb.tb_rx1,
+				     OFDM_UCODE_TRIG_BASE_RX_PRE_FEC_PAD_FACTOR,
+				     IEEE80211_RADIOTAP_EHT_DATA0_PRE_PADD_FACOR_OM);
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht_tb.tb_rx1,
+				     OFDM_UCODE_TRIG_BASE_RX_PE_DISAMBIG,
+				     IEEE80211_RADIOTAP_EHT_DATA0_PE_DISAMBIGUITY_OM);
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht_tb.tb_rx1,
+				     OFDM_UCODE_TRIG_BASE_RX_NUM_OF_LTF_SYM,
+				     IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
+	eht->data[1] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht_tb.tb_rx0,
+				     OFDM_UCODE_TRIG_BASE_RX_RU_P80,
+				     IEEE80211_RADIOTAP_EHT_DATA1_PRIMARY_80);
 
-	iwl_mld_decode_eht_ru(mld, rx_status, eht);
-
-	/* We only get here in case of IWL_RX_MPDU_PHY_TSF_OVERLOAD is set
-	 * which is on only in case of monitor mode so no need to check monitor
-	 * mode
-	 */
-	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_PRIMARY_80);
-	eht->data[1] |=
-		le32_encode_bits(mld->monitor.p80,
-				 IEEE80211_RADIOTAP_EHT_DATA1_PRIMARY_80);
-
-	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN);
-	if (phy_data->with_data)
-		usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_TXOP_DUR_MASK,
-					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
-	else
-		usig->common |= LE32_DEC_ENC(usig_a1, IWL_RX_USIG_A1_TXOP_DURATION,
-					     IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
+	iwl_mld_eht_set_ru_alloc(rx_status,
+				 le32_get_bits(phy_data->ntfy->sigs.eht_tb.tb_rx1,
+					       OFDM_UCODE_TRIG_BASE_RX_RU));
+}
 
-	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_LDPC_EXTRA_SYM_OM);
-	eht->data[0] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_LDPC_EXT_SYM,
-				     IEEE80211_RADIOTAP_EHT_DATA0_LDPC_EXTRA_SYM_OM);
+static void iwl_mld_eht_decode_user_ru(struct iwl_mld_rx_phy_data *phy_data,
+				       struct ieee80211_radiotap_eht *eht)
+{
+	u32 phy_bw = phy_data->rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK;
 
-	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_PRE_PADD_FACOR_OM);
-	eht->data[0] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PRE_FEC_PAD_MASK,
-				    IEEE80211_RADIOTAP_EHT_DATA0_PRE_PADD_FACOR_OM);
+	if (!(phy_data->ntfy->flags & IWL_SNIF_FLAG_VALID_RU))
+		return;
 
-	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_PE_DISAMBIGUITY_OM);
-	eht->data[0] |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PE_DISAMBIG,
-				     IEEE80211_RADIOTAP_EHT_DATA0_PE_DISAMBIGUITY_OM);
+#define __IWL_MLD_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru) \
+	eht->data[(rt_data)] |= \
+		(cpu_to_le32(IEEE80211_RADIOTAP_EHT_DATA ## rt_data ## _RU_ALLOC_CC_ ## rt_ru ## _KNOWN) | \
+		 LE32_DEC_ENC(phy_data->ntfy->sigs.eht.cmn[fw_data], \
+			      OFDM_RX_FRAME_EHT_RU_ALLOC_ ## fw_data ## _ ## fw_ru, \
+			      IEEE80211_RADIOTAP_EHT_DATA ## rt_data ## _RU_ALLOC_CC_ ## rt_ru))
 
-	/* TODO: what about IWL_RX_PHY_DATA0_EHT_BW320_SLOT */
+#define _IWL_MLD_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru)	\
+	__IWL_MLD_ENC_EHT_RU(rt_data, rt_ru, fw_data, fw_ru)
 
-	if (!le32_get_bits(data0, IWL_RX_PHY_DATA0_EHT_SIGA_CRC_OK))
-		usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BAD_USIG_CRC);
+#define IEEE80211_RADIOTAP_RU_DATA_1_1_1	1
+#define IEEE80211_RADIOTAP_RU_DATA_2_1_1	2
+#define IEEE80211_RADIOTAP_RU_DATA_1_1_2	2
+#define IEEE80211_RADIOTAP_RU_DATA_2_1_2	2
+#define IEEE80211_RADIOTAP_RU_DATA_1_2_1	3
+#define IEEE80211_RADIOTAP_RU_DATA_2_2_1	3
+#define IEEE80211_RADIOTAP_RU_DATA_1_2_2	3
+#define IEEE80211_RADIOTAP_RU_DATA_2_2_2	4
+#define IEEE80211_RADIOTAP_RU_DATA_1_2_3	4
+#define IEEE80211_RADIOTAP_RU_DATA_2_2_3	4
+#define IEEE80211_RADIOTAP_RU_DATA_1_2_4	5
+#define IEEE80211_RADIOTAP_RU_DATA_2_2_4	5
+#define IEEE80211_RADIOTAP_RU_DATA_1_2_5	5
+#define IEEE80211_RADIOTAP_RU_DATA_2_2_5	6
+#define IEEE80211_RADIOTAP_RU_DATA_1_2_6	6
+#define IEEE80211_RADIOTAP_RU_DATA_2_2_6	6
+
+#define IWL_RX_RU_DATA_A1			0
+#define IWL_RX_RU_DATA_A2			0
+#define IWL_RX_RU_DATA_A3			0
+#define IWL_RX_RU_DATA_A4			4
+#define IWL_RX_RU_DATA_B1			1
+#define IWL_RX_RU_DATA_B2			1
+#define IWL_RX_RU_DATA_B3			1
+#define IWL_RX_RU_DATA_B4			4
+#define IWL_RX_RU_DATA_C1			2
+#define IWL_RX_RU_DATA_C2			2
+#define IWL_RX_RU_DATA_C3			2
+#define IWL_RX_RU_DATA_C4			5
+#define IWL_RX_RU_DATA_D1			3
+#define IWL_RX_RU_DATA_D2			3
+#define IWL_RX_RU_DATA_D3			3
+#define IWL_RX_RU_DATA_D4			5
 
-	usig->common |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN);
-	usig->common |= LE32_DEC_ENC(data0, IWL_RX_PHY_DATA0_EHT_PHY_VER,
-				     IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER);
+#define IWL_MLD_ENC_EHT_RU(rt_ru, fw_ru)				\
+	_IWL_MLD_ENC_EHT_RU(IEEE80211_RADIOTAP_RU_DATA_ ## rt_ru,	\
+			    rt_ru,					\
+			    IWL_RX_RU_DATA_ ## fw_ru,			\
+			    fw_ru)
 
 	/*
-	 * TODO: what about TB - IWL_RX_PHY_DATA1_EHT_TB_PILOT_TYPE,
-	 *			 IWL_RX_PHY_DATA1_EHT_TB_LOW_SS
+	 * Hardware labels the content channels/RU allocation values
+	 * as follows:
+	 *
+	 *           Content Channel 1		Content Channel 2
+	 *   20 MHz: A1
+	 *   40 MHz: A1				B1
+	 *   80 MHz: A1 C1			B1 D1
+	 *  160 MHz: A1 C1 A2 C2		B1 D1 B2 D2
+	 *  320 MHz: A1 C1 A2 C2 A3 C3 A4 C4	B1 D1 B2 D2 B3 D3 B4 D4
 	 */
 
-	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF);
-	eht->data[0] |= LE32_DEC_ENC(data1, IWL_RX_PHY_DATA1_EHT_SIG_LTF_NUM,
+	switch (phy_bw) {
+	case RATE_MCS_CHAN_WIDTH_320:
+		/* content channel 1 */
+		IWL_MLD_ENC_EHT_RU(1_2_3, A3);
+		IWL_MLD_ENC_EHT_RU(1_2_4, C3);
+		IWL_MLD_ENC_EHT_RU(1_2_5, A4);
+		IWL_MLD_ENC_EHT_RU(1_2_6, C4);
+		/* content channel 2 */
+		IWL_MLD_ENC_EHT_RU(2_2_3, B3);
+		IWL_MLD_ENC_EHT_RU(2_2_4, D3);
+		IWL_MLD_ENC_EHT_RU(2_2_5, B4);
+		IWL_MLD_ENC_EHT_RU(2_2_6, D4);
+		fallthrough;
+	case RATE_MCS_CHAN_WIDTH_160:
+		/* content channel 1 */
+		IWL_MLD_ENC_EHT_RU(1_2_1, A2);
+		IWL_MLD_ENC_EHT_RU(1_2_2, C2);
+		/* content channel 2 */
+		IWL_MLD_ENC_EHT_RU(2_2_1, B2);
+		IWL_MLD_ENC_EHT_RU(2_2_2, D2);
+		fallthrough;
+	case RATE_MCS_CHAN_WIDTH_80:
+		/* content channel 1 */
+		IWL_MLD_ENC_EHT_RU(1_1_2, C1);
+		/* content channel 2 */
+		IWL_MLD_ENC_EHT_RU(2_1_2, D1);
+		fallthrough;
+	case RATE_MCS_CHAN_WIDTH_40:
+		/* content channel 2 */
+		IWL_MLD_ENC_EHT_RU(2_1_1, B1);
+		fallthrough;
+	case RATE_MCS_CHAN_WIDTH_20:
+		/* content channel 1 */
+		IWL_MLD_ENC_EHT_RU(1_1_1, A1);
+		break;
+	}
+}
+
+static void iwl_mld_decode_eht_non_tb(struct iwl_mld_rx_phy_data *phy_data,
+				      struct ieee80211_rx_status *rx_status,
+				      struct ieee80211_radiotap_eht *eht)
+{
+	eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_SPATIAL_REUSE |
+				  /* All RU allocating size/index is in TB format */
+				  IEEE80211_RADIOTAP_EHT_KNOWN_RU_ALLOC_TB_FMT |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_LDPC_EXTRA_SYM_OM |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_PRE_PADD_FACOR_OM |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_PE_DISAMBIGUITY_OM |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_EHT_LTF |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_PRIMARY_80 |
+				  IEEE80211_RADIOTAP_EHT_KNOWN_NR_NON_OFDMA_USERS_M);
+
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b1,
+				     OFDM_RX_FRAME_EHT_SPATIAL_REUSE,
+				     IEEE80211_RADIOTAP_EHT_DATA0_SPATIAL_REUSE);
+	eht->data[8] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b2,
+				     OFDM_RX_FRAME_EHT_STA_RU_PS160,
+				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_PS_160);
+	eht->data[8] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b2,
+				     OFDM_RX_FRAME_EHT_STA_RU,
+				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B0 |
+				     IEEE80211_RADIOTAP_EHT_DATA8_RU_ALLOC_TB_FMT_B7_B1);
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b1,
+				     OFDM_RX_FRAME_EHT_CODING_EXTRA_SYM,
+				     IEEE80211_RADIOTAP_EHT_DATA0_LDPC_EXTRA_SYM_OM);
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b1,
+				     OFDM_RX_FRAME_EHT_PRE_FEC_PAD_FACTOR,
+				     IEEE80211_RADIOTAP_EHT_DATA0_PRE_PADD_FACOR_OM);
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b1,
+				     OFDM_RX_FRAME_EHT_PE_DISAMBIG,
+				     IEEE80211_RADIOTAP_EHT_DATA0_PE_DISAMBIGUITY_OM);
+	eht->data[0] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b1,
+				     OFDM_RX_FRAME_EHT_NUM_OF_LTF_SYM,
 				     IEEE80211_RADIOTAP_EHT_DATA0_EHT_LTF);
+	eht->data[1] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b2,
+				     OFDM_RX_FRAME_EHT_STA_RU_P80,
+				     IEEE80211_RADIOTAP_EHT_DATA1_PRIMARY_80);
+	eht->data[7] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b1,
+				     OFDM_RX_FRAME_EHT_NUM_OF_USERS,
+				     IEEE80211_RADIOTAP_EHT_DATA7_NUM_OF_NON_OFDMA_USERS);
+
+	iwl_mld_eht_decode_user_ru(phy_data, eht);
+
+	iwl_mld_eht_set_ru_alloc(rx_status,
+				 le32_get_bits(phy_data->ntfy->sigs.eht.b2,
+					       OFDM_RX_FRAME_EHT_STA_RU));
+}
 
-	if (info_type == IWL_RX_PHY_INFO_TYPE_EHT_TB_EXT ||
-	    info_type == IWL_RX_PHY_INFO_TYPE_EHT_TB)
-		iwl_mld_decode_eht_ext_tb(mld, phy_data, rx_status, eht, usig);
+static void iwl_mld_decode_eht_phy_data(struct iwl_mld_rx_phy_data *phy_data,
+					struct ieee80211_rx_status *rx_status,
+					struct ieee80211_radiotap_eht *eht)
+{
+	u32 he_type = phy_data->rate_n_flags & RATE_MCS_HE_TYPE_MSK;
 
-	if (info_type == IWL_RX_PHY_INFO_TYPE_EHT_MU_EXT ||
-	    info_type == IWL_RX_PHY_INFO_TYPE_EHT_MU)
-		iwl_mld_decode_eht_ext_mu(mld, phy_data, rx_status, eht, usig);
+	if (he_type == RATE_MCS_HE_TYPE_TRIG)
+		iwl_mld_decode_eht_tb(phy_data, rx_status, eht);
+	else
+		iwl_mld_decode_eht_non_tb(phy_data, rx_status, eht);
 }
 
 static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
-			   struct iwl_mld_rx_phy_data *phy_data,
-			   int queue)
+			   struct iwl_mld_rx_phy_data *phy_data)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_radiotap_eht *eht;
-	struct ieee80211_radiotap_eht_usig *usig;
 	size_t eht_len = sizeof(*eht);
-
 	u32 rate_n_flags = phy_data->rate_n_flags;
 	u32 he_type = rate_n_flags & RATE_MCS_HE_TYPE_MSK;
 	/* EHT and HE have the same values for LTF */
 	u8 ltf = IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_UNKNOWN;
-	u16 phy_info = phy_data->phy_info;
-	u32 bw;
 
 	/* u32 for 1 user_info */
 	if (phy_data->with_data)
@@ -1065,50 +1106,7 @@ static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
 
 	eht = iwl_mld_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT, eht_len);
 
-	usig = iwl_mld_radiotap_put_tlv(skb, IEEE80211_RADIOTAP_EHT_USIG,
-					sizeof(*usig));
 	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
-	usig->common |=
-		cpu_to_le32(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN);
-
-	/* specific handling for 320MHz */
-	bw = u32_get_bits(rate_n_flags, RATE_MCS_CHAN_WIDTH_MSK);
-	if (bw == RATE_MCS_CHAN_WIDTH_320_VAL)
-		bw += le32_get_bits(phy_data->data0,
-				    IWL_RX_PHY_DATA0_EHT_BW320_SLOT);
-
-	usig->common |= cpu_to_le32
-		(FIELD_PREP(IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW, bw));
-
-	/* report the AMPDU-EOF bit on single frames */
-	if (!queue && !(phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
-		rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
-		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
-		if (phy_data->data0 &
-		    cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
-			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
-	}
-
-	/* update aggregation data for monitor sake on default queue */
-	if (!queue && (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD) &&
-	    (phy_info & IWL_RX_MPDU_PHY_AMPDU) && phy_data->first_subframe) {
-		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
-		if (phy_data->data0 &
-		    cpu_to_le32(IWL_RX_PHY_DATA0_EHT_DELIM_EOF))
-			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
-	}
-
-	if (phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
-		iwl_mld_decode_eht_phy_data(mld, phy_data, rx_status, eht, usig);
-
-#define CHECK_TYPE(F)							\
-	BUILD_BUG_ON(IEEE80211_RADIOTAP_HE_DATA1_FORMAT_ ## F !=	\
-		     (RATE_MCS_HE_TYPE_ ## F >> RATE_MCS_HE_TYPE_POS))
-
-	CHECK_TYPE(SU);
-	CHECK_TYPE(EXT_SU);
-	CHECK_TYPE(MU);
-	CHECK_TYPE(TRIG);
 
 	switch (u32_get_bits(rate_n_flags, RATE_MCS_HE_GI_LTF_MSK)) {
 	case 0:
@@ -1144,20 +1142,18 @@ static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
 
 	if (ltf != IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE_UNKNOWN) {
 		eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_GI);
-		eht->data[0] |= cpu_to_le32
-			(FIELD_PREP(IEEE80211_RADIOTAP_EHT_DATA0_LTF,
-				    ltf) |
-			 FIELD_PREP(IEEE80211_RADIOTAP_EHT_DATA0_GI,
-				    rx_status->eht.gi));
+		eht->data[0] |= le32_encode_bits(ltf,
+						 IEEE80211_RADIOTAP_EHT_DATA0_LTF) |
+				le32_encode_bits(rx_status->eht.gi,
+						 IEEE80211_RADIOTAP_EHT_DATA0_GI);
 	}
 
 	if (!phy_data->with_data) {
 		eht->known |= cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_NSS_S |
 					  IEEE80211_RADIOTAP_EHT_KNOWN_BEAMFORMED_S);
-		eht->data[7] |=
-			le32_encode_bits(le32_get_bits(phy_data->rx_vec[2],
-						       RX_NO_DATA_RX_VEC2_EHT_NSTS_MSK),
-					 IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
+		eht->data[7] |= LE32_DEC_ENC(phy_data->ntfy->sigs.eht.b1,
+					     OFDM_RX_FRAME_EHT_NSTS,
+					     IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
 		if (rate_n_flags & RATE_MCS_BF_MSK)
 			eht->data[7] |=
 				cpu_to_le32(IEEE80211_RADIOTAP_EHT_DATA7_BEAMFORMED_S);
@@ -1177,14 +1173,28 @@ static void iwl_mld_rx_eht(struct iwl_mld *mld, struct sk_buff *skb,
 			eht->user_info[0] |=
 				cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_CODING);
 
-		eht->user_info[0] |= cpu_to_le32
-			(FIELD_PREP(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS,
-				    u32_get_bits(rate_n_flags,
-						 RATE_VHT_MCS_RATE_CODE_MSK)) |
-			 FIELD_PREP(IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O,
-				    u32_get_bits(rate_n_flags,
-						 RATE_MCS_NSS_MSK)));
+		eht->user_info[0] |=
+			le32_encode_bits(u32_get_bits(rate_n_flags,
+						      RATE_VHT_MCS_RATE_CODE_MSK),
+					 IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
+			le32_encode_bits(u32_get_bits(rate_n_flags,
+						      RATE_MCS_NSS_MSK),
+					 IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O);
 	}
+
+	if (likely(!phy_data->ntfy))
+		return;
+
+	if (phy_data->with_data) {
+		eht->user_info[0] |=
+			cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID_KNOWN) |
+			LE32_DEC_ENC(phy_data->ntfy->sigs.eht.user_id,
+				     OFDM_RX_FRAME_EHT_USER_FIELD_ID,
+				     IEEE80211_RADIOTAP_EHT_USER_INFO_STA_ID);
+	}
+
+	iwl_mld_decode_eht_usig(phy_data, skb);
+	iwl_mld_decode_eht_phy_data(phy_data, rx_status, eht);
 }
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
@@ -1219,34 +1229,30 @@ static void iwl_mld_add_rtap_sniffer_config(struct iwl_mld *mld,
 }
 #endif
 
-/* Note: hdr can be NULL */
-static void iwl_mld_rx_fill_status(struct iwl_mld *mld, int link_id,
-				   struct ieee80211_hdr *hdr,
-				   struct sk_buff *skb,
-				   struct iwl_mld_rx_phy_data *phy_data,
-				   int queue)
+static void
+iwl_mld_set_rx_nonlegacy_rate_info(u32 rate_n_flags,
+				   struct ieee80211_rx_status *rx_status)
 {
-	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	u32 format = phy_data->rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
-	u32 rate_n_flags = phy_data->rate_n_flags;
 	u8 stbc = u32_get_bits(rate_n_flags, RATE_MCS_STBC_MSK);
-	bool is_sgi = rate_n_flags & RATE_MCS_SGI_MSK;
-
-	phy_data->info_type = IWL_RX_PHY_INFO_TYPE_NONE;
 
-	if (phy_data->phy_info & IWL_RX_MPDU_PHY_TSF_OVERLOAD)
-		phy_data->info_type =
-			le32_get_bits(phy_data->data1,
-				      IWL_RX_PHY_DATA1_INFO_TYPE_MASK);
-
-	/* set the preamble flag if appropriate */
-	if (format == RATE_MCS_MOD_TYPE_CCK &&
-	    phy_data->phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
-		rx_status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
+	/* NSS may be overridden by PHY ntfy with full value */
+	rx_status->nss = u32_get_bits(rate_n_flags, RATE_MCS_NSS_MSK) + 1;
+	rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
+	rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
+	if (rate_n_flags & RATE_MCS_LDPC_MSK)
+		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
+}
 
-	iwl_mld_fill_signal(mld, link_id, hdr, rx_status, phy_data);
+static void iwl_mld_set_rx_rate(struct iwl_mld *mld,
+				struct iwl_mld_rx_phy_data *phy_data,
+				struct ieee80211_rx_status *rx_status)
+{
+	u32 rate_n_flags = phy_data->rate_n_flags;
+	u8 stbc = u32_get_bits(rate_n_flags, RATE_MCS_STBC_MSK);
+	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+	bool is_sgi = rate_n_flags & RATE_MCS_SGI_MSK;
 
-	/* This may be overridden by iwl_mld_rx_he() to HE_RU */
+	/* bandwidth may be overridden to RU by PHY ntfy */
 	switch (rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK) {
 	case RATE_MCS_CHAN_WIDTH_20:
 		break;
@@ -1264,66 +1270,12 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, int link_id,
 		break;
 	}
 
-	/* must be before L-SIG data */
-	if (format == RATE_MCS_MOD_TYPE_HE)
-		iwl_mld_rx_he(mld, skb, phy_data, queue);
-
-	iwl_mld_decode_lsig(skb, phy_data);
-
-	rx_status->device_timestamp = phy_data->gp2_on_air_rise;
-
-	/* using TLV format and must be after all fixed len fields */
-	if (format == RATE_MCS_MOD_TYPE_EHT)
-		iwl_mld_rx_eht(mld, skb, phy_data, queue);
-
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	if (unlikely(mld->monitor.on)) {
-		iwl_mld_add_rtap_sniffer_config(mld, skb);
-
-		if (mld->monitor.ptp_time) {
-			u64 adj_time =
-			    iwl_mld_ptp_get_adj_time(mld,
-						     phy_data->gp2_on_air_rise *
-						     NSEC_PER_USEC);
-
-			rx_status->mactime = div64_u64(adj_time, NSEC_PER_USEC);
-			rx_status->flag |= RX_FLAG_MACTIME_IS_RTAP_TS64;
-			rx_status->flag &= ~RX_FLAG_MACTIME;
-		}
-	}
-#endif
-
-	if (format != RATE_MCS_MOD_TYPE_CCK && is_sgi)
-		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
-
-	if (rate_n_flags & RATE_MCS_LDPC_MSK)
-		rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
-
 	switch (format) {
-	case RATE_MCS_MOD_TYPE_HT:
-		rx_status->encoding = RX_ENC_HT;
-		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
-		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-		break;
-	case RATE_MCS_MOD_TYPE_VHT:
-	case RATE_MCS_MOD_TYPE_HE:
-	case RATE_MCS_MOD_TYPE_EHT:
-		if (format == RATE_MCS_MOD_TYPE_VHT) {
-			rx_status->encoding = RX_ENC_VHT;
-		} else if (format == RATE_MCS_MOD_TYPE_HE) {
-			rx_status->encoding = RX_ENC_HE;
-			rx_status->he_dcm =
-				!!(rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK);
-		} else if (format == RATE_MCS_MOD_TYPE_EHT) {
-			rx_status->encoding = RX_ENC_EHT;
-		}
-
-		rx_status->nss = u32_get_bits(rate_n_flags,
-					      RATE_MCS_NSS_MSK) + 1;
-		rx_status->rate_idx = rate_n_flags & RATE_MCS_CODE_MSK;
-		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-		break;
-	default: {
+	case RATE_MCS_MOD_TYPE_CCK:
+		if (phy_data->phy_info & IWL_RX_MPDU_PHY_SHORT_PREAMBLE)
+			rx_status->enc_flags |= RX_ENC_FLAG_SHORTPRE;
+		fallthrough;
+	case RATE_MCS_MOD_TYPE_LEGACY_OFDM: {
 		int rate =
 		    iwl_mld_legacy_hw_idx_to_mac80211_idx(rate_n_flags,
 							  rx_status->band);
@@ -1337,12 +1289,88 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, int link_id,
 		/* invalid rate */
 		rx_status->rate_idx = 0;
 
-		if (net_ratelimit())
+		/*
+		 * In monitor mode we can see CCK frames on 5 or 6 GHz, usually
+		 * just the (possibly malformed) PHY header by accident, since
+		 * the decoder doesn't seem to turn off CCK. We cannot correctly
+		 * encode the rate to mac80211 (and therefore not in radiotap)
+		 * since we give the per-band index which doesn't cover those
+		 * rates.
+		 */
+		if (!mld->monitor.on && net_ratelimit())
 			IWL_ERR(mld, "invalid rate_n_flags=0x%x, band=%d\n",
 				rate_n_flags, rx_status->band);
 		break;
 		}
+	case RATE_MCS_MOD_TYPE_HT:
+		rx_status->encoding = RX_ENC_HT;
+		rx_status->rate_idx = RATE_HT_MCS_INDEX(rate_n_flags);
+		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
+		break;
+	case RATE_MCS_MOD_TYPE_VHT:
+		rx_status->encoding = RX_ENC_VHT;
+		iwl_mld_set_rx_nonlegacy_rate_info(rate_n_flags, rx_status);
+		break;
+	case RATE_MCS_MOD_TYPE_HE:
+		rx_status->encoding = RX_ENC_HE;
+		rx_status->he_dcm =
+			!!(rate_n_flags & RATE_HE_DUAL_CARRIER_MODE_MSK);
+		iwl_mld_set_rx_nonlegacy_rate_info(rate_n_flags, rx_status);
+		break;
+	case RATE_MCS_MOD_TYPE_EHT:
+		rx_status->encoding = RX_ENC_EHT;
+		iwl_mld_set_rx_nonlegacy_rate_info(rate_n_flags, rx_status);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	if (format != RATE_MCS_MOD_TYPE_CCK && is_sgi)
+		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+}
+
+/* Note: hdr can be NULL */
+static void iwl_mld_rx_fill_status(struct iwl_mld *mld, int link_id,
+				   struct ieee80211_hdr *hdr,
+				   struct sk_buff *skb,
+				   struct iwl_mld_rx_phy_data *phy_data)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+	u32 rate_n_flags = phy_data->rate_n_flags;
+	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+
+	iwl_mld_fill_signal(mld, link_id, hdr, rx_status, phy_data);
+
+	rx_status->device_timestamp = phy_data->gp2_on_air_rise;
+
+	iwl_mld_set_rx_rate(mld, phy_data, rx_status);
+
+	/* must be before L-SIG data (radiotap field order) */
+	if (format == RATE_MCS_MOD_TYPE_HE)
+		iwl_mld_rx_he(skb, phy_data);
+
+	iwl_mld_decode_lsig(skb, phy_data);
+
+	/* TLVs - must be after radiotap fixed fields */
+	if (format == RATE_MCS_MOD_TYPE_EHT)
+		iwl_mld_rx_eht(mld, skb, phy_data);
+
+#ifdef CONFIG_IWLWIFI_DEBUGFS
+	if (unlikely(mld->monitor.on)) {
+		iwl_mld_add_rtap_sniffer_config(mld, skb);
+
+		if (mld->monitor.ptp_time) {
+			u64 adj_time =
+				iwl_mld_ptp_get_adj_time(mld,
+							 phy_data->gp2_on_air_rise *
+							 NSEC_PER_USEC);
+
+			rx_status->mactime = div64_u64(adj_time, NSEC_PER_USEC);
+			rx_status->flag |= RX_FLAG_MACTIME_IS_RTAP_TS64;
+			rx_status->flag &= ~RX_FLAG_MACTIME;
+		}
 	}
+#endif
 }
 
 /* iwl_mld_create_skb adds the rxb to a new skb */
@@ -1763,13 +1791,36 @@ static int iwl_mld_rx_crypto(struct iwl_mld *mld,
 	return 0;
 }
 
-static void iwl_mld_rx_update_ampdu_ref(struct iwl_mld *mld,
-					struct iwl_mld_rx_phy_data *phy_data,
-					struct ieee80211_rx_status *rx_status)
+static void iwl_mld_rx_update_ampdu_data(struct iwl_mld *mld,
+					 struct iwl_mld_rx_phy_data *phy_data,
+					 struct ieee80211_rx_status *rx_status)
 {
+	u32 format = phy_data->rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 	bool toggle_bit =
 		phy_data->phy_info & IWL_RX_MPDU_PHY_AMPDU_TOGGLE;
 
+	switch (format) {
+	case RATE_MCS_MOD_TYPE_CCK:
+	case RATE_MCS_MOD_TYPE_LEGACY_OFDM:
+		/* no aggregation possible */
+		return;
+	case RATE_MCS_MOD_TYPE_HT:
+	case RATE_MCS_MOD_TYPE_VHT:
+		/* single frames are not A-MPDU format */
+		if (!(phy_data->phy_info & IWL_RX_MPDU_PHY_AMPDU))
+			return;
+		break;
+	default:
+		/* HE/EHT/UHR have A-MPDU format for single frames */
+		if (!(phy_data->phy_info & IWL_RX_MPDU_PHY_AMPDU)) {
+			rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
+			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
+			if (phy_data->phy_info & IWL_RX_MPDU_PHY_EOF_INDICATION)
+				rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
+			return;
+		}
+	}
+
 	rx_status->flag |= RX_FLAG_AMPDU_DETAILS;
 	/* Toggle is switched whenever new aggregation starts. Make
 	 * sure ampdu_reference is never 0 so we can later use it to
@@ -1781,6 +1832,11 @@ static void iwl_mld_rx_update_ampdu_ref(struct iwl_mld *mld,
 			mld->monitor.ampdu_ref++;
 		mld->monitor.ampdu_toggle = toggle_bit;
 		phy_data->first_subframe = true;
+
+		/* report EOF bit on the first subframe */
+		rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT_KNOWN;
+		if (phy_data->phy_info & IWL_RX_MPDU_PHY_EOF_INDICATION)
+			rx_status->flag |= RX_FLAG_AMPDU_EOF_BIT;
 	}
 	rx_status->ampdu_reference = mld->monitor.ampdu_ref;
 }
@@ -1824,6 +1880,8 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 			 "FW lied about packet len (%d)\n", pkt_len))
 		return;
 
+	iwl_mld_fill_phy_data_from_mpdu(mld, mpdu_desc, &phy_data);
+
 	/* Don't use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
 	 */
@@ -1835,8 +1893,6 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 
 	hdr = (void *)(pkt->data + mpdu_desc_size);
 
-	iwl_mld_fill_phy_data(mld, mpdu_desc, &phy_data);
-
 	if (mpdu_desc->mac_flags2 & IWL_RX_MPDU_MFLG2_PAD) {
 		/* If the device inserted padding it means that (it thought)
 		 * the 802.11 header wasn't a multiple of 4 bytes long. In
@@ -1861,9 +1917,8 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	if (drop)
 		goto drop;
 
-	/* update aggregation data for monitor sake on default queue */
-	if (!queue && (phy_data.phy_info & IWL_RX_MPDU_PHY_AMPDU))
-		iwl_mld_rx_update_ampdu_ref(mld, &phy_data, rx_status);
+	if (unlikely(mld->monitor.on))
+		iwl_mld_rx_update_ampdu_data(mld, &phy_data, rx_status);
 
 	/* Keep packets with CRC errors (and with overrun) for monitor mode
 	 * (otherwise the firmware discards them) but mark them as bad.
@@ -1897,7 +1952,7 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	link_id = u8_get_bits(mpdu_desc->mac_phy_band,
 			      IWL_RX_MPDU_MAC_PHY_BAND_LINK_MASK);
 
-	iwl_mld_rx_fill_status(mld, link_id, hdr, skb, &phy_data, queue);
+	iwl_mld_rx_fill_status(mld, link_id, hdr, skb, &phy_data);
 
 	if (iwl_mld_rx_crypto(mld, sta, hdr, rx_status, mpdu_desc, queue,
 			      le32_to_cpu(pkt->len_n_flags), &crypto_len))
@@ -2031,87 +2086,64 @@ void iwl_mld_handle_rx_queues_sync_notif(struct iwl_mld *mld,
 		wake_up(&mld->rxq_sync.waitq);
 }
 
-void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
-				struct iwl_rx_packet *pkt, int queue)
+static void iwl_mld_no_data_rx(struct iwl_mld *mld,
+			       struct napi_struct *napi,
+			       struct iwl_rx_phy_air_sniffer_ntfy *ntfy)
 {
-	struct iwl_rx_no_data_ver_3 *desc;
-	struct iwl_mld_rx_phy_data phy_data;
 	struct ieee80211_rx_status *rx_status;
+	struct iwl_mld_rx_phy_data phy_data = {
+		.ntfy = ntfy,
+		.phy_info = 0, /* short preamble set below */
+		.rate_n_flags = le32_to_cpu(ntfy->rate),
+		.gp2_on_air_rise = le32_to_cpu(ntfy->on_air_rise_time),
+		.energy_a = ntfy->rssi_a,
+		.energy_b = ntfy->rssi_b,
+	};
+	u32 format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 	struct sk_buff *skb;
-	u32 format, rssi;
-	u8 channel;
 
-	if (unlikely(mld->fw_status.in_hw_restart))
-		return;
-
-	if (IWL_FW_CHECK(mld, iwl_rx_packet_payload_len(pkt) < sizeof(*desc),
-			 "Bad RX_NO_DATA_NOTIF size (%d)\n",
-			 iwl_rx_packet_payload_len(pkt)))
-		return;
-
-	desc = (void *)pkt->data;
-
-	rssi = le32_to_cpu(desc->rssi);
-	channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK);
-
-	phy_data.energy_a = u32_get_bits(rssi, RX_NO_DATA_CHAIN_A_MSK);
-	phy_data.energy_b = u32_get_bits(rssi, RX_NO_DATA_CHAIN_B_MSK);
-	phy_data.data0 = desc->phy_info[0];
-	phy_data.data1 = desc->phy_info[1];
-	phy_data.phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD;
-	phy_data.gp2_on_air_rise = le32_to_cpu(desc->on_air_rise_time);
-	phy_data.rate_n_flags = iwl_v3_rate_from_v2_v3(desc->rate,
-						       mld->fw_rates_ver_3);
-	phy_data.with_data = false;
-
-	BUILD_BUG_ON(sizeof(phy_data.rx_vec) != sizeof(desc->rx_vec));
-	memcpy(phy_data.rx_vec, desc->rx_vec, sizeof(phy_data.rx_vec));
-
-	format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
-
-	/* Don't use dev_alloc_skb(), we'll have enough headroom once
-	 * ieee80211_hdr pulled.
-	 */
 	skb = alloc_skb(128, GFP_ATOMIC);
-	if (!skb) {
-		IWL_ERR(mld, "alloc_skb failed\n");
+	if (!skb)
 		return;
-	}
 
 	rx_status = IEEE80211_SKB_RXCB(skb);
 
 	/* 0-length PSDU */
 	rx_status->flag |= RX_FLAG_NO_PSDU;
 
-	/* mark as failed PLCP on any errors to skip checks in mac80211 */
-	if (le32_get_bits(desc->info, RX_NO_DATA_INFO_ERR_MSK) !=
-	    RX_NO_DATA_INFO_ERR_NONE)
-		rx_status->flag |= RX_FLAG_FAILED_PLCP_CRC;
-
-	switch (le32_get_bits(desc->info, RX_NO_DATA_INFO_TYPE_MSK)) {
-	case RX_NO_DATA_INFO_TYPE_NDP:
+	switch (ntfy->status) {
+	case IWL_SNIF_STAT_PLCP_RX_OK:
+		/* we only get here with sounding PPDUs */
 		rx_status->zero_length_psdu_type =
 			IEEE80211_RADIOTAP_ZERO_LEN_PSDU_SOUNDING;
 		break;
-	case RX_NO_DATA_INFO_TYPE_MU_UNMATCHED:
-	case RX_NO_DATA_INFO_TYPE_TB_UNMATCHED:
+	case IWL_SNIF_STAT_AID_NOT_FOR_US:
 		rx_status->zero_length_psdu_type =
 			IEEE80211_RADIOTAP_ZERO_LEN_PSDU_NOT_CAPTURED;
 		break;
+	case IWL_SNIF_STAT_PLCP_RX_LSIG_ERR:
+	case IWL_SNIF_STAT_PLCP_RX_SIGA_ERR:
+	case IWL_SNIF_STAT_PLCP_RX_SIGB_ERR:
+	case IWL_SNIF_STAT_UNKNOWN_ERROR:
 	default:
+		rx_status->flag |= RX_FLAG_FAILED_PLCP_CRC;
+		fallthrough;
+	case IWL_SNIF_STAT_UNEXPECTED_TB:
+	case IWL_SNIF_STAT_UNSUPPORTED_RATE:
 		rx_status->zero_length_psdu_type =
 			IEEE80211_RADIOTAP_ZERO_LEN_PSDU_VENDOR;
-		break;
+		/* we could include the real reason in a vendor TLV */
 	}
 
-	rx_status->band = channel > 14 ? NL80211_BAND_5GHZ :
-		NL80211_BAND_2GHZ;
+	if (format == RATE_MCS_MOD_TYPE_CCK &&
+	    ntfy->legacy_sig.cck & cpu_to_le32(CCK_CRFR_SHORT_PREAMBLE))
+		phy_data.phy_info |= IWL_RX_MPDU_PHY_SHORT_PREAMBLE;
 
-	rx_status->freq = ieee80211_channel_to_frequency(channel,
-							 rx_status->band);
+	iwl_mld_fill_rx_status_band_freq(IEEE80211_SKB_RXCB(skb),
+					 ntfy->band, ntfy->channel);
 
 	/* link ID is ignored for NULL header */
-	iwl_mld_rx_fill_status(mld, -1, NULL, skb, &phy_data, queue);
+	iwl_mld_rx_fill_status(mld, -1, NULL, skb, &phy_data);
 
 	/* No more radiotap info should be added after this point.
 	 * Mark it as mac header for upper layers to know where
@@ -2119,29 +2151,72 @@ void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
 	 */
 	skb_set_mac_header(skb, skb->len);
 
-	/* Override the nss from the rx_vec since the rate_n_flags has
-	 * only 1 bit for the nss which gives a max of 2 ss but there
-	 * may be up to 8 spatial streams.
-	 */
-	switch (format) {
+	/* pass the packet to mac80211 */
+	rcu_read_lock();
+	ieee80211_rx_napi(mld->hw, NULL, skb, napi);
+	rcu_read_unlock();
+}
+
+void iwl_mld_handle_phy_air_sniffer_notif(struct iwl_mld *mld,
+					  struct napi_struct *napi,
+					  struct iwl_rx_packet *pkt)
+{
+	struct iwl_rx_phy_air_sniffer_ntfy *ntfy = (void *)pkt->data;
+	bool is_ndp = false;
+	u32 he_type;
+
+	if (IWL_FW_CHECK(mld, iwl_rx_packet_payload_len(pkt) < sizeof(*ntfy),
+			 "invalid air sniffer notification size\n"))
+		return;
+
+	/* check if there's an old one to release as errored */
+	if (mld->monitor.phy.valid && !mld->monitor.phy.used) {
+		/* didn't capture data, so override status */
+		mld->monitor.phy.data.status = IWL_SNIF_STAT_AID_NOT_FOR_US;
+		iwl_mld_no_data_rx(mld, napi, &mld->monitor.phy.data);
+	}
+
+	/* old data is no longer valid now */
+	mld->monitor.phy.valid = false;
+
+	he_type = le32_to_cpu(ntfy->rate) & RATE_MCS_HE_TYPE_MSK;
+
+	switch (le32_to_cpu(ntfy->rate) & RATE_MCS_MOD_TYPE_MSK) {
+	case RATE_MCS_MOD_TYPE_HT:
+		is_ndp = !le32_get_bits(ntfy->sigs.ht.a1,
+					OFDM_RX_FRAME_HT_LENGTH);
+		break;
 	case RATE_MCS_MOD_TYPE_VHT:
-		rx_status->nss =
-			le32_get_bits(desc->rx_vec[0],
-				      RX_NO_DATA_RX_VEC0_VHT_NSTS_MSK) + 1;
+		is_ndp = le32_get_bits(ntfy->sigs.vht.a0,
+				       OFDM_RX_FRAME_VHT_NUM_OF_DATA_SYM_VALID) &&
+			 !le32_get_bits(ntfy->sigs.vht.a0,
+					OFDM_RX_FRAME_VHT_NUM_OF_DATA_SYM);
 		break;
 	case RATE_MCS_MOD_TYPE_HE:
-		rx_status->nss =
-			le32_get_bits(desc->rx_vec[0],
-				      RX_NO_DATA_RX_VEC0_HE_NSTS_MSK) + 1;
+		if (he_type == RATE_MCS_HE_TYPE_TRIG)
+			break;
+		is_ndp = le32_get_bits(ntfy->sigs.he.a3,
+				       OFDM_RX_FRAME_HE_NUM_OF_DATA_SYM_VALID) &&
+			 !le32_get_bits(ntfy->sigs.he.a3,
+					OFDM_RX_FRAME_HE_NUM_OF_DATA_SYM);
 		break;
 	case RATE_MCS_MOD_TYPE_EHT:
-		rx_status->nss =
-			le32_get_bits(desc->rx_vec[2],
-				      RX_NO_DATA_RX_VEC2_EHT_NSTS_MSK) + 1;
+		if (he_type == RATE_MCS_HE_TYPE_TRIG)
+			break;
+		is_ndp = le32_get_bits(ntfy->sigs.eht.sig2,
+				       OFDM_RX_FRAME_EHT_NUM_OF_DATA_SYM_VALID) &&
+			 !le32_get_bits(ntfy->sigs.eht.sig2,
+					OFDM_RX_FRAME_EHT_NUM_OF_DATA_SYM);
+		break;
 	}
 
-	/* pass the packet to mac80211 */
-	rcu_read_lock();
-	ieee80211_rx_napi(mld->hw, NULL, skb, napi);
-	rcu_read_unlock();
+	if (ntfy->status != IWL_SNIF_STAT_PLCP_RX_OK || is_ndp) {
+		iwl_mld_no_data_rx(mld, napi, ntfy);
+		return;
+	}
+
+	/* hang on to it for the RX_MPDU data packet(s) */
+	mld->monitor.phy.data = *ntfy;
+	mld->monitor.phy.valid = true;
+	mld->monitor.phy.used = false;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.h b/drivers/net/wireless/intel/iwlwifi/mld/rx.h
index 2beabd7e70b1..09dddbd40f55 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.h
@@ -66,7 +66,8 @@ void iwl_mld_pass_packet_to_mac80211(struct iwl_mld *mld,
 				     struct sk_buff *skb, int queue,
 				     struct ieee80211_sta *sta);
 
-void iwl_mld_rx_monitor_no_data(struct iwl_mld *mld, struct napi_struct *napi,
-				struct iwl_rx_packet *pkt, int queue);
+void iwl_mld_handle_phy_air_sniffer_notif(struct iwl_mld *mld,
+					  struct napi_struct *napi,
+					  struct iwl_rx_packet *pkt);
 
 #endif /* __iwl_mld_agg_h__ */
-- 
2.34.1


