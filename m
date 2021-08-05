Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66A43E13BE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhHELWR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 07:22:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51272 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240797AbhHELWQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 07:22:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBbRn-00243p-Da; Thu, 05 Aug 2021 14:22:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 14:21:46 +0300
Message-Id: <20210805112158.460799-1-luca@coelho.fi>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.15 2021-08-05 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fifth set of patches intended for v5.15.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Fix reading one of our ACPI tables (WTAS);
* Support some new ACPI table revisions;
* Support new API of the WoWlan status FW notification;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Abhishek Naik (1):
  iwlwifi: skip first element in the WTAS ACPI table

Gregory Greenman (1):
  iwlwifi: mvm: support version 11 of wowlan statuses notification

Johannes Berg (1):
  iwlwifi: fw: correctly limit to monitor dump

Luca Coelho (6):
  iwlwifi: pass number of chains and sub-bands to iwl_sar_set_profile()
  iwlwifi: acpi: support reading and storing WRDS revision 1 and 2
  iwlwifi: support reading and storing EWRD revisions 1 and 2
  iwlwifi: remove unused ACPI_WGDS_TABLE_SIZE definition
  iwlwifi: convert flat GEO profile table to a struct version
  iwlwifi: acpi: support reading and storing WGDS revision 2

Miri Korenblit (2):
  iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage
  iwlwifi: mvm: load regdomain at INIT stage

Shaul Triebitz (1):
  iwlwifi: mvm: trigger WRT when no beacon heard

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 247 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  64 +++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  19 ++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 105 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   7 +
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  10 +
 11 files changed, 336 insertions(+), 139 deletions(-)

-- 
2.32.0

