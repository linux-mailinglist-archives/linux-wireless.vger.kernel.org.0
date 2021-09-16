Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE440D1C9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 04:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhIPC4Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 22:56:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16342 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233847AbhIPC4Y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 22:56:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631760905; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: To: From: Sender;
 bh=Fpi6vU+wGanDUgxmpwORFca3u2ACxgquL2v5HIryV2A=; b=WVelC1L4gu0nsaqaxYGdBypLHrW03gRgr+OeeIwJirFXk0feoYutzy9aI+yo8DKtX4nqOhDT
 1T3FieHqs7VxMea9m5rHkHdtrpruVgvAVRljBUYg87U+d4eLoSvdJcsH7V6oQvmcAbwEactJ
 5tksd90ZQBUhOYuNNP21hL+nowA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6142b1f7e0f78151d6408b46 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 02:54:47
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9870CC4338F; Thu, 16 Sep 2021 02:54:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4325FC43460;
        Thu, 16 Sep 2021 02:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4325FC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [PATCH v12 1/4] nl80211: MBSSID and EMA support in AP mode
Date:   Wed, 15 Sep 2021 19:54:34 -0700
Message-Id: <20210916025437.29138-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916025437.29138-1-alokad@codeaurora.org>
References: <20210916025437.29138-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

This commit adds new attributes to configure support for multiple BSSID
and advanced multi-BSSID advertisements (EMA) in AP mode.

- NL80211_ATTR_MBSSID_CONFIG used for per interface configuration.
- NL80211_ATTR_MBSSID_ELEMS used to MBSSID elements for beacons.

Memory for the elements is allocated dynamically. This change frees
the memory in existing functions which call nl80211_parse_beacon(),
a comment is added to indicate the new references to do the same.

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v12: Replaced __dev_get_by_index() with dev_get_by_index() and
     added dev_put().
     nl80211_parse_mbssid_elems()returns ERR_PTR() insead of NULL
     in case of error and the caller nl80211_parse_beacon() uses
     PTR_ERR() to return the same.

 include/net/cfg80211.h       |  44 ++++++
 include/uapi/linux/nl80211.h |  76 +++++++++-
 net/wireless/nl80211.c       | 277 ++++++++++++++++++++++++++++++-----
 3 files changed, 358 insertions(+), 39 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 62dd8422e0dc..63b8c9890be8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1040,6 +1040,36 @@ struct cfg80211_crypto_settings {
 	enum nl80211_sae_pwe_mechanism sae_pwe;
 };
 
