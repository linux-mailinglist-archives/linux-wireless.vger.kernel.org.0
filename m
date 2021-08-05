Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5FB3E1272
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhHEKTw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:19:52 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51194 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240012AbhHEKTw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:52 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTP-00240Q-2s; Thu, 05 Aug 2021 13:19:36 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:22 +0300
Message-Id: <20210805101934.431479-1-luca@coelho.fi>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.15 2021-08-05
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.15.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* A bunch of changes in the D3 code, including new FW API;
* Finalize the refactoring of 6GHz scan;
* Initial changes in the SAR profile code;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: silently drop encrypted frames for unknown station

Ilan Peer (1):
  iwlwifi: mvm: Refactor setting of SSIDs for 6GHz scan

Johannes Berg (7):
  iwlwifi: mvm: d3: separate TKIP data from key iteration
  iwlwifi: mvm: d3: remove fixed cmd_flags argument
  iwlwifi: mvm: d3: refactor TSC/RSC configuration
  iwlwifi: mvm: d3: add separate key iteration for GTK type
  iwlwifi: mvm: d3: make key reprogramming iteration optional
  iwlwifi: mvm: d3: implement RSC command version 5
  iwlwifi: mvm: fix access to BSS elements

Luca Coelho (3):
  iwlwifi: rename ACPI_SAR_NUM_CHAIN_LIMITS to ACPI_SAR_NUM_CHAINS
  iwlwifi: convert flat SAR profile table to a struct version
  iwlwifi: remove ACPI_SAR_NUM_TABLES definition

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  36 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  16 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   3 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 575 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 104 +---
 9 files changed, 494 insertions(+), 277 deletions(-)

-- 
2.32.0

