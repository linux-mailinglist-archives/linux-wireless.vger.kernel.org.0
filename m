Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F04345101
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 21:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhCVUmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 16:42:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:48250 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCVUmM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 16:42:12 -0400
IronPort-SDR: akcaIaEEvYRM0Dlc6nvzbJRm6fY+xKJZ6R+Sw4wz//4sGaXxxvu2P/GXI3BShqSBVpxqheTdFk
 XhbCJCXWSMYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="169675982"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="169675982"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:42:11 -0700
IronPort-SDR: k3iMo1FwPLxJnXms+oHPU6ySxYxJfjQMSm5r7g68oyVezjVdpvDcscYqPtg4mnhOdZXDCIc0/g
 0OaljXJg7yVQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="407978305"
Received: from isutskov-mobl.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.251.189.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 13:42:08 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        luca@coelho.fi, Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 0/5] Add support for AMT over WLAN
Date:   Mon, 22 Mar 2021 22:41:50 +0200
Message-Id: <20210322204157.102078-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series adds support for AMT over WLAN.
Information about Intel Active Management Technology is
available on the net, but in a nutshell, it is an application
running on an embedded CPU in the chipset. This application
can provide remote control to the system even when no OS is,
present or not even installed. By control, we mean, KVM,
the possibility to attach a remote driver, power up / down
/ reset the machine and other options.

When the host uses wireless, the embedded CPU can't access
the wireless device and hence, the traffic for AMT must be
routed through the host. The AMT <-> WLAN driver interface
is explained at lengh inside the patches. Basically, there
is a memory region that is mapped to a PCI devices that can
read / write to that memory and sends the data to the embedded
CPU. The driver for this PCI device is mei. We needed to add
code for that driver, those patches are in this series and
need to be routed through wireless-drivers tree as requested
by Greg KH.
There is also a cfg80211 patch that I should have sent earlier
to Johannes. I include this here. Hopefully, it'll not cause
trouble.

Note about how to use this new feature:
In order to fully use this new feature, we need to add a few
vendor commands that are not included in this series. The
upstream process for those commands will take some more time
but it is definitely planned. The motivation to use vendor
commands as opposed to regular nl80211 APIs is that we do not
expect any other vendor to need similar APIs. We had no control
on the AMT APIs and this is why we needed to add vendor commands
for flows that differ just a tiny bit from the regular flow. For
example, AMT needs to know when we are associated, but it
requires to know whether we are associated in WPA or in WPA2.
This is not known to the kernel, so we, unfortunately, had
to add a vendor command for this. This is just an example.

Integration with the connection manager is required to be able
to use this new feature.
In case the device is controlled by AMT and is actively used
by AMT, AMT will not release the device. To properly reflect
this state, we report hardware RF-Kill to the stack, but we
add a reason saying that we do not own the device. The
connection manager can then check what AP AMT is connected to
and signal to AMT that it can ensure the connetion to that
same AP can be kept. AMT will then release the device allowing
the host to connect to that AP. Doing this transition fast
enough will allow not to break the TCP connections that AMT
maintains.

I worked with Ayala Beker on the iwlwifi part of this feature.

Please do not apply those patches, they'll be part of a regular
pull request from Luca.

Johannes, feel free to pick the cfg80211 patch although then, it
will require to merge mac80211-next into wireless-drivers-next so
maybe it's better to route it through Kalle as well?

Alexander Usyskin (1):
  mei: bus: add client dma interface

Emmanuel Grumbach (3):
  cfg80211: allow to specifying a reason for hw_rfkill
  iwlwifi: mei: add the driver to allow cooperation with CSME
  iwlwifi: integrate with iwlmei

Tomas Winkler (1):
  mei: allow map and unmap of client dma buffer only for disconnected
    client

 drivers/misc/mei/bus.c                        |   67 +-
 drivers/misc/mei/client.c                     |   20 +-
 drivers/misc/mei/hw.h                         |    5 +
 drivers/net/wireless/intel/iwlwifi/Kconfig    |   13 +
 drivers/net/wireless/intel/iwlwifi/Makefile   |    2 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   61 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   11 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |    2 +
 .../net/wireless/intel/iwlwifi/mei/Makefile   |    8 +
 .../net/wireless/intel/iwlwifi/mei/internal.h |   20 +
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |  440 ++++
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 2026 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mei/net.c  |  409 ++++
 drivers/net/wireless/intel/iwlwifi/mei/sap.h  |  736 ++++++
 .../wireless/intel/iwlwifi/mei/trace-data.h   |   69 +
 .../net/wireless/intel/iwlwifi/mei/trace.c    |   15 +
 .../net/wireless/intel/iwlwifi/mei/trace.h    |   62 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |    3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   42 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   70 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  208 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |    7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   25 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   16 +-
 include/linux/mei_cl_bus.h                    |    3 +
 include/net/cfg80211.h                        |   11 +-
 net/wireless/core.c                           |    7 +-
 27 files changed, 4322 insertions(+), 36 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/internal.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/main.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/net.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/sap.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mei/trace.h

-- 
2.25.1