+/**
+ * struct cfg80211_mbssid_config - AP settings for multi bssid
+ *
+ * @tx_wdev: pointer to the transmitted interface in the MBSSID set
+ * @index: index of this AP in the multi bssid group.
+ * @ema: set to true if the beacons should be sent out in EMA mode.
+ */
+struct cfg80211_mbssid_config {
+	struct wireless_dev *tx_wdev;
+	u8 index;
+	bool ema;
+};
+
+/**
+ * struct cfg80211_mbssid_elems - Multiple BSSID elements
+ *
+ * @cnt: Number of elements in array %elems.
+ *
+ * @elem: Array of multiple BSSID element(s) to be added into Beacon frames.
+ * @elem.data: Data for multiple BSSID elements.
+ * @elem.len: Length of data.
+ */
+struct cfg80211_mbssid_elems {
+	u8 cnt;
+	struct {
+		u8 *data;
+		size_t len;
+	} elem[];
+};
+
 /**
  * struct cfg80211_beacon_data - beacon data
  * @head: head portion of beacon (before TIM IE)
@@ -1058,6 +1088,7 @@ struct cfg80211_crypto_settings {
  * @assocresp_ies_len: length of assocresp_ies in octets
  * @probe_resp_len: length of probe response template (@probe_resp)
  * @probe_resp: probe response template (AP mode only)
+ * @mbssid_ies: multiple BSSID elements
  * @ftm_responder: enable FTM responder functionality; -1 for no change
  *	(which also implies no change in LCI/civic location data)
  * @lci: Measurement Report element content, starting with Measurement Token
@@ -1075,6 +1106,7 @@ struct cfg80211_beacon_data {
 	const u8 *probe_resp;
 	const u8 *lci;
 	const u8 *civicloc;
+	struct cfg80211_mbssid_elems *mbssid_ies;
 	s8 ftm_responder;
 
 	size_t head_len, tail_len;
@@ -1189,6 +1221,7 @@ enum cfg80211_ap_settings_flags {
  * @he_oper: HE operation IE (or %NULL if HE isn't enabled)
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
+ * @mbssid_config: AP settings for multiple bssid
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1221,6 +1254,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_he_bss_color he_bss_color;
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
+	struct cfg80211_mbssid_config mbssid_config;
 };
 
 /**
@@ -4981,6 +5015,13 @@ struct wiphy_iftype_akm_suites {
  *	%NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
  * @sar_capa: SAR control capabilities
  * @rfkill: a pointer to the rfkill structure
+ *
+ * @mbssid_max_interfaces: maximum number of interfaces supported by the driver
+ *	in a multiple BSSID set. This field must be set to a non-zero value
+ *	by the driver to advertise MBSSID support.
+ * @mbssid_max_ema_profile_periodicity: maximum profile periodicity supported by
+ *	the driver. Setting this field to a non-zero value indicates that the
+ *	driver supports enhanced multi-BSSID advertisements (EMA AP).
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5125,6 +5166,9 @@ struct wiphy {
 
 	struct rfkill *rfkill;
 
+	u8 mbssid_max_interfaces;
+	u8 ema_max_profile_periodicity;
+
 	char priv[] __aligned(NETDEV_ALIGN);
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c2efea98e060..f1a21314e0f0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -337,7 +337,10 @@
  * @NL80211_CMD_DEL_INTERFACE: Virtual interface was deleted, has attributes
  *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_WIPHY. Can also be sent from
  *	userspace to request deletion of a virtual interface, then requires
- *	attribute %NL80211_ATTR_IFINDEX.
+ *	attribute %NL80211_ATTR_IFINDEX. If multiple BSSID advertisements are
+ *	enabled using %NL80211_ATTR_MBSSID_CONFIG, %NL80211_ATTR_MBSSID_ELEMS,
+ *	and if this command is used for the transmitting interface, then all
+ *	the non-transmitting interfaces are deleted as well.
  *
  * @NL80211_CMD_GET_KEY: Get sequence counter information for a key specified
  *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC.
@@ -2593,6 +2596,18 @@ enum nl80211_commands {
  * @NL80211_ATTR_COLOR_CHANGE_ELEMS: Nested set of attributes containing the IE
  *	information for the time while performing a color switch.
  *
+ * @NL80211_ATTR_MBSSID_CONFIG: Nested attribute for multiple BSSID
+ *	advertisements (MBSSID) parameters in AP mode.
+ *	Kernel uses this attribute to indicate the driver's support for MBSSID
+ *	and enhanced multi-BSSID advertisements (EMA AP) to the userspace.
+ *	Userspace should use this attribute to configure per interface MBSSID
+ *	parameters.
+ *	See &enum nl80211_mbssid_config_attributes for details.
+ *
+ * @NL80211_ATTR_MBSSID_ELEMS: Nested parameter to pass multiple BSSID elements.
+ *	Mandatory parameter for the transmitting interface to enable MBSSID.
+ *	Optional for the non-transmitting interfaces.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3096,6 +3111,9 @@ enum nl80211_attrs {
 	NL80211_ATTR_COLOR_CHANGE_COLOR,
 	NL80211_ATTR_COLOR_CHANGE_ELEMS,
 
+	NL80211_ATTR_MBSSID_CONFIG,
+	NL80211_ATTR_MBSSID_ELEMS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -7349,4 +7367,60 @@ enum nl80211_sar_specs_attrs {
 	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
 };
 
+/**
+ * enum nl80211_mbssid_config_attributes - multiple BSSID (MBSSID) and enhanced
+ * multi-BSSID advertisements (EMA) in AP mode.
+ * Kernel uses some of these attributes to advertise driver's support for
+ * MBSSID and EMA.
+ * Remaining attributes should be used by the userspace to configure the
+ * features.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES: Used by the kernel to advertise
+ *	the maximum number of MBSSID interfaces supported by the driver.
+ *	Driver should indicate MBSSID support by setting
+ *	wiphy->mbssid_max_interfaces to a value more than or equal to 2.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY: Used by the kernel
+ *	to advertise the maximum profile periodicity supported by the driver
+ *	if EMA is enabled. Driver should indicate EMA support to the userspace
+ *	by setting wiphy->mbssid_max_ema_profile_periodicity to
+ *	a non-zero value.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_INDEX: Mandatory parameter to pass the index of
+ *	this BSS (u8) in the multiple BSSID set.
+ *	Value must be set to 0 for the transmitting interface and non-zero for
+ *	all non-transmitting interfaces. The userspace will be responsible
+ *	for using unique indices for the interfaces.
+ *	Range: 0 to wiphy->mbssid_max_interfaces-1.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX: Mandatory parameter for
+ *	a non-transmitted profile which provides the interface index (u32) of
+ *	the transmitted profile. The value must match one of the interface
+ *	indices advertised by the kernel. Optional if the interface being set up
+ *	is the transmitting one, however, if provided then the value must match
+ *	the interface index of the same.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_EMA: Flag used to enable EMA AP feature.
+ *	Setting this flag is permitted only if the driver advertises EMA support
+ *	by setting wiphy->mbssid_max_ema_profile_periodicity to non-zero.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
+ */
+enum nl80211_mbssid_config_attributes {
+	__NL80211_MBSSID_CONFIG_ATTR_INVALID,
+
+	NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES,
+	NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY,
+	NL80211_MBSSID_CONFIG_ATTR_INDEX,
+	NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX,
+	NL80211_MBSSID_CONFIG_ATTR_EMA,
+
+	/* keep last */
+	__NL80211_MBSSID_CONFIG_ATTR_LAST,
+	NL80211_MBSSID_CONFIG_ATTR_MAX = __NL80211_MBSSID_CONFIG_ATTR_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bf7cd4752547..1f6216509124 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -437,6 +437,16 @@ sar_policy[NL80211_SAR_ATTR_MAX + 1] = {
 	[NL80211_SAR_ATTR_SPECS] = NLA_POLICY_NESTED_ARRAY(sar_specs_policy),
 };
 
+static const struct nla_policy
+nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
+	[NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES] = NLA_POLICY_MIN(NLA_U8, 2),
+	[NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY] =
+						NLA_POLICY_MIN(NLA_U8, 1),
+	[NL80211_MBSSID_CONFIG_ATTR_INDEX] = { .type = NLA_U8 },
+	[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX] = { .type = NLA_U32 },
+	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -763,6 +773,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_COLOR_CHANGE_COUNT] = { .type = NLA_U8 },
 	[NL80211_ATTR_COLOR_CHANGE_COLOR] = { .type = NLA_U8 },
 	[NL80211_ATTR_COLOR_CHANGE_ELEMS] = NLA_POLICY_NESTED(nl80211_policy),
