Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015797F4165
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 10:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjKVJQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 04:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjKVJQ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 04:16:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D8410C7
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 01:16:25 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5Vjaa013173;
        Wed, 22 Nov 2023 09:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gtJAohTC/AOsgBPrKHXMkxPxh0IhchJcpl2WYjn+JE4=;
 b=bG07aNegDM2lgIstI62kYpuDPCM763lOfqNlxh45qyKhGI642f1M5izcI8YMVsOI1qEw
 kIF+nHRgVYD1GqWD6izoUcGdRXHSn/lmuvkh+Og58ezZoruG2kxBv2CeTm7qHLdP6g2R
 2qVC08hTOCVxb7nFgw0+m+zdonlAvOjUqwGCPZfWEkc3Ud2DYj4pVVirNdyySfUuhOw7
 BE4+sIag4D+2QtQogQnE/3KfeyUk5BSUdIoAq/yOPLbyKJNzT9Xz2F41DLO8AREscH9Y
 YFVI3J1nwv8mePF9mnDIgUJixmD8I0JSPRLllwsl3KzONG0s/HefESyBM0ys69qHt8rr VQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhbjvgnv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:16:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM9GK1H001550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 09:16:21 GMT
Received: from bqiang-Celadon-RN.lan (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 01:16:19 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v7 08/12] wifi: ath11k: save max tx power in vdev start response event from firmware
Date:   Wed, 22 Nov 2023 17:15:49 +0800
Message-ID: <20231122091553.10837-9-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122091553.10837-1-quic_bqiang@quicinc.com>
References: <20231122091553.10837-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3zRps-bNigmKkvo7nIqmd29Y6bnAGHTU
X-Proofpoint-ORIG-GUID: 3zRps-bNigmKkvo7nIqmd29Y6bnAGHTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

Save the max tx power received in the vdev start response event from
firmware. A subsequent patch will use this to calculate the final power
value for WMI_VDEV_SET_TPC_POWER_CMDID.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v7:
 no change.

 drivers/net/wireless/ath/ath11k/core.h | 1 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 3 ++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index c5640be76514..d4a6763cb708 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -778,6 +778,7 @@ struct ath11k {
 	/* protected by conf_mutex */
 	bool ps_state_enable;
 	bool ps_timekeeper_enable;
+	s8 max_allowed_tx_power;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8083313b00ca..7e2007ea2352 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5033,6 +5033,7 @@ static int ath11k_pull_vdev_start_resp_tlv(struct ath11k_base *ab, struct sk_buf
 	vdev_rsp->mac_id = ev->mac_id;
 	vdev_rsp->cfgd_tx_streams = ev->cfgd_tx_streams;
 	vdev_rsp->cfgd_rx_streams = ev->cfgd_rx_streams;
+	vdev_rsp->max_allowed_tx_power = ev->max_allowed_tx_power;
 
 	kfree(tb);
 	return 0;
@@ -7427,7 +7428,7 @@ static void ath11k_vdev_start_resp_event(struct ath11k_base *ab, struct sk_buff
 	}
 
 	ar->last_wmi_vdev_start_status = 0;
-
+	ar->max_allowed_tx_power = vdev_start_resp.max_allowed_tx_power;
 	status = vdev_start_resp.status;
 
 	if (WARN_ON_ONCE(status)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index f77f309771a8..cad6b69be592 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4143,6 +4143,7 @@ struct wmi_vdev_start_resp_event {
 	};
 	u32 cfgd_tx_streams;
 	u32 cfgd_rx_streams;
+	s32 max_allowed_tx_power;
 } __packed;
 
 /* VDEV start response status codes */
-- 
2.25.1

