Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5904682F2
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhLDGj2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50266 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229784AbhLDGj1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:27 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOeK-0017AH-Tu; Sat, 04 Dec 2021 08:35:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:43 +0200
Message-Id: <20211204063555.769822-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.16 2021-12-04 part 1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.17.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some improvements in D3;
* Support for new FW API commands;
* Fixes and cleanups in device configurations;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Haim Dreyfuss (1):
  iwlwifi: pcie: support Bz suspend/resume trigger

Johannes Berg (8):
  iwlwifi: mvm: fix delBA vs. NSSN queue sync race
  iwlwifi: mvm: synchronize with FW after multicast commands
  iwlwifi: mvm: d3: move GTK rekeys condition
  iwlwifi: mvm: parse firmware alive message version 6
  iwlwifi: mvm: d3: support v12 wowlan status
  iwlwifi: mvm: support RLC configuration command
  iwlwifi: fw: api: add link to PHY context command struct v1
  iwlwifi: mvm: add support for PHY context command v4

Luca Coelho (1):
  iwlwifi: remove unused iwlax210_2ax_cfg_so_hr_a0 structure

Mike Golant (2):
  iwlwifi: properly support 4-bit MAC step
  iwlwifi: add support for Bz-Z HW

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  17 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   8 +-
 .../net/wireless/intel/iwlwifi/fw/api/alive.h |  17 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  81 +++++++-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  62 ++++++
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  19 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   7 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 184 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  17 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  11 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  62 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  10 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  24 +--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  80 ++++----
 24 files changed, 514 insertions(+), 131 deletions(-)

-- 
2.33.1

