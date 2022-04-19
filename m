Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214C15063B0
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Apr 2022 06:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiDSE7E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Apr 2022 00:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiDSE6o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Apr 2022 00:58:44 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9415213D
        for <linux-wireless@vger.kernel.org>; Mon, 18 Apr 2022 21:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650344153; x=1681880153;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=B448wx9/rMTMLFEPhW1NtU8yecKxOnZ9UkFqtiRneac=;
  b=wt5RKa99ggy7DRISbt5qoL6DdH8lG4mWTo5PmQUUKBrfhogn12DUjCJz
   XuKYNvYHQcR9nQU0Yn5Wn/Rr5hmNQhY0QcAvNX6hKh8iUPc9enhdzYGJX
   qFd/sOOJP0CuA9YoQ0T1nBdTuX3l/HUaPqm6T1rgcLL9UnZDzxX3nSgGe
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Apr 2022 21:55:53 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:55:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 21:55:52 -0700
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 21:55:51 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] cfg80211: Add support for sending more than two AKMs in crypto settings
Date:   Tue, 19 Apr 2022 10:25:43 +0530
Message-ID: <1650344143-1615-1-git-send-email-quic_vjakkam@quicinc.com>
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

Add support to indicate maximum number of AKMs allowed in
NL80211_CMD_CONNECT, NL80211_CMD_ASSOCIATE and NL80211_CMD_START_AP.
If the driver doesn't indicate the capability, maximum limit is set to
the legacy value i.e. NL80211_MAX_NR_AKM_SUITE.

Contains a fix for the issue:
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2:
 Fixed issue reported by kernel test robot.
---
 drivers/net/wireless/ath/wil6210/cfg80211.c       |  3 +--
 drivers/net/wireless/quantenna/qtnfmac/commands.c |  6 ++++--
 include/net/cfg80211.h                            |  6 +++++-
 include/uapi/linux/nl80211.h                      | 15 +++++++++++++++
 net/wireless/core.c                               | 11 +++++++++++
 net/wireless/nl80211.c                            | 15 +++++++++++++--
 net/wireless/sme.c                                | 20 +++++++++++++++++++-
 net/wireless/wext-compat.c                        |  8 ++++++++
 8 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 764d1d1..ac40fe2 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1073,8 +1073,7 @@ static void wil_print_crypto(struct wil6210_priv *wil,
 			     c->ciphers_pairwise[i]);
 	wil_dbg_misc(wil, "}\n");
 	wil_dbg_misc(wil, "AKM suites [%d] {\n", c->n_akm_suites);
