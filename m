Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCBC43448C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 07:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJTFON (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 01:14:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:53932 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhJTFOM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 01:14:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="226155042"
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="226155042"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 22:11:59 -0700
X-IronPort-AV: E=Sophos;i="5.87,165,1631602800"; 
   d="scan'208";a="494456251"
Received: from jrhew-mobl2.amr.corp.intel.com (HELO egrumbac-mobl1.intel.com) ([10.254.151.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 22:11:56 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] nl80211: vendor-cmd: intel: add more details for IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP
Date:   Wed, 20 Oct 2021 08:11:47 +0300
Message-Id: <20211020051147.29297-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Explain more the expected flow for this command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 include/uapi/linux/nl80211-vnd-intel.h | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/uapi/linux/nl80211-vnd-intel.h b/include/uapi/linux/nl80211-vnd-intel.h
index 0bf177b84fd9..4ed7d0b24512 100644
--- a/include/uapi/linux/nl80211-vnd-intel.h
+++ b/include/uapi/linux/nl80211-vnd-intel.h
@@ -13,6 +13,35 @@
  * enum iwl_mvm_vendor_cmd - supported vendor commands
  * @IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO: reports CSME connection info.
  * @IWL_MVM_VENDOR_CMD_HOST_GET_OWNERSHIP: asks for ownership on the device.
+ *	This is useful when the CSME firmware owns the device and the kernel
+ *	wants to use it. In case the CSME firmware has no connection active the
+ *	kernel will manage on its own to get ownership of the device.
+ *	When the CSME firmware has an active connection, the user space
+ *	involvement is required. The kernel will assert the RFKILL signal with
+ *	the "device not owned" reason so that nobody can touch the device. Then
+ *	the user space can run the following flow to be able to get connected
+ *	to the very same AP the CSME firmware is currently connected to:
+ *
+ *	1) The user space (NetworkManager) boots and sees that the device is
+ *	    in RFKILL because the host doesn't own the device
+ *	2) The user space asks the kernel what AP the CSME firmware is
+ *	   connected to (with %IWL_MVM_VENDOR_CMD_GET_CSME_CONN_INFO)
+ *	3) The user space checks if it has a profile that matches the reply
+ *	   from the CSME firmware
+ *	4) The user space installs a network to the wpa_supplicant with a
+ *	   specific BSSID and a specific frequency
+ *	5) The user space prevents any type of full scan
+ *	6) The user space asks iwlmei to request ownership on the device (with
+ *	   this command)
+ *	7) iwlmei requests ownership from the CSME firmware
+ *	8) The CSME firmware grants ownership
+ *	9) iwlmei tells iwlwifi to lift the RFKILL
+ *	10) RFKILL OFF is reported to user space
+ *	11) The host boots the device, loads the firwmare, and connects to a
+ *	    specific BSSID without scanning including IP as fast as it can
+ *	12) The host reports to the CSME firmware that there is a connection
+ *	13) The TCP connection is preserved and the host has connectivity
+ *
  * @IWL_MVM_VENDOR_CMD_ROAMING_FORBIDDEN_EVENT: notifies if roaming is allowed.
  *	It contains a &IWL_MVM_VENDOR_ATTR_ROAMING_FORBIDDEN and a
  *	&IWL_MVM_VENDOR_ATTR_VIF_ADDR attributes.
-- 
2.25.1

