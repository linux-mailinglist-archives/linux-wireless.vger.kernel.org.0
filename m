Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D783B1C1E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhFWONE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Jun 2021 10:13:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:53091 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhFWOND (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Jun 2021 10:13:03 -0400
IronPort-SDR: tGK4S1lGUQQvPqwrPbLZwfgroGOdHmIftOTxCnRlMqCgvEAAYUtUmbXMVIlINl65EJv0iHrvah
 bZNQfMoE2x/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="207085828"
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="207085828"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 07:10:45 -0700
IronPort-SDR: 3C8Bwnlg9w8mqx86RMo1vBx1u0OZUMAXVGKNDTxfX3YtxRBv6NCkGKLhYVj+wJTbyOzixLQtqB
 HwWyVpq1F/iA==
X-IronPort-AV: E=Sophos;i="5.83,294,1616482800"; 
   d="scan'208";a="454662103"
Received: from afialcko-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.254.150.63])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 07:10:43 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     luciano.coelho@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>
Subject: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands for iwlmei usage
Date:   Wed, 23 Jun 2021 17:10:32 +0300
Message-Id: <20210623141033.27475-3-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iwlmei allows to integrate with the CSME firmware. There are
flows that are prioprietary for this purpose:

* Get the information the AP, the CSME firmware is connected
  to. This is useful when we need to speed up the connection
  process in case the CSME firmware has an TCP connection
  that must be kept alive across the ownership transition.
* Forbid roaming, which will happen when the CSME firmware
  wants to tell the user space not disrupt the connection.
* Request ownership, upon driver boot when the CSME firmware
  owns the device.

Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 include/uapi/linux/nl80211-vnd-intel.h | 80 ++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 include/uapi/linux/nl80211-vnd-intel.h

diff --git a/include/uapi/linux/nl80211-vnd-intel.h b/include/uapi/linux/nl80211-vnd-intel.h
new file mode 100644
index 000000000000..d41c34b84f25
--- /dev/null
+++ b/include/uapi/linux/nl80211-vnd-intel.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
+ * Copyright (C) 2016-2017 Intel Deutschland GmbH
+ */
+#ifndef __VENDOR_CMD_INTEL_H__
+#define __VENDOR_CMD_INTEL_H__
+
+#define INTEL_OUI	0x001735
+
+/**
+ * enum iwl_mvm_vendor_cmd - supported vendor commands
+ * @IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO: reports CSME connection info.
+ * @IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP: asks for ownership on the device.
+ * @IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT: notifies if roaming is allowed.
+ *	It contains a &IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN and a
+ *	&IWL_MVM_VENDOR_ATTR_VIF_ADDR attributes.
+ */
+
+enum iwl_mvm_vendor_cmd {
+	IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO			= 0x2d,
+	IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP			= 0x30,
+	IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT		= 0x32,
+};
+
+enum iwl_vendor_auth_akm_mode {
+	IWL_VENDOR_AUTH_OPEN,
+	IWL_VENDOR_AUTH_SHARED,
+	IWL_VENDOR_AUTH_WPA = 0x3,
+	IWL_VENDOR_AUTH_WPA_PSK,
+	IWL_VENDOR_AUTH_RSNA = 0x6,
+	IWL_VENDOR_AUTH_RSNA_PSK,
+	IWL_VENDOR_AUTH_SAE = 0x9,
+	IWL_VENDOR_AUTH_MAX,
+};
+
+/**
+ * enum iwl_mvm_vendor_attr - attributes used in vendor commands
+ * @__IWL_MVM_VENDOR_ATTR_INVALID: attribute 0 is invalid
+ * @IWL_MVM_VENDOR_ATTR_VIF_ADDR: interface MAC address
+ * @IWL_MVM_VENDOR_ATTR_ADDR: MAC address
+ * @IWL_MVM_VENDOR_ATTR_SSID: SSID (binary attribute, 0..32 octets)
+ * @IWL_MVM_VENDOR_ATTR_STA_CIPHER: the cipher to use for the station with the
+ *	mac address specified in &IWL_MVM_VENDOR_ATTR_ADDR.
+ * @IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN: u8 attribute. Indicates whether
+ *	roaming is forbidden or not. Value 1 means roaming is forbidden,
+ *	0 mean roaming is allowed.
+ * @IWL_MVM_VENDOR_ATTR_AUTH_MODE: u32 attribute. Authentication mode type
+ *	as specified in &enum iwl_vendor_auth_akm_mode.
+ * @IWL_MVM_VENDOR_ATTR_CHANNEL_NUM: u8 attribute. Contains channel number.
+ * @IWL_MVM_VENDOR_ATTR_BAND: u8 attribute.
+ *	0 for 2.4 GHz band, 1 for 5.2GHz band and 2 for 6GHz band.
+ * @IWL_MVM_VENDOR_ATTR_COLLOC_CHANNEL: u32 attribute. Channel number of
+ *	collocated AP. Relevant for 6GHz AP info.
+ * @IWL_MVM_VENDOR_ATTR_COLLOC_ADDR: MAC address of a collocated AP.
+ *	Relevant for 6GHz AP info.
+ *
+ * @NUM_IWL_MVM_VENDOR_ATTR: number of vendor attributes
+ * @MAX_IWL_MVM_VENDOR_ATTR: highest vendor attribute number
+
+ */
+enum iwl_mvm_vendor_attr {
+	__IWL_MVM_VENDOR_ATTR_INVALID				= 0x00,
+	IWL_MVM_VENDOR_ATTR_VIF_ADDR				= 0x02,
+	IWL_MVM_VENDOR_ATTR_ADDR				= 0x0a,
+	IWL_MVM_VENDOR_ATTR_SSID				= 0x3d,
+	IWL_MVM_VENDOR_ATTR_STA_CIPHER				= 0x51,
+	IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN			= 0x64,
+	IWL_MVM_VENDOR_ATTR_AUTH_MODE				= 0x65,
+	IWL_MVM_VENDOR_ATTR_CHANNEL_NUM				= 0x66,
+	IWL_MVM_VENDOR_ATTR_BAND				= 0x69,
+	IWL_MVM_VENDOR_ATTR_COLLOC_CHANNEL			= 0x70,
+	IWL_MVM_VENDOR_ATTR_COLLOC_ADDR				= 0x71,
+
+	NUM_IWL_MVM_VENDOR_ATTR,
+	MAX_IWL_MVM_VENDOR_ATTR = NUM_IWL_MVM_VENDOR_ATTR - 1,
+};
+
+#endif /* __VENDOR_CMD_INTEL_H__ */
-- 
2.25.1

