Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767DC46FD77
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhLJJQY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:16:24 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50872 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234141AbhLJJQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:16:24 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvbxO-001FED-Sn; Fri, 10 Dec 2021 11:12:48 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 11:12:35 +0200
Message-Id: <20211210091245.289008-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 00/10] iwlwifi: updates intended for v5.17 2021-12-10 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fifth set of patches intended for v5.17.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Support for Optimized Connectivity Experience (OCE) scan;
* A bunch of FW debugging improvements and fixes;
* Fix one 32-bit compilation issue;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: add support for OCE scan

Johannes Berg (9):
  iwlwifi: parse error tables from debug TLVs
  iwlwifi: dump CSR scratch from outer function
  iwlwifi: dump both TCM error tables if present
  iwlwifi: dump RCM error tables
  iwlwifi: mvm: fix 32-bit build in FTM
  iwlwifi: fix debug TLV parsing
  iwlwifi: fix leaks/bad data after failed firmware load
  iwlwifi: mvm: isolate offload assist (checksum) calculation
  iwlwifi: remove module loading failure message

 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 11 ++-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  5 +
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  | 93 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 -
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 15 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 92 ++++++++++++++----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 11 ++-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  6 ++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 45 ++++-----
 11 files changed, 223 insertions(+), 70 deletions(-)

-- 
2.34.1

