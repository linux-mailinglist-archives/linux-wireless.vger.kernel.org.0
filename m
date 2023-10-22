Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB357D236A
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjJVO4M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVO4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35665A4
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986569; x=1729522569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4lz9J35+4ZgVST8FN3TPDIJw0/ekqGEzoLWaGc5dJn8=;
  b=C/OjLghMGjwqvOsiKAzde4X0LPWRlpnNTk9HH3IcZVx+/92cxAAPWllX
   TRroa3xtf/Ap1JLeOC/Xpbq501lMBG01JnZbLdTOefzFI5D2uRwDr69ie
   o8GSpcP2K7I3WHUdmdiMosuE27yItOT2PnZy9yy3VoxnBM4RiK1VgPbPI
   4WSsHv0t1YJAhYjxbfoAqfypF8Ez+gBDN4zDjaQnYve9wwtmEuhSTQS67
   hT9RgbXI9Xe3CaayVf1Yef8JHaWTBDu2L1sFr03tEL9e1rLr51sFnelqh
   I3U1jDOoGu3kQxp+36+lNBnTdHadxsbkFnFWWxklcQisaEl6HubHTXr6n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925841"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925841"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556172"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:54:52 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/10] wifi: iwlwifi: updates - 2023-10-22
Date:   Sun, 22 Oct 2023 17:55:46 +0300
Message-Id: <20231022145556.244202-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.7

It contains a few bugfixes and cleanups.
In addition, it implements the new statistis firmware API and bumps
firmware API to 86.

Thanks,
Gregory

Anjaneyulu (2):
  wifi: iwlwifi: mvm: implement new firmware API for statistics
  wifi: iwlwifi: mvm: debugfs for fw system stats

Daniel Gabay (1):
  wifi: iwlwifi: read DSM func 2 for specific RF types

Gregory Greenman (1):
  wifi: iwlwifi: bump FW API to 86 for AX/BZ/SC devices

Johannes Berg (3):
  wifi: iwlwifi: trace full frames with TX status request
  wifi: iwlwifi: mvm: cycle FW link on chanctx removal
  wifi: iwlwifi: mvm: show dump even for pldr_sync

Miri Korenblit (2):
  wifi: iwlwifi: mvm: add a print when sending RLC command
  wifi: iwlwifi: empty overflow queue during flush

Mukesh Sisodiya (1):
  wifi: iwlwifi: fw: Add support for UATS table in UHB

 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  26 ++-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  30 ++++
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  18 ++
 .../net/wireless/intel/iwlwifi/fw/api/stats.h | 153 +++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   4 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  50 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  17 ++
 .../net/wireless/intel/iwlwifi/iwl-devtrace.h |   8 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 104 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  59 +++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  46 +++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  12 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  27 ++-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 157 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  61 +++++++
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |   9 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |   2 +-
 25 files changed, 756 insertions(+), 65 deletions(-)

-- 
2.38.1

