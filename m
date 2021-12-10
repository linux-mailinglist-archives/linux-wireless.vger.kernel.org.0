Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6855146FB0C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhLJHKD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:03 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50792 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231180AbhLJHKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:03 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZz4-001F9v-Im; Fri, 10 Dec 2021 09:06:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:10 +0200
Message-Id: <20211210070621.236783-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/11] iwlwifi: updates intended for v5.17 2021-12-10 part 1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.17.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support for Time-Aware-SAR (TAS) as read from the BIOS;
* Fix scan timeout issue when 6GHz is enabled;
* Work continues for new HW family Bz;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ayala Barazani (1):
  iwlwifi: mvm: Add list of OEMs allowed to use TAS

Gregory Greenman (1):
  iwlwifi: mvm: rfi: update rfi table

Ilan Peer (1):
  iwlwifi: mvm: Increase the scan timeout guard to 30 seconds

Johannes Berg (2):
  iwlwifi: fix Bz NMI behaviour
  iwlwifi: fw: remove dead error log code

Luca Coelho (1):
  iwlwifi: recognize missing PNVM data and then log filename

Matti Gottlieb (1):
  iwlwifi: Read the correct addresses when getting the crf id

Mike Golant (2):
  iwlwifi: pcie: add jacket bit to device configuration parsing
  iwlwifi: add support for BNJ HW

Miri Korenblit (1):
  iwlwifi: mvm: support revision 1 of WTAS table

Mordechay Goodstein (1):
  iwlwifi: rs: add support for TLC config command ver 4

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  54 ++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  47 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  18 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  25 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  56 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  56 +---
 drivers/net/wireless/intel/iwlwifi/fw/img.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   4 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   9 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  62 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c  |  46 ++-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  72 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 268 ++++++++++--------
 18 files changed, 480 insertions(+), 256 deletions(-)

-- 
2.34.1

