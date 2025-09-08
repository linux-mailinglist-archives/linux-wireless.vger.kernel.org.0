Return-Path: <linux-wireless+bounces-27086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74091B48BE1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E63A48FB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD633009E2;
	Mon,  8 Sep 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt0xHDDP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5F7301011
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330025; cv=none; b=TPXQvzrzTEZoq61NdHqa0KRPIU+OQqM2MaBT3O/9A5Besrfo9TYdBHDRnDYq3Y/ILxXN+J7OXwAJacmXbgRDr3fCfvgRXSUGJMgXcO+0kk5aSoBGdOxA5BW3GHCmOimJEIrPth4oDbdHOlgkYaDpUxpXecYEiQ6SCQNgufCADPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330025; c=relaxed/simple;
	bh=Jn9rsEPWtxuJlMlhhjYOCtjRdsfnswxApwGoJF+CiOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPuDTNYnP0bNIWWgp77UY4qhFgFQ5cc++PcsRQTo/Q0qiUe+LPwIrPSW6IZH9U3xby/Jt5E177GNiyT5xfWlfNw3h1DyQErkPRgKdxtDfCbTW6BlbH0HeKdYLYvq13jbYK5WxshcV7+rZHgLKpdktOXq7XOg44NCX3oIaQ9sO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt0xHDDP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330024; x=1788866024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jn9rsEPWtxuJlMlhhjYOCtjRdsfnswxApwGoJF+CiOM=;
  b=Zt0xHDDP56B5qt8ea/55zzwnpn8MG8GahgnISjhER5vNrtLIbyZBviB3
   iy/SarqCfM3ns1xrhmpc9ljtKj4+RKIdhXHapLFdEtx0RRdsPoARlyv+Y
   wKkvLvsZe5ImCriitAroyThpzD7W/hqHN9xlQXFRH/vRF/WCK3/a5+1g1
   4rY1wIfnS8RmntczmlShqAiHOIu2wYD5BLnn4l7SGTOo24O2VsNRLI4s9
   UJRff5tztblpnACg7RmlcYbvs1rFWcBdea4jm6nd36GdI707q0Bzt/IeF
   X40sFCVdVOdBdGSMxszab4qS7UePAS9JDSqjG51NB0wSg1LKT4bZX5Z3d
   Q==;
X-CSE-ConnectionGUID: r3Ha69EPQoWlXigWAiGsLg==
X-CSE-MsgGUID: dOgbwHJlRkK/PjgNAAj4Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037890"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037890"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:43 -0700
X-CSE-ConnectionGUID: ROOhM3X5R6umaxOrQ7Mwkg==
X-CSE-MsgGUID: lL5kWNWURt67WEmHr9dn0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126568"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH wireless-next 04/14] wifi: nl80211: Add more NAN capabilities
Date: Mon,  8 Sep 2025 14:12:58 +0300
Message-Id: <20250908140015.bb02cd8c1596.I01fb2e8dc3662b847f3c27117bc4e199fc96d0a3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
References: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Add better break down for NAN capabilities, as NAN has multiple optional
features. This allows to better indicate which features are supported or
or offloaded to the device.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/uapi/linux/nl80211.h | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c5a7658b7297..423e258cdbd2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2964,6 +2964,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_NAN_NEW_CLUSTER: Flag attribute indicating that a new
  *	NAN cluster has been created. This is used with
  *	%NL80211_CMD_NAN_CLUSTER_JOINED
+ * @NL80211_ATTR_NAN_CAPABILITIES: Nested attribute for NAN capabilities.
+ *	This is used with %NL80211_CMD_GET_WIPHY to indicate the NAN
+ *	capabilities supported by the driver. See &enum nl80211_nan_capabilities
+ *	for details.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3529,6 +3533,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_BSS_PARAM,
 	NL80211_ATTR_NAN_CONFIG,
 	NL80211_ATTR_NAN_NEW_CLUSTER,
+	NL80211_ATTR_NAN_CAPABILITIES,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -8362,4 +8367,54 @@ enum nl80211_s1g_short_beacon_attrs {
 		__NL80211_S1G_SHORT_BEACON_ATTR_LAST - 1
 };
 
+/**
+ * enum nl80211_nan_capabilities - NAN (Neighbor Aware Networking)
+ *	capabilities.
+ *
+ * @__NL80211_NAN_CAPABILITIES_INVALID: Invalid.
+ * @NL80211_NAN_CAPA_CONFIGURABLE_SYNC: Flag attribute indicating that
+ *	the device supports configurable synchronization. If set, the device
+ *	should be able to handle %NL80211_ATTR_NAN_CONFIG
+ *	attribute in the %NL80211_CMD_START_NAN (and change) command.
+ * @NL80211_NAN_CAPA_USERSPACE_DE: Flag attribute indicating that
+ *	NAN Discovery Engine (DE) is not offloaded and the driver assumes
+ *	user space DE implementation. When set, %NL80211_CMD_ADD_NAN_FUNCTION,
+ *	%NL80211_CMD_DEL_NAN_FUNCTION and %NL80211_CMD_NAN_MATCH commands
+ *	should not be used. In addition, the device/driver should support
+ *	sending discovery window (DW) notifications using
+ *	%NL80211_CMD_NAN_NEXT_DW_NOTIFICATION and handling transmission and
+ *	reception of NAN SDF frames on NAN device interface during DW windows.
+ *	(%NL80211_CMD_FRAME is used to transmit SDFs)
+ * @NL80211_NAN_CAPA_OP_MODE: u8 attribute indicating the supported operation
+ *	modes as defined in Wi-Fi Aware (TM) specification Table 81 (Operation
+ *	Mode field format).
+ * @NL80211_NAN_CAPA_NUM_ANTENNAS: u8 attribute indicating the number of
+ *	TX and RX antennas supported by the device. Lower nibble indicates
+ *	the number of TX antennas and upper nibble indicates the number of RX
+ *	antennas. Value 0 indicates the information is not available.
+ *	See table 79 of Wi-Fi Aware (TM) specification (Number of
+ *	Antennas field).
+ * @NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME: u16 attribute indicating the
+ *	maximum time in microseconds that the device requires to switch
+ *	channels.
+ * @NL80211_NAN_CAPA_CAPABILITIES: u8 attribute containing the
+ *	capabilities of the device as defined in Wi-Fi Aware (TM)
+ *	specification Table 79 (Capabilities field).
+ * @__NL80211_NAN_CAPABILITIES_LAST: Internal
+ * @NL80211_NAN_CAPABILITIES_MAX: Highest NAN capability attribute.
+ */
+enum nl80211_nan_capabilities {
+	__NL80211_NAN_CAPABILITIES_INVALID,
+
+	NL80211_NAN_CAPA_CONFIGURABLE_SYNC,
+	NL80211_NAN_CAPA_USERSPACE_DE,
+	NL80211_NAN_CAPA_OP_MODE,
+	NL80211_NAN_CAPA_NUM_ANTENNAS,
+	NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME,
+	NL80211_NAN_CAPA_CAPABILITIES,
+	/* keep last */
+	__NL80211_NAN_CAPABILITIES_LAST,
+	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
-- 
2.34.1


