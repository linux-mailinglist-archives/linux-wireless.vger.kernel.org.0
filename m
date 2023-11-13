Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F637E990A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 10:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjKMJf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 04:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjKMJf2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 04:35:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2110D0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 01:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699868125; x=1731404125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ll5NyN97uCxIwBGW78X40SUpztKZmk1JKaO4ZROLtEQ=;
  b=koiD6lj4XNMxVIGHlrpmq5/x9S8BIbZmXfd7+radhEcaWh12TH14jrSi
   20ANYQeZ7tmgEnCj0NrNg4rdjiaeo1wjudUx6ZJTq73fzrJj++3OOr/R2
   TyOSkc51RTvAip83TpnEFm05zlMH7X0gMqZv5MqJG3ZOLbT8c+j741z5e
   fd3AoySX9gfHP7B5grxcoWjU9ghw0Y28ixXKr3/gnqwdOAGaziYAP85mW
   Qy0PMt/CU7EAromD+6vxS4CWAyo2ErSxidYJXFAAsKKeTwCVYrUUo/pLi
   tIJZhSPA7SjHufWmYjBT3lxYcD0UHcyhQOqUE8V+hBTvvBcbpzZ2b/sO4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369735605"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="369735605"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937695152"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937695152"
Received: from tdistelf-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.220.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:23 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/6] cfg80211/mac80211 patches from our internal tree 2023-11-13
Date:   Mon, 13 Nov 2023 11:34:59 +0200
Message-Id: <20231113093505.456824-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Hi,

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the usual developement, adding a few small
features.

Thanks,
Gregory

Andrei Otcheretianski (4):
  wifi: cfg80211: reg: Support P2P operation on DFS channels
  wifi: cfg80211: Schedule regulatory check on BSS STA channel change
  wifi: mac80211: Schedule regulatory channels check on bandwith change
  wifi: mac80211_hwsim: Add custom reg for DFS concurrent

Ilan Peer (2):
  wifi: cfg80211: Extend support for scanning while MLO connected
  wifi: mac80211: Extend support for scanning while MLO connected

 drivers/net/wireless/virtual/mac80211_hwsim.c | 19 ++++
 include/net/cfg80211.h                        | 16 ++++
 include/uapi/linux/nl80211.h                  | 25 ++++-
 net/mac80211/mlme.c                           |  1 +
 net/mac80211/scan.c                           | 48 +++++++++-
 net/wireless/chan.c                           | 94 +++++++++++++++++--
 net/wireless/nl80211.c                        | 20 ++++
 net/wireless/reg.c                            |  5 +-
 net/wireless/reg.h                            |  5 +
 net/wireless/sme.c                            |  2 +
 10 files changed, 219 insertions(+), 16 deletions(-)

-- 
2.38.1

