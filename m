Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 160CE18F418
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 13:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCWMKg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 08:10:36 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:37698 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgCWMKg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 08:10:36 -0400
Received: from isengard.fritz.box (unknown [87.147.56.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id E2E0358006C;
        Mon, 23 Mar 2020 13:10:32 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/2] iw: update nl80211.h
Date:   Mon, 23 Mar 2020 13:09:58 +0100
Message-Id: <20200323120959.12019-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 nl80211.h | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 2 deletions(-)

diff --git a/nl80211.h b/nl80211.h
index 350ab86..2b69116 100644
--- a/nl80211.h
+++ b/nl80211.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2019 Intel Corporation
+ * Copyright (C) 2018-2020 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -264,6 +264,29 @@
  * %NL80211_ATTR_VLAN_ID.
  */
 
+/**
+ * DOC: TID configuration
+ *
+ * TID config support can be checked in the %NL80211_ATTR_TID_CONFIG
+ * attribute given in wiphy capabilities.
+ *
+ * The necessary configuration parameters are mentioned in
+ * &enum nl80211_tid_config_attr and it will be passed to the
+ * %NL80211_CMD_SET_TID_CONFIG command in %NL80211_ATTR_TID_CONFIG.
+ *
+ * If the configuration needs to be applied for specific peer then the MAC
+ * address of the peer needs to be passed in %NL80211_ATTR_MAC, otherwise the
+ * configuration will be applied for all the connected peers in the vif except
+ * any peers that have peer specific configuration for the TID by default; if
+ * the %NL80211_TID_CONFIG_ATTR_OVERRIDE flag is set, peer specific values
+ * will be overwritten.
+ *
+ * All this configuration is valid only for STA's current connection
+ * i.e. the configuration will be reset to default when the STA connects back
+ * after disconnection/roaming, and this configuration will be cleared when
+ * the interface goes down.
+ */
+
 /**
  * enum nl80211_commands - supported nl80211 commands
  *
@@ -1125,6 +1148,9 @@
  *	peer MAC address and %NL80211_ATTR_FRAME is used to specify the frame
  *	content. The frame is ethernet data.
  *
+ * @NL80211_CMD_SET_TID_CONFIG: Data frame TID specific configuration
+ *	is passed using %NL80211_ATTR_TID_CONFIG attribute.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1349,6 +1375,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_PROBE_MESH_LINK,
 
+	NL80211_CMD_SET_TID_CONFIG,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -1604,7 +1632,8 @@ enum nl80211_commands {
  *	flag is included, then control port frames are sent over NL80211 instead
  *	using %CMD_CONTROL_PORT_FRAME.  If control port routing over NL80211 is
  *	to be used then userspace must also use the %NL80211_ATTR_SOCKET_OWNER
- *	flag.
+ *	flag. When used with %NL80211_ATTR_CONTROL_PORT_NO_PREAUTH, pre-auth
+ *	frames are not forwared over the control port.
  *
  * @NL80211_ATTR_TESTDATA: Testmode data blob, passed through to the driver.
  *	We recommend using nested, driver-specific attributes within this.
@@ -2409,6 +2438,38 @@ enum nl80211_commands {
  *	%NL80211_ATTR_AKM_SUITES are default capabilities if AKM suites not
  *	advertised for a specific interface type.
  *
+ * @NL80211_ATTR_TID_CONFIG: TID specific configuration in a
+ *	nested attribute with &enum nl80211_tid_config_attr sub-attributes;
+ *	on output (in wiphy attributes) it contains only the feature sub-
+ *	attributes.
+ *
+ * @NL80211_ATTR_CONTROL_PORT_NO_PREAUTH: disable preauth frame rx on control
+ *	port in order to forward/receive them as ordinary data frames.
+ *
+ * @NL80211_ATTR_PMK_LIFETIME: Maximum lifetime for PMKSA in seconds (u32,
+ *	dot11RSNAConfigPMKReauthThreshold; 0 is not a valid value).
+ *	An optional parameter configured through %NL80211_CMD_SET_PMKSA.
+ *	Drivers that trigger roaming need to know the lifetime of the
+ *	configured PMKSA for triggering the full vs. PMKSA caching based
+ *	authentication. This timeout helps authentication methods like SAE,
+ *	where PMK gets updated only by going through a full (new SAE)
+ *	authentication instead of getting updated during an association for EAP
+ *	authentication. No new full authentication within the PMK expiry shall
+ *	result in a disassociation at the end of the lifetime.
+ *
+ * @NL80211_ATTR_PMK_REAUTH_THRESHOLD: Reauthentication threshold time, in
+ *	terms of percentage of %NL80211_ATTR_PMK_LIFETIME
+ *	(u8, dot11RSNAConfigPMKReauthThreshold, 1..100). This is an optional
+ *	parameter configured through %NL80211_CMD_SET_PMKSA. Requests the
+ *	driver to trigger a full authentication roam (without PMKSA caching)
+ *	after the reauthentication threshold time, but before the PMK lifetime
+ *	has expired.
+ *
+ *	Authentication methods like SAE need to be able to generate a new PMKSA
+ *	entry without having to force a disconnection after the PMK timeout. If
+ *	no roaming occurs between the reauth threshold and PMK expiration,
+ *	disassociation is still forced.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2877,6 +2938,13 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_IFTYPE_AKM_SUITES,
 
+	NL80211_ATTR_TID_CONFIG,
+
+	NL80211_ATTR_CONTROL_PORT_NO_PREAUTH,
+
+	NL80211_ATTR_PMK_LIFETIME,
+	NL80211_ATTR_PMK_REAUTH_THRESHOLD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4550,6 +4618,7 @@ enum nl80211_key_default_types {
  *	See &enum nl80211_key_default_types.
  * @NL80211_KEY_MODE: the mode from enum nl80211_key_mode.
  *	Defaults to @NL80211_KEY_RX_TX.
+ * @NL80211_KEY_DEFAULT_BEACON: flag indicating default Beacon frame key
  *
  * @__NL80211_KEY_AFTER_LAST: internal
  * @NL80211_KEY_MAX: highest key attribute
@@ -4565,6 +4634,7 @@ enum nl80211_key_attributes {
 	NL80211_KEY_TYPE,
 	NL80211_KEY_DEFAULT_TYPES,
 	NL80211_KEY_MODE,
+	NL80211_KEY_DEFAULT_BEACON,
 
 	/* keep last */
 	__NL80211_KEY_AFTER_LAST,
@@ -4720,6 +4790,69 @@ enum nl80211_tx_power_setting {
 	NL80211_TX_POWER_FIXED,
 };
 
+/**
+ * enum nl80211_tid_config - TID config state
+ * @NL80211_TID_CONFIG_ENABLE: Enable config for the TID
+ * @NL80211_TID_CONFIG_DISABLE: Disable config for the TID
+ */
+enum nl80211_tid_config {
+	NL80211_TID_CONFIG_ENABLE,
+	NL80211_TID_CONFIG_DISABLE,
+};
+
+/* enum nl80211_tid_config_attr - TID specific configuration.
+ * @NL80211_TID_CONFIG_ATTR_PAD: pad attribute for 64-bit values
+ * @NL80211_TID_CONFIG_ATTR_VIF_SUPP: a bitmap (u64) of attributes supported
+ *	for per-vif configuration; doesn't list the ones that are generic
+ *	(%NL80211_TID_CONFIG_ATTR_TIDS, %NL80211_TID_CONFIG_ATTR_OVERRIDE).
+ * @NL80211_TID_CONFIG_ATTR_PEER_SUPP: same as the previous per-vif one, but
+ *	per peer instead.
+ * @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribue, if no peer
+ *	is selected, if set indicates that the new configuration overrides
+ *	all previous peer configurations, otherwise previous peer specific
+ *	configurations should be left untouched. If peer is selected then
+ *	it will reset particular TID configuration of that peer and it will
+ *	not accept other TID config attributes along with peer.
+ * @NL80211_TID_CONFIG_ATTR_TIDS: a bitmask value of TIDs (bit 0 to 7)
+ *	Its type is u16.
+ * @NL80211_TID_CONFIG_ATTR_NOACK: Configure ack policy for the TID.
+ *	specified in %NL80211_TID_CONFIG_ATTR_TID. see %enum nl80211_tid_config.
+ *	Its type is u8.
+ * @NL80211_TID_CONFIG_ATTR_RETRY_SHORT: Number of retries used with data frame
+ *	transmission, user-space sets this configuration in
+ *	&NL80211_CMD_SET_TID_CONFIG. It is u8 type, min value is 1 and
+ *	the max value is advertised by the driver in this attribute on
+ *	output in wiphy capabilities.
+ * @NL80211_TID_CONFIG_ATTR_RETRY_LONG: Number of retries used with data frame
+ *	transmission, user-space sets this configuration in
+ *	&NL80211_CMD_SET_TID_CONFIG. Its type is u8, min value is 1 and
+ *	the max value is advertised by the driver in this attribute on
+ *	output in wiphy capabilities.
+ * @NL80211_TID_CONFIG_ATTR_AMPDU_CTRL: Enable/Disable aggregation for the TIDs
+ *	specified in %NL80211_TID_CONFIG_ATTR_TIDS. Its type is u8, using
+ *	the values from &nl80211_tid_config.
+ * @NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL: Enable/Disable RTS_CTS for the TIDs
+ *	specified in %NL80211_TID_CONFIG_ATTR_TIDS. It is u8 type, using
+ *	the values from &nl80211_tid_config.
+ */
+enum nl80211_tid_config_attr {
+	__NL80211_TID_CONFIG_ATTR_INVALID,
+	NL80211_TID_CONFIG_ATTR_PAD,
+	NL80211_TID_CONFIG_ATTR_VIF_SUPP,
+	NL80211_TID_CONFIG_ATTR_PEER_SUPP,
+	NL80211_TID_CONFIG_ATTR_OVERRIDE,
+	NL80211_TID_CONFIG_ATTR_TIDS,
+	NL80211_TID_CONFIG_ATTR_NOACK,
+	NL80211_TID_CONFIG_ATTR_RETRY_SHORT,
+	NL80211_TID_CONFIG_ATTR_RETRY_LONG,
+	NL80211_TID_CONFIG_ATTR_AMPDU_CTRL,
+	NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL,
+
+	/* keep last */
+	__NL80211_TID_CONFIG_ATTR_AFTER_LAST,
+	NL80211_TID_CONFIG_ATTR_MAX = __NL80211_TID_CONFIG_ATTR_AFTER_LAST - 1
+};
+
 /**
  * enum nl80211_packet_pattern_attr - packet pattern attribute
  * @__NL80211_PKTPAT_INVALID: invalid number for nested attribute
@@ -5539,6 +5672,18 @@ enum nl80211_feature_flags {
  *	feature, which prevents bufferbloat by using the expected transmission
  *	time to limit the amount of data buffered in the hardware.
  *
+ * @NL80211_EXT_FEATURE_BEACON_PROTECTION: The driver supports Beacon protection
+ *	and can receive key configuration for BIGTK using key indexes 6 and 7.
+ *
+ * @NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH: The driver can disable the
+ *	forwarding of preauth frames over the control port. They are then
+ *	handled as ordinary data frames.
+ *
+ * @NL80211_EXT_FEATURE_PROTECTED_TWT: Driver supports protected TWT frames
+ *
+ * @NL80211_EXT_FEATURE_DEL_IBSS_STA: The driver supports removing stations
+ *      in IBSS mode, essentially by dropping their state.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5586,6 +5731,10 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 	NL80211_EXT_FEATURE_AQL,
+	NL80211_EXT_FEATURE_BEACON_PROTECTION,
+	NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH,
+	NL80211_EXT_FEATURE_PROTECTED_TWT,
+	NL80211_EXT_FEATURE_DEL_IBSS_STA,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -6208,12 +6357,14 @@ enum nl80211_ftm_responder_stats {
  * @NL80211_PREAMBLE_HT: HT preamble
  * @NL80211_PREAMBLE_VHT: VHT preamble
  * @NL80211_PREAMBLE_DMG: DMG preamble
+ * @NL80211_PREAMBLE_HE: HE preamble
  */
 enum nl80211_preamble {
 	NL80211_PREAMBLE_LEGACY,
 	NL80211_PREAMBLE_HT,
 	NL80211_PREAMBLE_VHT,
 	NL80211_PREAMBLE_DMG,
+	NL80211_PREAMBLE_HE,
 };
 
 /**
@@ -6406,6 +6557,10 @@ enum nl80211_peer_measurement_attrs {
  *	is valid)
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST: u32 attribute indicating
  *	the maximum FTMs per burst (if not present anything is valid)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED: flag attribute indicating if
+ *	trigger based ranging measurement is supported
+ * @NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED: flag attribute indicating
+ *	if non trigger based ranging measurement is supported
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -6421,6 +6576,8 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_BANDWIDTHS,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_BURSTS_EXPONENT,
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_FTMS_PER_BURST,
+	NL80211_PMSR_FTM_CAPA_ATTR_TRIGGER_BASED,
+	NL80211_PMSR_FTM_CAPA_ATTR_NON_TRIGGER_BASED,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
@@ -6450,6 +6607,20 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI: request LCI data (flag)
  * @NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC: request civic location data
  *	(flag)
+ * @NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED: request trigger based ranging
+ *	measurement (flag).
+ *	This attribute and %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED are
+ *	mutually exclusive.
+ *      if neither %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED nor
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set, EDCA based
+ *	ranging will be used.
+ * @NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED: request non trigger based
+ *	ranging measurement (flag)
+ *	This attribute and %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED are
+ *	mutually exclusive.
+ *      if neither %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED nor
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set, EDCA based
+ *	ranging will be used.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -6466,6 +6637,8 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES,
 	NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI,
 	NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC,
+	NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED,
+	NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
-- 
2.25.2

