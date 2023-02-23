Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC866A05BF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjBWKMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbjBWKMO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C8A51906
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147128; x=1708683128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iOzXP8LomyHd700l2Fo775pz3JgmHbSNQy1oTDWNjUM=;
  b=jdJcUNJQwE/jiyH0r9MF1xf0bETH/pY1rblGZ2rxqteYhkMD87/WAbz5
   ktERbzupmTdgn+2ZStmnjjaN43nFjF0EezQ3c80ApBFaCO9Akydl8Amic
   3Y9Hh4x41bJtwfSf1hiZZ74jKBIzpRknezmejdzPCw0PlUlFuWF8q+Vbd
   KUga29Q+L+NLIdhUx9Lcmn19kx79YxpBCjjdfWs6iPeG+JNPoqtMtXeNv
   Tn5x1CTAv4wggrydsGjiPmCq0sBL85BFxGWQCQFJf2/ML9WmcSQL/oreG
   xvS9l8mgWltqkh4cWz2WdxAjJJvkZsy+wG2ZGA69pk4NUY4raMuu58K0U
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396294"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396294"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245231"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245231"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:31 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/21] wifi: mac80211: allow beacon protection HW offload
Date:   Thu, 23 Feb 2023 12:09:26 +0200
Message-Id: <20230223114629.14e4b5885273.I6c0b9c50c6a481128ba912a11cb7afc92c4b6da7@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In case of beacon protection, check if the key was offloaded
to the hardware and in that case set control.hw_key so that
the encryption function will see it and only do the needed
steps that aren't done in hardware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/tx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1f9294f5baa4..628d60f3db2a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5121,6 +5121,10 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 		return -EINVAL;
 	}
 
+	if (!(tx.key->conf.flags & IEEE80211_KEY_FLAG_SW_MGMT_TX) &&
+	    tx.key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE)
+		IEEE80211_SKB_CB(skb)->control.hw_key = &tx.key->conf;
+
 	tx.local = local;
 	tx.sdata = sdata;
 	__skb_queue_head_init(&tx.skbs);
-- 
2.38.1

