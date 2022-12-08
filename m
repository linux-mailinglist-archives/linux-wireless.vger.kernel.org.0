Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D8E64680F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 05:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLHEBY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 23:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLHEBX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 23:01:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3150286E9
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 20:01:22 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B82HZ37029861;
        Thu, 8 Dec 2022 04:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=IAfD93YvuHRHqZxR0OQJnD75LCz/6DNBBfzcU269lhA=;
 b=c4C2ivM3MhO3QwQsiQ2cCG1yC+su/vNs5yTcb2Rrvkmlb4qiLJc3Z7D3KS71GdmUN28F
 B5HrvJTq16Ws5E7ueSY84AwLOlqjCthmlVHkC/Rx0YMDLN3ecLMAv5yKEnLuMU+2TeZc
 kQBtJk//cXOT6poM1pUyBkfGm8LT2bzlrzimqILJhOPA+PmDXxShIdKrfOcVY6HS7o8t
 EdRi3nla4SGMoMi8Y8+UaGb1LWOwtzTS0fMn/KqgFj4RdqiRo7P+XpodsqGuh8YAUOl6
 LdV5AotJo71CDpYFzUbFXyoRiFqvLytqhi6IoqeqLoFJT4ILGxO9vivWBHhCUGYjm8kz Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3marj0t91k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 04:01:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B841D9b031817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 04:01:13 GMT
Received: from srirrama-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 7 Dec 2022 20:01:11 -0800
From:   Sriram R <quic_srirrama@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH] mac80211: Fix MLO address translation for multiple bss case
Date:   Thu, 8 Dec 2022 09:30:50 +0530
Message-ID: <20221208040050.25922-1-quic_srirrama@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fd5QLZ5Tnc7UKEsLilAtaD_ZDBjY7yCc
X-Proofpoint-GUID: Fd5QLZ5Tnc7UKEsLilAtaD_ZDBjY7yCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_01,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=845 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212080031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When multiple interfaces are present in the local interface
list, new skb copy is taken before rx processing except for
the first interface. The address translation happens each
time only on the original skb since the hdr pointer is not
updated properly to the newly created skb.

As a result frames start to drop in userspace when address
based checks or search fails.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
---
 net/mac80211/rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 8dcd67d..3206b42 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5072,6 +5072,9 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		 */
 		shwt = skb_hwtstamps(rx->skb);
 		shwt->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
+
+		/* Update the hdr pointer to the new skb for translation below */
+		hdr = (struct ieee80211_hdr *)rx->skb->data;
 	}
 
 	if (unlikely(link_sta)) {
-- 
2.17.1

