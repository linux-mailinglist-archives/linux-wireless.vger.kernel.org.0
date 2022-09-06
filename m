Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E055AEB9C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbiIFOKt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241168AbiIFOI5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:08:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4793F868AF
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471987; x=1694007987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7CK7F+9fxRc3H7WEk1L1dHFbjNCtwDCqmw5x07uFyo=;
  b=agFqV1/19DpAGFlM+y+2bG0PqZGalSGXdQ2AVwDv3iH9UUrUwoW530R9
   iZ17lTAIzRtpwyweiJWOGy1FQbVAhrNcbbwBe2LEsQw3kHLqwRGBFFVKJ
   vBkrtyFRR8g0It+CH53qByDTPSziNNmx+lGlm4rfFzrRaLww5FfUpzGfN
   k2Ux976zL24AuyvlQDiSfqYTp5uL7yHZMtAi/Z3GmM6N1z4zb5R+EOwMC
   Zjk0k8DiKFD21HSQnFdJ1w+A5dIDwywJWZK8gnqKTFl/C1wH1oj5zQfPM
   gzuzJjras1cGOrWpBI/FXwPaBubujg6CJhAWY/p8tzwLWqPGDFPSfk455
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276989040"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276989040"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459907"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:48 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: Add support for d3 end notification
Date:   Tue,  6 Sep 2022 16:42:14 +0300
Message-Id: <20220906161827.898ecba881b2.I13eb69bb5af08b9ac33043647eaed6b8d50e8659@changeid>
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

Due to IMR, when host returns from hibernate, commands cannot
be sent as part of the resume flow, and so after ending
d3 the FW needs to send notifications instead of responses.
This notification indicates whether a fw reset is required.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  8 +++++
 .../wireless/intel/iwlwifi/fw/api/offload.h   |  5 +++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 34 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 5588f6d65813..df0833890e55 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -817,6 +817,14 @@ struct iwl_wowlan_wake_pkt_notif {
 	u8 wake_packet[1];
 } __packed; /* WOWLAN_WAKE_PKT_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_mvm_d3_end_notif -  d3 end notification
+ * @flags: See &enum iwl_d0i3_flags
+ */
+struct iwl_mvm_d3_end_notif {
+	__le32 flags;
+} __packed;
+
 /* TODO: NetDetect API */
 
 #endif /* __iwl_fw_api_d3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 1a1b7ac78309..a0123f81f5d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -22,6 +22,11 @@ enum iwl_prot_offload_subcmd_ids {
 	 */
 	WOWLAN_INFO_NOTIFICATION = 0xFD,
 
+	/**
+	 * @D3_END_NOTIFICATION: End D3 state notification
+	 */
+	D3_END_NOTIFICATION = 0xFE,
+
 	/**
 	 * @STORED_BEACON_NTF: &struct iwl_stored_beacon_notif
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 77e70899c46e..3a593f6175fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2517,16 +2517,21 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
  * enum iwl_d3_notif - d3 notifications
  * @IWL_D3_NOTIF_WOWLAN_INFO: WOWLAN_INFO_NOTIF was received
  * @IWL_D3_NOTIF_WOWLAN_WAKE_PKT: WOWLAN_WAKE_PKT_NOTIF was received
+ * @IWL_D3_NOTIF_PROT_OFFLOAD: PROT_OFFLOAD_NOTIF was received
+ * @IWL_D3_NOTIF_D3_END_NOTIF: D3_END_NOTIF was received
  */
 enum iwl_d3_notif {
 	IWL_D3_NOTIF_WOWLAN_INFO =	BIT(0),
 	IWL_D3_NOTIF_WOWLAN_WAKE_PKT =	BIT(1),
+	IWL_D3_NOTIF_PROT_OFFLOAD =	BIT(2),
+	IWL_D3_NOTIF_D3_END_NOTIF =	BIT(3)
 };
 
 /* manage d3 resume data */
 struct iwl_d3_data {
 	struct iwl_wowlan_status_data *status;
 	bool test;
+	u32 d3_end_flags;
 	u32 notif_expected;	/* bitmap - see &enum iwl_d3_notif */
 	u32 notif_received;	/* bitmap - see &enum iwl_d3_notif */
 };
@@ -2670,6 +2675,14 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 
 		break;
 	}
+	case WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION): {
+		struct iwl_mvm_d3_end_notif *notif = (void *)pkt->data;
+
+		d3_data->d3_end_flags = __le32_to_cpu(notif->flags);
+		d3_data->notif_received |= IWL_D3_NOTIF_D3_END_NOTIF;
+
+		break;
+	}
 	default:
 		WARN_ON(1);
 	}
@@ -2686,7 +2699,8 @@ static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 {
 	static const u16 d3_resume_notif[] = {
 		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION),
-		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_WAKE_PKT_NOTIFICATION)
+		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_WAKE_PKT_NOTIFICATION),
+		WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION)
 	};
 	struct iwl_notification_wait wait_d3_notif;
 	int ret;
@@ -2718,7 +2732,9 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	enum iwl_d3_status d3_status;
 	struct iwl_d3_data d3_data = {
 		.test = test,
-		.notif_expected = IWL_D3_NOTIF_WOWLAN_INFO,
+		.notif_expected =
+			IWL_D3_NOTIF_WOWLAN_INFO |
+			IWL_D3_NOTIF_D3_END_NOTIF,
 	};
 	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
@@ -2788,6 +2804,10 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	/* after the successful handshake, we're out of D3 */
 	mvm->trans->system_pm_mode = IWL_PLAT_PM_MODE_DISABLED;
 
+	/* when reset is required we can't send these following commands */
+	if (d3_data.d3_end_flags & IWL_D0I3_RESET_REQUIRE)
+		goto query_wakeup_reasons;
+
 	/*
 	 * Query the current location and source from the D3 firmware so we
 	 * can play it back when we re-intiailize the D0 firmware
@@ -2812,6 +2832,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 					false);
 	}
 
+query_wakeup_reasons:
 	iwl_mvm_choose_query_wakeup_reasons(mvm, vif, &d3_data, d3_data.test);
 	/* has unlocked the mutex, so skip that */
 	goto out;
@@ -2832,9 +2853,14 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		if (d0i3_first)
 			return 0;
 
-		ret = iwl_mvm_send_cmd_pdu(mvm, D0I3_END_CMD, 0, 0, NULL);
-		if (!ret)
+		if (!iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
+					     D3_END_NOTIFICATION, 0)) {
+			ret = iwl_mvm_send_cmd_pdu(mvm, D0I3_END_CMD, 0, 0, NULL);
+			if (!ret)
+				return 0;
+		} else if (!(d3_data.d3_end_flags & IWL_D0I3_RESET_REQUIRE)) {
 			return 0;
+		}
 	}
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 9c8adb0c2acf..3eb59b958801 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -576,6 +576,7 @@ static const struct iwl_hcmd_names iwl_mvm_location_names[] = {
 static const struct iwl_hcmd_names iwl_mvm_prot_offload_names[] = {
 	HCMD_NAME(WOWLAN_WAKE_PKT_NOTIFICATION),
 	HCMD_NAME(WOWLAN_INFO_NOTIFICATION),
+	HCMD_NAME(D3_END_NOTIFICATION),
 	HCMD_NAME(STORED_BEACON_NTF),
 };
 
-- 
2.35.3

