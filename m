Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724FB6F34DC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 May 2023 19:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjEARHB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjEARGo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 13:06:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9E75FE1
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 10:01:04 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341GjRgS031480;
        Mon, 1 May 2023 16:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=g3Eq3RgtI5WKus6NgsD/XSrAhg9GMicT5O8zHHYHRg8=;
 b=L3Nkd8cnyTJNuoouC8sxN0F/STysXozFWutpYJlIXEMa2vtvyvqjojGAE2gj4aY7Lz+t
 iZbpUzSO8UPM0hXh9eRD8DCKt0pT0HThsjSIba13qFc+eWJ6bAkrbUuhagdRGA5T71la
 6yL4Pu6PqP5e72eihguSOnGJi+tjXkH7+W77t1MQzkPOKZGvokvZ3DVUIzY9p5tHjd/E
 P40fKNDgNwekh1nSfMwRwo9ywO0hhRparegCt4Eg8N9+6Pz4AbeTzAg11vaEg7pfLrpG
 AMoD4YCDs3yFpUWCTtc17EfGYsatHT/G/T4ugdjv3kzw206ynEt2YW36OIKDIj/aUH16 1w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8t71v9pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 16:59:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341Gxu9k032414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 16:59:56 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 May 2023 09:59:55 -0700
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v6 2/3] wifi: mac80211: allow userspace to enable driver control of MU-EDCA
Date:   Mon, 1 May 2023 09:59:22 -0700
Message-ID: <1682960363-15452-2-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1682960363-15452-1-git-send-email-quic_msinada@quicinc.com>
References: <1682960363-15452-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eHb9kkmkQbqyA50YLUAN0kIO5XZZ03js
X-Proofpoint-ORIG-GUID: eHb9kkmkQbqyA50YLUAN0kIO5XZZ03js
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=613 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Propagate userspace configuration to enable or disable if driver is
able to dynamically update MU-EDCA parameters.

The updated MU-EDCA parameters from driver are part of an AP mode feature
where firmware determines better MU-EDCA parameters based on channel
conditions. The updated parameters are used and reported to user space
to reflect in AP management frames. These dynamic parameter updates
are offloaded to firmware for better user experience, thus details on
algorithm are not provided. This is a driver specific feature, thus
no spec references.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
v6: no change

v5: no change

v4: newly created patch in response to review comment to add opt in
    for user for this feature
---
 include/net/mac80211.h | 6 ++++++
 net/mac80211/cfg.c     | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 679421d37a42..70acd76ce450 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -376,6 +376,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
 	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
 	BSS_CHANGED_EHT_PUNCTURING	= BIT_ULL(32),
+	BSS_CHANGED_DYNAMIC_MU_EDCA	= BIT_ULL(33),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -683,6 +684,9 @@ struct ieee80211_fils_discovery {
  *	beamformee
  * @eht_mu_beamformer: in AP-mode, does this BSS enable operation as an EHT MU
  *	beamformer
+ * @dyn_muedca_enabled: whether to enable or disable driver control of MU-EDCA
+ *	parameters. If set to zero, driver dynamically updating parameters is
+ *	disabled; if set to 1, driver dynamically updating parameters is enable
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -776,6 +780,8 @@ struct ieee80211_bss_conf {
 	bool eht_su_beamformer;
 	bool eht_su_beamformee;
 	bool eht_mu_beamformer;
+
+	int dyn_muedca_enabled;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 473915606715..ff9117c1c288 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1465,6 +1465,11 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
 	}
 
+	if (link_conf->dyn_muedca_enabled != params->dyn_muedca_enable) {
+		link_conf->dyn_muedca_enabled = params->dyn_muedca_enable;
+		changed |= BSS_CHANGED_DYNAMIC_MU_EDCA;
+	}
+
 	err = drv_start_ap(sdata->local, sdata, link_conf);
 	if (err) {
 		old = sdata_dereference(link->u.ap.beacon, sdata);
-- 
2.7.4

