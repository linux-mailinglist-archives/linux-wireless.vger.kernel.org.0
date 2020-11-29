Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C224C2C7955
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 14:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgK2NPc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 08:15:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33394 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727357AbgK2NPb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 08:15:31 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjMXM-0035gF-4n; Sun, 29 Nov 2020 15:14:44 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 15:14:30 +0200
Message-Id: <20201129131442.1857561-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.11 2020-11-29
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.11.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* A few fixes and improvements in the FW debugging framework;
* A fix in the HE capabilities settings;
* Small fix in the logs for SAR;
* Move queue code to a common place;
* Some other clean-ups and small fixes;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: set station HE capabilities before authentication

Emmanuel Grumbach (3):
  cfg80211: flush scan entries upon suspend
  iwlwifi: mvm: remove the read_nvm from iwl_run_init_mvm_ucode
  iwlwifi: pcie: remove obsolete pre-release support code

Janie Tu (1):
  iwlwifi: mvm: fix sar profile printing issue

Johannes Berg (1):
  iwlwifi: update MAINTAINERS entry

Mordechay Goodstein (4):
  iwlwifi: remove all queue resources before free
  iwlwifi: yoyo: add the ability to dump phy periphery
  iwlwifi: move reclaim flows to the queue file
  iwlwifi: mvm: Init error table memory to zero

Naftali Goldstein (1):
  iwlwifi: d3: do not send the WOWLAN_CONFIGURATION command for
    netdetect

Rotem Saado (1):
  iwlwifi: yoyo: align the write pointer to DWs

 MAINTAINERS                                   |   3 -
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  82 +++++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  14 -
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  16 --
 .../wireless/intel/iwlwifi/pcie/internal.h    |   4 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  81 +-----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 199 +-------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 254 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |   7 +
 include/net/cfg80211.h                        |   6 +
 net/wireless/sysfs.c                          |   2 +
 18 files changed, 381 insertions(+), 331 deletions(-)

-- 
2.29.2

