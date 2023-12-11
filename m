Return-Path: <linux-wireless+bounces-598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB3B80BACD
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1D8280E11
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98DD526;
	Sun, 10 Dec 2023 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHdBDEWJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E64C4
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213508; x=1733749508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JqmiDlaAZ+gDyxapXv7YMx3OV/sjgctOJrjiKJtSZDw=;
  b=fHdBDEWJe0oy6xlaPEZ+o/jJ2S0irzdjcuTY/hyPAyA104xgiFYMb3g0
   NNTVp9GA/f0XCQYHVfJa7FRPwrQW4DvM5npC/uKZ2zfblIyf0Rg/eBb9n
   PZFz+Prv5hYfG9NfbH3+BvVNAVFQtFXLhDtOKPXxqw0F7yg9e0jwvo70w
   /CMT+20WUbYemipbmyoXGBSQcWm/bXeOgOc+JuMYHB0LBVXIUHzjOYyWz
   58hq46cCCYJnDqt4Cqfokq/bw2GNvbp2d/JyvMW/1GuQzQOZKl0pFH6IQ
   dvEYjKRrOWVkoBVl2YcmPpfrJjzN3mDUxIJGm04XMuxTUBNuvKnjxjyDr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480745659"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480745659"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748925496"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748925496"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>
Subject: [PATCH 03/14] wifi: mac80211: update some locking documentation
Date: Mon, 11 Dec 2023 09:05:21 +0200
Message-Id: <20231211085121.24fa44c7eeb4.I8c9e030ddd78e07c99dd21fe1d5156555390f92e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With the locking rework, more functions need to be called
with the wiphy mutex held. Document that, and for that use
the "Context" description that shows up more nicely in the
generated documentation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 580781ff9dcf..aa8e1055fc3a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5809,12 +5809,11 @@ void ieee80211_set_key_rx_seq(struct ieee80211_key_conf *keyconf,
  * ieee80211_remove_key - remove the given key
  * @keyconf: the parameter passed with the set key
  *
+ * Context: Must be called with the wiphy mutex held.
+ *
  * Remove the given key. If the key was uploaded to the hardware at the
  * time this function is called, it is not deleted in the hardware but
  * instead assumed to have been removed already.
- *
- * Note that due to locking considerations this function can (currently)
- * only be called during key iteration (ieee80211_iter_keys().)
  */
 void ieee80211_remove_key(struct ieee80211_key_conf *keyconf);
 
@@ -6368,12 +6367,12 @@ ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
  * @iter: iterator function that will be called for each key
  * @iter_data: custom data to pass to the iterator function
  *
+ * Context: Must be called with wiphy mutex held; can sleep.
+ *
  * This function can be used to iterate all the keys known to
  * mac80211, even those that weren't previously programmed into
  * the device. This is intended for use in WoWLAN if the device
- * needs reprogramming of the keys during suspend. Note that due
- * to locking reasons, it is also only safe to call this at few
- * spots since it must hold the RTNL and be able to sleep.
+ * needs reprogramming of the keys during suspend.
  *
  * The order in which the keys are iterated matches the order
  * in which they were originally installed and handed to the
@@ -7435,6 +7434,9 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
  * @vif: interface to set active links on
  * @active_links: the new active links bitmap
  *
+ * Context: Must be called with wiphy mutex held; may sleep; calls
+ *	back into the driver.
+ *
  * This changes the active links on an interface. The interface
  * must be in client mode (in AP mode, all links are always active),
  * and @active_links must be a subset of the vif's valid_links.
@@ -7442,6 +7444,7 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
  * If a link is switched off and another is switched on at the same
  * time (e.g. active_links going from 0x1 to 0x10) then you will get
  * a sequence of calls like
+ *
  *  - change_vif_links(0x11)
  *  - unassign_vif_chanctx(link_id=0)
  *  - change_sta_links(0x11) for each affected STA (the AP)
@@ -7451,10 +7454,6 @@ static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
  *  - change_sta_links(0x10) for each affected STA (the AP)
  *  - assign_vif_chanctx(link_id=4)
  *  - change_vif_links(0x10)
- *
- * Note: This function acquires some mac80211 locks and must not
- *	 be called with any driver locks held that could cause a
- *	 lock dependency inversion. Best call it without locks.
  */
 int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links);
 
-- 
2.34.1