+	[NL80211_ATTR_MBSSID_CONFIG] =
+			NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
+	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
 };
 
 /* policy for the key attributes */
@@ -2207,6 +2220,35 @@ nl80211_put_sar_specs(struct cfg80211_registered_device *rdev,
 	return -ENOBUFS;
 }
 
+static int nl80211_put_mbssid_support(struct wiphy *wiphy, struct sk_buff *msg)
+{
+	struct nlattr *config;
+
+	if (!wiphy->mbssid_max_interfaces)
+		return 0;
+
+	config = nla_nest_start(msg, NL80211_ATTR_MBSSID_CONFIG);
+	if (!config)
+		return -ENOBUFS;
+
+	if (nla_put_u8(msg, NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES,
+		       wiphy->mbssid_max_interfaces))
+		goto fail;
+
+	if (wiphy->ema_max_profile_periodicity &&
+	    nla_put_u8(msg,
+		       NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY,
+		       wiphy->ema_max_profile_periodicity))
+		goto fail;
+
+	nla_nest_end(msg, config);
+	return 0;
+
+fail:
+	nla_nest_cancel(msg, config);
+	return -ENOBUFS;
+}
+
 struct nl80211_dump_wiphy_state {
 	s64 filter_wiphy;
 	long start;
@@ -2792,6 +2834,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_sar_specs(rdev, msg))
 			goto nla_put_failure;
 
