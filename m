Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6205AED2C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240861AbiIFOK4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbiIFOJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:09:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C1D7E321
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471989; x=1694007989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bmt+8Xkm4Lsqx2EPIpivvCH7Yqisx486Dbb78u3vDcI=;
  b=mYmtu2+BZJqWPLSf+empyNPe3WL5Ntw2qtaE9ZYjKc0k0ccpehqep63m
   nxtZIiaaiYGMA6Ej52w1Jk0d9IB36isUf7oSfEG+ke1+p/x114qsK/iPA
   0yqO+4qEy2lcB4I/Ye9/dhiFNt9r0wmi4rYUyrggmlqh3AMLulRtU9m0g
   JSIAQM2XJElNpsU5SG1XYQL4Ew6aMpypKR7XbtvBeOrZRgwMqpg5V9YWY
   wETvxlpXv+vGUFRju9xQVQE8tCa9KD1xOqckHAHLH5xXt92QgLbWyk1Oh
   E5DIqPCOSx2uXIz5WH5NDAF7qJaDmr9VUAQe/4cc5qZ2LB9NLABSwT+i7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276989048"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276989048"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459919"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:51 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: enable resume based on notifications
Date:   Tue,  6 Sep 2022 16:42:15 +0300
Message-Id: <20220906161827.a6344ba23df5.I09fce8cf5aac1d46b40ae81b1abcf7a0e54af196@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

We have recently added support for resume based on notifications.
Enable it.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 3a593f6175fd..90871f3603de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2725,6 +2725,16 @@ static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 				     IWL_MVM_D3_NOTIF_TIMEOUT);
 }
 
+static inline bool iwl_mvm_d3_resume_notif_based(struct iwl_mvm *mvm)
+{
+	return iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
+				       WOWLAN_INFO_NOTIFICATION, 0) &&
+		iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
+					WOWLAN_WAKE_PKT_NOTIFICATION, 0) &&
+		iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
+					D3_END_NOTIFICATION, 0);
+}
+
 static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 {
 	struct ieee80211_vif *vif = NULL;
@@ -2740,8 +2750,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 	bool d0i3_first = fw_has_capa(&mvm->fw->ucode_capa,
 				      IWL_UCODE_TLV_CAPA_D0I3_END_FIRST);
-	/* currently disabled */
-	bool resume_notif_based = false;
+	bool resume_notif_based = iwl_mvm_d3_resume_notif_based(mvm);
 
 	mutex_lock(&mvm->mutex);
 
-- 
2.35.3

