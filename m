Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063AA52E45B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 07:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345592AbiETFcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 01:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbiETFcb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 01:32:31 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F6F137D
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653024750; x=1684560750;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=lHbrc7VNeAsy+eDs9RZ8tRISmZ49meZSrww9VNUBqGY=;
  b=FV8Ty7RvPno1UflhdasN9ZWbncIjFQz3paW97m+pKuNLKM1btqBmqUjZ
   oT93cs63oPmaj9Rb7Deb9WYmsse71huczaOvAdf97gIlRjoqmIP5F4cTx
   FSIHfCi+c2JDuxfTz9Vu+h1bDQ4T0Y7UEEkYJKCBCEfySN++YNH+cMKyp
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 May 2022 22:32:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 22:32:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 22:31:54 -0700
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 22:31:53 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3] cfg80211: Increase akm_suites array size in cfg80211_crypto_settings
Date:   Fri, 20 May 2022 11:01:42 +0530
Message-ID: <1653024702-5304-1-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
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

Increase akm_suites array size in struct cfg80211_crypto_settings to 10
and advertise the capability to userspace. This allows userspace to send
more than two AKMs to driver in netlink commands such as
NL80211_CMD_CONNECT.

This capability needed for implementing WPA3-Personal transition mode
correctly with any driver that handles roaming internally. Currently,
the possible AKMs for multi-AKM connect can include PSK, PSK-SHA-256,
SAE, FT-PSK and FT-SAE since the count is already 5, Increasing
the akm_suites array size to 10 should be reasonable for future
usecases.

Contains a fix for the issue:
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v3:
 - Increase akm_suites array size in cfg80211_crypto_settings instead
   of allocating the array dynamically.
v2:
 - Fixed issue reported by kernel test robot.
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 12 ++++++++----
 include/net/cfg80211.h                            | 11 ++++++++++-
 include/uapi/linux/nl80211.h                      | 14 ++++++++++++++
 net/wireless/core.c                               |  6 ++++++
 net/wireless/nl80211.c                            | 10 +++++++++-
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index c68563c..2c84736 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -241,6 +241,7 @@ int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
 	struct qlink_auth_encr *aen;
 	int ret;
 	int i;
+	int n;
 
 	if (!qtnf_cmd_start_ap_can_fit(vif, s))
 		return -E2BIG;
@@ -280,8 +281,9 @@ int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
 	for (i = 0; i < QLINK_MAX_NR_CIPHER_SUITES; i++)
 		aen->ciphers_pairwise[i] =
 				cpu_to_le32(s->crypto.ciphers_pairwise[i]);
-	aen->n_akm_suites = cpu_to_le32(s->crypto.n_akm_suites);
-	for (i = 0; i < QLINK_MAX_NR_AKM_SUITES; i++)
+	n = min(QLINK_MAX_NR_AKM_SUITES, s->crypto.n_akm_suites);
+	aen->n_akm_suites = cpu_to_le32(n);
+	for (i = 0; i < n; i++)
 		aen->akm_suites[i] = cpu_to_le32(s->crypto.akm_suites[i]);
 	aen->control_port = s->crypto.control_port;
 	aen->control_port_no_encrypt = s->crypto.control_port_no_encrypt;
