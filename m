Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9761D5AEB9F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiIFOK6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241188AbiIFOJA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:09:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF585FEF
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471983; x=1694007983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rzUuYUq9kN2DENwdg3HU7YC/J3bpJPa14+nt1QjC20I=;
  b=lsWHVsfXrahvQRaMlJfDpDfWXTueqLsGup7vAgsnwlITCHimJd+buHRY
   PlGhQoII17LARIfkbrao+dm3qFN0rEvnSs09BZT1pNCKTR86wew1ha+hu
   XQxp3IpOzBmxgjqLizRyhFsLet9Dm7hrFAeBJcwFW0F1NEoMu7VkMkCIU
   PNlrjNxwqc7TLkmyXAQnTAs4HRzPKLSTVi8vjFexaCPY1H9fY8JBtYJTW
   0JvN7Whh+zqTLw0pMw91pfrKQB4PUhwr95PasaW/tTHPqm72Y4Rf+HHab
   kmvuvn/kC/UTqz1FbmL3HxjTBzLkYBqroY6FPDN77xaqk/UDxLV3xsM4D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276989026"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276989026"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459895"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:44:45 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: mvm: Add support for wowlan wake packet notification
Date:   Tue,  6 Sep 2022 16:42:13 +0300
Message-Id: <20220906161827.06d1e6aecf10.Ib3d6a46ffe71d10cbc69bdb5654e6b14c28df245@changeid>
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

The wowlan info notification is quite big.
(~750 bytes without the wake packet itself).
The max FW notification size is ~2K.
There might be cases where the wake packet gets truncated because of
this limit.

Separating the wake packet from the wowlan info notification allows us to
get more data without trimming it.

Note: we currently limit the wake packet to 1600 bytes.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  14 ++
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   5 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 126 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 4 files changed, 118 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 7b2501fe50e6..5588f6d65813 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -803,6 +803,20 @@ struct iwl_wowlan_info_notif {
 	u8 reserved2[2];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_wowlan_wake_pkt_notif - WoWLAN wake packet notification
+ * @wake_packet_length: wakeup packet length
+ * @station_id: station id
+ * @reserved: unused
+ * @wake_packet: wakeup packet
+ */
+struct iwl_wowlan_wake_pkt_notif {
+	__le32 wake_packet_length;
+	u8 station_id;
+	u8 reserved[3];
+	u8 wake_packet[1];
+} __packed; /* WOWLAN_WAKE_PKT_NTFY_API_S_VER_1 */
+
 /* TODO: NetDetect API */
 
 #endif /* __iwl_fw_api_d3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index ae2263e2e293..1a1b7ac78309 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -12,6 +12,11 @@
  * enum iwl_prot_offload_subcmd_ids - protocol offload commands
  */
 enum iwl_prot_offload_subcmd_ids {
+	/**
+	 * @WOWLAN_WAKE_PKT_NOTIFICATION: Notification in &struct iwl_wowlan_wake_pkt_notif
+	 */
+	WOWLAN_WAKE_PKT_NOTIFICATION = 0xFC,
+
 	/**
 	 * @WOWLAN_INFO_NOTIFICATION: Notification in &struct iwl_wowlan_info_notif
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index f522cc105b53..77e70899c46e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1427,7 +1427,7 @@ struct iwl_wowlan_status_data {
 		u8 flags;
 	} igtk;
 
-	u8 wake_packet[];
+	u8 *wake_packet;
 };
 
 static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
@@ -1480,7 +1480,7 @@ static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
 	if (reasons & IWL_WOWLAN_WAKEUP_BY_REM_WAKE_WAKEUP_PACKET)
 		wakeup.tcp_match = true;
 
-	if (status->wake_packet_bufsize) {
+	if (status->wake_packet) {
 		int pktsize = status->wake_packet_bufsize;
 		int pktlen = status->wake_packet_length;
 		const u8 *pktdata = status->wake_packet;
@@ -1965,7 +1965,7 @@ iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
 		return NULL;						\
 	}								\
 									\
-	status = kzalloc(sizeof(*status) + data_size, GFP_KERNEL);	\
+	status = kzalloc(sizeof(*status), GFP_KERNEL);			\
 	if (!status)							\
 		return NULL;						\
 									\
@@ -1984,8 +1984,18 @@ iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
 		le32_to_cpu(data->wake_packet_length);			\
 	status->wake_packet_bufsize =					\
 		le32_to_cpu(data->wake_packet_bufsize);			\
-	memcpy(status->wake_packet, data->wake_packet,			\
-	       status->wake_packet_bufsize);				\
+	if (status->wake_packet_bufsize) {				\
+		status->wake_packet =					\
+			kmemdup(data->wake_packet,			\
+				status->wake_packet_bufsize,		\
+				GFP_KERNEL);				\
+		if (!status->wake_packet) {				\
+			kfree(status);					\
+			return NULL;					\
+		}							\
+	} else {							\
+		status->wake_packet = NULL;				\
+	}								\
 									\
 	return status;							\
 }
@@ -2197,25 +2207,6 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 	return status;
 }
 
-static struct iwl_wowlan_status_data *
-iwl_mvm_get_wakeup_status(struct iwl_mvm *mvm, u8 sta_id)
-{
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, OFFLOADS_QUERY_CMD,
-					   IWL_FW_CMD_VER_UNKNOWN);
-	__le32 station_id = cpu_to_le32(sta_id);
-	u32 cmd_size = cmd_ver != IWL_FW_CMD_VER_UNKNOWN ? sizeof(station_id) : 0;
-
-	if (!mvm->net_detect) {
-		/* only for tracing for now */
-		int ret = iwl_mvm_send_cmd_pdu(mvm, OFFLOADS_QUERY_CMD, 0,
-					       cmd_size, &station_id);
-		if (ret)
-			IWL_ERR(mvm, "failed to query offload statistics (%d)\n", ret);
-	}
-
-	return iwl_mvm_send_wowlan_get_status(mvm, sta_id);
-}
-
 /* releases the MVM mutex */
 static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
