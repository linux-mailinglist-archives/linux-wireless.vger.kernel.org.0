Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3B310779
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 10:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBEJNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 04:13:41 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43728 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230077AbhBEJHd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 04:07:33 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l7x4e-0044i1-K6; Fri, 05 Feb 2021 11:06:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  5 Feb 2021 11:06:30 +0200
Message-Id: <20210205090642.1553849-1-luca@coelho.fi>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [RESEND PATCH 00/12]  iwlwifi: updates intended for v5.12 2021-01-31
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

(resending because issues with spamcop seem to have prevented the
patches from reaching patchwork and possibly others)

Hi,

Here's the third set of patches intended for v5.12.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* One more CSA bug fix, this time in the AP side;
* Bump fW API support;
* Support for new So devices and a bit of reorg;
* Some other clean-ups and small fixes.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.

Emmanuel Grumbach (2):
  iwlwifi: mvm: cancel the scan delayed work when scan is aborted
  iwlwifi: mvm: fix CSA AP side

Ilan Peer (1):
  iwlwifi: pcie: Disable softirqs during Rx queue init

Johannes Berg (4):
  iwlwifi: mvm: advertise BIGTK client support if available
  iwlwifi: fw api: make hdr a zero-size array again
  iwlwifi: mvm: slightly clean up rs_fw_set_supp_rates()
  iwlwifi: mvm: make iwl_mvm_tt_temp_changed() static

Luca Coelho (5):
  iwlwifi: bump FW API to 60 for AX devices
  iwlwifi: move SnJ and So rules to the new tables
  iwlwifi: add support for SnJ with Jf devices
  iwlwifi: mvm: move early time-point before nvm_init in non-unified
  iwlwifi: pcie: add support for SnJ with Hr1

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  58 ++++++-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |   7 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  13 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 116 ++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  19 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 141 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  36 ++---
 15 files changed, 325 insertions(+), 95 deletions(-)

-- 
2.30.0

