Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B894127A52
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLTL4p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:56:45 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:53944 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfLTL4o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:44 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGte-0007ip-HN; Fri, 20 Dec 2019 13:56:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:28 +0200
Message-Id: <20191220115638.1299888-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 00/10] iwlwifi: fixes intended for 5.5 2019-12-20
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is my first patchset with fixes for v5.5.  This time I have 8
important fixes plus a couple of dependency-patches.

The changes are:

* Don't send the PPAG command when PPAG is disabled, since it can
  cause problems;
* A few fixes for a HW bug;
* A fix for RS offload;
* A fix for 3168 devices where the NVM tables where the wrong tables
  were being read.

As usual, I'm pushing this to a pending branch, for kbuild bot.  I'm
going to send a pull-request for this ones.  I have a bit more patches
to send too, which I'll then include inthe same pull-request.

Cheers,
Luca.


Gil Adam (1):
  iwlwifi: don't send PPAG command if disabled

Haim Dreyfuss (1):
  iwlwifi: Don't ignore the cap field upon mcc update

Johannes Berg (6):
  iwlwifi: pcie: move page tracking into get_page_hdr()
  iwlwifi: pcie: work around DMA hardware bug
  iwlwifi: pcie: detect the DMA bug and warn if it happens
  iwlwifi: pcie: allocate smaller dev_cmd for TX headers
  iwlwifi: mvm: report TX rate to mac80211 directly for RS offload
  iwlwifi: pcie: extend hardware workaround to context-info

Luca Coelho (2):
  iwlwifi: fix TLV fragment allocation loop
  iwlwifi: mvm: fix NVM check for 3168 devices

 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   9 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  48 +++-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   6 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  10 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  26 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 129 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  15 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  45 +++-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  19 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  32 ++-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 208 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  68 ++++--
 15 files changed, 521 insertions(+), 107 deletions(-)

-- 
2.24.0

