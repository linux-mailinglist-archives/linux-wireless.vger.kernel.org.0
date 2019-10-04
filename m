Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D21CBB5D
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388291AbfJDNOW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 09:14:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46548 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387796AbfJDNOW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 09:14:22 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iGNPX-0000l2-Bi; Fri, 04 Oct 2019 16:14:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  4 Oct 2019 16:14:06 +0300
Message-Id: <20191004131414.27372-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 0/8] iwlwifi: fixes intended for 5.4 2019-10-04
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This is my first patchset with fixes for v5.4.

The changes are:

* fix for an ACPI table parsing bug;
* a fix for a NULL pointer dereference in the cfg with specific
  devices;
* fix the rb_allocator;
* prevent multiple phy configuration with new devices;
* fix a race-condition in the rx queue;
* prevent a couple of memory leaks.

As usual, I'm pushing this to a pending branch, for kbuild bot.  I
will send you a pull-req later with these, since it goes over our
agreed threshold of 5 patches.

Cheers,
Luca.


Haim Dreyfuss (1):
  iwlwifi: mvm: force single phy init

Johannes Berg (2):
  iwlwifi: pcie: fix indexing in command dump for new HW
  iwlwifi: pcie: fix rb_allocator workqueue allocation

Luca Coelho (2):
  iwlwifi: don't access trans_cfg via cfg
  iwlwifi: fix ACPI table revision checks

Naftali Goldstein (1):
  iwlwifi: mvm: fix race in sync rx queue notification

Navid Emamdoost (2):
  iwlwifi: dbg_ini: fix memory leak in alloc_sgtable
  iwlwifi: pcie: fix memory leaks in iwl_pcie_ctxt_info_gen3_init

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 10 +++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   | 12 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 27 ++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 ++---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 36 +++++++++++++------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 25 +++++++++----
 7 files changed, 83 insertions(+), 37 deletions(-)

-- 
2.23.0

