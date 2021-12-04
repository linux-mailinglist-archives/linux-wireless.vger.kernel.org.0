Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9EA468606
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 16:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbhLDPxP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 10:53:15 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231259AbhLDPxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 10:53:14 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtXII-0017qB-QG; Sat, 04 Dec 2021 17:49:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 17:49:32 +0200
Message-Id: <20211204154944.914175-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.16 2021-12-04 part 3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.17.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support SAR GEO Offset Mapping (SGOM) via BIOS;
* Continued work on the new Bz device family;
* Some more firmware debugging improvements;
* Support new FW API version 68;
* Add some new device IDs;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ayala Barazani (1):
  iwlwifi: support SAR GEO Offset Mapping override via BIOS

Johannes Berg (6):
  iwlwifi: mvm/api: define system control command
  iwlwifi: mvm: always use 4K RB size by default
  iwlwifi: pcie: retake ownership after reset
  iwlwifi: implement reset flow for Bz devices
  iwlwifi: fw: correctly detect HW-SMEM region subtype
  iwlwifi: mvm: optionally suppress assert log

Luca Coelho (1):
  iwlwifi: bump FW API to 68 for AX devices

Matti Gottlieb (1):
  iwlwifi: Fix FW name for gl

Mukesh Sisodiya (1):
  iwlwifi: dbg:  disable ini debug in 8000 family and below

Yaara Baruch (2):
  iwlwifi: add new Qu-Hr device
  iwlwifi: add new ax1650 killer device

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  2 +
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  5 ++
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  3 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  5 ++
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 14 +++
 .../intel/iwlwifi/fw/api/{soc.h => system.h}  | 16 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 88 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 20 +++++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 11 ++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  8 ++
 .../net/wireless/intel/iwlwifi/mvm/fw-api.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 49 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 17 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  6 ++
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 13 +--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 35 +++++---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  7 +-
 24 files changed, 276 insertions(+), 47 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/fw/api/{soc.h => system.h} (70%)

-- 
2.33.1

