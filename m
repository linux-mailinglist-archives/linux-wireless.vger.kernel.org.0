Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E737C9278
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 05:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjJND1W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Oct 2023 23:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJND1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Oct 2023 23:27:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55113BF
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 20:27:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39E2V1Bu030991;
        Sat, 14 Oct 2023 03:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=bIgSrNAcFSQ5KTBkwyfl5cCjrSpUNyMeJ4btEoDQZFY=;
 b=h5Th45/aDnSJPBo6IzAHdxf9gOeErFyBRxSKHMpOPdPmxeSb2jGyq2dDqLuKkGDbEKp2
 ALSZ5ZF6xqh+mOlZhYffNFeZ3qtf2c0+BddJqFayIj39z50vYEbxagW3N5it6qLHvWcq
 mdvTCqcBNL8QXLynNVXczFzweideLEcLJgtleDtySOojclYHQeqX6eIL4SkMFbyE10oF
 mBGrMX89ZUxhmCfvp3LusKRqIGLVHpgXasCjfDk4igo38yGoErAs+3EBNLLsm5TvsMQf
 R/TpJ+gFltaBFh8BV+OT3g1NwAhemvy03e1PR8oA4kg2xDPIox5tIH7XRC+kwzipwbFL bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1k374w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 03:27:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39E3RCUA030516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 03:27:12 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 13 Oct 2023 20:27:11 -0700
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 1/2] wifi: ath11k: rename the wmi_sc naming convention to wmi_ab
Date:   Sat, 14 Oct 2023 08:56:49 +0530
Message-ID: <20231014032650.32605-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231014032650.32605-1-quic_periyasa@quicinc.com>
References: <20231014032650.32605-1-quic_periyasa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yXV64CgIQDvSspO7rh11QXbOkHH_NxQx
X-Proofpoint-GUID: yXV64CgIQDvSspO7rh11QXbOkHH_NxQx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310140029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In WMI layer module, the identifier wmi_sc is used to represent
an instance of ath11k_wmi_base structure. However, within ath11k,
the convention is to use "ab" to represent an SoC "base" struct.
So change the all instances of wmi_sc to wmi_ab.

Compile tested only.

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 26d416aa9c1f..8fd946437858 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -292,18 +292,18 @@ static int ath11k_wmi_cmd_send_nowait(struct ath11k_pdev_wmi *wmi, struct sk_buf
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id)
 {
-	struct ath11k_wmi_base *wmi_sc = wmi->wmi_ab;
+	struct ath11k_wmi_base *wmi_ab = wmi->wmi_ab;
 	int ret = -EOPNOTSUPP;
-	struct ath11k_base *ab = wmi_sc->ab;
+	struct ath11k_base *ab = wmi_ab->ab;
 
 	might_sleep();
 
 	if (ab->hw_params.credit_flow) {
-		wait_event_timeout(wmi_sc->tx_credits_wq, ({
+		wait_event_timeout(wmi_ab->tx_credits_wq, ({
 			ret = ath11k_wmi_cmd_send_nowait(wmi, skb, cmd_id);
 
 			if (ret && test_bit(ATH11K_FLAG_CRASH_FLUSH,
-					    &wmi_sc->ab->dev_flags))
+					    &wmi_ab->ab->dev_flags))
 				ret = -ESHUTDOWN;
 
 			(ret != -EAGAIN);
@@ -313,7 +313,7 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			ret = ath11k_wmi_cmd_send_nowait(wmi, skb, cmd_id);
 
 			if (ret && test_bit(ATH11K_FLAG_CRASH_FLUSH,
-					    &wmi_sc->ab->dev_flags))
+					    &wmi_ab->ab->dev_flags))
 				ret = -ESHUTDOWN;
 
 			(ret != -ENOBUFS);
@@ -321,10 +321,10 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 	}
 
 	if (ret == -EAGAIN)
-		ath11k_warn(wmi_sc->ab, "wmi command %d timeout\n", cmd_id);
+		ath11k_warn(wmi_ab->ab, "wmi command %d timeout\n", cmd_id);
 
 	if (ret == -ENOBUFS)
-		ath11k_warn(wmi_sc->ab, "ce desc not available for wmi command %d\n",
+		ath11k_warn(wmi_ab->ab, "ce desc not available for wmi command %d\n",
 			    cmd_id);
 
 	return ret;
@@ -611,10 +611,10 @@ static int ath11k_service_ready_event(struct ath11k_base *ab, struct sk_buff *sk
 	return 0;
 }
 
-struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len)
+struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_ab, u32 len)
 {
 	struct sk_buff *skb;
-	struct ath11k_base *ab = wmi_sc->ab;
+	struct ath11k_base *ab = wmi_ab->ab;
 	u32 round_len = roundup(len, 4);
 
 	skb = ath11k_htc_alloc_skb(ab, WMI_SKB_HEADROOM + round_len);
@@ -4291,7 +4291,7 @@ int ath11k_wmi_set_hw_mode(struct ath11k_base *ab,
 
 int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 {
-	struct ath11k_wmi_base *wmi_sc = &ab->wmi_ab;
+	struct ath11k_wmi_base *wmi_ab = &ab->wmi_ab;
 	struct wmi_init_cmd_param init_param;
 	struct target_resource_config  config;
 
@@ -4304,12 +4304,12 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 		     ab->wmi_ab.svc_map))
 		config.is_reg_cc_ext_event_supported = 1;
 
-	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
+	memcpy(&wmi_ab->wlan_resource_config, &config, sizeof(config));
 
-	init_param.res_cfg = &wmi_sc->wlan_resource_config;
-	init_param.num_mem_chunks = wmi_sc->num_mem_chunks;
-	init_param.hw_mode_id = wmi_sc->preferred_hw_mode;
-	init_param.mem_chunks = wmi_sc->mem_chunks;
+	init_param.res_cfg = &wmi_ab->wlan_resource_config;
+	init_param.num_mem_chunks = wmi_ab->num_mem_chunks;
+	init_param.hw_mode_id = wmi_ab->preferred_hw_mode;
+	init_param.mem_chunks = wmi_ab->mem_chunks;
 
 	if (ab->hw_params.single_pdev_only)
 		init_param.hw_mode_id = WMI_HOST_HW_MODE_MAX;
@@ -4317,7 +4317,7 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	init_param.num_band_to_mac = ab->num_radios;
 	ath11k_fill_band_to_mac_param(ab, init_param.band_to_mac);
 
-	return ath11k_init_cmd_send(&wmi_sc->wmi[0], &init_param);
+	return ath11k_init_cmd_send(&wmi_ab->wmi[0], &init_param);
 }
 
 int ath11k_wmi_vdev_spectral_conf(struct ath11k *ar,
-- 
2.17.1

