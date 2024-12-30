Return-Path: <linux-wireless+bounces-16896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CFF9FE286
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988BC16099F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89813B5A0;
	Mon, 30 Dec 2024 04:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSzj5/mH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027613633F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534589; cv=none; b=aHQSY+JibgLM3dco3utoKvg7aC6BqpiemqzEm+D6geywstw3OpEBpuR++GlZ+gub3RBNf1SHRmGvOlfqtBxtdxjlpk8UQXYfHeP67Oj3NX3lLozWx0XlMDgs0oQZi26wK1CcdteuZnWnWcP+JNEuUYAKKvgxOvy2FuiezMNWfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534589; c=relaxed/simple;
	bh=VDW3rg7ARkiIglozU0f/ot3xbvoccbySeQJaWq1dBtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nz/2A2EQIq9EWWt6cqadRK2g75BmPE0mvtqUTTSCY4ABdRUT2zA9S2Fc/AdaI4hOn4dPOqVmlUw+adc9oxngvOahV8j9XmaHK1hhAgFkE0I+Hbs0kdlh2zyo4aAFBxXNbyzqOIDbKoSR9VfNUf2Z+hO9XTnlB+ZduU0WUf5nZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSzj5/mH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534588; x=1767070588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VDW3rg7ARkiIglozU0f/ot3xbvoccbySeQJaWq1dBtI=;
  b=nSzj5/mHOXzsPsR3mjAiVO7zkkGe7+zpstmp5ePkfri0eSRLxt4zHsy6
   6bpQECI0HSz5Ulfm1w77kGeZ9C8rggI4DGu8TQ+f/QYwA0bPxxfnbL9DG
   z9XiHHaNuiqdxsqjQt4urUKaRFPiHIoJMsI07lo2Sm4GvbZxM7m5wqESP
   IUCUXuopHqubKIyBcNrOqBbHatbOmYC3vubwNp9CDFezfSwPk9WF2s9u8
   xlCbGWc8YAV6+bXelZaEb6mnakEMJLLFHG9RAjTZ/TLwMcmviQ0u8/+jX
   1HIU83IZC4eiCkIGToEy2oG1tBaNCCbnEz4hjKi/j0pYqTkys2XrCEQbN
   w==;
X-CSE-ConnectionGUID: EJOgD8YQRImQ1P2R4RUljg==
X-CSE-MsgGUID: GX4HAAVZTPCpzW0r+JW8fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405032"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405032"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:28 -0800
X-CSE-ConnectionGUID: Rm0deqMtTcSftPsaajpoyw==
X-CSE-MsgGUID: gCLUz4coS4mJP4Fv2sBYtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758923"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 13/15] wifi: ieee80211: Add some missing MLO related definitions
Date: Mon, 30 Dec 2024 06:55:52 +0200
Message-Id: <20241230065327.fa8f392cc8ba.Ibe7f6108cd0e04b8c739a8e35a4f485f664a17e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

As a preparation to support ML reconfiguration request and
response, add additional ML reconfiguration definitions
required to support the flow. See Section 9.4.2.321.4 in
Draft P802.11be_D6.0.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 9c0e2617fe8f..3751c4bf71ca 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3883,6 +3883,16 @@ enum ieee80211_protected_eht_actioncode {
 	WLAN_PROTECTED_EHT_ACTION_TTLM_REQ = 0,
 	WLAN_PROTECTED_EHT_ACTION_TTLM_RES = 1,
 	WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN = 2,
+	WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_REQ = 3,
+	WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_RESP = 4,
+	WLAN_PROTECTED_EHT_ACTION_EPCS_ENABLE_TEARDOWN = 5,
+	WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF = 6,
+	WLAN_PROTECTED_EHT_ACTION_LINK_RECOMMEND = 7,
+	WLAN_PROTECTED_EHT_ACTION_ML_OP_UPDATE_REQ = 8,
+	WLAN_PROTECTED_EHT_ACTION_ML_OP_UPDATE_RESP = 9,
+	WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_NOTIF = 10,
+	WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_REQ = 11,
+	WLAN_PROTECTED_EHT_ACTION_LINK_RECONFIG_RESP = 12,
 };
 
 /* Security key length */
@@ -5019,6 +5029,8 @@ struct ieee80211_multi_link_elem {
 #define IEEE80211_MLD_CAP_OP_TID_TO_LINK_MAP_NEG_SUPP_DIFF	3
 #define IEEE80211_MLD_CAP_OP_FREQ_SEP_TYPE_IND		0x0f80
 #define IEEE80211_MLD_CAP_OP_AAR_SUPPORT		0x1000
+#define IEEE80211_MLD_CAP_OP_LINK_RECONF_SUPPORT	0x2000
+#define IEEE80211_MLD_CAP_OP_ALIGNED_TWT_SUPPORT	0x4000
 
 struct ieee80211_mle_basic_common_info {
 	u8 len;
@@ -5034,6 +5046,9 @@ struct ieee80211_mle_preq_common_info {
 } __packed;
 
 #define IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR		0x0010
+#define IEEE80211_MLC_RECONF_PRES_EML_CAPA		0x0020
+#define IEEE80211_MLC_RECONF_PRES_MLD_CAPA_OP		0x0040
+#define IEEE80211_MLC_RECONF_PRES_EXT_MLD_CAPA_OP	0x0080
 
 /* no fixed fields in RECONF */
 
@@ -5352,6 +5367,12 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	case IEEE80211_ML_CONTROL_TYPE_RECONF:
 		if (control & IEEE80211_MLC_RECONF_PRES_MLD_MAC_ADDR)
 			common += ETH_ALEN;
+		if (control & IEEE80211_MLC_RECONF_PRES_EML_CAPA)
+			common += 2;
+		if (control & IEEE80211_MLC_RECONF_PRES_MLD_CAPA_OP)
+			common += 2;
+		if (control & IEEE80211_MLC_RECONF_PRES_EXT_MLD_CAPA_OP)
+			common += 2;
 		break;
 	case IEEE80211_ML_CONTROL_TYPE_TDLS:
 		common += sizeof(struct ieee80211_mle_tdls_common_info);
@@ -5502,8 +5523,13 @@ ieee80211_mle_basic_sta_prof_bss_param_ch_cnt(const struct ieee80211_mle_per_sta
 #define IEEE80211_MLE_STA_RECONF_CONTROL_COMPLETE_PROFILE		0x0010
 #define IEEE80211_MLE_STA_RECONF_CONTROL_STA_MAC_ADDR_PRESENT		0x0020
 #define IEEE80211_MLE_STA_RECONF_CONTROL_AP_REM_TIMER_PRESENT		0x0040
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_UPDATE_TYPE		0x0780
-#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_PARAMS_PRESENT	0x0800
+#define	IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE                 0x0780
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_AP_REM          0
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_OP_PARAM_UPDATE 1
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_ADD_LINK        2
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_DEL_LINK        3
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_TYPE_NSTR_STATUS     4
+#define IEEE80211_MLE_STA_RECONF_CONTROL_OPERATION_PARAMS_PRESENT       0x0800
 
 /**
  * ieee80211_mle_reconf_sta_prof_size_ok - validate reconfiguration multi-link
-- 
2.34.1


