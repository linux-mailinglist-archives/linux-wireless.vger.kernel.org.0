Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F914EB83
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgAaLNP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55812 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728407AbgAaLNP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:15 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEb-0002GC-0z; Fri, 31 Jan 2020 13:13:13 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:45 +0200
Message-Id: <20200131111300.891737-9-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 08/23] mac80211: he: set rx nss
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

In case of HE, the rx nss is taken from the HE capabilities.
If the supported nss capabilities that are reported by AP for the 11ax
mode in the HE Capabilities element are different from the nss
capabilities that are reported by AP for the vht mode in the vht
Capabilities element, need to use the lowest supported nss.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/vht.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index a7cd22594a14..632f07401850 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -481,12 +481,40 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta)
 
 void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 {
-	u8 ht_rx_nss = 0, vht_rx_nss = 0;
+	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, rx_nss;
 
 	/* if we received a notification already don't overwrite it */
 	if (sta->sta.rx_nss)
 		return;
 
+	if (sta->sta.he_cap.has_he) {
+		int i;
+		u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
+		const struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
+		u16 mcs_160_map =
+			le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
+		u16 mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
+
+		for (i = 7; i >= 0; i--) {
+			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
+
+			if (mcs_160 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+				rx_mcs_160 = i + 1;
+				break;
+			}
+		}
+		for (i = 7; i >= 0; i--) {
+			u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
+
+			if (mcs_80 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+				rx_mcs_80 = i + 1;
+				break;
+			}
+		}
+
+		he_rx_nss = min(rx_mcs_80, rx_mcs_160);
+	}
+
 	if (sta->sta.ht_cap.ht_supported) {
 		if (sta->sta.ht_cap.mcs.rx_mask[0])
 			ht_rx_nss++;
@@ -516,8 +544,9 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 		/* FIXME: consider rx_highest? */
 	}
 
-	ht_rx_nss = max(ht_rx_nss, vht_rx_nss);
-	sta->sta.rx_nss = max_t(u8, 1, ht_rx_nss);
+	rx_nss = max(vht_rx_nss, ht_rx_nss);
+	rx_nss = max(he_rx_nss, rx_nss);
+	sta->sta.rx_nss = max_t(u8, 1, rx_nss);
 }
 
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
-- 
2.24.1

