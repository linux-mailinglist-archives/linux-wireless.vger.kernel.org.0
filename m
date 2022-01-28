Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3C49F9CD
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbiA1Msy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:48:54 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37834 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbiA1Msy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:48:54 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQgO-0002Bq-45;
        Fri, 28 Jan 2022 14:48:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:48:49 +0200
Message-Id: <20220128124851.538580-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 0/2] iwlwifi: fixes intended for v5.17 2022-01-28 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the second patchset with fixes for v5.17.

These are two fixes that I missed in the previous patchset.

The changes are:

* Remove deprecated feature that causes FW errors when enabled with new FWs;
* Fix SAR Geo FW command failure with 3160 devices.

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the rc series, please take them directly to
wireless-drivers.git, as we agreed.  I'll assign them to you.

Cheers,
Luca.


Luca Coelho (2):
  iwlwifi: remove deprecated broadcast filtering feature
  iwlwifi: mvm: don't send SAR GEO command for 3160 devices

 drivers/net/wireless/intel/iwlwifi/Kconfig    |  13 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  11 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 -
 .../wireless/intel/iwlwifi/fw/api/filter.h    |  88 -------
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 203 ---------------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 240 ------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  13 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 -
 11 files changed, 9 insertions(+), 572 deletions(-)

-- 
2.34.1

