Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5C68066A
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 08:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbjA3HXE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 02:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjA3HXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 02:23:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB6C11E89
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 23:23:00 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U701b5019150;
        Mon, 30 Jan 2023 07:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=91nwmMgLOMNoljViMsb2pk2FpMO7qbeOyTWe2FsfO0c=;
 b=eoGuDv1N5IYas5B861lawUH2/mwg2b7kfa+CDsQKIjBkbSaSsSRw9182LyeB/wh/mBJW
 kiD1GFocSqlvTYfYMgF3nGYpDrZ2rPBCwcuvWUYDEKhxOwha1KUNEVZFlA4qjlV63mct
 yrYPi7O24BIfkmV40n9cett2q6z/TG/FiM3ia/SME3iVwHeQ2n3bXbxBGiJOer0MTKIU
 ZojerYnCQd1u84+kDURYs1A1HZmbdNPyCSGqY5Ek8VTEyUNKNpgxx/ewngLBtAhS1Thg
 7kDBuirAX/262barc73/+CU9g6mqyVoKzHFtPWPKp3MRdTZaDdY5CT03UThau1UuYt4h UQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpaurg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U7MqRf014986
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:52 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 23:22:52 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v3 4/6] wifi: mac80211: configure puncturing bitmap in channel_switch()
Date:   Sun, 29 Jan 2023 23:22:37 -0800
Message-ID: <20230130072239.26345-5-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130072239.26345-1-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lT9zngIbdAekLPgxF4qx8JYeYV9ekK35
X-Proofpoint-ORIG-GUID: lT9zngIbdAekLPgxF4qx8JYeYV9ekK35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=801 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Validate and set the puncturing bitmap in bss_conf for new channel.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/mac80211.h |  3 +++
 net/mac80211/cfg.c     | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b1c17c7ac044..87db6055d331 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -645,6 +645,7 @@ struct ieee80211_fils_discovery {
  * @csa_active: marks whether a channel switch is going on. Internally it is
  *	write-protected by sdata_lock and local->mtx so holding either is fine
  *	for read access.
+ * @csa_punct_bitmap: new pucturing bitmap for channel switch
  * @mu_mimo_owner: indicates interface owns MU-MIMO capability
  * @chanctx_conf: The channel context this interface is assigned to, or %NULL
  *	when it is not assigned. This pointer is RCU-protected due to the TX
@@ -741,6 +742,8 @@ struct ieee80211_bss_conf {
 	u32 eht_puncturing;
 
 	bool csa_active;
+	u32 csa_punct_bitmap;
+
 	bool mu_mimo_owner;
 	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87aab0ba9353..8a1cb2f083f5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3553,6 +3553,12 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&local->mtx);
 	lockdep_assert_held(&local->chanctx_mtx);
 
+	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
+		sdata->vif.bss_conf.eht_puncturing =
+					sdata->vif.bss_conf.csa_punct_bitmap;
+		changed |= BSS_CHANGED_EHT_PUNCTURING;
+	}
+
 	/*
 	 * using reservation isn't immediate as it may be deferred until later
 	 * with multi-vif. once reservation is complete it will re-schedule the
@@ -3856,9 +3862,16 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	if (params->punct_bitmap &&
+	    (!sdata->vif.bss_conf.eht_support ||
+	     !ieee80211_valid_disable_subchannel_bitmap(&params->punct_bitmap,
+							params->chandef.width)))
+		goto out;
+
 	sdata->deflink.csa_chandef = params->chandef;
 	sdata->deflink.csa_block_tx = params->block_tx;
 	sdata->vif.bss_conf.csa_active = true;
+	sdata->vif.bss_conf.csa_punct_bitmap = params->punct_bitmap;
 
 	if (sdata->deflink.csa_block_tx)
 		ieee80211_stop_vif_queues(local, sdata,
-- 
2.39.0

