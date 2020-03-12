Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C11182A69
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 09:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbgCLIEY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 04:04:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46284 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388074AbgCLIEY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 04:04:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jCIpJ-003oy7-VT; Thu, 12 Mar 2020 09:04:22 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Maital Hahn <maitalm@ti.com>, Hari Nagalla <hnagalla@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wlcore: remove stray plus sign
Date:   Thu, 12 Mar 2020 09:04:08 +0100
Message-Id: <20200312090405.5b1ee546a14b.I0a6a1a4c07a68ed1a435edb9553694bdb844e3a8@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The commit mentioned below added a stray plus sign, likely
due to some conflict resolution (i.e. as a leftover from a
unified diff), which was harmless since it was just used as
an integer constant modifier. Remove it anyway, now that I
stumbled across it.

Fixes: cf33a7728bf2 ("wlcore: mesh: Add support for RX Broadcast Key")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ti/wlcore/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index ed049c9f7e29..f140f7d7f553 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6274,7 +6274,7 @@ static int wl1271_init_ieee80211(struct wl1271 *wl)
 	wl->hw->wiphy->flags |= WIPHY_FLAG_AP_UAPSD |
 				WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 				WIPHY_FLAG_HAS_CHANNEL_SWITCH |
-+				WIPHY_FLAG_IBSS_RSN;
+				WIPHY_FLAG_IBSS_RSN;
 
 	wl->hw->wiphy->features |= NL80211_FEATURE_AP_SCAN;
 
-- 
2.24.1

