Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C75B19D233
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbgDCIaG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 04:30:06 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:45432 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727835AbgDCIaF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 04:30:05 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jKHiF-0008yu-GM; Fri, 03 Apr 2020 11:30:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  3 Apr 2020 11:29:47 +0300
Message-Id: <20200403082955.1126339-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v5.7 0/8] iwlwifi: fixes intended for v5.7 2020-04-03
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is my first patchset with fixes for v5.7.

The changes are:

* Remove ACK enabled aggregation support flag, since we never really
  supported it;
* A few fixes for the queues configuration on the 9000 family of
  devices that were causing FW hangs;
* Fix an RCU issue;
* A fix for the TCM statistics gathering code;


As usual, I'm pushing this to a pending branch, for kbuild bot.  And
since these are fixes for the rc series, feel free to take them
directly to wireless-drivers.git.

Cheers,
Luca.


Ilan Peer (1):
  iwlwifi: mvm: Do not declare support for ACK Enabled Aggregation

Johannes Berg (5):
  iwlwifi: pcie: actually release queue memory in TVQM
  iwlwifi: pcie: indicate correct RB size to device
  iwlwifi: mvm: limit maximum queue appropriately
  iwlwifi: mvm: fix inactive TID removal return value usage
  iwlwifi: mvm: don't call iwl_mvm_free_inactive_queue() under RCU

Mordechay Goodstein (2):
  iwlwifi: mvm: beacon statistics shouldn't go backwards
  iwlwifi: msix: limit max RX queues for 9000 family

 .../net/wireless/intel/iwlwifi/fw/api/txq.h    |  6 +++---
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  6 ++----
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c    | 13 +++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   | 17 ++++++++++-------
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c        | 18 ++++++++++++++----
 .../net/wireless/intel/iwlwifi/pcie/trans.c    |  6 +++++-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |  3 +++
 8 files changed, 49 insertions(+), 21 deletions(-)

-- 
2.25.1

