Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D215D7A8BB3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjITS07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjITS06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B825FEC
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234401; x=1726770401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVi41lCDPkkaIJhz3Xj2pBMfT3Zsq5IDRhJyTVIAQ8o=;
  b=crtGWwqIKzMHUlnAmyATvc8bBQvUwWMLDOKpvqU7L1UJWBYGJDlF5KNg
   GxWLiOFZhi2UgpfwjfO2q/IXNjdk49qXnCQxPWlRwt9j2PLeEPzp05tl2
   EkbDpA5gJZLvkTJLzyWdlkIxZdacis059x01OzU3pZuH+uMBFaVlECf7c
   BksnDAOq30nz+48cjWTcYTWCyPfhPKMyp3vuQJ+ogPn7NZ7EdSmyXMLeV
   JRiXs9FhZwPLXVD3UJMQA4VNC9DyqFqsdnCgA4X55PsiWwCiEJCphlk5f
   /DXJ4WlmxkZtu34Fvoz+jibTSStAJq4DSa4odoCg2F6s1oX7s57NaLoJq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556425"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424258"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424258"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 12/18] wifi: mac80211_hwsim: Handle BSS_CHANGED_VALID_LINKS
Date:   Wed, 20 Sep 2023 21:25:23 +0300
Message-Id: <20230920211508.6218307226d3.I249f52b4773423a33c3121e31002abe0a8d98e78@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
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

