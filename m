Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8D59744
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF1JUV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54678 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726385AbfF1JUV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3L-0001ny-CI; Fri, 28 Jun 2019 12:20:19 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 00/20] iwlwifi: updates intended for v5.3 2019-06-28
Date:   Fri, 28 Jun 2019 12:19:48 +0300
Message-Id: <20190628092008.11049-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.3.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Special SAR implementation for South Korea;
* Fixes in the module init error paths;
* Debugging infra work continues;
* A few clean-ups;
* Other small fixes and improvements;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Andrei Otcheretianski (1):
  iwlwifi: mvm: Drop large non sta frames

Dan Carpenter (1):
  iwlwifi: remove some unnecessary NULL checks

Emmanuel Grumbach (2):
  iwlwifi: support FSEQ TLV even when FMAC is not compiled
  iwlwifi: mvm: make the usage of TWT configurable

Gustavo A. R. Silva (2):
  iwlwifi: lib: Use struct_size() helper
  iwlwifi: d3: Use struct_size() helper

Haim Dreyfuss (2):
  iwlwifi: Add support for SAR South Korea limitation
  iwlwifi: mvm: Add log information about SAR status

Johannes Berg (1):
  iwlwifi: fix module init error paths

Luca Coelho (2):
  iwlwifi: pcie: increase the size of PCI dumps
  iwlwifi: mvm: remove MAC_FILTER_IN_11AX for AP mode

Naftali Goldstein (1):
  iwlwifi: mvm: correctly fill the ac array in the iwl_mac_ctx_cmd

Shahar S Matityahu (7):
  iwlwifi: dbg: fix debug monitor stop and restart delays
  iwlwifi: dbg_ini: enforce apply point early on buffer allocation tlv
  iwlwifi: dbg_ini: remove redundant checking of ini mode
  iwlwifi: dbg: move trans debug fields to a separate struct
  iwlwifi: dbg_ini: fix debug monitor stop and restart in ini mode
  iwlwifi: dbg: don't stop dbg recording before entering D3 from 9000
    devices
  iwlwifi: dbg: debug recording stop and restart command remove

Shaul Triebitz (1):
  iwlwifi: mvm: convert to FW AC when configuring MU EDCA

 drivers/net/wireless/intel/iwlwifi/dvm/lib.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  28 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  12 ++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 100 ++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  93 +++++-----
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  32 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  34 +++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  75 ++++----
 .../wireless/intel/iwlwifi/mvm/constants.h    |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  62 +++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  16 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   9 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  10 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  23 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   3 +
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  20 ++-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   8 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 166 +++++++++---------
 26 files changed, 433 insertions(+), 303 deletions(-)

-- 
2.20.1

