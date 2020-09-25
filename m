Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CED27938A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgIYVa7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:30:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52284 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726744AbgIYVa7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:30:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvIs-002J1P-G2; Sat, 26 Sep 2020 00:30:57 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:38 +0300
Message-Id: <20200925213053.454459-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/15] iwlwifi: updates intended for v5.10 2020-09-26
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.10.  This is a bit
larger than your recommended 12 patches per series, because 4 of them
should actually have been in the previous series, but I have
mistankenly not sent.  Other than this, it is usual development, new
features, cleanups and bugfixes.

The changes are:

* Some clean-ups in the ACPI code;
* A fix for AP mode;
* Work on a better trans abstraction continues;
* Support for some new cards;
* Some updates for new or changed FW APIs;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Andrei Otcheretianski (1):
  iwlwifi: mvm: Don't install CMAC/GMAC key in AP mode

Dan Halperin (2):
  iwlwifi: mvm: add support for new  version of
    WOWLAN_TKIP_SETTING_API_S
  iwlwifi: mvm: add support for new WOWLAN_TSC_RSC_PARAM version

Emmanuel Grumbach (1):
  iwlwifi: mvm: split a print to avoid a WARNING in ROC

Gil Adam (1):
  iwlwifi: regulatory: regulatory capabilities api change

Johannes Berg (1):
  iwlwifi: mvm: use CHECKSUM_COMPLETE

Luca Coelho (4):
  iwlwifi: dbg: remove IWL_FW_INI_TIME_POINT_WDG_TIMEOUT
  iwlwifi: don't export acpi functions unnecessarily
  iwlwifi: remove iwl_validate_sar_geo_profile() export
  iwlwifi: acpi: remove dummy definition of iwl_sar_set_profile()

Mordechay Goodstein (3):
  iwlwifi: dbg: add dumping special device memory
  iwl-trans: move dev_cmd_offs, page_offs to a common trans header
  iwlwifi: mvm: remove redundant support_umac_log field

Naftali Goldstein (1):
  iwlwifi: mvm: process ba-notifications also when sta rcu is invalid

Roee Goldfiner (1):
  iwlwifi: add new card for MA family

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 28 +-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 23 -----
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 26 +++--
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 26 ++++-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 56 +++++++++++
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 14 +++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  7 ++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 98 +++++++++++++++++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 60 ++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 41 ++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 24 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 73 ++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 77 ++++++++++-----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  1 +
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  6 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  9 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 15 ++-
 23 files changed, 436 insertions(+), 167 deletions(-)

-- 
2.28.0

