Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BDD127B45
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLTMvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54036 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727341AbfLTMvc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:32 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkf-0007lx-Ta; Fri, 20 Dec 2019 14:51:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:13 +0200
Message-Id: <20191220125124.1315679-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 00/11] iwlwifi: updates intended for v5.6 2019-11-20
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first and final set of patches intended for v5.6.  It's the
usual development, new features, cleanups and bugfixes.

The changes are:

* Support new versions of the FTM FW APIs;
* Fix an old bug in D3 (WoWLAN);
* A couple of fixes/improvements in the receive-buffers code;
* Fix in the debugging where we were skipping one TXQ;
* Some clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (2):
  iwlwifi: mvm: add support for location range request version 8
  iwlwifi: mvm: add support for responder config command version 7

Johannes Berg (5):
  iwlwifi: mvm: update powersave correctly for D3
  iwlwifi: allocate more receive buffers for HE devices
  iwlwifi: pcie: map only used part of RX buffers
  iwlwifi: pcie: use partial pages if applicable
  iwlwifi: pcie: validate queue ID before array deref/bit ops

Luca Coelho (3):
  iwlwifi: dbg_ini: don't skip a TX FIFO when dumping
  iwlwifi: remove some outdated iwl22000 configurations
  iwlwifi: remove CSR registers abstraction

Tova Mussai (1):
  iwlwifi: scan: remove support for fw scan api v11

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |  12 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  71 ++++--
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  19 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |   2 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  | 144 ++++++++++-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  41 ---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  56 +----
 .../wireless/intel/iwlwifi/iwl-context-info.h |  20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  27 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  37 +--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  14 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  18 ++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   6 +
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 238 ++++++++++++++----
 .../intel/iwlwifi/mvm/ftm-responder.c         |  95 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  47 ----
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  11 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  25 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  21 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 108 +++++---
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   5 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  51 ++--
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  16 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  12 +-
 33 files changed, 725 insertions(+), 430 deletions(-)

-- 
2.24.0

