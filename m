Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3C4B1630
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 20:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbiBJTUc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 14:20:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbiBJTU0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 14:20:26 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C625E243
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 11:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1PV0PRsiNEtB1StdhVuHVFsBYW4uLSaPeeWYvbnb73s=;
        t=1644520826; x=1645730426; b=keqz474i6ahwcDTvmb9PZaupwMLOudhg4fwuLnHVn/S8x45
        x13tIijbt5+Syn5SWvgz7nqbxSdECjO2y3fJ5G/G/S5KxNPghkb0y11pIQgkbNWDvUJwjvkrWaVeQ
        quIH+AmPjhjGtJSzg4bTA2b05sGD5A93ag40rLnVR0EguE/ld6Bdgo/Zw8QQKughtaes57wp0wg/J
        iVv+E+37xq5SNFhFCXCeXlWpI7fnR5Tevk4sluy2t3XlOaVwo108HPYab0rTPTpGqTmMXhIg3LZWk
        NdkA3ozY/B9Hv2dljkQcYAO/GgF+KsW+10efSyWwxjG8hBfzSCffaITr0ByK/gxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIEzQ-00HC2X-SU;
        Thu, 10 Feb 2022 20:20:24 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     quic_vikram@quicinc.com, quic_alokad@quicinc.com,
        quic_jiad@quicinc.com, quic_periyasa@quicinc.com,
        quic_msinada@quicinc.com, quic_srirrama@quicinc.com,
        ilan.peer@intel.com,
        Mordechay Goodstein <mordechay.goodstein@intel.com>
Subject: [PATCH v2 17/19] mac80211: calculate max RX NSS for EHT mode
Date:   Thu, 10 Feb 2022 20:20:06 +0100
Message-Id: <20220210201853.205cfae3f088.I54f5a416f0789bf4eefad04703d941b6755f6dd6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210192008.188166-1-johannes@sipsolutions.net>
References: <20220210192008.188166-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

If the station supports EHT mode, calculate the maximum RX NSS
from EHT station capabilities.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/vht.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 409d2fde83bf..8f16aa9c725d 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -497,13 +497,24 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta)
 
 void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 {
-	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, rx_nss;
+	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
 	bool support_160;
 
 	/* if we received a notification already don't overwrite it */
 	if (sta->sta.rx_nss)
 		return;
 
+	if (sta->sta.eht_cap.has_eht) {
+		int i;
+		const u8 *rx_nss_mcs = (void *)&sta->sta.eht_cap.eht_mcs_nss_supp;
+
+		/* get the max nss for EHT over all possible bandwidths and mcs */
+		for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
+			eht_rx_nss = max_t(u8, eht_rx_nss,
+					   u8_get_bits(rx_nss_mcs[i],
+						       IEEE80211_EHT_MCS_NSS_RX));
+	}
+
 	if (sta->sta.he_cap.has_he) {
 		int i;
 		u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
@@ -569,6 +580,7 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 
 	rx_nss = max(vht_rx_nss, ht_rx_nss);
 	rx_nss = max(he_rx_nss, rx_nss);
+	rx_nss = max(eht_rx_nss, rx_nss);
 	sta->sta.rx_nss = max_t(u8, 1, rx_nss);
 }
 
-- 
2.34.1

