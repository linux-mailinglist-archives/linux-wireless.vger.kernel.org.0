Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA151ADADB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgDQKVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:21:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56556 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728631AbgDQKVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO84-000Kba-FT; Fri, 17 Apr 2020 13:21:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:32 +0300
Message-Id: <20200417102142.2173014-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/10] iwlwifi: updates intended for v5.8 2020-04-17
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.8.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* TX queue debugfs improvements;
* Support for a few new FW API versions;
* Remove deprecated scan FW API version;
* More debugging fetures;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Johannes Berg (4):
  iwlwifi: pcie: use seq_file for tx_queue debugfs file
  iwlwifi: pcie: add n_window/ampdu to tx_queue debugfs
  iwlwifi: pcie: gen2: minor code cleanups in byte table update
  iwlwifi: mvm: add DCM flag to rate pretty-print

Mordechay Goodstein (2):
  iwlwifi: move API version lookup to common code
  iwlwifi: support version 9 of WOWLAN_GET_STATUS notification

Shahar S Matityahu (2):
  iwlwifi: dbg: support multiple dumps in legacy dump flow
  iwlwifi: yoyo: support IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT time
    point

Tova Mussai (2):
  iwlwifi: scan: remove support for fw scan api v13
  iwlwifi: nvm: use iwl_nl80211_band_from_channel_idx

 drivers/net/wireless/intel/iwlwifi/Makefile   |   3 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  39 ++++-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  26 ----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 139 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  11 --
 drivers/net/wireless/intel/iwlwifi/fw/img.c   | 100 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  19 +--
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  14 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  29 ++--
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   4 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  24 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  44 +-----
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 122 +++++++++++----
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   8 +-
 20 files changed, 375 insertions(+), 228 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/img.c

-- 
2.25.1

