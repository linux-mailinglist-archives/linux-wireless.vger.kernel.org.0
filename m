Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C83685FCD
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 07:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBAGeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 01:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjBAGeV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 01:34:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC64A226
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 22:34:19 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3115GJQi013200;
        Wed, 1 Feb 2023 06:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=W/BAUuFz1Nwd8KZNQzffNYl5Rqqhtt0te+jAOvUkxbc=;
 b=A/uaw39qE+0dShsawkdNUkP6m6FRafGnZd4UxJmnI1Y6BQGEIktZD+2w6QkQT7AgNlA7
 budFFblom5pTQ3Fa7OpngURdJh+GMK8ugSyqhTD+cirKKsm987kjvYAvUtEfvMrTPqxQ
 NCurvbeIppFGOC7NJ3TQk23Du1yCDmKwLlorDgtvSpv8H9OuEGc/Z76HdMQVG+jloxM/
 S2DM/KHJGxjE02c6rQP9AWJApo9VHQOcl2qMOLRyNrixOxDttwLLj0y4WcB6peE3rzfd
 DY+kQPowClCyzWFkFaFrV2TIviRW4SvPUsN4af10GW36zzChwoflnlYad68xztPNrjxD Cw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nf70shga8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:34:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3116Y5BJ030124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 06:34:05 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 22:34:03 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 3/3] wifi: ath11k: add support to enable/disable BSS color collision detection
Date:   Wed, 1 Feb 2023 12:03:33 +0530
Message-ID: <20230201063333.11747-4-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230201063333.11747-1-quic_ramess@quicinc.com>
References: <20230201063333.11747-1-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qmJg2p-UH3r5ejd8S60ennK0DFNuC5R4
X-Proofpoint-ORIG-GUID: qmJg2p-UH3r5ejd8S60ennK0DFNuC5R4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=967 lowpriorityscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable/Disable BSS color collision detection based on user
configuration of collision detection and BSS color feature
itself.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9e923ecb0891..6d5290996d9f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3112,6 +3112,7 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	u8 rateidx;
 	u32 rate;
 	u32 ipv4_cnt;
+	bool color_collision_detect;
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3370,10 +3371,12 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR) {
 		if (vif->type == NL80211_IFTYPE_AP) {
+			color_collision_detect = (info->he_bss_color.enabled &&
+						  info->he_bss_color.collision_detection_enabled);
 			ret = ath11k_wmi_send_obss_color_collision_cfg_cmd(
 				ar, arvif->vdev_id, info->he_bss_color.color,
 				ATH11K_BSS_COLOR_COLLISION_DETECTION_AP_PERIOD_MS,
-				info->he_bss_color.enabled);
+				color_collision_detect);
 			if (ret)
 				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
 					    arvif->vdev_id,  ret);
-- 
2.17.1

