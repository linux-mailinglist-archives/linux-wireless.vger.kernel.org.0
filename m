Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5972E6BB49D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjCON3h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjCON3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD8B8A393
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:32 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FAMMQ0011262;
        Wed, 15 Mar 2023 13:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=I8rwVTOOSK+Lnr6Kakn0cBE0/dyTUJG/gx/+vxsbcgQ=;
 b=XZImzfhrya1tzC3I2Bz/k8rR5BjDn2bgeG5Vbn45NjcJevsvqpSinTStE05zce7f7t0K
 4Mj5zdJOkaUUcsEHo5/J03DdmQRrrFAxy3oyP9fGTF4RV88QXQZ4lAW8Ze/GVQ6jEQNY
 FsDiMGT/ooel6hAkFo6H3hpblYKsu3yDW86+g4Wyyqx9VYHd7P7HpePUT+Y2TIGWTdeA
 K6Feu6R834nEsc9KjOoh+jPNMi89t7Bf2E5RjIykJE6LLxrK8n/Whfbre278aHCY4S9u
 orwZIEqC6bbEQ99Mvx1cPvCOPhlgRcb015/OJzjQ9IUV59CWE1hKldRaUx7wCKNl85wW jA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2cr1nvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTSq3018233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:28 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:27 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 4/9] wifi: cfg80211: add NL command to set 6 GHz power mode
Date:   Wed, 15 Mar 2023 18:58:59 +0530
Message-ID: <20230315132904.31779-5-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230315132904.31779-1-quic_adisi@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KMsELZ4p07IlJOpowfBX7aYC3SbkCSGE
X-Proofpoint-GUID: KMsELZ4p07IlJOpowfBX7aYC3SbkCSGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6 GHz introduces various power modes for access points and for clients.
When user configures these power modes, currently cfg80211 does not
have support to store the configured power mode.

Add support to store the 6 GHz configured power mode in the structure
wireless_dev via a new NL command - NL80211_CMD_SET_6GHZ_POWER_MODE.

The  above command uses a new NL attributes to set power mode for AP
and client interfaces - NL80211_ATTR_6GHZ_REG_POWER_MODE.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 include/net/cfg80211.h       |  6 +++-
 include/uapi/linux/nl80211.h | 10 ++++++
 net/wireless/ap.c            |  2 ++
 net/wireless/nl80211.c       | 66 +++++++++++++++++++++++++++++++++++-
 net/wireless/sme.c           |  2 ++
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7bc9ff9c3f36..d8d78141bab6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5805,7 +5805,8 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @unprot_beacon_reported: (private) timestamp of last
  *	unprotected beacon report
  * @links: array of %IEEE80211_MLD_MAX_NUM_LINKS elements containing @addr
