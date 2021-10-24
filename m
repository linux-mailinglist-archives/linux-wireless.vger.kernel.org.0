Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5754389BF
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhJXPXF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58608 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229564AbhJXPXE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefId-000czj-Hc; Sun, 24 Oct 2021 18:20:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:25 +0300
Message-Id: <20211024152037.332948-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.16 2021-10-24 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the sixth set of patches intended for v5.16.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some fixes in the Geographic SAR implementation;
* Support for WiFi 6E enablement via BIOS;
* Support FW API version 67;
* Improve debugging support;
* Some fixes in session protection;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Gregory Greenman (1):
  iwlwifi: mvm: update RFI TLV

Johannes Berg (4):
  iwlwifi: fw: uefi: add missing include guards
  iwlwifi: mvm: d3: use internal data representation
  iwlwifi: mvm: remove session protection on disassoc
  iwlwifi: mvm: extend session protection on association

Luca Coelho (5):
  iwlwifi: mvm: read 6E enablement flags from DSM and pass to FW
  iwlwifi: mvm: don't get address of mvm->fwrt just to dereference as a
    pointer
  iwlwifi: rename GEO_TX_POWER_LIMIT to PER_CHAIN_LIMIT_OFFSET_CMD
  iwlwifi: mvm: fix WGDS table print in iwl_mvm_chub_update_mcc()
  iwlwifi: bump FW API to 67 for AX devices

Mukesh Sisodiya (1):
  iwlwifi: yoyo: support for ROM usniffer

Nathan Errera (1):
  iwlwifi: rename CHANNEL_SWITCH_NOA_NOTIF to CHANNEL_SWITCH_START_NOTIF

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   1 +
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  43 ---
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  17 +
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  10 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |   6 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  28 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |   5 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  92 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 357 +++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  28 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  67 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  10 +-
 18 files changed, 417 insertions(+), 274 deletions(-)

-- 
2.33.0

