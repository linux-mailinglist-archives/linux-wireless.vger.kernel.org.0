Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D159B7347BB
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFRSuT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFRSuS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F01AA
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114215; x=1718650215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s9sRJC1p3NVVKEhnvDXVRQKzRmPhQ7x/agtXXOTvpYk=;
  b=GhX+bJS253w6XqLnmCpDmIFv18OQ6g7NaX6RoNVslFQQ1tGBCUpgUtrX
   7fYG27SY4k06fJvJkyRVVrr70xgddi7x191pnMdtlAmj4NuMrM+GJ1cj4
   QVydh036C4Wo8seKrekumS2F+EuXikU2WWQfqGEeT1AHEw6kMIc5VzZu9
   Zcn+gizG80YY63kIpyh3rMl5CppRYZTfbY1pjnbHmcmCXkdkfgYuIzdpy
   XWsYgy3wvjn/ghZJI/GqTFHKOXarVITZymoW9f/okAoPAsgxGIal6qvvs
   UDPXXJEaFEV99+N1JhTq+Ebc4Wk96AUcm6qD8svxzcXqXvQ69sm4qxnip
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116620"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:14 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233825"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233825"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 00/20] cfg80211/mac80211 patches from our internal tree 2023-06-18 
Date:   Sun, 18 Jun 2023 21:49:42 +0300
Message-Id: <20230618185002.817236-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Benjamin Berg (11):
  wifi: ieee80211: add helper to validate ML element type and size
  wifi: ieee80211: use default for medium synchronization delay
  wifi: cfg80211: Always ignore ML element
  wifi: ieee80211: add definitions for RNR MLD params
  wifi: cfg80211: use a struct for inform_single_bss data
  wifi: ieee80211: add structs for TBTT information access
  wifi: cfg80211: use structs for TBTT information access
  wifi: cfg80211: handle BSS data contained in ML probe responses
  wifi: cfg80211: do not scan disabled links on 6GHz
  wifi: cfg80211: stop parsing after allocation failure
  wifi: cfg80211: search all RNR elements for colocated APs

Ilan Peer (4):
  wifi: cfg80211: Support changes in AP MLD link state change
  wifi: mac80211: Include Multi-Link in CRC calculation
  wifi: ieee80211: Fix the common size calculation for reconfiguration ML
  wifi: mac80211: Support link removal using Reconfiguration ML element

Johannes Berg (5):
  wifi: ieee80211: reorder presence checks in MLE per-STA profile
  wifi: mac80211: agg-tx: add a few locking assertions
  wifi: mac80211: agg-tx: prevent start/stop race
  wifi: update multi-link element STA reconfig
  wifi: mac80211: check EHT basic MCS/NSS set

 include/linux/ieee80211.h    | 174 ++++++--
 include/net/cfg80211.h       |  14 +
 include/uapi/linux/nl80211.h |   3 +
 net/mac80211/agg-tx.c        |  14 +-
 net/mac80211/ieee80211_i.h   |   3 +
 net/mac80211/mlme.c          | 251 +++++++++++-
 net/mac80211/util.c          |   4 +
 net/wireless/nl80211.c       |  43 ++
 net/wireless/scan.c          | 748 ++++++++++++++++++++++++++---------
 net/wireless/trace.h         |  16 +
 10 files changed, 1045 insertions(+), 225 deletions(-)

-- 
2.38.1

