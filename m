Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4AC10376F
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfKTK05 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:26:57 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58502 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726757AbfKTK05 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:26:57 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNCJ-0001kS-3U; Wed, 20 Nov 2019 12:26:55 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 20 Nov 2019 12:26:38 +0200
Message-Id: <20191120102650.514376-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.5 2019-11-20
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the fifth and final set of patches intended for v5.5.  It's the
usual development, new features, cleanups and bugfixes.

The changes are:

* Fix a merge damage that causes issues with high-throuput on AX200+;
* Support TX/RX antennas reporting;
* Small fix in DVM's BT link-quality code;
* Bump supported FW API version to 52;
* Yet another scan FW API update;
* Some clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Ben Greear (1):
  iwlwifi: mvm: Report tx/rx antennas

Denis Efremov (1):
  iwlwifi: dvm: excessive if in rs_bt_update_lq()

Johannes Berg (8):
  iwlwifi: pcie: fix support for transmitting SKBs with fraglist
  iwlwifi: pcie: make some RX functions static
  iwlwifi: config: remove max_rx_agg_size
  iwlwifi: mvm: remove left-over non-functional email alias
  iwlwifi: pcie: rx: use rxq queue_size instead of constant
  iwlwifi: pcie: trace IOVA for iwlwifi_dev_tx_tb
  iwlwifi: mvm: remove outdated comment referring to wake lock
  iwlwifi: check kasprintf() return value

Luca Coelho (1):
  iwlwifi: bump FW API to 52 for 22000 series

Tova Mussai (1):
  iwlwifi: scan: support scan req FW API ver 13

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c  |  3 +
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 56 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 -
 .../intel/iwlwifi/iwl-devtrace-data.h         |  8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c  |  3 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  5 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    |  2 -
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 54 +++++++++++++++++-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  2 -
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  6 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 28 +++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 14 ++---
 16 files changed, 161 insertions(+), 41 deletions(-)

-- 
2.24.0

