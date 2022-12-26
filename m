Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6A65611D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Dec 2022 09:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiLZId7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Dec 2022 03:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiLZIdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Dec 2022 03:33:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC126C2
        for <linux-wireless@vger.kernel.org>; Mon, 26 Dec 2022 00:33:54 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQ8VS1j029110;
        Mon, 26 Dec 2022 08:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=G4+f1d2p2Q0yYCIS0hmFUTOMnQp8l1+adDjrcfGoEhc=;
 b=E0BnIWFC4SZ+J3kjX7NQ7hxtNFm2GfXhCOb/LgXhsp/Kc6I/8aB53gRDEzjHWJGBMhBc
 aVRmnY7nfciZ0J3acoqi2vgf1NMwvjLZSnTo/hJsOBlqlfKYFHul5J+Y6R69A7TWLL66
 1UlmYrjVxT+y1q5om8u7hkc8OUK2GZF/7K/+DXUywae9e6g9KWMhZngpqTjMRNxNHTq7
 dcg3EgfGRboycAYustzhr9S8i/LIgkgOQ4s/JG1BbpszJCACFb5ddA7MaYkzNd+IqLTH
 Vj3j4M8kxWsO6+iHTupctih1TEW4PYFIHBKaJcc+CC2TesIsf/0/iKAkm5E8gBHrMmJ7 Bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mns18305a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 08:33:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BQ8XiJ6007187
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 08:33:44 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 26 Dec 2022 00:33:42 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH 1/2] nl80211: add support to enable/disable bss color collision detection
Date:   Mon, 26 Dec 2022 14:03:27 +0530
Message-ID: <20221226083328.29051-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221226083328.29051-1-quic_ramess@quicinc.com>
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZQDlJX1MciB78ap_zda4Miz3_wH6cYbS
X-Proofpoint-GUID: ZQDlJX1MciB78ap_zda4Miz3_wH6cYbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_04,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212260074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As per 802.11ax-2021, STAs shall process BSS Color Change Announcement
(BCCA) from AP and switch to new color, but some STAs aren't processing
BCCA from AP and not doing color switch, causing them to drop data
frames from AP post color change.

Provide an option to disable color collision detection and therefore
not to do BCCA to mitigate the same from AP. If it's required in case
where STA supports BCCA handling, then it can enabled in AP using this
option.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 3 +++
 net/mac80211/rx.c            | 3 ++-
 net/wireless/nl80211.c       | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 03d4f4deadae..153a05a25d91 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -304,11 +304,13 @@ struct ieee80211_he_obss_pd {
  * @color: the current color.
  * @enabled: HE BSS color is used
  * @partial: define the AID equation.
+ * @collision_detection_enabled: HE BSS color collision detection is enabled.
  */
 struct cfg80211_he_bss_color {
 	u8 color;
 	bool enabled;
 	bool partial;
+	bool collision_detection_enabled;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14a91bbca7c..ec514669d203 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7440,6 +7440,8 @@ enum nl80211_obss_pd_attributes {
  * @NL80211_HE_BSS_COLOR_ATTR_COLOR: the current BSS Color.
  * @NL80211_HE_BSS_COLOR_ATTR_DISABLED: is BSS coloring disabled.
  * @NL80211_HE_BSS_COLOR_ATTR_PARTIAL: the AID equation to be used..
+ * @NL80211_HE_BSS_COLOR_ATTR_COLLISION_DETECTION_DISABLED: is BSS
+ * color collision detection disabled.
  *
  * @__NL80211_HE_BSS_COLOR_ATTR_LAST: Internal
  * @NL80211_HE_BSS_COLOR_ATTR_MAX: highest BSS Color attribute.
@@ -7450,6 +7452,7 @@ enum nl80211_bss_color_attributes {
 	NL80211_HE_BSS_COLOR_ATTR_COLOR,
 	NL80211_HE_BSS_COLOR_ATTR_DISABLED,
 	NL80211_HE_BSS_COLOR_ATTR_PARTIAL,
+	NL80211_HE_BSS_COLOR_ATTR_COLLISION_DETECTION_DISABLED,
 
 	/* keep last */
 	__NL80211_HE_BSS_COLOR_ATTR_LAST,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7e3ab6e1b28f..382f467f0e31 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3195,7 +3195,8 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 	if (ieee80211_hw_check(&rx->local->hw, DETECTS_COLOR_COLLISION))
 		return;
 
-	if (rx->sdata->vif.bss_conf.csa_active)
+	if (rx->sdata->vif.bss_conf.csa_active ||
+	    !rx->sdata->vif.bss_conf.he_bss_color.collision_detection_enabled)
 		return;
 
 	baselen = mgmt->u.beacon.variable - rx->skb->data;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33a82ecab9d5..8db437995e53 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -377,6 +377,7 @@ he_bss_color_policy[NL80211_HE_BSS_COLOR_ATTR_MAX + 1] = {
 	[NL80211_HE_BSS_COLOR_ATTR_COLOR] = NLA_POLICY_RANGE(NLA_U8, 1, 63),
 	[NL80211_HE_BSS_COLOR_ATTR_DISABLED] = { .type = NLA_FLAG },
 	[NL80211_HE_BSS_COLOR_ATTR_PARTIAL] = { .type = NLA_FLAG },
+	[NL80211_HE_BSS_COLOR_ATTR_COLLISION_DETECTION_DISABLED] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy nl80211_txattr_policy[NL80211_TXRATE_MAX + 1] = {
@@ -5414,6 +5415,8 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_DISABLED]);
 	he_bss_color->partial =
 		nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_PARTIAL]);
+	he_bss_color->collision_detection_enabled =
+		!nla_get_flag(tb[NL80211_HE_BSS_COLOR_ATTR_COLLISION_DETECTION_DISABLED]);
 
 	return 0;
 }

base-commit: 44bacbdf9066c590423259dbd6d520baac99c1a8
-- 
2.17.1

