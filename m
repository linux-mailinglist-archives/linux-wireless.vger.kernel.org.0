Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C790C6E92EE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDTLhe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbjDTLha (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 07:37:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A110F106
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 04:37:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KArIpI014247;
        Thu, 20 Apr 2023 11:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Gts8VGFtmTWRujbSbEjtKSN6BMNUIyMZ27yitoYEoBc=;
 b=Y4EurxYKG6wkYbSZzlEdR6Ol2WIRYpZFhuJIcC9p9a8E9+p8hB4L7sh1nK96YtjlnOha
 KOVMp/Uf/MtAxKY2xsLqfA503wfimV7wlJBivmvyt75ltuDPWiaCH2XqaXIFNkBRjfHl
 TXIIskSojrzLSv9glAxxaXlPj0FsztxBOg10Y4beuflR0ARLzTcGyWtG6ev77o56tVy4
 PdCqsymoQ1Yu9eUVwphgAW9+hnK43GcQ//RNJB/XFTIJirjfCF6r78g3zGmLf+ynLhtH
 rBzau60fZJRfgV/N7fSPF9PeDA6X/8ZRqcVphkeVr6zeRtUQORwYuLCPehdh9rOHDyR9 Mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2nn81xhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 11:37:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KBbNOm012294
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 11:37:23 GMT
Received: from rajkbhag-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 20 Apr 2023 04:37:21 -0700
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Govindaraj Saminathan <quic_gsaminat@quicinc.com>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [PATCH v2 2/4] wifi: ath11k: optimize ath11k_tm_cmd_get_version
Date:   Thu, 20 Apr 2023 17:06:51 +0530
Message-ID: <20230420113653.1686-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230420113653.1686-1-quic_rajkbhag@quicinc.com>
References: <20230420113653.1686-1-quic_rajkbhag@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UXuIs14IHfvGbW1qPpQb_hQ3NooLGKLO
X-Proofpoint-GUID: UXuIs14IHfvGbW1qPpQb_hQ3NooLGKLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_07,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=781
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200093
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>

Currently ath11k_tm_cmd_get_version() uses local variable ret.
optimize ath11k_tm_cmd_get_version() to avoid local variable use.

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

