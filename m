Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6259640D5D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 19:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiLBSgL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 13:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiLBSgK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 13:36:10 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF030ECE72
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 10:36:09 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B2EdBWf012095;
        Fri, 2 Dec 2022 18:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=5tV1fNoPXtkd0Jd2DT4ed4HOcknCcfKgPdFxxQIG6I4=;
 b=pIVNf5GCoxUgD1L+padQt73WjZu5DyGZ8Yn3WcHzaTqnyD4yTqeqlzxy80lvOV7kIq2w
 JkeQ6ETA2oxXq7rcEoghok4iqdN4ak8wE8zXiUt4CuGPYJRvRGK2YTk5vPKCGQR5lwEY
 yhLmhvjqQO4z59Q0unrjT5a41Vh3x2a0bu0NMYa8h811EBv6/BDCL2T2G/1gchnXvtFJ
 EUaQw0GLtYL99pQWUt/INS0ICgSyfff97/txGmOCCOGW79RYCOg5jp3R1agCzjutFyIU
 xM7xlcf2O1RVgIeBvFddg0UbkuXMPTraeBMuDX9TBl8loOXwpNynqETgikNZodYwDZtI kg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m7j3yrwfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 18:36:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B2Ia6iQ014068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 18:36:06 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 2 Dec 2022 10:36:06 -0800
From:   Muna Sinada <quic_msinada@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [RFC 3/4] wifi: nl80211: validate RU puncturing bitmap
Date:   Fri, 2 Dec 2022 10:35:53 -0800
Message-ID: <1670006154-6092-4-git-send-email-quic_msinada@quicinc.com>
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
X-Proofpoint-GUID: L0Mw7G6Iso3ajg_mUQUj2xW2OO8yI9Tv
X-Proofpoint-ORIG-GUID: L0Mw7G6Iso3ajg_mUQUj2xW2OO8yI9Tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_11,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=929 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Aloka Dixit <quic_alokad@quicinc.com>

Add new attributes NL80211_ATTR_RU_PUNCT_BITMAP and
NL80211_ATTR_RU_PUNCT_SUPP_HE to receive RU puncturing information
from the userspace.
- Bitmap consists of 16 bits, each bit corresponding to a 20 MHz
channel in the operating bandwidth. Lowest bit corresponds to
the lowest frequency. Validate the bitmap against the minimum
bandwidth support advertised by the driver.
- HE support flag indicates whether OFDMA puncturing patterns
should be considered during validation.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/uapi/linux/nl80211.h | 10 ++++++++++
 net/wireless/nl80211.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e5218fd7b37b..286579d56809 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2756,6 +2756,14 @@ enum nl80211_commands {
  *	the driver supports preamble puncturing, value should be of type
  *	&enum nl80211_ru_punct_supp_bw
  *
+ * @NL80211_ATTR_RU_PUNCT_SUPP_HE: flag attribute, used to indicate that RU
+ *	puncturing bitmap validation should include OFDMA bitmaps.
+ *
+ * @NL80211_ATTR_RU_PUNCT_BITMAP: (u16) RU puncturing bitmap where the lowest
+ *	bit corresponds to the lowest 20 MHz channel. Each bit set to 1
+ *	indicates that the sub-channel is punctured, set 0 indicates that the
+ *	channel is active.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  *
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3287,6 +3295,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_TD_BITMAP,
 
 	NL80211_ATTR_RU_PUNCT_SUPP_BW,
+	NL80211_ATTR_RU_PUNCT_SUPP_HE,
+	NL80211_ATTR_RU_PUNCT_BITMAP,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4b4cb3c64f62..fd7d83c533a8 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -807,6 +807,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
 	[NL80211_ATTR_RU_PUNCT_SUPP_BW] =
 		NLA_POLICY_MAX(NLA_U8, NL80211_RU_PUNCT_SUPP_BW_320),
+	[NL80211_ATTR_RU_PUNCT_SUPP_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_RU_PUNCT_BITMAP] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -3192,6 +3194,38 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 		wdev->iftype == NL80211_IFTYPE_P2P_GO;
 }
 
+static int nl80211_parse_ru_punct_bitmap(struct cfg80211_registered_device *rdev,
+					 struct net_device *dev,
+					 struct genl_info *info,
+					 struct vif_params *params)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	bool change = false;
+
+	if (info->attrs[NL80211_ATTR_RU_PUNCT_BITMAP]) {
+		params->ru_punct_bitmap =
+			 nla_get_u16(info->attrs[NL80211_ATTR_RU_PUNCT_BITMAP]);
+
+	if (!params->ru_punct_bitmap)
+		return change;
+
+	params->ru_punct_bitmap_supp_he =
+		nla_get_flag(info->attrs[NL80211_ATTR_RU_PUNCT_SUPP_HE]);
+
+	if (!rdev->wiphy.ru_punct_supp_bw &&
+	    (params->ru_punct_bitmap || params->ru_punct_bitmap_supp_he))
+		return -EOPNOTSUPP;
+
+	changed = true;
+
+	wdev_lock(wdev);
+	wdev->ru_punct_bitmap_supp_he = params->ru_punct_bitmap_supp_he;
+	wdev->ru_punct_bitmap = params->ru_punct_bitmap;
+	wdev_unlock(wdev);
+
+	return change ? 1 : 0;
+}
+
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct genl_info *info,
 			  struct cfg80211_chan_def *chandef)
@@ -4175,6 +4209,12 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 		params.use_4addr = -1;
 	}
 
+	err = nl80211_parse_ru_punct_bitmap(rdev, dev, info, &params);
+	if (err < 0)
+		return err;
+	else if (err > 0)
+		change = true;
+
 	err = nl80211_parse_mon_options(rdev, ntype, info, &params);
 	if (err < 0)
 		return err;
-- 
2.7.4

