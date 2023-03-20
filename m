Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1F6C1CE2
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 17:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjCTQxN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjCTQwv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 12:52:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320EA5EC
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 09:44:41 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KBusmE014207;
        Mon, 20 Mar 2023 16:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=C8j2QFsaYWezKCdL/4Itq1K9zXukindokHLbX4d7wR4=;
 b=K0BUkXf8qVC5GQohz/751ytU4YxCiJ950su5/xhoddP+x1YSQpquMxSmvUBceM2g4j6/
 dxz5kOiiZsp6Qw6YqyoAB5+vUSr+m0MoTYOeB3ChK5QlDiRXWOxjnqLEwVQvv7wjjnIJ
 X4NXQl2cFwkpzdSqzMGOzbxYP6Xk0nY29kkoc+CdIP9pWlCBhF4KXJz3pNut63yyRRpC
 miF5BEjmQewPqR8IyRQ+BbHuLbFQWrgDwlVmi0e9tPXFfGX5XMNPDLG5m1IZSoeySN4Z
 FrWKUc2tk+Y01ZDSrdY/EEYGJ+7wOQb3ZuNeRtskeFzNE8E2JcH7OfvfF71eNMJBul/0 7A== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pepfbgu5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:44:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KGi7TR008450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:44:07 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 09:44:05 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH v2 3/4] wifi: mac80211: notify BSS change upon AP power save change
Date:   Mon, 20 Mar 2023 22:13:33 +0530
Message-ID: <20230320164334.3325886-4-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
References: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 90zdyRZVhKOYBdSTnk71UIoZ2jDHyn5j
X-Proofpoint-ORIG-GUID: 90zdyRZVhKOYBdSTnk71UIoZ2jDHyn5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_13,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=984 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

