Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600BE1E5B5A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgE1JB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 05:01:56 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:32934 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgE1JBz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 05:01:55 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 43ECF580065;
        Thu, 28 May 2020 11:01:50 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/2] iw: update nl80211.h
Date:   Thu, 28 May 2020 11:01:38 +0200
Message-Id: <20200528090139.9879-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 nl80211.h | 94 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/nl80211.h b/nl80211.h
index d1b1d9e..c14666b 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -296,13 +296,14 @@
  *	to get a list of all present wiphys.
  * @NL80211_CMD_SET_WIPHY: set wiphy parameters, needs %NL80211_ATTR_WIPHY or
  *	%NL80211_ATTR_IFINDEX; can be used to set %NL80211_ATTR_WIPHY_NAME,
- *	%NL80211_ATTR_WIPHY_TXQ_PARAMS, %NL80211_ATTR_WIPHY_FREQ (and the
- *	attributes determining the channel width; this is used for setting
- *	monitor mode channel),  %NL80211_ATTR_WIPHY_RETRY_SHORT,
- *	%NL80211_ATTR_WIPHY_RETRY_LONG, %NL80211_ATTR_WIPHY_FRAG_THRESHOLD,
- *	and/or %NL80211_ATTR_WIPHY_RTS_THRESHOLD.
- *	However, for setting the channel, see %NL80211_CMD_SET_CHANNEL
- *	instead, the support here is for backward compatibility only.
+ *	%NL80211_ATTR_WIPHY_TXQ_PARAMS, %NL80211_ATTR_WIPHY_FREQ,
+ *	%NL80211_ATTR_WIPHY_FREQ_OFFSET (and the attributes determining the
+ *	channel width; this is used for setting monitor mode channel),
+ *	%NL80211_ATTR_WIPHY_RETRY_SHORT, %NL80211_ATTR_WIPHY_RETRY_LONG,
+ *	%NL80211_ATTR_WIPHY_FRAG_THRESHOLD, and/or
+ *	%NL80211_ATTR_WIPHY_RTS_THRESHOLD.  However, for setting the channel,
+ *	see %NL80211_CMD_SET_CHANNEL instead, the support here is for backward
+ *	compatibility only.
  * @NL80211_CMD_NEW_WIPHY: Newly created wiphy, response to get request
  *	or rename notification. Has attributes %NL80211_ATTR_WIPHY and
  *	%NL80211_ATTR_WIPHY_NAME.
@@ -351,7 +352,8 @@
  *	%NL80211_ATTR_AUTH_TYPE, %NL80211_ATTR_INACTIVITY_TIMEOUT,
  *	%NL80211_ATTR_ACL_POLICY and %NL80211_ATTR_MAC_ADDRS.
  *	The channel to use can be set on the interface or be given using the
- *	%NL80211_ATTR_WIPHY_FREQ and the attributes determining channel width.
+ *	%NL80211_ATTR_WIPHY_FREQ and %NL80211_ATTR_WIPHY_FREQ_OFFSET, and the
+ *	attributes determining channel width.
  * @NL80211_CMD_NEW_BEACON: old alias for %NL80211_CMD_START_AP
  * @NL80211_CMD_STOP_AP: Stop AP operation on the given interface
  * @NL80211_CMD_DEL_BEACON: old alias for %NL80211_CMD_STOP_AP
