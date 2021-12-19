Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E80047A05A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhLSL2l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:41 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51400 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235618AbhLSL2k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:40 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuMo-001O73-1f; Sun, 19 Dec 2021 13:28:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:24 +0200
Message-Id: <20211219112836.132859-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.17 2021-12-19 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Here's the seventh set of patches intended for v5.17.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some more fixes in 6 GHz scan;
* Fix early restart crash;
* Small fix in the debugging code;
* Add new Killer device IDs;
* Datapath updates for Bz family continues;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (2):
  iwlwifi: mvm: set protected flag only for NDP ranging
  iwlwifi: mvm: fix AUX ROC removal

Ayala Beker (1):
  iwlwifi: mvm: correctly set schedule scan profiles

Johannes Berg (4):
  iwlwifi: mvm: support Bz TX checksum offload
  iwlwifi: mvm: drop too short packets silently
  iwlwifi: mvm: remove card state notification code
  iwlwifi: fw: fix some scan kernel-doc

Luca Coelho (1):
  iwlwifi: pcie: make sure prph_info is set when treating wakeup IRQ

Miri Korenblit (1):
  iwlwifi: mvm: fix rfi get table vendor command handler

Mordechay Goodstein (1):
  iwlwifi: return op_mode only in case the failure is from MEI

Mukesh Sisodiya (1):
  iwlwifi: yoyo: fix issue with new DBGI_SRAM region read.

Yaara Baruch (1):
  iwlwifi: pcie: add killer devices to the driver

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/alive.h |  9 ---
 .../wireless/intel/iwlwifi/fw/api/commands.h  | 10 +--
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 40 +++++++++--
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 11 +++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 71 ++++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 22 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 12 +---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  4 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  9 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 65 ++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 18 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  7 +-
 18 files changed, 196 insertions(+), 100 deletions(-)

-- 
2.34.1

