Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF136E4537
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 12:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDQKc3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 06:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDQKc2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 06:32:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9683F7
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 03:31:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H9W3rj029823;
        Mon, 17 Apr 2023 10:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=6ILMAxn2X9XASMKxX1f9QOUcK7H08mCJWvLaMaR6t70=;
 b=ngaP4ViOTG55TQGWHE5nRcjI+6TUVdeCCMtQEZfsPbDwtDeLXFQRAZJo+7aDgz2ATJbe
 FbZBLSC5dEivLQfrRukG4l+wP97/GhHlWg2L5wmcDUjzxiixUv/xnL3Nz/kC9z2PA48c
 JeVq5RGvjZGR+VU49Obj3XXJ0JSJL3kuKaFPFArPZ/k73vNIF9Z3mpiCqzo5QqXX3fbQ
 aUdxNXO/QMyXKpIivSEqey4eumEBjhs/rO+zIJIQg8xVmHYY7UWNZlfkotQcisLgG6Of
 rUSBPgWdaHVoX5E8G7ZNcaJWHwNQQu5cHyyOkzIodiMz1b38dTAHRxobGmAwoZPVKTuJ 1Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q12ut86px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 10:03:11 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HA3AdE017163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 10:03:10 GMT
Received: from karm-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 17 Apr 2023 03:03:08 -0700
From:   Karthik M <quic_karm@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Karthik M <quic_karm@quicinc.com>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Subject: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Date:   Mon, 17 Apr 2023 15:32:58 +0530
Message-ID: <20230417100258.22965-1-quic_karm@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c8h5C5AED0p8aj-cESSVHy0SoHx701mj
X-Proofpoint-ORIG-GUID: c8h5C5AED0p8aj-cESSVHy0SoHx701mj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 phishscore=0 mlxscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If the average value in mesh metrics calculation
has been rounded to 0 (success), this resets it to
the smallest nonzero value (similarly to the initialization)
to avoid a case where a single failure would result in
an average value that goes beyond the value
of 95 (Link Failure Threshold).

Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Signed-off-by: Karthik M <quic_karm@quicinc.com>
---
Changes since v1:
 - Altered the comment to mention "mesh" and thershold value.
 - Checkpatch done
---
 net/mac80211/mesh_hwmp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 9b1ce7c3925a..f89cbcf212d5 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -298,10 +298,23 @@ void ieee80211s_update_metric(struct ieee80211_local *local,
 {
 	struct ieee80211_tx_info *txinfo = st->info;
 	int failed;
+	u32 fail_avg;
 	struct rate_info rinfo;
 
 	failed = !(txinfo->flags & IEEE80211_TX_STAT_ACK);
 
+	fail_avg = ewma_mesh_fail_avg_read(&sta->mesh->fail_avg);
+	if (!fail_avg) {
+		/* If the average value in mesh metrics calculation
+		 * has been rounded to 0 (success), this resets it to
+		 * the smallest nonzero value (similarly to the initialization)
+		 * to avoid a case where a single failure would result in
+		 * an average value that goes beyond the value
+		 * of 95 (Link Failure Threshold)
+		 */
+		ewma_mesh_fail_avg_add(&sta->mesh->fail_avg, 1);
+	}
+
 	/* moving average, scaled to 100.
 	 * feed failure as 100 and success as 0
 	 */
-- 
2.17.1

