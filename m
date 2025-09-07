Return-Path: <linux-wireless+bounces-27059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15496B479A7
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FE116A371
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574522172D;
	Sun,  7 Sep 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A216Yr+w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFD22128A
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233869; cv=none; b=PYINaku7zu2APKYKWLuKX+aw40cBrYV6TVIT/u6XBl+VjhnxCQ74CGi3SODlbT40qrctwyOwMcyAkFyrs9eoja4a8SirK5vMogOCaBnty8qfXtgOdRBKIL89cJkU+Zm8U5iI6Vq0FOSU/6aV3YLC6RsKiGvPl2nZtZL/dcKGvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233869; c=relaxed/simple;
	bh=tDbYbfAsxm6WTic1PEuoKKf9bhTy4FyAgwXIeHgIMwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vl3qGFpbDAp+kdl4Xha58oM6k0Hjn/Zs2MtLRg9VzIfKD7FSzzoLUNy3kDMg+SpVT7HMGcv5BKWl5tURj9jgIcLYIL+acaXUQpdXXtARkTJc1paNAd1YM1JR9TsUJ9u8PJ5yH+vviRxH5oUe0e8AOVupURXkDSToODGwPLEuH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A216Yr+w; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233868; x=1788769868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDbYbfAsxm6WTic1PEuoKKf9bhTy4FyAgwXIeHgIMwU=;
  b=A216Yr+wxloWmGNEe3+a5d1I9QGuK0CGBvUkP0S6xrzFVTLUDwuEIvEc
   +LJtOzyEOBIESiPrA61XQm9x5n3j4LnpJWPJTcazVpbtMku1l7u2Xc6Hy
   i3ASRx97WdXfoZLFxyeqPYRQ31vzUhNKqhYDcHwLKya2rFjFn14EbFDEQ
   LrzqHX//BP1xV3uMwBSX6xjsPf5DWKHLhVtYFGUN6N3Vh+/ylsTRggUVY
   /6oCPr/OknVOcdpMGEB6NflxdPhRrGKgbBtEPWjFB2kToubqg2m/TRLG9
   P3RdKlFQFJXXDzsBuTYCZ1J+t2h/Jt9k3jat18oys4g4DVio98d6I5PDs
   Q==;
X-CSE-ConnectionGUID: AExfDIwESciZ+oRes0qPlg==
X-CSE-MsgGUID: zH2GU7aIQyW+wt4dWSCMhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973624"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973624"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:08 -0700
X-CSE-ConnectionGUID: Z8zM2PQXSXeGBvi0LvSCnQ==
X-CSE-MsgGUID: lSuyKtaISIO1KDtrdypuxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790076"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: remove support of roc cmd version 5
Date: Sun,  7 Sep 2025 11:30:11 +0300
Message-Id: <20250907112757.9616b142da5c.I6978c216b52b818b879d076a85c5f9edafcf2e99@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
References: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The last FW API that supports version 5 is 97. Since this API is no
longer supported on any device that loads iwlmld, we can remove support
of it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/roc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/roc.c b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
index e85f45bce79a..4136c98030d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/roc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
@@ -82,9 +82,6 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct iwl_roc_req cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
 	};
-	u8 ver = iwl_fw_lookup_cmd_ver(mld->fw,
-				       WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
-	u16 cmd_len = ver < 6 ? sizeof(struct iwl_roc_req_v5) : sizeof(cmd);
 	enum iwl_roc_activity activity;
 	int ret = 0;
 
@@ -140,7 +137,7 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	memcpy(cmd.node_addr, vif->addr, ETH_ALEN);
 
 	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
-				   &cmd, cmd_len);
+				   &cmd);
 	if (ret) {
 		IWL_ERR(mld, "Couldn't send the ROC_CMD\n");
 		return ret;
@@ -190,9 +187,6 @@ int iwl_mld_cancel_roc(struct ieee80211_hw *hw,
 	struct iwl_roc_req cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
 	};
-	u8 ver = iwl_fw_lookup_cmd_ver(mld->fw,
-				       WIDE_ID(MAC_CONF_GROUP, ROC_CMD), 0);
-	u16 cmd_len = ver < 6 ? sizeof(struct iwl_roc_req_v5) : sizeof(cmd);
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
@@ -208,7 +202,7 @@ int iwl_mld_cancel_roc(struct ieee80211_hw *hw,
 	cmd.activity = cpu_to_le32(mld_vif->roc_activity);
 
 	ret = iwl_mld_send_cmd_pdu(mld, WIDE_ID(MAC_CONF_GROUP, ROC_CMD),
-				   &cmd, cmd_len);
+				   &cmd);
 	if (ret)
 		IWL_ERR(mld, "Couldn't send the command to cancel the ROC\n");
 
-- 
2.34.1


