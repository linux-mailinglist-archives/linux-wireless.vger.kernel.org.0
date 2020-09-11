Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970E2667E6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgIKRzG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:55:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50284 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726103AbgIKRzF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:55:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6H-0028eU-TG; Fri, 11 Sep 2020 20:44:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:28 +0300
Message-Id: <20200911174439.163225-1-luca@coelho.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/11] iwlwifi: updates intended for v5.10 2020-09-11
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.10.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Protected TWT implementation;
* Support for some new cards;
* Support disabling 5.8GHz channels via ACPI;
* Support VHT extended NSS capability;
* A few fixes in the datapath;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: add an option to add PASN station

Gil Adam (1):
  iwlwifi: acpi: evaluate dsm to disable 5.8GHz channels

Ihab Zhaika (1):
  iwlwifi: add new cards for AX201 family

Johannes Berg (1):
  iwlwifi: mvm: rs-fw: handle VHT extended NSS capability

Mordechay Goodstein (4):
  iwlwifi: sta: defer ADDBA transmit in case reclaimed SN != next SN
  iwlwifi: msix: limit max RX queues for 9000 family
  iwlwifi: wowlan: adapt to wowlan status API version 10
  iwlwifi: fw: move assert descriptor parser to common code

Shaul Triebitz (3):
  iwlwifi: mvm: add PROTECTED_TWT firmware API
  iwlwifi: mvm: set PROTECTED_TWT in MAC data policy
  iwlwifi: mvm: set PROTECTED_TWT feature if supported by firmware

 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 17 ++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 14 ++++
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   | 16 ++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.c   | 44 +++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  6 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  3 +-
 .../intel/iwlwifi/mvm/ftm-responder.c         | 78 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 81 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 12 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 10 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 24 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 51 ++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 +
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 44 +---------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 15 ++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  6 +-
 21 files changed, 351 insertions(+), 88 deletions(-)

-- 
2.28.0

