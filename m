Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F4A3213E4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 11:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhBVKNS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 05:13:18 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:37048 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhBVKLA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 05:11:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613988658; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=89rkTqf+msjJaSac/yfv4C+6TeGwRKNJeruzXD+KLWw=; b=iOtg3XlPZgdTrLPPHq6vSF2OpDT5f85Ld5rdt2f/Am+6ZN5nNtBOs5wFhs8gIBJGDHjRLu2B
 xFvkDjWYqN4ih2k1gS4d00Oyhon1O0mvkQHkafr9pb6pw9cXpjZtTbRXQcoNK0wTS57hdylv
 Hm0UP4aOmPsiWygXWzy3LSCVnRY=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 603382e8ad2d186f4b7cc9ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 10:09:44
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A16AC43465; Mon, 22 Feb 2021 10:09:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FAC6C43461;
        Mon, 22 Feb 2021 10:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FAC6C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH 1/3] nl80211: Add support for beacon tx mode
Date:   Mon, 22 Feb 2021 15:39:31 +0530
Message-Id: <1613988573-10839-2-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613988573-10839-1-git-send-email-mkenna@codeaurora.org>
References: <1613988573-10839-1-git-send-email-mkenna@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

User can configure the beacon tx mode while bring-up the AP
or MESH. Hence, added the support in the nl80211/cfg80211
layer to honour the beacon tx mode configuration and pass
this value to the driver.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00630-QCAHKSWPL_SILICONZ-2

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 15 +++++++++++++++
 net/wireless/nl80211.c       |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 911fae4..5346569 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1181,6 +1181,7 @@ enum cfg80211_ap_settings_flags {
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
+ * @beacon_tx_mode: Beacon Tx Mode setting
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1213,6 +1214,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
+	enum nl80211_beacon_tx_mode beacon_tx_mode;
 };
 
 /**
@@ -2060,6 +2062,7 @@ struct mesh_config {
  *	to operate on DFS channels.
  * @control_port_over_nl80211: TRUE if userspace expects to exchange control
  *	port frames over NL80211 instead of the network interface.
+ * @beacon_tx_mode: Beacon Tx Mode setting.
  *
  * These parameters are fixed when the mesh is created.
  */
@@ -2083,6 +2086,7 @@ struct mesh_setup {
 	struct cfg80211_bitrate_mask beacon_rate;
 	bool userspace_handles_dfs;
 	bool control_port_over_nl80211;
+	enum nl80211_beacon_tx_mode beacon_tx_mode;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ac78da9..70a76b9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2557,6 +2557,10 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_BEACON_TX_MODE: used to configure the beacon tx mode as
+ *      staggered mode = 1 or burst mode = 2 in %NL80211_CMD_START_AP or
+ *      %NL80211_CMD_JOIN_MESH from user-space.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3054,6 +3058,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_BEACON_TX_MODE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7277,4 +7283,13 @@ enum nl80211_sar_specs_attrs {
 	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
 };
 
+/**
+ * enum nl80211_beacon_tx_mode - Beacon Tx Mode enum.
+ *      Used to configure beacon staggered mode or beacon burst mode.
+ */
+enum nl80211_beacon_tx_mode {
+	NL80211_BEACON_STAGGERED_MODE = 1,
+	NL80211_BEACON_BURST_MODE = 2,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 521d36b..711f2f4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -753,6 +753,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_RECONNECT_REQUESTED] = { .type = NLA_REJECT },
 	[NL80211_ATTR_SAR_SPEC] = NLA_POLICY_NESTED(sar_policy),
 	[NL80211_ATTR_DISABLE_HE] = { .type = NLA_FLAG },
+	[NL80211_ATTR_BEACON_TX_MODE] = NLA_POLICY_RANGE(NLA_U32, 1, 2),
 };
 
 /* policy for the key attributes */
@@ -5324,6 +5325,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	params.dtim_period =
 		nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
 
+	if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
+		params.beacon_tx_mode =
+			nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
+
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params.beacon_interval);
 	if (err)
@@ -11878,6 +11883,10 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
+		setup.beacon_tx_mode =
+			nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
+
 	if (info->attrs[NL80211_ATTR_MESH_SETUP]) {
 		/* parse additional setup parameters if given */
 		err = nl80211_parse_mesh_setup(info, &setup);
-- 
2.7.4

