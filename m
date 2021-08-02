Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BFC3DDAFA
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhHBO2m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:28:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50900 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233940AbhHBO2m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:28:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYvd-001xts-Dd; Mon, 02 Aug 2021 17:28:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:28:17 +0300
Message-Id: <20210802142829.109448-1-luca@coelho.fi>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.15 2021-08-02 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.15.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* A bunch of janitorial clean-ups;
* Clean-ups in the TX code;
* Small fix for SMPS; 
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Johannes Berg (5):
  iwlwifi: mvm: set replay counter on key install
  iwlwifi: mvm: restrict FW SMPS request
  iwlwifi: mvm: avoid static queue number aliasing
  iwlwifi: mvm: clean up number of HW queues
  iwlwifi: mvm: treat MMPDUs in iwl_mvm_mac_tx() as bcast

Luca Coelho (2):
  iwlwifi: pcie: remove spaces from queue names
  iwlwifi: mvm: remove check for vif in iwl_mvm_vif_from_mac80211()

Mordechay Goodstein (1):
  iwlwifi: mvm: remove trigger EAPOL time event

Tom Rix (1):
  iwlwifi: remove trailing semicolon in macro definition

Wei Yongjun (1):
  iwlwifi: mvm: fix old-style static const declaration

Zhang Qilong (1):
  iwlwifi: mvm: fix a memory leak in iwl_mvm_mac_ctxt_beacon_changed

Zheng Yongjun (1):
  iwlwifi: use DEFINE_MUTEX() for mutex lock

 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/coex.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 27 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 35 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 83 ++++++++++++++++---
 .../wireless/intel/iwlwifi/pcie/internal.h    | 10 +--
 10 files changed, 121 insertions(+), 50 deletions(-)

-- 
2.32.0

