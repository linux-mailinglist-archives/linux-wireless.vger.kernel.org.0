Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CD365611C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Dec 2022 09:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiLZId6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Dec 2022 03:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiLZIdy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Dec 2022 03:33:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBE8BB0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Dec 2022 00:33:53 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQ5SUlA030390;
        Mon, 26 Dec 2022 08:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=W/BAUuFz1Nwd8KZNQzffNYl5Rqqhtt0te+jAOvUkxbc=;
 b=m5deBAVodVNJtPWxNA5UMP/QvQJSStTX8Nxr3IMSYWdwUrn7H1dSvsEnJAmylq9gJ6dp
 klsSnoM+EG8o5Lfrkubu9CO7evSzHXrIAvG9Iu9IhL1X8KwGOLXUkSvlSBw05VbxOdEg
 41CHqy/lzWJlEzInJslbnU6C7zi6thbm1d2CQod7T5KWsFwy+DjE5wpAlpj4F44kN2l0
 iCVqP4onUugS9Ysxj7Afv3cZeANFYA+FGAbGbpXKUn1G5i699oy2y1pTz9pBWHPP7CnI
 F/lhdCIoxMAqojNVJH0mTtMEOX2HmsT6aXMTwCAai7Xi2JaeAdshzPuan1qC33oZP0kx bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mns18305c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 08:33:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BQ8Xke4010793
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 08:33:46 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 26 Dec 2022 00:33:44 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH 2/2] ath11k: add support to enable/disable BSS color collision detection
Date:   Mon, 26 Dec 2022 14:03:28 +0530
Message-ID: <20221226083328.29051-3-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221226083328.29051-1-quic_ramess@quicinc.com>
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VPHDpsAdRot3GJ2I8GX6AFL_U3grNsbW
X-Proofpoint-GUID: VPHDpsAdRot3GJ2I8GX6AFL_U3grNsbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_04,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=990 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212260074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

