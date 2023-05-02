Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB06F45EF
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 16:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjEBOUh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 May 2023 10:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjEBOUg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 May 2023 10:20:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD7495
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 07:20:32 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342Cf1nc002956;
        Tue, 2 May 2023 14:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=igYnEbqouOca/khF5lBjPXOrEjknq3yuc6tNWZXMYpE=;
 b=TFN0IhFjRPdLiScPSIWksQyfCUVkWdFIdatf15/IUaHvr/w1FExptqzOvo1DmpHxSxM9
 aqHvbJac5lC8en+t/usqxTW0IUjGwF+7Sm7UXhIyVbJMCzV3OoLdu7bOI6UlKwJN3N5u
 vs4e2h6GsQUWJ7cyK+vHoJkaouQD3mH7JXcG7qtUnNuEk15X9TGNQCNNjMooUYrGJUfk
 b5C4nih5ROjsHaTOVICEjzbUYcAqTaJ1X9Yq2Mn298C6V2B2iG+6BJdMCZ0Yat6XmncK
 Eo1eckLDX+SESd+yf2LgceMEIutvIBoX1GT7De8BR2+QLJ2OV4nYmVRPAu8qhG+2m8/Z JA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qajdp28r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:20:26 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 342EKMTp007604;
        Tue, 2 May 2023 14:20:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3q8vakummn-1;
        Tue, 02 May 2023 14:20:22 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 342EKMHC007596;
        Tue, 2 May 2023 14:20:22 GMT
Received: from rgnanase-linux.qualcomm.com (rgnanase-linux.qualcomm.com [10.201.162.135])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 342EKM8u007595;
        Tue, 02 May 2023 14:20:22 +0000
Received: by rgnanase-linux.qualcomm.com (Postfix, from userid 2378837)
        id 7EEF41100068; Tue,  2 May 2023 19:50:21 +0530 (IST)
From:   Ramya Gnanasekar <quic_rgnanase@quicinc.com>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        P Praneesh <quic_ppranees@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Subject: [PATCH] wifi: ath12k: Add support to parse new WMI event for 6 GHz regulatory
Date:   Tue,  2 May 2023 19:50:18 +0530
Message-Id: <20230502142018.20301-1-quic_rgnanase@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iuGAyZ4t90fimvLkRQHwh02nTgtlHbbR
X-Proofpoint-ORIG-GUID: iuGAyZ4t90fimvLkRQHwh02nTgtlHbbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020121
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <quic_ppranees@quicinc.com>

In order to support different power levels of 6 GHz AP and client,
new WMI event for regulatory (WMI_REG_CHAN_LIST_CC_EXT_EVENTID) has been
added in firmware to provide new parameters required for 6 GHz regulatory rules.

Firmware advertises its capability of handling new event in WMI service ready
event. Based on that, host needs to set host_service_flags in WMI init command
to indicate that host supports processing of this WMI event.
Based on advertised host capability, firmware sends event (WMI_REG_CHAN_LIST_CC_EXT_EVENTID).
This new event contains 2G/5G/6G reg rules with additional power value
fields for 6GHz and regd is built accordingly.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 95 +++++++++++++++++----------
 drivers/net/wireless/ath/ath12k/wmi.h |  8 ++-
 2 files changed, 68 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 03fbe078ebe7..d972df7f21a5 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3194,8 +3194,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
 	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
 	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
 	wmi_cfg->twt_ap_sta_count = cpu_to_le32(tg_cfg->twt_ap_sta_count);
-	wmi_cfg->host_service_flags =
-		cpu_to_le32(1 << WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT);
+	wmi_cfg->host_service_flags = cpu_to_le32(tg_cfg->is_reg_cc_ext_event_supported <<
+				WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT);
 }
 
 static int ath12k_init_cmd_send(struct ath12k_wmi_pdev *wmi,
@@ -3403,6 +3403,10 @@ int ath12k_wmi_cmd_init(struct ath12k_base *ab)
 	struct ath12k_wmi_base *wmi_sc = &ab->wmi_ab;
 	struct ath12k_wmi_init_cmd_arg arg = {};
 
+	if (test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
+		     ab->wmi_ab.svc_map))
+		arg.res_cfg.is_reg_cc_ext_event_supported = 1;
+
 	ab->hw_params->wmi_init(ab, &arg.res_cfg);
 
 	arg.num_mem_chunks = wmi_sc->num_mem_chunks;
@@ -6011,47 +6015,72 @@ static void ath12k_vdev_install_key_compl_event(struct ath12k_base *ab,
 	rcu_read_unlock();
 }
 
