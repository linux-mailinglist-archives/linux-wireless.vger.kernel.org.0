Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0EB6AA43A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbfIENW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:22:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41048 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388305AbfIENW2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:22:28 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5riU-00062D-HT; Thu, 05 Sep 2019 16:22:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:21:59 +0300
Message-Id: <20190905132220.23970-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 00/21] iwlwifi: updates intended for v5.4 2019-09-03-2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.4.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support for single antenna diversity;
* Support for new WoWLAN FW API;
* Initial refactoring of the device selection code;
* Debug infrastructure work continues;
* A few clean-ups;
* Other small fixes and improvements;

In v2:
   * removed undefined symbol from patch 3.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: mvm: don't log un-decrypted frames

Haim Dreyfuss (3):
  iwlwifi: add support for suspend-resume flow for new device generation
  iwlwifi: add sta_id to WOWLAN_CONFIG_CMD
  iwlwifi: mvm: add support for single antenna diversity

Hariprasad Kelam (1):
  iwlwifi: fix warning iwl-trans.h is included more than once

Johannes Berg (2):
  iwlwifi: mvm: drop BA sessions on too many old-SN frames
  iwlwifi: mvm: handle BAR_FRAME_RELEASE (0xc2) notification

Luca Coelho (7):
  iwlwifi: separate elements from cfg that are needed by trans_alloc
  iwlwifi: pcie: use the cfg we passed to iwl_trans_pcie_alloc()
  iwlwifi: pcie: move some cfg mangling from trans_pcie_alloc to probe
  iwlwifi: pcie: set iwl_trans->cfg later in the probe function
  iwlwifi: pass the iwl_config_trans_params when needed
  iwlwifi: add a pointer to the trans_cfg directly in trans
  iwlwifi: always access the trans configuration via trans

Shahar S Matityahu (6):
  iwlwifi: add iwl_tlv_array_len()
  iwlwifi: dbg_ini: remove apply point, switch to time point API
  iwlwifi: fw api: add DRAM buffer allocation command
  iwlwifi: dbg_ini: fix dump structs doc
  iwlwifi: dbg_ini: remove periodic trigger
  iwlwifi: dbg: remove iwl_fw_cancel_dumps function

Shaul Triebitz (1):
  iwlwifi: pass the iwl_trans instead of cfg to some functions

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |  14 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |  26 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  35 +-
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  44 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  10 +-
 .../net/wireless/intel/iwlwifi/dvm/devices.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c  |   5 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  12 +-
 .../net/wireless/intel/iwlwifi/dvm/power.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |   5 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   7 +
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |   6 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  89 +++-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  71 ++-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  32 ++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  59 +--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  17 +-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  16 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  20 +
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   2 -
 .../net/wireless/intel/iwlwifi/fw/paging.c    |   6 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  51 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 489 +-----------------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  14 +-
 .../net/wireless/intel/iwlwifi/iwl-devtrace.h |   1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  10 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |  21 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h |   4 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |   6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  21 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |  18 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  40 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   5 +
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   2 -
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  20 +-
 .../wireless/intel/iwlwifi/mvm/constants.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  28 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 115 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  11 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 142 +++--
 .../wireless/intel/iwlwifi/pcie/internal.h    |  25 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  77 +--
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  10 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 305 +++++------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  84 +--
 66 files changed, 994 insertions(+), 1170 deletions(-)

-- 
2.23.0.rc1

