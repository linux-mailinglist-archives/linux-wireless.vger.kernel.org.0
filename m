Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3D93D6FB1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 08:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhG0Gvv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 02:51:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:21763 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235327AbhG0Gvv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 02:51:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212104837"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="212104837"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="505368822"
Received: from lgeva1-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.198.250])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:50 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     luciano.coelho@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     egrumbach@gmail.com,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>
Subject: [PATCH v5 5/7] nl80211: vendor-cmd: add Intel vendor commands for iwlmei usage
Date:   Tue, 27 Jul 2021 09:51:32 +0300
Message-Id: <20210727065134.3902-5-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
References: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iwlmei allows to integrate with the CSME firmware. There are
flows that are prioprietary for this purpose:

* Get the information of the AP the CSME firmware is connected
  to. This is useful when we need to speed up the connection
  process in case the CSME firmware has a TCP connection
  that must be kept alive across the ownership transition.
* Forbid roaming, which will happen when the CSME firmware
  wants to tell the user space not disrupt the connection.
* Request ownership, upon driver boot when the CSME firmware
  owns the device. This is a notification sent by the kernel.

All those commands are expected to be used by any software
managing the connection (mainly NetworkManager). Those commands
are expected to be used only in case the CSME firmware owns
the device and doesn't want to release the device unless the
host made sure that it can keep the connectivity.

Here are the steps of the expected flow:

1) The machine boots while AMT has an active TCP connection
2) iwlwifi starts and tries to access the device
3) The device is not available because of the active TCP
   connection. (If there are no active connections, the CSME
   firmware would have allowed iwlwifi to use the device)

Note that all the steps up to here don't involve iwlmei. All
this happens in iwlwifi (in iwl_pcie_prepare_card_hw).

4) iwlmei establishes a connection to the CSME firmware (through
   SAP)

Here iwlwifi uses iwlmei to access the device's capabilities
(since it can't touch the device), but this is not relevant
for the vendor commands.

5) The CSME firmware tells iwlmei that it uses the NIC and
   that there is an acitve TCP connection, and hence, the
   host needs to think twice before asking the CSME firmware
   to release the device
6) iwlmei tells iwlwifi to report HW RFKILL with a special
   reason

Up to here, there was no user space involved.

7) The user space (NetworkManager) boots and sees that the
   device is in RFKILL because the host doesn't own the
   device
8) The user space asks the kernel what AP the CSME firmware
   is connected to (with the first vendor command mentionned
   above)
9) The user space checks if it has a profile that matches the
   reply from the CSME firmware
10) The user space installs a network to the wpa_supplicant
    with a specific BSSID and a specific frequency
11) The user space prevents any type of full scan
12) The user space asks iwlmei to request ownership on the
    device (with the third vendor command)
13) iwlmei request ownership from the CSME firmware
14) The CSME firmware grants ownership
15) iwlmei tells iwlwifi to lift the RFKILL
16) RFKILL OFF is reported to userspace
17) The host boots the device, loads the firwmare, and
    connect to a specific BSSID without scanning including IP
    in less than 600ms (this is what I measured, of course
    it depends on many factors)
18) The host reports to the CSME firmware that there is a
    connection
19) The TCP connection is preserved and the host has now
    connectivity

20) Later, the TCP connection to the CSME firmware is
    terminated
21) The CSME firmware tells iwlmei that it is now free to
    do whatever it likes
22) iwlwifi sends the second vendor command to tell the
    user space that it can remove the special network
    configuration and pick any SSID / BSSID it likes.

Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 include/uapi/linux/nl80211-vnd-intel.h | 77 ++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 include/uapi/linux/nl80211-vnd-intel.h

diff --git a/include/uapi/linux/nl80211-vnd-intel.h b/include/uapi/linux/nl80211-vnd-intel.h
new file mode 100644
index 000000000000..0bf177b84fd9
--- /dev/null
+++ b/include/uapi/linux/nl80211-vnd-intel.h
@@ -0,0 +1,77 @@
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

