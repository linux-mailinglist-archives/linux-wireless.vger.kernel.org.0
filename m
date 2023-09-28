Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D07B1239
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 07:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjI1Fuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 01:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Fux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 01:50:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54DBF
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 22:50:51 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S5PfA9020430;
        Thu, 28 Sep 2023 05:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=h93u0m4Baq1x/Lrg5OXE2hHmB1BPlotWgBEozBxJ6dA=;
 b=fIWaJrEuuXepcZXx8bYMnz/RAa7uI8EW7nnsvj91qU5V4o8TLvGb71hEmHOI7XqPO4as
 ZXJv2dlx2Ru1XdlN8vLfaE2D374gNoZvL9tiTaV4DyMu03iPGs+LglGxizs7ECwQWxKw
 gjWbwMeDZMVcBNMmqpWAgOPC6QzMQAfubP6KpbKkCqqegp5Uxhk78dR39JmJAoDkETcJ
 lYOqlzgw9/6dVxVBZGWyLlj+z0xRo86qzGA16Vunebl6te7v/gtSleLoDGX7HZ8YfY9C
 yDp3YqC+CsJdp+x/biSUqLp5nWlxV35gGzg3JGmXJyq0ZF0RYCJiNUhePa9x6MO4sbIM JA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc8v4b525-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:50:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S5ojeP005045
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:50:45 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 27 Sep 2023 22:50:44 -0700
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 2/4] wifi: mac80211: mlme: correct the verification of extracted bitmap
Date:   Thu, 28 Sep 2023 13:50:20 +0800
Message-ID: <20230928055022.9670-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928055022.9670-1-quic_kangyang@quicinc.com>
References: <20230928055022.9670-1-quic_kangyang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wE_R_Wn8rbvglOW510Jpq7-CQCZisleq
X-Proofpoint-ORIG-GUID: wE_R_Wn8rbvglOW510Jpq7-CQCZisleq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_03,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=732 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mac80211 will extract puncturing bitmap according to the negotiated
bandwidth. After extraction, should check the new puncturing bitmap
according to the negotiated bandwidth, but here input the original bitmap.

When bandwidth downgrade occurs, this function may return an error even
though negotiated bandwidth and puncturing bitmap match correctly.

So correct it.

Fixes: aa87cd8b3573 ("wifi: mac80211: mlme: handle EHT channel puncturing")
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 16e15ced28a5..13fba1f1cd89 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -145,7 +145,7 @@ ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
 			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
 							 bitmap);
 
-		if (cfg80211_valid_disable_subchannel_bitmap(&bitmap,
+		if (cfg80211_valid_disable_subchannel_bitmap(&extracted,
 							     chandef))
 			break;
 		link->u.mgd.conn_flags |=
-- 
2.34.1

