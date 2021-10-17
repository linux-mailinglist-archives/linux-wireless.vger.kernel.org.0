Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B0430745
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbhJQIqB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53544 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234310AbhJQIqB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1ll-000YRM-Ml; Sun, 17 Oct 2021 11:43:50 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:38 +0300
Message-Id: <20211017084348.401570-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/10] iwlwifi: updates intended for v5.16 2021-10-17
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.16.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support for 160MHz in ranging measurements;
* Some fixes in HE capabilities;
* Fixes in vendor specific capabilities;
* Add the PC of both processors in error dumps;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: add support for 160Mhz in ranging measurements

Johannes Berg (7):
  iwlwifi: mvm: fix ieee80211_get_he_iftype_cap() iftype
  iwlwifi: mvm: disable RX-diversity in powersave
  iwlwifi: add vendor specific capabilities for some RFs
  iwlwifi: add some missing kernel-doc in struct iwl_fw
  iwlwifi: api: remove unused RX status bits
  iwlwifi: remove MODULE_AUTHOR() statements
  iwlwifi: remove contact information

Miri Korenblit (1):
  iwlwifi: mvm: Remove antenna c references

Mordechay Goodstein (1):
  iwlwifi: mvm: add lmac/umac PC info in case of error

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |  5 ---
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |  5 ---
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  5 ---
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  5 ---
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  |  4 ---
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |  5 ---
 .../net/wireless/intel/iwlwifi/dvm/devices.c  |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/led.c  |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/led.h  |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |  5 ---
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  6 ----
 .../net/wireless/intel/iwlwifi/dvm/power.c    |  4 ---
 .../net/wireless/intel/iwlwifi/dvm/power.h    |  4 ---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/rs.h   |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c |  4 ---
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c  |  5 ---
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c   |  4 ---
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h   |  4 ---
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |  5 ---
 .../net/wireless/intel/iwlwifi/dvm/ucode.c    |  5 ---
 .../wireless/intel/iwlwifi/fw/api/location.h  |  3 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  5 +--
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    | 19 ++----------
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.c   |  5 ---
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  2 ++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 -
 .../net/wireless/intel/iwlwifi/iwl-debug.h    |  5 ---
 .../intel/iwlwifi/iwl-devtrace-data.h         |  5 ---
 .../wireless/intel/iwlwifi/iwl-devtrace-io.h  |  5 ---
 .../intel/iwlwifi/iwl-devtrace-iwlwifi.h      |  5 ---
 .../wireless/intel/iwlwifi/iwl-devtrace-msg.h |  5 ---
 .../intel/iwlwifi/iwl-devtrace-ucode.h        |  5 ---
 .../net/wireless/intel/iwlwifi/iwl-devtrace.c |  5 ---
 .../net/wireless/intel/iwlwifi/iwl-devtrace.h |  5 ---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  3 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 17 ++++++++++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  7 ++---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 12 +++++++
 .../intel/iwlwifi/mvm/ftm-responder.c         | 15 +++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 18 +++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 -
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  4 ---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 31 +++++--------------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |  5 ---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 13 +++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  4 +++
 55 files changed, 85 insertions(+), 248 deletions(-)

-- 
2.33.0

