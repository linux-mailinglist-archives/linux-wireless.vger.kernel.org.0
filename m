Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846215286C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfFYJpA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54598 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727643AbfFYJpA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0X-0007Nv-Ig; Tue, 25 Jun 2019 12:44:57 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 00/12] iwlwifi: updates intended for v5.3 2019-06-25
Date:   Tue, 25 Jun 2019 12:44:40 +0300
Message-Id: <20190625094452.19034-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.3.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Work on the new debugging framework continues;
* Update the FW API for CSI;
* Other small fixes and improvements;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Jiri Kosina (1):
  iwlwifi: iwl_mvm_tx_mpdu() must be called with BH disabled

Johannes Berg (1):
  iwlwifi: update CSI API

Mordechay Goodstein (2):
  iwlwifi: mvm: add a debugfs entry to set a fixed size AMSDU for all TX
    packets
  iwlwifi: mvm: remove multiple debugfs entries

Shahar S Matityahu (8):
  iwlwifi: dbg: allow dump collection in case of an early error
  iwlwifi: dbg_ini: dump headers cleanup
  iwlwifi: dbg_ini: abort region collection in case the size is 0
  iwlwifi: dbg_ini: add consecutive trigger firing support
  iwlwifi: dbg_ini: use different barker for ini dump
  iwlwifi: dbg_ini: support debug info TLV
  iwlwifi: dbg_ini: implement dump info collection
  iwlwifi: fw api: support adwell HB default APs number api

 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  22 ++
 .../wireless/intel/iwlwifi/fw/api/location.h  |  11 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  15 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 329 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  40 ++-
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 111 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  14 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   7 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  28 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   1 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  66 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  16 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  13 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  21 +-
 21 files changed, 529 insertions(+), 195 deletions(-)

-- 
2.20.1

