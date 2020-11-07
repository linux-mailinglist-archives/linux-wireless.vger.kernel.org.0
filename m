Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C732AA3F7
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKGIuP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:50:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58776 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727955AbgKGIuP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:50:15 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kbJvJ-002on9-0l; Sat, 07 Nov 2020 10:50:13 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat,  7 Nov 2020 10:50:05 +0200
Message-Id: <20201107085011.57943-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 0/6] iwlwifi: fixes intended for v5.10 2020-11-07
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is my first patchset with fixes for v5.10.

The changes are:

* Fix a kernel panic in CSA when the FW asserts;
* Fix a command completion timeout by using LTR correctly;
* Fix HE capabilities;
* Some fixes in the session protection code;
* Fix a queue sync vs. async handling.

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the rc series, please take them directly to
wireless-drivers.git, as we agreed.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: write queue_sync_state only for sync

Emmanuel Grumbach (2):
  iwlwifi: mvm: use the HOT_SPOT_CMD to cancel an AUX ROC
  iwlwifi: mvm: properly cancel a session protection for P2P

Johannes Berg (1):
  iwlwifi: pcie: set LTR to avoid completion timeout

Mordechay Goodstein (1):
  iwlwifi: sta: set max HE max A-MPDU according to HE capa

Sara Sharon (1):
  iwlwifi: mvm: fix kernel panic in case of assert during CSA

 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  10 +-
 .../intel/iwlwifi/fw/api/time-event.h         |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  10 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  18 +++
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 103 ++++++++++++------
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  20 ++++
 7 files changed, 131 insertions(+), 43 deletions(-)

-- 
2.28.0

