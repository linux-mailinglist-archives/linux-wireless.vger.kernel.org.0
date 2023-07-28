Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848EA76656B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjG1He3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjG1He2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:34:28 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9682D51
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:34:22 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230728073419epoutp035f83ae177701a7eaad51daf9c52c85f1~198S9CtPb0566405664epoutp033
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 07:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230728073419epoutp035f83ae177701a7eaad51daf9c52c85f1~198S9CtPb0566405664epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690529659;
        bh=mUAxpLpJ1N13VZrCwXC7pUPNcZn98jmDXrWLaGf2hb0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SBZUJMfZ5T2RZ2t0vaMgqXFdU7cheptlF0zcmz3KCtL8E1lqKQpq96LGpD7fHICGx
         PzJahLYLvY3Kuaks0UVVhhifAb0uJftkl073vsOQGwJ77AvM0bri40GkCpKP3+KY+L
         x0i/sZfnD/24hDHti5VqyPB4CT+NzBNI5vsrmb9g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230728073418epcas5p1a26fa2b9bec72a672f38475c64b5db43~198SW1aPn1036410364epcas5p1c;
        Fri, 28 Jul 2023 07:34:18 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RBzsj1cC7z4x9Q8; Fri, 28 Jul
        2023 07:34:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.B8.55173.97F63C46; Fri, 28 Jul 2023 16:34:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230728071724epcas5p32f46dd6dd091c61aaba26f28897f6378~19th4j5uf2013720137epcas5p3n;
        Fri, 28 Jul 2023 07:17:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230728071724epsmtrp26f3fb138c1186b01e6827506b5df1f46~19th31F1q3066730667epsmtrp2N;
        Fri, 28 Jul 2023 07:17:24 +0000 (GMT)
