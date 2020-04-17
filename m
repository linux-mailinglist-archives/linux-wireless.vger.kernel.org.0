Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA61AD6FD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgDQHI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:08:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56364 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728449AbgDQHIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:08:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPL6s-000KNJ-QX; Fri, 17 Apr 2020 10:08:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 10:08:08 +0300
Message-Id: <20200417070814.2044774-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 v5.7 0/6] iwlwifi: fixes intended for v5.7 2020-04-03-2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is v2 of the series, with the comments addressed.  I'll assign
them directly to you, as we had agreed before.

In v2:
   * Dropped "iwlwifi: mvm: don't call iwl_mvm_free_inactive_queue()
     under RCU", while waiting for Johannes address the comment;

   * Dropped "iwlwifi: msix: limit max RX queues for 9000 family",
     since, as Emmanuel noted, NSSN is currently disabled;

   * Fixed the commit message in "iwlwifi: mvm: limit maximum queue
     appropriately", so that it says "queue 31" instead of "queue 32".

This is my first patchset with fixes for v5.7.

The changes are:

* Remove ACK enabled aggregation support flag, since we never really
  supported it;
* A few fixes for the queues configuration on the 9000 family of
  devices that were causing FW hangs;
* A fix for the TCM statistics gathering code;

Cheers,
Luca.


Ilan Peer (1):
  iwlwifi: mvm: Do not declare support for ACK Enabled Aggregation

Johannes Berg (4):
  iwlwifi: pcie: actually release queue memory in TVQM
  iwlwifi: pcie: indicate correct RB size to device
  iwlwifi: mvm: limit maximum queue appropriately
  iwlwifi: mvm: fix inactive TID removal return value usage

Mordechay Goodstein (1):
  iwlwifi: mvm: beacon statistics shouldn't go backwards

 .../net/wireless/intel/iwlwifi/fw/api/txq.h    |  6 +++---
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  6 ++----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c    | 13 +++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   |  9 +++++++--
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c        | 18 ++++++++++++++----
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |  3 +++
 6 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.25.1

