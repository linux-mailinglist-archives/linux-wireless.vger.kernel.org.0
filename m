Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D4D7327FC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFPGy7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243313AbjFPGyq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9B1FE8
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898485; x=1718434485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSiwSDUtBRojHisQFABP50ysAph75Bvd/nyXMbVHAQY=;
  b=H73B5ZJZtPtNPol67L2CGerJPHd5j1HCCZQCbKDN0Wj5tz5GWZyKR/RN
   FMLabMW2stwRriCMPo4hVfcEOKfmpw9xggej7nCLc3u8Z3eW6nUpQ0hv8
   28TwkORUSwo+9fMnoammdyQ4dW+Tj8qRTfMMaXim5Z69CezJWXDo/yqRO
   SbizW1z0Mh5stGCcJe/3K3k3pan/TS8/G3DicW21M1Yq3tGK0y+n7yZ7E
   N/Vpvvbta55jGta8NIWX4w7lc/XHWz+TQCjeX+LljOEaj9jyzfOc3Vsz1
   rlFwbOPFbYFwKddEPXBp7am0REavhXVXittfAikIBjcoDEF2bbsSzzW4g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078859"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078859"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720061"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720061"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/20] wifi: mac80211: add consistency check for compat chandef
Date:   Fri, 16 Jun 2023 09:53:56 +0300
Message-Id: <20230616094948.ae0f10dfd36b.Iea98c74aeb87bf6ef49f6d0c8687bba0dbea2abd@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add NULL check for compat variable to avoid crash in
cfg80211_chandef_compatible() if it got called with
some mixed up channel context where not all the users
compatible with each other, which shouldn't happen.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/chan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 168bf3edd4b4..68952752b599 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -802,6 +802,11 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 		}
 	}
 
+	if (WARN_ON_ONCE(!compat)) {
+		rcu_read_unlock();
+		return;
+	}
+
 	/* TDLS peers can sometimes affect the chandef width */
 	list_for_each_entry_rcu(sta, &local->sta_list, list) {
 		if (!sta->uploaded ||
-- 
2.38.1

