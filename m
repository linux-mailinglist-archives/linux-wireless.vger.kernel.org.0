Return-Path: <linux-wireless+bounces-28780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE3FC46C02
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DD814E9AC7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3231197B;
	Mon, 10 Nov 2025 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNL+tAwH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3630E858
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779772; cv=none; b=X2WP+r872CrEQo6qecOwXOqSD8UZpjlHMqZOKkyGB+rmXgKDiADB6z1hMeja9n/82GUX3iZuVRRw2r6cvnkjs/XovR9O3nTPdFmgBAuYFA7eNBtRDWG4vg3FzJYuUqh7EH5sMqwxxVHKfx+Syol0iUUeouaGsiuLlp1XeOULdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779772; c=relaxed/simple;
	bh=oWJNow25y2UaO73BKpFghe6PjM3JapYiRWevM4psPQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UotILC2TblPMCzojMQ09z+nrD9TWtiT4qeC59Px7K5Wxxm24O1qOjMHPAG1zdbwBSjpUzkR9/W6rjjhVr1CfMFROjbSOCQlMHghx4ysgptKy927Bho9rIVkteNt7//8nasQUqJZ940bgvCG0uVc2r3JAJ5iSgP2Ps4FfXGrMVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNL+tAwH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779772; x=1794315772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWJNow25y2UaO73BKpFghe6PjM3JapYiRWevM4psPQ4=;
  b=mNL+tAwH0RcyDF6IeFhiZLCMNIK/Qr/IM6OOevPe6BehnUDZypdMJvVy
   IcF/ygoFLXuwXCCcgGDD66JSeESEDohjmyv/NPi+dM8x/eSblOYfSrxn+
   M/4TymaBPVluEla5vnCngrhWBqBkL4C2uf6pIPrpGbLhDGedH2FC/2qqt
   CXRlu6dzOy0wJfhKkUt6bkMFNK4CBkUAuSfHBPhtVwhYGJSbgyXNpCv3n
   8B4Odx6Fw1jMLVNCTUIsN42LJch7ahAx91sgeldGUZRBryRzU80ma4knF
   EiOTbFSAftovB5qNCVVJqFaF5I3q/hF6xDJmhW1KqVtD0Doy5fpr03xye
   g==;
X-CSE-ConnectionGUID: 5JB+aCkFT86+2xZUA6xRJw==
X-CSE-MsgGUID: Qxf/CF79QTa+H5htbSKpRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454894"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454894"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:51 -0800
X-CSE-ConnectionGUID: lzROOM1fQByRbNYA0auvLg==
X-CSE-MsgGUID: ZiyZEvsUTXGRVmGpBiREHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928567"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: fix HE SIG-B MCS/DCM/compression
Date: Mon, 10 Nov 2025 15:02:24 +0200
Message-Id: <20251110150012.4d625e05dece.If295eb9382fc681d63b0853261d884cd1a833ba5@changeid>
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

These values should be taken from SIG-A, indicating how SIG-B
is encoded. The values taken from SIG-B (the corresponding
register) indicate how the data portion (for that user) is
encoded. For the SIG-B compression value the correct mask was
applied to the wrong value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h |  2 ++
 drivers/net/wireless/intel/iwlwifi/mld/rx.c    | 10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index beb20eadf6d6..ac6c1ef2cbcd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1090,7 +1090,9 @@ struct iwl_vht_sigs {
 struct iwl_he_sigs {
 #define OFDM_RX_FRAME_HE_BEAM_CHANGE			0x00000001
 #define OFDM_RX_FRAME_HE_UL_FLAG			0x00000002
+/* SU/ER-SU: MCS, MU: SIG-B MCS */
 #define OFDM_RX_FRAME_HE_MCS				0x0000003c
+/* SU/ER-SU: DCM, MU: SIG-B DCM */
 #define OFDM_RX_FRAME_HE_DCM				0x00000040
 #define OFDM_RX_FRAME_HE_BSS_COLOR			0x00001f80
 #define OFDM_RX_FRAME_HE_SPATIAL_REUSE			0x0001e000
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 817181e74d6e..7f2fb3780a1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -396,11 +396,11 @@ iwl_mld_decode_he_mu(struct iwl_mld_rx_phy_data *phy_data,
 {
 	u32 rate_n_flags = phy_data->rate_n_flags;
 
-	he_mu->flags1 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.b,
-				     OFDM_RX_FRAME_HE_SIGB_DCM,
+	he_mu->flags1 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a1,
+				     OFDM_RX_FRAME_HE_DCM,
 				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_DCM);
-	he_mu->flags1 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.b,
-				     OFDM_RX_FRAME_HE_SIGB_MCS,
+	he_mu->flags1 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a1,
+				     OFDM_RX_FRAME_HE_MCS,
 				     IEEE80211_RADIOTAP_HE_MU_FLAGS1_SIG_B_MCS);
 	he_mu->flags2 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a1,
 				     OFDM_RX_FRAME_HE_PRMBL_PUNC_TYPE,
@@ -408,7 +408,7 @@ iwl_mld_decode_he_mu(struct iwl_mld_rx_phy_data *phy_data,
 	he_mu->flags2 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
 				     OFDM_RX_FRAME_HE_MU_NUM_OF_SIGB_SYM_OR_USER_NUM,
 				     IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_SYMS_USERS);
-	he_mu->flags2 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.b,
+	he_mu->flags2 |= RTAP_ENC_HE(phy_data->ntfy->sigs.he.a2,
 				     OFDM_RX_FRAME_HE_MU_SIGB_COMP,
 				     IEEE80211_RADIOTAP_HE_MU_FLAGS2_SIG_B_COMP);
 
-- 
2.34.1


