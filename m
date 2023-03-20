Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A466C1C2D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 17:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCTQlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 12:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjCTQlD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 12:41:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734D26CC6
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 09:35:51 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KER7U1007436;
        Mon, 20 Mar 2023 16:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=C8j2QFsaYWezKCdL/4Itq1K9zXukindokHLbX4d7wR4=;
 b=k0PNn2YpRbLDJHUk564knOCr4D5w2Z56Cebh46bkwspExA+xsZrm+LgaP6f3kca5XW7k
 y//VI1IuFs4zXw6WhLSFoo0lwJZeV3b+7zpDKUJwCwV6npohb7FpbNQ86tWy53FrYXM/
 tPMxyvDcJzJaGiuaTVyIAILF0ynTfH1e3Kk9MKg6fcqbV6weIi1NiqYUwW9wAfxlsp09
 eR8VEbWNaoP3Cj3degOw1+fvVfr0vYY3Wsu+XJir2I7b08PbKzaF/rnukiz512e7GCF6
 3Mh5azGdf++dUkirpydhYWYwYj0ThPT/Wl+DTf4uHHXIz5y52aydawSs298mZmm2Awq7 rg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pes8p0cr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:35:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KGZjdt012160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:35:45 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 09:35:43 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH 3/4] wifi: mac80211: notify BSS change upon AP power save change
Date:   Mon, 20 Mar 2023 22:05:21 +0530
Message-ID: <20230320163522.3325587-4-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320163522.3325587-1-quic_mkenna@quicinc.com>
References: <20230320163522.3325587-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IKemyL6kDjBQweUzIYIYNnTBCkP1mEJh
X-Proofpoint-ORIG-GUID: IKemyL6kDjBQweUzIYIYNnTBCkP1mEJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_13,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=984 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Notify BSS change to the drivers upon AP power save
changes through ieee80211_vif_cfg_change_notify().

BSS_CHANGED_PS is reused to notify the AP power save
change, which is currently used only for STA mode.

A new hw flag IEEE80211_HW_SUPPORTS_AP_PS is introduced
for backward compatibility and notify the AP power save
change to the drivers which support AP power save.

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
 include/net/mac80211.h |  7 ++++++-
 net/mac80211/cfg.c     | 23 +++++++++++++++++------
 net/mac80211/debugfs.c |  1 +
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f12edca660ba..963607b64226 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -318,7 +318,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_IDLE: Idle changed for this BSS/interface.
  * @BSS_CHANGED_SSID: SSID changed for this BSS (AP and IBSS mode)
  * @BSS_CHANGED_AP_PROBE_RESP: Probe Response changed for this BSS (AP mode)
- * @BSS_CHANGED_PS: PS changed for this BSS (STA mode)
+ * @BSS_CHANGED_PS: PS changed for this BSS (AP and STA mode)
  * @BSS_CHANGED_TXPOWER: TX power setting changed for this interface
  * @BSS_CHANGED_P2P_PS: P2P powersave settings (CTWindow, opportunistic PS)
  *	changed
@@ -683,6 +683,7 @@ struct ieee80211_fils_discovery {
  *	beamformee
  * @eht_mu_beamformer: in AP-mode, does this BSS enable operation as an EHT MU
  *	beamformer
+ * @ap_ps_enable: enable/disable ap power save.
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -776,6 +777,7 @@ struct ieee80211_bss_conf {
 	bool eht_su_beamformer;
 	bool eht_su_beamformee;
 	bool eht_mu_beamformer;
+	bool ap_ps_enable;
 };
 
 /**
@@ -2646,6 +2648,8 @@ struct ieee80211_txq {
  * @IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX: Hardware/driver handles transmitting
  *	multicast frames on all links, mac80211 should not do that.
  *
+ * @IEEE80211_HW_SUPPORTS_AP_PS: Hardware supports AP power save.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2703,6 +2707,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_CONC_MON_RX_DECAP,
 	IEEE80211_HW_DETECTS_COLOR_COLLISION,
 	IEEE80211_HW_MLO_MCAST_MULTI_LINK_TX,
+	IEEE80211_HW_SUPPORTS_AP_PS,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 657be3d4dfcd..a9aec880721a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1468,6 +1468,7 @@ static int ieee80211_update_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct beacon_data *old;
 	int err;
 	struct ieee80211_bss_conf *link_conf;
+	u32 changed = 0;
 
 	sdata_assert_lock(sdata);
 
@@ -1488,20 +1489,30 @@ static int ieee80211_update_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (!old)
 		return -ENOENT;
 
-	err = ieee80211_assign_beacon(sdata, link, &params->settings.beacon,
-				      NULL, NULL);
-	if (err < 0)
-		return err;
+	if (test_bit(BEACON_VALID, params->valid)) {
+		err = ieee80211_assign_beacon(sdata, link, &params->settings.beacon,
+					      NULL, NULL);
+		if (err < 0)
+			return err;
+
+		changed |= err;
+	}
+
+	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_AP_PS) &&
+	    test_bit(AP_PS_VALID, params->valid)) {
+		sdata->vif.bss_conf.ap_ps_enable = params->settings.ap_ps_enable;
+		changed |= BSS_CHANGED_PS;
+	}
 
 	if (params->settings.beacon.he_bss_color_valid &&
 	    params->settings.beacon.he_bss_color.enabled !=
 	    link_conf->he_bss_color.enabled) {
 		link_conf->he_bss_color.enabled =
 			params->settings.beacon.he_bss_color.enabled;
-		err |= BSS_CHANGED_HE_BSS_COLOR;
+		changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
-	ieee80211_link_info_change_notify(sdata, link, err);
+	ieee80211_vif_cfg_change_notify(sdata, changed);
 	return 0;
 }
 
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index dfb9f55e2685..9cf744917a5f 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -496,6 +496,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_CONC_MON_RX_DECAP),
 	FLAG(DETECTS_COLOR_COLLISION),
 	FLAG(MLO_MCAST_MULTI_LINK_TX),
+	FLAG(SUPPORTS_AP_PS),
 #undef FLAG
 };
 
-- 
2.25.1

