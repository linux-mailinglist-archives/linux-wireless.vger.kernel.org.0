Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6957327F9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjFPGza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbjFPGzO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:55:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCAB1FF5
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898509; x=1718434509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t84rtVX0C/jy873IwEAxa8fWj0TWWL+5VhYiXFAJnVs=;
  b=FilN8wN94JjNs+nnxAYzUtflqeKlgtvHAmzB16Zx1B14Ko31YFWGU1Yt
   UyWtEOp3P83fmx5Z5CLLlQ/jnISrFhIXULngDsSNOBwC7Nyu3/VtKWqnY
   mKpkAdojt2w4VJkfXdxvL6Ta/6xiq2ZiAnr9LRU59VXHUP8T06/YAXup8
   Z1LawXWh1qjQRUhzplMTUCox6d4VnZj7KCDxNoR7bKgmqfa3XotIotwGS
   BhcKs6qntzZ34HZ3CSkZhvxJOgLfrla4UGUHth1jdgPXhPthEa5xXmv88
   zL9iyL/66kpH8hRjEKcVpVmiMcEdBa6t/zuFJGP4Kj8zhCkoeB6QnVmUh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078933"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720520"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720520"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:55:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 20/20] wifi: mac80211: Rename ieee80211_mle_sta_prof_size_ok()
Date:   Fri, 16 Jun 2023 09:54:09 +0300
Message-Id: <20230616094949.9bdfd263974f.I7bebd26894f33716e93cc7da576ef3215e0ba727@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

Rename it to ieee80211_mle_basic_sta_prof_size_ok() as it
validates the size of the station profile included in
Basic Multi-Link element.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 6 ++++--
 net/mac80211/util.c       | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 47ddc65b443b..aeedd49e5101 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4798,11 +4798,13 @@ struct ieee80211_mle_per_sta_profile {
 } __packed;
 
 /**
- * ieee80211_mle_sta_prof_size_ok - validate multi-link element sta profile size
+ * ieee80211_mle_basic_sta_prof_size_ok - validate basic multi-link element sta
+ *	profile size
  * @data: pointer to the sub element data
  * @len: length of the containing sub element
  */
-static inline bool ieee80211_mle_sta_prof_size_ok(const u8 *data, size_t len)
+static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
+							size_t len)
 {
 	const struct ieee80211_mle_per_sta_profile *prof = (const void *)data;
 	u16 control;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1e104c8756b1..2c53f6e17cfe 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1496,7 +1496,8 @@ static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
 		if (sub->id != IEEE80211_MLE_SUBELEM_PER_STA_PROFILE)
 			continue;
 
-		if (!ieee80211_mle_sta_prof_size_ok(sub->data, sub->datalen))
+		if (!ieee80211_mle_basic_sta_prof_size_ok(sub->data,
+							  sub->datalen))
 			return;
 
 		control = le16_to_cpu(prof->control);
-- 
2.38.1

