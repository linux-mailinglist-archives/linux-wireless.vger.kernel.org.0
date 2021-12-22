Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335A647CEBE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 10:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhLVJFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 04:05:53 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34981 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239681AbhLVJFw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 04:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640163952; x=1671699952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BOBKcTa+bHYlARGQNS0zVx10bMD1TK7KWSV1WAgO+Dc=;
  b=adTMiqSRpG72vGlcNwTa9g2VnZedLr3Duttgh/v4nxrgPY05IyLYb+OV
   B9a/wRw+UrP/FfG8SFXGNdebED3Mao9czipaR9JjRtwfEDfQJHABwGfDT
   Y3+D9Ipo5x51c0JDAv8moN6pkBeisfJ3P+oDVkLjW5roF4tcbreYLOIVA
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Dec 2021 01:05:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:05:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:51 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 01:05:48 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vikram@quicinc.com>,
        <quic_alokad@quicinc.com>, <quic_jiad@quicinc.com>,
        <quic_periyasa@quicinc.com>, <quic_msinada@quicinc.com>,
        <quic_srirrama@quicinc.com>
Subject: [PATCH 5/6] nl80211: add support for 320MHz channel limitation
Date:   Wed, 22 Dec 2021 14:34:42 +0530
Message-ID: <1640163883-12696-6-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <quic_srirrama@quicinc.com>

Add support to advertise drivers or regulatory limitations on 320 MHz
channels to userspace.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-authored-by: Karthikeyan Periyasamy <quic_periyasia@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasia@quicinc.com>
Co-authored-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 include/uapi/linux/nl80211.h | 5 +++++
 net/wireless/nl80211.c       | 3 +++
 net/wireless/reg.c           | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e4ac7ab..b985cb0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3942,6 +3942,8 @@ enum nl80211_wmm_rule {
  *	on this channel in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_16MHZ: 16 MHz operation is allowed
  *	on this channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_NO_320MHZ: any 320 MHz channel using this channel
+ *	as the primary or any of the secondary channels isn't possible
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -3978,6 +3980,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_4MHZ,
 	NL80211_FREQUENCY_ATTR_8MHZ,
 	NL80211_FREQUENCY_ATTR_16MHZ,
+	NL80211_FREQUENCY_ATTR_NO_320MHZ,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4176,6 +4179,7 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
  * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
  * @NL80211_RRF_NO_HE: HE operation not allowed
+ * @NL80211_RRF_NO_320MHZ: 320MHz operation not allowed
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4194,6 +4198,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_80MHZ		= 1<<15,
 	NL80211_RRF_NO_160MHZ		= 1<<16,
 	NL80211_RRF_NO_HE		= 1<<17,
+	NL80211_RRF_NO_320MHZ		= 1<<18,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index dba4002..f31a464 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1152,6 +1152,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_16MHZ) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_16MHZ))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_NO_320MHZ) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_320MHZ))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index ec25924..c76cd97 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1238,6 +1238,8 @@ unsigned int reg_get_max_bandwidth(const struct ieee80211_regdomain *rd,
 {
 	unsigned int bw = reg_get_max_bandwidth_from_range(rd, rule);
 
+	if (rule->flags & NL80211_RRF_NO_320MHZ)
+		bw = min_t(unsigned int, bw, MHZ_TO_KHZ(160));
 	if (rule->flags & NL80211_RRF_NO_160MHZ)
 		bw = min_t(unsigned int, bw, MHZ_TO_KHZ(80));
 	if (rule->flags & NL80211_RRF_NO_80MHZ)
@@ -1611,6 +1613,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_160MHZ;
 	if (rd_flags & NL80211_RRF_NO_HE)
 		channel_flags |= IEEE80211_CHAN_NO_HE;
+	if (rd_flags & NL80211_RRF_NO_320MHZ)
+		channel_flags |= IEEE80211_CHAN_NO_320MHZ;
 	return channel_flags;
 }
 
@@ -1773,6 +1777,8 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 			bw_flags |= IEEE80211_CHAN_NO_80MHZ;
 		if (max_bandwidth_khz < MHZ_TO_KHZ(160))
 			bw_flags |= IEEE80211_CHAN_NO_160MHZ;
+		if (max_bandwidth_khz < MHZ_TO_KHZ(320))
+			bw_flags |= IEEE80211_CHAN_NO_320MHZ;
 	}
 	return bw_flags;
 }
-- 
2.7.4

