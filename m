Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0783169DC
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhBJPQF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45226 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230245AbhBJPQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD1-0049kS-Fu; Wed, 10 Feb 2021 17:15:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:02 +0200
Message-Id: <20210210151514.416221-1-luca@coelho.fi>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.12 2021-02-10
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the seventh set of patches intended for v5.12.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support new scan config FW API;
* Some more CSA fixes;
* Support for RF interference mitigation (RFI);
* Improvements in the NVM flows;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Abhishek Naik (1):
  iwlwifi: mvm: Check ret code for iwl_mvm_load_nvm_to_nic

Emmanuel Grumbach (4):
  iwlwifi: mvm: register to mac80211 last
  iwlwifi: mvm: simplify iwl_mvm_dbgfs_register
  iwlwifi: mvm: isolate the get nvm flow
  iwlwifi: mvm: get NVM later in the mvm_start flow

Gregory Greenman (2):
  iwlwifi: mvm: add RFI-M support
  iwlwifi: acpi: add support for DSM RFI

Ilan Peer (1):
  iwlwifi: mvm: Support SCAN_CFG_CMD version 5

Johannes Berg (2):
  iwlwifi: remove max_vht_ampdu_exponent config parameter
  iwlwifi: remove max_ht_ampdu_exponent config parameter

Sara Sharon (1):
  iwlwifi: mvm: don't check if CSA event is running before removing

Shaul Triebitz (1):
  iwlmvm: set properly NIC_NOT_ACK_ENABLED flag

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |  14 +--
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   1 -
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  20 ++-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |   1 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  28 +++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  20 ++-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  10 ++
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   5 +
 .../net/wireless/intel/iwlwifi/fw/api/rfi.h   |  60 +++++++++
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   6 -
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |   2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   1 +
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  90 +++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/fw-api.h   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  58 +++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  16 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  15 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  67 +++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c  | 118 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  14 ++-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   3 -
 30 files changed, 471 insertions(+), 120 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c

-- 
2.30.0

