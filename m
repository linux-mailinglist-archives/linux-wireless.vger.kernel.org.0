Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975AA612BC3
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Oct 2022 18:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJ3RSL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3RSK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 13:18:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30452B1E8
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667150290; x=1698686290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=klOtJdlIIW2sAtHhwYJBpab9hnAz0fbCKG8nOtWNpgY=;
  b=Ao15qUWZmMtEgdxV3OnkzLEG/unEnUpMKbWL/FoNiTUoou3YATwVvlWi
   v0Mk8ZI9iliTwzRQ+qhZB6kH8wx+d51qNzrp+7eYOJ3oGiKRKNeWFMOJ0
   6FHevQocXn9/+mCHidsgHajODfmDhlAcI75cfgHaTkIOQvQ/G99pxKWwV
   JVW+yJYCZWVMRfjMZkhTFEVi3PnWiq8TJzlfl2TmlCe2i53L72gyN7sXL
   EEjcRaTpphFpM8yPgOwxJEOh3SQZ8+ubSgQKKyV3W7i+pi5j2i4b3u8oH
   TbHlytSYqQ1lvWO8e//9Go79O8/F1WDdb28WLxKmVkFlXjSk7ozWuY+GX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="310458254"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="310458254"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="633290155"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="633290155"
Received: from gustyuzh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:07 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/6] iwlwifi: updates intended for v6.2 2022-10-30 
Date:   Sun, 30 Oct 2022 19:17:39 +0200
Message-Id: <20221030171745.132081-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

Here's the first set of patches intended for v6.2. It contains
some fixes for IWLMEI. There will be more fixes, so it still depends
on BROKEN.

As usual, I'm pushing this to a pending branch, for kbuild bot,
and will send a pull-request later.

Please review.

Thanks,
Gregory

Avraham Stern (3):
  wifi: iwlwifi: mvm: send TKIP connection status to csme
  wifi: iwlwifi: mei: make sure ownership confirmed message is sent
  wifi: iwlwifi: mei: avoid blocking sap messages handling due to rtnl
    lock

Emmanuel Grumbach (2):
  wifi: iwlwifi: mei: don't send SAP commands if AMT is disabled
  wifi: iwlwifi: mei: fix tx DHCP packet for devices with new Tx API

Johannes Berg (1):
  wifi: iwlwifi: mei: fix potential NULL-ptr deref after clone

 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 172 ++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mei/net.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mei/sap.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   8 +-
 9 files changed, 132 insertions(+), 82 deletions(-)

-- 
2.35.3

