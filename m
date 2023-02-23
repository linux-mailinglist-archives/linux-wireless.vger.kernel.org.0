Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369A86A05C7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjBWKM0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjBWKMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9C51906
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147136; x=1708683136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rot+OKbv/dSXGiUk1D84zOWaHuUB3SXGd66605W/Hfo=;
  b=A/LLxMzs2g6ZTdBoeGRHPcLAwTV4wk7tJKEpLVUr1roIlcKU8/tNTt/O
   9GDi/+dKk0g0dNbrd7nUHL0JVXTeOvYKfFkVj7NeF0+cELdBwY2uPgNYZ
   dZ7nSh7Vvwq4rVtQdnee523cUJ2+AfNlgBmHia9iH/ABTzUiKp3ekhSD6
   pT08YTkFN+s5IMPWDccWhStnVP1loPMghTsEnO9y3TyMNnfcNOu8HHpzR
   EbA1PZ3CZC3mAyvb2xdpKkAs7cC7dhcK6jNMigxSVlMxE/KTqryT52IZN
   RhAAsSQVH/5NYAAOstQpEmJYlMvATfuVVqf8Hl+VrtLR8gShzA/IESSF1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396406"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396406"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245500"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245500"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:53 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/21] wifi: mac80211: add pointer from bss_conf to vif
Date:   Thu, 23 Feb 2023 12:09:34 +0200
Message-Id: <20230223114629.13d09e0ef71d.I20390b2a8165ff222d66585915689206ea93222b@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

While often not needed, this considerably simplifies going from a link
specific bss_config to the vif. This helps with e.g. creating link
specific debugfs entries inside drivers.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h | 3 +++
 net/mac80211/link.c    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6946c9d95aec..2a1874d994e0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -534,6 +534,7 @@ struct ieee80211_fils_discovery {
  * This structure keeps information about a BSS (and an association
  * to that BSS) that can change during the lifetime of the BSS.
  *
+ * @vif: reference to owning VIF
  * @addr: (link) address used locally
  * @link_id: link ID, or 0 for non-MLO
  * @htc_trig_based_pkt_ext: default PE in 4us units, if BSS supports HE
@@ -675,6 +676,8 @@ struct ieee80211_fils_discovery {
  *	bandwidth
  */
 struct ieee80211_bss_conf {
+	struct ieee80211_vif *vif;
+
 	const u8 *bssid;
 	unsigned int link_id;
 	u8 addr[ETH_ALEN] __aligned(2);
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 8c8869cc1fb4..e6f9fce1dadb 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -34,6 +34,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	link->link_id = link_id;
 	link->conf = link_conf;
 	link_conf->link_id = link_id;
+	link_conf->vif = &sdata->vif;
 
 	INIT_WORK(&link->csa_finalize_work,
 		  ieee80211_csa_finalize_work);
-- 
2.38.1

