Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D4758E17
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 08:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGSGsU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 02:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjGSGsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 02:48:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9B1BFD
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jul 2023 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689749299; x=1721285299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eOYM3iN0mfoqzR+XbZE5GPSe5JYgB81uPM28Ed9uHo0=;
  b=Fn8+HI1KlRAHu95hkddp7VvB0nL1ySCw3tceLzEjDorOyYo1wfTRkucY
   XOMRps4GrfJYzwl3KLOAIQKWufm48rJ9QyF9jr+cCElj/wjLNb+3Rdvn7
   Ql/ybg7P7vfv8u3tJcfYRXhpL9ZehrN5q8RXqqKGPq/PvO3iEmtemuL/4
   FZDpu7ZRNgHuYXfJI8vsLTEZMgIqzEOISEBn9xDPLHZLL5Gf1eXz/d/z9
   NwPmplAGrt3PGbTloOB8X4cHx17Owhdfxzv4H2SZ+Tlglpoy3RWuoxnGC
   +u+c15rS1uPkLQHy+Rg8T3ldgMfJYfpdTl4FZUKS5EF7JAQu12va3VSlh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="369033242"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="369033242"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 23:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="814026998"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="814026998"
Received: from jed01829.iil.intel.com ([10.12.217.181])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jul 2023 23:48:17 -0700
From:   Ilan Peer <ilan.peer@intel.com>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH] wifi: cfg80211: Fix return value in scan logic
Date:   Wed, 19 Jul 2023 17:51:20 +0300
Message-Id: <20230719145120.739521-1-ilan.peer@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As cfg80211_parse_colocated_ap() is not expected to return a negative
value return 0 and not a negative value if cfg80211_calc_short_ssid()
fails.

This bug was introduced in commit c8cb5b854b40f
('nl80211/cfg80211: support 6 GHz scanning').

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 8bf00caf5d29..0cf1ce7b6934 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -657,7 +657,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 
 	ret = cfg80211_calc_short_ssid(ies, &ssid_elem, &s_ssid_tmp);
 	if (ret)
-		return ret;
+		return 0;
 
 	for_each_element_id(elem, WLAN_EID_REDUCED_NEIGHBOR_REPORT,
 			    ies->data, ies->len) {
-- 
2.25.1

