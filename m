Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F8A2876D9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgJHPMz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:12:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54554 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729833AbgJHPMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:12:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXbA-002QxQ-RH; Thu, 08 Oct 2020 18:12:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:12:37 +0300
Message-Id: <20201008151250.332346-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/13] iwlwifi: updates intended for v5.10 2020-10-08 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the seventh set of patches intended for v5.10.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some more fixes in some device configurations;
* PNVM implementation continued;
* A few more FW API updates for newer FWs;
* Bump the FW API supported to 59;
* Some other small fixes;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: mvm: don't send a CSA command the firmware doesn't know

Luca Coelho (7):
  iwlwifi: pcie: fix xtal latency for 9560 devices
  iwlwifi: pcie: fix the xtal latency value for a few qu devices
  iwlwifi: move PNVM implementation to common code
  iwlwifi: add trans op to set PNVM
  iwlwifi: pcie: implement set_pnvm op
  iwlwifi: read and parse PNVM file
  iwlwifi: bump FW API to 59 for AX devices

Mordechay Goodstein (2):
  iwlwifi: stats: add new api fields for statistics cmd/ntfy
  iwlwifi: rs: align to new TLC config command API

Naftali Goldstein (1):
  iwlwifi: fix sar geo table initialization

Sara Sharon (2):
  iwlwifi: mvm: remove memset of kek_kck command
  iwlwifi: mvm: fix suspicious rcu usage warnings

 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  17 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  20 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   1 -
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   6 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |   7 +-
 .../net/wireless/intel/iwlwifi/fw/api/stats.h | 461 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 274 +++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |  18 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   1 +
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   3 +
 .../wireless/intel/iwlwifi/iwl-context-info.h |   7 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  20 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  84 +---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 195 +++++---
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  22 +
 .../wireless/intel/iwlwifi/mvm/time-event.h   |   7 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  27 +
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  21 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |   3 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   7 +
 27 files changed, 1094 insertions(+), 162 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h

-- 
2.28.0

