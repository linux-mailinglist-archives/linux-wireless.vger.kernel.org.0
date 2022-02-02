Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01CC4A6D4D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245240AbiBBIuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:07 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37938 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245235AbiBBIuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:06 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL2-0004v8-J7;
        Wed, 02 Feb 2022 10:50:05 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:41 +0200
Message-Id: <iwlwifi.20220202104617.e974b7b3b217.I732cc7f770c7fa06e4840adb5d45d7ee99ac8eb5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/14] mac80211: vht: use HE macros for parsing HE capabilities
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

IEEE80211_VHT_MCS_NOT_SUPPORTED and IEEE80211_HE_MCS_NOT_SUPPORTED
have the same value so no real bug, but for code integrity use the
HE macros for parsing HE capabilities.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/vht.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index e856f9092137..a45dacde96f7 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -501,7 +501,7 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 		for (i = 7; i >= 0; i--) {
 			u8 mcs_160 = (mcs_160_map >> (2 * i)) & 3;
 
-			if (mcs_160 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+			if (mcs_160 != IEEE80211_HE_MCS_NOT_SUPPORTED) {
 				rx_mcs_160 = i + 1;
 				break;
 			}
@@ -509,7 +509,7 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 		for (i = 7; i >= 0; i--) {
 			u8 mcs_80 = (mcs_80_map >> (2 * i)) & 3;
 
-			if (mcs_80 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+			if (mcs_80 != IEEE80211_HE_MCS_NOT_SUPPORTED) {
 				rx_mcs_80 = i + 1;
 				break;
 			}
-- 
2.34.1

