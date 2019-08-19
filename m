Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECB8926CC
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHSOfU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 10:35:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36762 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbfHSOfU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 10:35:20 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzikc-0007sP-Ur; Mon, 19 Aug 2019 17:35:17 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 17:34:45 +0300
Message-Id: <20190819143507.6989-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 00/22] iwlwifi: updates intended for v5.4 2019-08-17-2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second version of the first set of patches intended for
v5.4.  It's the usual development, new features, cleanups and
bugfixes.

The changes are:

* Remove (broken) d0i3 support;
* Debug infrastructure work continues;
* Bump support FW API version to 49;
* A few clean-ups;
* Other small fixes and improvements;

In v2:

* Fixed the bogus commit message of patch 9/22.
* Added more description to the two patches Kalle commented on (12/22
  and 22/22);

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Beker Ayala (1):
  iwlwifi: mvm: fix scan config command size

Emmanuel Grumbach (12):
  iwlwifi: mvm: remove redundant condition in
    iwl_mvm_set_hw_rfkill_state
  iwlwifi: mvm: start to remove the code for d0i3
  iwlwifi: remove all the d0i3 references
  iwlwifi: mvm: remove the tx defer for d0i3
  iwlwifi: mvm: remove the d0i3 entry/exit flow
  iwlwifi: mvm: iwl_mvm_wowlan_config_key_params is for wowlan only
  iwlwifi: mvm: remove d0i3_ap_sta_id
  iwlwifi: mvm: remove iwl_mvm_update_d0i3_power_mode
  iwlwifi: mvm: remove last leftovers of d0i3
  iwlwifi: remove CMD_HIGH_PRIO
  iwlwifi: trans: remove suspending flag
  iwlwifi: remove the code under IWLWIFI_PCIE_RTPM

Ilan Peer (1):
  iwlwifi: mvm: Block 26-tone RU OFDMA transmissions

Ilia Lin (1):
  iwlwifi: Send DQA enable command only if TVL is on

Johannes Berg (1):
  iwlwifi: mvm: remove unnecessary forward declarations

Luca Coelho (1):
  iwlwifi: bump FW API to 49 for 22000 series

Shahar S Matityahu (4):
  iwlwifi: dbg: move monitor recording functionality from header file
  iwlwifi: dbg: move debug recording stop from trans to op mode
  iwlwifi: dbg: support debug recording suspend resume command
  iwlwifi: add ldbg config cmd debug print

Shaul Triebitz (1):
  iwlwifi: mvm: add the skb length to a print

 drivers/net/wireless/intel/iwlwifi/Kconfig    |  14 -
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  30 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   4 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 102 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  92 +---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 186 +------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 111 -----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  13 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 333 +++----------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 117 +----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 460 +-----------------
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  82 +---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  19 -
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |   9 -
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  85 ----
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   3 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   7 -
 27 files changed, 251 insertions(+), 1496 deletions(-)

-- 
2.23.0.rc1

