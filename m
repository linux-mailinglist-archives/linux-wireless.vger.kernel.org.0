Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA3A730FA8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 08:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbjFOGtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 02:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbjFOGtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B0295E
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 23:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686811652; x=1718347652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fCO2c5T/QUPPLshyvcak2ntDYxh5xqJtU4gU3fRuK6c=;
  b=e+FATM8w7e7MdKMghK2fJ5bfRnCIXJuxHs+3AE9iUPT0Q0wuBx2Bg0UT
   gl6F4SozAkVbXuZYPwRsRGLFdPAq73kEeZco/hIdMahCpmqY6xAJ2Orsa
   dPaBaV6o3agDT7E/NMttV+jkuKV3dCss5e9A+gidPSojUfTd3lYS6LbDc
   XhwNtuLZo164omL8d7/Y8uVFf5+QzPkPHRogGprcOix6BSKfhtqI82KUG
   zun11oM8lV3zBPpNNKmUzHoY1eDM4dQFuI+qwvmxFrsW5nspRVawYmsD4
   kE2tx3i8R+85dcy7TtOD3euFzbeNInpEnjpShBD/05NgzSl4K47YuI76C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362212216"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="362212216"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782395911"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="782395911"
Received: from uabekas-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.220.240])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:30 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/5] wifi: iwlwifi: updates intended for v6.5 2023-06-15 
Date:   Thu, 15 Jun 2023 09:47:15 +0300
Message-Id: <20230615064720.459645-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.5.

It contains the continuation of MLO work and bumping FW API to 81.

It depends on the previous patch sets I've sent for v6.5.  

Thanks,
Gregory

Gregory Greenman (1):
  wifi: iwlwifi: bump FW API to 81 for AX devices

Ilan Peer (2):
  wifi: iwlwifi: mvm: Don't access vif valid links directly
  wifi: iwlwifi: mvm: Add support for SCAN API version 16

Miri Korenblit (2):
  wifi: iwlwifi: fix max number of fw active links
  wifi: iwlwifi: handle eSR transitions

 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  |  23 +--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  25 +--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |   4 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 150 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  32 ++++
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c |  13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  46 ++++--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   6 +-
 11 files changed, 229 insertions(+), 78 deletions(-)

-- 
2.38.1

