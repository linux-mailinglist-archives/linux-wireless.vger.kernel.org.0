Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A382568066C
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 08:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbjA3HXG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 02:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbjA3HXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 02:23:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C638211EAC
        for <linux-wireless@vger.kernel.org>; Sun, 29 Jan 2023 23:23:01 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U6ikpL020865;
        Mon, 30 Jan 2023 07:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=PlmJ6sdt3ghCjo7V1Ly2TmH4/Sm7O4zGNIr5SDKRBAQ=;
 b=p4Li4EL170uqzyMqtUGokozBD8hyWJMLdCIIzP3t0TQc4tmP/66DQzPBlu5rrUT9aWld
 cPAjH0v5O2x0RohwugFKVvp6mHPLpV49CrX5wE/k8WtL9zeYzw5Q3eR5tAtasn13RrwQ
 rOOhWLCrrlcyFxCaM61wJ42lyTHDKFtUBuki8qCNTR0edxd0Mjpan9YNk7BWbcz4P8Qj
 4UMnJmEmRBgcdsI8uqmh1Z9e4/uU0I3jCpk4o6CwlzuX5RkEVFpxH2XhPxYJIGesLu0L
 IIG7Mw4IhU5dyRirm5waAgKBqMkisncKN6Nyq1zE0OfHwlPj6HMI6wuh3C0xOeHd1rYS TQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxajxuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U7MpjC010477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:22:51 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 23:22:51 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v3 2/6] wifi: mac80211: validate and configure puncturing bitmap in start_ap()
Date:   Sun, 29 Jan 2023 23:22:35 -0800
Message-ID: <20230130072239.26345-3-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130072239.26345-1-quic_alokad@quicinc.com>
References: <20230130072239.26345-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zB0i95sk0VIGsUO6bfo5nUME3_jBRdIc
X-Proofpoint-GUID: zB0i95sk0VIGsUO6bfo5nUME3_jBRdIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=650 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300070
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Make puncturing bitmap 32 bit to match NL80211 interface.
- Export ieee80211_valid_disable_subchannel_bitmap() and use it to
validate the puncturing bitmap in AP mode.
- Modify 'change' in ieee80211_start_ap() from u32 to u64 to support
BSS_CHANGED_EHT_PUNCTURING.
- Configure the bitmap in link_conf and notify the driver.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
v3: This patch depends on following,
https://patchwork.kernel.org/project/linux-wireless/patch/20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid/

 include/net/mac80211.h     |  2 +-
 net/mac80211/cfg.c         | 10 +++++++++-
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 10 +++++-----
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 54ffc0cc2918..b1c17c7ac044 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -738,7 +738,7 @@ struct ieee80211_bss_conf {
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
 	bool eht_support;
-	u16 eht_puncturing;
+	u32 eht_puncturing;
 
 	bool csa_active;
 	bool mu_mimo_owner;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 24b8648cfafa..185e218e8668 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1220,7 +1220,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct beacon_data *old;
 	struct ieee80211_sub_if_data *vlan;
-	u32 changed = BSS_CHANGED_BEACON_INT |
+	u64 changed = BSS_CHANGED_BEACON_INT |
 		      BSS_CHANGED_BEACON_ENABLED |
 		      BSS_CHANGED_BEACON |
 		      BSS_CHANGED_P2P_PS |
@@ -1296,6 +1296,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO;
 	}
 
+	if (params->eht_cap) {
+		if (!ieee80211_valid_disable_subchannel_bitmap(
+							&params->punct_bitmap,
+							params->chandef.width))
+			return -EINVAL;
+		link_conf->eht_puncturing = params->punct_bitmap;
+		changed |= BSS_CHANGED_EHT_PUNCTURING;
+	}
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e833d472ff72..6fd14a3930d6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2566,4 +2566,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_eht_cap_elem *eht_cap_ie_elem,
 				    u8 eht_cap_len,
 				    struct link_sta_info *link_sta);
+bool ieee80211_valid_disable_subchannel_bitmap(u32 *bitmap,
+					       enum nl80211_chan_width bw);
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a14a5ea2bffd..50efd5980387 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -119,8 +119,8 @@ static const struct ieee80211_per_bw_puncturing_values per_bw_puncturing[] = {
 	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(320)
 };
 
-static bool ieee80211_valid_disable_subchannel_bitmap(u16 *bitmap,
-						      enum nl80211_chan_width bw)
+bool ieee80211_valid_disable_subchannel_bitmap(u32 *bitmap,
+					       enum nl80211_chan_width bw)
 {
 	u32 idx, i;
 
@@ -206,7 +206,7 @@ ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
 			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
 							 bitmap);
 
-		if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
+		if (ieee80211_valid_disable_subchannel_bitmap((u32 *)&bitmap,
 							      chandef->width))
 			break;
 		link->u.mgd.conn_flags |=
@@ -5638,7 +5638,7 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
 	    extracted == link->conf->eht_puncturing)
 		return true;
 
-	if (!ieee80211_valid_disable_subchannel_bitmap(&bitmap,
+	if (!ieee80211_valid_disable_subchannel_bitmap((u32 *)&bitmap,
 						       link->conf->chandef.width)) {
 		link_info(link,
 			  "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
@@ -7132,7 +7132,7 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 			u16 bitmap;
 
 			bitmap = get_unaligned_le16(disable_subchannel_bitmap);
-			if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
+			if (ieee80211_valid_disable_subchannel_bitmap((u32 *)&bitmap,
 								      link->conf->chandef.width))
 				ieee80211_handle_puncturing_bitmap(link,
 								   eht_oper,
-- 
2.39.0

