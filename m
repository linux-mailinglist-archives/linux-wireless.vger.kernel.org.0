Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748251B7222
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXKjz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXKjz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:39:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54091C09B045
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 03:39:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jRvkP-00FTFP-A3; Fri, 24 Apr 2020 12:39:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix two missing documentation entries
Date:   Fri, 24 Apr 2020 12:39:46 +0200
Message-Id: <20200424123945.6b23a26ab5e7.I664440ab5f33442df8103253bf5b9fe84be8d58c@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add documentation for two struct entries that was missing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h  | 2 ++
 net/mac80211/sta_info.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 2936049f918e..ecb219e3ec4f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -820,6 +820,8 @@ enum mac80211_tx_info_flags {
  * @IEEE80211_TX_CTRL_AMSDU: This frame is an A-MSDU frame
  * @IEEE80211_TX_CTRL_FAST_XMIT: This frame is going through the fast_xmit path
  * @IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP: This frame skips mesh path lookup
+ * @IEEE80211_TX_CTRL_HW_80211_ENCAP: This frame uses hardware encapsulation
+ *	(header conversion)
  *
  * These flags are used in tx_info->control.flags.
  */
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index a5de3aa6ea42..49728047dfad 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -69,6 +69,8 @@
  * @WLAN_STA_MPSP_RECIPIENT: local STA is recipient of a MPSP.
  * @WLAN_STA_PS_DELIVER: station woke up, but we're still blocking TX
  *	until pending frames are delivered
+ * @WLAN_STA_USES_ENCRYPTION: This station was configured for encryption,
+ *	so drop all packets without a key later.
  *
  * @NUM_WLAN_STA_FLAGS: number of defined flags
  */
-- 
2.25.1

