Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E7DD7AB
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfJSJjK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50388 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725810AbfJSJjK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:10 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCW-0002fy-6G; Sat, 19 Oct 2019 12:39:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:50 +0300
Message-Id: <20191019093902.29823-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.5 2019-19
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.5.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Update scan FW API;
* Fix single antenna diversity support;
* Bump the supported FW API version;
* Add debug dump collection on assert in WoWLAN;
* Fix VHT capabilities settings;
* A few clean-ups;
* Other small fixes and improvements;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: pcie: make iwl_pcie_gen2_update_byte_tbl static

Johannes Berg (1):
  iwlwifi: FW API: reference enum in docs of modify_mask

Luca Coelho (3):
  iwlwifi: mvm: fix support for single antenna diversity
  iwlwifi: mvm: remove else-if in iwl_send_phy_cfg_cmd()
  iwlwifi: bump FW API to 51 for 22000 series

Mordechay Goodstein (2):
  iwlwifi: mvm: in VHT connection use only VHT capabilities
  iwlwifi: mvm: print rate_n_flags in a pretty format

Shahar S Matityahu (1):
  iwlwifi: dbg_ini: support dump collection upon assert during D3

Tova Mussai (4):
  iwlwifi: nvm: update iwl_uhb_nvm_channels
  iwlwifi: scan: create function for scan scheduling params
  iwlwifi: scan: Create function to build scan cmd
  iwlwifi: scan: adapt the code to use api ver 11

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 157 ++++++++++
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  10 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  18 ++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 293 +++++++++++++++---
 .../wireless/intel/iwlwifi/pcie/internal.h    |   3 -
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   6 +-
 14 files changed, 477 insertions(+), 71 deletions(-)

-- 
2.23.0

