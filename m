Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BB17BE0B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 14:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgCFNQp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 08:16:45 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:60910 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726579AbgCFNQo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 08:16:44 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jACqD-0005yR-Gp; Fri, 06 Mar 2020 15:16:43 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  6 Mar 2020 15:16:20 +0200
Message-Id: <20200306131627.503176-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.6 0/7] iwlwifi: fixes intended for 5.6 2020-03-06
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is my second patchset with fixes for v5.6.  This time I have 7
important fixes.

The changes are:

* Fix a locking issue in time events handling;
* A fix in rate-scaling;
* Fix for a potential NULL pointer deref;
* Enable antenna diversity in some devices that were erroneously not
  doing it;
* Allow FW dumps to continue when the FW is stuck;
* A fix in the HE capabilities handling;
* Another fix for FW dumps where we were reading wrong addresses.

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the current rc series, feel free to take
them directly to wireless-drivers.git.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: take the required lock when clearing time event data

Ilan Peer (1):
  iwlwifi: mvm: Fix rate scale NSS configuration

Luca Coelho (3):
  iwlwifi: check allocated pointer when allocating conf_tlvs
  iwlwifi: dbg: don't abort if sending DBGC_SUSPEND_RESUME fails
  iwlwifi: cfg: use antenna diversity with all AX101 devices

Mordechay Goodstein (2):
  iwlwifi: consider HE capability when setting LDPC
  iwlwifi: yoyo: don't add TLV offset when reading FIFOs

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 ++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 25 +++++--------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  6 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 35 ++++++++++++++-----
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  4 +++
 6 files changed, 44 insertions(+), 30 deletions(-)

-- 
2.25.1

