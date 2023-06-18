Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B77347C8
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjFRSuz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFRSuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E808E51
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114250; x=1718650250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aYbssBODr05moZq26emV/XshR6vJNeEPNs13tWhCXRg=;
  b=a6Aj55XPS6hzWGYKAlSQE2GjSOEt5sK8+2VUoDklXyNF5qCWUTqQZVGB
   z7gDbBaRfklVJndsrrWUJzrxXvftbiB8XFny6v9oEDfkTU+a7IYa1fo21
   8pd5wbMVGaUjm/7E6RcW4dK5WvytaykHlFHMcbvS6QkFALxcG30886hvo
   wS2bPZ23MEOEYb6J3bgpoOnJOrlZY+ZKwyJUr+tvJFAMBgp27GPNoPGMQ
   oi0hsu6VIgCb+vog9KwZPNjJWvcQkORGy1jYAOTdHXGYYywykQOcCPwFY
   gnT4unh5zZ7/jzvXYt6EGdSXlXMmjQfx1Lo4pt1vph6F5X17gMhpsrLIz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116662"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116662"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:50 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234056"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234056"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/20] wifi: ieee80211: reorder presence checks in MLE per-STA profile
Date:   Sun, 18 Jun 2023 21:49:56 +0300
Message-Id: <20230618214436.fdbf17320a37.I517cf27fdc3f6e5d6a2615182da47ba4bdf14039@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

In ieee80211_mle_sta_prof_size_ok(), the presence
checks aren't ordered by field order, so that's a
bit confusing. Reorder them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 98223b665456..fc3c26f1b718 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4876,9 +4876,6 @@ static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 		info_len += 8;
 	if (control & IEEE80211_MLE_STA_CONTROL_DTIM_INFO_PRESENT)
 		info_len += 2;
-	if (control & IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT)
-		info_len += 1;
-
 	if (control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE &&
 	    control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE) {
 		if (control & IEEE80211_MLE_STA_CONTROL_NSTR_BITMAP_SIZE)
@@ -4886,6 +4883,8 @@ static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 		else
 			info_len += 1;
 	}
+	if (control & IEEE80211_MLE_STA_CONTROL_BSS_PARAM_CHANGE_CNT_PRESENT)
+		info_len += 1;
 
 	return prof->sta_info_len >= info_len &&
 	       fixed + prof->sta_info_len <= len;
-- 
2.38.1

