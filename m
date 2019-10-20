Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BACDDD5B
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfJTIzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 04:55:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50754 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbfJTIzy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 04:55:54 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iM709-0003LY-Il; Sun, 20 Oct 2019 11:55:51 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 20 Oct 2019 11:55:33 +0300
Message-Id: <20191020085545.16407-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.5 2019-20
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.5.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Move ACPI handling code fully into acpi.c;
* Increase the CTDP budget to improve signal strength;
* A fix for compilation with no ACPI enabled;
* Enable adaptive dwell on P2P interfaces;
* Another scan FW API update;
* A few clean-ups;
* Other small fixes and improvements;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Colin Ian King (1):
  iwlwifi: remove redundant assignment to variable bufsz

Emmanuel Grumbach (1):
  iwlwifi: mvm: sync the iwl_mvm_session_prot_notif layout

Haim Dreyfuss (1):
  iwlwifi: mvm: don't skip mgmt tid when flushing all tids

Ihab Zhaika (1):
  iwlwifi: refactor the SAR tables from mvm to acpi

Johannes Berg (3):
  iwlwifi: remove IWL_DEVICE_22560/IWL_DEVICE_FAMILY_22560
  iwlwifi: 22000: fix some indentation
  iwlwifi: mvm: fix non-ACPI function

Mordechay Goodstein (1):
  iwlwifi: mvm: start CTDP budget from 2400mA

Shahar S Matityahu (3):
  iwlwifi: scan: make new scan req versioning flow
  iwlwifi: scan: support scan req cmd ver 12
  iwlwifi: mvm: scan: enable adaptive dwell in p2p

Wang Xuerui (1):
  iwlwifi: mvm: fix unaligned read of rx_pkt_status

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  50 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 297 +++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  84 ++++
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 161 ++++---
 .../intel/iwlwifi/fw/api/time-event.h         |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |   6 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  11 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   1 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 361 ++-------------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 426 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  43 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  53 +--
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  31 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   2 +-
 27 files changed, 966 insertions(+), 646 deletions(-)

-- 
2.23.0

