Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA991430784
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245164AbhJQJmf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53634 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245081AbhJQJme (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2eS-000YUg-Rf; Sun, 17 Oct 2021 12:40:21 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:07 +0300
Message-Id: <20211017094019.442271-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.16 2021-10-17 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.16.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Small fix in TDLS;
* Code to sanitize firmware dumps;
* Updates for new FW rate and flags format;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.



Johannes Berg (6):
  iwlwifi: fix fw/img.c license statement
  iwlwifi: api: fix struct iwl_wowlan_status_v7 kernel-doc
  iwlwifi: mvm: correct sta-state logic for TDLS
  iwlwifi: fw dump: add infrastructure for dump scrubbing
  iwlwifi: parse debug exclude data from firmware file
  iwlwifi: mvm: scrub key material in firmware dumps

Miri Korenblit (5):
  iwlwifi: mvm: update definitions due to new rate & flags
  iwlwifi: mvm: add definitions for new rate & flags
  iwlwifi: mvm: convert old rate & flags to the new format.
  iwlwifi: mvm: Support version 3 of tlc_update_notif.
  iwlwifi: mvm: Support new version of ranging response notification

Mukesh Sisodiya (1):
  iwlwifi: yoyo: fw debug config from context info and preset

 drivers/net/wireless/intel/iwlwifi/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |   2 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  57 ++++
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  18 ++
 .../wireless/intel/iwlwifi/fw/api/location.h  |   7 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 229 +++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  44 ++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   9 +
 drivers/net/wireless/intel/iwlwifi/fw/img.c   |  53 +---
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  10 +
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   6 +-
 .../net/wireless/intel/iwlwifi/fw/paging.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    | 252 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   5 +
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 158 ++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  43 +++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  30 ++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 171 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 183 ++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  12 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 145 ++++------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |  12 -
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  78 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  27 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   4 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  12 +-
 35 files changed, 1249 insertions(+), 381 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/rs.c

-- 
2.33.0

