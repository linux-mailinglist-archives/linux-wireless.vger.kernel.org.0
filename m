Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB07CE137
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbjJRPao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 11:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJRPal (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 11:30:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FA311C
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 08:30:35 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IFHqaB022864;
        Wed, 18 Oct 2023 15:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PdkBpgHv/StHKwk69IznraunylZIj4pmKn8tbyFuCyM=;
 b=S/EomKBzxt3EpPxUI7crtAK3oj6TAkjeCPJlyjL5dZ58CFYiekuo6Xz3BlVhXKLYCiFW
 zOi09pJDu0c6yCJ1Gs5lwe59Cz/TBoU3+w+9sjN0ymKfCSGmsc+mxpZJtmpMRSfTFK1f
 SOuKbl7oZG3Zqm2dlUWiWre7jqg9dtg4+Z++0A40V8sS/9JnKoTBdQkr4SCi2tARIlgJ
 EnFOIgpiw56H2w/xe8zovdiPhVn+K3OISbIOkX286xiH5QOfmH2aXS5Jh6YWs2bvrM9D
 nAAPrwWR6kx0GtreXAa1Ev3jZ8irlyhkJm39ITy2BoSziuTP+haigcyTccFe3DMvLDWc 0g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttg82raam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 15:30:27 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IFUQf7015316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 15:30:26 GMT
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 08:30:24 -0700
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: rename the wmi_sc naming convention to wmi_ab
Date:   Wed, 18 Oct 2023 21:00:07 +0530
Message-ID: <20231018153008.29820-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231018153008.29820-1-quic_periyasa@quicinc.com>
References: <20231018153008.29820-1-quic_periyasa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dquRiKcOqU_CpOXIwHwG1GjF7Iyk4gF2
X-Proofpoint-ORIG-GUID: dquRiKcOqU_CpOXIwHwG1GjF7Iyk4gF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_13,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=950 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In WMI layer module, the identifier wmi_sc is used to represent
an instance of ath12k_wmi_base structure. However, within ath12k,
the convention is to use "ab" to represent an SoC "base" struct.
So change the all instances of wmi_sc to wmi_ab.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 1cac0135a1bc..0d46e97ffe56 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -408,22 +408,22 @@ static int ath12k_wmi_cmd_send_nowait(struct ath12k_wmi_pdev *wmi, struct sk_buf
 int ath12k_wmi_cmd_send(struct ath12k_wmi_pdev *wmi, struct sk_buff *skb,
 			u32 cmd_id)
 {
-	struct ath12k_wmi_base *wmi_sc = wmi->wmi_ab;
+	struct ath12k_wmi_base *wmi_ab = wmi->wmi_ab;
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
 
-	wait_event_timeout(wmi_sc->tx_credits_wq, ({
+	wait_event_timeout(wmi_ab->tx_credits_wq, ({
 		ret = ath12k_wmi_cmd_send_nowait(wmi, skb, cmd_id);
 
-		if (ret && test_bit(ATH12K_FLAG_CRASH_FLUSH, &wmi_sc->ab->dev_flags))
+		if (ret && test_bit(ATH12K_FLAG_CRASH_FLUSH, &wmi_ab->ab->dev_flags))
 			ret = -ESHUTDOWN;
 
 		(ret != -EAGAIN);
 	}), WMI_SEND_TIMEOUT_HZ);
 
 	if (ret == -EAGAIN)
-		ath12k_warn(wmi_sc->ab, "wmi command %d timeout\n", cmd_id);
+		ath12k_warn(wmi_ab->ab, "wmi command %d timeout\n", cmd_id);
 
 	return ret;
 }
@@ -727,10 +727,10 @@ static int ath12k_service_ready_event(struct ath12k_base *ab, struct sk_buff *sk
 	return 0;
 }
 
-struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_sc, u32 len)
+struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_ab, u32 len)
 {
 	struct sk_buff *skb;
-	struct ath12k_base *ab = wmi_sc->ab;
+	struct ath12k_base *ab = wmi_ab->ab;
 	u32 round_len = roundup(len, 4);
 
 	skb = ath12k_htc_alloc_skb(ab, WMI_SKB_HEADROOM + round_len);
@@ -3471,7 +3471,7 @@ int ath12k_wmi_set_hw_mode(struct ath12k_base *ab,
 
 int ath12k_wmi_cmd_init(struct ath12k_base *ab)
 {
-	struct ath12k_wmi_base *wmi_sc = &ab->wmi_ab;
+	struct ath12k_wmi_base *wmi_ab = &ab->wmi_ab;
 	struct ath12k_wmi_init_cmd_arg arg = {};
 
 	if (test_bit(WMI_TLV_SERVICE_REG_CC_EXT_EVENT_SUPPORT,
@@ -3480,9 +3480,9 @@ int ath12k_wmi_cmd_init(struct ath12k_base *ab)
 
 	ab->hw_params->wmi_init(ab, &arg.res_cfg);
 
-	arg.num_mem_chunks = wmi_sc->num_mem_chunks;
-	arg.hw_mode_id = wmi_sc->preferred_hw_mode;
-	arg.mem_chunks = wmi_sc->mem_chunks;
+	arg.num_mem_chunks = wmi_ab->num_mem_chunks;
+	arg.hw_mode_id = wmi_ab->preferred_hw_mode;
+	arg.mem_chunks = wmi_ab->mem_chunks;
 
 	if (ab->hw_params->single_pdev_only)
 		arg.hw_mode_id = WMI_HOST_HW_MODE_MAX;
@@ -3490,7 +3490,7 @@ int ath12k_wmi_cmd_init(struct ath12k_base *ab)
 	arg.num_band_to_mac = ab->num_radios;
 	ath12k_fill_band_to_mac_param(ab, arg.band_to_mac);
 
-	return ath12k_init_cmd_send(&wmi_sc->wmi[0], &arg);
+	return ath12k_init_cmd_send(&wmi_ab->wmi[0], &arg);
 }
 
 int ath12k_wmi_vdev_spectral_conf(struct ath12k *ar,
-- 
2.17.1

