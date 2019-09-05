Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21FAA3EE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbfIENMt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:12:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40894 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730839AbfIENMt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:12:49 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZ8-0005yI-Ev; Thu, 05 Sep 2019 16:12:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:23 +0300
Message-Id: <20190905131241.23487-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 00/18] iwlwifi: updates intended for v5.4 2019-08-21-2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.4.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Removal of (broken) d0i3 continues;
* Debug infrastructure work continues;
* Fix for the SN value in certain suspend/resume situations;
* Some work on new FW scan APIs;
* Work on LTR FW APIs;
* A few clean-ups;
* Other small fixes and improvements;

In v2:
   * fixed subject and commit message of the first patch;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Alex Malamud (2):
  iwlwifi: LTR updates
  iwlwifi: Set w-pointer upon resume according to SN

Ayala Beker (2):
  iwlwifi: scan: add support for new scan request command version
  iwlwifi: scan: don't pass large argument by value

Emmanuel Grumbach (6):
  iwlwifi: remove runtime_pm_mode
  iwlwifi: remove the opmode's d0i3 handlers
  iwlwifi: pcie: remove the refs / unrefs from the transport
  iwlwifi: pcie: remove some more d0i3 code from the transport
  iwlwifi: remove the d0i3 related module parameters
  iwlwifi: remove pm_runtime completely

Haim Dreyfuss (1):
  iwlwifi: remove unused regdb_ptrs allocation

Johannes Berg (1):
  iwlwifi: mvm: use FW thermal monitoring regardless of CONFIG_THERMAL

Mordechay Goodstein (1):
  iwlwifi: mvm: name magic numbers with enum

Shahar S Matityahu (5):
  iwlwifi: dbg_ini: align dbg tlv functions names to a single format
  iwlwifi: dbg: add debug periphery registers to 9000 device family
  iwlwifi: dbg_ini: maintain buffer allocations from trans instead of
    TLVs buffer
  iwlwifi: dbg_ini: use linked list to store debug TLVs
  iwlwifi: dbg_ini: remove periphery phy and aux regions handling

 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |   2 +
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  18 ++-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  55 ++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  53 +++---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   9 --
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 153 +++++-------------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  24 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  19 +--
 .../wireless/intel/iwlwifi/iwl-modparams.h    |   9 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  14 --
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  23 ---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  14 --
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 106 ++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   9 ++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  37 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  11 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  19 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  87 +++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  99 ------------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  11 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   6 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  67 ++------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  42 +----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  92 ++++-------
 26 files changed, 363 insertions(+), 637 deletions(-)

-- 
2.23.0.rc1

