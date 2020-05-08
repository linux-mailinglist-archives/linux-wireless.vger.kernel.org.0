Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4A1CB15F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 16:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgEHOIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 10:08:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:60246 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726736AbgEHOIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 10:08:14 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jX3fg-000WXw-J2; Fri, 08 May 2020 17:08:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  8 May 2020 17:07:51 +0300
Message-Id: <20200508140802.558267-1-luca@coelho.fi>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/11] iwlwifi: updates intended for v5.8 2020-05-08
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the sixth set of patches intended for v5.8.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Update range request API;
* Add ACPI DSM support;
* Support enabling 5.2GHz bands in Indonesia via ACPI;
* Bump FW API version to 56;
* TX queues refactoring started;
* Fix one memory leak;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: add support for range request version 10

Gil Adam (2):
  iwlwifi: acpi: support device specific method (DSM)
  iwlwifi: acpi: evaluate dsm to enable 5.2 bands in Indonesia

Haim Dreyfuss (2):
  iwlwifi: set NO_HE if the regulatory domain forbids it
  iwlwifi: pcie: don't count on the FW to set persistence mode

Johannes Berg (1):
  iwlwifi: pcie: gen3: indicate 8k/12k RB size to device

Luca Coelho (1):
  iwlwifi: bump FW API to 56 for AX devices

Mordechay Goodstein (3):
  iwlwifi: pcie: keep trans instead of trans_pcie in iwl_txq
  iwlwifi: move iwl_txq and substructures to a common trans header
  iwlwifi: move txq-specific from trans_pcie to common trans

Sharon (1):
  iwlwifi: mvm: fix aux station leak

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  99 ++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  22 +++
 .../wireless/intel/iwlwifi/fw/api/location.h  |  14 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  34 ++++-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  12 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   5 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 128 ++++++++++++++++++
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  42 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  43 ++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  18 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   6 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  10 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |   6 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    | 121 +----------------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   6 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  11 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  47 +++----
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  70 +++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 120 ++++++++--------
 21 files changed, 524 insertions(+), 297 deletions(-)

-- 
2.26.2

