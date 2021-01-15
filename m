Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1CA2F772D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhAOLGt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:06:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40266 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725950AbhAOLGt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:06:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0MvZ-003hBK-2y; Fri, 15 Jan 2021 13:06:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:46 +0200
Message-Id: <20210115110558.1248847-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 00/12] iwlwifi: fixes intended for v5.10 2020-12-02
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the first patchset with fixes for v5.11.

The changes are:

* Some memory leak fixes;
* Potential NULL pointer dereference fixes;
* Fixes for a few locking issues;
* Fix NMI trigger for FW assert recovery in old devices;
* A couple of fixes for CSA.

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the rc series, please take them directly to
wireless-drivers.git, as we agreed.

Cheers,
Luca.


Emmanuel Grumbach (3):
  iwlwifi: fix the NMI flow for old devices
  iwlwifi: queue: don't crash if txq->entries is NULL
  iwlwifi: pcie: add a NULL check in iwl_pcie_txq_unmap

Johannes Berg (8):
  iwlwifi: mvm: take mutex for calling iwl_mvm_get_sync_time()
  iwlwifi: pcie: avoid potential PNVM leaks
  iwlwifi: pnvm: don't skip everything when not reloading
  iwlwifi: pnvm: don't try to load after failures
  iwlwifi: pcie: set LTR on more devices
  iwlwifi: pcie: fix context info memory leak
  iwlwifi: pcie: use jiffies for memory read spin time limit
  iwlwifi: pcie: reschedule in long-running memory reads

Sara Sharon (1):
  iwlwifi: mvm: skip power command when unbinding vif during CSA

 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 56 ++++++++++---------
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  9 +--
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   | 10 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  6 ++
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  3 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 53 +++++++++++-------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 14 +++--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  5 ++
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 49 ++++++++--------
 10 files changed, 127 insertions(+), 81 deletions(-)

-- 
2.29.2

