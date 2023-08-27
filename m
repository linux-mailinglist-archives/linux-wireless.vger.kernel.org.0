Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ACB789D25
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjH0LGg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjH0LGO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:06:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F7139
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134372; x=1724670372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wnp93dS+Mq8NPs2vjDT4631SGyxRUUC7eMxxB9BP7fU=;
  b=eYNgQGRMmxdRygvHiu3DwfKTY1IY6HsOX0OtVwhKIiiCx68M1jMbPQY3
   t1HzkYuL6god1qNTPiVPTl7eJLPR29JVbnNHfPUMNriHC9iuoyIojv1Fq
   +mkdLhV1mR/cmDtH1scRpL1c7bBPqqxc7NeGlqbCx9YbFGrGXZkq6lC4q
   jZftuvbTpjOCkH0p9zhW3Q0UxLD3YfpzAFuJ/J6iAbcMgIe8jFK2YNgCB
   md7MwtQbIBh/bpLGeJ4VbsRtIl30xxgwYmgBmAwb0tm6eeSalJpyTmaxz
   O1fXjEr2kYXeGeZzJc8vvXFyWbAHgCfa+dQB2rE0kRLmZmtcI939hLkl8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301577"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301577"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881633010"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:06:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: mac80211: Print local link address during authentication
Date:   Sun, 27 Aug 2023 14:05:29 +0300
Message-Id: <20230827135854.9c08605e2691.I0032e9d6e01325862189e4a20b02ddbe8f2f5e75@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
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

To ease debugging, mostly in cases that authentication fails.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/mlme.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ca6045f56b4b..a93fbed69a70 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7085,6 +7085,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_auth_data *auth_data;
+	struct ieee80211_link_data *link;
 	u16 auth_alg;
 	int err;
 	bool cont_auth;
@@ -7208,8 +7209,6 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 					    false);
 	}
 
-	sdata_info(sdata, "authenticate with %pM\n", auth_data->ap_addr);
-
 	/* needed for transmitting the auth frame(s) properly */
 	memcpy(sdata->vif.cfg.ap_addr, auth_data->ap_addr, ETH_ALEN);
 
@@ -7218,6 +7217,19 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	if (err)
 		goto err_clear;
 
+	if (req->link_id > 0)
+		link = sdata_dereference(sdata->link[req->link_id], sdata);
+	else
+		link = sdata_dereference(sdata->link[0], sdata);
+
+	if (WARN_ON(!link)) {
+		err = -ENOLINK;
+		goto err_clear;
+	}
+
+	sdata_info(sdata, "authenticate with %pM (local address=%pM)\n",
+		   auth_data->ap_addr, link->conf->addr);
+
 	err = ieee80211_auth(sdata);
 	if (err) {
 		sta_info_destroy_addr(sdata, auth_data->ap_addr);
-- 
2.38.1

