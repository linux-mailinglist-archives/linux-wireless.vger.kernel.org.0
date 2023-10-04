Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1D7B7C43
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjJDJhD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbjJDJhC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB0C6
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412218; x=1727948218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pmTB2AVBdEhWzbh75RUHe3XmeptCbNvhDa46jcmLp5o=;
  b=bBi/lrxQ/yruKG0/iFfF/o/KDd3y5w5yilxJIskxymkWPBq0VIRfYzq8
   d4LotHuKjdtj1dT1GNIRt7dWC1xzHVT5xQHtZlw6pjkZ3m4Bl/jXnwo0n
   z177yZJnvWBOlwlFc4X+zMfVrLVQEZ8SEVIYdU0JRuTte1kkWcJGpgFDs
   3C7rCx/lnmWegchtkDEq+c5ZrZ1vhHPWkA/jzqQwhaa4Ajm5m8G45Duv8
   SZQ7MbMFviYlGIc6mvZrMEtQbten0Ac8da6NsiDI+pzVPXhoRnmzGk6KL
   UhG3qUL38bKcfx5W+fhclOrh1rlSK4Nx1jnNwwHXl41ZeVdJ0LKGTZniS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611657"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611657"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415145"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415145"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:43 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 2023-10-04 
Date:   Wed,  4 Oct 2023 12:36:19 +0300
Message-Id: <20231004093634.131303-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.7.

It contains:
* several debug (and debugfs) improvements
* small MLO features
* cleanups and bugfixes
 
Thanks,
Gregory

Ayala Beker (1):
  wifi: iwlwifi: mvm: advertise support for SCS traffic description

Ilan Peer (3):
  wifi: iwlwifi: mvm: Add basic link selection logic
  wifi: iwlwifi: mvm: Don't always bind/link the P2P Device interface
  wifi: iwlwifi: mvm: Correctly set link configuration

Johannes Berg (3):
  wifi: iwlwifi: mvm: rework debugfs handling
  wifi: iwlwifi: mvm: fix SB CFG check
  wifi: iwlwifi: mei: return error from register when not built

Miri Korenblit (4):
  wifi: iwlwifi: Extract common prph mac/phy regions data dump logic
  wifi: iwlwifi: add support for new ini region types
  wifi: iwlwifi: mvm: add a per-link debugfs
  wifi: iwlwifi: abort scan when rfkill on but device enabled

Mukesh Sisodiya (2):
  wifi: iwlwifi: fw: Fix debugfs command sending
  wifi: iwlwifi: fix the rf step and flavor bits range

Rotem Saado (1):
  wifi: iwlwifi: yoyo: swap cdb and jacket bits values

iallouch (1):
  wifi: iwlwifi: mvm: add start mac ctdp sum calculation debugfs handler

 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  34 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 124 ++++++++--
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   2 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  14 +-
 .../net/wireless/intel/iwlwifi/mei/iwl-mei.h  |   4 +-
 .../wireless/intel/iwlwifi/mvm/constants.h    |   1 +
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  76 ++++--
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  44 +++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  22 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 166 +++++--------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 231 ++++++++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  24 +-
 19 files changed, 533 insertions(+), 253 deletions(-)

-- 
2.38.1

