Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2113B4B5DA6
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Feb 2022 23:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiBNWbU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Feb 2022 17:31:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiBNWbR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Feb 2022 17:31:17 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB8F70DB
        for <linux-wireless@vger.kernel.org>; Mon, 14 Feb 2022 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644877869; x=1676413869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HiapnwOFBt/dZtzTSGiVoojDoOVJahSpERDOiy5mTBo=;
  b=CQHFDpRZRb0EbQwQ1wAAaSyvguR2qHkFGdHlo3sQxmtWvRfN/nl7Tj1W
   LkGgX/wGEImkdHpXwqRygrBJzwIZJuuDdlse5AJ2GfL69/B0Tr4Xx3q1L
   HhhPJvz1i4ATcDClAf8gRqydGzVSFMoGqONNp+ghLbpmVH9GtSVxZhX8v
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Feb 2022 14:31:07 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:31:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 14:31:05 -0800
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 14:31:04 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 3/3] nl80211: validate RU puncturing bitmap
Date:   Mon, 14 Feb 2022 14:30:51 -0800
Message-ID: <20220214223051.3610-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214223051.3610-1-quic_alokad@quicinc.com>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
---
 include/uapi/linux/nl80211.h | 10 ++++++++
 net/wireless/nl80211.c       | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b4849afede98..1cccc1e8dc29 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2667,6 +2667,14 @@ enum nl80211_commands {
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
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3180,6 +3188,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_EHT_CAPABILITY,
 
 	NL80211_ATTR_RU_PUNCT_SUPP_BW,
+	NL80211_ATTR_RU_PUNCT_SUPP_HE,
+	NL80211_ATTR_RU_PUNCT_BITMAP,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3b244b96d15f..720e53917013 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -784,6 +784,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
 	[NL80211_ATTR_RU_PUNCT_SUPP_BW] =
 		NLA_POLICY_MAX(NLA_U8, NL80211_RU_PUNCT_SUPP_BW_320),
+	[NL80211_ATTR_RU_PUNCT_SUPP_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_RU_PUNCT_BITMAP] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -3117,6 +3119,46 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 		wdev->iftype == NL80211_IFTYPE_P2P_GO;
 }
 
+static int nl80211_parse_ru_punct_bitmap(struct cfg80211_registered_device *rdev,
+					 struct genl_info *info,
+					 struct cfg80211_chan_def *chandef)
+{
+	chandef->ru_punct_bitmap_supp_he =
+		nla_get_flag(info->attrs[NL80211_ATTR_RU_PUNCT_SUPP_HE]);
+
+	chandef->ru_punct_bitmap =
+		nla_get_u16(info->attrs[NL80211_ATTR_RU_PUNCT_BITMAP]);
+
+	if (!chandef->ru_punct_bitmap)
+		return 0;
+
+	if (!rdev->wiphy.ru_punct_supp_bw &&
+	    (chandef->ru_punct_bitmap || chandef->ru_punct_bitmap_supp_he))
+		return -EOPNOTSUPP;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_80:
+		if (rdev->wiphy.ru_punct_supp_bw >=
+		    NL80211_RU_PUNCT_SUPP_BW_160)
+			return -EOPNOTSUPP;
+		break;
+
+	case NL80211_CHAN_WIDTH_160:
+		if (rdev->wiphy.ru_punct_supp_bw >=
+		    NL80211_RU_PUNCT_SUPP_BW_320)
+			return -EOPNOTSUPP;
+		break;
+
+	case NL80211_CHAN_WIDTH_320:
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct genl_info *info,
 			  struct cfg80211_chan_def *chandef)
@@ -3124,6 +3166,7 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **attrs = info->attrs;
 	u32 control_freq;
+	int err;
 
 	if (!attrs[NL80211_ATTR_WIPHY_FREQ])
 		return -EINVAL;
@@ -3230,6 +3273,12 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (info->attrs[NL80211_ATTR_RU_PUNCT_BITMAP]) {
+		err = nl80211_parse_ru_punct_bitmap(rdev, info, chandef);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
2.31.1

