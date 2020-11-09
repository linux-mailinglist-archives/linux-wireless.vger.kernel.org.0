Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B882AB426
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgKIJ55 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgKIJ54 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:56 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66CDC0613D3
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 01:57:55 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc3vt-004EGg-7E; Mon, 09 Nov 2020 10:57:53 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/8] wireless: remove CONFIG_WIRELESS_WDS
Date:   Mon,  9 Nov 2020 10:57:40 +0100
Message-Id: <20201109105103.7d1e44c50e21.I2c0a1705fd6491d9ba3400c88415ee2c4832ae98@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109095747.113720-1-johannes@sipsolutions.net>
References: <20201109095747.113720-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

WDS has long been superseded by 4-addr AP/client and lacks such
fundamental features like encryption, capability negotiation,
and similar. As such, it was basically always unusable as is.

Back in 2016, in commit 8f20542386c5 ("wireless: deprecate WDS
and disable by default") I disabled it and made the Kconfig option
only available under CONFIG_EXPERT to turn it back on. Since then,
nobody has complained about that, and given the severe limitations
with the code, it's unlikely anyone would have a reason to.

Remove the Kconfig option now, so we can clean up the associated
code in follow-up patches.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/Kconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 170a64e67709..7add2002ff4c 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -18,19 +18,6 @@ menuconfig WLAN
 
 if WLAN
 
-config WIRELESS_WDS
-	bool "mac80211-based legacy WDS support" if EXPERT
-	help
-	  This option enables the deprecated WDS support, the newer
-	  mac80211-based 4-addr AP/client support supersedes it with
-	  a much better feature set (HT, VHT, ...)
-
-	  We plan to remove this option and code, so if you find
-	  that you have to enable it, please let us know on the
-	  linux-wireless@vger.kernel.org mailing list, so we can
-	  help you migrate to 4-addr AP/client (or, if it's really
-	  necessary, give up on our plan of removing it).
-
 source "drivers/net/wireless/admtek/Kconfig"
 source "drivers/net/wireless/ath/Kconfig"
 source "drivers/net/wireless/atmel/Kconfig"
-- 
2.26.2

