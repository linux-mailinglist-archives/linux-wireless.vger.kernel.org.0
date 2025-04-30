Return-Path: <linux-wireless+bounces-22265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204AAA4C68
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAC8170D2B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213B25B1F8;
	Wed, 30 Apr 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdPxanX6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA61725FA24
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017870; cv=none; b=cNXgIBC79RL+clk+QqEwJWXFNdsk0UWDsP8P5pyYSVe2Yxxmf2X+9CnntCQ88fpjxlqEC4Z9Z7dUd4GaBIWgIaf7KsG5GaGA2ufADXixNiY9L8VPa1PHWEj0/vSoQl2m009uk0pYoD04nnNd/5J6tkFbdAEifIU//O0fF2rURZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017870; c=relaxed/simple;
	bh=nQhrKoIkTI95K6xtiYyUdALdzfabXHTgmuymFItOlf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhMwblv+M93Lo3kq41+Zhsa8T0JJAih+gKBEx/UJdWXWqjQB4w+K38tXtNFkZ0Ub1Qs07E1PEy7i9l/3msKIaYtW1Dbpc8cj5uELF3ujeqk8juCOp3iOQZ0jjmZGRVf1CnQ6Taw72q3Xrs/sWhQuWMVSD+wvrdt82OEp/KbAahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdPxanX6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017869; x=1777553869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQhrKoIkTI95K6xtiYyUdALdzfabXHTgmuymFItOlf8=;
  b=bdPxanX6/dmlX517DnxWhREvKuwqIcl5VntHHV38c1aYemyJlI+Nd6m4
   Efzk5Qy0F3QYnpi/LokJetKABeNVHqAUATSotyZEvGIVsQHdVPaHGvtsL
   /g/RoeXknym0FN/z+hUGOize4xd4CgftG5dRyLsfmvfsqSs/hTWpVDHEe
   YYTwwJcnfWLAB+Kon6NvrZvInxQLHZuxjbMqtwuCJAJUfYB+qiik/2lXs
   wLSNv8MdOSwC4Rxm/VQ17j+upisPnMbqGEZzZbnRxfA0P4B76nfXMzKQO
   3loZTvtQ0eFi4DBzXye2XtBJS2yyxCKW67FilzNTWcX3CAw160zkE71aw
   g==;
X-CSE-ConnectionGUID: cBeGNZ9oTvCsc3yX6C1T1w==
X-CSE-MsgGUID: yUA1ACOMSaqzcO1fh9FT2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332333"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332333"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:49 -0700
X-CSE-ConnectionGUID: kd75YbYMRNyg+YwUumgekw==
X-CSE-MsgGUID: B0AkE6bdSBC3C6js8Fc3JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632094"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mvm: support ROC command version 6
Date: Wed, 30 Apr 2025 15:57:18 +0300
Message-Id: <20250430155443.d118ee63aca4.I12ea349ca6587d8ea606f6ece4a9f3c0c2bb1494@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
References: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This was suppsed to be supported only in iwlmld, but turns out that it
will be needed also in iwlmvm. Add support for it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 1a30bb1ff8ca..478408f802d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -771,15 +771,17 @@ static void iwl_mvm_cancel_session_protection(struct iwl_mvm *mvm,
 
 static void iwl_mvm_roc_rm_cmd(struct iwl_mvm *mvm, u32 activity)
 {
-	struct iwl_roc_req_v5 roc_cmd = {
+	struct iwl_roc_req roc_cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
 		.activity = cpu_to_le32(activity),
 	};
+	u8 ver = iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
+	u16 cmd_len = ver < 6 ? sizeof(struct iwl_roc_req_v5) : sizeof(roc_cmd);
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0,
-				   sizeof(roc_cmd), &roc_cmd);
+				   cmd_len, &roc_cmd);
 	if (ret)
 		IWL_ERR(mvm, "Couldn't send the ROC_CMD: %d\n", ret);
 }
@@ -1102,11 +1104,13 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 {
 	int res;
 	u32 duration_tu, delay;
-	struct iwl_roc_req_v5 roc_req = {
+	struct iwl_roc_req roc_req = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
 		.activity = cpu_to_le32(activity),
 		.sta_id = cpu_to_le32(mvm->aux_sta.sta_id),
 	};
+	u8 ver = iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
+	u16 cmd_len = ver < 6 ? sizeof(struct iwl_roc_req_v5) : sizeof(roc_req);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	lockdep_assert_held(&mvm->mutex);
@@ -1136,7 +1140,7 @@ int iwl_mvm_roc_add_cmd(struct iwl_mvm *mvm,
 	memcpy(roc_req.node_addr, vif->addr, ETH_ALEN);
 
 	res = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
-				   0, sizeof(roc_req), &roc_req);
+				   0, cmd_len, &roc_req);
 	if (!res)
 		mvmvif->roc_activity = activity;
 
-- 
2.34.1


