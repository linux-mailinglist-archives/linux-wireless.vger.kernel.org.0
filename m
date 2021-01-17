Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5692F91DB
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbhAQLLg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:11:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40602 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727884AbhAQLLb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:31 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15x9-003sZv-Mr; Sun, 17 Jan 2021 13:10:40 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:27 +0200
Message-Id: <20210117111038.1402870-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/11] iwlwifi: updates intended for v5.12 2021-01-17
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.12.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Check FW notification sizes for robustness;
* Improvements in the NAPI implementation;
* Implement a workaround for CCA-EXT;
* Add new FW API support;
* Some other clean-ups and small fixes.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (2):
  iwlwifi: remove TRANS_PM_OPS
  iwlwifi: mvm: don't check system_pm_mode without mutex held

Johannes Berg (6):
  iwlwifi: mvm: add notification size checks
  iwlwifi: mvm: check more notification sizes
  iwlwifi: mvm: remove debugfs injection limitations
  iwlwifi: mvm: scan: fix scheduled scan restart handling
  iwlwifi: mvm: handle CCA-EXT delay firmware notification
  iwlwifi: pcie: properly implement NAPI

Mordechay Goodstein (3):
  iwlwifi: mvm: add support for new flush queue response
  iwl-trans: iwlwifi: move sync NMI logic to trans
  iwlwifi: dbg: dump paged memory from index 1

 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  18 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  15 ++
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  26 ++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  34 +--
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  36 +++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  27 +--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   9 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  30 +--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  18 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  46 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 195 +++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   9 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   6 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 136 ++++++++---
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  30 +++
 .../wireless/intel/iwlwifi/pcie/internal.h    |  15 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 224 ++++++++++++------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  85 ++-----
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  10 +-
 25 files changed, 691 insertions(+), 321 deletions(-)

-- 
2.29.2

