Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74F277284
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgIXNhU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:37:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52088 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727846AbgIXNhU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLRDp-002IGj-Po; Thu, 24 Sep 2020 16:23:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Sep 2020 16:23:32 +0300
Message-Id: <20200924132339.337310-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 0/7] iwlwifi: updates intended for v5.10 2020-09-24
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.10.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Enable TWT by default;
* Support for some new cards;
* Support new PPAG FW command version
* Move some trans code around for better abstraction;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Gil Adam (1):
  iwlwifi: acpi: support ppag table command v2

Golan Ben Ami (1):
  iwlwifi: enable twt by default

Ihab Zhaika (1):
  iwlwifi: add new cards for MA family

Mordechay Goodstein (4):
  iwlwifi: iwl-trans: move all txcmd init to trans alloc
  iwlwifi: move bc_pool to a common trans header
  iwlwifi: iwl-trans: move tfd to trans layer
  iwlwifi: move bc_table_dword to a common trans header

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  51 +++++++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   8 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  27 +++--
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |   7 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   9 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  57 +++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  23 +++-
 .../wireless/intel/iwlwifi/mvm/constants.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 103 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  18 ++-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  15 +--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  59 ++--------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  38 +++----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  28 ++---
 15 files changed, 279 insertions(+), 169 deletions(-)

-- 
2.28.0

