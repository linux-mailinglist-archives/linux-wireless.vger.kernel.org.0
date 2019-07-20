Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4EF6EF05
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfGTK0A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:26:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59426 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbfGTK0A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:26:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homYr-0000Hj-HZ; Sat, 20 Jul 2019 13:25:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:29 +0300
Message-Id: <20190720102545.5952-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 00/16] iwlwifi: fixes intended for 5.3 2019-07-20
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This is the second patchset with fixes for v5.3.

The changes are:

* Fix for an NSSN syncronization issue;
* Some fixes in rate-scaling;
* Fix for an "unknown command" bug with some FW versions;
* A couple of debug infrastructure fixes;
* One locking fix with GTK;
* Small fix for an error path (the error was ignored due to a type
  issue);

As usual, I'm pushing this to a pending branch, for kbuild bot.  I can
send you a pull-request for this or I can assign them to you so you
can apply them directly to wireless-drivers.  Let me know what you
prefer.


Cheers,
Luca.


Colin Ian King (1):
  iwlwifi: mvm: fix comparison of u32 variable with less than zero

Emmanuel Grumbach (5):
  iwlwifi: mvm: prepare the ground for more RSS notifications
  iwlwifi: mvm: add a new RSS sync notification for NSSN sync
  iwlwiif: mvm: refactor iwl_mvm_notify_rx_queue
  iwlwifi: mvm: add a loose synchronization of the NSSN across Rx queues
  iwlwifi: mvm: fix frame drop from the reordering buffer

Gregory Greenman (4):
  iwlwifi: mvm: add a wrapper around rs_tx_status to handle locks
  iwlwifi: mvm: send LQ command always ASYNC
  iwlwifi: mvm: replace RS mutex with a spin_lock
  iwlwifi: mvm: fix possible out-of-bounds read when accessing lq_info

Ihab Zhaika (1):
  iwlwifi: add 3 new IDs for the 9000 series (iwl9260_2ac_160_cfg)

Johannes Berg (1):
  iwlwifi: fix locking in delayed GTK setting

Luca Coelho (2):
  iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT on version < 41
  iwlwifi: mvm: fix version check for GEO_TX_POWER_LIMIT support

Shahar S Matityahu (2):
  iwlwifi: dbg_ini: move iwl_dbg_tlv_load_bin out of debug override
    ifdef
  iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  27 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  44 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 559 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 185 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  13 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   3 +
 14 files changed, 496 insertions(+), 376 deletions(-)

-- 
2.20.1

