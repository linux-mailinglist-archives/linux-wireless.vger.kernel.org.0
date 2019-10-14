Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2BCD5C2F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 09:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfJNHU1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 03:20:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49146 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729928AbfJNHU0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 03:20:26 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJueW-0007ae-V3; Mon, 14 Oct 2019 10:20:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 14 Oct 2019 10:20:03 +0300
Message-Id: <20191014072019.1254-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 00/16] iwlwifi: updates intended for v5.5 2019-10-12-v2
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's v2 of the first set of patches intended for v5.5.  This one
contains only changes to our debugging infrastructure.  There was a
big revamp on what we had before and this patchset is a bit large, but
I didn't see a reason to break it in two artificially.

In v2:

   * add dbg.o to iwlwifi's Makefile when MVM is not defined [kbuildbot].


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

 drivers/net/wireless/intel/iwlwifi/Makefile   |   3 +-
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
 20 files changed, 2005 insertions(+), 833 deletions(-)

-- 
2.23.0

