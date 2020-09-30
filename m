Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238A327EEDA
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgI3QUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:20:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53400 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbgI3QUF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:20:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNepl-002MPc-WB; Wed, 30 Sep 2020 19:20:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:47 +0300
Message-Id: <20200930161959.983283-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.10 2020-09-30 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>


Hi,

Here's the fifth set of patches intended for v5.10.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Another set of new FW API version support;
* A fix in the scanning code;
* More debugging infra improvements;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Andrei Otcheretianski (1):
  iwlwifi: use correct group for alive notification

Avraham Stern (1):
  iwlwifi: mvm: ignore the scan duration parameter

Ayala Beker (1):
  iwlwifi: mvm: clear all scan UIDs

Johannes Berg (3):
  iwlwifi: align RX status flags with firmware
  iwlwifi: mvm: d3: parse wowlan status version 11
  iwlwifi: api: fix u32 -> __le32

Luca Coelho (3):
  iwlwifi: mvm: remove redundant log in iwl_mvm_tvqm_enable_txq()
  iwlwifi: support version 5 of the alive notification
  iwlwifi: bump FW API to 57 for AX devices

Mordechay Goodstein (3):
  iwlwifi: pcie: make iwl_pcie_txq_update_byte_cnt_tbl bus independent
  iwlwifi: dbg: add debug host notification (DHN) time point
  iwlwifi: yoyo: add support for internal buffer allocation in D3

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/alive.h |  25 ++-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   7 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  42 +++-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |   8 +-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  23 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  11 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 133 +++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  64 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   2 -
 .../wireless/intel/iwlwifi/pcie/internal.h    |  18 --
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 196 ++----------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 154 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  42 ++++
 19 files changed, 422 insertions(+), 351 deletions(-)

-- 
2.28.0