@@ -536,11 +538,12 @@
  *	interface. %NL80211_ATTR_MAC is used to specify PeerSTAAddress (and
  *	BSSID in case of station mode). %NL80211_ATTR_SSID is used to specify
  *	the SSID (mainly for association, but is included in authentication
- *	request, too, to help BSS selection. %NL80211_ATTR_WIPHY_FREQ is used
- *	to specify the frequence of the channel in MHz. %NL80211_ATTR_AUTH_TYPE
- *	is used to specify the authentication type. %NL80211_ATTR_IE is used to
- *	define IEs (VendorSpecificInfo, but also including RSN IE and FT IEs)
- *	to be added to the frame.
+ *	request, too, to help BSS selection. %NL80211_ATTR_WIPHY_FREQ +
+ *	%NL80211_ATTR_WIPHY_FREQ_OFFSET is used to specify the frequence of the
+ *	channel in MHz. %NL80211_ATTR_AUTH_TYPE is used to specify the
+ *	authentication type. %NL80211_ATTR_IE is used to define IEs
+ *	(VendorSpecificInfo, but also including RSN IE and FT IEs) to be added
+ *	to the frame.
  *	When used as an event, this reports reception of an Authentication
  *	frame in station and IBSS modes when the local MLME processed the
  *	frame, i.e., it was for the local STA and was received in correct
@@ -595,8 +598,9 @@
  *	requests to connect to a specified network but without separating
  *	auth and assoc steps. For this, you need to specify the SSID in a
  *	%NL80211_ATTR_SSID attribute, and can optionally specify the association
- *	IEs in %NL80211_ATTR_IE, %NL80211_ATTR_AUTH_TYPE, %NL80211_ATTR_USE_MFP,
- *	%NL80211_ATTR_MAC, %NL80211_ATTR_WIPHY_FREQ, %NL80211_ATTR_CONTROL_PORT,
+ *	IEs in %NL80211_ATTR_IE, %NL80211_ATTR_AUTH_TYPE,
+ *	%NL80211_ATTR_USE_MFP, %NL80211_ATTR_MAC, %NL80211_ATTR_WIPHY_FREQ,
+ *	%NL80211_ATTR_WIPHY_FREQ_OFFSET, %NL80211_ATTR_CONTROL_PORT,
  *	%NL80211_ATTR_CONTROL_PORT_ETHERTYPE,
  *	%NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT,
  *	%NL80211_ATTR_CONTROL_PORT_OVER_NL80211, %NL80211_ATTR_MAC_HINT, and
@@ -1160,6 +1164,12 @@
  *	dropped because it did not include a valid MME MIC while beacon
  *	protection was enabled (BIGTK configured in station mode).
  *
+ * @NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS: Report TX status of a control
+ *	port frame transmitted with %NL80211_CMD_CONTROL_PORT_FRAME.
+ *	%NL80211_ATTR_COOKIE identifies the TX command and %NL80211_ATTR_FRAME
+ *	includes the contents of the frame. %NL80211_ATTR_ACK flag is included
+ *	if the recipient acknowledged the frame.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1388,6 +1398,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_UNPROT_BEACON,
 
+	NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -1433,7 +1445,8 @@ enum nl80211_commands {
  *	of &enum nl80211_chan_width, describing the channel width. See the
  *	documentation of the enum for more information.
  * @NL80211_ATTR_CENTER_FREQ1: Center frequency of the first part of the
- *	channel, used for anything but 20 MHz bandwidth
+ *	channel, used for anything but 20 MHz bandwidth. In S1G this is the
+ *	operating channel center frequency.
  * @NL80211_ATTR_CENTER_FREQ2: Center frequency of the second part of the
  *	channel, used only for 80+80 MHz bandwidth
  * @NL80211_ATTR_WIPHY_CHANNEL_TYPE: included with NL80211_ATTR_WIPHY_FREQ
@@ -2480,9 +2493,14 @@ enum nl80211_commands {
  *	entry without having to force a disconnection after the PMK timeout. If
  *	no roaming occurs between the reauth threshold and PMK expiration,
  *	disassociation is still forced.
- *
  * @NL80211_ATTR_RECEIVE_MULTICAST: multicast flag for the
  *	%NL80211_CMD_REGISTER_FRAME command, see the description there.
+ * @NL80211_ATTR_WIPHY_FREQ_OFFSET: offset of the associated
+ *	%NL80211_ATTR_WIPHY_FREQ in positive KHz. Only valid when supplied with
+ *	an %NL80211_ATTR_WIPHY_FREQ_OFFSET.
+ * @NL80211_ATTR_CENTER_FREQ1_OFFSET: Center frequency offset in KHz for the
+ *	first channel segment specified in %NL80211_ATTR_CENTER_FREQ1.
+ * @NL80211_ATTR_SCAN_FREQ_KHZ: nested attribute with KHz frequencies
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -2960,6 +2978,9 @@ enum nl80211_attrs {
 	NL80211_ATTR_PMK_REAUTH_THRESHOLD,
 
 	NL80211_ATTR_RECEIVE_MULTICAST,
+	NL80211_ATTR_WIPHY_FREQ_OFFSET,
+	NL80211_ATTR_CENTER_FREQ1_OFFSET,
+	NL80211_ATTR_SCAN_FREQ_KHZ,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -3682,6 +3703,7 @@ enum nl80211_wmm_rule {
  *	(see &enum nl80211_wmm_rule)
  * @NL80211_FREQUENCY_ATTR_NO_HE: HE operation is not allowed on this channel
  *	in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_OFFSET: frequency offset in KHz
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -3712,6 +3734,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_10MHZ,
 	NL80211_FREQUENCY_ATTR_WMM,
 	NL80211_FREQUENCY_ATTR_NO_HE,
+	NL80211_FREQUENCY_ATTR_OFFSET,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4482,6 +4505,7 @@ enum nl80211_bss_scan_width {
  * @NL80211_BSS_CHAIN_SIGNAL: per-chain signal strength of last BSS update.
  *	Contains a nested array of signal strength attributes (u8, dBm),
  *	using the nesting index as the antenna number.
+ * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4506,6 +4530,7 @@ enum nl80211_bss {
 	NL80211_BSS_PARENT_TSF,
 	NL80211_BSS_PARENT_BSSID,
 	NL80211_BSS_CHAIN_SIGNAL,
+	NL80211_BSS_FREQUENCY_OFFSET,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
@@ -4816,6 +4841,17 @@ enum nl80211_tid_config {
 	NL80211_TID_CONFIG_DISABLE,
 };
 
+/* enum nl80211_tx_rate_setting - TX rate configuration type
+ * @NL80211_TX_RATE_AUTOMATIC: automatically determine TX rate
+ * @NL80211_TX_RATE_LIMITED: limit the TX rate by the TX rate parameter
+ * @NL80211_TX_RATE_FIXED: fix TX rate to the TX rate parameter
+ */
+enum nl80211_tx_rate_setting {
+	NL80211_TX_RATE_AUTOMATIC,
+	NL80211_TX_RATE_LIMITED,
+	NL80211_TX_RATE_FIXED,
+};
+
 /* enum nl80211_tid_config_attr - TID specific configuration.
  * @NL80211_TID_CONFIG_ATTR_PAD: pad attribute for 64-bit values
  * @NL80211_TID_CONFIG_ATTR_VIF_SUPP: a bitmap (u64) of attributes supported
@@ -4851,6 +4887,14 @@ enum nl80211_tid_config {
  * @NL80211_TID_CONFIG_ATTR_AMSDU_CTRL: Enable/Disable MSDU aggregation
  *	for the TIDs specified in %NL80211_TID_CONFIG_ATTR_TIDS.
  *	Its type is u8, using the values from &nl80211_tid_config.
+ * @NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE: This attribute will be useful
+ *	to notfiy the driver that what type of txrate should be used
+ *	for the TIDs specified in %NL80211_TID_CONFIG_ATTR_TIDS. using
+ *	the values form &nl80211_tx_rate_setting.
+ * @NL80211_TID_CONFIG_ATTR_TX_RATE: Data frame TX rate mask should be applied
+ *	with the parameters passed through %NL80211_ATTR_TX_RATES.
+ *	configuration is applied to the data frame for the tid to that connected
+ *	station.
  */
 enum nl80211_tid_config_attr {
 	__NL80211_TID_CONFIG_ATTR_INVALID,
@@ -4865,6 +4909,8 @@ enum nl80211_tid_config_attr {
 	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
 	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
 	NL80211_TID_CONFIG_ATTR_AMSDU_CTRL,
+	NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE,
+	NL80211_TID_CONFIG_ATTR_TX_RATE,
 
 	/* keep last */
 	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
@@ -5707,6 +5753,14 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS: management frame registrations
  *	are possible for multicast frames and those will be reported properly.
  *
+ * @NL80211_EXT_FEATURE_SCAN_FREQ_KHZ: This driver supports receiving and
+ *	reporting scan request with %NL80211_ATTR_SCAN_FREQ_KHZ. In order to
+ *	report %NL80211_ATTR_SCAN_FREQ_KHZ, %NL80211_SCAN_FLAG_FREQ_KHZ must be
+ *	included in the scan request.
+ *
+ * @NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS: The driver
+ *	can report tx status for control port over nl80211 tx operations.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5760,6 +5814,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_DEL_IBSS_STA,
 	NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS,
 	NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT,
+	NL80211_EXT_FEATURE_SCAN_FREQ_KHZ,
+	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_TX_STATUS,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -5871,6 +5927,9 @@ enum nl80211_timeout_reason {
  * @NL80211_SCAN_FLAG_MIN_PREQ_CONTENT: minimize probe request content to
  *	only have supported rates and no additional capabilities (unless
  *	added by userspace explicitly.)
+ * @NL80211_SCAN_FLAG_FREQ_KHZ: report scan results with
+ *	%NL80211_ATTR_SCAN_FREQ_KHZ. This also means
+ *	%NL80211_ATTR_SCAN_FREQUENCIES will not be included.
  */
 enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_LOW_PRIORITY				= 1<<0,
@@ -5886,6 +5945,7 @@ enum nl80211_scan_flags {
 	NL80211_SCAN_FLAG_HIGH_ACCURACY				= 1<<10,
 	NL80211_SCAN_FLAG_RANDOM_SN				= 1<<11,
 	NL80211_SCAN_FLAG_MIN_PREQ_CONTENT			= 1<<12,
+	NL80211_SCAN_FLAG_FREQ_KHZ				= 1<<13,
 };
 
 /**
-- 
2.26.2

