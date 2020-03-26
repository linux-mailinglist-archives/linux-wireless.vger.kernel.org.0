Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE321941E4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 15:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgCZOsV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 10:48:21 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19355 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgCZOsV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 10:48:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585234100; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=iizag96MxErTyaViQP0FeIPhgRagQU+ZzbuTZdLn3xA=; b=wsOLBaiO6f/hXNJ7MNCw37KWvbDwQd0es7EmP60HRDiHfbwjq3600KtCrVb+1vKDrWCrigr8
 PLvR4MuId97fliK3FLvKpVK9dR4akp6/gx0LL3fcJATecxIvfYcYU0hjUhLAljWJFxzAJj9w
 h5XQYrpzlCaivUW8Y4iAR2Qi6y0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7cc0ac.7fa598d66570-smtp-out-n02;
 Thu, 26 Mar 2020 14:48:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11251C433D2; Thu, 26 Mar 2020 14:48:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from che-swdbs-01.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 050E6C433F2;
        Thu, 26 Mar 2020 14:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 050E6C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH] ath11k: add pktlog checksum in trace events to support pktlog
Date:   Thu, 26 Mar 2020 20:19:15 +0530
Message-Id: <1585234155-30574-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pktlog data are different among the chipset & chipset versions.
As part of enhancing the user space script to decode the pktlog
trace events generated, it is desirable to know which chipset or
which chipset version has provided the events and thereby decode
the pktlogs appropriately.

Pktlog checksum helps to determine the chipset variant which is
given by the firmware in the struct wmi_ready_event.

Pktlog checksums are computed during the firmware build.
So, adding that pktlog checksum in the pklog trace events.

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h  |  1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c |  3 ++-
 drivers/net/wireless/ath/ath11k/trace.h | 12 ++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c   | 21 +++++++++++++--------
 drivers/net/wireless/ath/ath11k/wmi.h   |  8 +++++++-
 5 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 6e7b8ec..a1e29f3 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -650,6 +650,7 @@ struct ath11k_base {
 		/* protected by data_lock */
 		u32 fw_crash_counter;
 	} stats;
+	u32 pktlog_defs_checksum;
 };
 
 struct ath11k_fw_stats_pdev {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index f74a0e7..a3f2c76 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1491,7 +1491,8 @@ static void ath11k_htt_pktlog(struct ath11k_base *ab, struct sk_buff *skb)
 		return;
 	}
 
-	trace_ath11k_htt_pktlog(ar, data->payload, hdr->size);
+	trace_ath11k_htt_pktlog(ar, data->payload, hdr->size,
+				ar->ab->pktlog_defs_checksum);
 }
 
 static void ath11k_htt_backpressure_event_handler(struct ath11k_base *ab,
diff --git a/drivers/net/wireless/ath/ath11k/trace.h b/drivers/net/wireless/ath/ath11k/trace.h
index 8700a62..66d0aae 100644
--- a/drivers/net/wireless/ath/ath11k/trace.h
+++ b/drivers/net/wireless/ath/ath11k/trace.h
@@ -21,14 +21,16 @@
 #define TRACE_SYSTEM ath11k
 
 TRACE_EVENT(ath11k_htt_pktlog,
-	    TP_PROTO(struct ath11k *ar, const void *buf, u16 buf_len),
+	    TP_PROTO(struct ath11k *ar, const void *buf, u16 buf_len,
+		     u32 pktlog_checksum),
 
-	TP_ARGS(ar, buf, buf_len),
+	TP_ARGS(ar, buf, buf_len, pktlog_checksum),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(ar->ab->dev))
 		__string(driver, dev_driver_string(ar->ab->dev))
 		__field(u16, buf_len)
+		__field(u32, pktlog_checksum)
 		__dynamic_array(u8, pktlog, buf_len)
 	),
 
@@ -36,14 +38,16 @@
 		__assign_str(device, dev_name(ar->ab->dev));
 		__assign_str(driver, dev_driver_string(ar->ab->dev));
 		__entry->buf_len = buf_len;
