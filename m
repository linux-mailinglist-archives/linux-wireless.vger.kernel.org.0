Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AADC47A025
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhLSKSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:25 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51322 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231185AbhLSKSZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:25 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGo-001O3b-Ft; Sun, 19 Dec 2021 12:18:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:08 +0200
Message-Id: <20211219101820.85153-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.17 2021-12-19 part 1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the sixth set of patches intended for v5.17.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Some RX changes for new HW family
* Some fixes for 6 GHz scan;
* Fix SAR table fixes with newer platforms;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: perform 6GHz passive scan after suspend

Ayala Beker (1):
  iwlwifi: mvm: correctly set channel flags

Ilan Peer (1):
  iwlwifi: mvm: Fix calculation of frame length

Johannes Berg (4):
  iwlwifi: mvm: use a define for checksum flags mask
  iwlwifi: mvm: handle RX checksum on Bz devices
  iwlwifi: mvm: don't trust hardware queue number
  iwlwifi: mvm: change old-SN drop threshold

Luca Coelho (2):
  iwlwifi: don't pass actual WGDS revision number in table_revision
  iwlwifi: bump FW API to 69 for AX devices

Miri Korenblit (1):
  iwlwifi: mvm: always store the PPAG table as the latest version.

Mukesh Sisodiya (1):
  iwlwifi: yoyo: support TLV-based firmware reset

Nathan Errera (1):
  iwlwifi: mvm: test roc running status bits before removing the sta

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  5 ++
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 15 +++-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  8 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  3 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  3 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 43 ++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +
 .../wireless/intel/iwlwifi/mvm/constants.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 74 ++++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 16 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 33 ++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 28 ++++---
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 15 +++-
 16 files changed, 185 insertions(+), 68 deletions(-)

-- 
2.34.1

