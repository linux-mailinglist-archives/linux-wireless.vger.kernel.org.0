Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8C35B2D8
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhDKJqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:46:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44414 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229804AbhDKJqu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:46:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfm-000Jkq-Ni; Sun, 11 Apr 2021 12:46:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:18 +0300
Message-Id: <20210411094630.431873-1-luca@coelho.fi>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.13 2021-04-11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.13.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support for a new FW API command version;
* Some locking fixes;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (2):
  iwlwifi: remove TCM events
  iwlwifi: don't warn if we can't wait for empty tx queues

Johannes Berg (3):
  iwlwifi: remove remaining software checksum code
  iwlwifi: mvm: don't lock mutex in RCU critical section
  iwlwifi: warn on SKB free w/o op-mode

Miri Korenblit (1):
  iwlwifi: mvm: add support for version 3 of LARI_CONFIG_CHANGE command.

Mordechay Goodstein (5):
  iwlwifi: queue: avoid memory leak in reset flow
  iwlwifi: mvm: remove PS from lower rates.
  iwlwifi: pcie: merge napi_poll_msix functions
  iwlwifi: pcie: add ISR debug info for msix debug
  iwlwifi: rs-fw: don't support stbc for HE 160

Roee Goldfiner (1):
  iwlwifi: mvm: umac error table mismatch

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 10 +---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 17 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  5 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 10 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 23 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 20 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  6 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 18 +-----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 59 +++++++------------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  5 ++
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 11 +---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 41 +++----------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  3 +-
 18 files changed, 100 insertions(+), 146 deletions(-)

-- 
2.31.0

