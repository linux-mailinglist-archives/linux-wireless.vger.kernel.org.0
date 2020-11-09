Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E52AB425
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgKIJ54 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbgKIJ54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:56 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13077C0617A6
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 01:57:56 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc3vt-004EGg-OD; Mon, 09 Nov 2020 10:57:53 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/8] carl9170: remove WDS code
Date:   Mon,  9 Nov 2020 10:57:42 +0100
Message-Id: <20201109105103.1e9c64789510.Ifc4f55c8099e7b7c31a8059befe102523d65e945@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109095747.113720-1-johannes@sipsolutions.net>
References: <20201109095747.113720-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The ability to reach this code was hidden behind
CONFIG_WIRELESS_WDS, which was just removed. Clean
up the driver accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/carl9170/mac.c  | 4 ----
 drivers/net/wireless/ath/carl9170/main.c | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/mac.c b/drivers/net/wireless/ath/carl9170/mac.c
index b2eeb9fd68d2..6cdbee5beb07 100644
--- a/drivers/net/wireless/ath/carl9170/mac.c
+++ b/drivers/net/wireless/ath/carl9170/mac.c
@@ -329,10 +329,6 @@ int carl9170_set_operating_mode(struct ar9170 *ar)
 			/* iwlagn 802.11n STA Workaround */
 			rx_ctrl |= AR9170_MAC_RX_CTRL_PASS_TO_HOST;
 			break;
-		case NL80211_IFTYPE_WDS:
-			cam_mode |= AR9170_MAC_CAM_AP_WDS;
-			rx_ctrl |= AR9170_MAC_RX_CTRL_PASS_TO_HOST;
-			break;
 		case NL80211_IFTYPE_STATION:
 			cam_mode |= AR9170_MAC_CAM_STA;
 			rx_ctrl |= AR9170_MAC_RX_CTRL_PASS_TO_HOST;
diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
index dbef9d8fc893..cca3b086aa70 100644
--- a/drivers/net/wireless/ath/carl9170/main.c
+++ b/drivers/net/wireless/ath/carl9170/main.c
@@ -646,7 +646,6 @@ static int carl9170_op_add_interface(struct ieee80211_hw *hw,
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_AP:
 			if ((vif->type == NL80211_IFTYPE_STATION) ||
-			    (vif->type == NL80211_IFTYPE_WDS) ||
 			    (vif->type == NL80211_IFTYPE_AP) ||
 			    (vif->type == NL80211_IFTYPE_MESH_POINT))
 				break;
-- 
2.26.2

