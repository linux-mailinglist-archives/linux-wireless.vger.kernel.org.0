Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A483AAD0A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFQHLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:11:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47864 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229515AbhFQHLD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm8y-001XeC-KL; Thu, 17 Jun 2021 10:08:54 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:40 +0300
Message-Id: <20210617070852.496985-1-luca@coelho.fi>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.14 2021-06-17
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.14.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support UNII4 enablement from BIOS;
* Support LMR feedback;
* Fix in TWT;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Abhishek Naik (1):
  iwlwifi: mvm: Read acpi dsm to get unii4 enable/disable bitmap.

Avraham Stern (1):
  iwlwifi: mvm: support LMR feedback

Harish Mitty (1):
  iwlwifi: mvm: Call NMI instead of REPLY_ERROR

Johannes Berg (7):
  iwlwifi: pcie: identify the RF module
  iwlwifi: mvm: don't request SMPS in AP mode
  iwlwifi: mvm: apply RX diversity per PHY context
  iwlwifi: mvm: honour firmware SMPS requests
  iwlwifi: correct HE capabilities
  iwlwifi: pcie: fix some kernel-doc comments
  iwlwifi: pcie: remove TR/CR tail allocations

Shaul Triebitz (2):
  iwlwifi: mvm: fix error print when session protection ends
  iwlwifi: advertise broadcast TWT support

 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   1 +
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  26 ++++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  19 +++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 140 +++++++++++-------
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  20 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  39 +++++
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  26 +++-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   4 +
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  36 +++--
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  28 ++--
 .../wireless/intel/iwlwifi/pcie/internal.h    |  20 +--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  34 -----
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  71 +++++++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  18 +++
 19 files changed, 361 insertions(+), 143 deletions(-)

-- 
2.32.0