- *	@ap and @client for each link
+ *	@ap and @client for each link. If link is 6 GHz link then uses
+ *	@reg_6ghz_pwr_configured as well.
  * @valid_links: bitmap describing what elements of @links are valid
  */
 struct wireless_dev {
@@ -5914,11 +5915,14 @@ struct wireless_dev {
 			struct {
 				unsigned int beacon_interval;
 				struct cfg80211_chan_def chandef;
+				enum ieee80211_ap_reg_power power_mode_6ghz;
 			} ap;
 			struct {
 				struct cfg80211_internal_bss *current_bss;
+				enum ieee80211_client_reg_power power_mode_6ghz;
 			} client;
 		};
+		bool reg_6ghz_pwr_configured;
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 valid_links;
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index eddccd491fc9..bff81489fa8a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1309,6 +1309,8 @@
  *	The number of peers that HW timestamping can be enabled for concurrently
  *	is indicated by %NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS.
  *
+ * @NL80211_CMD_SET_6GHZ_POWER_MODE: Set 6 GHz power mode for the interface
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1562,6 +1564,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_HW_TIMESTAMP,
 
+	NL80211_CMD_SET_6GHZ_POWER_MODE,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2786,6 +2790,10 @@ enum nl80211_commands {
  *	bit corresponds to the lowest 20 MHz channel. Each bit set to 1
  *	indicates that the sub-channel is punctured. Higher 16 bits are
  *	reserved.
+ * @NL80211_ATTR_6GHZ_REG_POWER_MODE: Regulatory power mode for 6 GHz operation.
+ *	This can be used for both AP and clients. Values are defined in
+ *	&enum ieee80211_ap_reg_power and &enum ieee80211_client_reg_power.
+ *	Therefore, iftype should be taken into consideration. u8 value.
  *
  * @NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS: Maximum number of peers that HW
  *	timestamping can be enabled for concurrently (u16), a wiphy attribute.
@@ -3328,6 +3336,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS,
 	NL80211_ATTR_HW_TIMESTAMP_ENABLED,
 
+	NL80211_ATTR_6GHZ_REG_POWER_MODE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/ap.c b/net/wireless/ap.c
index 0962770303b2..b8e2d9466434 100644
--- a/net/wireless/ap.c
+++ b/net/wireless/ap.c
@@ -30,6 +30,8 @@ static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	if (!wdev->links[link_id].ap.beacon_interval)
 		return -ENOENT;
 
+	wdev->links[link_id].reg_6ghz_pwr_configured = false;
+
 	err = rdev_stop_ap(rdev, dev, link_id);
 	if (!err) {
 		wdev->conn_owner_nlportid = 0;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1e8fe560078f..36cb4574145c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -809,6 +809,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 
 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_6GHZ_REG_POWER_MODE] = { .type = NLA_U8 },
 };
 
 /* policy for the key attributes */
@@ -16213,6 +16214,61 @@ static int nl80211_set_hw_timestamp(struct sk_buff *skb,
 	return rdev_set_hw_timestamp(rdev, dev, &hwts);
 }
 
+static bool nl80211_6ghz_power_mode_is_valid(enum nl80211_iftype iftype,
+					     u8 power_mode)
+{
+	/* For APs, referenced from enum ieee80211_ap_reg_power, and
+	 * For clients, referenced from enum ieee80211_client_reg_power
+	 */
+	switch (iftype) {
+	case NL80211_IFTYPE_AP:
+		return ((power_mode >= IEEE80211_REG_LPI_AP) &&
+			(power_mode <= IEEE80211_REG_AP_POWER_MAX));
+	case NL80211_IFTYPE_STATION:
+		return ((power_mode >= IEEE80211_REG_DEFAULT_CLIENT) &&
+			(power_mode <= IEEE80211_REG_CLIENT_POWER_MAX));
+	default:
+		return false;
+	}
+}
+
+static int nl80211_set_6ghz_power_mode(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	struct net_device *netdev = info->user_ptr[1];
+	struct wireless_dev *wdev = netdev->ieee80211_ptr;
+	enum nl80211_iftype iftype = wdev->iftype;
+	unsigned int link_id = nl80211_link_id(info->attrs);
+	u8 power_mode;
+
+	if (iftype != NL80211_IFTYPE_AP &&
+	    iftype != NL80211_IFTYPE_STATION)
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL80211_ATTR_6GHZ_REG_POWER_MODE])
+		return -EINVAL;
+
+	power_mode = nla_get_u8(info->attrs[NL80211_ATTR_6GHZ_REG_POWER_MODE]);
+	if (!nl80211_6ghz_power_mode_is_valid(iftype, power_mode))
+		return -EINVAL;
+
+	wdev_lock(wdev);
+	if (wdev->links[link_id].reg_6ghz_pwr_configured) {
+		wdev_unlock(wdev);
+		return -EALREADY;
+	}
+
+	if (iftype == NL80211_IFTYPE_AP)
+		wdev->links[link_id].ap.power_mode_6ghz = power_mode;
+	else
+		wdev->links[link_id].client.power_mode_6ghz = power_mode;
+
+	wdev->links[link_id].reg_6ghz_pwr_configured = true;
+
+	wdev_unlock(wdev);
+	return 0;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -17393,6 +17449,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_SET_6GHZ_POWER_MODE,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_set_6ghz_power_mode,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
@@ -17409,7 +17473,7 @@ static struct genl_family nl80211_fam __ro_after_init = {
 	.n_ops = ARRAY_SIZE(nl80211_ops),
 	.small_ops = nl80211_small_ops,
 	.n_small_ops = ARRAY_SIZE(nl80211_small_ops),
-	.resv_start_op = NL80211_CMD_REMOVE_LINK_STA + 1,
+	.resv_start_op = NL80211_CMD_SET_6GHZ_POWER_MODE + 1,
 	.mcgrps = nl80211_mcgrps,
 	.n_mcgrps = ARRAY_SIZE(nl80211_mcgrps),
 	.parallel_ops = true,
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 28ce13840a88..5ccc371fdfaf 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1558,6 +1558,8 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 	if (!wdev->connected)
 		wdev->u.client.ssid_len = 0;
 
+	wdev->links[0].reg_6ghz_pwr_configured = false;
+
 	return err;
 }
 
-- 
2.17.1

