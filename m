Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3C685FD0
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Feb 2023 07:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjBAGe3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Feb 2023 01:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjBAGe1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Feb 2023 01:34:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C79E5357A
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 22:34:26 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3115juc2017294;
        Wed, 1 Feb 2023 06:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=M366HwuphEn6XqbknvbhbZfdfjn9c1C/XPeCWaxT5FQ=;
 b=TWDE72+pOD2OuqYKH+OpPLGBFD5P6ti/y5A/GX5sOjc00LVDNcoDT5fpZDRqnoTD7V5P
 uUZKqJE5zgsK5+STTAh7O2M/8tJD8l7onocaRrVaJ5f7L3QkC3MeeW/QvMCn9yaOzmaP
 aSLuyM8IngWlhz9hYe6yVm2FlFB0X6lNoN0fSyx2yZDcM/LPZvJ7/JAPFEvlAF1KrEE2
 JXB+96LfjVIGx7RO85uBSVyHLvMsh3F25vb06qU3V2OsCv9WQIrj74scOcJycQBD1e4F
 /PokgJtqa0+6CxyYQhTMVHxAdE7g8RalcrejOi+NfQPXGqkSkgQrRkPOsdpnWFKUNoy1 Dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3neua9bc9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 06:34:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3116Y1F6030058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 06:34:01 GMT
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 22:33:59 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 1/3] wifi: cfg80211: add support to enable/disable bss color collision detection
Date:   Wed, 1 Feb 2023 12:03:31 +0530
Message-ID: <20230201063333.11747-2-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230201063333.11747-1-quic_ramess@quicinc.com>
References: <20230201063333.11747-1-quic_ramess@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KeLC2QwSCdgn1m53NFHQayKYbZmtaxJD
X-Proofpoint-ORIG-GUID: KeLC2QwSCdgn1m53NFHQayKYbZmtaxJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010056
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
 net/wireless/nl80211.c       | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 54a77d906b2d..c4c84ccf8e20 100644
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
index 8ecb0fbee721..a6068cdabf25 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7442,6 +7442,8 @@ enum nl80211_obss_pd_attributes {
  * @NL80211_HE_BSS_COLOR_ATTR_COLOR: the current BSS Color.
  * @NL80211_HE_BSS_COLOR_ATTR_DISABLED: is BSS coloring disabled.
  * @NL80211_HE_BSS_COLOR_ATTR_PARTIAL: the AID equation to be used..
+ * @NL80211_HE_BSS_COLOR_ATTR_COLLISION_DETECTION_DISABLED: is BSS
+ * color collision detection disabled.
  *
  * @__NL80211_HE_BSS_COLOR_ATTR_LAST: Internal
  * @NL80211_HE_BSS_COLOR_ATTR_MAX: highest BSS Color attribute.
@@ -7452,6 +7454,7 @@ enum nl80211_bss_color_attributes {
 	NL80211_HE_BSS_COLOR_ATTR_COLOR,
 	NL80211_HE_BSS_COLOR_ATTR_DISABLED,
 	NL80211_HE_BSS_COLOR_ATTR_PARTIAL,
+	NL80211_HE_BSS_COLOR_ATTR_COLLISION_DETECTION_DISABLED,
 
 	/* keep last */
 	__NL80211_HE_BSS_COLOR_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 64cf6110ce9d..ed344731e80e 100644
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
-- 
2.17.1

