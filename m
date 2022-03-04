Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792044CD340
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiCDLWY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiCDLWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:23 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F705137776
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:35 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ601-000QSW-Vv;
        Fri, 04 Mar 2022 13:21:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:16 +0200
Message-Id: <20220304112129.219513-1-luca@coelho.fi>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 00/13]  iwlwifi: updates intended for v5.18 2022-03-04
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the seventh set of patches intended for v5.18.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Mostly debugging infra changes;
* Some more work on the Bz family of devices;
* Bump the FW API twice;
* Some other small fixes, clean-ups and improvements.

There are two FW API dumps here.  We have loads of patches going to
v5.18, so we actually bumped the FW API version supported quite a bit.
I was debating whether to do the bump in one go, but since we're not
sure whether FW API version 72 will be released publicly, I decided to
keep it in two patches for easier reverting.  Even if we do end up
releasing version 72 (which we probably will), it's still easier to
bisect if we bump twice, in different patches.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ayala Barazani (2):
  iwlwifi: mvm: add a flag to reduce power command.
  iwlwifi: Configure FW debug preset via module param.

Johannes Berg (3):
  iwlwifi: mvm: remove cipher scheme support
  iwlwifi: pcie: fix SW error MSI-X mapping
  iwlwifi: use 4k queue size for Bz A-step

Luca Coelho (2):
  iwlwifi: bump FW API to 71 for AX devices
  iwlwifi: bump FW API to 72 for AX devices

Matt Chen (1):
  iwlwifi: acpi: move ppag code from mvm to fw/acpi

Mordechay Goodstein (2):
  iwlwifi: dbg: in sync mode don't call schedule
  iwlwifi: dbg: check trigger data before access

Mukesh Sisodiya (3):
  iwlwifi: yoyo: disable IMR DRAM region if IMR is disabled
  iwlwifi: mvm: add support for IMR based on platform
  iwlwifi: yoyo: dump IMR DRAM only for HW and FW error

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  19 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 211 ++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  28 +++
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  27 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  34 ++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  28 ---
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  12 -
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   5 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  69 +++---
 .../wireless/intel/iwlwifi/iwl-modparams.h    |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 221 +++---------------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  33 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 -
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   3 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |   4 +
 20 files changed, 412 insertions(+), 306 deletions(-)

-- 
2.35.1

