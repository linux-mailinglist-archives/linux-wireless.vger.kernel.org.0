Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA6735879
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjFSN1G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFSN1G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 09:27:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB74123
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687181225; x=1718717225;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rkkZTchTSkGJHCgIlIRePoXdkAIYIokSIbmYuEIe80g=;
  b=a0LWzCI97gLcoP+tjqb+gEgO8ke2Nccn+gekd/RRttWKYjjr445sGvbl
   cdTdQ90Amqu0zw28BAZyIJo2ggfDWnJAjrj306bRD02nAtObbfRg42g1I
   fCMkb27ryYtprEY9CwATAZ4EIB6Oi5tYmVzmXzzBorLStUuVea7LPREhf
   EeIeV7L/wRAcD9QI5LPaRG7dFU56c73K/vRZ/8mo014fmf17vSW8GNNNt
   ZGObVWFUTa7yaVyZreTYgC3pLxVLLKDu+WwH+XfSOGrgxAcA+1LWqk959
   koFe+uOf2KY2EjzJeDTjzFr7wXExaE/AX8RcvReYceaOs47/ATC7bnsAW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339240638"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="339240638"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="716871688"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="716871688"
Received: from aadawii-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.201.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 06:27:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 0/9] cfg80211/mac80211 patches from our internal tree 2023-06-19 
Date:   Mon, 19 Jun 2023 16:26:44 +0300
Message-Id: <20230619132653.902084-1-gregory.greenman@intel.com>
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

Alon Giladi (1):
  wifi: mac80211: drop unprotected robust mgmt before 4-way-HS

Benjamin Berg (1):
  wifi: mac80211: avoid lockdep checking when removing deflink

Ilan Peer (1):
  wifi: cfg80211: Retrieve PSD information from RNR AP information

Johannes Berg (6):
  wifi: mac80211: move action length check up
  wifi: mac80211: drop some unprotected action frames
  wifi: mac80211: store BSS param change count from assoc response
  wifi: mac80211: always hold sdata lock in chanctx assign/unassign
  wifi: mac80211: fix CRC calculation for extended elems
  wifi: nl80211/reg: add no-EHT regulatory flag

 include/linux/ieee80211.h    | 71 +++++++++++++++++++++++++++++++++++-
 include/net/cfg80211.h       |  2 +
 include/uapi/linux/nl80211.h |  2 +
 net/mac80211/cfg.c           | 16 +++++---
 net/mac80211/ieee80211_i.h   |  2 +
 net/mac80211/iface.c         |  7 ++++
 net/mac80211/mlme.c          | 16 +++++++-
 net/mac80211/rx.c            | 27 ++++++++++----
 net/mac80211/sta_info.c      |  5 ++-
 net/mac80211/util.c          | 25 ++++++-------
 net/wireless/reg.c           |  4 +-
 net/wireless/scan.c          | 13 +++++++
 12 files changed, 157 insertions(+), 33 deletions(-)

-- 
2.38.1

