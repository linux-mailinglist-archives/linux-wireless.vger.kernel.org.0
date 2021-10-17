Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F32430951
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343702AbhJQN2V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 09:28:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53834 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343689AbhJQN2T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 09:28:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6Av-000YdS-Cm; Sun, 17 Oct 2021 16:26:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:25:52 +0300
Message-Id: <20211017132604.480251-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.16 2021-10-17 part 3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.16.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Continue implementation of new rate and flags format in the FW APIs;
* Some fixes for BZ family initialization;
* Fix session protection in some scenarios;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Johannes Berg (4):
  iwlwifi: remove redundant iwl_finish_nic_init() argument
  iwlwifi: mvm: remove session protection after auth/assoc
  iwlwifi: allow rate-limited error messages
  iwlwifi: mvm: reduce WARN_ON() in TX status path

Luca Coelho (2):
  iwlwifi: mvm: Support new rate_n_flags for REPLY_RX_MPDU_CMD and
    RX_NO_DATA_NOTIF
  iwlwifi: mvm: remove csi from iwl_mvm_pass_packet_to_mac80211()

Miri Korenblit (4):
  iwlwifi: mvm: Add support for new rate_n_flags in tx_cmd.
  iwlwifi: mvm: Support new version of BEACON_TEMPLATE_CMD.
  iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions
  iwlwifi: mvm: Add RTS and CTS flags to iwl_tx_cmd_flags.

Roee Goldfiner (2):
  iwlwifi: BZ Family BUS_MASTER_DISABLE_REQ code duplication
  iwlwifi: BZ Family SW reset support

 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |  11 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  12 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  37 +++--
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-debug.c    |  24 ++-
 .../net/wireless/intel/iwlwifi/iwl-debug.h    |  21 ++-
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  30 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  16 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 140 ++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 107 ++++++++++---
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  27 +++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  30 +---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  33 +++--
 19 files changed, 353 insertions(+), 175 deletions(-)

-- 
2.33.0

