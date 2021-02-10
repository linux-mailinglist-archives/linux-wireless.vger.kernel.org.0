Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F113166BB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhBJMcL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:32:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45054 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231876AbhBJMaS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:30:18 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9oca-0049Yg-M7; Wed, 10 Feb 2021 14:29:29 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 14:29:15 +0200
Message-Id: <20210210122927.315774-1-luca@coelho.fi>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 00/12] iwlwifi: updates intended for v5.12 2021-02-07 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

In v2:

* Rebased with a few conflict resolutions;
* Reworded the "CRFs for Ma" commit message;
* Fix a typo in another commit message.


Here's the sixth set of patches intended for v5.12.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* New FW API version support;
* A few fixes in the debugging framework;
* Fix a couple of potential crashes in error paths;
* More HW IDs for new HW;
* Add one more value to the device configuration code;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: pcie: don't crash when rx queues aren't allocated in
    interrupt

Haim Dreyfuss (1):
  iwlwifi: acpi: don't return valid pointer as an ERR_PTR

Johannes Berg (2):
  iwlwifi: api: clean up some documentation/bits
  iwlwifi: remove flags argument for nic_access

Matti Gottlieb (2):
  iwlwifi: pcie: add CDB bit to the device configuration parsing
  iwlwifi: pcie: add AX201 and AX211 radio modules for Ma devices

Miri Korenblit (1):
  iwlwifi:mvm: Add support for version 2 of the LARI_CONFIG_CHANGE
    command.

Mordechay Goodstein (3):
  iwlwifi: dbg: remove unsupported regions
  iwlwifi: dbg: add op_mode callback for collecting debug data.
  iwlwifi: queue: add fake tx time point

Mukesh Sisodiya (1):
  iwlwifi: correction of group-id once sending REPLY_ERROR

Naftali Goldstein (1):
  iwlwifi: declare support for triggered SU/MU beamforming feedback

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  22 +++
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c   |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  22 ++-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   2 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  |   7 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  15 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  51 +++---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   6 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   2 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  36 +++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  46 ++---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   2 +
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  14 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   7 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 162 ++++++++++--------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  13 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   4 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  35 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |   4 +
 26 files changed, 324 insertions(+), 195 deletions(-)

-- 
2.30.0