@@ -2076,6 +2078,7 @@ int qtnf_cmd_send_connect(struct qtnf_vif *vif,
 	struct qlink_auth_encr *aen;
 	int ret;
 	int i;
+	int n;
 	u32 connect_flags = 0;
 
 	cmd_skb = qtnf_cmd_alloc_new_cmdskb(vif->mac->macid, vif->vifid,
@@ -2132,9 +2135,10 @@ int qtnf_cmd_send_connect(struct qtnf_vif *vif,
 		aen->ciphers_pairwise[i] =
 			cpu_to_le32(sme->crypto.ciphers_pairwise[i]);
 
-	aen->n_akm_suites = cpu_to_le32(sme->crypto.n_akm_suites);
+	n = min(QLINK_MAX_NR_AKM_SUITES, sme->crypto.n_akm_suites);
+	aen->n_akm_suites = cpu_to_le32(n);
 
-	for (i = 0; i < QLINK_MAX_NR_AKM_SUITES; i++)
+	for (i = 0; i < n; i++)
 		aen->akm_suites[i] = cpu_to_le32(sme->crypto.akm_suites[i]);
 
 	aen->control_port = sme->crypto.control_port;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cc8a988..33919256 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1061,6 +1061,7 @@ struct survey_info {
 };
 
 #define CFG80211_MAX_WEP_KEYS	4
+#define CFG80211_MAX_NUM_AKM_SUITES	10
 
 /**
  * struct cfg80211_crypto_settings - Crypto settings
@@ -1112,7 +1113,7 @@ struct cfg80211_crypto_settings {
 	int n_ciphers_pairwise;
 	u32 ciphers_pairwise[NL80211_MAX_NR_CIPHER_SUITES];
 	int n_akm_suites;
-	u32 akm_suites[NL80211_MAX_NR_AKM_SUITES];
+	u32 akm_suites[CFG80211_MAX_NUM_AKM_SUITES];
 	bool control_port;
 	__be16 control_port_ethertype;
 	bool control_port_no_encrypt;
@@ -5134,6 +5135,13 @@ struct wiphy_iftype_akm_suites {
  * @ema_max_profile_periodicity: maximum profile periodicity supported by
  *	the driver. Setting this field to a non-zero value indicates that the
  *	driver supports enhanced multi-BSSID advertisements (EMA AP).
+ * @max_num_akm_suites: maximum number of AKM suites allowed for
+ *	configuration through %NL80211_CMD_CONNECT, %NL80211_CMD_ASSOCIATE and
+ *	%NL80211_CMD_START_AP. Set to NL80211_MAX_NR_AKM_SUITES if not set by
+ *	driver. If set by driver minimum allowed value is
+ *	NL80211_MAX_NR_AKM_SUITES in order to avoid compatibility issues with
+ *	legacy userspace and maximum allowed value is
+ *	CFG80211_MAX_NUM_AKM_SUITES.
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5280,6 +5288,7 @@ struct wiphy {
 
 	u8 mbssid_max_interfaces;
 	u8 ema_max_profile_periodicity;
+	u16 max_num_akm_suites;
 
 	char priv[] __aligned(NETDEV_ALIGN);
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d9490e3..246bd00 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2663,6 +2663,13 @@ enum nl80211_commands {
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
  *	only if %NL80211_STA_FLAG_WME is set.
  *
+ * @NL80211_ATTR_MAX_NUM_AKM_SUITES: U16 attribute. Indicates maximum number of
+ *	AKM suites allowed for %NL80211_CMD_CONNECT, %NL80211_CMD_ASSOCIATE and
+ *	%NL80211_CMD_START_AP in %NL80211_CMD_GET_WIPHY response. If this
+ *	attribute is not present userspace shall consider maximum number of AKM
+ *	suites allowed as %NL80211_MAX_NR_AKM_SUITES which is the legacy maximum
+ *	number prior to the introduction of this attribute.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3177,6 +3184,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_EHT,
 
+	NL80211_ATTR_MAX_NUM_AKM_SUITES,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3231,6 +3240,11 @@ enum nl80211_attrs {
 #define NL80211_HE_MIN_CAPABILITY_LEN           16
 #define NL80211_HE_MAX_CAPABILITY_LEN           54
 #define NL80211_MAX_NR_CIPHER_SUITES		5
+
+/*
+ * NL80211_MAX_NR_AKM_SUITES is obsolete when %NL80211_ATTR_MAX_NUM_AKM_SUITES
+ * present in %NL80211_CMD_GET_WIPHY response.
+ */
 #define NL80211_MAX_NR_AKM_SUITES		2
 #define NL80211_EHT_MIN_CAPABILITY_LEN          13
 #define NL80211_EHT_MAX_CAPABILITY_LEN          51
diff --git a/net/wireless/core.c b/net/wireless/core.c
index f08d4b3..8d42fc4 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -913,6 +913,12 @@ int wiphy_register(struct wiphy *wiphy)
 		return -EINVAL;
 #endif
 
+	if (!wiphy->max_num_akm_suites)
+		wiphy->max_num_akm_suites = NL80211_MAX_NR_AKM_SUITES;
+	else if (wiphy->max_num_akm_suites < NL80211_MAX_NR_AKM_SUITES ||
+		 wiphy->max_num_akm_suites > CFG80211_MAX_NUM_AKM_SUITES)
+		return -EINVAL;
+
 	/* check and set up bitrates */
 	ieee80211_set_bitrate_flags(wiphy);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 842f82f..2134430 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -792,6 +792,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
 	[NL80211_ATTR_DISABLE_EHT] = { .type = NLA_FLAG },
+	[NL80211_ATTR_MAX_NUM_AKM_SUITES] =
+		NLA_POLICY_RANGE(NLA_U16,
+				 NL80211_MAX_NR_AKM_SUITES,
+				 CFG80211_MAX_NUM_AKM_SUITES),
 };
 
 /* policy for the key attributes */
@@ -2891,6 +2895,10 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_mbssid_support(&rdev->wiphy, msg))
 			goto nla_put_failure;
 
+		if (nla_put_u16(msg, NL80211_ATTR_MAX_NUM_AKM_SUITES,
+				rdev->wiphy.max_num_akm_suites))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -10263,7 +10271,7 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 		if (len % sizeof(u32))
 			return -EINVAL;
 
-		if (settings->n_akm_suites > NL80211_MAX_NR_AKM_SUITES)
+		if (settings->n_akm_suites > rdev->wiphy.max_num_akm_suites)
 			return -EINVAL;
 
 		memcpy(settings->akm_suites, data, len);
-- 
2.7.4

