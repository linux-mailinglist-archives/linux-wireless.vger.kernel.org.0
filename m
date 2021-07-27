Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB53D6FAE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhG0Gvr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 02:51:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:21751 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235272AbhG0Gvp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 02:51:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212104830"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="212104830"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="505368805"
Received: from lgeva1-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.255.198.250])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 23:51:42 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     luciano.coelho@intel.com, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org
Cc:     egrumbach@gmail.com,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ayala Beker <ayala.beker@intel.com>
Subject: [PATCH v5 2/7] iwlwifi: mei: add the driver to allow cooperation with CSME
Date:   Tue, 27 Jul 2021 09:51:29 +0300
Message-Id: <20210727065134.3902-2-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
References: <20210727065134.3902-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CSME in two words
-----------------
CSME stands for Converged Security and Management Engine. It is
a CPU on the chipset and runs a dedicated firmware.
AMT (Active Management Technology) is one of the applications
that run on that CPU. AMT allows to control the platform remotely.
Here is a partial list of the use cases:
* View the screen of the plaform, with keyboard and mouse (KVM)
* Attach a remote IDE device
* Have a serial console to the device
* Query the state of the platform
* Reset / shut down / boot the platform

Networking in CSME
------------------
For those uses cases, CSME's firmware has an embedded network
stack and is able to use the network devices of the system: LAN
and WLAN. This is thanks to the CSME's firmware WLAN driver.

One can add a profile (SSID / key / certificate) to the CSME's OS
and CSME will connect to that profile. Then, one can use the WLAN
link to access the applications that run on CSME (AMT is one of
them). Note that CSME is active during power state and power state
transitions. For example, it is possible to have a KVM session
open to the system while the system is rebooting and actually
configure the BIOS remotely over WLAN thanks to AMT.

How all this is related to Linux
--------------------------------
In Linux, there is a driver that allows the OS to talk to the
CSME firmware, this driver is drivers/misc/mei. This driver
advertises a bus that allows other kernel drivers or even user
space) to talk to components inside the CSME firmware.
In practice, the system advertises a PCI device that allows
to send / receive data to / from the CSME firmware. The mei
bus drivers in drivers/misc/mei is an abstration on top of
this PCI device.
The driver being added here is called iwlmei and talks to the
WLAN driver inside the CSME firmware through the mei bus driver.
Note that the mei bus driver only gives bus services, it doesn't
define the content of the communication.

Why do we need this driver?
--------------------------
CSME uses the same WLAN device that the OS is expecting to see
hence we need an arbitration mechanism. This is what iwlmei is
in charge of. iwlmei maintains the communication with the CSME
firmware's WLAN driver. The language / protocol that is used
between the CSME's firmware WLAN driver and iwlmei is OS agnostic
and is called SAP which stands for Software Abritration Protocol.
With SAP, iwlmei will be able to tell the CSME firmware's WLAN
driver:
1) Please give me the device.
2) Please note that the SW/HW rfkill state change.
3) Please note that I am now associated to X.
4) Please note that I received this packet.
etc...

There are messages that go the opposite direction as well:
1) Please note that AMT is en/disable.
2) Please note that I believe the OS is broken and hence I'll take
   the device *now*, whether you like it or not, to make sure that
   connectivity is preserved.
3) Please note that I am willing to give the device if the OS
   needs it.
4) Please give me any packet that is sent on UDP / TCP on IP address
   XX.XX.XX.XX and an port ZZ.
5) Please send this packet.
etc...

Please check drivers/net/wireless/intel/iwlwifi/mei/sap.h for the
full protocol specification.

Arbitration is not the only purpose of iwlmei and SAP. SAP also
allows to maintain the AMT's functionality even when the OS owns
the device. To connect to AMT, one needs to initiate an HTTP
connection to port 16992. iwlmei will listen to the Rx path and
forward (through SAP) to the CSME firmware the data it got. Then,
the embedded HTTP server in the chipset will reply to the request
and send a SAP notification to ask iwlmei to send the reply.
This way, AMT running on the CSME can still work.

In practice this means that all the use cases quoted above (KVM,
remote IDE device, etc...) will work even when the OS uses the
WLAN device.

How to disable all this?
---------------------------
iwlmei won't be able to do anything if the CSME's networking stack
is not enabled. By default, CSME's networking stack is disabled (this
is a BIOS setting).
In case the CSME's networking stack is disabled, iwlwifi will just
get access to the device because there is no contention with any other
actor and, hence, no arbitration is needed.

In this patch, I only add the iwlmei driver. Integration with
iwlwifi will be implemented in the next one.

Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
v2: fix a few warnings raised by the different bots
v3: rewrite the commit message
v4: put the debugfs content in a different patch
v5: fix a NULL pointer dereference upon DHCP TX if SAP is connected
    since we now have the required cfg80211 bits in wl-drv-next, add
    the RFKILL handling patch to this series.
---
 drivers/net/wireless/intel/iwlwifi/Kconfig    |   17 +
 drivers/net/wireless/intel/iwlwifi/Makefile   |    1 +
 .../net/wireless/intel/iwlwifi/mei/Makefile   |    8 +
 .../net/wireless/intel/iwlwifi/mei/internal.h |   20 +
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  467 ++++
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 1890 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mei/net.c  |  409 ++++
 drivers/net/wireless/intel/iwlwifi/mei/sap.h  |  731 +++++++
 .../wireless/intel/iwlwifi/mei/trace-data.h   |   69 +
 .../net/wireless/intel/iwlwifi/mei/trace.c    |   15 +
 .../net/wireless/intel/iwlwifi/mei/trace.h    |   62 +
 11 files changed, 3689 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/internal.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/main.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/net.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/sap.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 1085afbefba8..629aaa26a230 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -92,6 +92,23 @@ config IWLWIFI_BCAST_FILTERING
 	  If unsure, don't enable this option, as some programs might
 	  expect incoming broadcasts for their normal operations.
 
+config IWLMEI
+	tristate "Intel Management Engine communication over WLAN"
+	depends on INTEL_MEI
+	depends on PM
+	depends on IWLMVM
+	help
+	  Enables the iwlmei kernel module. This allows to communicate with
+	  the Intel Management Engine over Wifi. This is supported starting
+	  from Tiger Lake platforms and has been tested on 9260 devices only.
+	  Enabling this option on a platform that has a different device and
+	  has Wireless enabled on AMT can prevent WiFi from working correctly.
+
+	  For more information see
+	  <https://software.intel.com/en-us/manageability/>
+
+	  If unsure, say N.
+
 menu "Debugging Options"
 
 config IWLWIFI_DEBUG
diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index d86918d162aa..dab41f0fdea7 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -30,5 +30,6 @@ ccflags-y += -I$(src)
 
 obj-$(CONFIG_IWLDVM)	+= dvm/
 obj-$(CONFIG_IWLMVM)	+= mvm/
