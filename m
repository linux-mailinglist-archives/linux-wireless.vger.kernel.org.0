Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC4D2EC65F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jan 2021 23:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbhAFWsc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jan 2021 17:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbhAFWsc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jan 2021 17:48:32 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37727C061575
        for <linux-wireless@vger.kernel.org>; Wed,  6 Jan 2021 14:47:52 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kxHa9-002h7Y-OE; Wed, 06 Jan 2021 23:47:48 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3] cfg80211/mac80211: fix kernel-doc for SAR APIs
Date:   Wed,  6 Jan 2021 23:47:41 +0100
Message-Id: <20210106234740.96827c18f9bd.I8b9f0a9cbfe186931ef9640046f414371f216914@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

A stray @ caused the kernel-doc parser to not understand
this, fix that. Also add some missing kernel-doc.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 6bdb68cef7bf ("nl80211: add common API to configure SAR power limitations")
Fixes: c534e093d865 ("mac80211: add ieee80211_set_sar_specs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v3:
 * really include mac80211.h change
---
 include/net/cfg80211.h | 5 ++++-
 include/net/mac80211.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9a4bbccddc7f..1b3954afcda4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1756,7 +1756,7 @@ struct cfg80211_sar_specs {
 
 
 /**
- * @struct cfg80211_sar_chan_ranges - sar frequency ranges
+ * struct cfg80211_sar_chan_ranges - sar frequency ranges
  * @start_freq:  start range edge frequency
  * @end_freq:    end range edge frequency
  */
@@ -3972,6 +3972,8 @@ struct mgmt_frame_regs {
  *	This callback may sleep.
  * @reset_tid_config: Reset TID specific configuration for the peer, for the
  *	given TIDs. This callback may sleep.
+ *
+ * @set_sar_specs: Update the SAR (TX power) settings.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4929,6 +4931,7 @@ struct wiphy_iftype_akm_suites {
  * @max_data_retry_count: maximum supported per TID retry count for
  *	configuration through the %NL80211_TID_CONFIG_ATTR_RETRY_SHORT and
  *	%NL80211_TID_CONFIG_ATTR_RETRY_LONG attributes
+ * @sar_capa: SAR control capabilities
  */
 struct wiphy {
 	/* assign these fields before you register the wiphy */
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d315740581f1..2bdbf62f4ecd 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3880,6 +3880,7 @@ enum ieee80211_reconfig_type {
  *	This callback may sleep.
  * @sta_set_4addr: Called to notify the driver when a station starts/stops using
  *	4-address mode
+ * @set_sar_specs: Update the SAR (TX power) settings.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
-- 
2.26.2

