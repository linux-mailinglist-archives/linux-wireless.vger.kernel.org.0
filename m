Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE298732803
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbjFPGzC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbjFPGyr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4782965
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898486; x=1718434486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z7hwSfDKiy630sJ/J6AQ6Fc8dquSVM/FwxTkleLgXhA=;
  b=BmowvnMIFHvC0xersb+lvxmUrU2Y6eRPov7b2XwdyLJVQt3MUW9gtnsm
   klV3b7V3Fsq27kZsxvmuYU3aif4M0mIsOFMrupLKTCXPBfWTIGLd4IdPq
   g0mnwixdJcMJWLaSQgYX4zdfaU4fTg4Gq9CZoc3BiWffMeUJlH0forgsJ
   NZwh7gRAAIwc2JOFFQyE7NspHeELB2mXcBt2Vl3WPUqMyH9qZ+MnNONJB
   O/APDZNjJ+LJdognTBFhfQi0hJRWWxXeURlOkZF/ML9fFb3S/aEXv59TC
   A7NLCL9GbIkxKIMWx+U0JpdqScZBfLls46c0ICa2a7guuCzP9pB9n8lUQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078862"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078862"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720086"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720086"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/20] wifi: mac80211: feed the link_id to cfg80211_ch_switch_started_notify
Date:   Fri, 16 Jun 2023 09:53:57 +0300
Message-Id: <20230616094948.41e662ba1d68.I8faae5acb45c58cfeeb6bc6247aedbdaf9249d32@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

For now, fix this only in station mode. We'll need to fix
the AP mode later.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 171ba9d237c2..1fc66f09cbb8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1981,8 +1981,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 	mutex_unlock(&local->mtx);
 
-	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef, 0,
-					  csa_ie.count, csa_ie.mode, 0);
+	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef,
+					  link->link_id, csa_ie.count,
+					  csa_ie.mode, 0);
 
 	if (local->ops->channel_switch) {
 		/* use driver's channel switch callback */
-- 
2.38.1

