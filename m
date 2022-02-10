Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18304B1383
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbiBJQw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbiBJQwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:24 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D548F9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:24 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDL-000Bxy-LE;
        Thu, 10 Feb 2022 18:22:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:23 +0200
Message-Id: <20220210162234.285578-1-luca@coelho.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 00/11] iwlwifi: updates intended for v5.18 2022-02-10
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's the sixth set of patches intended for v5.18.  It's the usual
development, new features, cleanups and bugfixes.

The changes are:

* Fix config structure for one device;
* Support a new FW API command version;
* Support new queue allocation command;
* Some more debugging improvements;
* Some other small fixes, clean-ups and improvements.

As usual, I'm pushing this to a pending branch, for kbuild bot, and
will send a pull-request later.

Please review.

Cheers,
Luca.


Abhishek Naik (1):
  iwlwifi: tlc: Add logs in rs_fw_rate_init func to print TLC
    configuration

Johannes Berg (6):
  iwlwifi: make iwl_txq_dyn_alloc_dma() return the txq
  iwlwifi: remove command ID argument from queue allocation
  iwlwifi: mvm: remove iwl_mvm_disable_txq() flags argument
  iwlwifi: support new queue allocation command
  iwlwifi: api: remove ttl field from TX command
  iwlwifi: mvm: update BAID allocation command again

Miri Korenblit (1):
  iwlwifi: mvm: move only to an enabled channel

Mukesh Sisodiya (2):
  iwlwifi: yoyo: support dump policy for the dump size
  iwlwifi: yoyo: send hcmd to fw after dump collection completes.

Yaara Baruch (1):
  iwlwifi: pcie: iwlwifi: fix device id 7F70 struct

 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 89 ++++++++++++++++---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 32 ++++++-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 19 +++-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  6 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  7 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 69 +++++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |  5 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  8 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 25 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  9 ++
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 31 +++++--
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 14 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 53 +++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  8 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 81 +++++++++++------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  9 +-
 19 files changed, 365 insertions(+), 108 deletions(-)

-- 
2.34.1

