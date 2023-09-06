Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852227937A6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Sep 2023 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjIFJES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Sep 2023 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjIFJER (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Sep 2023 05:04:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80166184
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 02:04:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3868GlsN007065;
        Wed, 6 Sep 2023 09:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=8M0yWoxZOFEPy9Jia6aRfHa3MSTJPV6zmbbx2kbQAWQ=;
 b=b74ptwGSbbIZH17eKSTPTlwHIgJBWJRG0rRYQ1YB2Z2HByn6AqLtOIfsDPfdPyOw9gOo
 fBxD3Jim22yNG8RWpZtx52XBL4asYmtkoRd8aunW9tsFBTETxknY++5WQtsq2m4sBJW0
 epSoudeZMiHJ12peGdV213f2LFxmxRl3OwndM5d4Cp9SmQ7rAm0nwHK9HYV6cdZ5MONI
 oarERg0JiOHIYZJGOWdf5yrGRp51XsJbeQ57CQa/nym2a7a6FTz+nLq99TDZW8Lde0Vz
 zSuhu5UiBXpHAIFfss1xQaMOqoKqXRwEqeZHhP1kJyrKm55TS8joBGwD9+H1fWpd1i+5 Eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxhbhgtkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 09:04:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38694BHG002319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Sep 2023 09:04:11 GMT
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 6 Sep 2023 02:04:10 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] wifi: ath12k: change to treat alpha code na as world wide regdomain
Date:   Wed, 6 Sep 2023 05:03:55 -0400
Message-ID: <20230906090355.19181-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0OWZuv5KVV6GuSxhYS-s2op_cIZxfIug
X-Proofpoint-ORIG-GUID: 0OWZuv5KVV6GuSxhYS-s2op_cIZxfIug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=982 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060075
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some firmware versions for WCN7850 report the default regdomain with
alpha code "na" by default when load as a world wide regdomain,
ath12k should treat it as a world wide alpha code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 9ed33e2d6da0..4ebc09b35892 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5390,7 +5390,13 @@ static void ath12k_wmi_htc_tx_complete(struct ath12k_base *ab,
 
 static bool ath12k_reg_is_world_alpha(char *alpha)
 {
-	return alpha[0] == '0' && alpha[1] == '0';
+	if (alpha[0] == '0' && alpha[1] == '0')
+		return true;
+
+	if (alpha[0] == 'n' && alpha[1] == 'a')
+		return true;
+
+	return false;
 }
 
 static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)

base-commit: 3f257461ab0ab19806bae2bfde4c3cd88dbf050e
-- 
2.40.1

