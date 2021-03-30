Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157E534E905
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 15:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhC3NZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 09:25:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43582 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231968AbhC3NZI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 09:25:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lREMe-0007fg-3a; Tue, 30 Mar 2021 16:25:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Mar 2021 16:24:48 +0300
Message-Id: <20210330132500.468321-1-luca@coelho.fi>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.13 2021-03-30
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.13.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Add support for new FTM FW APIs;
* Some CSA fixes;
* Support for new HW family and other HW detection fixes;
* Robustness improvement in the HW detection code;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (2):
  iwlwifi: mvm: support range request command version 12
  iwlwifi: mvm: responder: support responder config command version 8

Emmanuel Grumbach (1):
  iwlwifi: mvm: don't allow CSA if we haven't been fully associated

Johannes Berg (3):
  iwlwifi: pcie: avoid unnecessarily taking spinlock
  iwlwifi: pcie: normally grab NIC access for inflight-hcmd
  iwlwifi: pcie: make cfg vs. trans_cfg more robust

Matti Gottlieb (1):
  iwlwifi: pcie: Add support for Bz Family

Mordechay Goodstein (1):
  iwlwifi: pcie: clear only FH bits handle in the interrupt

Sara Sharon (1):
  iwlwifi: mvm: enable TX on new CSA channel before disconnecting

ybaruch (3):
  iwlwifi: change step in so-gf struct
  iwlwifi: change name to AX 211 and 411 family
  iwlwifi: add 160Mhz to killer 1550 name

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  64 ++++++-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |   2 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  | 173 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   3 +
 .../wireless/intel/iwlwifi/mvm/constants.h    |   9 +
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  76 +++++++-
 .../intel/iwlwifi/mvm/ftm-responder.c         |  27 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  10 +
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  10 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  63 ++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  69 +++----
 13 files changed, 456 insertions(+), 67 deletions(-)

-- 
2.31.0

