Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD2129BDB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2019 00:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLWXrc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 18:47:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54690 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726512AbfLWXrc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 18:47:32 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ijXQ9-00010j-B6; Tue, 24 Dec 2019 01:47:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 24 Dec 2019 01:47:14 +0200
Message-Id: <20191223234721.1513938-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 0/7] iwlwifi: fixes intended for 5.5 2019-12-24
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is my second patchset with fixes for v5.5.  This time I have 6
important fixes and one simple dependency patch.

The changes are:

* Fix a couple of potential memory leaks in TXQ code;
* Disable L0S states in all hardware since our hardware doesn't
  officially support them anymore (and older versions of the hardware
  had instability in these states);
* Remove lar_disable parameter since it has been causing issues for
  some people who erroneously disable it;
* Force the debug monitor HW to stop also when debug is disabled,
  since it sometimes stays on and prevents low system power states;

As usual, I'm pushing this to a pending branch, for kbuild bot.  I'm
going to send a pull-request for this ones together of the previous
batch I sent.

Cheers,
Luca.


Johannes Berg (2):
  iwlwifi: mvm: fix SKB leak on invalid queue
  iwlwifi: mvm: fix potential SKB leak on TXQ TX

Luca Coelho (4):
  iwlwifi: pcie: rename L0S_ENABLED bit to L0S_DISABLED
  iwlwifi: pcie: always disable L0S states
  iwlwifi: remove lar_disable module parameter
  iwlwifi: fw: make pos static in iwl_sar_get_ewrd_table() loop

Shahar S Matityahu (1):
  iwlwifi: dbg: force stop the debug monitor HW

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 10 +++----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  7 +----
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  3 --
 .../wireless/intel/iwlwifi/iwl-modparams.h    |  2 --
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 13 +++++----
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 28 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  | 10 ++-----
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  6 ++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 15 ++++------
 12 files changed, 44 insertions(+), 62 deletions(-)

-- 
2.24.0