+		if (nl80211_put_mbssid_support(&rdev->wiphy, msg))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -4981,6 +5026,95 @@ static int validate_beacon_tx_rate(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+static int nl80211_parse_mbssid_config(struct wiphy *wiphy,
+				       struct net_device *dev,
+				       struct nlattr *attrs,
+				       struct cfg80211_mbssid_config *config,
+				       u8 num_elems)
+{
+	struct nlattr *tb[NL80211_MBSSID_CONFIG_ATTR_MAX + 1];
+
+	if (!wiphy->mbssid_max_interfaces)
+		return -EOPNOTSUPP;
+
+	if (nla_parse_nested(tb, NL80211_MBSSID_CONFIG_ATTR_MAX, attrs, NULL,
+			     NULL) ||
+	    !tb[NL80211_MBSSID_CONFIG_ATTR_INDEX])
+		return -EINVAL;
+
+	config->ema = nla_get_flag(tb[NL80211_MBSSID_CONFIG_ATTR_EMA]);
+	if (config->ema) {
+		if (!wiphy->ema_max_profile_periodicity)
+			return -EOPNOTSUPP;
+
+		if (num_elems > wiphy->ema_max_profile_periodicity)
+			return -EINVAL;
+	}
+
+	config->index = nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_INDEX]);
+	if (config->index >= wiphy->mbssid_max_interfaces ||
+	    (!config->index && !num_elems))
+		return -EINVAL;
+
+	if (!config->index)
+		config->tx_wdev = dev->ieee80211_ptr;
+
+	if (tb[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX]) {
+		u32 tx_ifindex =
+			nla_get_u32(tb[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX]);
+
+		if ((!config->index && tx_ifindex != dev->ifindex) ||
+		    (config->index && tx_ifindex == dev->ifindex))
+			return -EINVAL;
+
+		if (tx_ifindex != dev->ifindex) {
+			struct net_device *tx_netdev =
+				dev_get_by_index(wiphy_net(wiphy), tx_ifindex);
+
+			if (!tx_netdev || !tx_netdev->ieee80211_ptr ||
+			    tx_netdev->ieee80211_ptr->wiphy != wiphy ||
+			    tx_netdev->ieee80211_ptr->iftype !=
+							NL80211_IFTYPE_AP) {
+				dev_put(tx_netdev);
+				return -EINVAL;
+			}
+
+			config->tx_wdev = tx_netdev->ieee80211_ptr;
+		}
+	} else if (config->index) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct cfg80211_mbssid_elems *
+nl80211_parse_mbssid_elems(struct wiphy *wiphy, struct nlattr *attrs)
+{
+	struct nlattr *nl_elems;
+	struct cfg80211_mbssid_elems *elems;
+	int rem_elems;
+	u8 i = 0, num_elems = 0;
+
+	if (!wiphy->mbssid_max_interfaces)
+		return ERR_PTR(-EINVAL);
+
+	nla_for_each_nested(nl_elems, attrs, rem_elems)
+		num_elems++;
+
+	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
+	if (!elems)
+		return ERR_PTR(-ENOMEM);
+
+	nla_for_each_nested(nl_elems, attrs, rem_elems) {
+		elems->elem[i].data = nla_data(nl_elems);
+		elems->elem[i].len = nla_len(nl_elems);
+		i++;
+	}
+	elems->cnt = num_elems;
+	return elems;
+}
+
 static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 				struct nlattr *attrs[],
 				struct cfg80211_beacon_data *bcn)
@@ -5061,6 +5195,14 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 		bcn->ftm_responder = -1;
 	}
 
