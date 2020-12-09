Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF62D4506
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgLIPGD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:03 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728392AbgLIPGD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:03 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11n-003Dg4-Q1; Wed, 09 Dec 2020 17:05:16 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:03 +0200
Message-Id: <20201209150514.944056-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/11]  iwlwifi: updates intended for v5.11 2020-12-09
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fifth set of patches intended for v5.11.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Added some more validations for firmware notifications;
* Support for a new type of HW;
* A couple of channel switch fixes;
* Support new FW reset handshake;
* Add a couple of RX handlers that were accidentally left out;
* Some other clean-ups and small fixes.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Avraham Stern (1):
  iwlwifi: mvm: add size checks for range response notification

Emmanuel Grumbach (1):
  iwlwifi: mvm: purge the BSS table upon firmware load

Johannes Berg (6):
  iwlwifi: add an extra firmware state in the transport
  iwlwifi: support firmware reset handshake
  iwlwifi: mvm: disconnect if channel switch delay is too long
  iwlwifi: tighten RX MPDU bounds checks
  iwlwifi: mvm: hook up missing RX handlers
  iwlwifi: mvm: validate notification size when waiting

Matti Gottlieb (1):
  iwlwifi: Add a new card for MA family

Mordechay Goodstein (1):
  iwlwifi: mvm: check that statistics TLV version match struct version

Sara Sharon (1):
  iwlwifi: mvm: fix a race in CSA that caused assert 0x3420

 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 11 +++++
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   |  6 +++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 ++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  1 +
 .../net/wireless/intel/iwlwifi/iwl-phy-db.c   | 16 +++++--
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  2 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 20 ++++++---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 44 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 18 ++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 23 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  9 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  8 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 32 +++++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  6 +++
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 ++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  6 +++
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 26 +++++++++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  4 ++
 19 files changed, 210 insertions(+), 31 deletions(-)

-- 
2.29.2

