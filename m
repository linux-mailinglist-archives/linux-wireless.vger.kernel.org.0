Return-Path: <linux-wireless+bounces-25974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD7DB10155
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517181891BB1
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C41221736;
	Thu, 24 Jul 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gna96Vl5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C74E12E5B
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340890; cv=none; b=L7IqfkD1vKifqZ981doLo316hkToU5KQOIzaUG1KQSq4d6LqCC31b98nEimOm2RqQ2sBhMb4AhdYOGBJ6Mrn7BhL4uLjPAZF9QukI81sElypchzShnyVwtBMizQsKOrkfgfx6w4O2nwiW8l9M9h7FtSj8SEMiKydurhw486xVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340890; c=relaxed/simple;
	bh=ffsDvJcu/DpE4QA2zikWZzj5FFmXvK6MjW6nC7FVGPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq1wVGNd8JT2cFcuMwUFEr58MxPzwLGiQUW257Qxt88SrKIznl/GfJrRpEuoECMzWY69auFDC2XRR4qjcGEjPn4V+6bOAzgTeabJ8+L17Nh1ompO1beWrvm6KlOgZT5oYId4iEWBbes5Sg4B5SW9HfSIdwDj7ZI5dXfNqV8FoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gna96Vl5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753340889; x=1784876889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ffsDvJcu/DpE4QA2zikWZzj5FFmXvK6MjW6nC7FVGPc=;
  b=Gna96Vl5b2REu/SfXdmVRGHJwpnPcU49qFai0rDQQVK+bGw2oJdl4Qll
   M1gPJfABVXvS9uSJIL817AqDzlp1DKizaF1XswBUa1eAvWWV7z6uvlIfo
   BZPpwIV+lKw1auW7JbUZVBjNLGjFCVcjybGPIqKIWxY6iyp0DJSJNW5+3
   FWPNHD0hV3eM0/9OAtEoQZpHuDVxVXSvhx5r8xs2SfS5n2JP98ao1rgyy
   S8ltcG4Kz+/unWNJ9VF1gt9qiYMCS0yYMNVcvyADkkVp8yunnRxBz05a2
   dTiPfBSMFhdlxIzePJafLLJc2Vn/UM/AohTA0W/ZpNwV7qyxqdCBiwLCH
   w==;
X-CSE-ConnectionGUID: /C46VWymSNmwpBR4hy+40Q==
X-CSE-MsgGUID: XxVROKl7RceSilulUGuXRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55732676"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="55732676"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:08:08 -0700
X-CSE-ConnectionGUID: 8d/uH3I6SJ6Cpt4cDOcOxg==
X-CSE-MsgGUID: wrdous/HR62f879shadgSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="165422654"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO aotchere-mobl1.intel.com) ([10.245.249.251])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:08:06 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	quic_vganneva@quicinc.com,
	maheshkkv@google.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v2 2/4] wifi: nl80211: Add more NAN capabilities
Date: Thu, 24 Jul 2025 13:04:55 +0300
Message-ID: <20250724100457.181825-3-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250724100457.181825-1-andrei.otcheretianski@intel.com>
References: <20250724100457.181825-1-andrei.otcheretianski@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add better break down for NAN capabilities, as NAN has multiple optional
features. This allows to better indicate which features are supported or
or offloaded to the device.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
---
 include/uapi/linux/nl80211.h | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2dfa33926c34..7f291986ed6a 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2935,6 +2935,10 @@ enum nl80211_commands {
  *	%NL80211_CMD_START_NAN and %NL80211_CMD_CHANGE_NAN_CONFIG.
  *	See &enum nl80211_nan_conf_attributes for details.
  *	This attribute is optional.
+ * @NL80211_ATTR_NAN_CAPABILITIES: Nested attribute for NAN capabilities.
+ *	This is used with %NL80211_CMD_GET_WIPHY to indicate the NAN
+ *	capabilities supported by the driver. See &enum nl80211_nan_capabilities
+ *	for details.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -3499,6 +3503,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_SHORT_BEACON,
 
 	NL80211_ATTR_NAN_CONFIG,
+	NL80211_ATTR_NAN_CAPABILITIES,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8290,4 +8295,54 @@ enum nl80211_s1g_short_beacon_attrs {
 		__NL80211_S1G_SHORT_BEACON_ATTR_LAST - 1
 };
 
+/**
+ * enum nl80211_nan_capabilities - NAN (Neighbor Aware Networking)
+ *	capabilities.
+ *
+ * @__NL80211_NAN_CAPABILITIES_INVALID: Invalid.
+ * @NL80211_NAN_CAPA_SYNC_OFFLOAD: Flag attribute indicating that
+ *	NAN synchronization offload is supported. If this capability is set,
+ *	the driver must be able to handle %NL80211_ATTR_NAN_CONFIG
+ *	attribute in the %NL80211_CMD_START_NAN (and change) command.
+ * @NL80211_NAN_CAPA_DE_OFFLOAD: Flag attribute indicating that
+ *	NAN Discovery Engine (DE) offload is supported. Drivers/devices that
+ *	set this capability must be able to handle
+ *	%NL80211_CMD_ADD_NAN_FUNCTION, %NL80211_CMD_DEL_NAN_FUNCTION and
+ *	%NL80211_CMD_NAN_MATCH commands.
+ * @NL80211_NAN_CAPA_DW_NOTIF_SUPPORT: Flag attribute indicating that
+ *	the device supports notifying user space about the upcoming
+ *	discovery window (DW) using %NL80211_CMD_NAN_NEXT_DW_NOTIFICATION.
+ * @NL80211_NAN_CAPA_SUPPORTED_BANDS: u8 bitmask of the supported bands as
+ *	defined in Wifi Aware specification Table 79.(Supported Bands field)
+ * @NL80211_NAN_CAPA_OP_MODE: u8 attribute indicating the supported operation
+ *	modes as defined in Wifi Aware specification Table 81.
+ * @NL80211_NAN_CAPA_NUM_ANTENNAS: u8 attribute indicating the number of
+ *	TX and RX antennas supported by the device. Lower nibble indicates
+ *	the number of TX antennas and upper nibble indicates the number of RX
+ *	antennas. See table 79 of Wifi Aware specification (Number of Antennas)
+ * @NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME: u16 attribute indicating the
+ *	maximum time in microseconds that the device requires to switch
+ *	channels.
+ * @NL80211_NAN_CAPA_CAPABILITIES: Nested attribute containing the
+ *	capabilities of the device as defined in Wifi Aware
+ *	specification Table 79 (Capabilities field).
+ * @__NL80211_NAN_CAPABILITIES_LAST: Internal
+ * @NL80211_NAN_CAPABILITES_MAX: Highest NAN capability attribute.
+ */
+enum nl80211_nan_capabilities {
+	__NL80211_NAN_CAPABILITIES_INVALID,
+
+	NL80211_NAN_CAPA_SYNC_OFFLOAD,
+	NL80211_NAN_CAPA_DE_OFFLOAD,
+	NL80211_NAN_CAPA_DW_NOTIF_SUPPORT,
+	NL80211_NAN_CAPA_SUPPORTED_BANDS,
+	NL80211_NAN_CAPA_OP_MODE,
+	NL80211_NAN_CAPA_NUM_ANTENNAS,
+	NL80211_NAN_CAPA_MAX_CHANNEL_SWITCH_TIME,
+	NL80211_NAN_CAPA_CAPABILITIES,
+	/* keep last */
+	__NL80211_NAN_CAPABILITIES_LAST,
+	NL80211_NAN_CAPABILITES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
-- 
2.49.0


