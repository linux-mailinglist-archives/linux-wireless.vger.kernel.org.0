Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11731DF1B8
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgEVWTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 18:19:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:45962 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731062AbgEVWTd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 18:19:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590185971; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lueVwvkjcitjd+UnvDkTHapKJExsfXEoI9EqWO+FqZk=; b=QwFCdiwAZan9dqZ4S1YbupolvF9uCVHBY0oVme0A/TM2E2q1wV+F3mG8ECS4zA5X319qYPsL
 JBqwQCCjY84TJ1UTdCTD8vCmEowFo37QjHF057S/8sgbM1KcpbQaqY9G5lNW/arFQDp0VGFv
 SJIt842BOxAzjF0j2iT6wdCLZG8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ec84ff262ee3a3497dd1d54 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 22:19:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8895C433C8; Fri, 22 May 2020 22:19:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B7FEC433CA;
        Fri, 22 May 2020 22:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B7FEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=alokad@codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH 1/2] nl80211: FILS discovery/bcast probe resp support
Date:   Fri, 22 May 2020 15:19:20 -0700
Message-Id: <20200522221921.19347-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522221921.19347-1-alokad@codeaurora.org>
References: <20200522221921.19347-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds new attribute, NL80211_ATTR_FD_BCASTPRESP_CFG
to configure FILS discovery and broadcast probe response in 6GHz
for in-band discovery.

Only one of the two is active at a time to reduce broadcast
packets over the air.