@@ -2525,9 +2516,11 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 /**
  * enum iwl_d3_notif - d3 notifications
  * @IWL_D3_NOTIF_WOWLAN_INFO: WOWLAN_INFO_NOTIF was received
+ * @IWL_D3_NOTIF_WOWLAN_WAKE_PKT: WOWLAN_WAKE_PKT_NOTIF was received
  */
 enum iwl_d3_notif {
 	IWL_D3_NOTIF_WOWLAN_INFO =	BIT(0),
+	IWL_D3_NOTIF_WOWLAN_WAKE_PKT =	BIT(1),
 };
 
 /* manage d3 resume data */
@@ -2553,10 +2546,9 @@ static void iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 	/* if FW uses status notification, status shouldn't be NULL here */
 	if (!d3_data->status) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		u8 sta_id = mvm->net_detect ? IWL_MVM_INVALID_STA : mvmvif->ap_sta_id;
 
-		d3_data->status = iwl_mvm_get_wakeup_status(mvm, mvm->net_detect ?
-							    IWL_MVM_INVALID_STA :
-							    mvmvif->ap_sta_id);
+		d3_data->status = iwl_mvm_send_wowlan_get_status(mvm, sta_id);
 	}
 
 	if (mvm->net_detect) {
@@ -2578,6 +2570,55 @@ static void iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 	}
 }
 
