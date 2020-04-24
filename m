Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1E1B821D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 00:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDXWmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 18:42:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50737 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgDXWmZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 18:42:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587768144; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: References: In-Reply-To: Message-Id: Date: Subject: Cc:
 To: From: Sender; bh=Ud4IRT+9i8LHGRxXpAfqoe6+NfU7RgpuvE0e5HXjY1k=; b=pFAUYPe2cRMlfQhhJFLPPccQ9U4kQjFG+xJr6Vaez/evsQ+8GLYrIKWf42bEnjU1Jr0LFuAd
 WRHm5Oh04AklB/QfHnD7XMeR9srWJBZCVFPj2kuAc+yJ/AMDeO5Pv0VCo/J8lk+st7jBusLA
 CPyVjF0V7npKAw59esEB3d7IhmY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea36b48.7f25792de4c8-smtp-out-n01;
 Fri, 24 Apr 2020 22:42:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83706C433BA; Fri, 24 Apr 2020 22:42:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CABAEC433F2;
        Fri, 24 Apr 2020 22:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CABAEC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH 03/10] nl80211: add HE 6 GHz Band Capability support
Date:   Fri, 24 Apr 2020 15:41:41 -0700
Message-Id: <1587768108-25248-4-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define new structures for HE 6 GHz band capabilities as per

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/linux/ieee80211.h    | 57 ++++++++++++++++++++++++++++++++++++++++++++
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  6 +++++
 net/wireless/nl80211.c       | 14 +++++++++++
 4 files changed, 79 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 16268ef1cbcc..77462dff6db3 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1632,6 +1632,44 @@ struct ieee80211_he_mcs_nss_supp {
 } __packed;
 
 /**
+ * enum ieee80211_he_6ghz_chanwidth - HE 6 GHz channel width
+ * @IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ: 20 MHz bandwidth
+ * @IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ: 40 MHz bandwidth
+ * @IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ: 80 MHz bandwidth
+ * @IEEE80211_HE_6GHZ_CHANWIDTH_80P80MHZ: 160 or 80+80 MHz bandwidth
+ */
+enum ieee80211_he_6ghz_chanwidth {
+	IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ		= 0,
+	IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ		= 1,
+	IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ		= 2,
+	IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ	= 3,
+};
+
+/**
+ * struct ieee80211_he_oper_6ghz_op_info - 6 GHz Operation Information
+ *
+ * This structure is defined as described in IEEE P802.11ax/D6.0,
+ * Figure 9-787k—6 GHz Operation Information field.
+ *
+ * @primary_chan: The channel number of the primary channel in the 6 GHz band.
+ * @control: First two bits defines channel width field indicates the BSS
+ *	channel width and is set to 0 for 20 MHz, 1 for 40 MHz, 2 for 80 MHz,
+ *	and 3 for 80+80 or 160 MHz.
+ * @center_freq_seg0_idx: Channel center frequency index for the 20 MHz,
+ *	40 MHz, or 80 MHz, or 80+80 MHz.
+ * @center_freq_seg1_idx: Channel center frequency index of the 160 MHz.
+ * @min_rate: Minimum rate, in units of 1 Mb/s, that the non-AP STA is allowed
+ *	to use for sending PPDUs.
+ */
+struct ieee80211_he_oper_6ghz_op_info {
+	u8 primary_chan;
+	u8 control;
+	u8 center_freq_seg0_idx;
+	u8 center_freq_seg1_idx;
+	u8 min_rate;
+} __packed;
+
+/**
  * struct ieee80211_he_operation - HE capabilities element
  *
  * This structure is the "HE operation element" fields as
@@ -1682,6 +1720,15 @@ struct ieee80211_mu_edca_param_set {
 	struct ieee80211_he_mu_edca_param_ac_rec ac_vo;
 } __packed;
 
+/**
+ * struct ieee80211_he_6ghz_band_cap - HE 6 GHz Band Capabilities element
+ *
+ * This structure is defined as described in IEEE P802.11ax/D6.0, 9.4.2.261.
+ */
+struct ieee80211_he_6ghz_band_cap {
+	__le16 capab;
+} __packed;
+
 /* 802.11ac VHT Capabilities */
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991			0x00000001
@@ -1982,6 +2029,15 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_TX_RX_MCS_NSS_SUPP_TX_BITMAP_MASK			0x07c0
 #define IEEE80211_TX_RX_MCS_NSS_SUPP_RX_BITMAP_MASK			0xf800
 
