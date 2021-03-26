Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8F34A591
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 11:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhCZKao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 06:30:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43292 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229798AbhCZKam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 06:30:42 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lPjjg-0003EY-0b; Fri, 26 Mar 2021 12:30:37 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Mar 2021 12:30:28 +0200
Message-Id: <20210326103035.206088-1-luca@coelho.fi>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH for v5.12 0/7] iwlwifi: fixes intended for v5.12 2021-03-26
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the first patchset with fixes for v5.12.

The changes are:

* A few locking fixes;
* Fix a workaround for devices of the 22000 family;
* Fix the position of a bit in the regulatory capabilities;
* Add support to some devices that were missing.

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the rc series, please take them directly to
wireless-drivers.git, as we agreed.  I'll assign them to you.

Cheers,
Luca.


Gregory Greenman (1):
  mvm: rfi: don't lock mvm->mutex when sending config command

Johannes Berg (3):
  iwlwifi: pcie: properly set LTR workarounds on 22000 devices
  iwlwifi: fw: fix notification wait locking
  iwlwifi: mvm: fix beacon protection checks

Luca Coelho (2):
  iwlwifi: fix 11ax disabled bit in the regulatory capability flags
  iwlwifi: pcie: add support for So-F devices

Matt Chen (1):
  iwlwifi: add support for Qu with AX201 device

 .../wireless/intel/iwlwifi/fw/notif-wait.c    | 10 +++---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  7 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c  |  6 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 17 ++++++---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 31 +---------------
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 27 +++++++++++++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 35 +++++++++++++++++++
 10 files changed, 90 insertions(+), 49 deletions(-)

-- 
2.31.0

