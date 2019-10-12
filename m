Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D6CD50FB
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfJLQ3b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:29:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48732 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727423AbfJLQ3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:29:31 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGm-00062r-VA; Sat, 12 Oct 2019 19:29:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:11 +0300
Message-Id: <20191012162924.19848-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 00/13] iwlwifi: updates intended for v5.5 2019-10-12-2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.5.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some udpdates to FW API commands;
* Fix max amsdu value calculation;
* Small updates in the debugging infra;
* Some new helper functions;
* A few clean-ups;
* Other small fixes and improvements;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: mvm: use the new session protection command

Haim Dreyfuss (1):
  iwlwifi: mvm: add support for new version for D0I3_END_CMD

Johannes Berg (2):
  iwlwifi: mvm: remove leftover rs_remove_sta_debugfs() prototype
  iwlwifi: dbg: prefer struct copy to memcpy()

Lior Cohen (1):
  iwlwifi: mvm: add notification for missed VAP

Mordechay Goodstein (1):
  iwlwifi: mvm: consider ieee80211 station max amsdu value

Shahar S Matityahu (2):
  iwlwifi: dbg_ini: add user trigger support
  iwlwifi: dbg_ini: use vzalloc to allocate dumping memory regions

Tova Mussai (4):
  iwlwifi: mvm: create function to convert nl80211 band to phy band
  iwlwifi: mvm: Invert the condition for OFDM rate
  iwlwifi: nvm: create function to convert channel index to nl80211_band
  iwlwifi: rx: use new api to get band from rx mpdu

YueHaibing (1):
  iwlwifi: mvm: fix old-style declaration

 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |   8 +
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  33 ++-
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |   5 +
 .../intel/iwlwifi/fw/api/time-event.h         |  80 +++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  15 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  26 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  29 ++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   3 +
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  30 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  40 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  34 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  31 +++
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |   4 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  23 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  20 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 189 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  14 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   2 +-
 21 files changed, 552 insertions(+), 66 deletions(-)

-- 
2.23.0

