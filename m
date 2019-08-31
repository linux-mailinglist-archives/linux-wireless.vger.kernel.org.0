Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F757A43B9
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfHaJtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:49:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39622 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726323AbfHaJtH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:49:07 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400G-0002OQ-BI; Sat, 31 Aug 2019 12:49:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:40 +0300
Message-Id: <20190831094859.6391-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 00/19] iwlwifi: updates intended for v5.4 2019-08-31
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.4.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* New FW channel-switch support;
* Debug infrastructure work continues;
* Support new ACPI value for per-platform antenna gain;
* Some work on new FW scan APIs;
* A few clean-ups;
* Other small fixes and improvements;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Christoph Hellwig (1):
  iwlwifi: stop passing bogus gfp flags arguments to dma_alloc_coherent

Emmanuel Grumbach (1):
  iwlwifi: mvm: simplify the channel switch flow for newer firmware

Gil Adam (1):
  iwlwifi: support per-platform antenna gain

Johannes Berg (1):
  iwlwifi: api: fix FTM struct documentation

Luca Coelho (4):
  iwlwifi: mvm: remove check for lq_sta in __iwl_mvm_rs_tx_status()
  iwlwifi: bump FW API to 50 for 22000 series
  iwlwifi: remove duplicate FW string definitions
  iwlwifi: remove unnecessary IWL_DEVICE_AX200_COMMON definition

Shahar S Matityahu (9):
  iwlwifi: dbg_ini: use function to check if ini dbg mode is on
  iwlwifi: dbg_ini: verify debug TLVs at allocation phase
  iwlwifi: dbg_ini: remove debug flow TLV
  iwlwifi: dbg: align wrt log prints to the same format
  iwlwifi: dbg_ini: separate cfg and dump flows to different modules
  iwlwifi: dbg_ini: use linked list for dump TLVs during dump creation
  iwlwifi: dbg_ini: move tx fifo data into fw runtime
  iwlwifi: dbg_ini: make a single ops struct for paging collect
  iwlwifi: dbg_ini: use regions ops array instead of switch case in dump
    flow

Tova Mussai (2):
  iwlwifi: allocate bigger nvm data in case of UHB
  iwlwifi: mvm: look for the first supported channel when add/remove phy
    ctxt

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   13 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   12 +
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |   11 -
 .../wireless/intel/iwlwifi/fw/api/location.h  |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |    7 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h |   12 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 1003 +++++------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   12 +-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |   22 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |    4 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   18 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  580 +++++++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |    3 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |    6 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  142 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |    6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   83 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |    3 +
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |   11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |    2 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |    2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |    2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |    7 +-
 27 files changed, 1121 insertions(+), 888 deletions(-)

-- 
2.23.0.rc1

