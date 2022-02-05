Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1654AA7D7
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Feb 2022 10:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbiBEJVo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Feb 2022 04:21:44 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37980 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230226AbiBEJVo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Feb 2022 04:21:44 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nGHGH-0006b7-6l;
        Sat, 05 Feb 2022 11:21:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  5 Feb 2022 11:21:28 +0200
Message-Id: <20220205092140.751171-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.18 2022-02-05
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fifth set of patches intended for v5.18.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Add support for band disablement via BIOS;
* Bump FW API version;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ayala Barazani (1):
  iwlwifi: mvm: Disable WiFi bands selectively with BIOS

Emmanuel Grumbach (2):
  iwlwifi: don't dump_stack() when we get an unexpected interrupt
  iwlwifi: mvm: always remove the session protection after association

Golan Ben Ami (1):
  iwlwifi: bump FW API to 70 for AX devices

Gregory Greenman (1):
  iwlwifi: mvm: rfi: handle deactivation notification

Ilan Peer (1):
  iwlwifi: mvm: Consider P2P GO operation during scan

Johannes Berg (1):
  iwlwifi: mvm: make iwl_mvm_reconfig_scd() static

Luca Coelho (2):
  iwlwifi: mvm: don't send BAID removal to the FW during hw_restart
  iwlwifi: fix small doc mistake for iwl_fw_ini_addr_val

Miri Korenblit (1):
  iwlwifi: mvm: refactor setting PPE thresholds in STA_HE_CTXT_CMD

Mordechay Goodstein (2):
  iwlwifi: mvm: add additional info for boot info failures
  iwlwifi: mvm: add additional info for boot info failures

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   5 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |   5 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  28 ++-
 .../net/wireless/intel/iwlwifi/fw/api/rfi.h   |  10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  60 ++++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 209 ++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c  |   9 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 132 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  42 +++-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  34 +--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   9 +-
 include/linux/ieee80211.h                     |   3 +-
 17 files changed, 412 insertions(+), 162 deletions(-)

-- 
2.34.1

