Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71A7AF57
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfG3RMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 13:12:22 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36876 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfG3RMV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 13:12:21 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hsVff-0002v5-5q; Tue, 30 Jul 2019 19:12:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: pull-request: iwlwifi-fixes 2019-07-30
Date:   Tue, 30 Jul 2019 19:12:09 +0200
Message-Id: <20190730171210.16570-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Resending, with all sign-offs again ... sorry, that's because Luca
handled the previous part and then I just added stuff.

Please pull and let me know if there's any problem.

Thanks,
johannes



The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git tags/iwlwifi-fixes-for-kvalo-2019-07-30

for you to fetch changes up to 71b256f8f7a5c09810d2c3ed6165629c2cc0a652:

  iwlwifi: mvm: fix a use-after-free bug in iwl_mvm_tx_tso_segment (2019-07-30 18:34:32 +0200)

----------------------------------------------------------------
We have a lot of fixes, most of them are also applicable to stable.
Notably:
 * fix use-after-free issues
 * fix DMA mapping API usage errors
 * fix frame drop occurring due to reorder buffer handling in
   RSS in certain conditions
 * fix rate scale locking issues
 * disable TX A-MSDU on older NICs as it causes problems and was
   never supposed to be supported
 * new PCI IDs
 * GEO_TX_POWER_LIMIT API issue that many people were hitting

----------------------------------------------------------------
Colin Ian King (1):
      iwlwifi: mvm: fix comparison of u32 variable with less than zero

Emmanuel Grumbach (8):
      iwlwifi: mvm: prepare the ground for more RSS notifications
      iwlwifi: mvm: add a new RSS sync notification for NSSN sync
      iwlwiif: mvm: refactor iwl_mvm_notify_rx_queue
      iwlwifi: mvm: add a loose synchronization of the NSSN across Rx queues
      iwlwifi: mvm: fix frame drop from the reordering buffer
      iwlwifi: don't unmap as page memory that was mapped as single
      iwlwifi: mvm: fix an out-of-bound access
      iwlwifi: mvm: fix a use-after-free bug in iwl_mvm_tx_tso_segment

Gregory Greenman (4):
      iwlwifi: mvm: add a wrapper around rs_tx_status to handle locks
      iwlwifi: mvm: send LQ command always ASYNC
      iwlwifi: mvm: replace RS mutex with a spin_lock
      iwlwifi: mvm: fix possible out-of-bounds read when accessing lq_info

Ihab Zhaika (1):
      iwlwifi: add 3 new IDs for the 9000 series (iwl9260_2ac_160_cfg)

Johannes Berg (2):
      iwlwifi: mvm: disable TX-AMSDU on older NICs
      iwlwifi: fix locking in delayed GTK setting

Luca Coelho (2):
      iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT on version < 41
      iwlwifi: mvm: fix version check for GEO_TX_POWER_LIMIT support

Mordechay Goodstein (1):
      iwlwifi: mvm: avoid races in rate init and rate perform

Shahar S Matityahu (2):
      iwlwifi: dbg_ini: move iwl_dbg_tlv_load_bin out of debug override ifdef
      iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifdef

 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h    |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c      |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c       |  29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  58 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c       | 539 ++++++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h       |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     | 185 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h      |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c       |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c     |   3 +
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c      |   2 +
 16 files changed, 523 insertions(+), 342 deletions(-)

