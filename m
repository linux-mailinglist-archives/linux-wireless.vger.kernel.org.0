Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA908309EDF
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 21:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhAaUYt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 15:24:49 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:43182 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232081AbhAaUVg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 15:21:36 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6HMU-0041H2-DT; Sun, 31 Jan 2021 20:22:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 20:22:00 +0200
Message-Id: <20210131182212.929755-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.12 2021-01-31 part 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fourth set of patches intended for v5.12.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Per Platform Antenna Gain (PPAG) fixes and improvements;
* Bump FW API support again;
* Improvements in the debug framework;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Luca Coelho (7):
  iwlwifi: mvm: set enabled in the PPAG command properly
  iwlwifi: mvm: implement approved list for the PPAG feature
  iwlwifi: mvm: add HP to the PPAG approved list
  iwlwifi: mvm: add Samsung to the PPAG approved list
  iwlwifi: mvm: add Microsoft to the PPAG approved list
  iwlwifi: mvm: add Asus to the PPAG approved list
  iwlwifi: bump FW API to 61 for AX devices

Mordechay Goodstein (5):
  iwlwifi: mvm: add IML/ROM information for other HW families
  iwlwifi: mvm: add triggers for MLME events
  iwlwifi: fwrt: add suspend/resume time point
  iwlwifi: mvm: add tx fail time point
  iwlwifi: mvm: add debugfs entry to trigger a dump as any time-point

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  2 ++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  3 --
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 19 ++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 35 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 33 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 26 ++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 24 ++++++++++---
 9 files changed, 133 insertions(+), 12 deletions(-)

-- 
2.29.2

