Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F994E5905
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 20:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiCWTSl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiCWTSk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 15:18:40 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488638931C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648063030; x=1679599030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qQ2wmMHkn50+08badrFPHnuprRjtsCv9iwsiTcYjuWY=;
  b=rcOB7+qaUdqGMmWWMcp3NPlVl34H61mJ2+PStfUvAZ3mGaGfgCnsFd9y
   kuslK0uLzRiz4WP5d3YXCzzqvzEys2Xxh/hHDfXML0UovdTpKlSq6b47K
   OBdc5FR2lQWFgUQs8MsD+ln5lkJs2cZMVBxzoFhM8QpQa+uoU14Mfk1r7
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 12:17:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 12:17:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 12:16:53 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 12:16:52 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v2 3/4] nl80211: validate RU puncturing bitmap
Date:   Wed, 23 Mar 2022 12:16:39 -0700
Message-ID: <20220323191640.31230-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220323191640.31230-1-quic_alokad@quicinc.com>
References: <20220323191640.31230-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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
 include/uapi/linux/nl80211.h | 20 +++++++++++++++
 net/wireless/nl80211.c       | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index bdd2cb22b5a0..e8b9f07cdd38 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1469,6 +1469,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_SAR_SPECS,
 
+	NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS,
+
 	NL80211_CMD_OBSS_COLOR_COLLISION,
 
 	NL80211_CMD_COLOR_CHANGE_REQUEST,
@@ -1477,6 +1479,8 @@ enum nl80211_commands {
 	NL80211_CMD_COLOR_CHANGE_ABORTED,
 	NL80211_CMD_COLOR_CHANGE_COMPLETED,
 
+	NL80211_CMD_AWGN_DETECT,
+
 	NL80211_CMD_SET_FILS_AAD,
 
 	NL80211_CMD_ASSOC_COMEBACK,
@@ -2667,6 +2671,14 @@ enum nl80211_commands {
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
@@ -3164,6 +3176,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_HE_MUEDCA_PARAMS,
+
 	NL80211_ATTR_OBSS_COLOR_BITMAP,
 
 	NL80211_ATTR_COLOR_CHANGE_COUNT,
@@ -3180,6 +3194,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_EHT_CAPABILITY,
 
 	NL80211_ATTR_RU_PUNCT_SUPP_BW,
+	NL80211_ATTR_RU_PUNCT_SUPP_HE,
+	NL80211_ATTR_RU_PUNCT_BITMAP,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -4170,6 +4186,10 @@ enum nl80211_reg_rule_attr {
 
 	NL80211_ATTR_DFS_CAC_TIME,
 
+	NL80211_ATTR_POWER_RULE_PSD,
+
+	NL80211_ATTR_REG_POWER_MODE,
+
 	/* keep last */
 	__NL80211_REG_RULE_ATTR_AFTER_LAST,
 	NL80211_REG_RULE_ATTR_MAX = __NL80211_REG_RULE_ATTR_AFTER_LAST - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1fbfda2b3b14..e3a7a94d89ca 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -792,6 +792,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
 	[NL80211_ATTR_RU_PUNCT_SUPP_BW] =
 		NLA_POLICY_MAX(NLA_U8, NL80211_RU_PUNCT_SUPP_BW_320),
+	[NL80211_ATTR_RU_PUNCT_SUPP_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_RU_PUNCT_BITMAP] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -3122,6 +3124,46 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
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
@@ -3129,6 +3171,7 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **attrs = info->attrs;
 	u32 control_freq;
+	int err;
 
 	if (!attrs[NL80211_ATTR_WIPHY_FREQ])
 		return -EINVAL;
@@ -3205,6 +3248,12 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 				nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ2]);
 	}
 
+	if (info->attrs[NL80211_ATTR_RU_PUNCT_BITMAP]) {
+		err = nl80211_parse_ru_punct_bitmap(rdev, info, chandef);
+		if (err)
+			return err;
+	}
+
 	if (info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]) {
 		chandef->edmg.channels =
 		      nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]);
-- 
2.31.1

