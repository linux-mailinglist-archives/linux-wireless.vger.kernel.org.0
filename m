Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F2C7327F2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbjFPGyc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbjFPGyZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F64F2961
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898464; x=1718434464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NjUJ66GGsV54J5cU8sRdSzBTg/M7ilRIao1Xf21onUA=;
  b=kfZqV2dp6f9mw+XRX19u+pO9gCzmL3txPp+qXEc1wVpl2WuAgQXTGg6t
   ZHj4qCSEXlJACSFnJrOI/EaX0Y59CsW4IPD+xsVgFfrN7AbayIgxPmoCr
   Xw2jXFCdfsSvJ9TkM5e7hp7O7r2oo8XaJnnuJapUYVOybe31F/QaHFeug
   gF/MT2PPbN8SMWeg6+H9AJYXrpmP7DQdiG0xUjVMnmdCj68uP2mQ6alfj
   8C3HrSkG+K9mvpjO0NTFOukeqaAyQKp+99PVHEsUwENMiwQMZ9ovLx4L2
   FJ0xipJdvFZCXswATjvbEA1WW9Wliy/5UCJNMrvN+XFWlcpyASlbvblDn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078768"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078768"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802719921"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802719921"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:21 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/20] cfg80211/mac80211 patches from our internal tree 2023-06-16 
Date:   Fri, 16 Jun 2023 09:53:49 +0300
Message-Id: <20230616065409.633290-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the usual developement, cleanups and
bugfixes.

Thanks,
Gregory

Abhishek Naik (2):
  wifi: mac80211: handle TDLS data frames with MLO
  wifi: mac80211: Add HE and EHT capa elements in TDLS frames

Anjaneyulu (1):
  wifi: mac80211: add consistency check for compat chandef

Benjamin Berg (10):
  wifi: mac80211: stop passing cbss to parser
  wifi: cfg80211: move regulatory_hint_found_beacon to be earlier
  wifi: cfg80211: keep bss_lock held when informing
  wifi: cfg80211: add inform_bss op to update BSS
  wifi: mac80211: use new inform_bss callback
  wifi: cfg80211: ignore invalid TBTT info field types
  wifi: cfg80211: rewrite merging of inherited elements
  wifi: cfg80211: drop incorrect nontransmitted BSS update code
  wifi: cfg80211: add element defragmentation helper
  wifi: mac80211: use cfg80211 defragmentation helper

Emmanuel Grumbach (1):
  wifi: mac80211: feed the link_id to cfg80211_ch_switch_started_notify

Ilan Peer (3):
  wifi: mac80211: Rename multi_link
  wifi: mac80211: Add support for parsing Reconfiguration Multi Link element
  wifi: mac80211: Rename ieee80211_mle_sta_prof_size_ok()

Mukesh Sisodiya (3):
  wifi: cfg80211: make TDLS management link-aware
  wifi: mac80211: handle TDLS negotiation with MLO
  wifi: mac80211: Extend AID element addition for TDLS frames

 .../net/wireless/marvell/mwifiex/cfg80211.c   |   8 +-
 include/linux/ieee80211.h                     |   8 +-
 include/net/cfg80211.h                        |  42 +-
 net/mac80211/cfg.c                            |   1 +
 net/mac80211/chan.c                           |   5 +
 net/mac80211/ieee80211_i.h                    |  24 +-
 net/mac80211/mlme.c                           |  14 +-
 net/mac80211/scan.c                           |  93 ++-
 net/mac80211/tdls.c                           | 257 ++++++---
 net/mac80211/tx.c                             |  22 +-
 net/mac80211/util.c                           | 118 ++--
 net/wireless/nl80211.c                        |   7 +-
 net/wireless/rdev-ops.h                       |  27 +-
 net/wireless/scan.c                           | 542 +++++++++---------
 net/wireless/trace.h                          |  30 +-
 15 files changed, 697 insertions(+), 501 deletions(-)

-- 
2.38.1