X-AuditID: b6c32a50-e61c07000001d785-dc-64c36f7903de
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.4F.64355.48B63C46; Fri, 28 Jul 2023 16:17:24 +0900 (KST)
Received: from administrator-PowerEdge-R740xd.sa.corp.samsungelectronics.net
        (unknown [107.109.114.216]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA
        id
        20230728071723epsmtip20b45a8519e2f180e40035346ad02b321~19thIZWT92622726227epsmtip2A;
        Fri, 28 Jul 2023 07:17:23 +0000 (GMT)
From:   Kavitha Velayutham <k.velayutham@samsung.com>
To:     linux-wireless@vger.kernel.org, mohit.ghuley@samsung.com
Cc:     johannes@sipsolutions.net,
        Kavitha Velayutham <k.velayutham@samsung.com>
Subject: [PATCH v2 1/1] wifi: changes for FILS Authentication for External
 Auth
Date:   Fri, 28 Jul 2023 20:47:51 +0530
Message-Id: <20230728151751.1637555-1-k.velayutham@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmlm5l/uEUgzfv2Cw+bvjEYrH7+QVW
        izcr7rBb9DQmO7B49G1ZxejR37uNxePzJrkA5qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hT
        MwNDXUNLC3MlhbzE3FRbJRefAF23zBygZUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IwHbzcyF9wOqTjS2MXWwLjBvYuRk0NCwETi
        xMIj7F2MXBxCAnsYJXYtus0C4XxilLh9cykTnHNgwixmmJaGP1+gqnYySux5uA3Kmc8k0X/5
        JStIFZuAscT9Kz2MXYwcHCICNhL31guDhJkFfCTaZ14GGyQsEChx5fkuRhCbRUBVYtufVrBW
        XgF7iZ+np7FDLJOX2H/wLDNEXFDi5MwnLBBz5CWat85mBtkrIbCIXeLjq4lsEA0uEpd2PYe6
        VFji1fEtUIOkJD6/2wtVky1xc/FRFgi7RGLzquVQcXuJ/v3NrCA3MwtoSqzfpQ8RlpWYemod
        E8RePone30+YIOK8EjvmwdhqEic6VkGNlJFY3PAUyvaQ6Oi9D1YjJBAr8ePJZ/YJjPKzkLwz
        C8k7sxA2L2BkXsUolVpQnJuemmxaYKibl1oOj9nk/NxNjOBEpxWwg3H1hr96hxiZOBgPMUpw
        MCuJ8J4KOJQixJuSWFmVWpQfX1Sak1p8iNEUGMgTmaVEk/OBqTavJN7QxNLAxMzMzMTS2MxQ
        SZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQYmHo45m72eLrEUfD8zr/Pwystuwp/dQ3INzq1e
        uzT03WSdaRUJ6Ws9jW8lb0iXZvr5VdT60sdOthPtlz6yeyn8Tcthl65n/Py5qVdP6lUR1w0O
        c50PzVsTnkfyXV57q3WqpcLLayuWtzVYH/zbF1Nn2Swssvmwyq77S1pWpR80VYrf/+BrVGvf
        4/ccj3fpeV6LtJaKcVC3fBTQ6dgc8zP35e9f9eaPnZbaqctoplyoT2z13M+86Nux+7HGPm4T
        vTmWBjuvueBZ1Sybzi7Hwi8mkDlVyLJe4sfK6/c2TD3RkbpftELsZ5w89/z4h0Wpm78UBlwx
        O97hylkZeLpMe5Jnq8EZM4G8Dj4R61S+MiWW4oxEQy3mouJEAAD5Y/z9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSvG5L9uEUg7WP1Sw+bvjEYrH7+QVW
        izcr7rBb9DQmO7B49G1ZxejR37uNxePzJrkA5igum5TUnMyy1CJ9uwSujAdvNzIX3A6pONLY
        xdbAuMG9i5GTQ0LARKLhzxeWLkYuDiGB7YwSK3buZoNIyEjc6T7GCGELS6z895wdomg2k0RL
        53SwIjYBY4n7V3rAikQE7CQ+fVvABGIzC/hJvHq/GqxGWMBfYse2VWA1LAKqEtv+tLKC2LwC
        9hI/T09jh1ggL7H/4FlmiLigxMmZT1gg5shLNG+dzTyBkW8WktQsJKkFjEyrGEVTC4pz03OT
        Cwz1ihNzi0vz0vWS83M3MYJDTStoB+Oy9X/1DjEycTAeYpTgYFYS4T0VcChFiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgWnCVn42/t02+48tvdm/cOKn
        O+Hds1vWfytxle2OYNz4fV/g1HWuMv9eXm/U6mhasvjp/VWNFfcexd/c4bvd+2WzCefEKSlf
        1m9YseGh/PdFpq9vNOy7EV84NXdmKPNhP4X3O0tZ32+OXbEitMG+R+JB6bLztf9mqvXrC1ar
        qWw8MkND89lT67A/hx6ueeVzfKbUjdKV/daPJ7K3851iFnh449yvbbtDeE727y+qN6vgnGv4
        TC/P0/BXtUP9/YlGLEfO3zM/msz55K6tte6ZGIUXi+ao5mZO+7q96aCRs7L/rzU+XGWa5x7m
        bV2dMTs+6E55/bl1/3xEGpVqGlSMs/T2u/nZ1RpevHt2wlznT27NSizFGYmGWsxFxYkA26FI
        MaQCAAA=
X-CMS-MailID: 20230728071724epcas5p32f46dd6dd091c61aaba26f28897f6378
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230728071724epcas5p32f46dd6dd091c61aaba26f28897f6378
References: <CGME20230728071724epcas5p32f46dd6dd091c61aaba26f28897f6378@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For Auth to be handled by supplicant when sme is in lower layers for FILS Authentication and
to send Assoc params to the  Lower layers.
If Auth is handled in supplicant and if Assoc to be handled in lower layers , then Assoc params to be
sent to the Lower layers from supplicant.

Signed-off-by: Kavitha Velayutham <k.velayutham@samsung.com>
---
 include/net/cfg80211.h       | 14 ++++++++
 include/uapi/linux/nl80211.h | 15 ++++++++-
 net/wireless/Kconfig         |  5 +++
 net/wireless/nl80211.c       | 63 ++++++++++++++++++++++++++++++------
 net/wireless/rdev-ops.h      | 14 ++++++++
 net/wireless/trace.h         | 24 ++++++++++++++
 6 files changed, 125 insertions(+), 10 deletions(-)
 mode change 100644 => 100755 include/net/cfg80211.h
 mode change 100644 => 100755 include/uapi/linux/nl80211.h
 mode change 100644 => 100755 net/wireless/nl80211.c
 mode change 100644 => 100755 net/wireless/rdev-ops.h
 mode change 100644 => 100755 net/wireless/trace.h

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
old mode 100644
new mode 100755
index 9e04f69712b1..ac61d326f0f3
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3467,6 +3467,16 @@ struct cfg80211_update_ft_ies_params {
 	size_t ie_len;
 };
 
+#ifdef CONFIG_SCSC_WLAN_OCE
+struct cfg80211_external_fils_assoc_params {
+	const u8 *fils_kek;
+	size_t fils_kek_len;
+	const u8 *ie;
+	size_t ie_len;
+	const u8 *fils_nonces;
+	size_t fils_nonces_len;
+};
+#endif
 /**
  * struct cfg80211_mgmt_tx_params - mgmt tx parameters
  *
@@ -4626,6 +4636,10 @@ struct cfg80211_ops {
 				struct net_device *dev);
 	int	(*update_ft_ies)(struct wiphy *wiphy, struct net_device *dev,
 				 struct cfg80211_update_ft_ies_params *ftie);
+#ifdef CONFIG_SCSC_WLAN_OCE
+	int	(*set_fils_assoc_params)(struct wiphy *wiphy, struct net_device *dev,
+					 struct cfg80211_external_fils_assoc_params *ftie);
+#endif
 	int	(*crit_proto_start)(struct wiphy *wiphy,
 				    struct wireless_dev *wdev,
 				    enum nl80211_crit_proto_id protocol,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
old mode 100644
new mode 100755
index c59fec406da5..6ef927c966d3
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1562,6 +1562,10 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_HW_TIMESTAMP,
 
+	NL80211_CMD_SET_SAR_SPECS,
+
+	NL80211_CMD_FILS_ASSOC_REQ_INFO,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -1581,6 +1585,7 @@ enum nl80211_commands {
 #define NL80211_CMD_DEAUTHENTICATE NL80211_CMD_DEAUTHENTICATE
 #define NL80211_CMD_DISASSOCIATE NL80211_CMD_DISASSOCIATE
 #define NL80211_CMD_REG_BEACON_HINT NL80211_CMD_REG_BEACON_HINT
+#define NL80211_CMD_FILS_ASSOC_REQ_INFO NL80211_CMD_FILS_ASSOC_REQ_INFO
 
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
@@ -3302,6 +3307,14 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_FILS_ASSOC_IE,
+
+	NL80211_ATTR_RECONNECT_REQUESTED,
+
+	NL80211_ATTR_SAR_SPEC,
+
+	NL80211_ATTR_DISABLE_HE,
+
 	NL80211_ATTR_OBSS_COLOR_BITMAP,
 
 	NL80211_ATTR_COLOR_CHANGE_COUNT,
@@ -6443,7 +6456,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_PUNCT,
 	NL80211_EXT_FEATURE_SECURE_NAN,
 	NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,
-
+	NL80211_EXT_FEATURE_EXTERNAL_AUTH_FILS,
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
 	MAX_NL80211_EXT_FEATURES = NUM_NL80211_EXT_FEATURES - 1
diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index f620acd2a0f5..cac4586e21e1 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -67,6 +67,11 @@ config CFG80211_DEVELOPER_WARNINGS
 	  Say Y only if you are developing cfg80211 or a driver based
 	  on it (or mac80211).
 
+config SCSC_WLAN_OCE
+	bool "OCE Auth Support with External Auth"
+	default y
+	help
+	  This option enables external Auth Support for FILS Authentication
 
 config CFG80211_CERTIFICATION_ONUS
 	bool "cfg80211 certification onus"
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
old mode 100644
new mode 100755
index d95f8053020d..b78236883b84
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -559,6 +559,11 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_IE] = NLA_POLICY_VALIDATE_FN(NLA_BINARY,
 						   validate_ie_attr,
 						   IEEE80211_MAX_DATA_LEN),
+#ifdef CONFIG_SCSC_WLAN_OCE
+	[NL80211_ATTR_FILS_ASSOC_IE] = NLA_POLICY_VALIDATE_FN(NLA_BINARY,
+							      validate_ie_attr,
+							      IEEE80211_MAX_DATA_LEN),
+#endif
 	[NL80211_ATTR_SCAN_FREQUENCIES] = { .type = NLA_NESTED },
 	[NL80211_ATTR_SCAN_SSIDS] = { .type = NLA_NESTED },
 
@@ -5844,10 +5849,11 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 		if (auth_type == NL80211_AUTHTYPE_FILS_SK_PFS ||
 		    auth_type == NL80211_AUTHTYPE_FILS_PK)
 			return false;
-		if (!wiphy_ext_feature_isset(
-			    &rdev->wiphy,
-			    NL80211_EXT_FEATURE_FILS_SK_OFFLOAD) &&
-		    auth_type == NL80211_AUTHTYPE_FILS_SK)
+		if (!(wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_FILS_SK_OFFLOAD)
+#ifdef CONFIG_SCSC_WLAN_OCE
+		    || wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_EXTERNAL_AUTH_FILS)
+#endif
+		    ) && auth_type == NL80211_AUTHTYPE_FILS_SK)
 			return false;
 		return true;
 	case NL80211_CMD_START_AP:
@@ -11929,9 +11935,11 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	if (wiphy_ext_feature_isset(&rdev->wiphy,
-				    NL80211_EXT_FEATURE_FILS_SK_OFFLOAD) &&
-	    info->attrs[NL80211_ATTR_FILS_ERP_USERNAME] &&
+	if ((wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_FILS_SK_OFFLOAD)
+#ifdef CONFIG_SCSC_WLAN_OCE
+	    || wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_EXTERNAL_AUTH_FILS)
+#endif
+	    ) && info->attrs[NL80211_ATTR_FILS_ERP_USERNAME] &&
 	    info->attrs[NL80211_ATTR_FILS_ERP_REALM] &&
 	    info->attrs[NL80211_ATTR_FILS_ERP_NEXT_SEQ_NUM] &&
 	    info->attrs[NL80211_ATTR_FILS_ERP_RRK]) {
@@ -12013,8 +12021,8 @@ static int nl80211_update_connect_params(struct sk_buff *skb,
 		changed |= UPDATE_ASSOC_IES;
 	}
 
-	fils_sk_offload = wiphy_ext_feature_isset(&rdev->wiphy,
-						  NL80211_EXT_FEATURE_FILS_SK_OFFLOAD);
+	fils_sk_offload = wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_FILS_SK_OFFLOAD) ||
+			  wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_EXTERNAL_AUTH_FILS);
 
 	/*
 	 * when driver supports fils-sk offload all attributes must be
@@ -14789,6 +14797,33 @@ static int nl80211_update_ft_ies(struct sk_buff *skb, struct genl_info *info)
 	return rdev_update_ft_ies(rdev, dev, &ft_params);
 }
 
+#ifdef CONFIG_SCSC_WLAN_OCE
+static int nl80211_fils_assoc_req_ies(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_external_fils_assoc_params fils_params;
+	struct net_device *dev = info->user_ptr[1];
+
+	if (!rdev->ops->set_fils_assoc_params)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_FILS_KEK] ||
+	    !info->attrs[NL80211_ATTR_FILS_ASSOC_IE] ||
+	    !info->attrs[NL80211_ATTR_FILS_NONCES])
+		return -EINVAL;
+
+	memset(&fils_params, 0, sizeof(fils_params));
+	fils_params.fils_kek = nla_data(info->attrs[NL80211_ATTR_FILS_KEK]);
+	fils_params.fils_kek_len = nla_len(info->attrs[NL80211_ATTR_FILS_KEK]);
+	fils_params.ie = nla_data(info->attrs[NL80211_ATTR_FILS_ASSOC_IE]);
+	fils_params.ie_len = nla_len(info->attrs[NL80211_ATTR_FILS_ASSOC_IE]);
+	fils_params.fils_nonces = nla_data(info->attrs[NL80211_ATTR_FILS_NONCES]);
+	fils_params.fils_nonces_len = nla_len(info->attrs[NL80211_ATTR_FILS_NONCES]);
+
+	return rdev_fils_assoc_req_ies(rdev, dev, &fils_params);
+}
+#endif
+
 static int nl80211_crit_protocol_start(struct sk_buff *skb,
 				       struct genl_info *info)
 {
@@ -16631,6 +16666,16 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_set_wiphy,
 		.flags = GENL_UNS_ADMIN_PERM,
 	},
+#ifdef CONFIG_SCSC_WLAN_OCE
+	{
+		.cmd = NL80211_CMD_FILS_ASSOC_REQ_INFO,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_fils_assoc_req_ies,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_NEED_RTNL,
+	},
+#endif
 	{
 		.cmd = NL80211_CMD_GET_INTERFACE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
old mode 100644
new mode 100755
index 2e497cf26ef2..000d2019901d
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1062,6 +1062,20 @@ static inline int rdev_update_ft_ies(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+#ifdef CONFIG_SCSC_WLAN_OCE
+static inline int rdev_fils_assoc_req_ies(struct cfg80211_registered_device *rdev,
+					  struct net_device *dev,
+					  struct cfg80211_external_fils_assoc_params *params)
+{
+	int ret;
+
+	trace_rdev_fils_assoc_req_ies(&rdev->wiphy, dev, params);
+	ret = rdev->ops->set_fils_assoc_params(&rdev->wiphy, dev, params);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+#endif
+
 static inline int rdev_crit_proto_start(struct cfg80211_registered_device *rdev,
 					struct wireless_dev *wdev,
 					enum nl80211_crit_proto_id protocol,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
old mode 100644
new mode 100755
index 716a1fa70069..7c2877a7099b
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2256,6 +2256,30 @@ TRACE_EVENT(rdev_update_ft_ies,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->md)
 );
 
+#ifdef CONFIG_SCSC_WLAN_OCE
+TRACE_EVENT(rdev_fils_assoc_req_ies,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_external_fils_assoc_params *filsie),
+	TP_ARGS(wiphy, netdev, filsie),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__dynamic_array(u8, kek, filsie->fils_kek_len)
+		__dynamic_array(u8, ie, filsie->ie_len)
+		__dynamic_array(u8, nonces, filsie->fils_nonces_len)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		memcpy(__get_dynamic_array(kek), filsie->fils_kek, filsie->fils_kek_len);
+		memcpy(__get_dynamic_array(ie), filsie->ie, filsie->ie_len);
+		memcpy(__get_dynamic_array(ie), filsie->fils_nonces, filsie->fils_nonces_len);
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG)
+);
+#endif
+
 TRACE_EVENT(rdev_crit_proto_start,
 	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 enum nl80211_crit_proto_id protocol, u16 duration),
-- 
2.34.1

