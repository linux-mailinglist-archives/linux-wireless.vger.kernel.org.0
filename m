Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014C227AA9B
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgI1JXZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52722 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgI1JXZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNT-002KgD-0X; Mon, 28 Sep 2020 12:23:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:09 +0300
Message-Id: <20200928092321.649185-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.10 2020-09-28
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.10.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some new FW API command version implementations;
* Updates in the ACPI code to support new tables and FW versions;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (2):
  iwlwifi: mvm: add support for range request command ver 11
  iwlwifi: mvm: add support for responder dynamic config command version
    3

Luca Coelho (5):
  iwlwifi: add a common struct for all iwl_tx_power_cmd versions
  iwlwifi: acpi: prepare SAR profile selection code for multiple sizes
  iwlwifi: support REDUCE_TX_POWER_CMD version 6
  iwlwifi: acpi: rename geo structs to contain versioning
  iwlwifi: support version 3 of GEO_TX_POWER_LIMIT

Mordechay Goodstein (4):
  iwlwifi: rs: set RTS protection for all non legacy rates
  iwlwifi: acpi: in non acpi compilations remove iwl_sar_geo_init
  iwlwifi: fw: add default value for iwl_fw_lookup_cmd_ver
  iwlwifi: remove wide_cmd_header field

Nathan Errera (1):
  iwlwifi: mvm: support new KEK KCK api

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  44 ++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  13 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   3 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  14 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  | 231 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 106 ++++++--
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  11 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.c   |  11 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  25 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  69 ++++--
 .../intel/iwlwifi/mvm/ftm-responder.c         | 103 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 110 ++++++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   6 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   5 -
 22 files changed, 643 insertions(+), 167 deletions(-)

-- 
2.28.0

