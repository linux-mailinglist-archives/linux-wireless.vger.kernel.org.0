Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898AD1B857C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgDYKFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58206 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgDYKFL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgJ-000P3t-Rr; Sat, 25 Apr 2020 13:05:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:48 +0300
Message-Id: <20200425100459.2778317-1-luca@coelho.fi>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/11]  iwlwifi: updates intended for v5.8 2020-04-25
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fifth set of patches intended for v5.8.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some queues rework by Johannes;
* Enable A-AMSDU in low  latency;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Johannes Berg (9):
  iwlwifi: pcie: allocate much smaller byte-count table
  iwlwifi: mvm: attempt to allocate smaller queues
  iwlwifi: dbg: mark a variable __maybe_unused
  iwlwifi: pcie: remove some dead code
  iwlwifi: pcie: gen2: use DMA pool for byte-count tables
  iwlwifi: use longer queues for 256-BA
  iwlwifi: mvm: don't transmit on unallocated queue
  iwlwifi: remove outdated copyright print/module statement
  iwlwifi: pcie: skip fragmented receive buffers

Liad Kaufman (1):
  iwlwifi: dbg_ini: differentiate ax210 hw with same hw type

Mordechay Goodstein (1):
  iwlwifi: tx: enable A-MSDU in low latency mode

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 24 +++++++++++--
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 13 +++++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  7 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |  7 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 35 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 11 +++---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  5 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 32 ++++++++++++++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 19 ++++++++++
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 33 +++++++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 12 +++----
 15 files changed, 152 insertions(+), 55 deletions(-)

-- 
2.26.2

