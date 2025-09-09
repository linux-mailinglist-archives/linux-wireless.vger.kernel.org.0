Return-Path: <linux-wireless+bounces-27131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC801B49FFC
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AAF1B24898
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB0264A90;
	Tue,  9 Sep 2025 03:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPM3MH3H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7652D0605
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388133; cv=none; b=rfgBpkdzZAHTCY556mUWRLhVgV2KwR+Kclx9kVDIrrUL42As4bA14G6XuZU3yw38B+oLNAMBDk9uVU7BMRFPs9J4xpjH9MUMvS0V+E3N3BGkZW89FfmCixC0dJfXk9QpCmfkgZWBu5NwtRJmz3VR8xNmVAtv/ozItOr+Gr6gb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388133; c=relaxed/simple;
	bh=tDbYbfAsxm6WTic1PEuoKKf9bhTy4FyAgwXIeHgIMwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwfU1BRwLIig89273hMn3+57aNMeTkzpnbwJSUBDuA+rTdJZlZxcsSetQsf2fmutqVoFm3pNssdYUMguNXgnnLdEYz9/xBgMobTxU+u6MEo46t6fQP91QKbHH3uI/Hp11phZ0/OmQfP4P/gh7Vc3w9SN/huEzHYBTenFJZ1kgEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPM3MH3H; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388131; x=1788924131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDbYbfAsxm6WTic1PEuoKKf9bhTy4FyAgwXIeHgIMwU=;
  b=lPM3MH3HUFqckWOSt+aq8w0jX3jwmBrXql/8mdwMOlPKuzl56RJZ4ADw
   xCvzdr1nN3rDWbtqABCQGOAk0KsuskYJZsWs4JX7YeStLHTk0G25CwBJT
   WRPrD9MRdRz5rjzqS3kep0DjyU2QqcKxSfaSOm9fWvNeg35g69AdzZdsG
   7XCgTbju9jvo+1QIXBSNm3b22D/wC5sjeyKTtw4jvxje5FbGXC4y0ikON
   rrBvPlvpr1vhiodmxQDyyMXC3YPnsiYuttfNWQ1tQnTNmZVRULNb43W7/
   v8hPE0b1q7HK2cx5H5C6Jf+xlqgQAYAHIsYxR4KU8EKHVS3UvTnDG8gCP
   A==;
X-CSE-ConnectionGUID: eONj2LRTQpapuqZ5PnT1pA==
X-CSE-MsgGUID: wbwcungkRnusvyFRHUaVVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281073"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281073"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:11 -0700
X-CSE-ConnectionGUID: NAr6BfWXREap/iKKHpHaZw==
X-CSE-MsgGUID: CO+9xTuVRLSNFTvncjcrAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950398"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:22:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 12/15] wifi: iwlwifi: mld: remove support of roc cmd version 5
Date: Tue,  9 Sep 2025 06:21:25 +0300
Message-Id: <20250909061931.e53bd8553360.I6978c216b52b818b879d076a85c5f9edafcf2e99@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
References: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
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


