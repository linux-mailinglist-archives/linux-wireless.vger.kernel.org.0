Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D82D130EF1
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgAFIzK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:10 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51346 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgAFIzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:10 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAG-0007qa-6B; Mon, 06 Jan 2020 10:55:08 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:50 +0200
Message-Id: <20200106085502.363205-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.6 2020-01-06
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.6.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support new version of the beacon template FW API;
* Print some extra information when the driver is loaded;
* Some debugging infrastructure (aka. yoyo) updates;
* Support for a new HW version;
* Second phase of device configuration work started;
* Some clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Andrei Otcheretianski (1):
  iwlwifi: mvm: Update BEACON_TEMPLATE_CMD firmware API

Johannes Berg (3):
  iwlwifi: incorporate firmware filename into version
  iwlwifi: mvm: print out extended secboot status before dump
  iwlwifi: prph: remove some unused register definitions

Luca Coelho (7):
  iwlwifi: yoyo: don't allow changing the domain via debugfs
  iwlwifi: yoyo: remove unnecessary active triggers status flag
  iwlwifi: yoyo: remove the iwl_dbg_tlv_gen_active_trigs() function
  iwlwifi: yoyo: check for the domain on all TLV types during init
  iwlwifi: assume the driver_data is a trans_cfg, but allow full cfg
  iwlwifi: implement a new device configuration table
  iwlwifi: add device name to device_info

Oren Givon (1):
  iwlwifi: add new iwlax411 struct for type SoSnj

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  10 ++
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   5 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  29 +---
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  13 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  14 ++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  65 +++-----
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  26 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  10 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   4 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  27 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 156 ++++++++++++------
 19 files changed, 217 insertions(+), 172 deletions(-)

-- 
2.24.1