+obj-$(CONFIG_IWLMEI)	+= mei/
 
 CFLAGS_iwl-devtrace.o := -I$(src)
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/Makefile b/drivers/net/wireless/intel/iwlwifi/mei/Makefile
new file mode 100644
index 000000000000..fd3c14e3b74c
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_IWLMEI)	+= iwlmei.o
+iwlmei-y += main.o
+iwlmei-y += net.o
+iwlmei-$(CONFIG_IWLWIFI_DEVICE_TRACING) += trace.o
+CFLAGS_trace.o := -I$(src)
+
+ccflags-y += -I $(srctree)/$(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/internal.h b/drivers/net/wireless/intel/iwlwifi/mei/internal.h
new file mode 100644
index 000000000000..7f0a2e4de0f4
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/internal.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#ifndef __IWLMEI_INTERNAL_H_
+#define __IWLMEI_INTERNAL_H_
+
+#include <uapi/linux/if_ether.h>
+#include <linux/netdevice.h>
+
+#include "sap.h"
+
+rx_handler_result_t iwl_mei_rx_filter(struct sk_buff *skb,
+				      const struct iwl_sap_oob_filters *filters,
+				      bool *pass_to_csme);
+
+void iwl_mei_add_data_to_ring(struct sk_buff *skb, bool cb_tx);
+
+#endif /* __IWLMEI_INTERNAL_H_ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
new file mode 100644
index 000000000000..75c8b2eaeffc
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -0,0 +1,467 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#ifndef __iwl_mei_h__
+#define __iwl_mei_h__
+
+#include <linux/if_ether.h>
+#include <linux/skbuff.h>
+#include <linux/ieee80211.h>
+
+/**
+ * DOC: Introduction
+ *
+ * iwlmei is the kernel module that is in charge of the commnunication between
+ * the iwlwifi driver and the CSME firmware's WLAN driver. This communication
+ * uses the SAP protocol defined in another file.
+ * iwlwifi can request or release ownership on the WiFi device through iwlmei.
+ * iwlmei may notify iwlwifi about certain events: what filter iwlwifi should
+ * use to passthrough inbound packets to the CSME firmware for example. iwlmei
+ * may also use iwlwifi to send traffic. This means that we need communication
+ * from iwlmei to iwlwifi and the other way around.
+ */
+
+/**
+ * DOC: Life cycle
+ *
+ * iwlmei exports symbols that are needed by iwlwifi so that iwlmei will always
+ * be loaded when iwlwifi is alive. iwlwifi registers itself to iwlmei and
+ * provides the pointers to the functions that iwlmei calls whenever needed.
+ * iwlwifi calls iwlmei through direct and context-free function calls.
+ * It is assumed that only one device is accessible to the CSME firmware and
+ * under the scope of iwlmei so that it is valid not to have any context passed
+ * to iwlmei's functions.
+ *
+ * There are cases in which iwlmei can't access the CSME firmware, because the
+ * CSME firmware is undergoing a reset, or the mei bus decided to unbind the
+ * device. In those cases, iwlmei will need not to send requests over the mei
+ * bus. Instead, it needs to cache the requests from iwlwifi and fulfill them
+ * when the mei bus is available again.
+ *
+ * iwlmei can call iwlwifi as long as iwlwifi is registered to iwlmei. When
+ * iwlwifi goes down (the PCI device is unbound, or the iwlwifi is unloaded)
+ * iwlwifi needs to unregister from iwlmei.
+ */
+
+/**
+ * DOC: Memory layout
+ *
+ * Since iwlwifi calls iwlmei without any context, iwlmei needs to hold a
+ * global pointer to its data (which is in the mei client device's private
+ * data area). If there was no bind on the mei bus, this pointer is NULL and
+ * iwlmei knows not access to the CSME firmware upon requests from iwlwifi.
+ *
+ * iwlmei needs to cache requests from iwlwifi when there is no mei client
+ * device available (when iwlmei has been removed from the mei bus). In this
+ * case, all iwlmei's data that resides in the mei client device's private data
+ * area is unavailable. For this specific case, a separate caching area is
+ * needed.
+ */
+
+/**
+ * DOC: Concurrency
+ *
+ * iwlwifi can call iwlmei at any time. iwlmei will take care to synchronize
+ * the calls from iwlwifi with its internal flows. iwlwifi must not call iwlmei
+ * in flows that cannot sleep. Moreover, iwlwifi must not call iwlmei in flows
+ * that originated from iwlmei.
+ */
+
+/**
+ * DOC: Probe and remove from mei bus driver
+ *
+ * When the mei bus driver enumerates its devices, it calls the iwlmei's probe
+ * function which will send the %SAP_ME_MSG_START message. The probe completes
+ * before the response (%SAP_ME_MSG_START_OK) is received. This response will
+ * be handle by the Rx path. Once it arrives, the connection to the CSME
+ * firmware is considered established and iwlwifi's requests can be treated
+ * against the CSME firmware.
+ *
+ * When the mei bus driver removes the device, iwlmei loses all the data that
+ * was attached to the mei client device. It clears the global pointer to the
+ * mei client device since it is not available anymore. This will cause all the
+ * requests coming from iwlwifi to be cached. This flow takes the global mutex
+ * to be synchronized with all the requests coming from iwlwifi.
+ */
+
+/**
+ * DOC: Driver load when CSME owns the device
+ *
+ * When the driver (iwlwifi) is loaded while CSME owns the device,
+ * it'll ask CSME to release the device through HW registers. CSME
+ * will release the device only in the case that there is no connection
+ * through the mei bus. If there is a mei bus connection, CSME will refuse
+ * to release the ownership on the device through the HW registers. In that
+ * case, iwlwifi must first request ownership using the SAP protocol.
+ *
+ * Once iwlwifi will request ownership through the SAP protocol, CSME will
+ * grant the ownership on the device through the HW registers as well.
+ * In order to request ownership over SAP, we first need to have an interface
+ * which means that we need to register to mac80211.
+ * This can't happen before we get the NVM that contains all the capabilities
+ * of the device. Reading the NVM usually requires the load the firmware, but
+ * this is impossible as long as we don't have ownership on the device.
+ * In order to solve this chicken and egg problem, the host driver can get
+ * the NVM through CSME which owns the device. It can send
+ * %SAP_MSG_NOTIF_GET_NVM, which will be replied by %SAP_MSG_NOTIF_NVM with
+ * the NVM's content that the host driver needs.
+ */
+
+/**
+ * DOC: Driver load when CSME is associated and a session is active
+ *
+ * A "session" is active when CSME is associated to an access point and the
+ * link is used to attach a remote driver or to control the system remotely.
+ * When a session is active, we want to make sure it won't disconnect when we
+ * take ownership on the device.
+ * In this case, the driver can get the device, but it'll need to make
+ * sure that it'll connect to the exact same AP (same BSSID).
+ * In order to do so, CSME will send the connection parameters through
+ * SAP and then the host can check if it can connect to this same AP.
+ * If yes, it can request ownership through SAP and connect quickly without
+ * scanning all the channels, but just probing the AP on the channel that
+ * CSME was connected to.
+ * In order to signal this specific scenario to iwlwifi, iwlmei will
+ * immediately require iwlwifi to report RF-Kill to the network stack. This
+ * RF-Kill will prevent the stack from getting the device, and it has a reason
+ * that tells the userspace that the device is in RF-Kill because it is not
+ * owned by the host. Once the userspace has configured the right profile,
+ * it'll be able to let iwlmei know that it can request ownership over SAP
+ * which will remove the RF-Kill, and finally allow the host to connect.
+ * The host has then 3 seconds to connect (including DHCP). Had the host
+ * failed to connect within those 3 seconds, CSME will take the device back.
+ */
+
+/**
+ * DOC: Datapath
+ *
+ * CSME can transmit packets, through the netdev that it gets from the wifi
+ * driver. It'll send packet in the 802.3 format and simply call
+ * dev_queue_xmit.
+ *
+ * For Rx, iwlmei registers a Rx handler that it attaches to the netdev. iwlmei
+ * may catch packets and send them to CSME, it can then either drop them so
+ * that they are invisible to user space, or let them go the user space.
+ *
+ * Packets transmitted by the user space do not need to be forwarded to CSME
+ * with the exception of the DHCP request. In order to know what IP is used
+ * by the user space, CSME needs to get the DHCP request. See
+ * iwl_mei_tx_copy_to_csme().
+ */
+
+/**
+ * enum iwl_mei_nvm_caps - capabilities for MEI NVM
+ * @MEI_NVM_CAPS_LARI_SUPPORT: Lari is supported
+ * @MEI_NVM_CAPS_11AX_SUPPORT: 11AX is supported
+ */
+enum iwl_mei_nvm_caps {
+	MEI_NVM_CAPS_LARI_SUPPORT	= BIT(0),
+	MEI_NVM_CAPS_11AX_SUPPORT	= BIT(1),
+};
+
+/**
+ * struct iwl_mei_nvm - used to pass the NVM from CSME
+ * @hw_addr: The MAC address
+ * @n_hw_addrs: The number of MAC addresses
+ * @reserved: For alignment.
+ * @radio_cfg: The radio configuration.
+ * @caps: See &enum iwl_mei_nvm_caps.
+ * @nvm_version: The version of the NVM.
+ * @channels: The data for each channel.
+ *
+ * If a field is added, it must correspond to the SAP structure.
+ */
+struct iwl_mei_nvm {
+	u8 hw_addr[ETH_ALEN];
+	u8 n_hw_addrs;
+	u8 reserved;
+	u32 radio_cfg;
+	u32 caps;
+	u32 nvm_version;
+	u32 channels[110];
+};
+
+/**
+ * enum iwl_mei_pairwise_cipher - cipher for UCAST key
+ * @IWL_MEI_CIPHER_NONE: none
+ * @IWL_MEI_CIPHER_CCMP: ccmp
+ * @IWL_MEI_CIPHER_GCMP: gcmp
+ * @IWL_MEI_CIPHER_GCMP_256: gcmp 256
+ */
+enum iwl_mei_pairwise_cipher {
+	IWL_MEI_CIPHER_NONE	= 0,
+	IWL_MEI_CIPHER_CCMP	= 4,
+	IWL_MEI_CIPHER_GCMP	= 8,
+	IWL_MEI_CIPHER_GCMP_256 = 9,
+};
+
+/**
+ * enum iwl_mei_akm_auth - a combination of AKM and AUTH method
+ * @IWL_MEI_AKM_AUTH_OPEN: No encryption
+ * @IWL_MEI_AKM_AUTH_RSNA: 1X profile
+ * @IWL_MEI_AKM_AUTH_RSNA_PSK: PSK profile
+ * @IWL_MEI_AKM_AUTH_SAE: SAE profile
+ */
+enum iwl_mei_akm_auth {
+	IWL_MEI_AKM_AUTH_OPEN		= 0,
+	IWL_MEI_AKM_AUTH_RSNA		= 6,
+	IWL_MEI_AKM_AUTH_RSNA_PSK	= 7,
+	IWL_MEI_AKM_AUTH_SAE		= 9,
+};
+
+/**
+ * struct iwl_mei_conn_info - connection info
+ * @lp_state: link protection state
+ * @auth_mode: authentication mode
+ * @ssid_len: the length of SSID
+ * @ssid: the SSID
+ * @pairwise_cipher: the cipher used for unicast packets
+ * @channel: the associated channel
+ * @band: the associated band
+ * @bssid: the BSSID
+ */
+struct iwl_mei_conn_info {
+	u8 lp_state;
+	u8 auth_mode;
+	u8 ssid_len;
+	u8 channel;
+	u8 band;
+	u8 pairwise_cipher;
+	u8 bssid[ETH_ALEN];
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+};
+
+/**
+ * struct iwl_mei_colloc_info - collocated AP info
+ * @channel: the channel of the collocated AP
+ * @bssid: the BSSID of the collocated AP
+ */
+struct iwl_mei_colloc_info {
+	u8 channel;
+	u8 bssid[ETH_ALEN];
+};
+
+/*
+ * struct iwl_mei_ops - driver's operations called by iwlmei
+ * Operations will not be called more than once concurrently.
+ * It's not allowed to call iwlmei functions from this context.
+ *
+ * @me_conn_status: provide information about CSME's current connection.
+ * @rfkill: called when the wifi driver should report a change in the rfkill
+ *	status.
+ * @roaming_forbidden: indicates whether roaming is forbidden.
+ * @sap_connected: indicate that SAP is now connected. Will be called in case
+ *	the wifi driver registered to iwlmei before SAP connection succeeded or
+ *	when the SAP connection is re-established.
+ * @nic_stolen: this means that device is no longer available. The device can
+ *	still be used until the callback returns.
+ */
+struct iwl_mei_ops {
+	void (*me_conn_status)(void *priv,
+			       const struct iwl_mei_conn_info *conn_info);
+	void (*rfkill)(void *priv, bool blocked);
+	void (*roaming_forbidden)(void *priv, bool forbidden);
+	void (*sap_connected)(void *priv);
+	void (*nic_stolen)(void *priv);
+};
+
+#if IS_ENABLED(CONFIG_IWLMEI)
+
+/**
+ * iwl_mei_is_connected() - is the connection to the CSME firmware established?
+ *
+ * Return: true if we have a SAP connection
+ */
+bool iwl_mei_is_connected(void);
+
+/**
+ * iwl_mei_get_nvm() - returns the NVM for the device
+ *
+ * It is the caller's responsibility to free the memory returned
+ * by this function.
+ * This function blocks (sleeps) until the NVM is ready.
+ *
+ * Return: the NVM as received from CSME
+ */
+struct iwl_mei_nvm *iwl_mei_get_nvm(void);
+
+/**
+ * iwl_mei_get_ownership() - request ownership
+ *
+ * This function blocks until ownership is granted or timeout expired.
+ *
+ * Return: 0 in case we could get ownership on the device
+ */
+int iwl_mei_get_ownership(void);
+
+/**
+ * iwl_mei_set_rfkill_state() - set SW and HW RF kill states
+ * @hw_rfkill: HW RF kill state.
+ * @sw_rfkill: SW RF kill state.
+ *
+ * This function must be called when SW RF kill is issued by the user.
+ */
+void iwl_mei_set_rfkill_state(bool hw_rfkill, bool sw_rfkill);
+
+/**
+ * iwl_mei_set_nic_info() - set mac address
+ * @mac_address: mac address to set
+ * @nvm_address: NVM mac adsress to set
+ *
+ * This function must be called upon mac address change.
+ */
+void iwl_mei_set_nic_info(const u8 *mac_address, const u8 *nvm_address);
+
+/**
+ * iwl_mei_set_country_code() - set new country code
+ * @mcc: the new applied MCC
+ *
+ * This function must be called upon country code update
+ */
+void iwl_mei_set_country_code(u16 mcc);
+
+/**
+ * iwl_mei_set_power_limit() - set TX power limit
+ * @power_limit: pointer to an array of 10 elements (le16) represents the power
+ * restrictions per chain.
+ *
+ * This function must be called upon power restrictions change
+ */
+void iwl_mei_set_power_limit(const __le16 *power_limit);
+
+/**
+ * iwl_mei_register() - register the wifi driver to iwlmei
+ * @priv: a pointer to the wifi driver's context. Cannot be NULL.
+ * @ops: the ops structure.
+ *
+ * Return: 0 unless something went wrong. It is illegal to call any
+ * other API function before this function is called and succeeds.
+ *
+ * Only one wifi driver instance (wifi device instance really)
+ * can register at a time.
+ */
+int iwl_mei_register(void *priv, const struct iwl_mei_ops *ops);
+
+/**
+ * iwl_mei_start_unregister() - unregister the wifi driver from iwlmei
+ *
+ * From this point on, iwlmei will not used the callbacks provided by
+ * the driver, but the device is still usable.
+ */
+void iwl_mei_start_unregister(void);
+
+/**
+ * iwl_mei_unregister_complete() - complete the unregistration
+ *
+ * Must be called after iwl_mei_start_unregister. When this function returns,
+ * the device is owned by CSME.
+ */
+void iwl_mei_unregister_complete(void);
+
+/**
+ * iwl_mei_set_netdev() - sets the netdev for Tx / Rx.
+ * @netdev: the net_device
+ *
+ * The caller should set the netdev to a non-NULL value when the
+ * interface is added. Packets might be sent to the driver immediately
+ * afterwards.
+ * The caller should set the netdev to NULL when the interface is removed.
+ * This function will call synchronize_net() after setting the netdev to NULL.
+ * Only when this function returns, can the caller assume that iwlmei will
+ * no longer inject packets into the netdev's Tx path.
+ *
+ * Context: This function can sleep and assumes rtnl_lock is taken.
+ * The netdev must be set to NULL before iwl_mei_start_unregister() is called.
+ */
+void iwl_mei_set_netdev(struct net_device *netdev);
+
+/**
+ * iwl_mei_tx_copy_to_csme() - must be called for each packet sent by
+ * the wifi driver.
+ * @skb: the skb sent
+ * @ivlen: the size of the IV that needs to be skipped after the MAC and
+ *	before the SNAP header.
+ *
+ * This function doesn't take any lock, it simply tries to catch DHCP
+ * packets sent by the wifi driver. If the packet is a DHCP packet, it
+ * will send it to CSME. This function must not be called for virtual
+ * interfaces that are not monitored by CSME, meaning it must be called
+ * only for packets transmitted by the netdevice that was registered
+ * with iwl_mei_set_netdev().
+ */
+void iwl_mei_tx_copy_to_csme(struct sk_buff *skb, unsigned int ivlen);
+
+/**
+ * iwl_mei_host_associated() - must be called when iwlwifi associated.
+ * @conn_info: pointer to the connection info structure.
+ * @colloc_info: pointer to the collocated AP info. This is relevant only in
+ *	case of UHB associated AP, otherwise set to NULL.
+ */
+void iwl_mei_host_associated(const struct iwl_mei_conn_info *conn_info,
+			     const struct iwl_mei_colloc_info *colloc_info);
+
+/**
+ * iwl_mei_host_disassociated() - must be called when iwlwifi disassociated.
+ */
+void iwl_mei_host_disassociated(void);
+
+/**
+ * iwl_mei_device_down() - must be called when the device is down
+ */
+void iwl_mei_device_down(void);
+
+#else
+
+static inline bool iwl_mei_is_connected(void)
+{ return false; }
+
+static inline struct iwl_mei_nvm *iwl_mei_get_nvm(void)
+{ return NULL; }
+
+static inline int iwl_mei_get_ownership(void)
+{ return 0; }
+
+static inline void iwl_mei_set_rfkill_state(bool hw_rfkill, bool sw_rfkill)
+{}
+
+static inline void iwl_mei_set_nic_info(const u8 *mac_address, const u8 *nvm_address)
+{}
+
+static inline void iwl_mei_set_country_code(u16 mcc)
+{}
+
+static inline void iwl_mei_set_power_limit(__le16 *power_limit)
+{}
+
+static inline int iwl_mei_register(void *priv,
+				   const struct iwl_mei_ops *ops)
+{ return 0; }
+
+static inline void iwl_mei_start_unregister(void)
+{}
+
+static inline void iwl_mei_unregister_complete(void)
+{}
+
+static inline void iwl_mei_set_netdev(struct net_device *netdev)
+{}
+
+static inline void iwl_mei_tx_copy_to_csme(struct sk_buff *skb,
+					   unsigned int ivlen)
+{}
+
+static inline void iwl_mei_host_associated(const struct iwl_mei_conn_info *conn_info,
+					   const struct iwl_mei_colloc_info *colloc_info)
+{}
+
+static inline void iwl_mei_host_disassociated(void)
+{}
+
+static inline void iwl_mei_device_down(void)
+{}
+
+#endif /* CONFIG_IWLMEI */
+
+#endif /* __iwl_mei_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
new file mode 100644
index 000000000000..d0ddb707d4da
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -0,0 +1,1890 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mei_cl_bus.h>
+#include <linux/rcupdate.h>
+#include <linux/skbuff.h>
+#include <linux/wait.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include "internal.h"
+#include "iwl-mei.h"
+#include "trace.h"
+#include "trace-data.h"
+#include "sap.h"
+
+MODULE_DESCRIPTION("The Intel(R) wireless / CSME firmware interface");
+MODULE_LICENSE("GPL");
+
+#define MEI_WLAN_UUID UUID_LE(0x13280904, 0x7792, 0x4fcb, \
+			      0xa1, 0xaa, 0x5e, 0x70, 0xcb, 0xb1, 0xe8, 0x65)
+
+/*
+ * Since iwlwifi calls iwlmei without any context, hold a pointer to the
+ * mei_cl_device structure here.
+ * Define a mutex that will synchronize all the flows between iwlwifi and
+ * iwlmei.
+ */
+static struct mei_cl_device *iwl_mei_global_cldev;
+static DEFINE_MUTEX(iwl_mei_mutex);
+static unsigned long iwl_mei_status;
+
+enum iwl_mei_status_bits {
+	IWL_MEI_STATUS_SAP_CONNECTED,
+};
+
+bool iwl_mei_is_connected(void)
+{
+	return test_bit(IWL_MEI_STATUS_SAP_CONNECTED, &iwl_mei_status);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_is_connected);
+
+#define SAP_VERSION	3
+#define SAP_CONTROL_BLOCK_ID 0x21504153 /* SAP! in ASCII */
+
+struct iwl_sap_q_ctrl_blk {
+	__le32 wr_ptr;
+	__le32 rd_ptr;
+	__le32 size;
+};
+
+enum iwl_sap_q_idx {
+	SAP_QUEUE_IDX_NOTIF = 0,
+	SAP_QUEUE_IDX_DATA,
+	SAP_QUEUE_IDX_MAX,
+};
+
+struct iwl_sap_dir {
+	__le32 reserved;
+	struct iwl_sap_q_ctrl_blk q_ctrl_blk[SAP_QUEUE_IDX_MAX];
+};
+
+enum iwl_sap_dir_idx {
+	SAP_DIRECTION_HOST_TO_ME = 0,
+	SAP_DIRECTION_ME_TO_HOST,
+	SAP_DIRECTION_MAX,
+};
+
+struct iwl_sap_shared_mem_ctrl_blk {
+	__le32 sap_id;
+	__le32 size;
+	struct iwl_sap_dir dir[SAP_DIRECTION_MAX];
+};
+
+/*
+ * The shared area has the following layout:
+ *
+ * +-----------------------------------+
+ * |struct iwl_sap_shared_mem_ctrl_blk |
+ * +-----------------------------------+
+ * |Host -> ME data queue              |
+ * +-----------------------------------+
+ * |Host -> ME notif queue             |
+ * +-----------------------------------+
+ * |ME -> Host data queue              |
+ * +-----------------------------------+
+ * |ME -> host notif queue             |
+ * +-----------------------------------+
+ * |SAP control block id (SAP!)        |
+ * +-----------------------------------+
+ */
+
+#define SAP_H2M_DATA_Q_SZ	48256
+#define SAP_M2H_DATA_Q_SZ	24128
+#define SAP_H2M_NOTIF_Q_SZ	2240
+#define SAP_M2H_NOTIF_Q_SZ	62720
+
+#define _IWL_MEI_SAP_SHARED_MEM_SZ \
+	(sizeof(struct iwl_sap_shared_mem_ctrl_blk) + \
+	 SAP_H2M_DATA_Q_SZ + SAP_H2M_NOTIF_Q_SZ + \
+	 SAP_M2H_DATA_Q_SZ + SAP_M2H_NOTIF_Q_SZ + 4)
+
+#define IWL_MEI_SAP_SHARED_MEM_SZ \
+	(roundup(_IWL_MEI_SAP_SHARED_MEM_SZ, PAGE_SIZE))
+
+struct iwl_mei_shared_mem_ptrs {
+	struct iwl_sap_shared_mem_ctrl_blk *ctrl;
+	void *q_head[SAP_DIRECTION_MAX][SAP_QUEUE_IDX_MAX];
+};
+
+struct iwl_mei_filters {
+	struct rcu_head rcu_head;
+	struct iwl_sap_oob_filters filters;
+};
+
+/**
+ * struct iwl_mei - holds the private date for iwl_mei
+ *
+ * @get_nvm_wq: the wait queue for the get_nvm flow
+ * @send_csa_msg_wk: used to defer the transmission of the CHECK_SHARED_AREA
+ *	message. Used so that we can send CHECK_SHARED_AREA from atomic
+ *	contexts.
+ * @get_ownership_wq: the wait queue for the get_ownership_flow
+ * @shared_mem: the memory that is shared between CSME and the host
+ * @cldev: the pointer to the MEI client device
+ * @nvm: the data returned by the CSME for the NVM
+ * @filters: the filters sent by CSME
+ * @got_ownership: true if we own the device
+ * @amt_enabled: true if CSME has wireless enabled
+ * @csa_throttled: when true, we can't send CHECK_SHARED_AREA over the MEI
+ *	bus, but rather need to wait until send_csa_msg_wk runs
+ * @csme_taking_ownership: true when CSME is taking ownership. Used to remember
+ *	to send CSME_OWNERSHIP_CONFIRMED when the driver completes its down
+ *	flow.
+ * @csa_throttle_end_wk: used when &csa_throttled is true
+ * @data_q_lock: protects the access to the data queues which are
+ *	accessed without the mutex.
+ * @sap_seq_no: the sequence number for the SAP messages
+ * @seq_no: the sequence number for the SAP messages
+ */
+struct iwl_mei {
+	wait_queue_head_t get_nvm_wq;
+	struct work_struct send_csa_msg_wk;
+	wait_queue_head_t get_ownership_wq;
+	struct iwl_mei_shared_mem_ptrs shared_mem;
+	struct mei_cl_device *cldev;
+	struct iwl_mei_nvm *nvm;
+	struct iwl_mei_filters __rcu *filters;
+	bool got_ownership;
+	bool amt_enabled;
+	bool csa_throttled;
+	bool csme_taking_ownership;
+	struct delayed_work csa_throttle_end_wk;
+	spinlock_t data_q_lock;
+
+	atomic_t sap_seq_no;
+	atomic_t seq_no;
+};
+
+/**
+ * iwl_mei_cache - cache for the parameters from iwlwifi
+ * @ops: Callbacks to iwlwifi.
+ * @netdev: The netdev that will be used to transmit / receive packets.
+ * @conn_info: The connection info message triggered by iwlwifi's association.
+ * @power_limit: pointer to an array of 10 elements (le16) represents the power
+ *	restrictions per chain.
+ * @rf_kill: rf kill state.
+ * @mcc: MCC info
+ * @mac_address: interface MAC address.
+ * @nvm_address: NVM MAC address.
+ * @priv: A pointer to iwlwifi.
+ *
+ * This used to cache the configurations coming from iwlwifi's way. The data
+ * is cached here so that we can buffer the configuration even if we don't have
+ * a bind from the mei bus and hence, on iwl_mei structure.
+ */
+static struct {
+	const struct iwl_mei_ops *ops;
+	struct net_device __rcu *netdev;
+	const struct iwl_sap_notif_connection_info *conn_info;
+	const __le16 *power_limit;
+	u32 rf_kill;
+	u16 mcc;
+	u8 mac_address[6];
+	u8 nvm_address[6];
+	void *priv;
+} iwl_mei_cache = {
+	.rf_kill = SAP_HW_RFKILL_DEASSERTED | SAP_SW_RFKILL_DEASSERTED
+};
+
+static void iwl_mei_free_shared_mem(struct mei_cl_device *cldev)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+
+	if (mei_cldev_dma_unmap(cldev))
+		dev_err(&cldev->dev, "Coudln't unmap the shared mem properly\n");
+	memset(&mei->shared_mem, 0, sizeof(mei->shared_mem));
+}
+
+#define HBM_DMA_BUF_ID_WLAN 1
+
+static int iwl_mei_alloc_shared_mem(struct mei_cl_device *cldev)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	struct iwl_mei_shared_mem_ptrs *mem = &mei->shared_mem;
+
+	mem->ctrl = mei_cldev_dma_map(cldev, HBM_DMA_BUF_ID_WLAN,
+				       IWL_MEI_SAP_SHARED_MEM_SZ);
+
+	if (IS_ERR(mem->ctrl)) {
+		int ret = PTR_ERR(mem->ctrl);
+
+		dev_err(&cldev->dev, "Couldn't allocate the shared memory: %d\n",
+			ret);
+		mem->ctrl = NULL;
+
+		return ret;
+	}
+
+	memset(mem->ctrl, 0, IWL_MEI_SAP_SHARED_MEM_SZ);
+
+	return 0;
+}
+
+static void iwl_mei_init_shared_mem(struct iwl_mei *mei)
+{
+	struct iwl_mei_shared_mem_ptrs *mem = &mei->shared_mem;
+	struct iwl_sap_dir *h2m;
+	struct iwl_sap_dir *m2h;
+	int dir, queue;
+	u8 *q_head;
+
+	mem->ctrl->sap_id = cpu_to_le32(SAP_CONTROL_BLOCK_ID);
+
+	mem->ctrl->size = cpu_to_le32(sizeof(*mem->ctrl));
+
+	h2m = &mem->ctrl->dir[SAP_DIRECTION_HOST_TO_ME];
+	m2h = &mem->ctrl->dir[SAP_DIRECTION_ME_TO_HOST];
+
+	h2m->q_ctrl_blk[SAP_QUEUE_IDX_DATA].size =
+		cpu_to_le32(SAP_H2M_DATA_Q_SZ);
+	h2m->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF].size =
+		cpu_to_le32(SAP_H2M_NOTIF_Q_SZ);
+	m2h->q_ctrl_blk[SAP_QUEUE_IDX_DATA].size =
+		cpu_to_le32(SAP_M2H_DATA_Q_SZ);
+	m2h->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF].size =
+		cpu_to_le32(SAP_M2H_NOTIF_Q_SZ);
+
+	/* q_head points to the start of the first queue */
+	q_head = (void *)(mem->ctrl + 1);
+
+	/* Initialize the queue heads */
+	for (dir = 0; dir < SAP_DIRECTION_MAX; dir++) {
+		for (queue = 0; queue < SAP_QUEUE_IDX_MAX; queue++) {
+			mem->q_head[dir][queue] = q_head;
+			q_head +=
+				le32_to_cpu(mem->ctrl->dir[dir].q_ctrl_blk[queue].size);
+		}
+	}
+
+	*(__le32 *)q_head = cpu_to_le32(SAP_CONTROL_BLOCK_ID);
+}
+
+static ssize_t iwl_mei_write_cyclic_buf(struct mei_cl_device *cldev,
+					struct iwl_sap_q_ctrl_blk *notif_q,
+					u8 *q_head,
+					const struct iwl_sap_hdr *hdr)
+{
+	u32 rd = le32_to_cpu(READ_ONCE(notif_q->rd_ptr));
+	u32 wr = le32_to_cpu(READ_ONCE(notif_q->wr_ptr));
+	u32 q_sz = le32_to_cpu(notif_q->size);
+	size_t room_in_buf;
+	size_t tx_sz = sizeof(*hdr) + le16_to_cpu(hdr->len);
+
+	if (rd > q_sz || wr > q_sz) {
+		dev_err(&cldev->dev,
+			"Pointers are past the end of the buffer\n");
+		return -EINVAL;
+	}
+
+	room_in_buf = wr >= rd ? q_sz - wr + rd : rd - wr;
+
+	/* we don't have enough room for the data to write */
+	if (room_in_buf < tx_sz) {
+		dev_err(&cldev->dev,
+			"Not enough room in the buffer\n");
+		return -ENOSPC;
+	}
+
+	if (wr + tx_sz <= q_sz) {
+		memcpy(q_head + wr, hdr, tx_sz);
+	} else {
+		memcpy(q_head + wr, hdr, q_sz - wr);
+		memcpy(q_head, (u8 *)hdr + q_sz - wr, tx_sz - (q_sz - wr));
+	}
+
+	WRITE_ONCE(notif_q->wr_ptr, cpu_to_le32((wr + tx_sz) % q_sz));
+	return 0;
+}
+
+static bool iwl_mei_host_to_me_data_pending(const struct iwl_mei *mei)
+{
+	struct iwl_sap_q_ctrl_blk *notif_q;
+	struct iwl_sap_dir *dir;
+
+	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_HOST_TO_ME];
+	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_DATA];
+
+	if (READ_ONCE(notif_q->wr_ptr) != READ_ONCE(notif_q->rd_ptr))
+		return true;
+
+	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF];
+	return READ_ONCE(notif_q->wr_ptr) != READ_ONCE(notif_q->rd_ptr);
+}
+
+static int iwl_mei_send_check_shared_area(struct mei_cl_device *cldev)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	struct iwl_sap_me_msg_start msg = {
+		.hdr.type = cpu_to_le32(SAP_ME_MSG_CHECK_SHARED_AREA),
+		.hdr.seq_num = cpu_to_le32(atomic_inc_return(&mei->seq_no)),
+	};
+	int ret;
+
+	lockdep_assert_held(&iwl_mei_mutex);
+
+	if (mei->csa_throttled)
+		return 0;
+
+	trace_iwlmei_me_msg(&msg.hdr, true);
+	ret = mei_cldev_send(cldev, (void *)&msg, sizeof(msg));
+	if (ret != sizeof(msg)) {
+		dev_err(&cldev->dev,
+			"failed to send the SAP_ME_MSG_CHECK_SHARED_AREA message %d\n",
+			ret);
+		return ret;
+	}
+
+	mei->csa_throttled = true;
+
+	schedule_delayed_work(&mei->csa_throttle_end_wk,
+			      msecs_to_jiffies(100));
+
+	return 0;
+}
+
+static void iwl_mei_csa_throttle_end_wk(struct work_struct *wk)
+{
+	struct iwl_mei *mei =
+		container_of(wk, struct iwl_mei, csa_throttle_end_wk.work);
+
+	mutex_lock(&iwl_mei_mutex);
+
+	mei->csa_throttled = false;
+
+	if (iwl_mei_host_to_me_data_pending(mei))
+		iwl_mei_send_check_shared_area(mei->cldev);
+
+	mutex_unlock(&iwl_mei_mutex);
+}
+
+static int iwl_mei_send_sap_msg_payload(struct mei_cl_device *cldev,
+					struct iwl_sap_hdr *hdr)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	struct iwl_sap_q_ctrl_blk *notif_q;
+	struct iwl_sap_dir *dir;
+	void *q_head;
+	int ret;
+
+	lockdep_assert_held(&iwl_mei_mutex);
+
+	if (!mei->shared_mem.ctrl) {
+		dev_err(&cldev->dev,
+			"No shared memory, can't send any SAP message\n");
+		return -EINVAL;
+	}
+
+	if (!iwl_mei_is_connected()) {
+		dev_err(&cldev->dev,
+			"Can't send a SAP message if we're not connected\n");
+		return -ENODEV;
+	}
+
+	hdr->seq_num = cpu_to_le32(atomic_inc_return(&mei->sap_seq_no));
+	dev_dbg(&cldev->dev, "Sending %d\n", hdr->type);
+
+	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_HOST_TO_ME];
+	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF];
+	q_head = mei->shared_mem.q_head[SAP_DIRECTION_HOST_TO_ME][SAP_QUEUE_IDX_NOTIF];
+	ret = iwl_mei_write_cyclic_buf(q_head, notif_q, q_head, hdr);
+
+	if (ret < 0)
+		return ret;
+
+	trace_iwlmei_sap_cmd(hdr, true);
+
+	return iwl_mei_send_check_shared_area(cldev);
+}
+
+void iwl_mei_add_data_to_ring(struct sk_buff *skb, bool cb_tx)
+{
+	struct iwl_sap_q_ctrl_blk *notif_q;
+	struct iwl_sap_dir *dir;
+	struct iwl_mei *mei;
+	size_t room_in_buf;
+	size_t tx_sz;
+	size_t hdr_sz;
+	u32 q_sz;
+	u32 rd;
+	u32 wr;
+	void *q_head;
+
+	if (!iwl_mei_global_cldev)
+		return;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	/*
+	 * We access this path for Rx packets (the more common case)
+	 * and from Tx path when we send DHCP packets, the latter is
+	 * very unlikely.
+	 * Take the lock already here to make sure we see that remove()
+	 * might have cleared the IWL_MEI_STATUS_SAP_CONNECTED bit.
+	 */
+	spin_lock_bh(&mei->data_q_lock);
+
+	if (!iwl_mei_is_connected()) {
+		spin_unlock_bh(&mei->data_q_lock);
+		return;
+	}
+
+	/*
+	 * We are in a RCU critical section and the remove from the CSME bus
+	 * which would free this memory waits for the readers to complete (this
+	 * is done in netdev_rx_handler_unregister).
+	 */
+	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_HOST_TO_ME];
+	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_DATA];
+	q_head = mei->shared_mem.q_head[SAP_DIRECTION_HOST_TO_ME][SAP_QUEUE_IDX_DATA];
+
+	rd = le32_to_cpu(READ_ONCE(notif_q->rd_ptr));
+	wr = le32_to_cpu(READ_ONCE(notif_q->wr_ptr));
+	q_sz = le32_to_cpu(notif_q->size);
+	hdr_sz = cb_tx ? sizeof(struct iwl_sap_cb_data) :
+			 sizeof(struct iwl_sap_hdr);
+	tx_sz = skb->len + hdr_sz;
+
+	if (rd > q_sz || wr > q_sz) {
+		dev_err(&mei->cldev->dev,
+			"can't write the data: pointers are past the end of the buffer\n");
+		goto out;
+	}
+
+	room_in_buf = wr >= rd ? q_sz - wr + rd : rd - wr;
+
+	/* we don't have enough room for the data to write */
+	if (room_in_buf < tx_sz) {
+		dev_err(&mei->cldev->dev,
+			"Not enough room in the buffer for this data\n");
+		goto out;
+	}
+
+	if (skb_headroom(skb) < hdr_sz) {
+		dev_err(&mei->cldev->dev,
+			"Not enough headroom in the skb to write the SAP header\n");
+		goto out;
+	}
+
+	if (cb_tx) {
+		struct iwl_sap_cb_data *cb_hdr = skb_push(skb, sizeof(*cb_hdr));
+
+		cb_hdr->hdr.type = cpu_to_le16(SAP_MSG_CB_DATA_PACKET);
+		cb_hdr->hdr.len = cpu_to_le16(skb->len - sizeof(cb_hdr->hdr));
+		cb_hdr->hdr.seq_num = cpu_to_le32(atomic_inc_return(&mei->sap_seq_no));
+		cb_hdr->to_me_filt_status = cpu_to_le32(BIT(CB_TX_DHCP_FILT_IDX));
+		cb_hdr->data_len = cpu_to_le32(skb->len - sizeof(*cb_hdr));
+		trace_iwlmei_sap_data(skb, IWL_SAP_TX_DHCP);
+	} else {
+		struct iwl_sap_hdr *hdr = skb_push(skb, sizeof(*hdr));
+
+		hdr->type = cpu_to_le16(SAP_MSG_DATA_PACKET);
+		hdr->len = cpu_to_le16(skb->len - sizeof(*hdr));
+		hdr->seq_num = cpu_to_le32(atomic_inc_return(&mei->sap_seq_no));
+		trace_iwlmei_sap_data(skb, IWL_SAP_TX_DATA_FROM_AIR);
+	}
+
+	if (wr + tx_sz <= q_sz) {
+		skb_copy_bits(skb, 0, q_head + wr, tx_sz);
+	} else {
+		skb_copy_bits(skb, 0, q_head + wr, q_sz - wr);
+		skb_copy_bits(skb, q_sz - wr, q_head, tx_sz - (q_sz - wr));
+	}
+
+	WRITE_ONCE(notif_q->wr_ptr, cpu_to_le32((wr + tx_sz) % q_sz));
+
+out:
+	spin_unlock_bh(&mei->data_q_lock);
+}
+
+static int
+iwl_mei_send_sap_msg(struct mei_cl_device *cldev, u16 type)
+{
+	struct iwl_sap_hdr msg = {
+		.type = cpu_to_le16(type),
+	};
+
+	return iwl_mei_send_sap_msg_payload(cldev, &msg);
+}
+
+static void iwl_mei_send_csa_msg_wk(struct work_struct *wk)
+{
+	struct iwl_mei *mei =
+		container_of(wk, struct iwl_mei, send_csa_msg_wk);
+
+	if (!iwl_mei_is_connected())
+		return;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	iwl_mei_send_check_shared_area(mei->cldev);
+
+	mutex_unlock(&iwl_mei_mutex);
+}
+
+/* Called in a RCU read critical section from netif_receive_skb */
+static rx_handler_result_t iwl_mei_rx_handler(struct sk_buff **pskb)
+{
+	struct sk_buff *skb = *pskb;
+	struct iwl_mei *mei =
+		rcu_dereference(skb->dev->rx_handler_data);
+	struct iwl_mei_filters *filters = rcu_dereference(mei->filters);
+	bool rx_for_csme = false;
+	rx_handler_result_t res;
+
+	/*
+	 * remove() unregisters this handler and synchronize_net, so this
+	 * should never happen.
+	 */
+	if (!iwl_mei_is_connected()) {
+		dev_err(&mei->cldev->dev,
+			"Got an Rx packet, but we're not connected to SAP?\n");
+		return RX_HANDLER_PASS;
+	}
+
+	if (filters)
+		res = iwl_mei_rx_filter(skb, &filters->filters, &rx_for_csme);
+	else
+		res = RX_HANDLER_PASS;
+
+	/*
+	 * The data is already on the ring of the shared area, all we
+	 * need to do is to tell the CSME firmware to check what we have
+	 * there.
+	 */
+	if (rx_for_csme)
+		schedule_work(&mei->send_csa_msg_wk);
+
+	if (res != RX_HANDLER_PASS) {
+		trace_iwlmei_sap_data(skb, IWL_SAP_RX_DATA_DROPPED_FROM_AIR);
+		dev_kfree_skb(skb);
+	}
+
+	return res;
+}
+
+static void
+iwl_mei_handle_rx_start_ok(struct mei_cl_device *cldev,
+			   const struct iwl_sap_me_msg_start_ok *rsp,
+			   ssize_t len)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+
+	if (len != sizeof(*rsp)) {
+		dev_err(&cldev->dev,
+			"got invalid SAP_ME_MSG_START_OK from CSME firmware\n");
+		dev_err(&cldev->dev,
+			"size is incorrect: %zd instead of %zu\n",
+			len, sizeof(*rsp));
+		return;
+	}
+
+	if (rsp->supported_version != SAP_VERSION) {
+		dev_err(&cldev->dev,
+			"didn't get the expected version: got %d\n",
+			rsp->supported_version);
+		return;
+	}
+
+	mutex_lock(&iwl_mei_mutex);
+	set_bit(IWL_MEI_STATUS_SAP_CONNECTED, &iwl_mei_status);
+	/* wifi driver has registered already */
+	if (iwl_mei_cache.ops) {
+		iwl_mei_send_sap_msg(mei->cldev,
+				     SAP_MSG_NOTIF_WIFIDR_UP);
+		iwl_mei_cache.ops->sap_connected(iwl_mei_cache.priv);
+	}
+
+	mutex_unlock(&iwl_mei_mutex);
+}
+
+static void iwl_mei_handle_csme_filters(struct mei_cl_device *cldev,
+					const struct iwl_sap_csme_filters *filters)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+	struct iwl_mei_filters *new_filters;
+	struct iwl_mei_filters *old_filters;
+
+	old_filters =
+		rcu_dereference_protected(mei->filters,
+					  lockdep_is_held(&iwl_mei_mutex));
+
+	new_filters = kzalloc(sizeof(*new_filters), GFP_KERNEL);
+
+	/* Copy the OOB filters */
+	new_filters->filters = filters->filters;
+
+	rcu_assign_pointer(mei->filters, new_filters);
+
+	if (old_filters)
+		kfree_rcu(old_filters, rcu_head);
+}
+
+static void
+iwl_mei_handle_conn_status(struct mei_cl_device *cldev,
+			   const struct iwl_sap_notif_conn_status *status)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	struct iwl_mei_conn_info conn_info = {
+		.lp_state = le32_to_cpu(status->link_prot_state),
+		.ssid_len = le32_to_cpu(status->conn_info.ssid_len),
+		.channel = status->conn_info.channel,
+		.band = status->conn_info.band,
+		.auth_mode = le32_to_cpu(status->conn_info.auth_mode),
+		.pairwise_cipher = le32_to_cpu(status->conn_info.pairwise_cipher),
+	};
+
+	if (!iwl_mei_cache.ops ||
+	    conn_info.ssid_len > ARRAY_SIZE(conn_info.ssid))
+		return;
+
+	memcpy(conn_info.ssid, status->conn_info.ssid, conn_info.ssid_len);
+	ether_addr_copy(conn_info.bssid, status->conn_info.bssid);
+
+	iwl_mei_cache.ops->me_conn_status(iwl_mei_cache.priv, &conn_info);
+
+	/*
+	 * Update the Rfkill state in case the host does not own the device:
+	 * if we are in Link Protection, ask to not touch the device, else,
+	 * unblock rfkill.
+	 * If the host owns the device, inform the user space whether it can
+	 * roam.
+	 */
+	if (mei->got_ownership)
+		iwl_mei_cache.ops->roaming_forbidden(iwl_mei_cache.priv,
+						     status->link_prot_state);
+	else
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv,
+					  status->link_prot_state);
+}
+
+static void iwl_mei_set_init_conf(struct iwl_mei *mei)
+{
+	struct iwl_sap_notif_host_link_up link_msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_HOST_LINK_UP),
+		.hdr.len = cpu_to_le16(sizeof(link_msg) - sizeof(link_msg.hdr)),
+	};
+	struct iwl_sap_notif_country_code mcc_msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_COUNTRY_CODE),
+		.hdr.len = cpu_to_le16(sizeof(mcc_msg) - sizeof(mcc_msg.hdr)),
+		.mcc = cpu_to_le16(iwl_mei_cache.mcc),
+	};
+	struct iwl_sap_notif_sar_limits sar_msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_SAR_LIMITS),
+		.hdr.len = cpu_to_le16(sizeof(sar_msg) - sizeof(sar_msg.hdr)),
+	};
+	struct iwl_sap_notif_host_nic_info nic_info_msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_NIC_INFO),
+		.hdr.len = cpu_to_le16(sizeof(nic_info_msg) - sizeof(nic_info_msg.hdr)),
+	};
+	struct iwl_sap_msg_dw rfkill_msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_RADIO_STATE),
+		.hdr.len = cpu_to_le16(sizeof(rfkill_msg) - sizeof(rfkill_msg.hdr)),
+		.val = cpu_to_le32(iwl_mei_cache.rf_kill),
+	};
+
+	iwl_mei_send_sap_msg(mei->cldev,
+			     SAP_MSG_NOTIF_HOST_ASKS_FOR_NIC_OWNERSHIP);
+
+	if (iwl_mei_cache.conn_info) {
+		link_msg.conn_info = *iwl_mei_cache.conn_info;
+		iwl_mei_send_sap_msg_payload(mei->cldev, &link_msg.hdr);
+	}
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &mcc_msg.hdr);
+
+	if (iwl_mei_cache.power_limit) {
+		memcpy(sar_msg.sar_chain_info_table, iwl_mei_cache.power_limit,
+		       sizeof(sar_msg.sar_chain_info_table));
+		iwl_mei_send_sap_msg_payload(mei->cldev, &sar_msg.hdr);
+	}
+
+	ether_addr_copy(nic_info_msg.mac_address, iwl_mei_cache.mac_address);
+	ether_addr_copy(nic_info_msg.nvm_address, iwl_mei_cache.nvm_address);
+	iwl_mei_send_sap_msg_payload(mei->cldev, &nic_info_msg.hdr);
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &rfkill_msg.hdr);
+}
+
+static void iwl_mei_handle_amt_state(struct mei_cl_device *cldev,
+				     const struct iwl_sap_msg_dw *dw)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	struct net_device *netdev;
+
+	/*
+	 * First take rtnl and only then the mutex to avoid an ABBA
+	 * with iwl_mei_set_netdev()
+	 */
+	rtnl_lock();
+	mutex_lock(&iwl_mei_mutex);
+
+	netdev = rcu_dereference_protected(iwl_mei_cache.netdev,
+					   lockdep_is_held(&iwl_mei_mutex));
+
+	if (mei->amt_enabled == !!le32_to_cpu(dw->val))
+		goto out;
+
+	mei->amt_enabled = dw->val;
+
+	if (mei->amt_enabled) {
+		if (netdev)
+			netdev_rx_handler_register(netdev, iwl_mei_rx_handler, mei);
+
+		iwl_mei_set_init_conf(mei);
+	} else {
+		if (iwl_mei_cache.ops)
+			iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
+		if (netdev)
+			netdev_rx_handler_unregister(netdev);
+	}
+
+out:
+	mutex_unlock(&iwl_mei_mutex);
+	rtnl_unlock();
+}
+
+static void iwl_mei_handle_can_release_ownership(struct mei_cl_device *cldev,
+						 const void *payload)
+{
+	/* We can get ownership and driver is registered, go ahead */
+	if (iwl_mei_cache.ops)
+		iwl_mei_send_sap_msg(cldev,
+				     SAP_MSG_NOTIF_HOST_ASKS_FOR_NIC_OWNERSHIP);
+}
+
+static void iwl_mei_handle_csme_taking_ownership(struct mei_cl_device *cldev,
+						 const void *payload)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+
+	dev_info(&cldev->dev, "CSME takes ownership\n");
+
+	mei->got_ownership = false;
+
+	/*
+	 * Remember to send CSME_OWNERSHIP_CONFIRMED when the wifi driver
+	 * is finished taking the device down.
+	 */
+	mei->csme_taking_ownership = true;
+
+	if (iwl_mei_cache.ops)
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, true);
+}
+
+static void iwl_mei_handle_nvm(struct mei_cl_device *cldev,
+			       const struct iwl_sap_nvm *sap_nvm)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	const struct iwl_mei_nvm *mei_nvm = (const void *)sap_nvm;
+	int i;
+
+	kfree(mei->nvm);
+	mei->nvm = kzalloc(sizeof(*mei_nvm), GFP_KERNEL);
+	if (!mei->nvm)
+		return;
+
+	ether_addr_copy(mei->nvm->hw_addr, sap_nvm->hw_addr);
+	mei->nvm->n_hw_addrs = sap_nvm->n_hw_addrs;
+	mei->nvm->radio_cfg = le32_to_cpu(sap_nvm->radio_cfg);
+	mei->nvm->caps = le32_to_cpu(sap_nvm->caps);
+	mei->nvm->nvm_version = le32_to_cpu(sap_nvm->nvm_version);
+
+	for (i = 0; i < ARRAY_SIZE(mei->nvm->channels); i++)
+		mei->nvm->channels[i] = le32_to_cpu(sap_nvm->channels[i]);
+
+	wake_up_all(&mei->get_nvm_wq);
+}
+
+static void iwl_mei_handle_rx_host_own_req(struct mei_cl_device *cldev,
+					   const struct iwl_sap_msg_dw *dw)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+
+	/*
+	 * This means that we can't use the wifi device right now, CSME is not
+	 * ready to let us use it.
+	 */
+	if (!dw->val) {
+		dev_info(&cldev->dev, "Ownership req denied\n");
+		return;
+	}
+
+	mei->got_ownership = true;
+	wake_up_all(&mei->get_ownership_wq);
+
+	iwl_mei_send_sap_msg(cldev,
+			     SAP_MSG_NOTIF_HOST_OWNERSHIP_CONFIRMED);
+
+	/* We can now start the connection, unblock rfkill */
+	if (iwl_mei_cache.ops)
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
+}
+
+static void iwl_mei_handle_ping(struct mei_cl_device *cldev,
+				const struct iwl_sap_hdr *hdr)
+{
+	iwl_mei_send_sap_msg(cldev, SAP_MSG_NOTIF_PONG);
+}
+
+static void iwl_mei_handle_sap_msg(struct mei_cl_device *cldev,
+				   const struct iwl_sap_hdr *hdr)
+{
+	u16 len = le16_to_cpu(hdr->len) + sizeof(*hdr);
+	u16 type = le16_to_cpu(hdr->type);
+
+	dev_dbg(&cldev->dev,
+		"Got a new SAP message: type %d, len %d, seq %d\n",
+		le16_to_cpu(hdr->type), len,
+		le32_to_cpu(hdr->seq_num));
+
+#define SAP_MSG_HANDLER(_cmd, _handler, _sz)				\
+	case SAP_MSG_NOTIF_ ## _cmd:					\
+		if (len < _sz) {					\
+			dev_err(&cldev->dev,				\
+				"Bad size for %d: %u < %u\n",		\
+				le16_to_cpu(hdr->type),			\
+				(unsigned int)len,			\
+				(unsigned int)_sz);			\
+			break;						\
+		}							\
+		mutex_lock(&iwl_mei_mutex);				\
+		_handler(cldev, (const void *)hdr);			\
+		mutex_unlock(&iwl_mei_mutex);				\
+		break
+
+#define SAP_MSG_HANDLER_NO_LOCK(_cmd, _handler, _sz)			\
+	case SAP_MSG_NOTIF_ ## _cmd:					\
+		if (len < _sz) {					\
+			dev_err(&cldev->dev,				\
+				"Bad size for %d: %u < %u\n",		\
+				le16_to_cpu(hdr->type),			\
+				(unsigned int)len,			\
+				(unsigned int)_sz);			\
+			break;						\
+		}							\
+		_handler(cldev, (const void *)hdr);			\
+		break
+
+#define SAP_MSG_HANDLER_NO_HANDLER(_cmd, _sz)				\
+	case SAP_MSG_NOTIF_ ## _cmd:					\
+		if (len < _sz) {					\
+			dev_err(&cldev->dev,				\
+				"Bad size for %d: %u < %u\n",		\
+				le16_to_cpu(hdr->type),			\
+				(unsigned int)len,			\
+				(unsigned int)_sz);			\
+			break;						\
+		}							\
+		break
+
+	switch (type) {
+	SAP_MSG_HANDLER(PING, iwl_mei_handle_ping, 0);
+	SAP_MSG_HANDLER(CSME_FILTERS,
+			iwl_mei_handle_csme_filters,
+			sizeof(struct iwl_sap_csme_filters));
+	SAP_MSG_HANDLER(CSME_CONN_STATUS,
+			iwl_mei_handle_conn_status,
+			sizeof(struct iwl_sap_notif_conn_status));
+	SAP_MSG_HANDLER_NO_LOCK(AMT_STATE,
+				iwl_mei_handle_amt_state,
+				sizeof(struct iwl_sap_msg_dw));
+	SAP_MSG_HANDLER_NO_HANDLER(PONG, 0);
+	SAP_MSG_HANDLER(NVM, iwl_mei_handle_nvm,
+			sizeof(struct iwl_sap_nvm));
+	SAP_MSG_HANDLER(CSME_REPLY_TO_HOST_OWNERSHIP_REQ,
+			iwl_mei_handle_rx_host_own_req,
+			sizeof(struct iwl_sap_msg_dw));
+	SAP_MSG_HANDLER_NO_HANDLER(NIC_OWNER, sizeof(struct iwl_sap_msg_dw));
+	SAP_MSG_HANDLER(CSME_CAN_RELEASE_OWNERSHIP,
+			iwl_mei_handle_can_release_ownership, 0);
+	SAP_MSG_HANDLER(CSME_TAKING_OWNERSHIP,
+			iwl_mei_handle_csme_taking_ownership, 0);
+	default:
+	/*
+	 * This is not really an error, there are message that we decided
+	 * to ignore, yet, it is useful to be able to leave a note if debug
+	 * is enabled.
+	 */
+	dev_dbg(&cldev->dev, "Unsupported message: type %d, len %d\n",
+		le16_to_cpu(hdr->type), len);
+	}
+
+#undef SAP_MSG_HANDLER
+#undef SAP_MSG_HANDLER_NO_LOCK
+}
+
+static void iwl_mei_read_from_q(const u8 *q_head, u32 q_sz,
+				u32 *_rd, u32 wr,
+				void *_buf, u32 len)
+{
+	u8 *buf = _buf;
+	u32 rd = *_rd;
+
+	if (rd + len <= q_sz) {
+		memcpy(buf, q_head + rd, len);
+		rd += len;
+	} else {
+		memcpy(buf, q_head + rd, q_sz - rd);
+		memcpy(buf + q_sz - rd, q_head, len - (q_sz - rd));
+		rd = len - (q_sz - rd);
+	}
+
+	*_rd = rd;
+}
+
+static void iwl_mei_handle_sap_data(struct mei_cl_device *cldev,
+				    const u8 *q_head, u32 q_sz,
+				    u32 rd, u32 wr, ssize_t valid_rx_sz,
+				    struct sk_buff_head *tx_skbs)
+{
+	struct iwl_sap_hdr hdr;
+	struct net_device *netdev =
+		rcu_dereference_protected(iwl_mei_cache.netdev,
+					  lockdep_is_held(&iwl_mei_mutex));
+
+	if (!netdev)
+		return;
+
+	while (valid_rx_sz >= sizeof(hdr)) {
+		struct ethhdr *ethhdr;
+		unsigned char *data;
+		struct sk_buff *skb;
+		u16 len;
+
+		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, &hdr, sizeof(hdr));
+		valid_rx_sz -= sizeof(hdr);
+		len = le16_to_cpu(hdr.len);
+
+		if (valid_rx_sz < len) {
+			dev_err(&cldev->dev,
+				"Data queue is corrupted: valid data len %zd, len %d\n",
+				valid_rx_sz, len);
+			break;
+		}
+
+		if (len < sizeof(*ethhdr)) {
+			dev_err(&cldev->dev,
+				"Data len is smaller than an ethernet header? len = %d\n",
+				len);
+		}
+
+		valid_rx_sz -= len;
+
+		if (le16_to_cpu(hdr.type) != SAP_MSG_DATA_PACKET) {
+			dev_err(&cldev->dev, "Unsupported Rx data: type %d, len %d\n",
+				le16_to_cpu(hdr.type), len);
+			continue;
+		}
+
+		/* We need enough room for the WiFi header + SNAP + IV */
+		skb = netdev_alloc_skb(netdev, len + 26 + 8 + 8);
+
+		skb_reserve(skb, 26 + 8 + 8);
+		ethhdr = skb_push(skb, sizeof(*ethhdr));
+
+		iwl_mei_read_from_q(q_head, q_sz, &rd, wr,
+				    ethhdr, sizeof(*ethhdr));
+		len -= sizeof(*ethhdr);
+
+		skb_reset_mac_header(skb);
+		skb_reset_network_header(skb);
+		skb->protocol = ethhdr->h_proto;
+
+		data = skb_put(skb, len);
+		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, data, len);
+
+		/*
+		 * Enqueue the skb here so that it can be sent later when we
+		 * do not hold the mutex. TX'ing a packet with a mutex held is
+		 * possible, but it wouldn't be nice to forbid the TX path to
+		 * call any of iwlmei's functions, since every API from iwlmei
+		 * needs the mutex.
+		 */
+		__skb_queue_tail(tx_skbs, skb);
+	}
+}
+
+static void iwl_mei_handle_sap_rx_cmd(struct mei_cl_device *cldev,
+				      const u8 *q_head, u32 q_sz,
+				      u32 rd, u32 wr, ssize_t valid_rx_sz)
+{
+	struct page *p = alloc_page(GFP_KERNEL);
+	struct iwl_sap_hdr *hdr;
+
+	if (!p)
+		return;
+
+	hdr = page_address(p);
+
+	while (valid_rx_sz >= sizeof(*hdr)) {
+		u16 len;
+
+		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, hdr, sizeof(*hdr));
+		valid_rx_sz -= sizeof(*hdr);
+		len = le16_to_cpu(hdr->len);
+
+		if (valid_rx_sz < len)
+			break;
+
+		iwl_mei_read_from_q(q_head, q_sz, &rd, wr, hdr + 1, len);
+
+		trace_iwlmei_sap_cmd(hdr, false);
+		iwl_mei_handle_sap_msg(cldev, hdr);
+		valid_rx_sz -= len;
+	}
+
+	/* valid_rx_sz must be 0 now... */
+	if (valid_rx_sz)
+		dev_err(&cldev->dev,
+			"More data in the buffer although we read it all\n");
+
+	__free_page(p);
+}
+
+static void iwl_mei_handle_sap_rx(struct mei_cl_device *cldev,
+				  struct iwl_sap_q_ctrl_blk *notif_q,
+				  const u8 *q_head,
+				  struct sk_buff_head *skbs)
+{
+	u32 rd = le32_to_cpu(READ_ONCE(notif_q->rd_ptr));
+	u32 wr = le32_to_cpu(READ_ONCE(notif_q->wr_ptr));
+	u32 q_sz = le32_to_cpu(notif_q->size);
+	ssize_t valid_rx_sz;
+
+	if (rd > q_sz || wr > q_sz) {
+		dev_err(&cldev->dev,
+			"Pointers are past the buffer limit\n");
+		return;
+	}
+
+	if (rd == wr)
+		return;
+
+	valid_rx_sz = wr > rd ? wr - rd : q_sz - rd + wr;
+
+	if (skbs)
+		iwl_mei_handle_sap_data(cldev, q_head, q_sz, rd, wr,
+					valid_rx_sz, skbs);
+	else
+		iwl_mei_handle_sap_rx_cmd(cldev, q_head, q_sz, rd, wr,
+					  valid_rx_sz);
+
+	/* Increment the read pointer to point to the write pointer */
+	WRITE_ONCE(notif_q->rd_ptr, cpu_to_le32(wr));
+}
+
+static void iwl_mei_handle_check_shared_area(struct mei_cl_device *cldev)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	struct iwl_sap_q_ctrl_blk *notif_q;
+	struct sk_buff_head tx_skbs;
+	struct iwl_sap_dir *dir;
+	void *q_head;
+
+	if (!mei->shared_mem.ctrl)
+		return;
+
+	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_ME_TO_HOST];
+	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_NOTIF];
+	q_head = mei->shared_mem.q_head[SAP_DIRECTION_ME_TO_HOST][SAP_QUEUE_IDX_NOTIF];
+
+	/*
+	 * Do not hold the mutex here, but rather each and every message
+	 * handler takes it.
+	 * This allows message handlers to take it at a certain time.
+	 */
+	iwl_mei_handle_sap_rx(cldev, notif_q, q_head, NULL);
+
+	mutex_lock(&iwl_mei_mutex);
+	dir = &mei->shared_mem.ctrl->dir[SAP_DIRECTION_ME_TO_HOST];
+	notif_q = &dir->q_ctrl_blk[SAP_QUEUE_IDX_DATA];
+	q_head = mei->shared_mem.q_head[SAP_DIRECTION_ME_TO_HOST][SAP_QUEUE_IDX_DATA];
+
+	__skb_queue_head_init(&tx_skbs);
+
+	iwl_mei_handle_sap_rx(cldev, notif_q, q_head, &tx_skbs);
+
+	if (skb_queue_empty(&tx_skbs)) {
+		mutex_unlock(&iwl_mei_mutex);
+		return;
+	}
+
+	/*
+	 * Take the RCU read lock before we unlock the mutex to make sure that
+	 * even if the netdev is replaced by another non-NULL netdev right after
+	 * we unlock the mutex, the old netdev will still be valid when we
+	 * transmit the frames. We can't allow to replace the netdev here because
+	 * the skbs hold a pointer to the netdev.
+	 */
+	rcu_read_lock();
+
+	mutex_unlock(&iwl_mei_mutex);
+
+	if (!rcu_access_pointer(iwl_mei_cache.netdev)) {
+		dev_err(&cldev->dev, "Can't Tx without a netdev\n");
+		skb_queue_purge(&tx_skbs);
+		goto out;
+	}
+
+	while (!skb_queue_empty(&tx_skbs)) {
+		struct sk_buff *skb = __skb_dequeue(&tx_skbs);
+
+		trace_iwlmei_sap_data(skb, IWL_SAP_RX_DATA_TO_AIR);
+		dev_queue_xmit(skb);
+	}
+
+out:
+	rcu_read_unlock();
+}
+
+static void iwl_mei_rx(struct mei_cl_device *cldev)
+{
+	struct iwl_sap_me_msg_hdr *hdr;
+	u8 msg[100];
+	ssize_t ret;
+
+	ret = mei_cldev_recv(cldev, (u8 *)&msg, sizeof(msg));
+	if (ret < 0) {
+		dev_err(&cldev->dev, "failed to receive data: %zd\n", ret);
+		return;
+	}
+
+	if (ret == 0) {
+		dev_err(&cldev->dev, "got an empty response\n");
+		return;
+	}
+
+	hdr = (void *)msg;
+	trace_iwlmei_me_msg(hdr, false);
+
+	switch (le32_to_cpu(hdr->type)) {
+	case SAP_ME_MSG_START_OK:
+		BUILD_BUG_ON(sizeof(struct iwl_sap_me_msg_start_ok) >
+			     sizeof(msg));
+
+		iwl_mei_handle_rx_start_ok(cldev, (void *)msg, ret);
+		break;
+	case SAP_ME_MSG_CHECK_SHARED_AREA:
+		iwl_mei_handle_check_shared_area(cldev);
+		break;
+	default:
+		dev_err(&cldev->dev, "got a RX notification: %d\n",
+			le32_to_cpu(hdr->type));
+		break;
+	}
+}
+
+static int iwl_mei_send_start(struct mei_cl_device *cldev)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	struct iwl_sap_me_msg_start msg = {
+		.hdr.type = cpu_to_le32(SAP_ME_MSG_START),
+		.hdr.seq_num = cpu_to_le32(atomic_inc_return(&mei->seq_no)),
+		.hdr.len = cpu_to_le32(sizeof(msg)),
+		.supported_versions[0] = SAP_VERSION,
+		.init_data_seq_num = cpu_to_le16(0x100),
+		.init_notif_seq_num = cpu_to_le16(0x800),
+	};
+	int ret;
+
+	trace_iwlmei_me_msg(&msg.hdr, true);
+	ret = mei_cldev_send(cldev, (void *)&msg, sizeof(msg));
+	if (ret != sizeof(msg)) {
+		dev_err(&cldev->dev,
+			"failed to send the SAP_ME_MSG_START message %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int iwl_mei_enable(struct mei_cl_device *cldev)
+{
+	int ret;
+
+	ret = mei_cldev_enable(cldev);
+	if (ret < 0) {
+		dev_err(&cldev->dev, "failed to enable the device: %d\n", ret);
+		return ret;
+	}
+
+	ret = mei_cldev_register_rx_cb(cldev, iwl_mei_rx);
+	if (ret) {
+		dev_err(&cldev->dev,
+			"failed to register to the rx cb: %d\n", ret);
+		mei_cldev_disable(cldev);
+		return ret;
+	}
+
+	return 0;
+}
+
+struct iwl_mei_nvm *iwl_mei_get_nvm(void)
+{
+	struct iwl_mei_nvm *nvm = NULL;
+	struct iwl_mei *mei;
+	int ret;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	ret = iwl_mei_send_sap_msg(iwl_mei_global_cldev,
+				   SAP_MSG_NOTIF_GET_NVM);
+	if (ret)
+		goto out;
+
+	mutex_unlock(&iwl_mei_mutex);
+
+	ret = wait_event_timeout(mei->get_nvm_wq, mei->nvm, 2 * HZ);
+	if (!ret)
+		return NULL;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	if (mei->nvm)
+		nvm = kmemdup(mei->nvm, sizeof(*mei->nvm), GFP_KERNEL);
+
+out:
+	mutex_unlock(&iwl_mei_mutex);
+	return nvm;
+}
+EXPORT_SYMBOL_GPL(iwl_mei_get_nvm);
+
+int iwl_mei_get_ownership(void)
+{
+	struct iwl_mei *mei;
+	int ret;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	/* In case we didn't have a bind */
+	if (!iwl_mei_is_connected()) {
+		ret = 0;
+		goto out;
+	}
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!mei->amt_enabled) {
+		ret = 0;
+		goto out;
+	}
+
+	mei->got_ownership = false;
+
+	ret = iwl_mei_send_sap_msg(mei->cldev,
+				   SAP_MSG_NOTIF_HOST_ASKS_FOR_NIC_OWNERSHIP);
+	if (ret)
+		goto out;
+
+	mutex_unlock(&iwl_mei_mutex);
+
+	ret = wait_event_timeout(mei->get_ownership_wq,
+				 mei->got_ownership, HZ / 2);
+	if (!ret)
+		return -ETIMEDOUT;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	/* In case we didn't have a bind */
+	if (!iwl_mei_is_connected()) {
+		ret = 0;
+		goto out;
+	}
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = !mei->got_ownership;
+
+out:
+	mutex_unlock(&iwl_mei_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iwl_mei_get_ownership);
+
+void iwl_mei_host_associated(const struct iwl_mei_conn_info *conn_info,
+			     const struct iwl_mei_colloc_info *colloc_info)
+{
+	struct iwl_sap_notif_host_link_up msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_HOST_LINK_UP),
+		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
+		.conn_info = {
+			.ssid_len = cpu_to_le32(conn_info->ssid_len),
+			.channel = conn_info->channel,
+			.band = conn_info->band,
+			.pairwise_cipher = cpu_to_le32(conn_info->pairwise_cipher),
+			.auth_mode = cpu_to_le32(conn_info->auth_mode),
+		},
+	};
+	struct iwl_mei *mei;
+
+	BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_OPEN !=
+		     (u32)SAP_WIFI_AUTH_TYPE_OPEN);
+	BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA !=
+		     (u32)SAP_WIFI_AUTH_TYPE_RSNA);
+	BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA_PSK !=
+		     (u32)SAP_WIFI_AUTH_TYPE_RSNA_PSK);
+	BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_SAE !=
+		     (u32)SAP_WIFI_AUTH_TYPE_SAE);
+
+	BUILD_BUG_ON((u32)IWL_MEI_CIPHER_NONE !=
+		     (u32)SAP_WIFI_CIPHER_ALG_NONE);
+	BUILD_BUG_ON((u32)IWL_MEI_CIPHER_CCMP !=
+		     (u32)SAP_WIFI_CIPHER_ALG_CCMP);
+	BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP !=
+		     (u32)SAP_WIFI_CIPHER_ALG_GCMP);
+	BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP_256 !=
+		     (u32)SAP_WIFI_CIPHER_ALG_GCMP_256);
+
+	if (conn_info->ssid_len > ARRAY_SIZE(msg.conn_info.ssid))
+		return;
+
+	memcpy(msg.conn_info.ssid, conn_info->ssid, conn_info->ssid_len);
+	memcpy(msg.conn_info.bssid, conn_info->bssid, ETH_ALEN);
+
+	if (colloc_info) {
+		msg.colloc_channel = colloc_info->channel;
+		msg.colloc_band = colloc_info->channel <= 14 ? 0 : 1;
+		memcpy(msg.colloc_bssid, colloc_info->bssid, ETH_ALEN);
+	}
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	if (!mei->amt_enabled)
+		goto out;
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
+
+out:
+	kfree(iwl_mei_cache.conn_info);
+	iwl_mei_cache.conn_info =
+		kmemdup(&msg.conn_info, sizeof(msg.conn_info), GFP_KERNEL);
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_host_associated);
+
+void iwl_mei_host_disassociated(void)
+{
+	struct iwl_mei *mei;
+	struct iwl_sap_notif_host_link_down msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_HOST_LINK_DOWN),
+		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
+		.type = HOST_LINK_DOWN_TYPE_LONG,
+	};
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
+
+out:
+	kfree(iwl_mei_cache.conn_info);
+	iwl_mei_cache.conn_info = NULL;
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_host_disassociated);
+
+void iwl_mei_set_rfkill_state(bool hw_rfkill, bool sw_rfkill)
+{
+	struct iwl_mei *mei;
+	u32 rfkill_state = 0;
+	struct iwl_sap_msg_dw msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_RADIO_STATE),
+		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
+	};
+
+	if (!sw_rfkill)
+		rfkill_state |= SAP_SW_RFKILL_DEASSERTED;
+
+	if (!hw_rfkill)
+		rfkill_state |= SAP_HW_RFKILL_DEASSERTED;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	msg.val = cpu_to_le32(rfkill_state);
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
+
+out:
+	iwl_mei_cache.rf_kill = rfkill_state;
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_set_rfkill_state);
+
+void iwl_mei_set_nic_info(const u8 *mac_address, const u8 *nvm_address)
+{
+	struct iwl_mei *mei;
+	struct iwl_sap_notif_host_nic_info msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_NIC_INFO),
+		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
+	};
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	ether_addr_copy(msg.mac_address, mac_address);
+	ether_addr_copy(msg.nvm_address, nvm_address);
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
+
+out:
+	ether_addr_copy(iwl_mei_cache.mac_address, mac_address);
+	ether_addr_copy(iwl_mei_cache.nvm_address, nvm_address);
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_set_nic_info);
+
+void iwl_mei_set_country_code(u16 mcc)
+{
+	struct iwl_mei *mei;
+	struct iwl_sap_notif_country_code msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_COUNTRY_CODE),
+		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
+		.mcc = cpu_to_le16(mcc),
+	};
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
+
+out:
+	iwl_mei_cache.mcc = mcc;
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_set_country_code);
+
+void iwl_mei_set_power_limit(const __le16 *power_limit)
+{
+	struct iwl_mei *mei;
+	struct iwl_sap_notif_sar_limits msg = {
+		.hdr.type = cpu_to_le16(SAP_MSG_NOTIF_SAR_LIMITS),
+		.hdr.len = cpu_to_le16(sizeof(msg) - sizeof(msg.hdr)),
+	};
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	memcpy(msg.sar_chain_info_table, power_limit, sizeof(msg.sar_chain_info_table));
+
+	iwl_mei_send_sap_msg_payload(mei->cldev, &msg.hdr);
+
+out:
+	kfree(iwl_mei_cache.power_limit);
+	iwl_mei_cache.power_limit = kmemdup(power_limit,
+					    sizeof(msg.sar_chain_info_table), GFP_KERNEL);
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_set_power_limit);
+
+void iwl_mei_set_netdev(struct net_device *netdev)
+{
+	struct iwl_mei *mei;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected()) {
+		rcu_assign_pointer(iwl_mei_cache.netdev, netdev);
+		goto out;
+	}
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	if (!netdev) {
+		struct net_device *dev =
+			rcu_dereference_protected(iwl_mei_cache.netdev,
+						  lockdep_is_held(&iwl_mei_mutex));
+
+		if (!dev)
+			goto out;
+
+		netdev_rx_handler_unregister(dev);
+	}
+
+	rcu_assign_pointer(iwl_mei_cache.netdev, netdev);
+
+	if (netdev && mei->amt_enabled)
+		netdev_rx_handler_register(netdev, iwl_mei_rx_handler, mei);
+
+out:
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_set_netdev);
+
+void iwl_mei_device_down(void)
+{
+	struct iwl_mei *mei;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	if (!iwl_mei_is_connected())
+		goto out;
+
+	mei = mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+	if (!mei)
+		goto out;
+
+	if (!mei->csme_taking_ownership)
+		goto out;
+
+	iwl_mei_send_sap_msg(mei->cldev,
+			     SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED);
+	mei->csme_taking_ownership = false;
+out:
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_device_down);
+
+int iwl_mei_register(void *priv, const struct iwl_mei_ops *ops)
+{
+	int ret;
+
+	/*
+	 * We must have a non-NULL priv pointer to not crash when there are
+	 * multiple WiFi devices.
+	 */
+	if (!priv)
+		return -EINVAL;
+
+	mutex_lock(&iwl_mei_mutex);
+
+	/* do not allow registration if someone else already registered */
+	if (iwl_mei_cache.priv || iwl_mei_cache.ops) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	iwl_mei_cache.priv = priv;
+	iwl_mei_cache.ops = ops;
+
+	if (iwl_mei_global_cldev) {
+		struct iwl_mei *mei =
+			mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+		/* we have already a SAP connection */
+		if (iwl_mei_is_connected())
+			iwl_mei_send_sap_msg(mei->cldev,
+					     SAP_MSG_NOTIF_WIFIDR_UP);
+	}
+	ret = 0;
+
+out:
+	mutex_unlock(&iwl_mei_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iwl_mei_register);
+
+void iwl_mei_start_unregister(void)
+{
+	mutex_lock(&iwl_mei_mutex);
+
+	/* At this point, the wifi driver should have removed the netdev */
+	if (rcu_access_pointer(iwl_mei_cache.netdev))
+		pr_err("Still had a netdev pointer set upon unregister\n");
+
+	kfree(iwl_mei_cache.conn_info);
+	iwl_mei_cache.conn_info = NULL;
+	kfree(iwl_mei_cache.power_limit);
+	iwl_mei_cache.power_limit = NULL;
+	iwl_mei_cache.ops = NULL;
+	/* leave iwl_mei_cache.priv non-NULL to prevent any new registration */
+
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_start_unregister);
+
+void iwl_mei_unregister_complete(void)
+{
+	mutex_lock(&iwl_mei_mutex);
+
+	iwl_mei_cache.priv = NULL;
+
+	if (iwl_mei_global_cldev) {
+		struct iwl_mei *mei =
+			mei_cldev_get_drvdata(iwl_mei_global_cldev);
+
+		iwl_mei_send_sap_msg(mei->cldev, SAP_MSG_NOTIF_WIFIDR_DOWN);
+	}
+
+	mutex_unlock(&iwl_mei_mutex);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_unregister_complete);
+
+/**
+ * iwl_mei_probe - the probe function called by the mei bus enumeration
+ *
+ * This allocates the data needed by iwlmei and sets a pointer to this data
+ * into the mei_cl_device's drvdata.
+ * It starts the SAP protocol by sending the SAP_ME_MSG_START without
+ * waiting for the answer. The answer will be caught later by the Rx callback.
+ */
+static int iwl_mei_probe(struct mei_cl_device *cldev,
+			 const struct mei_cl_device_id *id)
+{
+	struct iwl_mei *mei;
+	int ret;
+
+	mei = devm_kzalloc(&cldev->dev, sizeof(*mei), GFP_KERNEL);
+	if (!mei)
+		return -ENOMEM;
+
+	init_waitqueue_head(&mei->get_nvm_wq);
+	INIT_WORK(&mei->send_csa_msg_wk, iwl_mei_send_csa_msg_wk);
+	INIT_DELAYED_WORK(&mei->csa_throttle_end_wk,
+			  iwl_mei_csa_throttle_end_wk);
+	init_waitqueue_head(&mei->get_ownership_wq);
+	spin_lock_init(&mei->data_q_lock);
+
+	mei_cldev_set_drvdata(cldev, mei);
+	mei->cldev = cldev;
+
+	ret = iwl_mei_alloc_shared_mem(cldev);
+	if (ret)
+		goto free;
+
+	iwl_mei_init_shared_mem(mei);
+
+	ret = iwl_mei_enable(cldev);
+	if (ret)
+		goto free_shared_mem;
+
+	/*
+	 * We now have a Rx function in place, start the SAP procotol
+	 * we expect to get the SAP_ME_MSG_START_OK response later on.
+	 */
+	mutex_lock(&iwl_mei_mutex);
+	ret = iwl_mei_send_start(cldev);
+	mutex_unlock(&iwl_mei_mutex);
+	if (ret)
+		goto disable;
+
+	/* must be last */
+	iwl_mei_global_cldev = cldev;
+
+	return 0;
+
+disable:
+	mei_cldev_disable(cldev);
+free_shared_mem:
+	iwl_mei_free_shared_mem(cldev);
+free:
+	mei_cldev_set_drvdata(cldev, NULL);
+	devm_kfree(&cldev->dev, mei);
+
+	return ret;
+}
+
+static void iwl_mei_remove(struct mei_cl_device *cldev)
+{
+	struct iwl_mei *mei = mei_cldev_get_drvdata(cldev);
+	int i;
+
+	/*
+	 * We are being removed while the bus is active, it means we are
+	 * going to suspend/ shutdown, so the NIC will disappear.
+	 */
+	if (mei_cldev_enabled(cldev) && iwl_mei_cache.ops)
+		iwl_mei_cache.ops->nic_stolen(iwl_mei_cache.priv);
+
+	if (rcu_access_pointer(iwl_mei_cache.netdev)) {
+		struct net_device *dev;
+
+		/*
+		 * If we are suspending and the wifi driver hasn't removed it's netdev
+		 * yet, do it now. In any case, don't change the cache.netdev pointer.
+		 */
+		dev = rcu_dereference_protected(iwl_mei_cache.netdev,
+						lockdep_is_held(&iwl_mei_mutex));
+
+		rtnl_lock();
+		netdev_rx_handler_unregister(dev);
+		rtnl_unlock();
+	}
+
+	mutex_lock(&iwl_mei_mutex);
+
+	/*
+	 * Tell CSME that we are going down so that it won't access the
+	 * memory anymore, make sure this message goes through immediately.
+	 */
+	mei->csa_throttled = false;
+	iwl_mei_send_sap_msg(mei->cldev,
+			     SAP_MSG_NOTIF_HOST_GOES_DOWN);
+
+	for (i = 0; i < 10; i++) {
+		if (!iwl_mei_host_to_me_data_pending(mei))
+			break;
+
+		msleep(5);
+	}
+
+	/*
+	 * If we couldn't make sure that CSME saw the HOST_GOES_DOWN message,
+	 * it means that it will probably keep reading memory that we are going
+	 * to unmap and free, expect IOMMU error messages.
+	 */
+	if (i == 10)
+		dev_err(&mei->cldev->dev,
+			"Couldn't get ACK from CSME on HOST_GOES_DOWN message\n");
+
+	mutex_unlock(&iwl_mei_mutex);
+
+	/*
+	 * This looks strange, but this lock is taken here to make sure that
+	 * iwl_mei_add_data_to_ring called from the Tx path sees that we
+	 * clear the IWL_MEI_STATUS_SAP_CONNECTED bit.
+	 * Rx isn't a problem because the rx_handler can't be called after
+	 * having been unregistered.
+	 */
+	spin_lock_bh(&mei->data_q_lock);
+	clear_bit(IWL_MEI_STATUS_SAP_CONNECTED, &iwl_mei_status);
+	spin_unlock_bh(&mei->data_q_lock);
+
+	if (iwl_mei_cache.ops)
+		iwl_mei_cache.ops->rfkill(iwl_mei_cache.priv, false);
+
+	/*
+	 * mei_cldev_disable will return only after all the MEI Rx is done.
+	 * It must be called when iwl_mei_mutex is *not* held, since it waits
+	 * for our Rx handler to complete.
+	 * After it returns, no new Rx will start.
+	 */
+	mei_cldev_disable(cldev);
+
+	/*
+	 * Since the netdev was already removed and the netdev's removal
+	 * includes a call to synchronize_net() so that we know there won't be
+	 * any new Rx that will trigger the following workers.
+	 */
+	cancel_work_sync(&mei->send_csa_msg_wk);
+	cancel_delayed_work_sync(&mei->csa_throttle_end_wk);
+
+	/*
+	 * If someone waits for the ownership, let him know that we are going
+	 * down and that we are not connected anymore. He'll be able to take
+	 * the device.
+	 */
+	wake_up_all(&mei->get_ownership_wq);
+
+	mutex_lock(&iwl_mei_mutex);
+
+	iwl_mei_global_cldev = NULL;
+
+	wake_up_all(&mei->get_nvm_wq);
+
+	iwl_mei_free_shared_mem(cldev);
+
+	mei_cldev_set_drvdata(cldev, NULL);
+
+	kfree(mei->nvm);
+
+	kfree(mei->filters);
+
+	devm_kfree(&cldev->dev, mei);
+
+	mutex_unlock(&iwl_mei_mutex);
+}
+
+static struct mei_cl_device_id iwl_mei_tbl[] = {
+	{ KBUILD_MODNAME, MEI_WLAN_UUID, MEI_CL_VERSION_ANY},
+
+	/* required last entry */
+	{ }
+};
+
+/*
+ * Do not export the device table because this module is loaded by
+ * iwlwifi's dependency.
+ */
+
+static struct mei_cl_driver iwl_mei_cl_driver = {
+	.id_table = iwl_mei_tbl,
+	.name = KBUILD_MODNAME,
+	.probe = iwl_mei_probe,
+	.remove = iwl_mei_remove,
+};
+
+module_mei_cl_driver(iwl_mei_cl_driver);
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/net.c b/drivers/net/wireless/intel/iwlwifi/mei/net.c
new file mode 100644
index 000000000000..1a31541708b8
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/net.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#include <uapi/linux/if_ether.h>
+#include <uapi/linux/if_arp.h>
+#include <uapi/linux/icmp.h>
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/ieee80211.h>
+
+#include <net/cfg80211.h>
+#include <net/ip.h>
+
+#include <linux/if_arp.h>
+#include <linux/icmp.h>
+#include <linux/udp.h>
+#include <linux/ip.h>
+#include <linux/mm.h>
+
+#include "internal.h"
+#include "sap.h"
+#include "iwl-mei.h"
+
+/*
+ * Returns true if further filtering should be stopped. Only in that case
+ * pass_to_csme and rx_handler_res are set. Otherwise, next level of filters
+ * should be checked.
+ */
+static bool iwl_mei_rx_filter_eth(const struct ethhdr *ethhdr,
+				  const struct iwl_sap_oob_filters *filters,
+				  bool *pass_to_csme,
+				  rx_handler_result_t *rx_handler_res)
+{
+	const struct iwl_sap_eth_filter *filt;
+
+	/* This filter is not relevant for UCAST packet */
+	if (!is_multicast_ether_addr(ethhdr->h_dest) ||
+	    is_broadcast_ether_addr(ethhdr->h_dest))
+		return false;
+
+	for (filt = &filters->eth_filters[0];
+	     filt < &filters->eth_filters[0] + ARRAY_SIZE(filters->eth_filters);
+	     filt++) {
+		/* Assume there are no enabled filter after a disabled one */
+		if (!(filt->flags & SAP_ETH_FILTER_ENABLED))
+			break;
+
+		if (compare_ether_header(filt->mac_address, ethhdr->h_dest))
+			continue;
+
+		/* Packet needs to reach the host's stack */
+		if (filt->flags & SAP_ETH_FILTER_COPY)
+			*rx_handler_res = RX_HANDLER_PASS;
+		else
+			*rx_handler_res = RX_HANDLER_CONSUMED;
+
+		/* We have an authoritative answer, stop filtering */
+		if (filt->flags & SAP_ETH_FILTER_STOP) {
+			*pass_to_csme = true;
+			return true;
+		}
+
+		return false;
+	}
+
+	 /* MCAST frames that don't match layer 2 filters are not sent to ME */
+	*pass_to_csme  = false;
+
+	return true;
+}
+
+/*
+ * Returns true iff the frame should be passed to CSME in which case
+ * rx_handler_res is set.
+ */
+static bool iwl_mei_rx_filter_arp(struct sk_buff *skb,
+				  const struct iwl_sap_oob_filters *filters,
+				  rx_handler_result_t *rx_handler_res)
+{
+	const struct iwl_sap_ipv4_filter *filt = &filters->ipv4_filter;
+	const struct arphdr *arp;
+	const __be32 *target_ip;
+	u32 flags = le32_to_cpu(filt->flags);
+
+	if (!pskb_may_pull(skb, arp_hdr_len(skb->dev)))
+		return false;
+
+	arp = arp_hdr(skb);
+
+	/* Handle only IPv4 over ethernet ARP frames */
+	if (arp->ar_hrd != htons(ARPHRD_ETHER) ||
+	    arp->ar_pro != htons(ETH_P_IP))
+		return false;
+
+	/*
+	 * After the ARP header, we have:
+	 * src MAC address   - 6 bytes
+	 * src IP address    - 4 bytes
+	 * target MAC addess - 6 bytes
+	 */
+	target_ip = (void *)((u8 *)(arp + 1) +
+			     ETH_ALEN + sizeof(__be32) + ETH_ALEN);
+
+	/*
+	 * ARP request is forwarded to ME only if IP address match in the
+	 * ARP request's target ip field.
+	 */
+	if (arp->ar_op == htons(ARPOP_REQUEST) &&
+	    (filt->flags & cpu_to_le32(SAP_IPV4_FILTER_ARP_REQ_PASS)) &&
+	    (filt->ipv4_addr == 0 || filt->ipv4_addr == *target_ip)) {
+		if (flags & SAP_IPV4_FILTER_ARP_REQ_COPY)
+			*rx_handler_res = RX_HANDLER_PASS;
+		else
+			*rx_handler_res = RX_HANDLER_CONSUMED;
+
+		return true;
+	}
+
+	/* ARP reply is always forwarded to ME regardless of the IP */
+	if (flags & SAP_IPV4_FILTER_ARP_RESP_PASS &&
+	    arp->ar_op == htons(ARPOP_REPLY)) {
+		if (flags & SAP_IPV4_FILTER_ARP_RESP_COPY)
+			*rx_handler_res = RX_HANDLER_PASS;
+		else
+			*rx_handler_res = RX_HANDLER_CONSUMED;
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool
+iwl_mei_rx_filter_tcp_udp(struct sk_buff *skb, bool  ip_match,
+			  const struct iwl_sap_oob_filters *filters,
+			  rx_handler_result_t *rx_handler_res)
+{
+	const struct iwl_sap_flex_filter *filt;
+
+	for (filt = &filters->flex_filters[0];
+	     filt < &filters->flex_filters[0] + ARRAY_SIZE(filters->flex_filters);
+	     filt++) {
+		if (!(filt->flags & SAP_FLEX_FILTER_ENABLED))
+			break;
+
+		/*
+		 * We are required to have a match on the IP level and we didn't
+		 * have such match.
+		 */
+		if ((filt->flags &
+		     (SAP_FLEX_FILTER_IPV4 | SAP_FLEX_FILTER_IPV6)) &&
+		    !ip_match)
+			continue;
+
+		if ((filt->flags & SAP_FLEX_FILTER_UDP) &&
+		    ip_hdr(skb)->protocol != IPPROTO_UDP)
+			continue;
+
+		if ((filt->flags & SAP_FLEX_FILTER_TCP) &&
+		    ip_hdr(skb)->protocol != IPPROTO_TCP)
+			continue;
+
+		/*
+		 * We must have either a TCP header or a UDP header, both
+		 * starts with a source port and then a destination port.
+		 * Both are big endian words.
+		 * Use a UDP header and that will work for TCP as well.
+		 */
+		if ((filt->src_port && filt->src_port != udp_hdr(skb)->source) ||
+		    (filt->dst_port && filt->dst_port != udp_hdr(skb)->dest))
+			continue;
+
+		if (filt->flags & SAP_FLEX_FILTER_COPY)
+			*rx_handler_res = RX_HANDLER_PASS;
+		else
+			*rx_handler_res = RX_HANDLER_CONSUMED;
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool iwl_mei_rx_filter_ipv4(struct sk_buff *skb,
+				   const struct iwl_sap_oob_filters *filters,
+				   rx_handler_result_t *rx_handler_res)
+{
+	const struct iwl_sap_ipv4_filter *filt = &filters->ipv4_filter;
+	const struct iphdr *iphdr;
+	unsigned int iphdrlen;
+	bool match;
+
+	if (!pskb_may_pull(skb, skb_network_offset(skb) + sizeof(*iphdr)) ||
+	    !pskb_may_pull(skb, skb_network_offset(skb) +
+			   sizeof(ip_hdrlen(skb) - sizeof(*iphdr))))
+		return false;
+
+	iphdrlen = ip_hdrlen(skb);
+	iphdr = ip_hdr(skb);
+	match = !filters->ipv4_filter.ipv4_addr ||
+		filters->ipv4_filter.ipv4_addr == iphdr->daddr;
+
+	skb_set_transport_header(skb, skb_network_offset(skb) + iphdrlen);
+
+	switch (ip_hdr(skb)->protocol) {
+	case IPPROTO_UDP:
+	case IPPROTO_TCP:
+		/*
+		 * UDP header is shorter than TCP header and we look at the first bytes
+		 * of the header anyway (see below).
+		 * If we have a truncated TCP packet, let CSME handle this.
+		 */
+		if (!pskb_may_pull(skb, skb_transport_offset(skb) +
+				   sizeof(struct udphdr)))
+			return false;
+
+		return iwl_mei_rx_filter_tcp_udp(skb, match,
+						 filters, rx_handler_res);
+
+	case IPPROTO_ICMP: {
+		struct icmphdr *icmp;
+
+		if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(*icmp)))
+			return false;
+
+		icmp = icmp_hdr(skb);
+
+		/*
+		 * Don't pass echo requests to ME even if it wants it as we
+		 * want the host to answer.
+		 */
+		if ((filt->flags & cpu_to_le32(SAP_IPV4_FILTER_ICMP_PASS)) &&
+		    match && (icmp->type != ICMP_ECHO || icmp->code != 0)) {
+			if (filt->flags & cpu_to_le32(SAP_IPV4_FILTER_ICMP_COPY))
+				*rx_handler_res = RX_HANDLER_PASS;
+			else
+				*rx_handler_res = RX_HANDLER_CONSUMED;
+
+			return true;
+		}
+		break;
+		}
+	case IPPROTO_ICMPV6:
+		/* TODO: Should we have the same ICMP request logic here too? */
+		if ((filters->icmpv6_flags & cpu_to_le32(SAP_ICMPV6_FILTER_ENABLED) &&
+		     match)) {
+			if (filters->icmpv6_flags &
+			    cpu_to_le32(SAP_ICMPV6_FILTER_COPY))
+				*rx_handler_res = RX_HANDLER_PASS;
+			else
+				*rx_handler_res = RX_HANDLER_CONSUMED;
+
+			return true;
+		}
+		break;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static bool iwl_mei_rx_filter_ipv6(struct sk_buff *skb,
+				   const struct iwl_sap_oob_filters *filters,
+				   rx_handler_result_t *rx_handler_res)
+{
+	*rx_handler_res = RX_HANDLER_PASS;
+
+	/* TODO */
+
+	return false;
+}
+
+static rx_handler_result_t
+iwl_mei_rx_pass_to_csme(struct sk_buff *skb,
+			const struct iwl_sap_oob_filters *filters,
+			bool *pass_to_csme)
+{
+	const struct ethhdr *ethhdr = (void *)skb_mac_header(skb);
+	rx_handler_result_t rx_handler_res = RX_HANDLER_PASS;
+	bool (*filt_handler)(struct sk_buff *skb,
+			     const struct iwl_sap_oob_filters *filters,
+			     rx_handler_result_t *rx_handler_res);
+
+	/*
+	 * skb->data points the IP header / ARP header and the ETH header
+	 * is in the headroom.
+	 */
+	skb_reset_network_header(skb);
+
+	/*
+	 * MCAST IP packets sent by us are received again here without
+	 * an ETH header. Drop them here.
+	 */
+	if (!skb_mac_offset(skb))
+		return RX_HANDLER_PASS;
+
+	if (skb_headroom(skb) < sizeof(*ethhdr))
+		return RX_HANDLER_PASS;
+
+	if (iwl_mei_rx_filter_eth(ethhdr, filters,
+				  pass_to_csme, &rx_handler_res))
+		return rx_handler_res;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		filt_handler = iwl_mei_rx_filter_ipv4;
+		break;
+	case htons(ETH_P_ARP):
+		filt_handler = iwl_mei_rx_filter_arp;
+		break;
+	case htons(ETH_P_IPV6):
+		filt_handler = iwl_mei_rx_filter_ipv6;
+		break;
+	default:
+		*pass_to_csme = false;
+		return rx_handler_res;
+	}
+
+	*pass_to_csme = filt_handler(skb, filters, &rx_handler_res);
+
+	return rx_handler_res;
+}
+
+rx_handler_result_t iwl_mei_rx_filter(struct sk_buff *orig_skb,
+				      const struct iwl_sap_oob_filters *filters,
+				      bool *pass_to_csme)
+{
+	rx_handler_result_t ret;
+	struct sk_buff *skb;
+
+	ret = iwl_mei_rx_pass_to_csme(orig_skb, filters, pass_to_csme);
+
+	if (!*pass_to_csme)
+		return RX_HANDLER_PASS;
+
+	if (ret == RX_HANDLER_PASS)
+		skb = skb_copy(orig_skb, GFP_ATOMIC);
+	else
+		skb = orig_skb;
+
+	/* CSME wants the MAC header as well, push it back */
+	skb_push(skb, skb->data - skb_mac_header(skb));
+
+	/*
+	 * Add the packet that CSME wants to get to the ring. Don't send the
+	 * Check Shared Area HECI message since this is not possible from the
+	 * Rx context. The caller will schedule a worker to do just that.
+	 */
+	iwl_mei_add_data_to_ring(skb, false);
+
+	/*
+	 * In case we drop the packet, don't free it, the caller will do that
+	 * for us
+	 */
+	if (ret == RX_HANDLER_PASS)
+		dev_kfree_skb(skb);
+
+	return ret;
+}
+
+#define DHCP_SERVER_PORT 67
+#define DHCP_CLIENT_PORT 68
+void iwl_mei_tx_copy_to_csme(struct sk_buff *origskb, unsigned int ivlen)
+{
+	struct ieee80211_hdr *hdr;
+	struct sk_buff *skb;
+	struct ethhdr ethhdr;
+	struct ethhdr *eth;
+
+	/* Catch DHCP packets */
+	if (origskb->protocol != htons(ETH_P_IP) ||
+	    ip_hdr(origskb)->protocol != IPPROTO_UDP ||
+	    udp_hdr(origskb)->source != htons(DHCP_CLIENT_PORT) ||
+	    udp_hdr(origskb)->dest != htons(DHCP_SERVER_PORT))
+		return;
+
+	/*
+	 * We could be a bit less aggressive here and not copy everything, but
+	 * this is very rare anyway, do don't bother much.
+	 */
+	skb = skb_copy(origskb, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	skb->protocol = origskb->protocol;
+
+	hdr = (void *)skb->data;
+
+	memcpy(ethhdr.h_dest, ieee80211_get_DA(hdr), ETH_ALEN);
+	memcpy(ethhdr.h_source, ieee80211_get_SA(hdr), ETH_ALEN);
+
+	/*
+	 * Remove the ieee80211 header + IV + SNAP but leave the ethertype
+	 * We still have enough headroom for the sap header.
+	 */
+	pskb_pull(skb, ieee80211_hdrlen(hdr->frame_control) + ivlen + 6);
+	eth = skb_push(skb, sizeof(ethhdr.h_dest) + sizeof(ethhdr.h_source));
+	memcpy(eth, &ethhdr, sizeof(ethhdr.h_dest) + sizeof(ethhdr.h_source));
+
+	iwl_mei_add_data_to_ring(skb, true);
+
+	dev_kfree_skb(skb);
+}
+EXPORT_SYMBOL_GPL(iwl_mei_tx_copy_to_csme);
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/sap.h b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
new file mode 100644
index 000000000000..96f0b17adfef
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
@@ -0,0 +1,731 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#ifndef __sap_h__
+#define __sap_h__
+
+/**
+ * DOC: Introduction
+ *
+ * SAP is the protocol used by the Intel Wireless driver (iwlwifi)
+ * and the wireless driver implemented in the CSME firmware.
+ * It allows to do several things:
+ * 1) Decide who is the owner of the device: CSME or the host
+ * 2) When the host is the owner of the device, CSME can still
+ * send and receive packets through iwlwifi.
+ *
+ * The protocol uses the ME interface (mei driver) to send
+ * messages to the CSME firmware. Those messages have a header
+ * &struct iwl_sap_me_msg_hdr and this header is followed
+ * by a payload.
+ *
+ * Since this messaging system cannot support high amounts of
+ * traffic, iwlwifi and the CSME firmware's WLAN driver have an
+ * addtional communication pipe to exchange information. The body
+ * of the message is copied to a shared area and the message that
+ * goes over the ME interface just signals the other side
+ * that a new message is waiting in the shared area. The ME
+ * interface is used only for signaling and not to transfer
+ * the payload.
+ *
+ * This shared area of memory is DMA'able mapped to be
+ * writable by both the CSME firmware and iwlwifi. It is
+ * mapped to address space of the device that controls the ME
+ * interface's DMA engine. Any data that iwlwifi needs to
+ * send to the CSME firmware needs to be copied to there.
+ */
+
+/**
+ * DOC: Initial Handshake
+ *
+ * Once we get a link to the CMSE's WLAN driver we start the handshake
+ * to establish the shared memory that will allow the communication between
+ * the CSME's WLAN driver and the host.
+ *
+ * 1) Host sends %SAP_ME_MSG_START message with the physical address
+ * of the shared area.
+ * 2) CSME replies with %SAP_ME_MSG_START_OK which includes the versions
+ * protocol versions supported by CSME.
+ */
+
+/**
+ * DOC: Host and driver state messages
+ *
+ * In order to let CSME konw about the host state and the host driver state,
+ * the host sends messages that let CSME know about the host's state.
+ * When the host driver is loaded, the host sends %SAP_MSG_NOTIF_WIFIDR_UP.
+ * When the host driver is unloaded, the host sends %SAP_MSG_NOTIF_WIFIDR_DOWN.
+ * When the iwlmei is unloaded, %SAP_MSG_NOTIF_HOST_GOES_DOWN is sent to let
+ * CSME know not to access the shared memory anymore since it'll be freed.
+ *
+ * CSME will reply to SAP_MSG_NOTIF_WIFIDR_UP by
+ * %SAP_MSG_NOTIF_AMT_STATE to let the host driver whether CSME can use the
+ * WiFi device or not followed by %SAP_MSG_NOTIF_CSME_CONN_STATUS to inform
+ * the host driver on the connection state of CSME.
+ *
+ * When host is associated to an AP, it must send %SAP_MSG_NOTIF_HOST_LINK_UP
+ * and when it disconnect from the AP, it must send
+ * %SAP_MSG_NOTIF_HOST_LINK_DOWN.
+ */
+
+/**
+ * DOC: Ownership
+ *
+ * The device can be controlled either by the CSME firmware or
+ * by the host driver: iwlwifi. There is a negotiaion between
+ * those two entities to determine who controls (or owns) the
+ * device. Since the CSME can control the device even when the
+ * OS is not working or even missing, the CSME can request the
+ * device if it comes to the conclusion that the OS's host driver
+ * is not operational. This is why the host driver needs to
+ * signal CSME that it is up and running. If the driver is
+ * unloaded, it'll signal CSME that it is going down so that
+ * CSME can take ownership.
+ */
+
+/**
+ * DOC: Ownership transfer
+ *
+ * When the host driver needs the device, it'll send the
+ * %SAP_MSG_NOTIF_HOST_ASKS_FOR_NIC_OWNERSHIP that will be replied by
+ * %SAP_MSG_NOTIF_CSME_REPLY_TO_HOST_OWNERSHIP_REQ which will let the
+ * host know whether the ownership is granted or no. If the ownership is
+ * granted, the hosts sends %SAP_MSG_NOTIF_HOST_OWNERSHIP_CONFIRMED.
+ *
+ * When CSME requests ownership, it'll send the
+ * %SAP_MSG_NOTIF_CSME_TAKING_OWNERSHIP and give some time to host to stop
+ * accessing the device. The host needs to send
+ * %SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED to confirm that it won't access
+ * the device anymore. If the host failed to send this message fast enough,
+ * CSME will take ownership on the device anyway.
+ * When CSME is willing to release the ownership, it'll send
+ * %SAP_MSG_NOTIF_CSME_CAN_RELEASE_OWNERSHIP.
+ */
+
+/**
+ * DOC: Data messages
+ *
+ * Data messages must be sent and receives on a separate queue in the shared
+ * memory. Almost all the data messages use the %SAP_MSG_DATA_PACKET for both
+ * packets sent by CSME to the host to be sent to the AP or for packets
+ * received from the AP and sent by the host to CSME.
+ * CSME sends filters to the host to let the host what inbound packets it must
+ * send to CSME. Those filters are received by the host as a
+ * %SAP_MSG_NOTIF_CSME_FILTERS command.
+ * The only outbound packets that must be sent to CSME are the DHCP packets.
+ * Those packets must use the %SAP_MSG_CB_DATA_PACKET message.
+ */
+
+/**
+ * enum iwl_sap_me_msg_id - the ID of the ME message
+ * @SAP_ME_MSG_START: See &struct iwl_sap_me_msg_start.
+ * @SAP_ME_MSG_START_OK: See &struct iwl_sap_me_msg_start_ok.
+ * @SAP_ME_MSG_CHECK_SHARED_AREA: This message has no payload.
+ */
+enum iwl_sap_me_msg_id {
+	SAP_ME_MSG_START	= 1,
+	SAP_ME_MSG_START_OK,
+	SAP_ME_MSG_CHECK_SHARED_AREA,
+};
+
+/**
+ * struct iwl_sap_me_msg_hdr - the header of the ME message
+ * @type: the type of the message, see &enum iwl_sap_me_msg_id.
+ * @seq_num: a sequence number used for debug only.
+ * @len: the length of the mssage.
+ */
+struct iwl_sap_me_msg_hdr {
+	__le32 type;
+	__le32 seq_num;
+	__le32 len;
+} __packed;
+
+/**
+ * struct iwl_sap_me_msg_start - used for the %SAP_ME_MSG_START message
+ * @hdr: See &struct iwl_sap_me_msg_hdr.
+ * @shared_mem: physical address of SAP shared memory area.
+ * @init_data_seq_num: seq_num of the first data packet HOST -> CSME.
+ * @init_notif_seq_num: seq_num of the first notification HOST -> CSME.
+ * @supported_versions: The host sends to the CSME a zero-terminated array
+ * of versions its supports.
+ *
+ * This message is sent by the host to CSME and will responded by the
+ * %SAP_ME_MSG_START_OK message.
+ */
+struct iwl_sap_me_msg_start {
+	struct iwl_sap_me_msg_hdr hdr;
+	__le64 shared_mem;
+	__le16 init_data_seq_num;
+	__le16 init_notif_seq_num;
+	u8 supported_versions[64];
+} __packed;
+
+/**
+ * struct iwl_sap_me_msg_start_ok - used for the %SAP_ME_MSG_START_OK
+ * @hdr: See &struct iwl_sap_me_msg_hdr
+ * @init_data_seq_num: Not used.
+ * @init_notif_seq_num: Not used
+ * @supported_version: The version that will be used.
+ * @reserved: For alignment.
+ *
+ * This message is sent by CSME to the host in response to the
+ * %SAP_ME_MSG_START message.
+ */
+struct iwl_sap_me_msg_start_ok {
+	struct iwl_sap_me_msg_hdr hdr;
+	__le16 init_data_seq_num;
+	__le16 init_notif_seq_num;
+	u8 supported_version;
+	u8 reserved[3];
+} __packed;
+
+/**
+ * enum iwl_sap_msg - SAP messages
+ * @SAP_MSG_NOTIF_BOTH_WAYS_MIN: Not used.
+ * @SAP_MSG_NOTIF_PING: No payload. Solicitate a response message (check-alive).
+ * @SAP_MSG_NOTIF_PONG: No payload. The response message.
+ * @SAP_MSG_NOTIF_BOTH_WAYS_MAX: Not used.
+ *
+ * @SAP_MSG_NOTIF_FROM_CSME_MIN: Not used.
+ * @SAP_MSG_NOTIF_CSME_FILTERS: TODO
+ * @SAP_MSG_NOTIF_AMT_STATE: Payload is a DW. Any non-zero value means
+ *	that CSME is enabled.
+ * @SAP_MSG_NOTIF_CSME_REPLY_TO_HOST_OWNERSHIP_REQ: Payload is a DW. 0 means
+ *	the host will not get ownership. Any other value means the host is
+ *	the owner.
+ * @SAP_MSG_NOTIF_CSME_TAKING_OWNERSHIP: No payload.
+ * @SAP_MSG_NOTIF_TRIGGER_IP_REFRESH: No payload.
+ * @SAP_MSG_NOTIF_CSME_CAN_RELEASE_OWNERSHIP: No payload.
+ * @SAP_MSG_NOTIF_NIC_OWNER: Payload is a DW. See &enum iwl_sap_nic_owner.
+ * @SAP_MSG_NOTIF_CSME_CONN_STATUS: See &struct iwl_sap_notif_conn_status.
+ * @SAP_MSG_NOTIF_NVM: See &struct iwl_sap_nvm.
+ * @SAP_MSG_NOTIF_FROM_CSME_MAX: Not used.
+ *
+ * @SAP_MSG_NOTIF_FROM_HOST_MIN: Not used.
+ * @SAP_MSG_NOTIF_BAND_SELECTION: TODO
+ * @SAP_MSG_NOTIF_RADIO_STATE: Payload is a DW.
+ *	See &enum iwl_sap_radio_state_bitmap.
+ * @SAP_MSG_NOTIF_NIC_INFO: See &struct iwl_sap_notif_host_nic_info.
+ * @SAP_MSG_NOTIF_HOST_ASKS_FOR_NIC_OWNERSHIP: No payload.
+ * @SAP_MSG_NOTIF_HOST_SUSPENDS: Payload is a DW. Bitmap described in
+ *	&enum iwl_sap_notif_host_suspends_bitmap.
+ * @SAP_MSG_NOTIF_HOST_RESUMES: Payload is a DW. 0 or 1. 1 says that
+ *	the CSME should re-initialize the init control block.
+ * @SAP_MSG_NOTIF_HOST_GOES_DOWN: No payload.
+ * @SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED: No payload.
+ * @SAP_MSG_NOTIF_COUNTRY_CODE: See &struct iwl_sap_notif_country_code.
+ * @SAP_MSG_NOTIF_HOST_LINK_UP: See &struct iwl_sap_notif_host_link_up.
+ * @SAP_MSG_NOTIF_HOST_LINK_DOWN: See &struct iwl_sap_notif_host_link_down.
+ * @SAP_MSG_NOTIF_WHO_OWNS_NIC: No payload.
+ * @SAP_MSG_NOTIF_WIFIDR_DOWN: No payload.
+ * @SAP_MSG_NOTIF_WIFIDR_UP: No payload.
+ * @SAP_MSG_NOTIF_HOST_OWNERSHIP_CONFIRMED: No payload.
+ * @SAP_MSG_NOTIF_SAR_LIMITS: See &struct iwl_sap_notif_sar_limits.
+ * @SAP_MSG_NOTIF_GET_NVM: No payload. Triggers %SAP_MSG_NOTIF_NVM.
+ * @SAP_MSG_NOTIF_FROM_HOST_MAX: Not used.
+ *
+ * @SAP_MSG_DATA_MIN: Not used.
+ * @SAP_MSG_DATA_PACKET: Packets that passed the filters defined by
+ *	%SAP_MSG_NOTIF_CSME_FILTERS. The payload is &struct iwl_sap_hdr with
+ *	the payload of the packet immediately afterwards.
+ * @SAP_MSG_CB_DATA_PACKET: Indicates to CSME that we transmitted a specific
+ *	packet. Used only for DHCP transmitted packets. See
+ *	&struct iwl_sap_cb_data.
+ * @SAP_MSG_DATA_MAX: Not used.
+ */
+enum iwl_sap_msg {
+	SAP_MSG_NOTIF_BOTH_WAYS_MIN			= 0,
+	SAP_MSG_NOTIF_PING				= 1,
+	SAP_MSG_NOTIF_PONG				= 2,
+	SAP_MSG_NOTIF_BOTH_WAYS_MAX,
+
+	SAP_MSG_NOTIF_FROM_CSME_MIN			= 500,
+	SAP_MSG_NOTIF_CSME_FILTERS			= SAP_MSG_NOTIF_FROM_CSME_MIN,
+	/* 501 is deprecated */
+	SAP_MSG_NOTIF_AMT_STATE				= 502,
+	SAP_MSG_NOTIF_CSME_REPLY_TO_HOST_OWNERSHIP_REQ	= 503,
+	SAP_MSG_NOTIF_CSME_TAKING_OWNERSHIP		= 504,
+	SAP_MSG_NOTIF_TRIGGER_IP_REFRESH		= 505,
+	SAP_MSG_NOTIF_CSME_CAN_RELEASE_OWNERSHIP	= 506,
+	/* 507 is deprecated */
+	/* 508 is deprecated */
+	/* 509 is deprecated */
+	/* 510 is deprecated */
+	SAP_MSG_NOTIF_NIC_OWNER				= 511,
+	SAP_MSG_NOTIF_CSME_CONN_STATUS			= 512,
+	SAP_MSG_NOTIF_NVM				= 513,
+	SAP_MSG_NOTIF_FROM_CSME_MAX,
+
+	SAP_MSG_NOTIF_FROM_HOST_MIN			= 1000,
+	SAP_MSG_NOTIF_BAND_SELECTION			= SAP_MSG_NOTIF_FROM_HOST_MIN,
+	SAP_MSG_NOTIF_RADIO_STATE			= 1001,
+	SAP_MSG_NOTIF_NIC_INFO				= 1002,
+	SAP_MSG_NOTIF_HOST_ASKS_FOR_NIC_OWNERSHIP	= 1003,
+	SAP_MSG_NOTIF_HOST_SUSPENDS			= 1004,
+	SAP_MSG_NOTIF_HOST_RESUMES			= 1005,
+	SAP_MSG_NOTIF_HOST_GOES_DOWN			= 1006,
+	SAP_MSG_NOTIF_CSME_OWNERSHIP_CONFIRMED		= 1007,
+	SAP_MSG_NOTIF_COUNTRY_CODE			= 1008,
+	SAP_MSG_NOTIF_HOST_LINK_UP			= 1009,
+	SAP_MSG_NOTIF_HOST_LINK_DOWN			= 1010,
+	SAP_MSG_NOTIF_WHO_OWNS_NIC			= 1011,
+	SAP_MSG_NOTIF_WIFIDR_DOWN			= 1012,
+	SAP_MSG_NOTIF_WIFIDR_UP				= 1013,
+	/* 1014 is deprecated */
+	SAP_MSG_NOTIF_HOST_OWNERSHIP_CONFIRMED		= 1015,
+	SAP_MSG_NOTIF_SAR_LIMITS			= 1016,
+	SAP_MSG_NOTIF_GET_NVM				= 1017,
+	SAP_MSG_NOTIF_FROM_HOST_MAX,
+
+	SAP_MSG_DATA_MIN				= 2000,
+	SAP_MSG_DATA_PACKET				= SAP_MSG_DATA_MIN,
+	SAP_MSG_CB_DATA_PACKET				= 2001,
+	SAP_MSG_DATA_MAX,
+};
+
+/**
+ * struct iwl_sap_hdr - prefixes any SAP message
+ * @type: See &enum iwl_sap_msg.
+ * @len: The length of the message (header not included).
+ * @seq_num: For debug.
+ * @payload: The payload of the message.
+ */
+struct iwl_sap_hdr {
+	__le16 type;
+	__le16 len;
+	__le32 seq_num;
+	u8 payload[0];
+};
+
+/**
+ * struct iwl_sap_msg_dw - suits any DW long SAP message
+ * @hdr: The SAP header
+ * @val: The value of the DW.
+ */
+struct iwl_sap_msg_dw {
+	struct iwl_sap_hdr hdr;
+	__le32 val;
+};
+
+/**
+ * enum iwl_sap_nic_owner - used by %SAP_MSG_NOTIF_NIC_OWNER
+ * @SAP_NIC_OWNER_UNKNOWN: Not used.
+ * @SAP_NIC_OWNER_HOST: The host owns the NIC.
+ * @SAP_NIC_OWNER_ME: CSME owns the NIC.
+ */
+enum iwl_sap_nic_owner {
+	SAP_NIC_OWNER_UNKNOWN,
+	SAP_NIC_OWNER_HOST,
+	SAP_NIC_OWNER_ME,
+};
+
+enum iwl_sap_wifi_auth_type {
+	SAP_WIFI_AUTH_TYPE_OPEN		= 0,
+	SAP_WIFI_AUTH_TYPE_RSNA		= 6,
+	SAP_WIFI_AUTH_TYPE_RSNA_PSK	= 7,
+	SAP_WIFI_AUTH_TYPE_SAE		= 9,
+	SAP_WIFI_AUTH_TYPE_MAX,
+};
+
+/**
+ * enum iwl_sap_wifi_cipher_alg
+ * @SAP_WIFI_CIPHER_ALG_NONE: TBD
+ * @SAP_WIFI_CIPHER_ALG_CCMP: TBD
+ * @SAP_WIFI_CIPHER_ALG_GCMP: TBD
+ * @SAP_WIFI_CIPHER_ALG_GCMP_256: TBD
+ */
+enum iwl_sap_wifi_cipher_alg {
+	SAP_WIFI_CIPHER_ALG_NONE	= 0,
+	SAP_WIFI_CIPHER_ALG_CCMP	= 4,
+	SAP_WIFI_CIPHER_ALG_GCMP	= 8,
+	SAP_WIFI_CIPHER_ALG_GCMP_256	= 9,
+};
+
+/**
+ * struct iwl_sap_notif_connection_info - nested in other structures
+ * @ssid_len: The length of the SSID.
+ * @ssid: The SSID.
+ * @auth_mode: The authentication mode. See &enum iwl_sap_wifi_auth_type.
+ * @pairwise_cipher: The cipher used for unicast packets.
+ *	See &enum iwl_sap_wifi_cipher_alg.
+ * @channel: The channel on which we are associated.
+ * @band: The band on which we are associated.
+ * @reserved: For alignment.
+ * @bssid: The BSSID.
+ * @reserved1: For alignment.
+ */
+struct iwl_sap_notif_connection_info {
+	__le32 ssid_len;
+	u8 ssid[32];
+	__le32 auth_mode;
+	__le32 pairwise_cipher;
+	u8 channel;
+	u8 band;
+	__le16 reserved;
+	u8 bssid[6];
+	__le16 reserved1;
+} __packed;
+
+/**
+ * enum iwl_sap_scan_request - for the scan_request field
+ * @SCAN_REQUEST_FILTERING: Filtering is requested.
+ * @SCAN_REQUEST_FAST: Fast scan is requested.
+ */
+enum iwl_sap_scan_request {
+	SCAN_REQUEST_FILTERING	= 1 << 0,
+	SCAN_REQUEST_FAST	= 1 << 1,
+};
+
+/**
+ * struct iwl_sap_notif_conn_status - payload of %SAP_MSG_NOTIF_CSME_CONN_STATUS
+ * @hdr: The SAP header
+ * @link_prot_state: Non-zero if link protection is active.
+ * @scan_request: See &enum iwl_sap_scan_request.
+ * @conn_info: Information about the connection.
+ */
+struct iwl_sap_notif_conn_status {
+	struct iwl_sap_hdr hdr;
+	__le32 link_prot_state;
+	__le32 scan_request;
+	struct iwl_sap_notif_connection_info conn_info;
+} __packed;
+
+/**
+ * enum iwl_sap_radio_state_bitmap - used for %SAP_MSG_NOTIF_RADIO_STATE
+ * @SAP_SW_RFKILL_DEASSERTED: If set, SW RfKill is de-asserted
+ * @SAP_HW_RFKILL_DEASSERTED: If set, HW RfKill is de-asserted
+ *
+ * If both bits are set, then the radio is on.
+ */
+enum iwl_sap_radio_state_bitmap {
+	SAP_SW_RFKILL_DEASSERTED	= 1 << 0,
+	SAP_HW_RFKILL_DEASSERTED	= 1 << 1,
+};
+
+/**
+ * enum iwl_sap_notif_host_suspends_bitmap - used for %SAP_MSG_NOTIF_HOST_SUSPENDS
+ * @SAP_OFFER_NIC: TBD
+ * @SAP_FILTER_CONFIGURED: TBD
+ * @SAP_NLO_CONFIGURED: TBD
+ * @SAP_HOST_OWNS_NIC: TBD
+ * @SAP_LINK_PROTECTED: TBD
+ */
+enum iwl_sap_notif_host_suspends_bitmap {
+	SAP_OFFER_NIC		= 1 << 0,
+	SAP_FILTER_CONFIGURED	= 1 << 1,
+	SAP_NLO_CONFIGURED	= 1 << 2,
+	SAP_HOST_OWNS_NIC	= 1 << 3,
+	SAP_LINK_PROTECTED	= 1 << 4,
+};
+
+/**
+ * struct iwl_sap_notif_country_code - payload of %SAP_MSG_NOTIF_COUNTRY_CODE
+ * @hdr: The SAP header
+ * @mcc: The country code.
+ * @source_id: TBD
+ * @reserved: For alignment.
+ * @diff_time: TBD
+ */
+struct iwl_sap_notif_country_code {
+	struct iwl_sap_hdr hdr;
+	__le16 mcc;
+	u8 source_id;
+	u8 reserved;
+	__le32 diff_time;
+} __packed;
+
+/**
+ * struct iwl_sap_notif_host_link_up - payload of %SAP_MSG_NOTIF_HOST_LINK_UP
+ * @hdr: The SAP header
+ * @conn_info: Information about the connection.
+ * @colloc_channel: The collocated channel
+ * @colloc_band: The band of the collocated channel.
+ * @reserved: For alignment.
+ * @colloc_bssid: The collocated BSSID.
+ * @reserved1: For alignment.
+ */
+struct iwl_sap_notif_host_link_up {
+	struct iwl_sap_hdr hdr;
+	struct iwl_sap_notif_connection_info conn_info;
+	u8 colloc_channel;
+	u8 colloc_band;
+	__le16 reserved;
+	u8 colloc_bssid[6];
+	__le16 reserved1;
+} __packed;
+
+/**
+ * enum iwl_sap_notif_link_down_type - used in &struct iwl_sap_notif_host_link_down
+ * @HOST_LINK_DOWN_TYPE_NONE: TBD
+ * @HOST_LINK_DOWN_TYPE_TEMPORARY: TBD
+ * @HOST_LINK_DOWN_TYPE_LONG: TBD
+ */
+enum iwl_sap_notif_link_down_type {
+	HOST_LINK_DOWN_TYPE_NONE,
+	HOST_LINK_DOWN_TYPE_TEMPORARY,
+	HOST_LINK_DOWN_TYPE_LONG,
+};
+
+/**
+ * struct iwl_sap_notif_host_link_down - payload for %SAP_MSG_NOTIF_HOST_LINK_DOWN
+ * @hdr: The SAP header
+ * @type: See &enum iwl_sap_notif_link_down_type.
+ * @reserved: For alignment.
+ * @reason_valid: If 0, ignore the next field.
+ * @reason: The reason of the disconnection.
+ */
+struct iwl_sap_notif_host_link_down {
+	struct iwl_sap_hdr hdr;
+	u8 type;
+	u8 reserved[2];
+	u8 reason_valid;
+	__le32 reason;
+} __packed;
+
+/**
+ * struct iwl_sap_notif_host_nic_info - payload for %SAP_MSG_NOTIF_NIC_INFO
+ * @hdr: The SAP header
+ * @mac_address: The MAC address as configured to the interface.
+ * @nvm_address: The MAC address as configured in the NVM.
+ */
+struct iwl_sap_notif_host_nic_info {
+	struct iwl_sap_hdr hdr;
+	u8 mac_address[6];
+	u8 nvm_address[6];
+} __packed;
+
+/**
+ * struct iwl_sap_notif_dw - payload is a dw
+ * @hdr: The SAP header.
+ * @dw: The payload.
+ */
+struct iwl_sap_notif_dw {
+	struct iwl_sap_hdr hdr;
+	__le32 dw;
+} __packed;
+
+/**
+ * struct iwl_sap_notif_sar_limits - payload for %SAP_MSG_NOTIF_SAR_LIMITS
+ * @hdr: The SAP header
+ * @sar_chain_info_table: Tx power limits.
+ */
+struct iwl_sap_notif_sar_limits {
+	struct iwl_sap_hdr hdr;
+	__le16 sar_chain_info_table[2][5];
+} __packed;
+
+/**
+ * enum iwl_sap_nvm_caps - capabilities for NVM SAP
+ * @SAP_NVM_CAPS_LARI_SUPPORT: Lari is supported
+ * @SAP_NVM_CAPS_11AX_SUPPORT: 11AX is supported
+ */
+enum iwl_sap_nvm_caps {
+	SAP_NVM_CAPS_LARI_SUPPORT	= BIT(0),
+	SAP_NVM_CAPS_11AX_SUPPORT	= BIT(1),
+};
+
+/**
+ * struct iwl_sap_nvm - payload for %SAP_MSG_NOTIF_NVM
+ * @hdr: The SAP header.
+ * @hw_addr: The MAC address
+ * @n_hw_addrs: The number of MAC addresses
+ * @reserved: For alignment.
+ * @radio_cfg: The radio configuration.
+ * @caps: See &enum iwl_sap_nvm_caps.
+ * @nvm_version: The version of the NVM.
+ * @channels: The data for each channel.
+ */
+struct iwl_sap_nvm {
+	struct iwl_sap_hdr hdr;
+	u8 hw_addr[6];
+	u8 n_hw_addrs;
+	u8 reserved;
+	__le32 radio_cfg;
+	__le32 caps;
+	__le32 nvm_version;
+	__le32 channels[110];
+} __packed;
+
+/**
+ * enum iwl_sap_eth_filter_flags - used in &struct iwl_sap_eth_filter
+ * @SAP_ETH_FILTER_STOP: Do not process further filters.
+ * @SAP_ETH_FILTER_COPY: Copy the packet to the CSME.
+ * @SAP_ETH_FILTER_ENABLED: If false, the filter should be ignored.
+ */
+enum iwl_sap_eth_filter_flags {
+	SAP_ETH_FILTER_STOP    = BIT(0),
+	SAP_ETH_FILTER_COPY    = BIT(1),
+	SAP_ETH_FILTER_ENABLED = BIT(2),
+};
+
+/**
+ * struct iwl_sap_eth_filter - a L2 filter
+ * @mac_address: Address to filter.
+ * @flags: See &enum iwl_sap_eth_filter_flags.
+ */
+struct iwl_sap_eth_filter {
+	u8 mac_address[6];
+	u8 flags;
+} __packed;
+
+/**
+ * enum iwl_sap_flex_filter_flags - used in &struct iwl_sap_flex_filter
+ * @SAP_FLEX_FILTER_COPY: Pass UDP / TCP packets to CSME.
+ * @SAP_FLEX_FILTER_ENABLED: If false, the filter should be ignored.
+ * @SAP_FLEX_FILTER_IPV4: Filter requires match on the IP address as well.
+ * @SAP_FLEX_FILTER_IPV6: Filter requires match on the IP address as well.
+ * @SAP_FLEX_FILTER_TCP: Filter should be applied on TCP packets.
+ * @SAP_FLEX_FILTER_UDP: Filter should be applied on UDP packets.
+ */
+enum iwl_sap_flex_filter_flags {
+	SAP_FLEX_FILTER_COPY		= BIT(0),
+	SAP_FLEX_FILTER_ENABLED		= BIT(1),
+	SAP_FLEX_FILTER_IPV6		= BIT(2),
+	SAP_FLEX_FILTER_IPV4		= BIT(3),
+	SAP_FLEX_FILTER_TCP		= BIT(4),
+	SAP_FLEX_FILTER_UDP		= BIT(5),
+};
+
+/**
+ * struct iwl_sap_flex_filter -
+ * @src_port: Source port in network format.
+ * @dst_port: Destination port in network format.
+ * @flags: Flags and protocol, see &enum iwl_sap_flex_filter_flags.
+ * @reserved: For alignment.
+ */
+struct iwl_sap_flex_filter {
+	__be16 src_port;
+	__be16 dst_port;
+	u8 flags;
+	u8 reserved;
+} __packed;
+
+/**
+ * enum iwl_sap_ipv4_filter_flags - used in &struct iwl_sap_ipv4_filter
+ * @SAP_IPV4_FILTER_ICMP_PASS: Pass ICMP packets to CSME.
+ * @SAP_IPV4_FILTER_ICMP_COPY: Pass ICMP packets to host.
+ * @SAP_IPV4_FILTER_ARP_REQ_PASS: Pass ARP requests to CSME.
+ * @SAP_IPV4_FILTER_ARP_REQ_COPY: Pass ARP requests to host.
+ * @SAP_IPV4_FILTER_ARP_RESP_PASS: Pass ARP responses to CSME.
+ * @SAP_IPV4_FILTER_ARP_RESP_COPY: Pass ARP responses to host.
+ */
+enum iwl_sap_ipv4_filter_flags {
+	SAP_IPV4_FILTER_ICMP_PASS	= BIT(0),
+	SAP_IPV4_FILTER_ICMP_COPY	= BIT(1),
+	SAP_IPV4_FILTER_ARP_REQ_PASS	= BIT(2),
+	SAP_IPV4_FILTER_ARP_REQ_COPY	= BIT(3),
+	SAP_IPV4_FILTER_ARP_RESP_PASS	= BIT(4),
+	SAP_IPV4_FILTER_ARP_RESP_COPY	= BIT(5),
+};
+
+/**
+ * struct iwl_sap_ipv4_filter-
+ * @ipv4_addr: The IP address to filer.
+ * @flags: See &enum iwl_sap_ipv4_filter_flags.
+ */
+struct iwl_sap_ipv4_filter {
+	__be32 ipv4_addr;
+	__le32 flags;
+} __packed;
+
+/**
+ * enum iwl_sap_ipv6_filter_flags -
+ * @SAP_IPV6_ADDR_FILTER_COPY: Pass packets to the host.
+ * @SAP_IPV6_ADDR_FILTER_ENABLED: If false, the filter should be ignored.
+ */
+enum iwl_sap_ipv6_filter_flags {
+	SAP_IPV6_ADDR_FILTER_COPY	= BIT(0),
+	SAP_IPV6_ADDR_FILTER_ENABLED	= BIT(1),
+};
+
+/**
+ * struct iwl_sap_ipv6_filter -
+ * @addr_lo24: Lowest 24 bits of the IPv6 address.
+ * @flags: See &enum iwl_sap_ipv6_filter_flags.
+ */
+struct iwl_sap_ipv6_filter {
+	u8 addr_lo24[3];
+	u8 flags;
+} __packed;
+
+/**
+ * enum iwl_sap_icmpv6_filter_flags -
+ * @SAP_ICMPV6_FILTER_ENABLED: If false, the filter should be ignored.
+ * @SAP_ICMPV6_FILTER_COPY: Pass packets to the host.
+ */
+enum iwl_sap_icmpv6_filter_flags {
+	SAP_ICMPV6_FILTER_ENABLED	= BIT(0),
+	SAP_ICMPV6_FILTER_COPY		= BIT(1),
+};
+
+/**
+ * enum iwl_sap_vlan_filter_flags -
+ * @SAP_VLAN_FILTER_VLAN_ID_MSK: TBD
+ * @SAP_VLAN_FILTER_ENABLED: If false, the filter should be ignored.
+ */
+enum iwl_sap_vlan_filter_flags {
+	SAP_VLAN_FILTER_VLAN_ID_MSK	= 0x0FFF,
+	SAP_VLAN_FILTER_ENABLED		= BIT(15),
+};
+
+/**
+ * struct iwl_sap_oob_filters - Out of band filters (for RX only)
+ * @flex_filters: Array of &struct iwl_sap_flex_filter.
+ * @icmpv6_flags: See &enum iwl_sap_icmpv6_filter_flags.
+ * @ipv6_filters: Array of &struct iwl_sap_ipv6_filter.
+ * @eth_filters: Array of &struct iwl_sap_eth_filter.
+ * @reserved: For alignment.
+ * @ipv4_filter: &struct iwl_sap_ipv4_filter.
+ * @vlan: See &enum iwl_sap_vlan_filter_flags.
+ */
+struct iwl_sap_oob_filters {
+	struct iwl_sap_flex_filter flex_filters[14];
+	__le32 icmpv6_flags;
+	struct iwl_sap_ipv6_filter ipv6_filters[4];
+	struct iwl_sap_eth_filter eth_filters[5];
+	u8 reserved;
+	struct iwl_sap_ipv4_filter ipv4_filter;
+	__le16 vlan[4];
+} __packed;
+
+/**
+ * struct iwl_sap_csme_filters - payload of %SAP_MSG_NOTIF_CSME_FILTERS
+ * @hdr: The SAP header.
+ * @mode: Not used.
+ * @mac_address: Not used.
+ * @reserved: For alignment.
+ * @cbfilters: Not used.
+ * @filters: Out of band filters.
+ */
+struct iwl_sap_csme_filters {
+	struct iwl_sap_hdr hdr;
+	__le32 mode;
+	u8 mac_address[6];
+	__le16 reserved;
+	u8 cbfilters[1728];
+	struct iwl_sap_oob_filters filters;
+} __packed;
+
+#define CB_TX_DHCP_FILT_IDX 30
+/**
+ * struct iwl_sap_cb_data - header to be added for transmitted packets.
+ * @hdr: The SAP header.
+ * @reserved: Not used.
+ * @to_me_filt_status: The filter that matches. Bit %CB_TX_DHCP_FILT_IDX should
+ *	be set for DHCP (the only packet that uses this header).
+ * @reserved2: Not used.
+ * @data_len: The length of the payload.
+ * @payload: The payload of the transmitted packet.
+ */
+struct iwl_sap_cb_data {
+	struct iwl_sap_hdr hdr;
+	__le32 reserved[7];
+	__le32 to_me_filt_status;
+	__le32 reserved2;
+	__le32 data_len;
+	u8 payload[];
+};
+
+#endif /* __sap_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h b/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
new file mode 100644
index 000000000000..9ee1c6072cd9
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2021        Intel Corporation
+ */
+
+#if !defined(__IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_DATA) || defined(TRACE_HEADER_MULTI_READ)
+
+#ifndef __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_DATA
+enum iwl_sap_data_trace_type {
+	IWL_SAP_RX_DATA_TO_AIR,
+	IWL_SAP_TX_DATA_FROM_AIR,
+	IWL_SAP_RX_DATA_DROPPED_FROM_AIR,
+	IWL_SAP_TX_DHCP,
+};
+
+static inline size_t
+iwlmei_sap_data_offset(enum iwl_sap_data_trace_type trace_type)
+{
+	switch (trace_type) {
+	case IWL_SAP_RX_DATA_TO_AIR:
+		return 0;
+	case IWL_SAP_TX_DATA_FROM_AIR:
+	case IWL_SAP_RX_DATA_DROPPED_FROM_AIR:
+		return sizeof(struct iwl_sap_hdr);
+	case IWL_SAP_TX_DHCP:
+		return sizeof(struct iwl_sap_cb_data);
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	return 0;
+}
+#endif
+
+#define __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_DATA
+
+#include <linux/tracepoint.h>
+#include <linux/skbuff.h>
+#include "sap.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM iwlmei_sap_data
+
+TRACE_EVENT(iwlmei_sap_data,
+	TP_PROTO(const struct sk_buff *skb,
+		 enum iwl_sap_data_trace_type trace_type),
+	TP_ARGS(skb, trace_type),
+	TP_STRUCT__entry(
+		__dynamic_array(u8, data,
+				skb->len - iwlmei_sap_data_offset(trace_type))
+		__field(u32, trace_type)
+	),
+	TP_fast_assign(
+		size_t offset = iwlmei_sap_data_offset(trace_type);
+		__entry->trace_type = trace_type;
+		skb_copy_bits(skb, offset, __get_dynamic_array(data),
+			      skb->len - offset);
+	),
+	TP_printk("sap_data:trace_type %d len %d",
+		  __entry->trace_type, __get_dynamic_array_len(data))
+);
+
+#endif /* __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_DATA */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-data
+#include <trace/define_trace.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace.c b/drivers/net/wireless/intel/iwlwifi/mei/trace.c
new file mode 100644
index 000000000000..47ac32ef9f69
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#include <linux/module.h>
+
+/* sparse doesn't like tracepoint macros */
+#ifndef __CHECKER__
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+#include "trace-data.h"
+
+#endif /* __CHECKER__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace.h b/drivers/net/wireless/intel/iwlwifi/mei/trace.h
new file mode 100644
index 000000000000..141dc0e64dd0
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2021        Intel Corporation
+ */
+
+#if !defined(__IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_CMD) || defined(TRACE_HEADER_MULTI_READ)
+#define __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_CMD
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM iwlmei_sap_cmd
+
+#include "mei/sap.h"
+
+TRACE_EVENT(iwlmei_sap_cmd,
+	TP_PROTO(const struct iwl_sap_hdr *sap_cmd, bool tx),
+	TP_ARGS(sap_cmd, tx),
+	TP_STRUCT__entry(
+		__dynamic_array(u8, cmd,
+				le16_to_cpu(sap_cmd->len) + sizeof(*sap_cmd))
+		__field(u8, tx)
+		__field(u16, type)
+		__field(u16, len)
+		__field(u32, seq)
+	),
+	TP_fast_assign(
+		memcpy(__get_dynamic_array(cmd), sap_cmd,
+		       le16_to_cpu(sap_cmd->len) + sizeof(*sap_cmd));
+		__entry->tx = tx;
+		__entry->type = le16_to_cpu(sap_cmd->type);
+		__entry->len = le16_to_cpu(sap_cmd->len);
+		__entry->seq = le32_to_cpu(sap_cmd->seq_num);
+	),
+	TP_printk("sap_cmd %s: type %d len %d seq %d", __entry->tx ? "Tx" : "Rx",
+		  __entry->type, __entry->len, __entry->seq)
+);
+
+TRACE_EVENT(iwlmei_me_msg,
+	TP_PROTO(const struct iwl_sap_me_msg_hdr *hdr, bool tx),
+	TP_ARGS(hdr, tx),
+	TP_STRUCT__entry(
+		__field(u8, type)
+		__field(u8, tx)
+		__field(u32, seq_num)
+	),
+	TP_fast_assign(
+		__entry->type = le32_to_cpu(hdr->type);
+		__entry->seq_num = le32_to_cpu(hdr->seq_num);
+		__entry->tx = tx;
+	),
+	TP_printk("ME message: %s: type %d seq %d", __entry->tx ? "Tx" : "Rx",
+		  __entry->type, __entry->seq_num)
+);
+
+#endif /* __IWLWIFI_DEVICE_TRACE_IWLWIFI_SAP_CMD */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.25.1