-	n = min_t(int, c->n_akm_suites, ARRAY_SIZE(c->akm_suites));
-	for (i = 0; i < n; i++)
+	for (i = 0; i < c->n_akm_suites; i++)
 		wil_dbg_misc(wil, "  [%d] = 0x%08x\n", i,
 			     c->akm_suites[i]);
 	wil_dbg_misc(wil, "}\n");
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index c68563c..ace78ff 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -281,7 +281,8 @@ int qtnf_cmd_send_start_ap(struct qtnf_vif *vif,
 		aen->ciphers_pairwise[i] =
 				cpu_to_le32(s->crypto.ciphers_pairwise[i]);
 	aen->n_akm_suites = cpu_to_le32(s->crypto.n_akm_suites);
-	for (i = 0; i < QLINK_MAX_NR_AKM_SUITES; i++)
+	for (i = 0; i < min(QLINK_MAX_NR_AKM_SUITES, s->crypto.n_akm_suites);
+	     i++)
 		aen->akm_suites[i] = cpu_to_le32(s->crypto.akm_suites[i]);
 	aen->control_port = s->crypto.control_port;
 	aen->control_port_no_encrypt = s->crypto.control_port_no_encrypt;
@@ -2134,7 +2135,8 @@ int qtnf_cmd_send_connect(struct qtnf_vif *vif,
 
 	aen->n_akm_suites = cpu_to_le32(sme->crypto.n_akm_suites);
 
-	for (i = 0; i < QLINK_MAX_NR_AKM_SUITES; i++)
+	for (i = 0; i < min(QLINK_MAX_NR_AKM_SUITES, sme->crypto.n_akm_suites);
+	     i++)
 		aen->akm_suites[i] = cpu_to_le32(sme->crypto.akm_suites[i]);
 
 	aen->control_port = sme->crypto.control_port;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6871338..48c7ab1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1112,7 +1112,7 @@ struct cfg80211_crypto_settings {
 	int n_ciphers_pairwise;
 	u32 ciphers_pairwise[NL80211_MAX_NR_CIPHER_SUITES];
 	int n_akm_suites;
-	u32 akm_suites[NL80211_MAX_NR_AKM_SUITES];
+	u32 *akm_suites;
 	bool control_port;
 	__be16 control_port_ethertype;
 	bool control_port_no_encrypt;
@@ -5129,6 +5129,9 @@ struct wiphy_iftype_akm_suites {
  * @ema_max_profile_periodicity: maximum profile periodicity supported by
  *	the driver. Setting this field to a non-zero value indicates that the
  *	driver supports enhanced multi-BSSID advertisements (EMA AP).
+ * @max_num_akm_suites: maximum supported number of AKM suites for
+ *	configuration through %NL80211_CMD_CONNECT, %NL80211_CMD_ASSOCIATE and
+ *	%NL80211_CMD_START_AP.
  */
 struct wiphy {
 	struct mutex mtx;
@@ -5275,6 +5278,7 @@ struct wiphy {
 
 	u8 mbssid_max_interfaces;
 	u8 ema_max_profile_periodicity;
+	u16 max_num_akm_suites;
 
 	char priv[] __aligned(NETDEV_ALIGN);
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0568a79..00fa5ea 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2663,6 +2663,13 @@ enum nl80211_commands {
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
  *	only if %NL80211_STA_FLAG_WME is set.
  *
+ * @NL80211_ATTR_MAX_NUM_AKM_SUITES: U16 attribute. Indicates maximum number of
+ *	AKM suites allowed for %NL80211_CMD_CONNECT, %NL80211_CMD_ASSOCIATE and
+ *	%NL80211_CMD_START_AP. If this attribute is not present userspace shall
+ *	consider maximum number of AKM suites supported as
+ *	%NL80211_MAX_NR_AKM_SUITES which is the legacy maximum number prior to
+ *	the introduction of this attribute.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3175,6 +3182,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EHT_CAPABILITY,
 
+	NL80211_ATTR_MAX_NUM_AKM_SUITES,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3229,6 +3238,12 @@ enum nl80211_attrs {
 #define NL80211_HE_MIN_CAPABILITY_LEN           16
 #define NL80211_HE_MAX_CAPABILITY_LEN           54
 #define NL80211_MAX_NR_CIPHER_SUITES		5
+
+/*
+ * NL80211_MAX_NR_AKM_SUITES is obsolete and not used for indicating maximum
+ * number of supported AKM suites. Instead, maximum number of supported AKM
+ * suites is indicated using %NL80211_ATTR_MAX_NUM_AKM_SUITES attribute.
+ */
 #define NL80211_MAX_NR_AKM_SUITES		2
 #define NL80211_EHT_MIN_CAPABILITY_LEN          13
 #define NL80211_EHT_MAX_CAPABILITY_LEN          51
diff --git a/net/wireless/core.c b/net/wireless/core.c
index f08d4b3..282cabc 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -913,6 +913,15 @@ int wiphy_register(struct wiphy *wiphy)
 		return -EINVAL;
 #endif
 
+	/*
+	 * Maximum number of AKM suites allowed for NL80211_CMD_CONECT,
+	 * NL80211_CMD_ASSOCIATE and NL80211_CMD_START_AP, must be at least
+	 * NL80211_MAX_NR_AKM_SUITES to avoid issues with legacy userspace.
+	 */
+	if (WARN_ON(wiphy->max_num_akm_suites &&
+		    wiphy->max_num_akm_suites < NL80211_MAX_NR_AKM_SUITES))
+		return -EINVAL;
+
 	/* check and set up bitrates */
 	ieee80211_set_bitrate_flags(wiphy);
 
@@ -1154,6 +1163,8 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 #ifdef CONFIG_CFG80211_WEXT
 	kfree_sensitive(wdev->wext.keys);
 	wdev->wext.keys = NULL;
+	kfree(wdev->wext.connect.crypto.akm_suites);
+	wdev->wext.connect.crypto.akm_suites = NULL;
 #endif
 	/* only initialized if we have a netdev */
 	if (wdev->netdev)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 711061c..4b7cbd5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -790,6 +790,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
+	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -2889,6 +2890,12 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		if (nl80211_put_mbssid_support(&rdev->wiphy, msg))
 			goto nla_put_failure;
 
+		if (nla_put_u16(msg, NL80211_ATTR_MAX_NUM_AKM_SUITES,
+				rdev->wiphy.max_num_akm_suites ?
+				rdev->wiphy.max_num_akm_suites :
+				NL80211_MAX_NR_AKM_SUITES))
+			goto nla_put_failure;
+
 		/* done */
 		state->split_start = 0;
 		break;
@@ -10253,6 +10260,7 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 	if (info->attrs[NL80211_ATTR_AKM_SUITES]) {
 		void *data;
 		int len;
+		int max_num_akm_suites = NL80211_MAX_NR_AKM_SUITES;
 
 		data = nla_data(info->attrs[NL80211_ATTR_AKM_SUITES]);
 		len = nla_len(info->attrs[NL80211_ATTR_AKM_SUITES]);
@@ -10261,10 +10269,13 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 		if (len % sizeof(u32))
 			return -EINVAL;
 
-		if (settings->n_akm_suites > NL80211_MAX_NR_AKM_SUITES)
+		if (rdev->wiphy.max_num_akm_suites)
+			max_num_akm_suites = rdev->wiphy.max_num_akm_suites;
+
+		if (settings->n_akm_suites > max_num_akm_suites)
 			return -EINVAL;
 
-		memcpy(settings->akm_suites, data, len);
+		settings->akm_suites = data;
 	}
 
 	if (info->attrs[NL80211_ATTR_PMK]) {
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index ff4d48fc..1ff9513 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -57,6 +57,7 @@ static void cfg80211_sme_free(struct wireless_dev *wdev)
 		return;
 
 	kfree(wdev->conn->ie);
+	kfree(wdev->conn->params.crypto.akm_suites);
 	kfree(wdev->conn);
 	wdev->conn = NULL;
 }
@@ -537,7 +538,8 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
 		return -ENOMEM;
 
 	/*
-	 * Copy all parameters, and treat explicitly IEs, BSSID, SSID.
+	 * Copy all parameters, and treat explicitly IEs, BSSID, SSID,
+	 * AKM SUITES.
 	 */
 	memcpy(&wdev->conn->params, connect, sizeof(*connect));
 	if (connect->bssid) {
@@ -563,6 +565,22 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
 		wdev->conn->auto_auth = false;
 	}
 
+	if (connect->crypto.n_akm_suites) {
+		wdev->conn->params.crypto.akm_suites =
+			kcalloc(connect->crypto.n_akm_suites, sizeof(u32),
+				GFP_KERNEL);
+		if (!wdev->conn->params.crypto.akm_suites) {
+			cfg80211_sme_free(wdev);
+			return -ENOMEM;
+		}
+
+		wdev->conn->params.crypto.n_akm_suites =
+			connect->crypto.n_akm_suites;
+		memcpy(wdev->conn->params.crypto.akm_suites,
+		       connect->crypto.akm_suites,
+		       sizeof(u32) * connect->crypto.n_akm_suites);
+	}
+
 	wdev->conn->params.ssid = wdev->ssid;
 	wdev->conn->params.ssid_len = wdev->ssid_len;
 
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a32065d..0d262e9 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1102,6 +1102,14 @@ static int cfg80211_set_key_mgt(struct wireless_dev *wdev, u32 key_mgt)
 			IW_AUTH_KEY_MGMT_PSK))
 		return -EINVAL;
 
+	if (!wdev->wext.connect.crypto.akm_suites) {
+		wdev->wext.connect.crypto.akm_suites =
+			kcalloc(NL80211_MAX_NR_AKM_SUITES, sizeof(u32),
+				GFP_KERNEL);
+		if (!wdev->wext.connect.crypto.akm_suites)
+			return -ENOMEM;
+	}
+
 	if (key_mgt & IW_AUTH_KEY_MGMT_802_1X) {
 		wdev->wext.connect.crypto.akm_suites[nr_akm_suites] =
 			WLAN_AKM_SUITE_8021X;
-- 
2.7.4

