Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0327E6E205B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDNKMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDNKMT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C58198D
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467138; x=1713003138;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=opIZTxk0/1YtqqykBfqA1bnL7410rQflN+QQMBGP5lw=;
  b=KoKOKEEm6YPEX0NG2hs64y6F4u/t5H6iyhrMuhfcWWc0vda+vUde595R
   ipZgY2yLrLhzdRsQf0aTJlSDdd0VTsrJnnZRqPneG/xHH3MScGXqrZEJ/
   Id2PyWCzDtfYlNwyyqLTNIOHHlgk9MQncl5zK05zdSgi/Hj6aTtDP08JJ
   DWFfok3QdwfB3USueI3oNKR9sw9qmNjjWf4OQeDXUmroxW2jmcLJlMlcr
   4gIcB1PgrEKz5U5QAIEp8k3il/rPKAcVzGu7kYJw4QnPtu8PohLxz3IMr
   qpi5QeheUvilnwfIg2kVwFUK7JhALLuRv5SWI2likPnVfYwrefmc/ECRM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263533"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263533"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351514"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351514"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] wifi: iwlwifi: updates intended for v6.4 2023-04-14
Date:   Fri, 14 Apr 2023 13:11:51 +0300
Message-Id: <20230414101206.1170180-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's the next set of iwlwifi patches for v6.4.
Same as the previous one, this set contains the
ususal developement, small improvements, cleanups and
bugfixes. It also enables the new MLO FW API.

Thanks,
Gregory

Colin Ian King (2):
  wifi: iwlwifi: Fix spelling mistake "upto" -> "up to"
  wifi: iwlwifi: mvm: Fix spelling mistake "Gerenal" -> "General"

Hyunwoo Kim (1):
  wifi: iwlwifi: pcie: Fix integer overflow in iwl_write_to_user_buf

Ilan Peer (1):
  wifi: iwlwifi: mvm: Fix setting the rate for non station cases

Johannes Berg (6):
  wifi: iwlwifi: mvm: track AP STA pointer and use it for MFP
  wifi: iwlwifi: mvm: make iwl_mvm_mac_ctxt_send_beacon() static
  wifi: iwlwifi: mvm: fix ptk_pn memory leak
  wifi: iwlwifi: mvm: set STA mask for keys in MLO
  wifi: iwlwifi: mvm: validate station properly in flush
  wifi: iwlwifi: mvm: tx: remove misleading if statement

Miri Korenblit (1):
  wifi: iwlwifi: mvm: enable new MLD FW API

Mukesh Sisodiya (2):
  wifi: iwlwifi: Add RF Step Type for BZ device
  wifi: iwlwifi: add a new PCI device ID for BZ device

Tom Rix (2):
  wifi: iwlwifi: mvm: initialize seq variable
  wifi: iwlwifi: fw: move memset before early return

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  47 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   4 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   7 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  18 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  23 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |  82 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  29 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 376 +++++++++---------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   2 +-
 17 files changed, 378 insertions(+), 256 deletions(-)

-- 
2.38.1

