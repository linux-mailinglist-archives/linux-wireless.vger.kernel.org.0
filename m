Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9FA359D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfH3LZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:25:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39438 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727820AbfH3LZB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:25:01 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3f1X-0001lc-9U; Fri, 30 Aug 2019 14:24:59 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:24:47 +0300
Message-Id: <20190830112451.21655-5-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190830112451.21655-1-luca@coelho.fi>
References: <20190830112451.21655-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 4/8] mac80211: Allow user space to register for station Rx authentication
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

To support Pre Association Security Negotiation (PASN) while already
associated to one AP, allow user space to register to Rx authentication
frames, so that the user space logic would be able to receive/handle
authentication frames from a different AP as part of PASN.

Note that it is expected that user space would intelligently register
for Rx authentication frames, i.e., only when PASN is used and configure
a match filter only for PASN authentication algorithm, as otherwise
the MLME functionality of mac80211 would be broken.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 29b9d57df1a3..6eddc5592fc4 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -416,7 +416,20 @@ ieee80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 	},
 	[NL80211_IFTYPE_STATION] = {
 		.tx = 0xffff,
+		/*
+		 * To support Pre Association Security Negotiation (PASN) while
+		 * already associated to one AP, allow user space to register to
+		 * Rx authentication frames, so that the user space logic would
+		 * be able to receive/handle authentication frames from a
+		 * different AP as part of PASN.
+		 * It is expected that user space would intelligently register
+		 * for Rx authentication frames, i.e., only when PASN is used
+		 * and configure a match filter only for PASN authentication
+		 * algorithm, as otherwise the MLME functionality of mac80211
+		 * would be broken.
+		 */
 		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+			BIT(IEEE80211_STYPE_AUTH >> 4) |
 			BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
 	},
 	[NL80211_IFTYPE_AP] = {
-- 
2.23.0.rc1

