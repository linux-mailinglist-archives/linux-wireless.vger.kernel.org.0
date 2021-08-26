Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA313F8F21
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 21:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbhHZTsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 15:48:40 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33406 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243446AbhHZTsk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 15:48:40 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJLLp-002XB4-4I; Thu, 26 Aug 2021 22:47:51 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 22:47:36 +0300
Message-Id: <20210826194748.826360-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH v2 00/12] iwlwifi: updates intended for v5.15 2021-08-20 v2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the seventh set of patches intended for v5.15.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support few new FW command versions;
* Ongoing work on support for Bz devices;
* Add new DHC framework to help with debugging of FW flows;
* Some other small fixes, clean-ups and improvements.

In v2:

* Make DHC Kconfig option depend on EXPERT;
* Convvert bit-based struct into direct bit operations;
* Fix small typo, s/resonder/responder/.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (2):
  iwlwifi: mvm: add support for range request command version 13
  iwlwifi: mvm: add support for responder config command version 9

Dror Moshe (1):
  iwlwifi: move get pnvm file name to a separate function

Gregory Greenman (1):
  iwlwifi: mvm: introduce iwl_stored_beacon_notif_v3

Ilan Peer (1):
  iwlwifi: mvm: Fix scan channel flags settings

Johannes Berg (1):
  iwlwifi: mvm: don't use FW key ID in beacon protection

Luca Coelho (2):
  iwlwifi: export DHC framework and add first public entry, twt_setup
  iwlwifi: mvm: add fixed_rate debugfs entry to public DHC

Matti Gottlieb (3):
  iwlwifi: Add support for getting rf id with blank otp
  iwlwifi: Add support for more BZ HWs
  iwlwifi: Start scratch debug register for Bz family

Shaul Triebitz (1):
  iwlwifi: mvm: support broadcast TWT alone

 drivers/net/wireless/intel/iwlwifi/Kconfig    |   6 +
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  23 +++
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +
 .../net/wireless/intel/iwlwifi/fw/api/dhc.h   | 132 ++++++++++++
 .../wireless/intel/iwlwifi/fw/api/location.h  | 189 +++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |  31 ++-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  40 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   7 +
 .../wireless/intel/iwlwifi/fw/error-dump.h    |   4 -
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |  20 ++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   3 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   7 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  36 ++++
 .../wireless/intel/iwlwifi/mvm/constants.h    |   5 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  87 ++++++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  46 +++++
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  85 ++++++--
 .../intel/iwlwifi/mvm/ftm-responder.c         |  27 ++-
 .../net/wireless/intel/iwlwifi/mvm/fw-api.h   |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  41 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  33 +++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  41 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 110 ++++++++++
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   8 +-
 29 files changed, 935 insertions(+), 84 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h

-- 
2.33.0

