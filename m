Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E56536B4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 19:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiLUS4f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 13:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiLUS4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 13:56:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3305524082
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 10:56:31 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLIC7Ok004008;
        Wed, 21 Dec 2022 18:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=fntQqvWdb+hZb0tvH5km7fOhQF0br6lbusO/FKnxsVQ=;
 b=cJaM8rqiA715xSp0EPRR+N/F7Au/CO+dXYSyBi1w8wMHse0XE9Q9idermjZT0LaXRcM7
 y3ePB2p6LPXkzVfhjo61CG8VcN8CoCm3TPAbX41CZxgJyqSszGbD4dd3RAon0F45OtQE
 1i2tpZAALgxFNmruPmO9QC69HgEXaa4cNL9SfmTvNoPrDbVHmh+Gl4/j9p/XzKrbENPc
 wyxVoQlcGU+9F/c3ydd3l/uHgpcaueQ/qJs9tQ9D9ZIZsXNTXa79fKHbvX7Pg4nLII5k
 b4+5GQ+/NlzGTOmf9wvRXyB3a5i9l4CiKqKDjwc2vfjkUxLruzYnRAGvgDN4Y3MiiWaH kQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm2brrtgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 18:56:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLIuRSg006151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 18:56:27 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 21 Dec 2022 10:56:26 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>, Jouni Malinen <j@w1.fi>
Subject: [PATCH] mac80211: reset multiple BSSID options in stop_ap()
Date:   Wed, 21 Dec 2022 10:56:16 -0800
Message-ID: <20221221185616.11514-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: X9-IOXoysgPeCsYON7qL6V9NDekxRVUo
X-Proofpoint-GUID: X9-IOXoysgPeCsYON7qL6V9NDekxRVUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_11,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=885 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reset multiple BSSID options when all AP related configurations are
reset in ieee80211_stop_ap().

Stale values result in HWSIM test failures (e.g. p2p_group_cli_invalid),
if run after 'he_ap_ema'.

Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 net/mac80211/cfg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8f9a2ab502b3..672eff6f5d32 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -147,6 +147,7 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 	link_conf->bssid_index = 0;
 	link_conf->nontransmitted = false;
 	link_conf->ema_ap = false;
+	link_conf->bssid_indicator = 0;
 
 	if (sdata->vif.type != NL80211_IFTYPE_AP || !params.tx_wdev)
 		return -EINVAL;
@@ -1511,6 +1512,12 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	kfree(link_conf->ftmr_params);
 	link_conf->ftmr_params = NULL;
 
+	sdata->vif.mbssid_tx_vif = NULL;
+	link_conf->bssid_index = 0;
+	link_conf->nontransmitted = false;
+	link_conf->ema_ap = false;
+	link_conf->bssid_indicator = 0;
+
 	__sta_info_flush(sdata, true);
 	ieee80211_free_keys(sdata, true);
 

base-commit: 117dbeda22ec5ea0918254d03b540ef8b8a64d53
-- 
2.39.0

