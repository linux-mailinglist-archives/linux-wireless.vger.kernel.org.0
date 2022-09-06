Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB795AECF6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiIFOLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbiIFOJc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:09:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB312018B
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662472001; x=1694008001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hoTdyMPRK8mYLBSLeWumzqGvsYvug2vZg1+TRcG7k6E=;
  b=ZEjby89k3jVu1/jgxTKyjTztf17hsqs2l/N2SOHyHiDVVNWS58MToh3U
   qlE+pNCNvayMRIFNWCm0ZQhURQVLckM2Q469EFitZjFAP/ea4kaqXhxij
   fTl4Fqdi7IGrY98C9ajobsEKxxW9584lIgSIAEIu8B4ixB7K7o2Wy6PlJ
   snYt9bdDqAcQI+LxWekv1Np0GR+PwsOhnF3ztKAPJg1vwOETwsvsyjoiu
   Aj6t8AoBE1+IbzUjmV44rrW5g3AGR/0pXG+OHkL/dLI18DR970hcfsB+1
   5FBTvoXU1+c4gWHo/5ug1lFR+BxeRmSFXV07tUrK4vko6FeDqH0ELOngO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276989089"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276989089"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:45:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459999"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:45:01 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: d3: parse keys from wowlan info notification
Date:   Tue,  6 Sep 2022 16:42:19 +0300
Message-Id: <20220906161827.ca3fb23cab81.I0a9fe7729af4567b98813bc51bad13ee5512a0ae@changeid>
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

From: Naftali Goldstein <naftali.goldstein@intel.com>

This notification replaces the WOWLAN_GET_STATUSES command-and-response,
so it's required to parse all the keys in the notification just like
what happened when that command was used.

Move around a few required static functions in order to avoid forward
declarations.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 171 ++++++++++----------
 1 file changed, 88 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d8a67f391ab9..919b1f478b4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1944,6 +1944,94 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	return true;
 }
 
+static void iwl_mvm_convert_gtk_v2(struct iwl_wowlan_status_data *status,
+				   struct iwl_wowlan_gtk_status_v2 *data)
+{
+	BUILD_BUG_ON(sizeof(status->gtk.key) < sizeof(data->key));
+	BUILD_BUG_ON(NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY +
+		     sizeof(data->tkip_mic_key) >
+		     sizeof(status->gtk.key));
+
+	status->gtk.len = data->key_len;
+	status->gtk.flags = data->key_flags;
+
+	memcpy(status->gtk.key, data->key, sizeof(data->key));
+
+	/* if it's as long as the TKIP encryption key, copy MIC key */
+	if (status->gtk.len == NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY)
+		memcpy(status->gtk.key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+		       data->tkip_mic_key, sizeof(data->tkip_mic_key));
+}
+
+static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
+				   struct iwl_wowlan_gtk_status_v3 *data)
+{
+	/* The parts we need are identical in v2 and v3 */
+#define CHECK(_f) do {							\
+	BUILD_BUG_ON(offsetof(struct iwl_wowlan_gtk_status_v2, _f) !=	\
+		     offsetof(struct iwl_wowlan_gtk_status_v3, _f));	\
+	BUILD_BUG_ON(offsetofend(struct iwl_wowlan_gtk_status_v2, _f) !=\
+		     offsetofend(struct iwl_wowlan_gtk_status_v3, _f));	\
+} while (0)
+
+	CHECK(key);
+	CHECK(key_len);
+	CHECK(key_flags);
+	CHECK(tkip_mic_key);
+#undef CHECK
+
+	iwl_mvm_convert_gtk_v2(status, (void *)data);
+}
+
+static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
+				 struct iwl_wowlan_igtk_status *data)
+{
+	const u8 *ipn = data->ipn;
+
+	BUILD_BUG_ON(sizeof(status->igtk.key) < sizeof(data->key));
+
+	status->igtk.len = data->key_len;
+	status->igtk.flags = data->key_flags;
+
+	memcpy(status->igtk.key, data->key, sizeof(data->key));
+
+	status->igtk.ipn = ((u64)ipn[5] <<  0) |
+			   ((u64)ipn[4] <<  8) |
+			   ((u64)ipn[3] << 16) |
+			   ((u64)ipn[2] << 24) |
+			   ((u64)ipn[1] << 32) |
+			   ((u64)ipn[0] << 40);
+}
+
+static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
+					    struct iwl_wowlan_info_notif *data,
+					    struct iwl_wowlan_status_data *status,
+					    u32 len)
+{
+	u32 i;
+
+	if (len < sizeof(*data)) {
+		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
+		status = NULL;
+		return;
+	}
+
+	iwl_mvm_convert_key_counters_v5(status, &data->gtk[0].sc);
+	iwl_mvm_convert_gtk_v3(status, &data->gtk[0]);
+	iwl_mvm_convert_igtk(status, &data->igtk[0]);
+
+	status->replay_ctr = le64_to_cpu(data->replay_ctr);
+	status->pattern_number = le16_to_cpu(data->pattern_number);
+	for (i = 0; i < IWL_MAX_TID_COUNT; i++)
+		status->qos_seq_ctr[i] =
+			le16_to_cpu(data->qos_seq_ctr[i]);
+	status->wakeup_reasons = le32_to_cpu(data->wakeup_reasons);
+	status->num_of_gtk_rekeys =
+		le32_to_cpu(data->num_of_gtk_rekeys);
+	status->received_beacons = le32_to_cpu(data->received_beacons);
+	status->tid_tear_down = data->tid_tear_down;
+}
+
 /* Occasionally, templates would be nice. This is one of those times ... */
 #define iwl_mvm_parse_wowlan_status_common(_ver)			\
 static struct iwl_wowlan_status_data *					\
