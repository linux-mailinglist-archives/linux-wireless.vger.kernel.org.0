Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF72316A0B
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhBJPYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:24:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45330 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231659AbhBJPYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:24:45 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rLP-0049nr-VB; Wed, 10 Feb 2021 17:23:56 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:23:47 +0200
Message-Id: <20210210152355.419776-1-luca@coelho.fi>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 0/8] iwlwifi: updates intended for v5.12 2021-02-10 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the seventh set of patches intended for v5.12.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Bump the FW API support version;
* Implement support for PNVM from BIOS;
* Fix PM status when a FW crash happens;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Golan Ben Ami (1):
  iwlwifi: mvm: reduce the print severity of failing getting NIC temp

Luca Coelho (5):
  iwlwifi: pnvm: set the PNVM again if it was already loaded
  iwlwifi: pnvm: increment the pointer before checking the TLV
  iwlwifi: pnvm: move file loading code to a separate function
  iwlwifi: pnvm: implement reading PNVM from UEFI
  iwlwifi: bump FW API to 62 for AX devices

Matti Gottlieb (1):
  iwlwifi: pcie: define FW_RESET_TIMEOUT for clarity

Ravi Darsi (1):
  iwlwifi: mvm: global PM mode does not reset after FW crash

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 190 ++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   2 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  21 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   4 +-
 6 files changed, 172 insertions(+), 48 deletions(-)

-- 
2.30.0

