Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1C640D5E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiLBSgP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 13:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiLBSgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 13:36:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D7ECE72
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 10:36:11 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2FjjZc012919;
        Fri, 2 Dec 2022 18:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PhSFr3fIHFf/Bv/iCYFZyFk7T1iHwFRdGBGffgNAH0o=;
 b=FmBooLxr79KvC8+5jBIkoQ4jJm1v+2pNdDlpcjAAzbraYIGVT82wdcg72gFwdnOxwZWM
 YS5ZUXNWmAyTvC7hL7+zyDAp3D4kIV0JCaGaGhclbmP1iNovwnVaArgboCSFBuSFJGB2
 x+A/zO3HYnWEBPbtBkayuHkSmUbSwg0zxmTb3cOs2mnbZ3Z4kYzOZEz9Kd5Z9moCSODI
 2RebQRWwwODr0KugBy2BAS0ZEFobTB7SQ89qt2XHMXMlsXgyULn6YO2qbV4WBFcK+5yp
 lWDFQxGZLfQ8+f09kzdOB5lfPvlzz1gJcbxJpPr8mtz6sutUzlI/LXA6m7nS7iCT3B3Z Yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7f2dsby3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 18:36:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B2Ia8nn022504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 18:36:08 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 2 Dec 2022 10:36:07 -0800
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [RFC 4/4] wifi: mac80211: Handle RU Puncturing information
Date:   Fri, 2 Dec 2022 10:35:54 -0800
Message-ID: <1670006154-6092-5-git-send-email-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E75943Ip1VuEHzExDZTv6YXC3wqoOYPj
X-Proofpoint-ORIG-GUID: E75943Ip1VuEHzExDZTv6YXC3wqoOYPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_10,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=733 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212020147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handle RU Puncturing information received from user space.
RU Puncturing bitmap is initially received during
ieee80211_change_iface() and stored. During AP chanwidth setting,
the bitmap is validated. In addition driver is notified of new bitmap
value.

Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 net/mac80211/cfg.c  |  8 ++++++++
 net/mac80211/chan.c | 14 ++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c848fe04dd44..d82060d8fd4e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -213,6 +213,12 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 	struct sta_info *sta;
 	int ret;
 
+	sdata->vif.bss_conf.ru_punct_bitmap = params->ru_punct_bitmap;
+	sdata->vif.bss_conf.ru_punct_bitmap_supp_he = params->ru_punct_bitmap_supp_he;
+
+	if (!sdata->vif.bss_conf.ru_punct_bitmap)
+		sdata_dbg(sdata, "RU Puncturing Bitmap was not set by user\n");
+
 	ret = ieee80211_if_change_type(sdata, type);
 	if (ret)
 		return ret;
@@ -1251,6 +1257,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	prev_beacon_int = link_conf->beacon_int;
 	link_conf->beacon_int = params->beacon_interval;
 
+	sdata->vif.bss_conf.ru_punct_bitmap = dev->ieee80211_ptr->ru_punct_bitmap;
+
 	if (params->he_cap && params->he_oper) {
 		link_conf->he_support = true;
 		link_conf->htc_trig_based_pkt_ext =
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e72cf0749d49..55a1f8bb309c 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -838,6 +838,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *curr_ctx = NULL;
+	u64 changed;
 	int ret = 0;
 
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_NAN))
@@ -882,8 +883,10 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	}
 
 	if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
-	    sdata->vif.type != NL80211_IFTYPE_MONITOR)
-		ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_IDLE);
+	    sdata->vif.type != NL80211_IFTYPE_MONITOR) {
+		changed |= BSS_CHANGED_IDLE | BSS_CHANGED_EHT_PUNCTURING;
+		ieee80211_vif_cfg_change_notify(sdata, changed);
+	}
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
@@ -1942,6 +1945,13 @@ int ieee80211_link_change_bandwidth(struct ieee80211_link_data *link,
 		goto out;
 	}
 
+	if (!ieee80211_valid_disable_subchannel_bitmap(
+					   &sdata->vif.bss_conf.ru_punct_bitmap,
+					   chandef->width)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	conf = rcu_dereference_protected(link_conf->chanctx_conf,
 					 lockdep_is_held(&local->chanctx_mtx));
 	if (!conf) {
-- 
2.7.4

