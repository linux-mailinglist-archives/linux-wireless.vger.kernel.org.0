Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A44B59020E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2019 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHPM4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Aug 2019 08:56:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36126 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbfHPM4C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Aug 2019 08:56:02 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hyblw-00066W-6m; Fri, 16 Aug 2019 15:56:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 16 Aug 2019 15:55:50 +0300
Message-Id: <20190816125554.8659-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 0/4] iwlwifi: fixes intended for 5.3 2019-08-16
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

This is my third patchset with fixes for v5.3.

The changes are:

* fix one bug on 22560 Tx code;
* prevent sending multicast frames when not associated;
* a couple of fixes in the card detection code.

As usual, I'm pushing this to a pending branch, for kbuild bot.  I
will assign these patches to you in patchwork so you can apply them
directly to wireless-drivers.

Cheers,
Luca.


Emmanuel Grumbach (1):
  iwlwifi: pcie: fix the byte count table format for 22560 devices

Ilan Peer (1):
  iwlwifi: mvm: Allow multicast data frames only when associated

Luca Coelho (2):
  iwlwifi: pcie: don't switch FW to qnj when ax201 is detected
  iwlwifi: pcie: fix recognition of QuZ devices

 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 33 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 ++++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 17 ++++++++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 +
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 20 +++++++----
 5 files changed, 71 insertions(+), 10 deletions(-)

-- 
2.23.0.rc1