@@ -2005,89 +2093,6 @@ iwl_mvm_parse_wowlan_status_common(v7)
 iwl_mvm_parse_wowlan_status_common(v9)
 iwl_mvm_parse_wowlan_status_common(v12)
 
-static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
-					    struct iwl_wowlan_info_notif *data,
-					    struct iwl_wowlan_status_data *status,
-					    u32 len)
-{
-	u32 i;
-
-	if (len < sizeof(*data)) {
-		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
-		status = NULL;
-		return;
-	}
-
-	status->replay_ctr = le64_to_cpu(data->replay_ctr);
-	status->pattern_number = le16_to_cpu(data->pattern_number);
-	for (i = 0; i < IWL_MAX_TID_COUNT; i++)
-		status->qos_seq_ctr[i] =
-			le16_to_cpu(data->qos_seq_ctr[i]);
-	status->wakeup_reasons = le32_to_cpu(data->wakeup_reasons);
-	status->num_of_gtk_rekeys =
-		le32_to_cpu(data->num_of_gtk_rekeys);
-	status->received_beacons = le32_to_cpu(data->received_beacons);
-}
-
-static void iwl_mvm_convert_gtk_v2(struct iwl_wowlan_status_data *status,
-				   struct iwl_wowlan_gtk_status_v2 *data)
-{
-	BUILD_BUG_ON(sizeof(status->gtk.key) < sizeof(data->key));
-	BUILD_BUG_ON(NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY +
-		     sizeof(data->tkip_mic_key) >
-		     sizeof(status->gtk.key));
-
-	status->gtk.len = data->key_len;
-	status->gtk.flags = data->key_flags;
-
-	memcpy(status->gtk.key, data->key, sizeof(data->key));
-
-	/* if it's as long as the TKIP encryption key, copy MIC key */
-	if (status->gtk.len == NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY)
-		memcpy(status->gtk.key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
-		       data->tkip_mic_key, sizeof(data->tkip_mic_key));
-}
-
-static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
-				   struct iwl_wowlan_gtk_status_v3 *data)
-{
-	/* The parts we need are identical in v2 and v3 */
-#define CHECK(_f) do {							\
-	BUILD_BUG_ON(offsetof(struct iwl_wowlan_gtk_status_v2, _f) !=	\
-		     offsetof(struct iwl_wowlan_gtk_status_v3, _f));	\
-	BUILD_BUG_ON(offsetofend(struct iwl_wowlan_gtk_status_v2, _f) !=\
-		     offsetofend(struct iwl_wowlan_gtk_status_v3, _f));	\
-} while (0)
-
-	CHECK(key);
-	CHECK(key_len);
-	CHECK(key_flags);
-	CHECK(tkip_mic_key);
-#undef CHECK
-
-	iwl_mvm_convert_gtk_v2(status, (void *)data);
-}
-
-static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
-				 struct iwl_wowlan_igtk_status *data)
-{
-	const u8 *ipn = data->ipn;
-
-	BUILD_BUG_ON(sizeof(status->igtk.key) < sizeof(data->key));
-
-	status->igtk.len = data->key_len;
-	status->igtk.flags = data->key_flags;
-
-	memcpy(status->igtk.key, data->key, sizeof(data->key));
-
-	status->igtk.ipn = ((u64)ipn[5] <<  0) |
-			   ((u64)ipn[4] <<  8) |
-			   ((u64)ipn[3] << 16) |
-			   ((u64)ipn[2] << 24) |
-			   ((u64)ipn[1] << 32) |
-			   ((u64)ipn[0] << 40);
-}
-
 static struct iwl_wowlan_status_data *
 iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 {
-- 
2.35.3

