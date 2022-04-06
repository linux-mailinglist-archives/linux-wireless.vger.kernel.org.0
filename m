Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EC34F63D7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiDFPi7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiDFPhs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:37:48 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961BC4E387
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:52:16 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nc4TV-000pov-AS;
        Wed, 06 Apr 2022 15:09:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net, kvalo@kernel.org
Cc:     luca@coelho.fi, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed,  6 Apr 2022 15:09:17 +0300
Message-Id: <20220406120924.979792-1-luca@coelho.fi>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 0/7] cfg80211/mac80211: updates intended for v5.19 2022-04-06
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here are some patches that implement time measurement timestamps in
cfg80211 and mac80211.  Then there is an iwlwifi patch on top that
depends on them.

Since we have a single tree now, I sent the series with both cfg/mac
and iwlwifi patches.  Let me know if you prefer to have them
separately.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
I will report if there are any issues.

Please review.

Cheers,
Luca.


Avraham Stern (7):
  nl80211: add RX and TX timestamp attributes
  cfg80211: add a function for reporting TX status with hardware
    timestamps
  cfg80211/nl80211: move rx management data into a struct
  cfg80211: add hardware timestamps to frame RX info
  ieee80211: add helper functions for detecting TM/FTM frames
  mac80211: add hardware timestamps for RX and TX
  iwlwifi: mvm: report hardware timestamps in RX/TX status

 .../wireless/intel/iwlwifi/fw/api/commands.h  |  20 +-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 126 ++++++++++++-
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   8 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  12 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   6 +
 .../wireless/intel/iwlwifi/mvm/time-sync.c    | 172 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/time-sync.h    |  30 +++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 include/linux/ieee80211.h                     |  54 ++++++
 include/net/cfg80211.h                        | 111 ++++++++++-
 include/net/mac80211.h                        |  30 ++-
 include/uapi/linux/nl80211.h                  |  27 ++-
 net/mac80211/rx.c                             |  32 +++-
 net/mac80211/status.c                         |  40 +++-
 net/wireless/mlme.c                           |  21 +--
 net/wireless/nl80211.c                        |  69 ++++---
 net/wireless/nl80211.h                        |   5 +-
 net/wireless/trace.h                          |   8 +-
 21 files changed, 713 insertions(+), 75 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/time-sync.h

-- 
2.35.1

