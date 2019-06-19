Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19ADC4BFF6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfFSRmJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 13:42:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54510 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726380AbfFSRmJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 13:42:09 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hdeb1-0002zq-5G; Wed, 19 Jun 2019 20:42:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 0/6] iwlwifi: fixes intended for 5.2 2019-06-19
Date:   Wed, 19 Jun 2019 20:41:53 +0300
Message-Id: <20190619174159.13927-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

This is the third patchset with fixes for v5.2.

The changes are:

* A bunch of RF-kill fixes by Emmanuel;
* A fix for AP mode, also related to RF-kill, by Johannes.

As usual, I'm pushing this to a pending branch, for kbuild bot.  And
as we agreed, I'll delegate these patches to you in patchwork for you
to apply them directly.

Please review.

Cheers,
Luca.


Emmanuel Grumbach (5):
  iwlwifi: pcie: fix ALIVE interrupt handling for gen2 devices w/o MSI-X
  iwlwifi: fix RF-Kill interrupt while FW load for gen2 devices
  iwlwifi: pcie: don't service an interrupt that was masked
  iwlwifi: don't WARN when calling iwl_get_shared_mem_conf with RF-Kill
  iwlwifi: mvm: clear rfkill_safe_init_done when we start the firmware

Johannes Berg (1):
  iwlwifi: mvm: delay GTK setting in FW in AP mode

 drivers/net/wireless/intel/iwlwifi/fw/smem.c  | 12 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  8 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 53 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    | 27 ++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 66 ++++++++++++-------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  9 +++
 9 files changed, 149 insertions(+), 33 deletions(-)

-- 
2.20.1

