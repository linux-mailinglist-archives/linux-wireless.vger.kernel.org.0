Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919257B1238
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 07:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjI1Fu7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 01:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1Fuz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 01:50:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF62D122
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 22:50:52 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S5iE5L021954;
        Thu, 28 Sep 2023 05:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=8SKaY3foq4ZnEVvUnm+BG03YTdIles1jbzczQPA5N50=;
 b=HUSIq+1JMwUoih+l1gqAF+QU2hWt6E5/FxAiI3FuniWuO2ogaLYo0zHQKDakHLjoLvqH
 jhnQ7Y/ssMRDPWMvkEz8bBSnYReWl+LBZd57rwHD4ARhlehUd3VXu0UT2aueFMP7Q4tv
 ua/zLf9FtGvpBls4bN5anXN0NYVRMtpRjmuHKaS5+7MI4xNCQfvzTPuAtQQ9lJeRepOz
 ER3+EfEMAByMOCd88l4mIO9tCCLV+yn6TEv2KtKaQ9n8g/YZZKMw9kXs9qK16nCITmM2
 sMLHCmAGcrIvT8C9nHOzJ1qyjuVgJzwQAFgpq0qVRg8e31iVt2y4xeMA9OmaxhhmUgBs ag== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td3gg80mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:50:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38S5olmw005063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 05:50:47 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 27 Sep 2023 22:50:45 -0700
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 3/4] wifi: mac80211: mlme: enable tracking bandwidth changes for 6 GHz band
Date:   Thu, 28 Sep 2023 13:50:21 +0800
Message-ID: <20230928055022.9670-4-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: _8J9ba7RmGo3JYb3vLtE9G5NKDPtjfrV
X-Proofpoint-ORIG-GUID: _8J9ba7RmGo3JYb3vLtE9G5NKDPtjfrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_03,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309280048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After connection, mac80211 will track bandwidth changes upon
beacon's CRC is changed. But it will stop tracking bandwidth
changes when these is no HT Operation element.

According to the section 9.4.2.311 in IEEE P802.11be draft 4.0:
The operation of EHT STAs in an EHT BSS is controlled by the following:
        -'The HT Operation element, HE Operation element, and EHT
          Operation element if operating in the 2.4 GHz band'
        -'The HT Operation element, VHT Operation element (if present),
          HE Operation element, and EHT Operation element if operating
          in the 5 GHz band'
        -'The HE Operation element and EHT Operation element if
          operating in the 6 GHz band'

For 6 GHz band, beacon doesn't contain HT Operation element. Therefore,
current checking code needs to be changed.

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 net/mac80211/mlme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 13fba1f1cd89..f55d677f9ace 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -501,9 +501,9 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	u32 vht_cap_info = 0;
 	int ret;
 
-	/* if HT was/is disabled, don't track any bandwidth changes */
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT || !ht_oper)
-		return 0;
+	/* don't check HT if we associated as non-HT station */
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)
+		ht_oper = NULL;
 
 	/* don't check VHT if we associated as non-VHT station */
 	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
@@ -525,10 +525,12 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	 * if bss configuration changed store the new one -
 	 * this may be applicable even if channel is identical
 	 */
-	ht_opmode = le16_to_cpu(ht_oper->operation_mode);
-	if (link->conf->ht_operation_mode != ht_opmode) {
-		*changed |= BSS_CHANGED_HT;
-		link->conf->ht_operation_mode = ht_opmode;
+	if (ht_oper) {
+		ht_opmode = le16_to_cpu(ht_oper->operation_mode);
+		if (link->conf->ht_operation_mode != ht_opmode) {
+			*changed |= BSS_CHANGED_HT;
+			link->conf->ht_operation_mode = ht_opmode;
+		}
 	}
 
 	if (vht_cap)
-- 
2.34.1

