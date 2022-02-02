Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3F4A6D47
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbiBBIuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:07 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37940 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245225AbiBBIuH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:07 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL3-0004v8-AQ;
        Wed, 02 Feb 2022 10:50:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:42 +0200
Message-Id: <iwlwifi.20220202104617.f1bafd0861b7.I566612d99bca5245dc06cbcc70369b94a525389c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/14] mac80211: mlme: add documentation from spec to code
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Reference the spec why we decline HE support in
case STA don't support all HE basic rates recurred by AP.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 291226a1599d..bf777943cacd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5052,7 +5052,15 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 
 			/*
 			 * Make sure the HE AP doesn't require MCSs that aren't
-			 * supported by the client
+			 * supported by the client as required by spec
+			 *
+			 * P802.11-REVme/D0.3
+			 * 26.17.1 Basic HE BSS operation
+			 *
+			 * An HE STA shall not attempt to join * (MLME-JOIN.request primitive)
+			 * a BSS, unless it supports (i.e., is able to both transmit and
+			 * receive using) all of the <HE-MCS, NSS> tuples in the basic
+			 * HE-MCS and NSS set.
 			 */
 			if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
 			    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-- 
2.34.1

