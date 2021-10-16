Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ECF430131
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Oct 2021 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243816AbhJPIqL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Oct 2021 04:46:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52844 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234494AbhJPIqL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Oct 2021 04:46:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mbfIP-000Xqv-Bj; Sat, 16 Oct 2021 11:44:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 16 Oct 2021 11:43:54 +0300
Message-Id: <20211016084359.246930-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.15 0/5] iwlwifi: fixes intended for v5.15 2021-10-16
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the first patchset with fixes for v5.15.

The changes are:

* Some memory handling fixes;
* Fix the device initialization configuration for So devices;
* Fix resume flow when iwlwifi resume fails;
* Fix device configuration for JnP edvices.

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the rc series, please take them directly to
wireless-drivers.git, as we agreed.  I'll assign them to you.

Cheers,
Luca.


Johannes Berg (4):
  iwlwifi: mvm: reset PM state on unsuccessful resume
  iwlwifi: pnvm: don't kmemdup() more than we have
  iwlwifi: pnvm: read EFI data only if long enough
  iwlwifi: cfg: set low-latency-xtal for some integrated So devices

Yaara Baruch (1):
  iwlwifi: change all JnP to NO-160 configuration

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c   | 13 ++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    |  5 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c  |  6 +++---
 4 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.33.0

