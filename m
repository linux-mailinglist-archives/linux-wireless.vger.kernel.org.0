Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5077914EDB5
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgAaNpm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 08:45:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55974 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728669AbgAaNpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 08:45:42 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixWc5-0002Nv-IF; Fri, 31 Jan 2020 15:45:38 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 15:45:23 +0200
Message-Id: <20200131134530.931641-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 0/7] iwlwifi: fixes intended for 5.6 2020-01-31
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is my first patchset with fixes for v5.6.  This time I have 7
important fixes.

The changes are:

* Fix module removal with multiple NICs;
* Don't treat IGTK removal failure as an error;
* Avoid FW crashes due to DTS measurement races;
* Fix a potential use after free in FTM code;
* Prevent a NULL pointer dereference in iwl_mvm_cfg_he_sta();
* Fix TDLS discovery;
* Check all CPUs when trying to detect an error during resume;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Cheers,
Luca.


Andrei Otcheretianski (2):
  iwlwifi: mvm: Fix thermal zone registration
  iwlwifi: mvm: Check the sta is not NULL in iwl_mvm_cfg_he_sta()

Avraham Stern (1):
  iwlwifi: mvm: avoid use after free for pmsr request

Emmanuel Grumbach (1):
  iwlwifi: mvm: fix TDLS discovery with the new firmware API

Golan Ben Ami (1):
  iwlwifi: mvm: update the DTS measurement type

Luca Coelho (1):
  iwlwifi: don't throw error when trying to remove IGTK

Mordechay Goodstein (1):
  iwlwifi: d3: read all FW CPUs error info

 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 52 ++++++++++----
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 10 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c | 10 ++-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 71 ++++++++++++++++---
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   | 10 +--
 8 files changed, 132 insertions(+), 40 deletions(-)

-- 
2.24.1

