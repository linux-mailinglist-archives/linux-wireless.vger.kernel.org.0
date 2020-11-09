Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425072AB427
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgKIJ56 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgKIJ54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:56 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36BC0613CF
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 01:57:55 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc3vu-004EGg-74; Mon, 09 Nov 2020 10:57:54 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/8] b43legacy: remove WDS code
Date:   Mon,  9 Nov 2020 10:57:44 +0100
Message-Id: <20201109105103.daa66065cc71.Ie6280e1606fa9aa892b2a342a62aabd42e241f9c@changeid>
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
 drivers/net/wireless/broadcom/b43legacy/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/main.c b/drivers/net/wireless/broadcom/b43legacy/main.c
index a27125b7922c..7692a2618c97 100644
--- a/drivers/net/wireless/broadcom/b43legacy/main.c
+++ b/drivers/net/wireless/broadcom/b43legacy/main.c
@@ -3381,11 +3381,10 @@ static int b43legacy_op_add_interface(struct ieee80211_hw *hw,
 	unsigned long flags;
 	int err = -EOPNOTSUPP;
 
-	/* TODO: allow WDS/AP devices to coexist */
+	/* TODO: allow AP devices to coexist */
 
 	if (vif->type != NL80211_IFTYPE_AP &&
 	    vif->type != NL80211_IFTYPE_STATION &&
-	    vif->type != NL80211_IFTYPE_WDS &&
 	    vif->type != NL80211_IFTYPE_ADHOC)
 		return -EOPNOTSUPP;
 
@@ -3805,9 +3804,6 @@ static int b43legacy_wireless_init(struct ssb_device *dev)
 	hw->wiphy->interface_modes =
 		BIT(NL80211_IFTYPE_AP) |
 		BIT(NL80211_IFTYPE_STATION) |
-#ifdef CONFIG_WIRELESS_WDS
-		BIT(NL80211_IFTYPE_WDS) |
-#endif
 		BIT(NL80211_IFTYPE_ADHOC);
 	hw->queues = 1; /* FIXME: hardware has more queues */
 	hw->max_rates = 2;
-- 
2.26.2

