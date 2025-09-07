Return-Path: <linux-wireless+bounces-27060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE5AB479A8
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC443C30FC
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B6521CC58;
	Sun,  7 Sep 2025 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B172rfXW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9221CA0E
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233870; cv=none; b=Gd5MKxIKxVLtM8fu4kbyAcniAcOuLntoDcbZtZ/hqI43ZKyteXeGfv9eYl+lSxjrhvJ2XxkhMbKpTcI3N3VNs8BmRuT/ER1iI4EuVA8gYzGk8nkYJZQWx2BqBgPczQoTBDZQa5OsrROUpy2p+251xDhxh5U+I+0NJeHLyHnG1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233870; c=relaxed/simple;
	bh=usWEh4wTy5YkgXyDBKKneYCnA6yu1RVhRKm3DaOKDtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u2j93W6xkYe66R/sBrDm1uJWfgcmMpWEAZ9qOHWXctuXcrHfmcE23w1e89sgAFldNf3f6Xlm7IMbQ7I9kY5XPqPcErwZnQfwpOjd80G7QXwlAsUUra2id5O+d3YawrUqn2Rl7jDplO2HtDibaht2v+ERwKbgROruCR0W9YmEkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B172rfXW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233869; x=1788769869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=usWEh4wTy5YkgXyDBKKneYCnA6yu1RVhRKm3DaOKDtQ=;
  b=B172rfXWJQUYPFSk+Go69fBrZQGLMwiCLFic7LKqbqkppv9XqtFJTppJ
   neD89R/py4winrsQSMu3DbWXwDx+XDs2x73m+jdU1Jhu8dF+Mx6jv6TDN
   je+OVkJEzHukXpfypTerAxuiI7kxqZtXDdk6EXEMY1SAHP1iL+3Hsu72X
   e+xADJ6frq0NNREty7exv369uQEtexzkyzfcPFB5j8KQyYFqdj2mbbKML
   UKtqsA53dV3DumOhAl7cFrOY0PaOSZ2q8uDCBeJo8LnmHqdM2MoqhycXQ
   Q+KPOlIsQEswVk8lpclbt6GBEwWUWnpB/kiuJY2A4ypmGzsrWD4HTkJCO
   g==;
X-CSE-ConnectionGUID: kXCCXWIaQI6q6mwoQGo/dQ==
X-CSE-MsgGUID: wNQarWpkQeW7ilc/lwjAaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973625"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973625"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:09 -0700
X-CSE-ConnectionGUID: vdYpX5h9TEycc6Qvi6h5nQ==
X-CSE-MsgGUID: KeyMeJhvT+uCZl4uGvDAcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171790082"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:31:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: remove support from of sta cmd version 1
Date: Sun,  7 Sep 2025 11:30:12 +0300
Message-Id: <20250907112757.423b075d9637.I5d2bf7302eea8ac7a805f58e4e60e527d6f5b346@changeid>
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

The last FW API that supports version 1 is 99. Since this API is no
longer supported on any device that loads iwlmld, we can remove support
of it.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/sta.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 8fb51209b4a6..5cdbfa29a202 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -401,11 +401,9 @@ static u32 iwl_mld_get_htc_flags(struct ieee80211_link_sta *link_sta)
 static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
 				const struct iwl_sta_cfg_cmd *cmd)
 {
-	u32 cmd_id = WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD);
-	int cmd_len = iwl_fw_lookup_cmd_ver(mld->fw, cmd_id, 0) > 1 ?
-		      sizeof(*cmd) :
-		      sizeof(struct iwl_sta_cfg_cmd_v1);
-	int ret = iwl_mld_send_cmd_pdu(mld, cmd_id, cmd, cmd_len);
+	int ret = iwl_mld_send_cmd_pdu(mld,
+				       WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD),
+				       cmd);
 	if (ret)
 		IWL_ERR(mld, "STA_CONFIG_CMD send failed, ret=0x%x\n", ret);
 	return ret;
-- 
2.34.1


