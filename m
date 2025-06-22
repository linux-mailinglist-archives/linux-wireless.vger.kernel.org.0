Return-Path: <linux-wireless+bounces-24324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF189AE32C9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 00:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575567A6037
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C68219E8C;
	Sun, 22 Jun 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2IU219j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AE6136
	for <linux-wireless@vger.kernel.org>; Sun, 22 Jun 2025 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750631151; cv=none; b=n/q1WncUakKzy/Stb3hc80YvSd5neS2XeCSlGiV29ZKmaDIjftXCGj30lnTlHEQknOqfaEXGXvvp0D3WWDY8fYoa56XsmG/yOfy2JUuLwZKzz26ihxDs0O06ZkU3zglqUromz6OV2V6t8Beun4ZX5LwAEgmohk+7vYqF+LJGlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750631151; c=relaxed/simple;
	bh=Z0xAzXo16psFLMWO7hK98VPX/wnxJMsK7Tyfmua22aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLA06ZyWlhXhUHdthwvOB3IF23ppMHTdJEU6t9mo0baFw02VpwEGpnZfmomBE4l3oOn0loKhbjCr/nsTTS70RNQ5FmFAzLgNxjverMCBe2/WdF9YkmFgysE0YWupIsgnaP5U6YqtbnO0jyT+8MnZenhhMOxf/E2Tqi+rCD0YVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2IU219j; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750631151; x=1782167151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z0xAzXo16psFLMWO7hK98VPX/wnxJMsK7Tyfmua22aM=;
  b=G2IU219jn4V1oVsRVX/PF/7nF8NsBhC4zR9Hktar67nbVawMvtusZtAN
   YPnYJOKeWndnba+GsU1IQZesFFJvIOKrxW9SkXsZURGFaxnkUvHx7Ptyd
   F+SFzit3YoC462HFTTk/QcdSc2+nuBzFXFEHbBM+YWvXqzzRvifXGK6UQ
   hbo8JE3Af8TRyKSWzojVRIUQAjM0WeryxHFkMLdUk4GiJr0nMzVwRgaLc
   DpRo6aHhTpHaUd2gTFmvmJaNwPuW/zW3p55+zELI2ETIMSUni6flTOmFI
   d1RRqIpCudnNt0jc2RgBTKQ2oAdA9gSB9cJ+tKanAuTDNdoLTdYC5JNQO
   g==;
X-CSE-ConnectionGUID: axkRns4kTTO2VEBZekxkaQ==
X-CSE-MsgGUID: qv/RADEXTaK30m4uFHlXsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52916080"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52916080"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:49 -0700
X-CSE-ConnectionGUID: dfFdLD/pS8yKu4vBSjm9ow==
X-CSE-MsgGUID: O30HTqO1Rr6MvVhOMNLrGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="182295701"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.248.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 15:25:46 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC 2/5] wifi: nl80211: Add more NAN capabilities
Date: Mon, 23 Jun 2025 01:24:41 +0300
Message-ID: <20250622222444.356435-3-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
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
 include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a68c486e2083..f2d4a2007463 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2915,6 +2915,10 @@ enum nl80211_commands {
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
@@ -3474,6 +3478,7 @@ enum nl80211_attrs {
 	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
 
 	NL80211_ATTR_NAN_CONFIG,
+	NL80211_ATTR_NAN_CAPABILITIES,
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -8226,4 +8231,35 @@ enum nl80211_wiphy_radio_freq_range {
 	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX = __NL80211_WIPHY_RADIO_FREQ_ATTR_LAST - 1,
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
+ *	NAN Discovery Engine (DE) offload is supported. Drivers/devices that set
+ *	this capability must be able to handle %NL80211_CMD_ADD_NAN_FUNCTION,
+ *	%NL80211_CMD_DEL_NAN_FUNCTION and %NL80211_CMD_NAN_MATCH commands.
+ * @NL80211_NAN_CAPA_DW_NOTIF_SUPPORT: Flag attribute indicating that
+ *	the device supports notifying user space about the upcoming
+ *	discovery window (DW) using %NL80211_CMD_NAN_NEXT_DW_NOTIFICATION.
+ *
+ * @__NL80211_NAN_CAPABILITIES_LAST: Internal
+ * @NL80211_NAN_CAPABILITES_MAX: Highest NAN capability attribute.
+ */
+enum nl80211_nan_capabilities {
+	__NL80211_NAN_CAPABILITIES_INVALID,
+
+	NL80211_NAN_CAPA_SYNC_OFFLOAD,
+	NL80211_NAN_CAPA_DE_OFFLOAD,
+	NL80211_NAN_CAPA_DW_NOTIF_SUPPORT,
+	/* keep last */
+	__NL80211_NAN_CAPABILITIES_LAST,
+	NL80211_NAN_CAPABILITES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
-- 
2.49.0