+	if (attrs[NL80211_ATTR_MBSSID_ELEMS]) {
+		bcn->mbssid_ies =
+			nl80211_parse_mbssid_elems(&rdev->wiphy,
+						   attrs[NL80211_ATTR_MBSSID_ELEMS]);
+		if (IS_ERR(bcn->mbssid_ies))
+			return PTR_ERR(bcn->mbssid_ies);
+	}
+
 	return 0;
 }
 
@@ -5346,7 +5488,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
 	if (err)
-		return err;
+		goto out;
 
 	params.beacon_interval =
 		nla_get_u32(info->attrs[NL80211_ATTR_BEACON_INTERVAL]);
@@ -5356,7 +5498,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
 					   params.beacon_interval);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * In theory, some of these attributes should be required here
@@ -5369,8 +5511,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params.ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
 		params.ssid_len =
 			nla_len(info->attrs[NL80211_ATTR_SSID]);
-		if (params.ssid_len == 0)
-			return -EINVAL;
+		if (params.ssid_len == 0) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_HIDDEN_SSID])
@@ -5383,57 +5527,74 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params.auth_type = nla_get_u32(
 			info->attrs[NL80211_ATTR_AUTH_TYPE]);
 		if (!nl80211_valid_auth_type(rdev, params.auth_type,
-					     NL80211_CMD_START_AP))
-			return -EINVAL;
+					     NL80211_CMD_START_AP)) {
+			err = -EINVAL;
+			goto out;
+		}
 	} else
 		params.auth_type = NL80211_AUTHTYPE_AUTOMATIC;
 
 	err = nl80211_crypto_settings(rdev, info, &params.crypto,
 				      NL80211_MAX_NR_CIPHER_SUITES);
 	if (err)
-		return err;
+		goto out;
 
 	if (info->attrs[NL80211_ATTR_INACTIVITY_TIMEOUT]) {
-		if (!(rdev->wiphy.features & NL80211_FEATURE_INACTIVITY_TIMER))
-			return -EOPNOTSUPP;
+		if (!(rdev->wiphy.features &
+		      NL80211_FEATURE_INACTIVITY_TIMER)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
 		params.inactivity_timeout = nla_get_u16(
 			info->attrs[NL80211_ATTR_INACTIVITY_TIMEOUT]);
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_CTWINDOW]) {
-		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
-			return -EINVAL;
+		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO) {
+			err = -EINVAL;
+			goto out;
+		}
 		params.p2p_ctwindow =
 			nla_get_u8(info->attrs[NL80211_ATTR_P2P_CTWINDOW]);
 		if (params.p2p_ctwindow != 0 &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN))
-			return -EINVAL;
+		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_CTWIN)) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_P2P_OPPPS]) {
 		u8 tmp;
 
-		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
-			return -EINVAL;
+		if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO) {
+			err = -EINVAL;
+			goto out;
+		}
 		tmp = nla_get_u8(info->attrs[NL80211_ATTR_P2P_OPPPS]);
 		params.p2p_opp_ps = tmp;
 		if (params.p2p_opp_ps != 0 &&
-		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS))
-			return -EINVAL;
+		    !(rdev->wiphy.features & NL80211_FEATURE_P2P_GO_OPPPS)) {
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
 		err = nl80211_parse_chandef(rdev, info, &params.chandef);
 		if (err)
-			return err;
+			goto out;
 	} else if (wdev->preset_chandef.chan) {
 		params.chandef = wdev->preset_chandef;
-	} else if (!nl80211_get_ap_channel(rdev, &params))
-		return -EINVAL;
+	} else if (!nl80211_get_ap_channel(rdev, &params)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params.chandef,
-					   wdev->iftype))
-		return -EINVAL;
+					   wdev->iftype)) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
@@ -5441,12 +5602,12 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 						    &params.beacon_rate,
 						    dev, false);
 		if (err)
