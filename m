Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F298E628A57
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Nov 2022 21:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiKNUTe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Nov 2022 15:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiKNUT3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A3BA19C
        for <linux-wireless@vger.kernel.org>; Mon, 14 Nov 2022 12:19:27 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEHRa20009177;
        Mon, 14 Nov 2022 20:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/kRhCDWwCDUaaUJAJfA5v/a3xiwXglWpMm1AjM1NJ38=;
 b=ZsSTncSqG/Pq1OrdLtdh992G7QR9qizqKJTspflbb//rktDpT4LVEtqNIkp4CChU23EA
 GfF5EbXOjMElcNAkzCIEVnqldAPnpNbjpxtUBxe67OO5vJGxpwz3onsPTXcRA3Ir0gIi
 p7vv5BjQwAeHhzJOO/ZZ8pa/psdg821bqipJHjZN8iaWfzpxN+QBTTA2/pcFra1ryV18
 TsK7o3GJDkAZIU4TpHeOpEckwcf0IRuMd5Fm+XNQTYDEapXgfv6hAlxBP6NdVKBXRiU9
 klkD0Y7I6pSz7wMMjd1/OKize6oWPxLc/rULkdvXZ/z5ggU0KE0JpsAhG27YhVCJk7mm 0A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kusg5rjnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AEKJN55028462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 20:19:23 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 14 Nov 2022 12:19:23 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 06/10] ath11k: rename struct wmi_vdev_up_cmd members
Date:   Mon, 14 Nov 2022 12:19:08 -0800
Message-ID: <20221114201912.22893-7-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114201912.22893-1-quic_alokad@quicinc.com>
References: <20221114201912.22893-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c8NSDwO6jmxSscnX2iXqfJMPDTXWVPUm
X-Proofpoint-GUID: c8NSDwO6jmxSscnX2iXqfJMPDTXWVPUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxlogscore=889 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Rename trans_bssid to tx_vdev_bssid to make it similar to vdev_bssid.
- Rename profile_num to profile_cnt to make it clearer that it stores
the count of MBSSID profiles. The variable profile_num can be confused
to be the profile index for which profile_idx is used.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v2: New patch in this version. Code moved from patch 5/9 in v1.

 drivers/net/wireless/ath/ath11k/wmi.c | 4 ++--
 drivers/net/wireless/ath/ath11k/wmi.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index f589569fec0d..b108ce423e8e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1021,10 +1021,10 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params)
 		bss_conf = &arvif->vif->bss_conf;
 
 		if (bss_conf->nontransmitted) {
-			ether_addr_copy(cmd->trans_bssid.addr,
+			ether_addr_copy(cmd->tx_vdev_bssid.addr,
 					bss_conf->transmitter_bssid);
 			cmd->profile_idx = bss_conf->bssid_index;
-			cmd->profile_num = bss_conf->bssid_indicator;
+			cmd->profile_cnt = bss_conf->bssid_indicator;
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 425ca6da84d7..1a563e88f7fb 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2623,9 +2623,9 @@ struct wmi_vdev_up_cmd {
 	u32 vdev_id;
 	u32 vdev_assoc_id;
 	struct wmi_mac_addr vdev_bssid;
-	struct wmi_mac_addr trans_bssid;
+	struct wmi_mac_addr tx_vdev_bssid;
 	u32 profile_idx;
-	u32 profile_num;
+	u32 profile_cnt;
 } __packed;
 
 struct wmi_vdev_stop_cmd {
-- 
2.17.1

