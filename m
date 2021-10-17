Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B331430983
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbhJQOCH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53928 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343772AbhJQOCH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hg-000Yi6-4X; Sun, 17 Oct 2021 16:59:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:44 +0300
Message-Id: <20211017135954.504836-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/10] iwlwifi: updates intended for v5.16 2021-10-17 part 4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Here's the fourth set of patches intended for v5.16.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some debugging improvements;
* Fix BT-coex priority;
* Improve PS-poll timeout detection;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Gregory Greenman (1):
  iwlwifi: mvm: improve log when processing CSA

Johannes Berg (3):
  iwlwifi: pcie: try to grab NIC access early
  iwlwifi: mvm: set BT-coex high priority for 802.1X/4-way-HS
  iwlwifi: pnvm: print out the version properly

Miri Korenblit (1):
  iwlwifi: mvm: Read acpi dsm to get channel activation bitmap

Rotem Saado (2):
  iwlwifi: dbg: treat dbgc allocation failure when tlv is missing
  iwlwifi: dbg: treat non active regions as unsupported regions

Sara Sharon (1):
  iwlwifi: mvm: set inactivity timeouts also for PS-poll

Yaara Baruch (2):
  iwlwifi: add new killer devices to the driver
  wlwifi: add new device id 7F70

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  8 ++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  3 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  3 ++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 23 +++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 ++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  8 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 18 ++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  6 +++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 28 ++++++-------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 41 +++++++++++++++++++
 14 files changed, 136 insertions(+), 24 deletions(-)

-- 
2.33.0

