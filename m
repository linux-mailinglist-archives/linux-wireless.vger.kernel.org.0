Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617FC1AEAB2
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDRIJS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56734 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgDRIJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXJ-000L3r-8I; Sat, 18 Apr 2020 11:09:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:45 +0300
Message-Id: <20200418080857.2232093-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.8 2020-04-18
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.8.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* New hw configs and other related changes;
* Support for NPK buffers in debugging;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: remove fw_monitor module parameter

Gil Adam (2):
  iwlwifi: mvm: add framework for specific phy configuration
  iwlwifi: debug: set NPK buffer in context info

Ihab Zhaika (2):
  iwlwifi: add new cards for AX family
  iwlwifi: update few product names in AX family

Johannes Berg (2):
  iwlwifi: pcie: move iwl_pcie_ctxt_info_alloc_dma() to user
  iwlwifi: mvm: tell firmware about required LTR delay

Luca Coelho (4):
  iwlwifi: remove deprecated and unused iwl_mvm_keyinfo struct
  iwlwifi: pcie: add cfgs for SoCs with device ID 0x4FD0
  iwlwifi: pcie: add new structure for Qu devices with medium latency
  iwlwifi: pcie: add new structs for So devices with long latency

Mordechay Goodstein (1):
  iwlwifi: acpi: read TAS table from ACPI and send it to the FW

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  71 ++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  76 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  17 +++
 .../wireless/intel/iwlwifi/fw/api/config.h    |  39 ++++++-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  15 +++
 .../net/wireless/intel/iwlwifi/fw/api/soc.h   |  12 +-
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  26 -----
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  23 +++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  26 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   4 -
 .../wireless/intel/iwlwifi/iwl-modparams.h    |   2 -
 .../wireless/intel/iwlwifi/mvm/constants.h    |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 107 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  47 ++++----
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  15 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  34 ++++--
 .../wireless/intel/iwlwifi/pcie/internal.h    |  16 ---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  15 +--
 20 files changed, 425 insertions(+), 126 deletions(-)

-- 
2.25.1

