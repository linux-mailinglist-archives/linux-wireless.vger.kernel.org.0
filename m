Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604BA6A05BE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjBWKMP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjBWKMM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B7C4ECD6
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147126; x=1708683126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XLVdsPgOX3Umo5RtJVhKiesnGNhn/vnt2Y6G6T1/jYk=;
  b=LQhEPd0tUwyF3NEZZ8/mxJNlGNcSRVPKlU90/ItN2GivFnkv4lc0YIQy
   zgWbqhgrQlqFsL5ZUeAKjZBT+pVj/BxZJBx5MaUikX9BvOmRO93M7CaWb
   d71WfDsHoKbc9DhaQEeg5zQ1Dbxqr10OCQDGGNjtWBKi8+7f37k6lSHuM
   5ZZhRje4fAM9AE0hH971mXhQebmGCthlD91UobDW5wtznJ0MCeWatLQGe
   QL6eJKrRDM4udkYZBZpsTN0m+hyKlWV68ifob+Um2cOBc0oeUePXGVSFD
   ZqoE5jzVqxpFUhtcdURoHDJQRk11d/w8WIHIfLxNopZzk5VbvBdvYVKAb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396307"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396307"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245252"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245252"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:34 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/21] wifi: net: wireless: return primary channel regardless of DUP
Date:   Thu, 23 Feb 2023 12:09:27 +0200
Message-Id: <20230223114629.b054806047f4.I5e0add054f72ede95611391b99804c61c40cc959@changeid>
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

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently in case DUP bit is not set we don't return the primary
channel for 6Ghz Band (UHB), but from spec seems that
DUP has no affect on primary channel for UHB,

9.4.2.249 HE Operation element:
	The Duplicate Beacon subfield is set to 1 if the AP transmits
Beacon frames in non-HT duplicate PPDU with a TXVECTOR parameter
CH_BANDWIDTH value that is up to the BSS bandwidth and is set to
0 otherwise.

So remove the condition for returning primary channel based on DUP.

About RSSI for DUP beacon no need to mark it as invalid, due to the
code calling the function check marks signal invalid in case beacon
freq is not the freq we received it on, which is the case for DUP beacon
on non primary channels.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 790bc31cf82e..72e9af6158ef 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1830,9 +1830,7 @@ int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
 			if (!he_6ghz_oper)
 				return -1;
 
-			if (ftype != CFG80211_BSS_FTYPE_BEACON ||
-			    he_6ghz_oper->control & IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON)
-				return he_6ghz_oper->primary;
+			return he_6ghz_oper->primary;
 		}
 	} else if (band == NL80211_BAND_S1GHZ) {
 		tmp = cfg80211_find_elem(WLAN_EID_S1G_OPERATION, ie, ielen);
-- 
2.38.1

