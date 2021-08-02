Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0293DDAC4
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhHBOUz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:20:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50884 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234286AbhHBOUf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:20:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYdU-001xoA-Lw; Mon, 02 Aug 2021 17:09:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:09:32 +0300
Message-Id: <20210802140944.90143-1-luca@coelho.fi>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.15 2021-08-02
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.15.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support scanning hidden 6GHz networks;
* Some improvements in the FW error dumps;
* Add some HE capability flags;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ilan Peer (2):
  iwlwifi: mvm: Do not use full SSIDs in 6GHz scan
  iwlwifi: mvm: Add support for hidden network scan on 6GHz band

Johannes Berg (6):
  iwlwifi: nvm: enable IEEE80211_HE_PHY_CAP10_HE_MU_M1RU_MAX_LTF
  iwlwifi: mvm: avoid FW restart while shutting down
  iwlwifi: pcie: optimise struct iwl_rx_mem_buffer layout
  iwlwifi: pcie: free RBs during configure
  iwlwifi: prepare for synchronous error dumps
  iwlwifi: pcie: dump error on FW reset handshake failures

Luca Coelho (1):
  iwlwifi: print PNVM complete notification status in hexadecimal

Mordechay Goodstein (2):
  iwlwifi: iwl-nvm-parse: set STBC flags for HE phy capabilities
  iwlwifi: iwl-dbg-tlv: add info about loading external dbg bin

Shaul Triebitz (1):
  iwlwifi: mvm: set BROADCAST_TWT_SUPPORTED in MAC policy

 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 97 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  7 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 30 +++---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  | 24 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  8 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  8 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 24 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 99 +++++++++++++++----
 .../wireless/intel/iwlwifi/pcie/internal.h    | 14 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 17 +++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 11 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  3 +
 19 files changed, 256 insertions(+), 110 deletions(-)

-- 
2.32.0

