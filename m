Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD713A4E58
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFLLes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:34:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47534 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229942AbhFLLer (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:34:47 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1sa-001V8i-Tl; Sat, 12 Jun 2021 14:32:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:33 +0300
Message-Id: <20210612113245.691117-1-luca@coelho.fi>
X-Mailer: git-send-email 2.32.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.14 2021-06-12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.14.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some robustness improvements in the PCI code;
* Remove some duplicate and unused declarations;
* Improve PNVM load robustness by increasing the timeout a bit;
* Support for a new HW;
* Suport for BIOS control of 11ax enablement in Russia;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Johannes Berg (5):
  iwlwifi: mvm: don't change band on bound PHY contexts
  iwlwifi: pcie: handle pcim_iomap_table() failures better
  iwlwifi: pcie: print interrupt number, not index
  iwlwifi: pcie: remove CSR_HW_RF_ID_TYPE_CHIP_ID
  iwlwifi: remove duplicate iwl_ax201_cfg_qu_hr declaration

Luca Coelho (4):
  iwlwifi: mvm: pass the clock type to iwl_mvm_get_sync_time()
  iwlwifi: mvm: fix indentation in some scan functions
  iwlwifi: remove unused REMOTE_WAKE_CONFIG_CMD definitions
  iwlwifi: increase PNVM load timeout

Matti Gottlieb (1):
  iwlwifi: pcie: Add support for AX231 radio module with Ma devices

Miri Korenblit (1):
  iwlwifi: mvm: support BIOS enable/disable for 11ax in Russia

Mukesh Sisodiya (1):
  iwlwifi: yoyo: support region TLV version 2

 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 12 +++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 50 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  9 ++++
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  5 --
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 51 +------------------
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  9 +++-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  5 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 13 ++++-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  4 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 26 ++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 24 ++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 14 ++---
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 11 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 17 ++++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 14 +++--
 21 files changed, 168 insertions(+), 118 deletions(-)

-- 
2.32.0.rc2

