Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45394A357B
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 10:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346817AbiA3JxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 04:53:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37894 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229782AbiA3JxK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 04:53:10 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nE6tP-0003JO-Ly;
        Sun, 30 Jan 2022 11:53:08 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 30 Jan 2022 11:52:54 +0200
Message-Id: <20220130095306.790573-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.18 2022-01-30
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the third set of patches intended for v5.18.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* A bunch of fixes for W=1 and W=3 warnings;
* Add support for a couple of new devices;
* Fix a potential buffer underflow;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Abhishek Naik (1):
  iwlwifi: nvm: Correct HE capability

Andrei Otcheretianski (1):
  iwlwifi: pcie: make sure iwl_rx_packet_payload_len() will not
    underflow

Johannes Berg (6):
  iwlwifi: fw: make dump_start callback void
  iwlwifi: move symbols into a separate namespace
  iwlwifi: dbg-tlv: clean up iwl_dbg_tlv_update_drams()
  iwlwifi: avoid variable shadowing
  iwlwifi: make some functions friendly to sparse
  iwlwifi: mei: avoid -Wpointer-arith and -Wcast-qual warnings

Luca Coelho (2):
  iwlwifi: read and print OTP minor version
  iwlwifi: remove unused DC2DC_CONFIG_CMD definitions

Mike Golant (1):
  iwlwifi: add support for BZ-U and BZ-L HW

Miri Korenblit (1):
  iwlwifi: mvm: use debug print instead of WARN_ON()

 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  1 +
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  8 -----
 .../wireless/intel/iwlwifi/fw/api/config.h    | 33 -------------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  5 ++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 --
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 33 +++++++++++--------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   | 18 +++++-----
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 11 +++++--
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  2 ++
 drivers/net/wireless/intel/iwlwifi/mei/main.c |  4 +--
 drivers/net/wireless/intel/iwlwifi/mei/net.c  |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  6 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  6 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  6 ++--
 drivers/net/wireless/intel/iwlwifi/queue/tx.h | 10 +++---
 20 files changed, 66 insertions(+), 93 deletions(-)

-- 
2.34.1

