Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB117CBEB8
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQJRF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJQJRE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B7FB0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534222; x=1729070222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KYAQQO7nx7kDK45amppfqf1mh3RYyoKjqwhtFTVwP7o=;
  b=Ti1XQ9n5Dt1y2aUvwqpFuZE/Bx/kCMw+eZvGqjZwLw5S+RkwZPMnC0hi
   UNhyr1Dy4/yeXhddJxVNeJi67ZyS9JSabCKXH2UnjkPi69kk46fjYFSZA
   SeCSiQoHAECigm69WJWdjeqGsC05JwiO9xpSAYRgn5urhQ2TLcEr+XxoD
   y3qFgVOb/ZI2SeHCdznBWLE8mgrs7zjYuqzZ1YPGFWQPbpaLieLlBkvSt
   jySRMFQHx7SQIDR4DqulSEoOQlDKrQQVwHMf9llcjMfYVxhz8DJJvicvL
   vEoxEMbWHbETo0pmgfhG4OILei4de+9eQ6Cjp7j7AHOCf0JnczdN9didJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808513"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808513"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731772"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731772"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:16:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/14] wifi: iwlwifi: updates - 2023-10-17 
Date:   Tue, 17 Oct 2023 12:16:35 +0300
Message-Id: <20231017091649.65090-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

This patch set includes iwlwifi patches intended for v6.7.

It contains:
* update session protection to be MLO aware
* remove support for RSS on 9000 devices and simplify the reorder buffe
* cleanups and bugfixes

Thanks,
Gregory

Benjamin Berg (1):
  wifi: iwlwifi: mvm: Return success if link could not be removed

Daniel Gabay (1):
  wifi: iwlwifi: add support for SNPS DPHYIP region type

Emmanuel Grumbach (2):
  wifi: iwlwifi: disable multi rx queue for 9000
  wifi: iwlwifi: mvm: simplify the reorder buffer

Gregory Greenman (2):
  wifi: iwlwifi: mvm: fix size check for fw_link_id
  wifi: iwlwifi: mvm: fix regdb initialization

Johannes Berg (4):
  wifi: iwlwifi: api: fix center_freq label in PHY diagram
  wifi: iwlwifi: mvm: remove set_tim callback for MLD ops
  wifi: iwlwifi: mvm: fix netif csum flags
  wifi: iwlwifi: pcie: synchronize IRQs before NAPI

Miri Korenblit (3):
  wifi: iwlwifi: make time_events MLO aware
  wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd
  wifi: iwlwifi: support link id in SESSION_PROTECTION_NOTIF

Yedidya Benshimol (1):
  wifi: iwlwifi: mvm: update IGTK in mvmvif upon D3 resume

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |   3 +
 .../wireless/intel/iwlwifi/fw/api/phy-ctxt.h  |   4 +-
 .../intel/iwlwifi/fw/api/time-event.h         |  21 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  56 ++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   4 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  25 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  35 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 324 ++----------------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   7 -
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |   2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 115 +++++--
 .../wireless/intel/iwlwifi/mvm/time-event.h   |   4 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   1 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   1 +
 23 files changed, 254 insertions(+), 410 deletions(-)

-- 
2.38.1

