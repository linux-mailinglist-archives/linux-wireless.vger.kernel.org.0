Return-Path: <linux-wireless+bounces-3114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B635849102
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 23:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8061C21DAD
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 22:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3FF41218;
	Sun,  4 Feb 2024 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzWk0OQg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFE40C0C
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084420; cv=none; b=e+VQH7AyEG1SEzWObS4urG0oSImtvP289yIiUfG4mcLfaO6/BdbmWQMZhY1loD+WXMI6uzysWsQii6bJQDWOVN1+RplZA+JjdXVUd/Mb/GSkN6tybS8E6MbOg8pAKfYPADPo1MDzaaxWfhLmjwZ7XXTq1vMMvDnasjHjOqCSYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084420; c=relaxed/simple;
	bh=GhWSfxawwVD0dIKOsuDqFu4Rnwo4GbrthudeoUfFskE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O717/em3KOb6HYSGwxaUWXqeErttPzQEzaZbUhBRQV+LgDnKn+YJzpbTX08UfDyKfZn12+SXXx0V2/oBFmk8yfXTFx/PzsGsnpdb2xkB6wlq3malTz6JnP1kkrmO00fNWF81KrNAey4iFc6pGVBV00+mKrONN/HUJsj6P4QBg/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzWk0OQg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707084419; x=1738620419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GhWSfxawwVD0dIKOsuDqFu4Rnwo4GbrthudeoUfFskE=;
  b=UzWk0OQgwUbh+PsbFZGpwJHrf5rrbyhQRXgaj/24m1BOEVh8WSPaduFI
   PsLBfuU024UAlEhpjq1X1yS9srd/cvoMmTds4OtqtyJgurjmcbmWFzPaW
   KDMFfE4b/X8H309jh5k6Ps3PC2+Vgot1IqE1snHgx8Zq9lVUg8iFZUR+b
   QKN6gPgPSa8Ik83PhFkF5Ntf1bnTOySVu9Rlje8xvbxmhi6+ntA0fVmzJ
   J4YN38dZA0tUYQWybo2v1RyxxJkJq7jqA2i4+DoHitYtbZ5sq2WnDC6w8
   0zZmAGmB0CyRnD/ybMg1YLHILKxo5C11k7TccgBZDEZVgjNQbUFOiEajf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25869396"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25869396"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="23815915"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 14:06:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: Declare support for secure LTF measurement
Date: Mon,  5 Feb 2024 00:06:15 +0200
Message-Id: <20240204235836.f20d2437c06f.I479df8ab543db2d05c413119ad3eb3936cc86294@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Declare support for secure LTF measurement if the FW supports it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h           | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      | 5 +++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index b216da7d95fc..b7ef0882dbad 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -385,6 +385,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	complete to FW.
  * @IWL_UCODE_TLV_CAPA_SPP_AMSDU_SUPPORT: Support SPP (signaling and payload
  *	protected) A-MSDU.
+ * @IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT: Support secure LTF measurement.
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -483,7 +484,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_STA_EXP_MFP_SUPPORT		= (__force iwl_ucode_tlv_capa_t)114,
 	IWL_UCODE_TLV_CAPA_SNIFF_VALIDATE_SUPPORT	= (__force iwl_ucode_tlv_capa_t)116,
 	IWL_UCODE_TLV_CAPA_CHINA_22_REG_SUPPORT		= (__force iwl_ucode_tlv_capa_t)117,
-
+	IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT		= (__force iwl_ucode_tlv_capa_t)121,
 	NUM_IWL_UCODE_TLV_CAPA
 /*
  * This construction make both sparse (which cannot increment the previous
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index f72ca38d7c0e..dca36b0662c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -349,6 +349,12 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 	}
 
 	if (hltk && hltk_len) {
+		if (!fw_has_capa(&mvm->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT)) {
+			IWL_ERR(mvm, "No support for secure LTF measurement\n");
+			return -EINVAL;
+		}
+
 		hltk_data.cipher = iwl_mvm_cipher_to_location_cipher(cipher);
 		if (hltk_data.cipher == IWL_LOCATION_CIPHER_INVALID) {
 			IWL_ERR(mvm, "invalid cipher: %u\n", cipher);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index e62fcfd1a65f..4188957afdf4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -710,6 +710,11 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 				  IWL_FW_CMD_VER_UNKNOWN) >= 11) {
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE);
+
+		if (fw_has_capa(&mvm->fw->ucode_capa,
+				IWL_UCODE_TLV_CAPA_SECURE_LTF_SUPPORT))
+			wiphy_ext_feature_set(hw->wiphy,
+					      NL80211_EXT_FEATURE_SECURE_LTF);
 	}
 
 	mvm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
-- 
2.34.1


