Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331B04A2E16
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiA2LQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:27 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37868 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233626AbiA2LQ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:26 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDliR-0002ji-8Y;
        Sat, 29 Jan 2022 13:16:24 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:10 +0200
Message-Id: <20220129111622.678447-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.18 2022-01-29
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.18.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support a few new FW API command versions;
* Some debugging infra fixes;
* A few fixes in the HE functionality;
* Add a few new devices;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Johannes Berg (2):
  iwlwifi: mvm: align locking in D3 test debugfs
  iwlwifi: mvm: support v3 of station HE context command

Luca Coelho (1):
  iwlwifi: mvm: don't iterate unadded vifs when handling FW SMPS req

Miri Korenblit (1):
  iwlwifi: mvm: add support for CT-KILL notification version 2

Mordechay Goodstein (3):
  iwlwifi: dbg: add infra for tracking free buffer size
  iwlwifi: mvm: only enable HE DCM if we also support TX
  iwlwifi: advertise support for HE - DCM BPSK RX/TX

Mukesh Sisodiya (1):
  iwlwifi: yoyo: add IMR DRAM dump support

Rotem Saado (3):
  iwlwifi: yoyo: fix DBGI_SRAM ini dump header.
  iwlwifi: yoyo: fix DBGC allocation flow
  iwlwifi: yoyo: remove DBGI_SRAM address reset writing

Yaara Baruch (1):
  iwlwifi: pcie: add support for MS devices

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  29 +++
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   | 127 +++++++++-
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |  16 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 216 +++++++++++++++---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   6 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |  19 ++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  34 +++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  30 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  86 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   5 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  25 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  24 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  28 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  42 +++-
 20 files changed, 642 insertions(+), 80 deletions(-)

-- 
2.34.1

