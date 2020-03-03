Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3E17757B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 12:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgCCLug (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 06:50:36 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:59753 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgCCLug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 06:50:36 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 69C14580065;
        Tue,  3 Mar 2020 12:50:34 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/3] nl80211: add monitor mode scan feature
Date:   Tue,  3 Mar 2020 12:50:15 +0100
Message-Id: <20200303115017.9845-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Back in 2007 "mac80211: don't allow scanning in monitor mode"
(f27b62d3e7ec) disabled scanning in monitor mode, because hw
controlled by the zd1211rw driver got confused during this operation.

Nevertheless, it can be useful to scan in monitor mode, e.g.
when building a tool which processes scans, channel surveys and
monitors the channel passively in monitor mode.

This patch adds a feature flag for scanning in monitor mode,
which can be set by hw supporting this feature.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/uapi/linux/nl80211.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b002ef2060fa..062519967e60 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5642,6 +5642,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_BEACON_PROTECTION: The driver supports Beacon protection
  *	and can receive key configuration for BIGTK using key indexes 6 and 7.
  *
+ * @NL80211_EXT_FEATURE_MONITOR_MODE_SCAN: The driver supports scanning while in
+ *	monitor mode.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5690,6 +5693,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 	NL80211_EXT_FEATURE_AQL,
 	NL80211_EXT_FEATURE_BEACON_PROTECTION,
+	NL80211_EXT_FEATURE_MONITOR_MODE_SCAN,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.25.1

