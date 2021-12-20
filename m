Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6B47B096
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 16:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhLTPso (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 10:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhLTPsn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 10:48:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9ECC061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 07:48:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F004B80EE9
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 15:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A63C36AE5;
        Mon, 20 Dec 2021 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640015319;
        bh=y5DeE3tLutHa8QcgZ+MmTHS8datxRRU/WrFpOIxfX20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2tiRvdOyGZW8+65Sq9vp4UFVYg1K6Oal8DSOhuG+C8BkWVF6v7HTgs5+0A+Dz6xq
         e5Yc3oC7vXsEHOZnOOEXP2d1u/1+41wfPqtq1BzQlDbi8nedLeY5sfoiKt3lyjLtTs
         s+3Zwjv4zVE9S3Gwy8HfbXoQ9FBy1GhsewRKW0Cnhm7J9XIVlyRONvcaoUHSVQJL7W
         a2uH44Uj9849DBXztUZPvFGHS6wSK3LKOy7uxg9lXe5d4/dLeclSa30bmlK+1qmV1b
         Tb/oiSmp5ONKdcGOfmD2beMe00yJ8wpxmq6Axxxv2dDAbvUt2Wc0Bvohe2TBw6tjMS
         WHWKMkOrqyiRA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     j@w1.fi
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org,
        nbd@nbd.name, ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 1/9] Sync include/uapi/linux/nl80211.h with mac80211-next.git
Date:   Mon, 20 Dec 2021 16:48:16 +0100
Message-Id: <47673578aceca9726e4ca724eadbccce1c4d67fb.1640014128.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640014128.git.lorenzo@kernel.org>
References: <cover.1640014128.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 src/drivers/driver_nl80211_event.c |   7 +
 src/drivers/nl80211_copy.h         | 228 +++++++++++++++++++++++++++--
 2 files changed, 225 insertions(+), 10 deletions(-)

diff --git a/src/drivers/driver_nl80211_event.c b/src/drivers/driver_nl80211_event.c
index 0f0a01d01..c920ea382 100644
--- a/src/drivers/driver_nl80211_event.c
+++ b/src/drivers/driver_nl80211_event.c
@@ -172,6 +172,13 @@ static const char * nl80211_command_to_string(enum nl80211_commands cmd)
 	C2S(NL80211_CMD_UNPROT_BEACON)
 	C2S(NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS)
 	C2S(NL80211_CMD_SET_SAR_SPECS)
+	C2S(NL80211_CMD_OBSS_COLOR_COLLISION)
+	C2S(NL80211_CMD_COLOR_CHANGE_REQUEST)
+	C2S(NL80211_CMD_COLOR_CHANGE_STARTED)
+	C2S(NL80211_CMD_COLOR_CHANGE_ABORTED)
+	C2S(NL80211_CMD_COLOR_CHANGE_COMPLETED)
+	C2S(NL80211_CMD_SET_FILS_AAD)
+	C2S(NL80211_CMD_ASSOC_COMEBACK)
 	C2S(__NL80211_CMD_AFTER_LAST)
 	}
 #undef C2S
diff --git a/src/drivers/nl80211_copy.h b/src/drivers/nl80211_copy.h
index f962c06e9..f1a9d6594 100644
--- a/src/drivers/nl80211_copy.h
+++ b/src/drivers/nl80211_copy.h
@@ -11,7 +11,7 @@
  * Copyright 2008 Jouni Malinen <jouni.malinen@atheros.com>
  * Copyright 2008 Colin McCabe <colin@cozybit.com>
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -300,6 +300,29 @@
  * the interface goes down.
  */
 