-			return err;
+			goto out;
 
 		err = validate_beacon_tx_rate(rdev, params.chandef.chan->band,
 					      &params.beacon_rate);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_SMPS_MODE]) {
@@ -5457,29 +5618,38 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			break;
 		case NL80211_SMPS_STATIC:
 			if (!(rdev->wiphy.features &
-			      NL80211_FEATURE_STATIC_SMPS))
-				return -EINVAL;
+			      NL80211_FEATURE_STATIC_SMPS)) {
+				err = -EINVAL;
+				goto out;
+			}
 			break;
 		case NL80211_SMPS_DYNAMIC:
 			if (!(rdev->wiphy.features &
-			      NL80211_FEATURE_DYNAMIC_SMPS))
-				return -EINVAL;
+			      NL80211_FEATURE_DYNAMIC_SMPS)) {
+				err = -EINVAL;
+				goto out;
+			}
 			break;
 		default:
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 	} else {
 		params.smps_mode = NL80211_SMPS_OFF;
 	}
 
 	params.pbss = nla_get_flag(info->attrs[NL80211_ATTR_PBSS]);
-	if (params.pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ])
-		return -EOPNOTSUPP;
+	if (params.pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ]) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (info->attrs[NL80211_ATTR_ACL_POLICY]) {
 		params.acl = parse_acl_data(&rdev->wiphy, info);
-		if (IS_ERR(params.acl))
-			return PTR_ERR(params.acl);
+		if (IS_ERR(params.acl)) {
+			err = PTR_ERR(params.acl);
+			goto out;
+		}
 	}
 
 	params.twt_responder =
@@ -5517,6 +5687,17 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_MBSSID_CONFIG]) {
+		err = nl80211_parse_mbssid_config(&rdev->wiphy, dev,
+						  info->attrs[NL80211_ATTR_MBSSID_CONFIG],
+						  &params.mbssid_config,
+						  (params.beacon.mbssid_ies ?
+						   params.beacon.mbssid_ies->cnt :
+						   0));
+		if (err)
+			goto out;
+	}
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
@@ -5537,7 +5718,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.acl);
+	if (!IS_ERR(params.acl))
+		kfree(params.acl);
+	if (!IS_ERR(params.beacon.mbssid_ies))
+		kfree(params.beacon.mbssid_ies);
+	if (params.mbssid_config.tx_wdev &&
+	    params.mbssid_config.tx_wdev->netdev &&
+	    params.mbssid_config.tx_wdev->netdev != dev)
+		dev_put(params.mbssid_config.tx_wdev->netdev);
 
 	return err;
 }
@@ -5562,12 +5750,15 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params);
 	if (err)
-		return err;
+		goto out;
 
 	wdev_lock(wdev);
 	err = rdev_change_beacon(rdev, dev, &params);
 	wdev_unlock(wdev);
 
+out:
+	if (!IS_ERR(params.mbssid_ies))
+		kfree(params.mbssid_ies);
 	return err;
 }
 
@@ -9244,12 +9435,14 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon_after);
 	if (err)
-		return err;
+		goto free;
 
 	csa_attrs = kcalloc(NL80211_ATTR_MAX + 1, sizeof(*csa_attrs),
 			    GFP_KERNEL);
-	if (!csa_attrs)
-		return -ENOMEM;
+	if (!csa_attrs) {
+		err = -ENOMEM;
+		goto free;
+	}
 
 	err = nla_parse_nested_deprecated(csa_attrs, NL80211_ATTR_MAX,
 					  info->attrs[NL80211_ATTR_CSA_IES],
@@ -9367,6 +9560,10 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 free:
+	if (!IS_ERR(params.beacon_after.mbssid_ies))
+		kfree(params.beacon_after.mbssid_ies);
+	if (!IS_ERR(params.beacon_csa.mbssid_ies))
+		kfree(params.beacon_csa.mbssid_ies);
 	kfree(csa_attrs);
 	return err;
 }
@@ -14900,6 +15097,10 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 	wdev_unlock(wdev);
 
 out:
+	if (!IS_ERR(params.beacon_next.mbssid_ies))
+		kfree(params.beacon_next.mbssid_ies);
+	if (!IS_ERR(params.beacon_color_change.mbssid_ies))
+		kfree(params.beacon_color_change.mbssid_ies);
 	kfree(tb);
 	return err;
 }
-- 
2.31.1

