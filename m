Return-Path: <linux-wireless+bounces-2407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C1839752
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75CF1C2572B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024DE81AA1;
	Tue, 23 Jan 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5mew35I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF68121F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033359; cv=none; b=S8+h6fyY5PX0TodUaC0Ja2euuFBCDOOmqzM61S0gNOv3UXvNIq9sjEgeHKtdBosUBMllOZ0MEBAZNKLE4kp19swhdZDAoTyWd1wBEy1BSTXpBBFx8BuHv+Vf5qXm0wT5Q5OcoyE4KZCuI0OdXxSSWLJXRNziFj35FXt/NOHu/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033359; c=relaxed/simple;
	bh=MM8MLz3EvZM0lcopyxHLbQ7ct/QUVdWPEOxiQs/ZHCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+7Bs5kde94ihT0Gh0hpp8sQZ29rICUe23Las+Ct1Uf91SS2VJxHCp4WRjtV3LpH+CVUTo5/5Tm7J1OKpTVqEMYn8z1YrYyPelnqTk/ikVke9eWlhQ5JdWKqcHW62Av03xjG7/5XARI1ryeFfQIuCdOsgu6sc47gBrnh00QxH2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5mew35I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033359; x=1737569359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MM8MLz3EvZM0lcopyxHLbQ7ct/QUVdWPEOxiQs/ZHCw=;
  b=J5mew35I6BePg4yEt3mg+6idv5YnUy+cIm5yR83aNdd3pICbgcJ2U8Tq
   J+ccWy7pgaLqh8xjzL3muMfmBmRVx7VuUUZ3jQ1a+1YtuaoRb3mRI3rkj
   M1oolrINDPW0rS5i89PYyQ2BZXLsLNxoEzxTim97e2C5yFdN0oJmlLf0P
   UUJflDhRlfOfOEOxln5A+LMiPJnGR6j7AA8a5c7hMLn6z3gTkcCM9ysvN
   YR+CWJEmwUqPF07m0pMk4sXv6LNZ28+NEbvwISPhByWlhJaydsoYoO26w
   L+Z0pJm3usZv+ReusNKMjdUjMNwG4jB78AorJzVQsNbp0U9CDzG9ReC6X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="501948"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="501948"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666611"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: introduce PHY_CONTEXT_CMD_API_VER_5
Date: Tue, 23 Jan 2024 20:08:20 +0200
Message-Id: <20240123200528.82ab4140fff9.Icfba4819fe0b7ac8219ab671c632e25f5fbbaf6f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This command version adds two news fields:
sbb_bandwidth and sbb_ctrl_channel_loc
They will be populated later.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h | 16 ++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c    |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
index 306ed88de463..205d0413e626 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h
@@ -142,6 +142,8 @@ struct iwl_phy_context_cmd_v1 {
  * @lmac_id: the lmac id the phy context belongs to
  * @ci: channel info
  * @rxchain_info: ???
+ * @sbb_bandwidth: 0 disabled, 1 - 40Mhz ... 4 - 320MHz
+ * @sbb_ctrl_channel_loc: location of the control channel
  * @dsp_cfg_flags: set to 0
  * @reserved: reserved to align to 64 bit
  */
@@ -152,9 +154,19 @@ struct iwl_phy_context_cmd {
 	/* PHY_CONTEXT_DATA_API_S_VER_3, PHY_CONTEXT_DATA_API_S_VER_4 */
 	struct iwl_fw_channel_info ci;
 	__le32 lmac_id;
-	__le32 rxchain_info; /* reserved in _VER_4 */
+	union {
+		__le32 rxchain_info; /* reserved in _VER_4 */
+		struct {             /* used for _VER_5 */
+			u8 sbb_bandwidth;
+			u8 sbb_ctrl_channel_loc;
+			__le16 reserved;
+		} v5;
+	};
 	__le32 dsp_cfg_flags;
 	__le32 reserved;
-} __packed; /* PHY_CONTEXT_CMD_API_VER_3, PHY_CONTEXT_CMD_API_VER_4 */
+} __packed; /* PHY_CONTEXT_CMD_API_VER_3,
+	     * PHY_CONTEXT_CMD_API_VER_4,
+	     * PHY_CONTEXT_CMD_API_VER_5
+	     */
 
 #endif /* __iwl_fw_api_phy_ctxt_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 334d1f59f6e4..8bf778503b74 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -204,7 +204,7 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 	int ret;
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1);
 
-	if (ver == 3 || ver == 4) {
+	if (ver >= 3 && ver <= 5) {
 		struct iwl_phy_context_cmd cmd = {};
 
 		/* Set the command header fields */
-- 
2.34.1


