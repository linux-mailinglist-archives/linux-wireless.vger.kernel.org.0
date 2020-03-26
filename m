Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCBF193F4A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgCZMzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44186 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727841AbgCZMzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2Y-00040Z-Cr; Thu, 26 Mar 2020 14:55:19 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:54:58 +0200
Message-Id: <20200326125510.621842-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.7 2020-03-27
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.7.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* More refactoring of the device selection algorithms;
* Support new FW API version;
* Support for EDCA measurements;
* New scan API features;
* Enable new debugging code;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: add support for non EDCA based measurements

Johannes Berg (3):
  iwlwifi: remove IWL_FW_DBG_DOMAIN macro
  iwlwifi: pcie: make iwl_pcie_cmdq_reclaim static
  iwlwifi: mvm: remove newline from rs_pretty_print_rate()

Luca Coelho (6):
  iwlwifi: add support for version 2 of SOC_CONFIGURATION_CMD
  iwlwifi: add trans_cfg for devices with long latency
  iwlwifi: remove support for QnJ Hr STEP A
  iwlwifi: remove support for QnJ HR FPGA
  iwlwifi: yoyo: enable yoyo by default
  iwlwifi: bump FW API to 53 for 22000 series

Tova Mussai (1):
  iwlwifi: scan: support FW APIs with variable number of profiles

rotem saado (1):
  iwlwifi: yoyo: don't block dumping internal memory when not in SRAM
    mode

 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 48 +++++--------------
 .../wireless/intel/iwlwifi/fw/api/location.h  |  6 +++
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 31 +++++++++---
 .../net/wireless/intel/iwlwifi/fw/api/soc.h   | 24 ++++++----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  8 +---
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  5 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  4 ++
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  9 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 21 ++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  6 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 40 +++++++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 17 ++-----
 .../wireless/intel/iwlwifi/pcie/internal.h    |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  2 +-
 19 files changed, 145 insertions(+), 104 deletions(-)

-- 
2.25.1

