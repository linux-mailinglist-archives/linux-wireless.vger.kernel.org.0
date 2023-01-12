Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B966685A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jan 2023 02:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbjALBY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 20:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjALBYz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 20:24:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D004086C
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 17:24:54 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BNxRqt030913;
        Thu, 12 Jan 2023 01:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=UO96Uw4BEMBBuMbf/pDEd3SPzLFgwpGvtMFqid7G4uw=;
 b=p5IpwQ4oqSOwJtcM2iOGIyk6kH4XTxLud+hDSmQnPA913oZgf2DRBlAYMSrvtltuLXLu
 ETUD3+Kf4cKXS0REAiiD5bg9vasOJYn81zvyuxJ2BYZFRNcu+STkKz3zaMSn7lDidEQf
 aYM7PfZ6o23DVQxeYcGqkN3fQkLutv74qkqw6x/ixLbHliwsTZ+FHQY2bYdUs1AeZFzE
 9eq/TVRgnxwstSPrDxx+dQyui16uG0GcDCCF4yHzc/t/tIMB/46542CVOupmsqUx/TCs
 rMR3F7GVbuLOPd8yEqJzCsWPsJV5m6F23yM7T2uaS8zk+fQxPSgbevuAMRzLy4avUEMs yg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k5k2ksb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:24:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C1OlKH001659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 01:24:47 GMT
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 17:24:45 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v3 3/3] wifi: mac80211_hwsim: Add support for randomizing auth and deauth frames TA
Date:   Thu, 12 Jan 2023 06:54:15 +0530
Message-ID: <20230112012415.167556-4-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112012415.167556-1-quic_vjakkam@quicinc.com>
References: <20230112012415.167556-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KMFtHWMwSgqz0dfk85NJ9V0WE-3shAE7
X-Proofpoint-GUID: KMFtHWMwSgqz0dfk85NJ9V0WE-3shAE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add changes to support randomizing TA of the authentication and
deauthentication frames and indicate the support to upper layers.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index c57c8903b7c0..40469d2723e5 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -720,6 +720,9 @@ struct mac80211_hwsim_data {
 	int rx_rssi;
 
 	struct mac80211_hwsim_link_data link_data[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	/* Ack the frames with RA as configured temporary address */
+	u8 temp_addr[ETH_ALEN];
 };
 
 static const struct rhashtable_params hwsim_rht_params = {
@@ -1237,6 +1240,10 @@ static bool mac80211_hwsim_addr_match(struct mac80211_hwsim_data *data,
 	if (data->scanning && memcmp(addr, data->scan_addr, ETH_ALEN) == 0)
 		return true;
 
+	if (!is_zero_ether_addr(data->temp_addr) &&
+	    ether_addr_equal(addr, data->temp_addr))
+		return true;
+
 	memcpy(md.addr, addr, ETH_ALEN);
 
 	ieee80211_iterate_active_interfaces_atomic(data->hw,
@@ -2285,6 +2292,7 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 					    u64 changed)
 {
 	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
+	struct mac80211_hwsim_data *hwsim = hw->priv;
 
 	hwsim_check_magic(vif);
 
@@ -2297,6 +2305,22 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 		vp->assoc = vif->cfg.assoc;
 		vp->aid = vif->cfg.aid;
 	}
+
+	if (changed & BSS_CHANGED_TEMP_ADDR) {
+		wiphy_dbg(hw->wiphy, "  TMP_ADDR: vif->cfg.temp_addr=%pM\n",
+			  vif->cfg.temp_addr);
+
+		if (!is_zero_ether_addr(hwsim->temp_addr))
+			mac80211_hwsim_config_mac_nl(hw, hwsim->temp_addr,
+						     false);
+		if (!is_zero_ether_addr(vif->cfg.temp_addr)) {
+			ether_addr_copy(hwsim->temp_addr, vif->cfg.temp_addr);
+			mac80211_hwsim_config_mac_nl(hw, hwsim->temp_addr,
+						     true);
+		} else {
+			eth_zero_addr(hwsim->temp_addr);
+		}
+	}
 }
 
 static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
@@ -4445,6 +4469,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_BEACON_RATE_LEGACY);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.25.1

