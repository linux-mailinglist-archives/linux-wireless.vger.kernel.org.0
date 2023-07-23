Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549975E1AF
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jul 2023 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGWMHg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jul 2023 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGWMHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jul 2023 08:07:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F502E5B
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jul 2023 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690114055; x=1721650055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b6thoYWjp8mQVV1VYXnw2skiXLGMpwG4GHEhAzilOTA=;
  b=YidQaSq6R18aXcPb3tZF8a1lCGwIDrhHKGdr4BiU8ffm2R2P1Gjfgb8m
   XarqxfXqshnzZYp9iTB9CnBrNJ0CnVjMjEUmJ6fIqA/iWH4HN0o1U/Q0U
   DoT4GlvfqMO/ni/gMExSZm0Yhveqe3C3hMoSLEEkO31lJLvpxiSV6wnXR
   EnvS84QgQnVfzzKbhTb1d5p6PQJluVUffoGN/tjb+7GruF8RlUOBiHbQT
   HWeK7JTSFD1UZVTIPS3GBE3Qon3/O/f8+u6CCVyDeNy+xc1x0cQ26Jps+
   Y1RG79US/zekQe9VKm4lNovt3J1RIv7AjGfMNMPC/8zeejbwPtQ71NUut
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="433509105"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="433509105"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 05:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="795489488"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="795489488"
Received: from jed01829.iil.intel.com ([10.12.217.181])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2023 05:07:33 -0700
From:   Ilan Peer <ilan.peer@intel.com>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2] wifi: cfg80211: Fix return value in scan logic
Date:   Sun, 23 Jul 2023 23:10:43 +0300
Message-Id: <20230723201043.3007430-1-ilan.peer@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As cfg80211_parse_colocated_ap() is not expected to return a negative
value return 0 and not a negative value if cfg80211_calc_short_ssid()
fails.

Fixes: c8cb5b854b40f ("nl80211/cfg80211: support 6 GHz scanning")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217675
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

