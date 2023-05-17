Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64528706A5F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjEQOAJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 10:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEQOAH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 10:00:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C3559E
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 07:00:05 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HDZ9WW015644;
        Wed, 17 May 2023 14:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=p+TbnmmYvqSa77jOGPBaTOH0lEIU5dKKi6f2LvhZta8=;
 b=hMZd6jdlmsZi1NV4s9NynJotDICNAX58e+6FLij4PdDMGRsyKIimDNG8m7w8vlKVvz3S
 yvRJwjne2LgcBWLdd7lzZll3rk57FHvM4weHHGO51qGIZRm0OjN58IHsjTlRwzxSbZtB
 VB4Wc76CvdNx3XcJPOn/tgYJqzc0Mskcwbci5W1UQchmrYj5vRTrHuidhC93KvE6sxC+
 srtxCKviaG0kOs+TztYI2A/JNkCnL3/oPSJFBr+YBIlHOT+5lQaDYgT8oNp5Ryyo4fyE
 6/DtO+j+VDjsSpg1CnM/50sPzFsKQYUZK6YpR57IQ/gh8JH6JCVRZj+mENWhcVBwnpKS 2g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmcc62ea1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:00:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HE036R005858
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 14:00:03 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 07:00:01 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v4 2/4] wifi: ath11k: optimize ath11k_tm_cmd_get_version
Date:   Wed, 17 May 2023 19:29:32 +0530
Message-ID: <20230517135934.16408-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
References: <20230517135934.16408-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vn9K_zmxU0vL7GNU1yAe6C1xq4tTQ2-X
X-Proofpoint-ORIG-GUID: vn9K_zmxU0vL7GNU1yAe6C1xq4tTQ2-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=884 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>

Currently ath11k_tm_cmd_get_version() uses local variable ret.
optimize ath11k_tm_cmd_get_version() to avoid local variable use.

Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/testmode.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index ebeca5eb6a67..f562f860ebf3 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -24,7 +24,6 @@ static const struct nla_policy ath11k_tm_policy[ATH11K_TM_ATTR_MAX + 1] = {
 static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
 {
 	struct sk_buff *skb;
-	int ret;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
 		   "testmode cmd get version_major %d version_minor %d\n",
@@ -36,18 +35,12 @@ static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
 	if (!skb)
 		return -ENOMEM;
 
-	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
-			  ATH11K_TESTMODE_VERSION_MAJOR);
-	if (ret) {
-		kfree_skb(skb);
-		return ret;
-	}
-
-	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
-			  ATH11K_TESTMODE_VERSION_MINOR);
-	if (ret) {
+	if (nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
+			ATH11K_TESTMODE_VERSION_MAJOR) ||
+	    nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
+			ATH11K_TESTMODE_VERSION_MINOR)) {
 		kfree_skb(skb);
-		return ret;
+		return -ENOBUFS;
 	}
 
 	return cfg80211_testmode_reply(skb);
-- 
2.17.1

