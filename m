Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C192D018D
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 09:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgLFIWt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 03:22:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34626 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbgLFIWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 03:22:48 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klpIv-003A2r-51; Sun, 06 Dec 2020 10:22:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 10:21:47 +0200
Message-Id: <20201206082159.440198-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.11 2020-12-06
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.11.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Improve validation of firmware notifications;
* Debugging improvements and fixes;
* Replace terminology with inclusive words determined by the guidelines;
* Some other clean-ups and small fixes.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (4):
  iwlwifi: mvm: remove the read_nvm from iwl_run_unified_mvm_ucode
  iwlwifi: follow the new inclusive terminology
  iwlwifi: sort out the NVM offsets
  iwlwifi: remove sw_csum_tx

Johannes Berg (4):
  iwlwifi: validate MPDU length against notification length
  iwlwifi: pcie: validate RX descriptor length
  iwlwifi: mvm: clear up iwl_mvm_notify_rx_queue() argument type
  iwlwifi: mvm: move iwl_mvm_stop_device() out of line

Mordechay Goodstein (4):
  iwlwifi: enable sending/setting debug host event
  iwlwifi: avoid endless HW errors at assert time
  iwlwifi: fix typo in comment
  iwlwifi: mvm: iterate active stations when updating statistics

 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   | 10 ++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 20 ++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 10 +--
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 14 ++++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  8 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 12 +--
 .../net/wireless/intel/iwlwifi/fw/api/stats.h |  2 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   | 29 +++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 -
 .../wireless/intel/iwlwifi/mvm/constants.h    |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 16 ++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 10 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 22 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 14 +---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 23 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 44 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 19 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 24 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  7 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  3 -
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  8 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 83 +------------------
 27 files changed, 184 insertions(+), 208 deletions(-)

-- 
2.29.2

