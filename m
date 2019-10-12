Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64BAD50AF
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfJLPsf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48596 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727115AbfJLPsf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:35 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdA-0005yf-VG; Sat, 12 Oct 2019 18:48:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:12 +0300
Message-Id: <20191012154828.9249-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 00/16] iwlwifi: updates intended for v5.5 2019-10-12
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the first set of patches intended for v5.5.  This one contains
only changes to our debugging infrastructure.  There was a big revamp
on what we had before and this patchset is a bit large, but I didn't
see a reason to break it in two artificially.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Shahar S Matityahu (16):
  iwlwifi: dbg_ini: load external dbg cfg after internal cfg is loaded
  iwlwifi: dbg_ini: use new region TLV in dump flow
  iwlwifi: dbg_ini: use new trigger TLV in dump flow
  iwlwifi: dbg: remove multi buffers infra
  iwlwifi: dbg_ini: add monitor dumping support
  iwlwifi: dbg_ini: add error tables dumping support
  iwlwifi: dbg_ini: use new API in dump info
  iwlwifi: dbg_ini: add TLV allocation new API support
  iwlwifi: dbg_ini: implement time point handling
  iwlwifi: dbg_ini: implement monitor allocation flow
  iwlwifi: dbg_ini: add periodic trigger new API support
  iwlwifi: dbg_ini: support domain changing via debugfs
  iwlwifi: dbg_ini: support FW response/notification region type
  iwlwifi: dbg_ini: rename external debug configuration file
  iwlwifi: dbg_ini: remove old API and some related code
  iwlwifi: dbg_ini: support FW notification dumping in case of missed
    beacon

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  55 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  25 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 514 ++++------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 800 ++++++++++------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  47 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  37 +
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  63 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  12 -
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  58 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  28 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 891 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  22 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   7 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  40 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   3 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  77 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 149 +--
 19 files changed, 2003 insertions(+), 832 deletions(-)

-- 
2.23.0

