Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF149F960
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348409AbiA1MbO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:31:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37816 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348416AbiA1MbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:13 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQP7-0002A0-DA;
        Fri, 28 Jan 2022 14:31:10 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:30:49 +0200
Message-Id: <20220128123057.524038-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 0/8] iwlwifi: fixes intended for v5.17 2022-01-28
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the first patchset with fixes for v5.17.

The changes are:

* A few fixes for iwlmei;
* A couple of fixes in an error path during init that renders the
  device unusable;
* Two fixes for the newly introduced rate_n_flags FW API;

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the rc series, please take them directly to
wireless-drivers.git, as we agreed.  I'll assign them to you.

Cheers,
Luca.


Emmanuel Grumbach (4):
  iwlwifi: mei: fix the pskb_may_pull check in ipv4
  iwlwifi: mei: retry mapping the shared area
  iwlwifi: mvm: don't feed the hardware RFKILL into iwlmei
  iwlwifi: mei: report RFKILL upon register when needed

Johannes Berg (2):
  iwlwifi: pcie: fix locking when "HW not ready"
  iwlwifi: pcie: gen2: fix locking when "HW not ready"

Miri Korenblit (2):
  iwlwifi: mvm: fix condition which checks the version of rate_n_flags
  iwlwifi: fix iwl_legacy_rate_to_fw_idx

 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  1 -
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    | 33 +++++++-------
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 45 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mei/net.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  3 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  3 +-
 8 files changed, 57 insertions(+), 35 deletions(-)

-- 
2.34.1

