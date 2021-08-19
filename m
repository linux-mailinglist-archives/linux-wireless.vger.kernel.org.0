Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32723F1CFC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbhHSPlQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:41:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56884 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238776AbhHSPlQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:41:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mGk9k-002Hje-CU; Thu, 19 Aug 2021 18:40:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 19 Aug 2021 18:40:24 +0300
Message-Id: <20210819154035.72584-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/11] iwlwifi: updates intended for v5.15 2021-08-19
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the sixth set of patches intended for v5.15.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support for new FW API version;
* Fixes in SAR ACPI tables handling;
* Some debugging improvements;
* Fix in ROC;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: don't schedule the roc_done_wk if it is already running

Johannes Berg (5):
  iwlwifi: pcie: avoid dma unmap/remap in crash dump
  iwlwifi: fix __percpu annotation
  iwlwifi: api: remove datamember from struct
  iwlwifi: fw: fix debug dump data declarations
  iwlwifi: allow debug init in RF-kill

Luca Coelho (3):
  iwlwifi: bump FW API to 65 for AX devices
  iwlwifi: acpi: fill in WGDS table with defaults
  iwlwifi: acpi: fill in SAR tables with defaults

Mukesh Sisodiya (1):
  iwlwifi: yoyo: support for new DBGI_SRAM region

Shaul Triebitz (1):
  iwlwifi: add 'Rx control frame to MBSSID' HE capability

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 67 ++++++++++++-------
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 45 +++++++++++--
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 22 +++---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  1 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  7 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 31 +++++----
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  8 +--
 11 files changed, 135 insertions(+), 59 deletions(-)

-- 
2.33.0

