Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4037E26FB4C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRLVZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRLVZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 07:21:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40BFC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 04:21:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJESA-006Dej-6t; Fri, 18 Sep 2020 13:21:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix some encapsulation offload kernel-doc
Date:   Fri, 18 Sep 2020 13:21:16 +0200
Message-Id: <20200918132115.d46a0915ba8a.Ibba536d04a5a5fb655f8ef6e51b247457bfda4ca@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f0908b567d65..e90089d104b0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1690,6 +1690,8 @@ enum ieee80211_offload_flags {
  * @txq: the multicast data TX queue (if driver uses the TXQ abstraction)
  * @txqs_stopped: per AC flag to indicate that intermediate TXQs are stopped,
  *	protected by fq->lock.
+ * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
+ *	&enum ieee80211_offload_flags.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -3864,7 +3866,7 @@ enum ieee80211_reconfig_type {
  * @set_tid_config: Apply TID specific configurations. This callback may sleep.
  * @reset_tid_config: Reset TID specific configuration for the peer.
  *	This callback may sleep.
- * @update_vif_config: Update virtual interface offload flags
+ * @update_vif_offload: Update virtual interface offload flags
  *	This callback may sleep.
  * @sta_set_4addr: Called to notify the driver when a station starts/stops using
  *	4-address mode
-- 
2.26.2

