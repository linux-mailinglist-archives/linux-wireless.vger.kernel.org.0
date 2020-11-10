Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF162AD1B7
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 09:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgKJItT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 03:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgKJItT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 03:49:19 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CEFC0613CF
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 00:49:18 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kcPL2-004pBx-6Y; Tue, 10 Nov 2020 09:49:16 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: fix kernel-doc warning in the new SAE attribute
Date:   Tue, 10 Nov 2020 09:49:11 +0100
Message-Id: <20201110094911.bb020e863aa0.I960caf90e2a8cc23f6bf9245d77524df6a4d8f37@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Format the items as a definition list, to avoid the warning
from the rst parsing.

Fixes: 9f0ffa418483 ("cfg80211: Add support to configure SAE PWE value to drivers")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ff804a8bc1d..9678d32dae83 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1008,14 +1008,21 @@ struct survey_info {
  * @sae_pwd: password for SAE authentication (for devices supporting SAE
  *	offload)
  * @sae_pwd_len: length of SAE password (for devices supporting SAE offload)
- * @sae_pwe: The mechanisms allowed for SAE PWE derivation
- *	NL80211_SAE_PWE_UNSPECIFIED: Not-specified, used to indicate userspace
- *		did not specify any preference. The driver should follow its
- *		internal policy in such a scenario.
- *	NL80211_SAE_PWE_HUNT_AND_PECK: Allow hunting-and-pecking loop only
- *	NL80211_SAE_PWE_HASH_TO_ELEMENT: Allow hash-to-element only
- *	NL80211_SAE_PWE_BOTH: Allow either hunting-and-pecking loop
- *		or hash-to-element
+ * @sae_pwe: The mechanisms allowed for SAE PWE derivation:
+ *
+ *	NL80211_SAE_PWE_UNSPECIFIED
+ *	  Not-specified, used to indicate userspace did not specify any
+ *	  preference. The driver should follow its internal policy in
+ *	  such a scenario.
+ *
+ *	NL80211_SAE_PWE_HUNT_AND_PECK
+ *	  Allow hunting-and-pecking loop only
+ *
+ *	NL80211_SAE_PWE_HASH_TO_ELEMENT
+ *	  Allow hash-to-element only
+ *
+ *	NL80211_SAE_PWE_BOTH
+ *	  Allow either hunting-and-pecking loop or hash-to-element
  */
 struct cfg80211_crypto_settings {
 	u32 wpa_versions;
-- 
2.26.2

