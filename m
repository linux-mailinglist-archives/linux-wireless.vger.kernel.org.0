Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2013147D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 16:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgAFPKd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 10:10:33 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:41881 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgAFPKb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 10:10:31 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id F12DC580073;
        Mon,  6 Jan 2020 16:10:29 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/4] update nl80211.h
Date:   Mon,  6 Jan 2020 16:10:23 +0100
Message-Id: <20200106151024.124315-4-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151024.124315-1-markus.theil@tu-ilmenau.de>
References: <20200106151024.124315-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 nl80211.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/nl80211.h b/nl80211.h
index beee59c..5eab191 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -248,6 +248,22 @@
  * %NL80211_ATTR_SAE_PASSWORD.
  */
 
+/**
+ * DOC: VLAN offload support for setting group keys and binding STAs to VLANs
+ *
+ * By setting @NL80211_EXT_FEATURE_VLAN_OFFLOAD flag drivers can indicate they
+ * support offloading VLAN functionality in a manner where the driver exposes a
+ * single netdev that uses VLAN tagged frames and separate VLAN-specific netdevs
+ * can then be added using RTM_NEWLINK/IFLA_VLAN_ID similarly to the Ethernet
+ * case. Frames received from stations that are not assigned to any VLAN are
+ * delivered on the main netdev and frames to such stations can be sent through
+ * that main netdev.
+ *
+ * %NL80211_CMD_NEW_KEY (for group keys), %NL80211_CMD_NEW_STATION, and
+ * %NL80211_CMD_SET_STATION will optionally specify vlan_id using
+ * %NL80211_ATTR_VLAN_ID.
+ */
+
 /**
  * enum nl80211_commands - supported nl80211 commands
  *
@@ -571,6 +587,14 @@
  *	set of BSSID,frequency parameters is used (i.e., either the enforcing
  *	%NL80211_ATTR_MAC,%NL80211_ATTR_WIPHY_FREQ or the less strict
  *	%NL80211_ATTR_MAC_HINT and %NL80211_ATTR_WIPHY_FREQ_HINT).
+ *	Driver shall not modify the IEs specified through %NL80211_ATTR_IE if
+ *	%NL80211_ATTR_MAC is included. However, if %NL80211_ATTR_MAC_HINT is
+ *	included, these IEs through %NL80211_ATTR_IE are specified by the user
+ *	space based on the best possible BSS selected. Thus, if the driver ends
+ *	up selecting a different BSS, it can modify these IEs accordingly (e.g.
+ *	userspace asks the driver to perform PMKSA caching with BSS1 and the
+ *	driver ends up selecting BSS2 with different PMKSA cache entry; RSNIE
+ *	has to get updated with the apt PMKID).
  *	%NL80211_ATTR_PREV_BSSID can be used to request a reassociation within
  *	the ESS in case the device is already associated and an association with
  *	a different BSS is desired.
@@ -2373,6 +2397,9 @@ enum nl80211_commands {
  *	the allowed channel bandwidth configurations. (u8 attribute)
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
  *
+ * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
+ *	(u16).
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2835,6 +2862,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_WIPHY_EDMG_CHANNELS,
 	NL80211_ATTR_WIPHY_EDMG_BW_CONFIG,
 
+	NL80211_ATTR_VLAN_ID,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5484,6 +5513,14 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD: Device wants to do SAE authentication in
  *	station mode (SAE password is passed as part of the connect command).
  *
+ * @NL80211_EXT_FEATURE_VLAN_OFFLOAD: The driver supports a single netdev
+ *	with VLAN tagged frames and separate VLAN-specific netdevs added using
+ *	vconfig similarly to the Ethernet case.
+ *
+ * @NL80211_EXT_FEATURE_AQL: The driver supports the Airtime Queue Limit (AQL)
+ *	feature, which prevents bufferbloat by using the expected transmission
+ *	time to limit the amount of data buffered in the hardware.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5529,6 +5566,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
+	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
+	NL80211_EXT_FEATURE_AQL,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.24.1

