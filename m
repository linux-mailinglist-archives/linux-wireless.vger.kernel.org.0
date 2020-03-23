Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC98218F58D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgCWNTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:19:36 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43376 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728357AbgCWNTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:19:36 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzN-00023f-EH; Mon, 23 Mar 2020 15:19:34 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:11 +0200
Message-Id: <20200323131925.208376-1-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 00/14] iwlwifi: updates intended for v5.7 2020-03-23
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the second set of patches intended for v5.7.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Refactoring of the device selection algorithms continues;
* Improvement in the initialization fo SoC-based devices;
* Support for FW scan API;
* Some additions to our FW debuggging capabilities;
* Some other small fixes and clean-ups;

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Johannes Berg (3):
  iwlwifi: pass trans and NVM data to HE capability parsing
  iwlwifi: mvm: rs-fw: fix some indentation
  iwlwifi: mvm: enable SF also when we have HE

Luca Coelho (9):
  iwlwifi: yoyo: add PCI config space region type
  iwlwifi: pcie: implement read_config32
  iwlwifi: remove redundant iwl9560_2ac_cfg struct
  iwlwifi: move integrated, extra_phy and soc_latency to trans_cfg
  iwlwifi: remove some unused extern declarations from iwl-config.h
  iwlwifi: add HW step to new cfg device table
  iwlwifi: convert all Qu with Jf devices to the new config table
  iwlwifi: convert QnJ with Jf devices to new config table
  iwlwifi: remove unnecessary cfg mangling for Qu C and QuZ with Jf

Shahar S Matityahu (2):
  iwlwifi: mvm: add soc latency support
  iwlwifi: scan: support scan req cmd ver 14

 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 252 ++-----
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  32 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   9 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  52 +-
 .../net/wireless/intel/iwlwifi/fw/api/soc.h   |  83 ++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  39 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  11 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  57 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |   6 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   8 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   3 +
 .../net/wireless/intel/iwlwifi/mvm/fw-api.h   |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  35 +-
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 129 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 708 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  10 +-
 19 files changed, 815 insertions(+), 633 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/soc.h

-- 
2.25.1

