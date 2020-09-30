Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA5B27E9FA
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgI3Nb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53290 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730169AbgI3Nb2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCc-002MJ5-0I; Wed, 30 Sep 2020 16:31:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:11 +0300
Message-Id: <20200930133123.924256-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12]  iwlwifi: updates intended for v5.10 2020-09-30
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.10.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* FTM updates;
* More new FW API version support;
* A bit of reorganiztion in the queue code;
* A few debugging infra improvements;
* Add support for new GTK rekeying;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (3):
  iwlwifi: mvm: location: set the HLTK when PASN station is added
  iwlwifi: mvm: responder: allow to set only the HLTK for an associated
    station
  iwlwifi: mvm: initiator: add option for adding a PASN responder

Gil Adam (1):
  iwlwifi: thermal: support new temperature measurement API

Ilan Peer (1):
  iwlwifi: mvm: Add FTM initiator RTT smoothing logic

Johannes Berg (1):
  iwlwifi: mvm: d3: support GCMP ciphers

Mordechay Goodstein (4):
  iwlwifi: move all bus-independent TX functions to common code
  iwlwifi: dbg: remove no filter condition
  iwlwifi: dbg: run init_cfg function once per driver load
  iwlwifi: phy-ctxt: add new API VER 3 for phy context cmd

Nathan Errera (1):
  iwlwifi: mvm: support more GTK rekeying algorithms

Sara Sharon (1):
  iwlwifi: mvm: add d3 prints

 drivers/net/wireless/intel/iwlwifi/Makefile   |    1 +
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |   32 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |   13 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |    8 +-
 .../net/wireless/intel/iwlwifi/iwl-debug.h    |    6 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   19 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |    1 +
 .../wireless/intel/iwlwifi/mvm/constants.h    |    6 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   60 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  300 +++-
 .../intel/iwlwifi/mvm/ftm-responder.c         |   62 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |    2 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |    7 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   31 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |    1 +
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  126 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   78 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |    2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  125 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |    2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |    4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   59 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 1078 +------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  311 +---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 1375 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  188 +++
 26 files changed, 2286 insertions(+), 1611 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/queue/tx.h

-- 
2.28.0

