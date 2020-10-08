Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A432876C0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgJHPJz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:09:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54442 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730806AbgJHPJz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:09:55 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYG-002Qut-Fw; Thu, 08 Oct 2020 18:09:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:36 +0300
Message-Id: <20201008150949.331882-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/13]  iwlwifi: updates intended for v5.10 2020-10-08 part 1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the sixth set of patches intended for v5.10.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* PNVM support (platform-specific phy config data);
* Added and fixed some device recognition code;
* A few more FW API updates for newer FWs;
* Some other small fixesl;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: avoid possible NULL pointer dereference

Golan Ben Ami (1):
  iwlwifi: support an additional Qu subsystem id

Johannes Berg (1):
  iwlwifi: mvm: stop claiming NL80211_EXT_FEATURE_SET_SCAN_DWELL

Luca Coelho (5):
  iwlwifi: mvm: read and parse SKU ID if available
  iwlwifi: update prph scratch structure to include PNVM data
  iwlwifi: mvm: ring the doorbell and wait for PNVM load completion
  iwlwifi: mvm: don't send RFH_QUEUE_CONFIG_CMD with no queues
  iwlwifi: pcie: fix 0x271B and 0x271C trans cfg struct

Nathan Errera (4):
  iwlwifi: mvm: get number of stations from TLV
  iwlwifi: mvm: prepare roc_done_wk to work sync
  iwlwifi: mvm: add a get lmac id function
  iwlwifi: mvm: support ADD_STA_CMD_API_S ver 12

Sara Sharon (1):
  iwlwifi: mvm: re-enable TX after channel switch

 .../wireless/intel/iwlwifi/fw/api/binding.h   |  16 ++-
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   2 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  13 ++
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h |  10 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   1 +
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  18 +--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  15 ++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   1 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   1 +
 .../net/wireless/intel/iwlwifi/mvm/binding.c  |  11 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 129 ++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  42 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  37 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  33 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |  12 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  27 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  18 +--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   5 +-
 30 files changed, 320 insertions(+), 137 deletions(-)

-- 
2.28.0

