Return-Path: <linux-wireless+bounces-26360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBFBB2481E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 13:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFF188253F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763562F658E;
	Wed, 13 Aug 2025 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfMQ6di1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EE2F746F
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083533; cv=none; b=mVjwt2+wGD7ub06ptZsiAMHFuw47s0UXv5piJ3tCO2q4zquJM72wdb0dlKUpBvhvnbjxN5sPO2qDVUXCIxKsuqBxZb36AbhiNgpY5d6J58lWGRm7SBMZwe81EIrf3VV2zv5gaIV8j6U658+ItThHuhVUfsSltr/py0DiM8rqiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083533; c=relaxed/simple;
	bh=GSZs+wp7eRu9Gl5IbeOd25C2YjbLBla/aN5ugCvisWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUDytGLUPv6WVMJzxcItM31I4qy94altb/8ekAu0Klkgg0su9sqZnnrlwopu1+jRWtOKbMiETi0F13bptCCbjMcUXo/ACYbNqqFB4pPUTP/+yvy/XTJjNdJUHqpRWC5tgB98vaPCCHvEce/xcaVozJ4KjeqZII35pN/+/PmG7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfMQ6di1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755083532; x=1786619532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GSZs+wp7eRu9Gl5IbeOd25C2YjbLBla/aN5ugCvisWU=;
  b=SfMQ6di1ENNiclWJ2u5auqNwThHv5lujOlxAWhO3SOT2DeisiHJT9mXT
   9izuYU3w5paTzXGaOSo7VetuPSxWfjdtXQIOsNWVRxoar4Y1BUWMW6YdZ
   TYfRtZrMz9g5ZBuEfQzXKJ1PP/ILC+rcWT7O214FmNKpE6L2XQTC5K6YK
   fP7zJA+2OqTDuike+AyigbQHEvAlkLpSiXtG7RQnA4bNMqtY1fvGlxT+I
   kVQqMAFG9XAfiptCw3grmX4U/aExL+6qdyrKEDIK9WDZ4r3d3VYMl0vwU
   5c6bdOiUeIcri5HQKkUbMaGtM2BxoVnKSvWKy5bedURfO3PcOT7G8sWlF
   Q==;
X-CSE-ConnectionGUID: dapxN5C1RZmmHjUBHtG2sw==
X-CSE-MsgGUID: gc8uchEZToy0tETn6XOg2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74951217"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74951217"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:12:11 -0700
X-CSE-ConnectionGUID: tOO8Vy0OQA+7dTUxtrQDMw==
X-CSE-MsgGUID: 7drGqtF1Qv6YDTIABdusIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165628960"
Received: from aotchere-mobl1.jer.intel.com ([10.13.73.232])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:12:09 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	maheshkkv@google.com,
	quic_vganneva@quicinc.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v3 4/4] wifi: nl80211: Add more NAN capabilities
Date: Wed, 13 Aug 2025 17:10:48 +0300
Message-ID: <20250813141048.100884-5-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813141048.100884-1-andrei.otcheretianski@intel.com>
References: <20250813141048.100884-1-andrei.otcheretianski@intel.com>
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
 include/uapi/linux/nl80211.h | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0a5915b33705..8452d4470068 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2956,6 +2956,10 @@ enum nl80211_commands {
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
@@ -3521,6 +3525,7 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_NAN_CONFIG,
 	NL80211_ATTR_NAN_NEW_CLUSTER,
+	NL80211_ATTR_NAN_CAPABILITIES,
 
 	/* add attributes here, update the policy in nl80211.c */
 
@@ -8325,4 +8330,60 @@ enum nl80211_s1g_short_beacon_attrs {
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
+ * @NL80211_NAN_CONF_EXTRA_ATTRS_MAX_LEN: Maximum length of extra NAN
+ *	attributes. See %NL80211_NAN_CONF_EXTRA_ATTRS. This is u16.
+ * @NL80211_NAN_CONF_VENDOR_ELEMS_MAX_LEN: Maximum length of NAN vendor
+ *	elements. See %NL80211_NAN_CONF_VENDOR_ELEMS. This is u16.
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
+	NL80211_NAN_CONF_EXTRA_ATTRS_MAX_LEN,
+	NL80211_NAN_CONF_VENDOR_ELEMS_MAX_LEN,
+	/* keep last */
+	__NL80211_NAN_CAPABILITIES_LAST,
+	NL80211_NAN_CAPABILITIES_MAX = __NL80211_NAN_CAPABILITIES_LAST - 1,
+};
+
 #endif /* __LINUX_NL80211_H */
-- 
2.47.1


