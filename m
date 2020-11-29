Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090D82C79C4
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgK2Pdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:33:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33602 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726961AbgK2Pdf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:33:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfI-0035ld-Eb; Sun, 29 Nov 2020 17:31:04 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:52 +0200
Message-Id: <iwlwifi.20201129172929.b503adccce6a.Ie684e1d3039c111bf2d521bf762aaec3f7a24d2e@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/13] ieee80211: update reduced neighbor report TBTT info length
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

A new field (20MHz PSD - 1 byte) was added to the RNR TBTT info field.
Adjust the expected TBTT info length accordingly.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/linux/ieee80211.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 9b99a5afe097..37b7dde6173d 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3837,15 +3837,15 @@ static inline bool for_each_element_completed(const struct element *element,
 #define WLAN_RSNX_CAPA_SAE_H2E BIT(5)
 
 /*
- * reduced neighbor report, based on Draft P802.11ax_D5.0,
- * section 9.4.2.170
+ * reduced neighbor report, based on Draft P802.11ax_D6.1,
+ * section 9.4.2.170 and accepted contributions.
  */
 #define IEEE80211_AP_INFO_TBTT_HDR_TYPE				0x03
 #define IEEE80211_AP_INFO_TBTT_HDR_FILTERED			0x04
 #define IEEE80211_AP_INFO_TBTT_HDR_COLOC			0x08
 #define IEEE80211_AP_INFO_TBTT_HDR_COUNT			0xF0
-#define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		8
-#define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	12
+#define IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM		9
+#define IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM	13
 
 #define IEEE80211_RNR_TBTT_PARAMS_OCT_RECOMMENDED		0x01
 #define IEEE80211_RNR_TBTT_PARAMS_SAME_SSID			0x02
-- 
2.29.2