Maximum packet interval can be 20 TUs.
Packet interval set to 0 disables FILS discovery and broadcast
probe response transmission.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
 include/net/cfg80211.h       | 26 ++++++++++++++++
 include/uapi/linux/nl80211.h | 27 +++++++++++++++++
 net/wireless/nl80211.c       | 58 ++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a82fc59a1d82..e4bc03947005 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -957,6 +957,8 @@ struct cfg80211_crypto_settings {
  * @assocresp_ies_len: length of assocresp_ies in octets
  * @probe_resp_len: length of probe response template (@probe_resp)
  * @probe_resp: probe response template (AP mode only)
+ * @bcast_presp: Broadcast probe response template (AP mode only)
+ * @fils_disc: FILS discovery template (AP mode only)
  * @ftm_responder: enable FTM responder functionality; -1 for no change
  *	(which also implies no change in LCI/civic location data)
  * @lci: Measurement Report element content, starting with Measurement Token
@@ -965,6 +967,8 @@ struct cfg80211_crypto_settings {
  *	Token (measurement type 11)
  * @lci_len: LCI data length
  * @civicloc_len: Civic location data length
+ * @bcast_presp_len: Broadcast probe response template length
+ * @fils_disc_len: FILS discovery template length
  */
 struct cfg80211_beacon_data {
 	const u8 *head, *tail;
@@ -974,6 +978,8 @@ struct cfg80211_beacon_data {
 	const u8 *probe_resp;
 	const u8 *lci;
 	const u8 *civicloc;
+	const u8 *bcast_presp;
+	const u8 *fils_disc;
 	s8 ftm_responder;
 
 	size_t head_len, tail_len;
@@ -983,6 +989,8 @@ struct cfg80211_beacon_data {
 	size_t probe_resp_len;
 	size_t lci_len;
 	size_t civicloc_len;
+	size_t bcast_presp_len;
+	size_t fils_disc_len;
 };
 
 struct mac_address {
@@ -1017,6 +1025,22 @@ struct cfg80211_bitrate_mask {
 	} control[NUM_NL80211_BANDS];
 };
 
+enum cfg80211_fd_bcastpresp_types {
+	CFG80211_TYPE_FILS_DISCOVERY = 1,
+	CFG80211_TYPE_BCAST_PROBE_RESP
+};
+
+/**
+ * struct cfg80211_fd_bcastpresp - FILS discovery/bcast probe response config
+ *
+ * @type: CFG80211_TYPE_FILS_DISCOVERY/CFG80211_TYPE_BCAST_PROBE_RESP
+ * @interval: FILS discovery/broadcast probe response interval in TUs
+ */
+struct cfg80211_fd_bcastpresp {
+	enum cfg80211_fd_bcastpresp_types type;
+	u32 interval;
+};
+
 /**
  * enum cfg80211_ap_settings_flags - AP settings flags
  *
@@ -1064,6 +1088,7 @@ enum cfg80211_ap_settings_flags {
  * @he_obss_pd: OBSS Packet Detection settings
  * @he_bss_color: BSS Color settings
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
+ * @fd_bcastpresp: FILS discovery and broadcast probe response configuration
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1094,6 +1119,7 @@ struct cfg80211_ap_settings {
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct cfg80211_fd_bcastpresp fd_bcastpresp;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9679d561f7d0..3d7bb5c61002 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2484,6 +2484,8 @@ enum nl80211_commands {
  * @NL80211_ATTR_RECEIVE_MULTICAST: multicast flag for the
  *	%NL80211_CMD_REGISTER_FRAME command, see the description there.
  *
+ * @NL80211_ATTR_FD_BCASTPRESP_CFG: FILS discovery/broadcast probe resp.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2961,6 +2963,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_RECEIVE_MULTICAST,
 
+	NL80211_ATTR_FD_BCASTPRESP_CFG,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6848,4 +6852,27 @@ enum nl80211_iftype_akm_attributes {
 	NL80211_IFTYPE_AKM_ATTR_MAX = __NL80211_IFTYPE_AKM_ATTR_LAST - 1,
 };
 
+/**
+ * enum nl80211_fd_bcastpresp_attributes - FILS disc/bcast probe resp settings
+ * @__NL80211_FD_BCASTPRESP_ATTR_INVALID: Invalid
+ *
+ * @NL80211_FD_BCASTPRESP_ATTR_TYPE: 1-FILS discovery, 2-broadcast probe resp
+ * @NL80211_FD_BCASTPRESP_ATTR_INT: FILS disc/bcast probe resp interval in TUs
+ * @NL80211_FD_BCASTPRESP_ATTR_TMPL: FILS discovery/bcast probe resp template
+ *
+ * @__NL80211_FD_BCASTPRESP_ATTR_LAST: Internal
+ * @NL80211_FD_BCASTPRESP_ATTR_MAX: highest FD/bcast probe resp attribute
+ */
+enum nl80211_fd_bcastpresp_attributes {
+	__NL80211_FD_BCASTPRESP_ATTR_INVALID,
+
+	NL80211_FD_BCASTPRESP_ATTR_TYPE,
+	NL80211_FD_BCASTPRESP_ATTR_INT,
+	NL80211_FD_BCASTPRESP_ATTR_TMPL,
+
+	/* keep last */
+	__NL80211_FD_BCASTPRESP_ATTR_LAST,
+	NL80211_FD_BCASTPRESP_ATTR_MAX = __NL80211_FD_BCASTPRESP_ATTR_LAST - 1
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3d27b24c68b2..da61344c8ca3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -331,6 +331,14 @@ he_bss_color_policy[NL80211_HE_BSS_COLOR_ATTR_MAX + 1] = {
 	[NL80211_HE_BSS_COLOR_ATTR_PARTIAL] = { .type = NLA_FLAG },
 };
 
+static const struct nla_policy
+fd_bcastpresp_policy[NL80211_FD_BCASTPRESP_ATTR_MAX + 1] = {
+	[NL80211_FD_BCASTPRESP_ATTR_TYPE] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
+	[NL80211_FD_BCASTPRESP_ATTR_INT] = NLA_POLICY_MAX(NLA_U32, 20),
+	[NL80211_FD_BCASTPRESP_ATTR_TMPL] = { .type = NLA_BINARY,
+					      .len = IEEE80211_MAX_DATA_LEN },
+};
+
 static const struct nla_policy
 nl80211_tid_config_attr_policy[NL80211_TID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_TID_CONFIG_ATTR_VIF_SUPP] = { .type = NLA_U64 },
@@ -662,6 +670,8 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
 	[NL80211_ATTR_RECEIVE_MULTICAST] = { .type = NLA_FLAG },
+	[NL80211_ATTR_FD_BCASTPRESP_CFG] =
+				NLA_POLICY_NESTED(fd_bcastpresp_policy),
 };
 
 /* policy for the key attributes */
@@ -4725,6 +4735,48 @@ static int nl80211_parse_he_bss_color(struct nlattr *attrs,
 	return 0;
 }
 
+static int nl80211_parse_fd_bcastpresp(struct genl_info *info,
+				       struct cfg80211_ap_settings *params)
+{
+	struct nlattr *tmpl;
+	struct nlattr *tb[NL80211_FD_BCASTPRESP_ATTR_MAX + 1];
+	int ret;
+	struct cfg80211_beacon_data *beacon = &params->beacon;
+	struct cfg80211_fd_bcastpresp *cfg;
+
+	if (params->chandef.center_freq1 <= 5940 &&
+	    params->chandef.center_freq1 >= 7105)
+		return -EOPNOTSUPP;
+
+	ret = nla_parse_nested(tb, NL80211_FD_BCASTPRESP_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_FD_BCASTPRESP_CFG],
+			       fd_bcastpresp_policy, NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[NL80211_FD_BCASTPRESP_ATTR_TYPE] ||
+	    !tb[NL80211_FD_BCASTPRESP_ATTR_INT])
+		return -EINVAL;
+
+	cfg = &params->fd_bcastpresp;
+	cfg->type = nla_get_u8(tb[NL80211_FD_BCASTPRESP_ATTR_TYPE]);
+	cfg->interval = nla_get_u32(tb[NL80211_FD_BCASTPRESP_ATTR_INT]);
+
+	tmpl = tb[NL80211_FD_BCASTPRESP_ATTR_TMPL];
+	if (!tmpl && !beacon->fils_disc_len && !beacon->bcast_presp_len)
+		return -EINVAL;
+
+	if (cfg->type == CFG80211_TYPE_FILS_DISCOVERY) {
+		beacon->fils_disc = nla_data(tmpl);
+		beacon->fils_disc_len = nla_len(tmpl);
+	} else if (cfg->type == CFG80211_TYPE_BCAST_PROBE_RESP) {
+		beacon->bcast_presp = nla_data(tmpl);
+		beacon->bcast_presp_len = nla_len(tmpl);
+	}
+
+	return 0;
+}
+
 static void nl80211_check_ap_rate_selectors(struct cfg80211_ap_settings *params,
 					    const u8 *rates)
 {
@@ -5029,6 +5081,12 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	if (info->attrs[NL80211_ATTR_FD_BCASTPRESP_CFG]) {
+		err = nl80211_parse_fd_bcastpresp(info, &params);
+		if (err)
+			return err;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.25.0

