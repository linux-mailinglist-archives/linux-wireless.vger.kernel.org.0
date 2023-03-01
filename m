Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB96A6A99
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCAKLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 05:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjCAKKp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 05:10:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D93B67D
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 02:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677665434; x=1709201434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rot+OKbv/dSXGiUk1D84zOWaHuUB3SXGd66605W/Hfo=;
  b=JDUcl4NE843FMyhTdSVPtTJugwpuKpY80XwZQdK5lI1RbdX4jPAmg9/L
   LZ1bIfEI3ngv18/01YDGkyRJ1PnQBXy8qRTr2WiT02gTiBK80Ko8CFWAh
   TGFi8jKUoagAAm8X7LjiJWJ9vd6KtabTOe/qnhPIhconrqSsSvOOBbP9j
   a5N3LjkP12aB+DhqZJTEteR9eqmYG5zt8jeEGScuMSMq2Sv9a1fbjw8r/
   EHhlkVW7zir/ieGWj9ckoMzVWc3my8aFyz3Uqfpfp9bmnkYQE8YRMJgKh
   8uMoceJhTnSoNrIAipdCrlXPhgCJFwS4Ex11SS2HUQe1Aw8FPHra+8mkK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="336662891"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="336662891"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738589145"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="738589145"
Received: from omimran-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 02:10:32 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 13/23] wifi: mac80211: add pointer from bss_conf to vif
Date:   Wed,  1 Mar 2023 12:09:25 +0200
Message-Id: <20230301115906.46f701a10ed5.I20390b2a8165ff222d66585915689206ea93222b@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230301100935.170922-1-gregory.greenman@intel.com>
References: <20230301100935.170922-1-gregory.greenman@intel.com>
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

