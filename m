Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80FE5BCB87
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiISMMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiISMMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 08:12:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943F16336
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 05:12:12 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JAwBZA004718;
        Mon, 19 Sep 2022 12:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=BiXWgKAJbJicHw+2ZcuypCKf5cdcSBRC077qYOaCc3c=;
 b=KJC4w1twiLXjnDuudx2L1fnxIytofW1v/Q4WkKHh7aGlVOQvZlVgsSzaC/lXEm/oXHNO
 Jki47JRocP7O0zIR0aeqzi17Nav6dQUByNMllaK7fZ4y8iQF+VMZbqL9yWf02VWmdZ2T
 7vkJmT21EvHcTnPzoF3U4ozRGIetusgeozzdcQVLiI8N1LLD2sQFjss/bvS+cmjwXihY
 4GtkzngYctOFHuoIpe+Rq69XrpGeqxzYVQ+8HBlkamk+4BvH9/03QJ33vVbWsdiIX1pc
 TSWxobJKhYIho+t0lhrujAGP6fHpRpR5s11153ivlsgkekeDAvRS1lDhPA9g3rClJCzc bA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6e5ck4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 12:12:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JCC8AD032569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 12:12:08 GMT
Received: from u20-san1p10030.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 05:12:08 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/4] wifi: mac80211_hwsim: Add support for randomizing auth and deauth frames TA
Date:   Mon, 19 Sep 2022 05:11:54 -0700
Message-ID: <20220919121155.3069765-3-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
References: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xx7OeK8qfST0pMkLUfirrcU7khiJzRxV
X-Proofpoint-ORIG-GUID: Xx7OeK8qfST0pMkLUfirrcU7khiJzRxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add changes to support randomizing transmit address of the
authentication and deauthentication frames and support sending ACK to
frames with receive address as configured random MAC address.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 33 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index df51b5b1f171..4473cbf28725 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -720,6 +720,9 @@ struct mac80211_hwsim_data {
 	int rx_rssi;
 
 	struct mac80211_hwsim_link_data link_data[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	/* Ack the frames with RA as configured random address */
+	u8 random_addr[ETH_ALEN];
 };
 
 static const struct rhashtable_params hwsim_rht_params = {
@@ -1232,6 +1235,10 @@ static bool mac80211_hwsim_addr_match(struct mac80211_hwsim_data *data,
 	if (data->scanning && memcmp(addr, data->scan_addr, ETH_ALEN) == 0)
 		return true;
 
+	if (!is_zero_ether_addr(data->random_addr) &&
+	    ether_addr_equal(addr, data->random_addr))
+		return true;
+
 	memcpy(md.addr, addr, ETH_ALEN);
 
 	ieee80211_iterate_active_interfaces_atomic(data->hw,
@@ -3102,6 +3109,27 @@ static int mac80211_hwsim_change_sta_links(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static void mac80211_hwsim_config_random_mac(struct ieee80211_hw *hw,
+					     const u8 *addr)
+{
+	struct mac80211_hwsim_data *hwsim = hw->priv;
+
+	mutex_lock(&hwsim->mutex);
+
+	if (!is_zero_ether_addr(addr)) {
+		if (!is_zero_ether_addr(hwsim->random_addr))
+			mac80211_hwsim_config_mac_nl(hw, hwsim->random_addr,
+						     false);
+		ether_addr_copy(hwsim->random_addr, addr);
+		mac80211_hwsim_config_mac_nl(hw, hwsim->random_addr, true);
+	} else {
+		mac80211_hwsim_config_mac_nl(hw, hwsim->random_addr, false);
+		eth_zero_addr(hwsim->random_addr);
+	}
+
+	mutex_unlock(&hwsim->mutex);
+}
+
 #define HWSIM_COMMON_OPS					\
 	.tx = mac80211_hwsim_tx,				\
 	.start = mac80211_hwsim_start,				\
@@ -3123,7 +3151,8 @@ static int mac80211_hwsim_change_sta_links(struct ieee80211_hw *hw,
 	.flush = mac80211_hwsim_flush,				\
 	.get_et_sset_count = mac80211_hwsim_get_et_sset_count,	\
 	.get_et_stats = mac80211_hwsim_get_et_stats,		\
-	.get_et_strings = mac80211_hwsim_get_et_strings,
+	.get_et_strings = mac80211_hwsim_get_et_strings,	\
+	.config_random_mac = mac80211_hwsim_config_random_mac,
 
 #define HWSIM_NON_MLO_OPS					\
 	.sta_add = mac80211_hwsim_sta_add,			\
@@ -4439,6 +4468,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.25.1

