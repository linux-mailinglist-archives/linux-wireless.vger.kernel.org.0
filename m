Return-Path: <linux-wireless+bounces-28778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C910C46C0B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DBF3B675A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD230BB95;
	Mon, 10 Nov 2025 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOqD9RAD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D0311583
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779771; cv=none; b=O/x36GIaScAxpurTeLvB95+3zRxH5mLLUE/d6/zI+po+Y+NFBS+zcL647lphtIQULBYNoQ/+pA3pPqCCDH5ASGm07U/qw5OXWQKbwOqQ1gn2yKczrFjgOuAgpWpq9slacVlJcUu2akg4Cv2kcjX7Xvjd44IIQ/M3NAK/bGXovSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779771; c=relaxed/simple;
	bh=3iVf5i3EBoTjJ20jskegfgwH/mkNOpYM8bo32YO9JCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NV0f0K2A6RJRYWgu7HKKzYzKE/ht/0bM2uDBfR7jt9CLGOdlIK/VbCgtJlxXzlrcSovTmYf8E4Sj3ilZYOy+27E5RlqGEhnpniwEKZ3PcswgrGz21SfVkwaj5u2RwSaUiYdNlTCcL2016FaPoPB1DPP58CPYm1VQJgM98w2oEeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOqD9RAD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779770; x=1794315770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3iVf5i3EBoTjJ20jskegfgwH/mkNOpYM8bo32YO9JCY=;
  b=AOqD9RADT4tVvKTFLbwcahV0rgz/Zzm17d2Le7kv1EWdG4t2BlmhiQkv
   PrIAg6N1PBfTdF+xKvjOxXHgynclFtgJSkT8cRcgHpavbpU75RlnHpHy1
   WwS49aeGZ43yv/mK8fPXeXdsziAWDwiesEh4mMFtRGw7BBtu5qITF+vlF
   AVZEkmY9SF8dlThRv+CCKaDJmFPKp/0QczFyz+REXWCleEIDaPv91sy1l
   dowdxlqs4aIf7nQAqSgzSRmGiMLlrFqcFCtiod1vOjYrMmLBA65NpL2eN
   cRgz2p90xw8xtJTZlcdAOFrm1n8mozsAh1+11hyKZaTbuSJCWfdUmDpYq
   Q==;
