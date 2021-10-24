Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1347438951
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhJXN5b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58500 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231172AbhJXN5b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:31 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medxs-000cvJ-7i; Sun, 24 Oct 2021 16:55:09 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:54:55 +0300
Message-Id: <20211024135506.285102-1-luca@coelho.fi>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/11] iwlwifi: updates intended for v5.16 2021-10-24
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fifth set of patches intended for v5.16.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support a new ACPI table revision;
* Improvements in the device selection code;
* New HW support;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ayala Barazani (1):
  iwlwifi: ACPI: support revision 3 WGDS tables

Emmanuel Grumbach (1):
  iwlwifi: mvm: fix some kerneldoc issues

Ilan Peer (1):
  iwlwifi: mvm: Use all Rx chains for roaming scan

Johannes Berg (6):
  iwlwifi: pcie: fix killer name matching for AX200
  iwlwifi: pcie: remove duplicate entry
  iwlwifi: pcie: refactor dev_info lookup
  iwlwifi: pcie: remove two duplicate PNJ device entries
  iwlwifi: pcie: simplify iwl_pci_find_dev_info()
  iwlwifi: dump host monitor data when NIC doesn't init

Mike Golant (1):
  iwlwifi: pcie: update sw error interrupt for BZ family

Yaara Baruch (1):
  iwlwifi: add new pci SoF with JF

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 142 ++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  39 +++--
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  35 +++-
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |   2 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  46 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  44 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   8 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 149 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   9 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  45 ++++--
 12 files changed, 391 insertions(+), 131 deletions(-)

-- 
2.33.0