+		__entry->pktlog_checksum = pktlog_checksum;
 		memcpy(__get_dynamic_array(pktlog), buf, buf_len);
 	),
 
 	TP_printk(
-		"%s %s size %hu",
+		"%s %s size %hu pktlog_checksum %d",
 		__get_str(driver),
 		__get_str(device),
-		__entry->buf_len
+		__entry->buf_len,
+		__entry->pktlog_checksum
 	 )
 );
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index e7ce369..ad88efe 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -87,8 +87,8 @@ struct wmi_tlv_rdy_parse {
 		= { .min_len = sizeof(struct wmi_pdev_bss_chan_info_event) },
 	[WMI_TAG_VDEV_INSTALL_KEY_COMPLETE_EVENT]
 		= { .min_len = sizeof(struct wmi_vdev_install_key_compl_event) },
-	[WMI_TAG_READY_EVENT]
-		= {.min_len = sizeof(struct wmi_ready_event) },
+	[WMI_TAG_READY_EVENT] = {
+		.min_len = sizeof(struct wmi_ready_event_min) },
 	[WMI_TAG_SERVICE_AVAILABLE_EVENT]
 		= {.min_len = sizeof(struct wmi_service_available_event) },
 	[WMI_TAG_PEER_ASSOC_CONF_EVENT]
@@ -4851,7 +4851,7 @@ static int ath11k_wmi_tlv_rdy_parse(struct ath11k_base *ab, u16 tag, u16 len,
 				    const void *ptr, void *data)
 {
 	struct wmi_tlv_rdy_parse *rdy_parse = data;
-	struct wmi_ready_event *fixed_param;
+	struct wmi_ready_event fixed_param;
 	struct wmi_mac_addr *addr_list;
 	struct ath11k_pdev *pdev;
 	u32 num_mac_addr;
@@ -4859,11 +4859,16 @@ static int ath11k_wmi_tlv_rdy_parse(struct ath11k_base *ab, u16 tag, u16 len,
 
 	switch (tag) {
 	case WMI_TAG_READY_EVENT:
-		fixed_param = (struct wmi_ready_event *)ptr;
-		ab->wlan_init_status = fixed_param->status;
-		rdy_parse->num_extra_mac_addr = fixed_param->num_extra_mac_addr;
-
-		ether_addr_copy(ab->mac_addr, fixed_param->mac_addr.addr);
+		memset(&fixed_param, 0, sizeof(fixed_param));
+		memcpy(&fixed_param, (struct wmi_ready_event *)ptr,
+		       min_t(u16, sizeof(fixed_param), len));
+		ab->wlan_init_status = fixed_param.ready_event_min.status;
+		rdy_parse->num_extra_mac_addr =
+			fixed_param.ready_event_min.num_extra_mac_addr;
+
+		ether_addr_copy(ab->mac_addr,
+				fixed_param.ready_event_min.mac_addr.addr);
+		ab->pktlog_defs_checksum = fixed_param.pktlog_defs_checksum;
 		ab->wmi_ready = true;
 		break;
 	case WMI_TAG_ARRAY_FIXED_STRUCT:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 510f9c6..58f9098 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2345,7 +2345,7 @@ struct wmi_mac_addr {
 	} __packed;
 } __packed;
 
-struct wmi_ready_event {
+struct wmi_ready_event_min {
 	struct wmi_abi_version fw_abi_vers;
 	struct wmi_mac_addr mac_addr;
 	u32 status;
@@ -2355,6 +2355,12 @@ struct wmi_ready_event {
 	u32 num_extra_peers;
 } __packed;
 
+struct wmi_ready_event {
+	struct wmi_ready_event_min ready_event_min;
+	u32 max_ast_index;
+	u32 pktlog_defs_checksum;
+} __packed;
+
 struct wmi_service_available_event {
 	u32 wmi_service_segment_offset;
 	u32 wmi_service_segment_bitmap[WMI_SERVICE_SEGMENT_BM_SIZE32];
-- 
1.9.1
