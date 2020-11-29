Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06132C79B8
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgK2Pbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33510 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726462AbgK2Pbp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:45 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfC-0035ld-Ep; Sun, 29 Nov 2020 17:30:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:43 +0200
Message-Id: <iwlwifi.20201129172929.69a7f7753444.I405c4b5245145e24577512c477f19131d4036489@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/13] mac80211: he: remove non-bss-conf fields from bss_conf
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

ack_enabled and multi_sta_back_32bit are station capabilities
and should not be in the bss_conf structure.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h | 2 --
 net/mac80211/mlme.c    | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 05c7524bab26..1328b7166460 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -635,9 +635,7 @@ struct ieee80211_fils_discovery {
 struct ieee80211_bss_conf {
 	const u8 *bssid;
 	u8 htc_trig_based_pkt_ext;
-	bool multi_sta_back_32bit;
 	bool uora_exists;
-	bool ack_enabled;
 	u8 uora_ocw_range;
 	u16 frame_time_rts_th;
 	bool he_support;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6adfcb9c06dc..b0afb61d9e84 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3494,14 +3494,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			le32_get_bits(elems->he_operation->he_oper_params,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 
-		bss_conf->multi_sta_back_32bit =
-			sta->sta.he_cap.he_cap_elem.mac_cap_info[2] &
-			IEEE80211_HE_MAC_CAP2_32BIT_BA_BITMAP;
-
-		bss_conf->ack_enabled =
-			sta->sta.he_cap.he_cap_elem.mac_cap_info[2] &
-			IEEE80211_HE_MAC_CAP2_ACK_EN;
-
 		bss_conf->uora_exists = !!elems->uora_element;
 		if (elems->uora_element)
 			bss_conf->uora_ocw_range = elems->uora_element[0];
-- 
2.29.2

