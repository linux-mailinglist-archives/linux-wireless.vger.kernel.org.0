Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133814A97AB
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348078AbiBDKZR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37952 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236036AbiBDKZR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:17 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmE-0005zM-9e;
        Fri, 04 Feb 2022 12:25:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:24:59 +0200
Message-Id: <20220204102511.606112-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.18 2022-02-04
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.18.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* W=1 warnings clean up continues;
* Some improvements and fixes in scanning;
* More work on the Bz family of devices;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ilan Peer (4):
  iwlwifi: mvm: Correctly set fragmented EBS
  iwlwifi: scan: Modify return value of a function
  iwlwifi: mvm: Passively scan non PSC channels only when requested so
  iwlwifi: mvm: Unify the scan iteration functions

Johannes Berg (6):
  iwlwifi: pcie: adjust to Bz completion descriptor
  iwlwifi: drv: load tlv debug data earlier
  iwlwifi: eeprom: clean up macros
  iwlwifi: remove unused macros
  iwlwifi: debugfs: remove useless double condition
  iwlwifi: mei: use C99 initializer for device IDs

Matti Gottlieb (1):
  iwlwifi: pcie: Adapt rx queue write pointer for Bz family

Mukesh Sisodiya (1):
  iwlwifi: yoyo: Avoid using dram data if allocation failed

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 -
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   3 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   3 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  13 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   4 +-
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c  |  12 +-
 .../net/wireless/intel/iwlwifi/iwl-phy-db.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 129 ++++++++++--------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  20 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  65 ++++++---
 14 files changed, 154 insertions(+), 116 deletions(-)

-- 
2.34.1

