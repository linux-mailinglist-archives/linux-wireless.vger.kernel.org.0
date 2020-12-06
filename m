Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14532D032C
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 12:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgLFLIS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 06:08:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34762 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbgLFLIS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 06:08:18 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klrt3-003AAN-Uo; Sun, 06 Dec 2020 13:07:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 13:07:17 +0200
Message-Id: <20201206110729.488452-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.11 2020-12-06 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.11.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Convert copyright notices to SPDX tags;
* Added more validations for firmware notifications;
* A couple of debugging/recovery fixes;
* Some other clean-ups and small fixes.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Johannes Berg (12):
  iwlwifi: pcie: change 12k A-MSDU config to use 16k buffers
  iwlwifi: mvm: fix 22000 series driver NMI
  iwlwifi: mvm: do more useful queue sync accounting
  iwlwifi: mvm: clean up scan state on failure
  iwlwifi: pcie: remove MSIX_HW_INT_CAUSES_REG_IML handling
  iwlwifi: fw: file: fix documentation for SAR flag
  iwlwifi: pcie: remove unnecessary setting of inta_mask
  iwlwifi: trans: consider firmware dead after errors
  iwlwifi: dbg-tlv: fix old length in is_trig_data_contained()
  iwlwifi: use SPDX tags
  iwlwifi: pcie: clean up some rx code
  iwlwifi: mvm: validate firmware sync response size

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  56 +---------
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  70 ++----------
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  58 +---------
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |  61 +----------
 .../net/wireless/intel/iwlwifi/dvm/calib.c    |  61 +----------
 .../net/wireless/intel/iwlwifi/dvm/calib.h    |  60 +----------
 .../net/wireless/intel/iwlwifi/dvm/commands.h |  61 +----------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  65 +----------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  64 +----------
 .../net/wireless/intel/iwlwifi/fw/api/alive.h |  69 ++----------
 .../wireless/intel/iwlwifi/fw/api/binding.h   |  67 ++----------
 .../wireless/intel/iwlwifi/fw/api/cmdhdr.h    |  67 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |  69 ++----------
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  68 ++----------
 .../wireless/intel/iwlwifi/fw/api/config.h    |  70 ++----------
 .../wireless/intel/iwlwifi/fw/api/context.h   |  68 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  69 ++----------
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  70 ++----------
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  61 +----------
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  67 ++----------
 .../wireless/intel/iwlwifi/fw/api/filter.h    |  68 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/led.h   |  62 +----------
 .../wireless/intel/iwlwifi/fw/api/location.h  |  64 +----------
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  70 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  64 +----------
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  70 ++----------
 .../wireless/intel/iwlwifi/fw/api/offload.h   |  68 ++----------
 .../wireless/intel/iwlwifi/fw/api/paging.h    |  67 ++----------
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |  68 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |  70 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  70 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  66 +-----------
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  68 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  70 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/sf.h    |  68 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/soc.h   |  68 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  69 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/stats.h |  67 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  70 ++----------
 .../intel/iwlwifi/fw/api/time-event.h         |  70 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  64 +----------
 .../net/wireless/intel/iwlwifi/fw/api/txq.h   |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  70 ++----------
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  67 ++----------
 .../net/wireless/intel/iwlwifi/fw/debugfs.h   |  68 ++----------
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  68 ++----------
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  64 +----------
 .../wireless/intel/iwlwifi/fw/notif-wait.c    |  64 +----------
 .../wireless/intel/iwlwifi/fw/notif-wait.h    |  63 +----------
 .../net/wireless/intel/iwlwifi/fw/paging.c    |  69 ++----------
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  62 +----------
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |  67 ++----------
 .../net/wireless/intel/iwlwifi/iwl-agn-hw.h   |  61 +----------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  64 +----------
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  56 ++--------
 .../wireless/intel/iwlwifi/iwl-context-info.h |  58 +---------
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  70 ++----------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  67 +-----------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  64 +----------
 .../net/wireless/intel/iwlwifi/iwl-debug.c    |  62 +----------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  64 +----------
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |  65 +----------
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |  65 +----------
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  |  62 +----------
 .../wireless/intel/iwlwifi/iwl-eeprom-read.h  |  61 +----------
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |  66 +-----------
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  68 ++----------
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |  61 +----------
 .../wireless/intel/iwlwifi/iwl-modparams.h    |  61 +----------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  68 ++----------
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  65 +----------
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  69 ++----------
 .../net/wireless/intel/iwlwifi/iwl-phy-db.c   |  64 +----------
 .../net/wireless/intel/iwlwifi/iwl-phy-db.h   |  62 +----------
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/iwl-scd.h  |  62 +----------
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  67 ++----------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  77 ++-----------
 .../net/wireless/intel/iwlwifi/mvm/binding.c  |  65 +----------
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |  65 +----------
 .../wireless/intel/iwlwifi/mvm/constants.h    |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  68 ++----------
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  67 ++----------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  67 ++----------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.h  |  65 +----------
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  68 +-----------
 .../intel/iwlwifi/mvm/ftm-responder.c         |  64 +----------
 .../net/wireless/intel/iwlwifi/mvm/fw-api.h   |  70 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  67 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/led.c  |  67 +-----------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  68 ++----------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  78 +++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  70 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  69 ++----------
 .../wireless/intel/iwlwifi/mvm/offloading.c   |  67 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  69 ++----------
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  69 ++----------
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  70 ++----------
 .../net/wireless/intel/iwlwifi/mvm/quota.c    |  68 ++----------
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  64 +----------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  68 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  97 ++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 101 +++++-------------
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c   |  66 +-----------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  67 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  70 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  68 ++----------
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  68 ++----------
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  67 +-----------
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  70 ++----------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  69 ++----------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  67 ++----------
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  57 +---------
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  60 ++---------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  68 ++----------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  99 +++--------------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  57 +---------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  69 ++----------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  57 +---------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  69 ++----------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  54 +---------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  61 +----------
 128 files changed, 770 insertions(+), 7798 deletions(-)

-- 
2.29.2

