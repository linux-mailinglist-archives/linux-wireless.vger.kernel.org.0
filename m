Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEEE72B110
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jun 2023 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjFKJOo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Jun 2023 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKJOm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Jun 2023 05:14:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E9193
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jun 2023 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686474881; x=1718010881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W7uCkVvG5060QxQ/5oX+ota6FmLX5rWGz6zeSnNeSUM=;
  b=Qf7dokrDh9UcTOLHV/DKb9Kw2H9F4U1PaYQddKXwkO6LbxDcV5hf3Y5b
   mHrd4R0PEngs606bRBhXlKTGbdy4ibUuX2FC0Z5PTxJ9VOUGSBq1EjYGJ
   +S7qgsSLXA2XEmtoG/T6Ohy5v03vEYmuof3rog3V2EX4LIouvQoGbBKCK
   sXAnFh68UNsVQ52aiZ/i1DT83UTvW1TBQ5CmxABAG+uIHDG9Z2cntK416
   zQ0IiDMAeQrEKtYXtZu6dCIIfQhTYBP6aE4ta+H8tQW8GwUUraxsevqPL
   FcMZ62joVz74RTnZZP9p2/CYR6Bl8Un2x4BBj2b2NOn43Trpkpyan4lVl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="347488928"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="347488928"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688249728"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="688249728"
Received: from rganonx-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.222.121])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:14:39 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/4] cfg80211/mac80211 patches from our internal tree 2023-06-08 
Date:   Sun, 11 Jun 2023 12:14:25 +0300
Message-Id: <20230611091429.24517-1-gregory.greenman@intel.com>
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

Hi

A bunch of patches from our internal tree with mac80211 and
cfg80211 changes. It's the continuation of the previous patch set,
sent on 2023-06-08. 

Thanks,
Gregory

Benjamin Berg (1):
  wifi: mac80211: fragment per STA profile correctly

Ilan Peer (3):
  wifi: mac80211: Add debugfs entry to report dormant links
  wifi: mac80211: Do not use "non-MLD AP" syntax
  wifi: mac80211: Fix permissions for valid_links debugfs entry

 include/net/mac80211.h        |  9 ++++++---
 net/mac80211/debugfs_netdev.c | 23 +++++++++++++++--------
 net/mac80211/ieee80211_i.h    |  2 +-
 net/mac80211/mlme.c           |  5 +++--
 net/mac80211/util.c           |  4 ++--
 5 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.38.1

