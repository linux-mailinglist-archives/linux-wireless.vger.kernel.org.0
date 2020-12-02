Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92002CBD33
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 13:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgLBMml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 07:42:41 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33950 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726631AbgLBMml (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 07:42:41 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kkRSD-0037gb-Lo; Wed, 02 Dec 2020 14:41:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  2 Dec 2020 14:41:48 +0200
Message-Id: <20201202124151.55050-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 0/3] iwlwifi: fixes intended for v5.10 2020-12-02
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the second patchset with fixes for v5.10.

The changes are:

* Add a few PCI IDs for some new devices;
* Fix 160 vs. non-160 MHz device detection.

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the rc series, please take them directly to
wireless-drivers.git, as we agreed.

Cheers,
Luca.


Golan Ben Ami (1):
  iwlwifi: pcie: add some missing entries for AX210

Luca Coelho (2):
  iwlwifi: pcie: add one missing entry for AX210
  iwlwifi: pcie: invert values of NO_160 device config entries

 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.29.2

