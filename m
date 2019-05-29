Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA102DE9D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfE2NkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 09:40:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54338 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726863AbfE2NkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 09:40:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVyoD-00080o-0f; Wed, 29 May 2019 16:40:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 0/7] wlwifi: fixes intended for 5.2 2019-05-29
Date:   Wed, 29 May 2019 16:39:48 +0300
Message-Id: <20190529133955.31082-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the first patchset with fixes for 5.2.

The changes are:

* Fix rfkill bug with newer devices;
* Fix a potential double-free;
* Remove an obsolete debugfs file that, when used with new devices ,
  caused an oops;
* Fix a sleep with a spinlock held;
* Use the correct firmware when using a Killer NIC;
* Fix PCI persistence register for newer families;
* Print a firmware-related ID to help debug mismatch issues;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: fix load in rfkill flow for unified firmware

Jia-Ju Bai (1):
  iwlwifi: Fix double-free problems in iwl_req_fw_callback()

Johannes Berg (1):
  iwlwifi: mvm: remove d3_sram debugfs file

Lior Cohen (1):
  iwlwifi: mvm: change TLC config cmd sent by rs to be async

Matt Chen (1):
  iwlwifi: fix AX201 killer sku loading firmware issue

Shahar S Matityahu (2):
  iwlwifi: clear persistence bit according to device family
  iwlwifi: print fseq info upon fw assert

 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 39 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  2 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 22 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 22 -------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 57 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 23 ++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 20 ++++---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +
 .../wireless/intel/iwlwifi/pcie/internal.h    |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 53 ++++++++++++-----
 14 files changed, 136 insertions(+), 116 deletions(-)

-- 
2.20.1

