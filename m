Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5C4C1E8C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 23:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbiBWWfh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 17:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243016AbiBWWfg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:36 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E971B780;
        Wed, 23 Feb 2022 14:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645655707; x=1677191707;
  h=from:to:cc:subject:date:message-id;
  bh=lGi75bVJ/v9HTb8gmUSECkUQgBA0OWv3I20s2g+dW9A=;
  b=AD+IKlvdZqKQpGpyeBVYDxdyTz/3gAnbaanePm18MyEfO4XYWMfS+x9b
   AmlgyjKLVL6VAZTtK3mm45FKJKCQseeAZr0awY+cb2Lj8yCv2U13ySxPf
   1v92+7Bjjm8zVuFO+PwxA2peSNbPcucS4DmvpyJsSqsplpeCrwmw+CrbG
   K2p6zxGPY34i8E/z7OC2XcgGLNcpBXutkB0BERrn4MCPX2R6+eeEuRhKz
   MPYTk0osQfPQ/TDuA8y82bOojNJi73ZiTxV8umx7jYO7ZwkSkX0ijj2Av
   QkUWD+oYXOvYs7Dip8wA3vUYqJaDwEWmMOZvdjhBw8xfHq3J9cxJKz4oh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312812420"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="312812420"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:35:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="628252216"
Received: from rmarti10-desk.jf.intel.com ([134.134.150.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:35:05 -0800
From:   Ricardo Martinez <ricardo.martinez@linux.intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net, johannes@sipsolutions.net,
        ryazanov.s.a@gmail.com, loic.poulain@linaro.org,
        m.chetan.kumar@intel.com, chandrashekar.devegowda@intel.com,
        linuxwwan@intel.com, chiranjeevi.rapolu@linux.intel.com,
        haijun.liu@mediatek.com, amir.hanania@intel.com,
        andriy.shevchenko@linux.intel.com, dinesh.sharma@intel.com,
        eliot.lee@intel.com, ilpo.johannes.jarvinen@intel.com,
        moises.veleta@intel.com, pierre-louis.bossart@intel.com,
        muralidharan.sethuraman@intel.com, Soumya.Prakash.Mishra@intel.com,
        sreehari.kancharla@intel.com, madhusmita.sahu@intel.com,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
Subject: [PATCH net-next v5 00/13] net: wwan: t7xx: PCIe driver for MediaTek M.2 modem
Date:   Wed, 23 Feb 2022 15:33:13 -0700
Message-Id: <20220223223326.28021-1-ricardo.martinez@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

t7xx is the PCIe host device driver for Intel 5G 5000 M.2 solution which
is based on MediaTek's T700 modem to provide WWAN connectivity.
The driver uses the WWAN framework infrastructure to create the following
control ports and network interfaces:
* /dev/wwan0mbim0 - Interface conforming to the MBIM protocol.
  Applications like libmbim [1] or Modem Manager [2] from v1.16 onwards
  with [3][4] can use it to enable data communication towards WWAN.
* /dev/wwan0at0 - Interface that supports AT commands.
* wwan0 - Primary network interface for IP traffic.

The main blocks in t7xx driver are:
* PCIe layer - Implements probe, removal, and power management callbacks.
* Port-proxy - Provides a common interface to interact with different types
  of ports such as WWAN ports.
* Modem control & status monitor - Implements the entry point for modem
  initialization, reset and exit, as well as exception handling.
* CLDMA (Control Layer DMA) - Manages the HW used by the port layer to send
  control messages to the modem using MediaTek's CCCI (Cross-Core
  Communication Interface) protocol.
* DPMAIF (Data Plane Modem AP Interface) - Controls the HW that provides
  uplink and downlink queues for the data path. The data exchange takes
  place using circular buffers to share data buffer addresses and metadata
  to describe the packets.
* MHCCIF (Modem Host Cross-Core Interface) - Provides interrupt channels
  for bidirectional event notification such as handshake, exception, PM and
  port enumeration.

The compilation of the t7xx driver is enabled by the CONFIG_MTK_T7XX config
option which depends on CONFIG_WWAN.
This driver was originally developed by MediaTek. Intel adapted t7xx to
the WWAN framework, optimized and refactored the driver source code in close
collaboration with MediaTek. This will enable getting the t7xx driver on the
Approved Vendor List for interested OEM's and ODM's productization plans
with Intel 5G 5000 M.2 solution.

List of contributors:
Amir Hanania <amir.hanania@intel.com>
Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Dinesh Sharma <dinesh.sharma@intel.com>
Eliot Lee <eliot.lee@intel.com>
Haijun Liu <haijun.liu@mediatek.com>
M Chetan Kumar <m.chetan.kumar@intel.com>
Mika Westerberg <mika.westerberg@linux.intel.com>
Moises Veleta <moises.veleta@intel.com>
Pierre-louis Bossart <pierre-louis.bossart@intel.com>
Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Ricardo Martinez <ricardo.martinez@linux.intel.com>
Madhusmita Sahu <madhusmita.sahu@intel.com>
Muralidharan Sethuraman <muralidharan.sethuraman@intel.com>
Soumya Prakash Mishra <Soumya.Prakash.Mishra@intel.com>
Sreehari Kancharla <sreehari.kancharla@intel.com>
Suresh Nagaraj <suresh.nagaraj@intel.com>

[1] https://www.freedesktop.org/software/libmbim/
[2] https://www.freedesktop.org/software/ModemManager/
[3] https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/merge_requests/582
[4] https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/merge_requests/523

v5:
- Update Intel's copyright years to 2021-2022.
- Remove circular dependency between DPMAIF HW (07) and HIF (08).
- Keep separate patches for CLDMA (02) and Core (03)
  but improve the code split by decoupling CLDMA from
  modem ops and cleaning up t7xx_common.h.
- Rename ID_CLDMA0/ID_CLDMA1 to CLDMA_ID_AP/CLDMA_ID_MD.
- Consistently use CLDMA's ring_lock to protect tr_ring.
- Free resources first and then print messages.
- Implement suggested name changes.
- Do not explicitly include dev_printk.h.
- Remove redundant dev_err()s.
- Fix possible memory leak during probe.
- Remove infrastructure for legacy interrupts.
- Remove unused macros and variables, including those that
  can be replaced with constants.
- Remove PCIE_MAC_MSIX_MSK_SET macro which is duplicated code.
- Refactor __t7xx_pci_pm_suspend() for clarity.
- Refactor t7xx_cldma_rx_ring_init() and t7xx_cldma_tx_ring_init().
- Do not use & for function callbacks.
- Declare a structure to access skb->cb[] data.
- Use skb_put_data instead of memcpy.
- No need to use kfree_sensitive.
- Use dev_kfree_skb() instead of kfree_skb().
- Refactor t7xx_prepare_device_rt_data() to remove potential leaks,
  avoid unneeded memset and keep rt_data and packet_size updates
  inside the same 'if' block.
- Set port's rx_length_th back to 0 during uninit.
- Remove unneeded 'blocking' parameter from t7xx_cldma_send_skb().
- Return -EIO in t7xx_cldma_send_skb() if the queue is inactive.
- Refactor t7xx_cldma_qs_are_active() to use pci_device_is_present().
- Simplify t7xx_cldma_stop_q() and rename it to t7xx_cldma_stop_all_qs().
- Fix potential leaks in t7xx_cldma_init().
- Improve error handling in fsm_append_event and fsm_routine_starting().
- Propagate return codes from fsm_append_cmd() and t7xx_fsm_append_event().
- Refactor fsm_wait_for_event() to avoid unnecessary sleep.
- Create the WWAN ports and net device only after the modem is in
  the ready state.
- Refactor t7xx_port_proxy_recv_skb() and port_recv_skb().
- Rename t7xx_port_check_rx_seq_num() as t7xx_port_next_rx_seq_num()
  and fix the seq_num logic to handle overflows.
- Declare seq_nums as u16 instead of short.
- Use unsigned int for local indexes.
- Use min_t instead of the ternary operator.
- Refactor the loop in t7xx_dpmaif_rx_data_collect() to avoid a dead
  condition check.
- Use a bitmap (bat_bitmap) instead of an array to keep track of
  the DRB status. Used in t7xx_dpmaif_avail_pkt_bat_cnt().
- Refactor t7xx_dpmaif_tx_send_skb() to protect tx_submit_skb_cnt
  with spinlock and remove the misleading tx_drb_available variable.
- Consolidate bit operations before endianness conversion.
- Use C bit fields in dpmaif_drb_skb struct which is not HW related.
- Add back the que_started check in t7xx_select_tx_queue().
- Create a helper function to get the DRB count.
- Simplify the use of 'usage' during t7xx_ccmni_close().
- Enforce CCMNI MTU selection with BUILD_BUG_ON() instead of a comment.
- Remove t7xx_ccmni_ctrl->capability parameter which remains constant.

v4:
- Implement list_prev_entry_circular() and list_next_entry_circular() macros.
- Remove inline from all c files.
- Define ioread32_poll_timeout_atomic() helper macro.
- Fix return code for WWAN port tx op.
- Allow AT commands fragmentation same as MBIM commands.
- Introduce t7xx_common.h file in the first patch.
- Rename functions and variables as suggested in v3.
- Reduce code duplication by creating fsm_wait_for_event() helper function.
- Remove unneeded dev_err in t7xx_fsm_clr_event().
- Remove unused variable last_state from struct t7xx_fsm_ctl.
- Remove unused variable txq_select_times from struct dpmaif_ctrl.
- Replace ETXTBSY with EBUSY.
- Refactor t7xx_dpmaif_rx_buf_alloc() to remove an unneeded allocation.
- Fix potential leak at t7xx_dpmaif_rx_frag_alloc().
- Simplify return value handling at t7xx_dpmaif_rx_start().
- Add a helper to handle the common part of CCCI header initialization.
- Make sure interrupts are enabled during PM resume.
- Add a parameter to t7xx_fsm_append_cmd() to tell if it is in interrupt context.

v3:
- Avoid unneeded ping-pong changes between patches.
- Use t7xx_ prefix in functions.
- Use t7xx_ prefix in generic structs where mtk_ or ccci prefix was used.
- Update Authors/Contributors header.
- Remove skb pools used for control path.
- Remove skb pools used for RX data path.
- Do not use dedicated TX queue for ACK-only packets.
- Remove __packed attribute from GPD structs.
- Remove the infrastructure for test and debug ports.
- Use the skb control buffer to store metadata.
- Get the IP packet type from RX PIT.
- Merge variable declaration and simple assignments.
- Use preferred coding patterns.
- Remove global variables.
- Declare HW facing structure members as little endian.
- Rename goto tags to describe what is going to be done.
- Do not use variable length arrays.
- Remove unneeded blank lines source code and kdoc headers.
- Use C99 initialization format for port-proxy ports.
- Clean up comments.
- Review included headers.
- Better use of 100 column limit.
- Remove unneeded mb() in CLDMA.
- Remove unneeded spin locks and atomics.
- Handle read_poll_timeout error.
- Use dev_err_ratelimited() where required.
- Fix resource leak when requesting IRQs.
- Use generic DEFAULT_TX_QUEUE_LEN instead custom macro.
- Use ETH_DATA_LEN instead of defining WWAN_DEFAULT_MTU.
- Use sizeof() instead of defines when the size of structures is required.
- Remove unneeded code from netdev:
    No need to configure HW address length
    No need to implement .ndo_change_mtu
    Remove random address generation
- Code simplifications by using kernel provided functions and macros such as:
    module_pci_driver
    PTR_ERR_OR_ZERO
    for_each_set_bit
    pci_device_is_present
    skb_queue_purge
    list_prev_entry
    __ffs64

v2:
- Replace pdev->driver->name with dev_driver_string(&pdev->dev).
- Replace random_ether_addr() with eth_random_addr().
- Update kernel-doc comment for enum data_policy.
- Indicate the driver is 'Supported' instead of 'Maintained'.
- Fix the Signed-of-by and Co-developed-by tags in the patches.
- Added authors and contributors in the top comment of the src files.

Ricardo Martinez (13):
  list: Add list_next_entry_circular() and list_prev_entry_circular()
  net: wwan: t7xx: Add control DMA interface
  net: wwan: t7xx: Add core components
  net: wwan: t7xx: Add port proxy infrastructure
  net: wwan: t7xx: Add control port
  net: wwan: t7xx: Add AT and MBIM WWAN ports
  net: wwan: t7xx: Data path HW layer
  net: wwan: t7xx: Add data path interface
  net: wwan: t7xx: Add WWAN network interface
  net: wwan: t7xx: Introduce power management
  net: wwan: t7xx: Runtime PM
  net: wwan: t7xx: Device deep sleep lock/unlock
  net: wwan: t7xx: Add maintainers and documentation

 .../networking/device_drivers/wwan/index.rst  |    1 +
 .../networking/device_drivers/wwan/t7xx.rst   |  120 ++
 MAINTAINERS                                   |   11 +
 drivers/net/wwan/Kconfig                      |   14 +
 drivers/net/wwan/Makefile                     |    1 +
 drivers/net/wwan/t7xx/Makefile                |   20 +
 drivers/net/wwan/t7xx/t7xx_cldma.c            |  281 ++++
 drivers/net/wwan/t7xx/t7xx_cldma.h            |  176 +++
 drivers/net/wwan/t7xx/t7xx_common.h           |   66 +
 drivers/net/wwan/t7xx/t7xx_dpmaif.c           | 1294 ++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_dpmaif.h           |  179 +++
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c        | 1351 +++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h        |  142 ++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c       |  574 +++++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h       |  211 +++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c    | 1248 +++++++++++++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h    |  114 ++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c    |  729 +++++++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.h    |   84 +
 drivers/net/wwan/t7xx/t7xx_mhccif.c           |  122 ++
 drivers/net/wwan/t7xx/t7xx_mhccif.h           |   37 +
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  764 ++++++++++
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |   87 ++
 drivers/net/wwan/t7xx/t7xx_netdev.c           |  430 ++++++
 drivers/net/wwan/t7xx/t7xx_netdev.h           |   56 +
 drivers/net/wwan/t7xx/t7xx_pci.c              |  768 ++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.h              |  122 ++
 drivers/net/wwan/t7xx/t7xx_pcie_mac.c         |  263 ++++
 drivers/net/wwan/t7xx/t7xx_pcie_mac.h         |   31 +
 drivers/net/wwan/t7xx/t7xx_port.h             |  149 ++
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c    |  205 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       |  621 ++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  100 ++
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  210 +++
 drivers/net/wwan/t7xx/t7xx_reg.h              |  352 +++++
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |  550 +++++++
 drivers/net/wwan/t7xx/t7xx_state_monitor.h    |  125 ++
 include/linux/list.h                          |   26 +
 38 files changed, 11634 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/wwan/t7xx.rst
 create mode 100644 drivers/net/wwan/t7xx/Makefile
 create mode 100644 drivers/net/wwan/t7xx/t7xx_cldma.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_cldma.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_common.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_dpmaif.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_dpmaif.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_cldma.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_cldma.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_mhccif.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_mhccif.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_modem_ops.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_modem_ops.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_netdev.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_netdev.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_pci.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_pci.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_pcie_mac.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_pcie_mac.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_proxy.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_proxy.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_wwan.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_reg.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_state_monitor.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_state_monitor.h

-- 
2.17.1