+#define IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT (IWL_WOWLAN_WAKEUP_BY_MAGIC_PACKET | \
+						 IWL_WOWLAN_WAKEUP_BY_PATTERN | \
+						 IWL_WAKEUP_BY_PATTERN_IPV4_TCP_SYN |\
+						 IWL_WAKEUP_BY_PATTERN_IPV4_TCP_SYN_WILDCARD |\
+						 IWL_WAKEUP_BY_PATTERN_IPV6_TCP_SYN |\
+						 IWL_WAKEUP_BY_PATTERN_IPV6_TCP_SYN_WILDCARD)
+
+static int iwl_mvm_wowlan_store_wake_pkt(struct iwl_mvm *mvm,
+					 struct iwl_wowlan_wake_pkt_notif *notif,
+					 struct iwl_wowlan_status_data *status,
+					 u32 len)
+{
+	u32 data_size, packet_len = le32_to_cpu(notif->wake_packet_length);
+
+	if (len < sizeof(*notif)) {
+		IWL_ERR(mvm, "Invalid WoWLAN wake packet notification!\n");
+		return -EIO;
+	}
+
+	if (WARN_ON(!status)) {
+		IWL_ERR(mvm, "Got wake packet notification but wowlan status data is NULL\n");
+		return -EIO;
+	}
+
+	if (WARN_ON(!(status->wakeup_reasons &
+		      IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT))) {
+		IWL_ERR(mvm, "Got wakeup packet but wakeup reason is %x\n",
+			status->wakeup_reasons);
+		return -EIO;
+	}
+
+	data_size = len - offsetof(struct iwl_wowlan_wake_pkt_notif, wake_packet);
+
+	/* data_size got the padding from the notification, remove it. */
+	if (packet_len < data_size)
+		data_size = packet_len;
+
+	status->wake_packet = kmemdup(notif->wake_packet, data_size,
+				      GFP_ATOMIC);
+
+	if (!status->wake_packet)
+		return -ENOMEM;
+
+	status->wake_packet_length = packet_len;
+	status->wake_packet_bufsize = data_size;
+
+	return 0;
+}
+
 static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 				  struct iwl_rx_packet *pkt, void *data)
 {
@@ -2585,6 +2626,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 		container_of(notif_wait, struct iwl_mvm, notif_wait);
 	struct iwl_d3_data *d3_data = data;
 	u32 len;
+	int ret;
 
 	switch (WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd)) {
 	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION): {
@@ -2601,6 +2643,31 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 		len = iwl_rx_packet_payload_len(pkt);
 		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
 						len);
+		if (d3_data->status &&
+		    d3_data->status->wakeup_reasons & IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT)
+			/* We are supposed to get also wake packet notif */
+			d3_data->notif_expected |= IWL_D3_NOTIF_WOWLAN_WAKE_PKT;
+
+		break;
+	}
+	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_WAKE_PKT_NOTIFICATION): {
+		struct iwl_wowlan_wake_pkt_notif *notif = (void *)pkt->data;
+
+		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_WAKE_PKT) {
+			/* We shouldn't get two wake packet notifications */
+			IWL_ERR(mvm,
+				"Got additional wowlan wake packet notification\n");
+		} else {
+			d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_WAKE_PKT;
+			len =  iwl_rx_packet_payload_len(pkt);
+			ret = iwl_mvm_wowlan_store_wake_pkt(mvm, notif,
+							    d3_data->status,
+							    len);
+			if (ret)
+				IWL_ERR(mvm,
+					"Can't parse WOWLAN_WAKE_PKT_NOTIFICATION\n");
+		}
+
 		break;
 	}
 	default:
@@ -2618,7 +2685,8 @@ static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 				 bool test)
 {
 	static const u16 d3_resume_notif[] = {
-		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION)
+		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION),
+		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_WAKE_PKT_NOTIFICATION)
 	};
 	struct iwl_notification_wait wait_d3_notif;
 	int ret;
@@ -2751,6 +2819,8 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 err:
 	mutex_unlock(&mvm->mutex);
 out:
+	if (d3_data.status)
+		kfree(d3_data.status->wake_packet);
 	kfree(d3_data.status);
 	iwl_mvm_free_nd(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e380ee841773..9c8adb0c2acf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -574,6 +574,7 @@ static const struct iwl_hcmd_names iwl_mvm_location_names[] = {
  * Access is done through binary search
  */
 static const struct iwl_hcmd_names iwl_mvm_prot_offload_names[] = {
+	HCMD_NAME(WOWLAN_WAKE_PKT_NOTIFICATION),
 	HCMD_NAME(WOWLAN_INFO_NOTIFICATION),
 	HCMD_NAME(STORED_BEACON_NTF),
 };
-- 
2.35.3

