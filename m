Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C898E7A4819
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbjIRLMe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241496AbjIRLMN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77618F
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695035527; x=1726571527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVi41lCDPkkaIJhz3Xj2pBMfT3Zsq5IDRhJyTVIAQ8o=;
  b=JYuH38PYfAqOnWNaJj2ScwLI9FmJZS3Eoe6zrJJ/oY6FWCCeqtysrT5v
   5EwMtUztIYkGTwA0B9tZWjc1l7qWNx2ir9DBPe16JWs/Cwp+mAgEW/5aA
   buZT2HekoD3K4OGwOYWcRz+3PEkH+BRf7oqBvbPQX5Eig66yTrZSznQYc
   IHIK9BzpWofnPqy686QanIFf3Yka4V4uKCeA+KUl5MU6FTtJU1VVRvcAI
   65wlIrgNDV5kVe9qjHJMjfhTP1Z+YpEWeGS0h+MxheNFKsRyvtN5qJePe
   gxkXtEpSk+HRq138qvDIbpYfljp0iJLRGHJ0q+p8ziroKJ/U9xoHHxuSA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="378535891"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="378535891"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="861025479"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861025479"
Received: from guyarad-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.14])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 04:12:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/18] wifi: mac80211_hwsim: Handle BSS_CHANGED_VALID_LINKS
Date:   Mon, 18 Sep 2023 14:10:57 +0300
Message-Id: <20230918140607.5819e367edc2.I249f52b4773423a33c3121e31002abe0a8d98e78@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918111103.435195-1-gregory.greenman@intel.com>
References: <20230918111103.435195-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

In station mode, set the active links to all the usable
links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 17ecd5fe7258..c7b4414cc6c3 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2445,6 +2445,14 @@ static void mac80211_hwsim_vif_info_changed(struct ieee80211_hw *hw,
 		vp->assoc = vif->cfg.assoc;
 		vp->aid = vif->cfg.aid;
 	}
+
+	if (vif->type == NL80211_IFTYPE_STATION &&
+	    changed & BSS_CHANGED_MLD_VALID_LINKS) {
+		u16 usable_links = ieee80211_vif_usable_links(vif);
+
+		if (vif->active_links != usable_links)
+			ieee80211_set_active_links_async(vif, usable_links);
+	}
 }
 
 static void mac80211_hwsim_link_info_changed(struct ieee80211_hw *hw,
-- 
2.38.1