+/* 802.11ax HE 6 GHz Band Capability */
+#define IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START_SPACE_MASK		GENMASK(2, 0)
+#define IEEE80211_HE_6GHZ_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK	GENMASK(5, 3)
+#define IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LENGTH_MASK		GENMASK(7, 6)
+#define IEEE80211_HE_6GHZ_CAP_SMPS_MASK				GENMASK(10, 9)
+#define IEEE80211_HE_6GHZ_CAP_RD_RESP				BIT(11)
+#define IEEE80211_HE_6GHZ_CAP_RX_ANTENNA_PATTERN		BIT(12)
+#define IEEE80211_HE_6GHZ_CAP_TX_ANTENNA_PATTERN		BIT(13)
+
 /* TX/RX HE MCS Support field Highest MCS subfield encoding */
 enum ieee80211_he_highest_mcs_supported_subfield_enc {
 	HIGHEST_MCS_SUPPORTED_MCS7 = 0,
@@ -2059,6 +2115,7 @@ ieee80211_he_ppe_size(u8 ppe_thres_hdr, const u8 *phy_cap_info)
 #define IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET			24
 #define IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR		0x40000000
 #define IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED		0x80000000
+#define IEEE80211_HE_OPERATION_6GHZ_OP_INFO_CTRL_CHAN_WIDTH	0x3
 
 /*
  * ieee80211_he_oper_size - calculate 802.11ax HE Operations IE size
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 13d3d8f92c99..bb5c3e2ec96c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1239,6 +1239,7 @@ struct sta_txpwr {
  * @he_capa_len: the length of the HE capabilities
  * @airtime_weight: airtime scheduler weight for this station
  * @txpwr: transmit power for an associated station
+ * @he_6ghz_cap: HE 6 GHz Band capabilities of station
  */
 struct station_parameters {
 	const u8 *supported_rates;
@@ -1271,6 +1272,7 @@ struct station_parameters {
 	u8 he_capa_len;
 	u16 airtime_weight;
 	struct sta_txpwr txpwr;
+	const struct ieee80211_he_6ghz_band_cap *he_6ghz_capa;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2b691161830f..9c0a912f1684 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2470,6 +2470,9 @@ enum nl80211_commands {
  *	no roaming occurs between the reauth threshold and PMK expiration,
  *	disassociation is still forced.
  *
+ * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
+ *	association request when used with NL80211_CMD_NEW_STATION).
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2945,6 +2948,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_PMK_LIFETIME,
 	NL80211_ATTR_PMK_REAUTH_THRESHOLD,
 
+	NL80211_ATTR_HE_6GHZ_CAPABILITY,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -2998,6 +3003,7 @@ enum nl80211_attrs {
 #define NL80211_HE_MAX_CAPABILITY_LEN           54
 #define NL80211_MAX_NR_CIPHER_SUITES		5
 #define NL80211_MAX_NR_AKM_SUITES		2
+#define NL80211_HE_6GHZ_CAPABILITY_LEN		2
 
 #define NL80211_MIN_REMAIN_ON_CHANNEL_TIME	10
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 692bcd35f809..fd1aa70d1f5c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -661,6 +661,10 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH] = { .type = NLA_FLAG },
 	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
+	[NL80211_ATTR_HE_6GHZ_CAPABILITY] = {
+		.type = NLA_EXACT_LEN_WARN,
+		.len = NL80211_HE_6GHZ_CAPABILITY_LEN,
+	},
 };
 
 /* policy for the key attributes */
@@ -6129,6 +6133,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
+		params.he_6ghz_capa =
+			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
+
 	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
 		params.opmode_notif_used = true;
 		params.opmode_notif =
@@ -6177,6 +6185,12 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
+	if (params.he_6ghz_capa) {
+		params.ht_capa = NULL;
+		params.vht_capa = NULL;
+	}
+
 	/* When you run into this, adjust the code below for the new flag */
 	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 7);
 
-- 
2.7.4