+/**
+ * DOC: FILS shared key crypto offload
+ *
+ * This feature is applicable to drivers running in AP mode.
+ *
+ * FILS shared key crypto offload can be advertised by drivers by setting
+ * @NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD flag. The drivers that support
+ * FILS shared key crypto offload should be able to encrypt and decrypt
+ * association frames for FILS shared key authentication as per IEEE 802.11ai.
+ * With this capability, for FILS key derivation, drivers depend on userspace.
+ *
+ * After FILS key derivation, userspace shares the FILS AAD details with the
+ * driver and the driver stores the same to use in decryption of association
+ * request and in encryption of association response. The below parameters
+ * should be given to the driver in %NL80211_CMD_SET_FILS_AAD.
+ *	%NL80211_ATTR_MAC - STA MAC address, used for storing FILS AAD per STA
+ *	%NL80211_ATTR_FILS_KEK - Used for encryption or decryption
+ *	%NL80211_ATTR_FILS_NONCES - Used for encryption or decryption
+ *			(STA Nonce 16 bytes followed by AP Nonce 16 bytes)
+ *
+ * Once the association is done, the driver cleans the FILS AAD data.
+ */
+
 /**
  * enum nl80211_commands - supported nl80211 commands
  *
@@ -337,7 +360,10 @@
  * @NL80211_CMD_DEL_INTERFACE: Virtual interface was deleted, has attributes
  *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_WIPHY. Can also be sent from
  *	userspace to request deletion of a virtual interface, then requires
- *	attribute %NL80211_ATTR_IFINDEX.
+ *	attribute %NL80211_ATTR_IFINDEX. If multiple BSSID advertisements are
+ *	enabled using %NL80211_ATTR_MBSSID_CONFIG, %NL80211_ATTR_MBSSID_ELEMS,
+ *	and if this command is used for the transmitting interface, then all
+ *	the non-transmitting interfaces are deleted as well.
  *
  * @NL80211_CMD_GET_KEY: Get sequence counter information for a key specified
  *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC.
@@ -1185,6 +1211,32 @@
  *	passed using %NL80211_ATTR_SAR_SPEC. %NL80211_ATTR_WIPHY is used to
  *	specify the wiphy index to be applied to.
  *
+ * @NL80211_CMD_OBSS_COLOR_COLLISION: This notification is sent out whenever
+ *	mac80211/drv detects a bss color collision.
+ *
+ * @NL80211_CMD_COLOR_CHANGE_REQUEST: This command is used to indicate that
+ *	userspace wants to change the BSS color.
+ *
+ * @NL80211_CMD_COLOR_CHANGE_STARTED: Notify userland, that a color change has
+ *	started
+ *
+ * @NL80211_CMD_COLOR_CHANGE_ABORTED: Notify userland, that the color change has
+ *	been aborted
+ *
+ * @NL80211_CMD_COLOR_CHANGE_COMPLETED: Notify userland that the color change
+ *	has completed
+ *
+ * @NL80211_CMD_SET_FILS_AAD: Set FILS AAD data to the driver using -
+ *	&NL80211_ATTR_MAC - for STA MAC address
+ *	&NL80211_ATTR_FILS_KEK - for KEK
+ *	&NL80211_ATTR_FILS_NONCES - for FILS Nonces
+ *		(STA Nonce 16 bytes followed by AP Nonce 16 bytes)
+ *
+ * @NL80211_CMD_ASSOC_COMEBACK: notification about an association
+ *      temporal rejection with comeback. The event includes %NL80211_ATTR_MAC
+ *      to describe the BSSID address of the AP and %NL80211_ATTR_TIMEOUT to
+ *      specify the timeout value.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1417,6 +1469,18 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_SAR_SPECS,
 
+	NL80211_CMD_OBSS_COLOR_COLLISION,
+
+	NL80211_CMD_COLOR_CHANGE_REQUEST,
+
+	NL80211_CMD_COLOR_CHANGE_STARTED,
+	NL80211_CMD_COLOR_CHANGE_ABORTED,
+	NL80211_CMD_COLOR_CHANGE_COMPLETED,
+
+	NL80211_CMD_SET_FILS_AAD,
+
+	NL80211_CMD_ASSOC_COMEBACK,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2413,7 +2477,9 @@ enum nl80211_commands {
  *	space supports external authentication. This attribute shall be used
  *	with %NL80211_CMD_CONNECT and %NL80211_CMD_START_AP request. The driver
  *	may offload authentication processing to user space if this capability
- *	is indicated in the respective requests from the user space.
+ *	is indicated in the respective requests from the user space. (This flag
+ *	attribute deprecated for %NL80211_CMD_START_AP, use
+ *	%NL80211_ATTR_AP_SETTINGS_FLAGS)
  *
  * @NL80211_ATTR_NSS: Station's New/updated  RX_NSS value notified using this
  *	u8 attribute. This is used with %NL80211_CMD_STA_OPMODE_CHANGED.
@@ -2560,6 +2626,39 @@ enum nl80211_commands {
  *	disassoc events to indicate that an immediate reconnect to the AP
  *	is desired.
  *
+ * @NL80211_ATTR_OBSS_COLOR_BITMAP: bitmap of the u64 BSS colors for the
+ *	%NL80211_CMD_OBSS_COLOR_COLLISION event.
+ *
+ * @NL80211_ATTR_COLOR_CHANGE_COUNT: u8 attribute specifying the number of TBTT's
+ *	until the color switch event.
+ * @NL80211_ATTR_COLOR_CHANGE_COLOR: u8 attribute specifying the color that we are
+ *	switching to
+ * @NL80211_ATTR_COLOR_CHANGE_ELEMS: Nested set of attributes containing the IE
+ *	information for the time while performing a color switch.
+ *
+ * @NL80211_ATTR_MBSSID_CONFIG: Nested attribute for multiple BSSID
+ *	advertisements (MBSSID) parameters in AP mode.
+ *	Kernel uses this attribute to indicate the driver's support for MBSSID
+ *	and enhanced multi-BSSID advertisements (EMA AP) to the userspace.
+ *	Userspace should use this attribute to configure per interface MBSSID
+ *	parameters.
+ *	See &enum nl80211_mbssid_config_attributes for details.
+ *
+ * @NL80211_ATTR_MBSSID_ELEMS: Nested parameter to pass multiple BSSID elements.
+ *	Mandatory parameter for the transmitting interface to enable MBSSID.
+ *	Optional for the non-transmitting interfaces.
+ *
+ * @NL80211_ATTR_RADAR_BACKGROUND: Configure dedicated offchannel chain
+ *	available for radar/CAC detection on some hw. This chain can't be used
+ *	to transmit or receive frames and it is bounded to a running wdev.
+ *	Background radar/CAC detection allows to avoid the CAC downtime
+ *	switching on a different channel during CAC detection on the selected
+ *	radar channel.
+ *
+ * @NL80211_ATTR_AP_SETTINGS_FLAGS: u32 attribute contains ap settings flags,
+ *	enumerated in &enum nl80211_ap_settings_flags. This attribute shall be
+ *	used with %NL80211_CMD_START_AP request.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3057,6 +3156,19 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_HE,
 
+	NL80211_ATTR_OBSS_COLOR_BITMAP,
+
+	NL80211_ATTR_COLOR_CHANGE_COUNT,
+	NL80211_ATTR_COLOR_CHANGE_COLOR,
+	NL80211_ATTR_COLOR_CHANGE_ELEMS,
+
+	NL80211_ATTR_MBSSID_CONFIG,
+	NL80211_ATTR_MBSSID_ELEMS,
+
+	NL80211_ATTR_RADAR_BACKGROUND,
+
+	NL80211_ATTR_AP_SETTINGS_FLAGS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3650,11 +3762,12 @@ enum nl80211_mpath_info {
  *     capabilities IE
  * @NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE: HE PPE thresholds information as
  *     defined in HE capabilities IE
- * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band HE capability attribute currently
- *     defined
  * @NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA: HE 6GHz band capabilities (__le16),
  *	given for all 6 GHz band channels
+ * @NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS: vendor element capabilities that are
+ *	advertised on this band/for this iftype (binary)
  * @__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST: internal use
+ * @NL80211_BAND_IFTYPE_ATTR_MAX: highest band attribute currently defined
  */
 enum nl80211_band_iftype_attr {
 	__NL80211_BAND_IFTYPE_ATTR_INVALID,
@@ -3665,6 +3778,7 @@ enum nl80211_band_iftype_attr {
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_MCS_SET,
 	NL80211_BAND_IFTYPE_ATTR_HE_CAP_PPE,
 	NL80211_BAND_IFTYPE_ATTR_HE_6GHZ_CAPA,
+	NL80211_BAND_IFTYPE_ATTR_VENDOR_ELEMS,
 
 	/* keep last */
 	__NL80211_BAND_IFTYPE_ATTR_AFTER_LAST,
@@ -4887,6 +5001,7 @@ enum nl80211_txrate_gi {
  * @NL80211_BAND_60GHZ: around 60 GHz band (58.32 - 69.12 GHz)
  * @NL80211_BAND_6GHZ: around 6 GHz band (5.9 - 7.2 GHz)
  * @NL80211_BAND_S1GHZ: around 900MHz, supported by S1G PHYs
+ * @NL80211_BAND_LC: light communication band (placeholder)
  * @NUM_NL80211_BANDS: number of bands, avoid using this in userspace
  *	since newer kernel versions may support more bands
  */
@@ -4896,6 +5011,7 @@ enum nl80211_band {
 	NL80211_BAND_60GHZ,
 	NL80211_BAND_6GHZ,
 	NL80211_BAND_S1GHZ,
+	NL80211_BAND_LC,
 
 	NUM_NL80211_BANDS,
 };
@@ -5462,7 +5578,7 @@ enum nl80211_iface_limit_attrs {
  *	=> allows 8 of AP/GO that can have BI gcd >= min gcd
  *
  *	numbers = [ #{STA} <= 2 ], channels = 2, max = 2
- *	=> allows two STAs on different channels
+ *	=> allows two STAs on the same or on different channels
  *
  *	numbers = [ #{STA} <= 1, #{P2P-client,P2P-GO} <= 3 ], max = 4
  *	=> allows a STA plus three P2P interfaces
@@ -5644,13 +5760,15 @@ enum nl80211_tdls_operation {
 	NL80211_TDLS_DISABLE_LINK,
 };
 
-/*
+/**
  * enum nl80211_ap_sme_features - device-integrated AP features
- * Reserved for future use, no bits are defined in
- * NL80211_ATTR_DEVICE_AP_SME yet.
+ * @NL80211_AP_SME_SA_QUERY_OFFLOAD: SA Query procedures offloaded to driver
+ *	when user space indicates support for SA Query procedures offload during
+ *	"start ap" with %NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT.
+ */
 enum nl80211_ap_sme_features {
+	NL80211_AP_SME_SA_QUERY_OFFLOAD		= 1 << 0,
 };
- */
 
 /**
  * enum nl80211_feature_flags - device/driver features
@@ -5950,6 +6068,17 @@ enum nl80211_feature_flags {
  *      frame protection for all management frames exchanged during the
  *      negotiation and range measurement procedure.
  *
+ * @NL80211_EXT_FEATURE_BSS_COLOR: The driver supports BSS color collision
+ *	detection and change announcemnts.
+ *
+ * @NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD: Driver running in AP mode supports
+ *	FILS encryption and decryption for (Re)Association Request and Response
+ *	frames. Userspace has to share FILS AAD details to the driver by using
+ *	@NL80211_CMD_SET_FILS_AAD.
+ *
+ * @NL80211_EXT_FEATURE_RADAR_BACKGROUND: Device supports background radar/CAC
+ *	detection.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6014,6 +6143,9 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SECURE_LTF,
 	NL80211_EXT_FEATURE_SECURE_RTT,
 	NL80211_EXT_FEATURE_PROT_RANGE_NEGO_AND_MEASURE,
+	NL80211_EXT_FEATURE_BSS_COLOR,
+	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
+	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
@@ -6912,6 +7044,9 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK: negotiate for LMR feedback. Only
  *	valid if either %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED or
  *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR: optional. The BSS color of the
+ *	responder. Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
+ *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED is set.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -6931,6 +7066,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED,
 	NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED,
 	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
+	NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
@@ -7299,4 +7435,76 @@ enum nl80211_sar_specs_attrs {
 	NL80211_SAR_ATTR_SPECS_MAX = __NL80211_SAR_ATTR_SPECS_LAST - 1,
 };
 
+/**
+ * enum nl80211_mbssid_config_attributes - multiple BSSID (MBSSID) and enhanced
+ * multi-BSSID advertisements (EMA) in AP mode.
+ * Kernel uses some of these attributes to advertise driver's support for
+ * MBSSID and EMA.
+ * Remaining attributes should be used by the userspace to configure the
+ * features.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_INVALID: Invalid
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES: Used by the kernel to advertise
+ *	the maximum number of MBSSID interfaces supported by the driver.
+ *	Driver should indicate MBSSID support by setting
+ *	wiphy->mbssid_max_interfaces to a value more than or equal to 2.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY: Used by the kernel
+ *	to advertise the maximum profile periodicity supported by the driver
+ *	if EMA is enabled. Driver should indicate EMA support to the userspace
+ *	by setting wiphy->ema_max_profile_periodicity to
+ *	a non-zero value.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_INDEX: Mandatory parameter to pass the index of
+ *	this BSS (u8) in the multiple BSSID set.
+ *	Value must be set to 0 for the transmitting interface and non-zero for
+ *	all non-transmitting interfaces. The userspace will be responsible
+ *	for using unique indices for the interfaces.
+ *	Range: 0 to wiphy->mbssid_max_interfaces-1.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX: Mandatory parameter for
+ *	a non-transmitted profile which provides the interface index (u32) of
+ *	the transmitted profile. The value must match one of the interface
+ *	indices advertised by the kernel. Optional if the interface being set up
+ *	is the transmitting one, however, if provided then the value must match
+ *	the interface index of the same.
+ *
+ * @NL80211_MBSSID_CONFIG_ATTR_EMA: Flag used to enable EMA AP feature.
+ *	Setting this flag is permitted only if the driver advertises EMA support
+ *	by setting wiphy->ema_max_profile_periodicity to non-zero.
+ *
+ * @__NL80211_MBSSID_CONFIG_ATTR_LAST: Internal
+ * @NL80211_MBSSID_CONFIG_ATTR_MAX: highest attribute
+ */
+enum nl80211_mbssid_config_attributes {
+	__NL80211_MBSSID_CONFIG_ATTR_INVALID,
+
+	NL80211_MBSSID_CONFIG_ATTR_MAX_INTERFACES,
+	NL80211_MBSSID_CONFIG_ATTR_MAX_EMA_PROFILE_PERIODICITY,
+	NL80211_MBSSID_CONFIG_ATTR_INDEX,
+	NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX,
+	NL80211_MBSSID_CONFIG_ATTR_EMA,
+
+	/* keep last */
+	__NL80211_MBSSID_CONFIG_ATTR_LAST,
+	NL80211_MBSSID_CONFIG_ATTR_MAX = __NL80211_MBSSID_CONFIG_ATTR_LAST - 1,
+};
+
+/**
+ * enum nl80211_ap_settings_flags - AP settings flags
+ *
+ * @NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT: AP supports external
+ *	authentication.
+ * @NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT: Userspace supports SA Query
+ *	procedures offload to driver. If driver advertises
+ *	%NL80211_AP_SME_SA_QUERY_OFFLOAD in AP SME features, userspace shall
+ *	ignore SA Query procedures and validations when this flag is set by
+ *	userspace.
+ */
+enum nl80211_ap_settings_flags {
+	NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT	= 1 << 0,
+	NL80211_AP_SETTINGS_SA_QUERY_OFFLOAD_SUPPORT	= 1 << 1,
+};
+
 #endif /* __LINUX_NL80211_H */
-- 
2.33.1