X-CSE-ConnectionGUID: Zd0Xh8KcRSyQHXCuKO14Lw==
X-CSE-MsgGUID: ToIWFZSXTYuQrpVlFyvELA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454893"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454893"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:50 -0800
X-CSE-ConnectionGUID: ltVU7pzQSGqeuA6TSHTkoA==
X-CSE-MsgGUID: l/m9h4aUQXqhST+x7TCPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928564"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: fw: api: add UHR data definitions
Date: Mon, 10 Nov 2025 15:02:23 +0200
Message-Id: <20251110150012.358b51dd8cb2.I16178416dd7019cb88a45e55f81eb28510982028@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add the necessary data definitions for the sniffer-related fields
reported for the various UHR frame formats by the firmware/hardware
to be able to later add the necessary sniffer code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 69 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 6d0523497663..beb20eadf6d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1269,19 +1269,82 @@ struct iwl_eht_tb_sigs {
 };
 
 struct iwl_uhr_sigs {
-	__le32 usig_a1, usig_a1_uhr, usig_a2_uhr, b1, b2;
+	/* same as EHT above */
+	__le32 usig_a1;
+#define OFDM_RX_FRAME_UHR_BSS_COLOR2			0x0000003f
+	__le32 usig_a1_uhr;
+#define	OFDM_RX_FRAME_UHR_PPDU_TYPE			0x00000003
+#define	OFDM_RX_FRAME_UHR_COBF_CSR_DISABLE		0x00000004
+#define	OFDM_RX_FRAME_UHR_PUNC_CHANNEL			0x000000f8
+#define	OFDM_RX_FRAME_UHR_USIG2_VALIDATE_B8		0x00000100
+#define	OFDM_RX_FRAME_UHR_SIG_MCS			0x00000600
+#define	OFDM_RX_FRAME_UHR_SIG_SYM_NUM			0x0000f800
+#define	OFDM_RX_FRAME_UHR_TRIG_SPATIAL_REUSE_1		0x000f0000
+#define	OFDM_RX_FRAME_UHR_TRIG_SPATIAL_REUSE_2		0x00f00000
+#define	OFDM_RX_FRAME_UHR_TRIG_USIG2_DISREGARD		0x1f000000
+	__le32 usig_a2_uhr;
+#define OFDM_RX_FRAME_UHR_SPATIAL_REUSE			0x0000000f
+#define OFDM_RX_FRAME_UHR_GI_LTF_TYPE			0x00000030
+#define OFDM_RX_FRAME_UHR_NUM_OF_LTF_SYM		0x000001c0
+#define OFDM_RX_FRAME_UHR_CODING_EXTRA_SYM		0x00000200
+#define OFDM_RX_FRAME_UHR_PE_A_FACTOR			0x00000c00
+#define OFDM_RX_FRAME_UHR_PE_DISAMBIGUITY		0x00001000
+#define OFDM_RX_FRAME_UHR_IM_DISABLE			0x00002000
+#define OFDM_RX_FRAME_UHR_USIG_OVF_DISREGARD		0x0000c000
+#define OFDM_RX_FRAME_UHR_NUM_OF_USERS			0x00070000
+#define OFDM_RX_FRAME_UHR_NSTS				0x00f00000
+#define OFDM_RX_FRAME_UHR_BF				0x01000000
+#define OFDM_RX_FRAME_UHR_USIG_OVF_NDP_DISREGARD	0x06000000
+#define OFDM_RX_FRAME_UHR_COMM_CC1_CRC_OK		0x08000000
+#define OFDM_RX_FRAME_UHR_COMM_CC2_CRC_OK		0x10000000
+#define OFDM_RX_FRAME_UHR_NON_VALID_RU_ALLOC		0x20000000
+	__le32 b1;
+#define OFDM_RX_FRAME_UHR_MCS				0x000001f0
+#define OFDM_RX_FRAME_UHR_CODING			0x00000200
+#define OFDM_RX_FRAME_UHR_SPATIAL_CONFIG		0x00003c00
+#define OFDM_RX_FRAME_UHR_STA_RU			0x003fc000
+#define OFDM_RX_FRAME_UHR_STA_RU_PS160			0x00400000
+#define OFDM_RX_FRAME_UHR_UEQM				0x00800000
+#define OFDM_RX_FRAME_UHR_2XLDPC			0x01000000
+#define OFDM_RX_FRAME_UHR_UEQM_PATTERN			0x06000000
+#define OFDM_RX_FRAME_UHR_IS_MU_MIMO_USER_FIELD		0x08000000
+#define OFDM_RX_FRAME_UHR_USER_FIELD_CRC_OK		0x40000000
+	__le32 b2;
+#define OFDM_RX_UHR_NUM_OF_DATA_SYM			0x000007ff
+#define OFDM_RX_UHR_PE_DURATION				0x00003800
 	__le32 sig2;
+	/* same as EHT above: OFDM_RX_FRAME_EHT_RU_ALLOC_* */
 	__le32 cmn[6];
+#define OFDM_RX_FRAME_UHR_USER_FIELD_ID			0x000007ff
 	__le32 user_id;
 };
 
 struct iwl_uhr_tb_sigs {
-	__le32 usig_a1, usig_a2_uhr, tb_rx0, tb_rx1;
+	/* same as UHR above */
+	__le32 usig_a1, usig_a2_uhr;
+	/* same as HE above */
+	__le32 tb_rx0, tb_rx1;
 };
 
 struct iwl_uhr_elr_sigs {
+	/* same as UHR above */
 	__le32 usig_a1, usig_a2_uhr;
-	__le32 uhr_sig_elr1, uhr_sig_elr2;
+#define OFDM_RX_VECTOR_UHR_ELR_VER_ID			0x00000007
+#define OFDM_RX_VECTOR_UHR_ELR_UPLINK_FLAG		0x00000008
+#define OFDM_RX_VECTOR_UHR_ELR_MCS			0x00000010
+#define OFDM_RX_VECTOR_UHR_ELR_CODING			0x00000020
+#define OFDM_RX_VECTOR_UHR_ELR_LENGTH_IN_SYM		0x00007fc0
+#define OFDM_RX_VECTOR_UHR_ELR_CODING_EXTRA_SYM		0x00008000
+#define OFDM_RX_VECTOR_UHR_ELR_SIG1_CRC_OK		0x00010000
+#define OFDM_RX_VECTOR_UHR_ELR_STA_ID			0x0ffe0000
+#define OFDM_RX_VECTOR_UHR_ELR_DISREGARD		0x70000000
+	__le32 uhr_sig_elr1;
+#define OFDM_RX_VECTOR_UHR_ELR_MARK_BSS_COLOR		0x0000003f
+#define OFDM_RX_VECTOR_UHR_ELR_SIG_ID_INDX		0x00000e00
+#define OFDM_RX_VECTOR_UHR_ELR_STA_RU			0x000ff000
+#define OFDM_RX_VECTOR_UHR_ELR_STA_RU_PS160		0x00100000
+#define OFDM_RX_VECTOR_UHR_ELR_SIG2_CRC_OK		0x00200000
+	__le32 uhr_sig_elr2;
 };
 
 union iwl_sigs {
-- 
2.34.1


