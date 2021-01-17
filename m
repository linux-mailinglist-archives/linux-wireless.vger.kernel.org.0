Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2A2F930F
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbhAQOx3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40718 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728837AbhAQOxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:25 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Pw-003sgA-4c; Sun, 17 Jan 2021 16:52:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:25 +0200
Message-Id: <20210117145234.1435324-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 0/9] iwlwifi: updates intended for v5.12 2021-01-17 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.12.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Fix a CSA bug;
* Implement PHY integration version parsing;
* A bit of refactoring;
* Some other clean-ups and small fixes.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Dror Moshe (2):
  iwlwifi: parse phy integration string from FW TLV
  iwlwifi: mvm: debugfs for phy-integration-ver

Haim Dreyfuss (1):
  iwlwifi: mvm: don't send commands during suspend\resume transition

Johannes Berg (3):
  iwlwifi: mvm: simplify TX power setting
  iwlwifi: mvm: debugfs: check length precisely in inject_packet
  iwlwifi: always allow maximum A-MSDU on newer devices

Krishnanand Prabhu (1):
  iwlwifi: mvm: add explicit check for non-data frames in get Tx rate

Mordechay Goodstein (1):
  iwlwifi: tx: move handing sync/async host command to trans

Shaul Triebitz (1):
  iwlwifi: mvm: csa: do not abort CSA before disconnect

 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   3 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  14 ++
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |   7 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  18 ++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   6 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  19 +--
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  32 +++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  22 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  13 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   7 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   7 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   7 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 125 +--------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 142 +-----------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 129 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |   1 +
 18 files changed, 244 insertions(+), 314 deletions(-)

-- 
2.29.2

