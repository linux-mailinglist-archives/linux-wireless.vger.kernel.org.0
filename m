Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC0A1B7A7B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgDXPs3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57870 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbgDXPs3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:29 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z0-000OY2-IF; Fri, 24 Apr 2020 18:48:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:06 +0300
Message-Id: <20200424154818.2657602-1-luca@coelho.fi>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.8 2020-04-24
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.8.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support new FW APIs;
* Remove some old and unused features;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: add support for range request command version 9

Emmanuel Grumbach (3):
  iwlwifi: remove antenna_coupling module parameter
  iwlwifi: mvm: stop supporting swcrypto and bt_coex_active module
    parameters
  iwlwifi: mvm: remove iwlmvm's tfd_q_hang_detect module parameter

Johannes Berg (1):
  iwlwifi: fw api: fix PHY data 2/3 position

Luca Coelho (1):
  iwlwifi: bump FW API to 55 for AX devices

Mordechay Goodstein (5):
  iwlwifi: yoyo: add support for parsing SHARED_MEM_ALLOC version 4
  iwlwifi: yoyo: use hweight_long instead of bit manipulating
  iwlwifi: yoyo: don't access TLV before verifying len
  iwlwifi: avoid debug max amsdu config overwriting itself
  iwlwifi: yoyo: add D3 resume timepoint

Shaul Triebitz (1):
  iwlwifi: mvm: set properly station flags in STA_HE_CTXT_CMD

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |   3 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  11 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |  14 ++-
 .../wireless/intel/iwlwifi/fw/api/location.h  | 110 ++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  14 +--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  50 +++++---
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |  14 ++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  44 ++++---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  11 +-
 .../wireless/intel/iwlwifi/iwl-modparams.h    |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  34 +++---
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  11 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  67 ++++++++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  56 +++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  11 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  15 +--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  16 +--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   9 +-
 25 files changed, 331 insertions(+), 218 deletions(-)

-- 
2.26.2

