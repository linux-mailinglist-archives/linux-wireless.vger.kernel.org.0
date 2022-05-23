Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362FB530AD6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 10:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiEWHqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiEWHqg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 03:46:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161B5319
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291995; x=1684827995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gODjbkNAiqr7YYTSKhZn/JtSF6AkaSsDoz79JBEI2VU=;
  b=hutN0nWrokIaptYRmbyhJKEgySOv37CiOCy3Oo+swgtv6Pfqd8pp7TaM
   d+KVBlENoQjx/9ZNmxxu7cUGgB/DQk3qlG9CU3U3JNOD3ErqkeH02Pf9b
   rOvSXL5Wh2bAk20+0s3YOT5K2j0phD91oiapzU8X2yrb5prxzGc26SKHF
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 May 2022 23:01:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 23:01:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:29 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:28 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 9/9] ath11k: configure WPA and RSN parameters for nontransmitting interface
Date:   Sun, 22 May 2022 23:01:08 -0700
Message-ID: <20220523060108.23982-10-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523060108.23982-1-quic_alokad@quicinc.com>
References: <20220523060108.23982-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Set rsnie_present and wpaie_present fields for the non-transmitting
interfaces when MBSSID is enabled.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 99 ++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4ead94554724..cee505a1bada 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1373,6 +1373,89 @@ static void ath11k_mac_setup_bcn_tmpl_vif_params(struct ath11k_vif *arvif,
 		arvif->wpaie_present = false;
 }
 
+static void ath11k_mac_setup_bcn_tmpl_nontx_vif_rsnie(struct ath11k_vif *arvif,
+						      bool tx_arvif_rsnie_present,
+						      const u8 *profile,
+						      u8 profile_len)
+{
+	if (cfg80211_find_ie(WLAN_EID_RSN, profile, profile_len)) {
+		arvif->rsnie_present = true;
+	} else if (tx_arvif_rsnie_present) {
+		int i;
+		u8 nie_len;
+		const u8 *nie = cfg80211_find_ext_ie(WLAN_EID_EXT_NON_INHERITANCE,
+						     profile, profile_len);
+		if (!nie)
+			return;
+
+		nie_len = nie[1];
+		nie += 2;
+		for (i = 0; i < nie_len; i++) {
+			if (nie[i] == WLAN_EID_RSN) {
+				arvif->rsnie_present = false;
+				break;
+			}
+		}
+	}
+}
+
+static bool ath11k_mac_setup_bcn_tmpl_nontx_vif_params(struct ath11k_vif *tx_arvif,
+						       struct ath11k_vif *arvif,
+						       struct sk_buff *bcn)
+{
+	struct ieee80211_mgmt *mgmt;
+	const u8 *ies, *profile, *next_profile;
+	int ies_len;
+
+	if (arvif == tx_arvif)
+		return true;
+
+	arvif->rsnie_present = tx_arvif->rsnie_present;
+
+	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
+	mgmt = (struct ieee80211_mgmt *)bcn->data;
+	ies += sizeof(mgmt->u.beacon);
+	ies_len = skb_tail_pointer(bcn) - ies;
+
+	ies = cfg80211_find_ie(WLAN_EID_MULTIPLE_BSSID, ies, ies_len);
+
+	while (ies) {
+		u8 mbssid_len;
+
+		ies_len -= (2 + ies[1]);
+		mbssid_len = ies[1] - 1;
+		profile = &ies[3];
+
+		while (mbssid_len) {
+			u8 profile_len;
+
+			profile_len = profile[1];
+			next_profile = profile + (2 + profile_len);
+			mbssid_len -= (2 + profile_len);
+
+			profile += 2;
+			profile_len -= (2 + profile[1]);
+			profile += (2 + profile[1]); /* nontx capabilities */
+			profile_len -= (2 + profile[1]);
+			profile += (2 + profile[1]); /* SSID */
+			if (profile[2] == arvif->vif->bss_conf.bssid_index) {
+				profile_len -= 5;
+				profile = profile + 5;
+				ath11k_mac_setup_bcn_tmpl_nontx_vif_rsnie(arvif,
+									  tx_arvif->rsnie_present,
+									  profile,
+									  profile_len);
+				return true;
+			}
+			profile = next_profile;
+		}
+		ies = cfg80211_find_ie(WLAN_EID_MULTIPLE_BSSID, profile,
+				       ies_len);
+	}
+
+	return false;
+}
+
 static int __ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif,
 				       struct sk_buff *bcn,
 				       struct ieee80211_mutable_offsets offs,
@@ -1399,6 +1482,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 	struct ieee80211_ema_beacons *beacons;
 	u8 i = 0;
 	int ret = 0;
+	bool found_vdev = false;
 
 	if (!arvif->vif->mbssid_tx_vif)
 		return -1;
@@ -1412,11 +1496,21 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 		return -EPERM;
 	}
 
-	if (tx_arvif == arvif)
+	if (tx_arvif == arvif) {
 		ath11k_mac_setup_bcn_tmpl_vif_params(tx_arvif,
 						     beacons->bcn[0].skb);
+		found_vdev = true;
+	} else {
+		arvif->wpaie_present = tx_arvif->wpaie_present;
+	}
 
 	for (i = 0; i < beacons->cnt; i++) {
+		if (!found_vdev)
+			found_vdev =
+				ath11k_mac_setup_bcn_tmpl_nontx_vif_params(tx_arvif,
+									   arvif,
+									   beacons->bcn[i].skb);
+
 		ret = __ath11k_mac_setup_bcn_tmpl(tx_arvif, beacons->bcn[i].skb,
 						  beacons->bcn[i].offs,
 						  i, beacons->cnt);
@@ -1452,6 +1546,9 @@ static int ath11k_mac_setup_bcn_tmpl_non_ema(struct ath11k_vif *arvif)
 
 	if (tx_arvif == arvif)
 		ath11k_mac_setup_bcn_tmpl_vif_params(tx_arvif, bcn);
+	else
+		(void)ath11k_mac_setup_bcn_tmpl_nontx_vif_params(tx_arvif,
+								 arvif, bcn);
 
 	ret = __ath11k_mac_setup_bcn_tmpl(tx_arvif, bcn, offs, 0, 0);
 	if (ret)
-- 
2.31.1

