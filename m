Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A062B49FAC7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348871AbiA1Neh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:37 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37840 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348882AbiA1Neg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:36 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROc-0002DK-09;
        Fri, 28 Jan 2022 15:34:35 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:20 +0200
Message-Id: <20220128133433.591765-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/13]  iwlwifi: updates intended for v5.18 2022-01-28
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.18.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support UHB TAS enablement via BIOS;
* Remove a bunch of W=1 warnings;
* Add support for channel switch offload;
* Support a new FW API command version;
* Support 32 Rx AMPDU sessions in newer devices;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ayala Barazani (1):
  iwlwifi: mvm: allow enabling UHB TAS in the USA via ACPI setting

Bjoern A. Zeeb (2):
  iwlwifi: de-const properly where needed
  iwlwifi: propagate (const) type qualifier

Emmanuel Grumbach (1):
  iwlwifi: mvm: starting from 22000 we have 32 Rx AMPDU sessions

Johannes Berg (7):
  iwlwifi: prefer WIDE_ID() over iwl_cmd_id()
  iwlwifi: mvm: fw: clean up hcmd struct creation
  iwlwifi: make iwl_fw_lookup_cmd_ver() take a cmd_id
  iwlwifi: fix various more -Wcast-qual warnings
  iwlwifi: avoid void pointer arithmetic
  iwlwifi: mvm: refactor iwl_mvm_sta_rx_agg()
  iwlwifi: mvm: support new BAID allocation command

Mordechay Goodstein (1):
  iwlwifi: cfg: add support for 1K BA queue

Nathan Errera (1):
  iwlwifi: mvm: offload channel switch timing to FW

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   5 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  18 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   6 +-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  77 +++++++
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  34 +++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  24 ++
 .../net/wireless/intel/iwlwifi/fw/api/txq.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.c   |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   5 +-
 .../net/wireless/intel/iwlwifi/fw/paging.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  22 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  12 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   6 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 114 ++++-----
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |  11 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  24 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  25 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  15 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  25 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |  24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  93 ++++----
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  50 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  49 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   6 +-
 .../wireless/intel/iwlwifi/mvm/offloading.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/quota.c    |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  33 +--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 217 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   3 +
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  13 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   6 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   6 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |   2 +-
 53 files changed, 684 insertions(+), 394 deletions(-)

-- 
2.34.1

