Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12835AEC9C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbiIFOKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241303AbiIFOJY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:09:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E26B79A41
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471993; x=1694007993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93ISQq+irzOavLdLd3bn6WLgY29G1/toWR4cJd/N8RY=;
  b=I6W9RXQw1nhV6nt2N2Bydq9XnFPfIoatjARND3dNpsKPs6zPsFEHtJQs
   zIdR7GuRLeM2kPlbkozTy/KvNqqCan15it7azhuFRsysDdxBJqsgD7rem
   4YXVdlrpu4/4v36hY64qsmOoGBsut/IwBishESOAIHzTRWc1nYZgM/iA8
   9rC6dDHhKLqO1WWdSJ8aOIzvoEYiJDzLhGWYX6DQ/y4XxhLCAPKv9un+V
   dkdgtzrdqkgQaYTdm1793m2jMuPJCpIssXyLHJG45ouV5XbGojKANLy1/
   VLYh5OaAkn7tOIiYpqmPe85YvdU3TlMvP/om22wK4QrwdPAxlb9J2nkEZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276989075"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276989075"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459950"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:56 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        "Haim, Dreyfuss" <haim.dreyfuss@intel.com>, Haim@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: trigger resume flow before wait for notifications
Date:   Tue,  6 Sep 2022 16:42:17 +0300
Message-Id: <20220906161827.5f0f251edf9c.Ia49ab73105af6f52aa7d318f4984edecd3b0671a@changeid>
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

From: "Haim, Dreyfuss" <haim.dreyfuss@intel.com>

We have recently enabled resume flow based on notifications.
These notifications are sent by the FW when completing the resume flow.
From IWL_DEVICE_FAMILY_AX210 the resume flow is triggered by the
transport layer on iwl_trans_d3_resume.
On IWL_DEVICE_FAMILY_22000 and earlier we trigger the resume flow by
sending the D0I3 command.

Currently, we are waiting for the notifications before sending the
command, the notifications won't be sent by the FW since there is no
resume trigger to piggyback on.

Send the command before starting the wait flow to fix it.

Signed-off-by: Haim, Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 77 ++++++++++++---------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 8c38e96ae608..012fe872d9aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2771,11 +2771,46 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	return d3_data->notif_received == d3_data->notif_expected;
 }
 
+static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm, bool test)
+{
+	int ret;
+	enum iwl_d3_status d3_status;
+	struct iwl_host_cmd cmd = {
+			.id = D0I3_END_CMD,
+			.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
+		};
+	bool reset = fw_has_capa(&mvm->fw->ucode_capa,
+				 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
+
+	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test, !reset);
+	if (ret)
+		return ret;
+
+	if (d3_status != IWL_D3_STATUS_ALIVE) {
+		IWL_INFO(mvm, "Device was reset during suspend\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * We should trigger resume flow using command only for 22000 family
+	 * AX210 and above don't need the command since they have
+	 * the doorbell interrupt.
+	 */
+	if (mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_22000 &&
+	    fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_D0I3_END_FIRST)) {
+		ret = iwl_mvm_send_cmd(mvm, &cmd);
+		if (ret < 0)
+			IWL_ERR(mvm, "Failed to send D0I3_END_CMD first (%d)\n",
+				ret);
+	}
+
+	return ret;
+}
+
 #define IWL_MVM_D3_NOTIF_TIMEOUT (HZ / 5)
 
 static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
-				 struct iwl_d3_data *d3_data,
-				 enum iwl_d3_status *d3_status)
+				 struct iwl_d3_data *d3_data)
 {
 	static const u16 d3_resume_notif[] = {
 		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION),
@@ -2790,18 +2825,12 @@ static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 				   d3_resume_notif, ARRAY_SIZE(d3_resume_notif),
 				   iwl_mvm_wait_d3_notif, d3_data);
 
-	ret = iwl_trans_d3_resume(mvm->trans, d3_status, d3_data->test, false);
+	ret = iwl_mvm_resume_firmware(mvm, d3_data->test);
 	if (ret) {
 		iwl_remove_notification(&mvm->notif_wait, &wait_d3_notif);
 		return ret;
 	}
 
-	if (*d3_status != IWL_D3_STATUS_ALIVE) {
-		IWL_INFO(mvm, "Device was reset during suspend\n");
-		iwl_remove_notification(&mvm->notif_wait, &wait_d3_notif);
-		return -ENOENT;
-	}
-
 	return iwl_wait_notification(&mvm->notif_wait, &wait_d3_notif,
 				     IWL_MVM_D3_NOTIF_TIMEOUT);
 }
@@ -2820,7 +2849,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 {
 	struct ieee80211_vif *vif = NULL;
 	int ret = 1;
-	enum iwl_d3_status d3_status;
 	struct iwl_mvm_nd_results results = {};
 	struct iwl_d3_data d3_data = {
 		.test = test,
@@ -2866,32 +2894,13 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 			goto err;
 		}
 
-		ret = iwl_mvm_d3_notif_wait(mvm, &d3_data, &d3_status);
+		ret = iwl_mvm_d3_notif_wait(mvm, &d3_data);
+		if (ret)
+			goto err;
 	} else {
-		ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test,
-					  !unified_image);
-	}
-
-	if (ret)
-		goto err;
-
-	if (d3_status != IWL_D3_STATUS_ALIVE) {
-		IWL_INFO(mvm, "Device was reset during suspend\n");
-		goto err;
-	}
-
-	if (d0i3_first && mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_22000) {
-		struct iwl_host_cmd cmd = {
-			.id = D0I3_END_CMD,
-			.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
-		};
-
-		ret = iwl_mvm_send_cmd(mvm, &cmd);
-		if (ret < 0) {
-			IWL_ERR(mvm, "Failed to send D0I3_END_CMD first (%d)\n",
-				ret);
+		ret = iwl_mvm_resume_firmware(mvm, test);
+		if (ret < 0)
 			goto err;
-		}
 	}
 
 	/* after the successful handshake, we're out of D3 */
-- 
2.35.3

