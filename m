Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA436BEB9D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 15:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCQOpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCQOpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 10:45:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D5038B7B
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 07:44:49 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7XuZP014931;
        Fri, 17 Mar 2023 14:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=7xJv19rYtCyjS6FtMyVQcyiOlD1FGuh5o5qI9j1qxHw=;
 b=LjYHaKaaieYQE2Dh+SkPoe6j/NkTmW2TCcztdBwIFoKHzZUriyHPiTscPXrMJEim4Zx3
 oTBfE5Ib1oBYjb/760b3kczhekwbxShEtbkprQDFwJ6njTnNZixFUu5Cv8mv99olUwe4
 MH6AcSSL1n+La2IckZHxl5RVp8tXKgImhv7AbbAnBmOYT1omYD0nTZ/NRKjGaaBi7KGj
 /85MVPlniEOBVUIgbMpYdap8fukrsJWV5WJc3J4KjNY4fUwTpnmmte+XnYG8WzB/JdYi
 6NOp8DSHRkkEwKehvpa/kl9TYDyGLzZOjZHuDIMjx+UuVAmbNW7EeinVwG8SzjsJZFHm wg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pce6nj2fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:44:45 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HEiigW018288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 14:44:44 GMT
Received: from karm-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Mar 2023 07:44:42 -0700
From:   Karthik M <quic_karm@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Karthik M <quic_karm@quicinc.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH] wifi: mac80211: Initialize EWMA fail avg to 1
Date:   Fri, 17 Mar 2023 20:14:32 +0530
Message-ID: <20230317144432.10477-1-quic_karm@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NNxuc2QQ27qY2msSRz_JPCzhtcJq3mbF
X-Proofpoint-GUID: NNxuc2QQ27qY2msSRz_JPCzhtcJq3mbF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_09,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the average value has been rounded to 0 (success),
reset it to the smallest nonzero value (similarly to the initialization) to
avoid a case where a single failure would result in an average value
that goes beyond the threshold value of 95.

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Signed-off-by: Karthik M <quic_karm@quicinc.com>
---
 net/mac80211/mesh_hwmp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9b1ce7c3925a..e9fcaff9cc7e 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -298,10 +298,21 @@ void ieee80211s_update_metric(struct ieee80211_local *local,
 {
 	struct ieee80211_tx_info *txinfo = st->info;
 	int failed;
+	u32 fail_avg;
 	struct rate_info rinfo;
 
 	failed = !(txinfo->flags & IEEE80211_TX_STAT_ACK);
 
+	fail_avg = ewma_mesh_fail_avg_read(&sta->mesh->fail_avg);
+	if (!fail_avg) {
+		/* If the average value has been rounded to 0 (success), 
+		 * reset it to the smallest nonzero value (similarly to 
+		 * the initialization) to avoid a case where a single 
+		 * failure would result in an average value that goes 
+		 * beyond the threshold value of 95 */
+		ewma_mesh_fail_avg_add(&sta->mesh->fail_avg, 1);
+	}
+
 	/* moving average, scaled to 100.
 	 * feed failure as 100 and success as 0
 	 */
-- 
2.17.1