-static void ath12k_service_available_event(struct ath12k_base *ab, struct sk_buff *skb)
+static int ath12k_wmi_tlv_services_parser(struct ath12k_base *ab,
+					  u16 tag, u16 len,
+					  const void *ptr,
+					  void *data)
 {
-	const void **tb;
 	const struct wmi_service_available_event *ev;
-	int ret;
+	u32 *wmi_ext2_service_bitmap;
 	int i, j;
+	u16 expected_len;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
-	if (IS_ERR(tb)) {
-		ret = PTR_ERR(tb);
-		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
-		return;
+	expected_len = WMI_SERVICE_SEGMENT_BM_SIZE32 * sizeof(u32);
+	if (len < expected_len) {
+		ath12k_warn(ab, "invalid len %d for the tag 0x%x\n",
+			    len, tag);
+		return -EINVAL;
 	}
 
-	ev = tb[WMI_TAG_SERVICE_AVAILABLE_EVENT];
-	if (!ev) {
-		ath12k_warn(ab, "failed to fetch svc available ev");
-		kfree(tb);
-		return;
-	}
+	switch (tag) {
+	case WMI_TAG_SERVICE_AVAILABLE_EVENT:
+		ev = (struct wmi_service_available_event *)ptr;
+		for (i = 0, j = WMI_MAX_SERVICE;
+		     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT_SERVICE;
+		     i++) {
+			do {
+				if (le32_to_cpu(ev->wmi_service_segment_bitmap[i]) &
+				    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
+					set_bit(j, ab->wmi_ab.svc_map);
+			} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
+		}
 
-	/* TODO: Use wmi_service_segment_offset information to get the service
-	 * especially when more services are advertised in multiple service
-	 * available events.
-	 */
-	for (i = 0, j = WMI_MAX_SERVICE;
-	     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT_SERVICE;
-	     i++) {
-		do {
-			if (le32_to_cpu(ev->wmi_service_segment_bitmap[i]) &
-			    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
-				set_bit(j, ab->wmi_ab.svc_map);
-		} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "wmi_ext_service_bitmap 0:0x%x, 1:0x%x, 2:0x%x, 3:0x%x",
+			   ev->wmi_service_segment_bitmap[0],
+			   ev->wmi_service_segment_bitmap[1],
+			   ev->wmi_service_segment_bitmap[2],
+			   ev->wmi_service_segment_bitmap[3]);
+		break;
+	case WMI_TAG_ARRAY_UINT32:
+		wmi_ext2_service_bitmap = (u32 *)ptr;
+		for (i = 0, j = WMI_MAX_EXT_SERVICE;
+		     i < WMI_SERVICE_SEGMENT_BM_SIZE32 && j < WMI_MAX_EXT2_SERVICE;
+		     i++) {
+			do {
+				if (wmi_ext2_service_bitmap[i] &
+				    BIT(j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32))
+					set_bit(j, ab->wmi_ab.svc_map);
+			} while (++j % WMI_AVAIL_SERVICE_BITS_IN_SIZE32);
+		}
+
+		ath12k_dbg(ab, ATH12K_DBG_WMI,
+			   "wmi_ext2_service_bitmap  0:0x%04x, 1:0x%04x, 2:0x%04x, 3:0x%04x",
+			   wmi_ext2_service_bitmap[0], wmi_ext2_service_bitmap[1],
+			   wmi_ext2_service_bitmap[2], wmi_ext2_service_bitmap[3]);
+		break;
 	}
+	return 0;
+}
 
-	ath12k_dbg(ab, ATH12K_DBG_WMI,
-		   "wmi_ext_service_bitmap 0:0x%x, 1:0x%x, 2:0x%x, 3:0x%x",
-		   ev->wmi_service_segment_bitmap[0], ev->wmi_service_segment_bitmap[1],
-		   ev->wmi_service_segment_bitmap[2], ev->wmi_service_segment_bitmap[3]);
+static int ath12k_service_available_event(struct ath12k_base *ab, struct sk_buff *skb)
+{
+	int ret;
 
-	kfree(tb);
+	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath12k_wmi_tlv_services_parser,
+				  NULL);
+	return ret;
 }
 
 static void ath12k_peer_assoc_conf_event(struct ath12k_base *ab, struct sk_buff *skb)
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index a8b972493fbb..43a7eef3f3f9 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2148,7 +2148,10 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 
-	WMI_MAX_EXT_SERVICE
+	WMI_MAX_EXT_SERVICE = 256,
+
+	WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT = 281,
+	WMI_MAX_EXT2_SERVICE,
 };
 
 enum {
@@ -2333,6 +2336,7 @@ struct ath12k_wmi_resource_config_arg {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	bool is_reg_cc_ext_event_supported;
 };
 
 struct ath12k_wmi_init_cmd_arg {
@@ -4665,7 +4669,7 @@ struct ath12k_wmi_base {
 
 	struct completion service_ready;
 	struct completion unified_ready;
-	DECLARE_BITMAP(svc_map, WMI_MAX_EXT_SERVICE);
+	DECLARE_BITMAP(svc_map, WMI_MAX_EXT2_SERVICE);
 	wait_queue_head_t tx_credits_wq;
 	const struct wmi_peer_flags_map *peer_flags;
 	u32 num_mem_chunks;
-- 
2.17.1

