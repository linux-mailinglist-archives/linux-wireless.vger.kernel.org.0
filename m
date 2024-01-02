Return-Path: <linux-wireless+bounces-1401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4408D822222
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB13B1F23148
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012616401;
	Tue,  2 Jan 2024 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Usi5rIQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59E1641A
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224184; x=1735760184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KFKHt6GA68DxXHYXjvPJwwr31wonVO+3lFa737ObiXw=;
  b=Usi5rIQYw3IO3ZJImTkcfD4SdP898UJbVFHX1YM2sEKQpi7NM5v9LsNn
   T715UtjS5X1S47SbzE+HGD9XWPV7kLawzxgNr/qvrr0IR3+VppWdrdQtQ
   cbLHZhgWLjVtJ9KYl0vlU9HOabMEAPPeJ6AkfvfMkW6HSwMW61ReFtZ21
   m/Ka5g91LqMdAKvuPnmivLgYoDXdbJ5X1SLJKVPbgqqXLZs6qUxX2u6EZ
   fDeLagmFKVAahbgW7rsf3NB67gJMN7MwL1por0iifhFlJKrTeSCUvwQ1X
   CLgLRKV3iVDBTjrrBn99UUufeSsbVSg7pwOKEixvNJ9u1Y0zbznquRjzQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314311"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314311"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624514"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624514"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/15] wifi: mac80211_hwsim: handle TID to link mapping neg request
Date: Tue,  2 Jan 2024 21:35:35 +0200
Message-Id: <20240102213313.dfa8e132d0cd.I5fbec1fef933980819ea39c1227f37d307ab1145@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

Accept the request if all TIDs are mapped to the same link set,
otherwise reject it.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index a84340c2075f..e144cd30ae3f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2738,6 +2738,24 @@ static int mac80211_hwsim_get_survey(struct ieee80211_hw *hw, int idx,
 	return 0;
 }
 
+static enum ieee80211_neg_ttlm_res
+mac80211_hwsim_can_neg_ttlm(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_neg_ttlm *neg_ttlm)
+{
+	u32 i;
+
+	/* For testing purposes, accept if all TIDs are mapped to the same links
+	 * set, otherwise reject.
+	 */
+	for (i = 0; i < IEEE80211_TTLM_NUM_TIDS; i++) {
+		if (neg_ttlm->downlink[i] != neg_ttlm->uplink[i] ||
+		    neg_ttlm->downlink[i] != neg_ttlm->downlink[0])
+			return NEG_TTLM_RES_REJECT;
+	}
+
+	return NEG_TTLM_RES_ACCEPT;
+}
+
 #ifdef CONFIG_NL80211_TESTMODE
 /*
  * This section contains example code for using netlink
@@ -3903,6 +3921,7 @@ static const struct ieee80211_ops mac80211_hwsim_mlo_ops = {
 	.change_vif_links = mac80211_hwsim_change_vif_links,
 	.change_sta_links = mac80211_hwsim_change_sta_links,
 	.sta_state = mac80211_hwsim_sta_state,
+	.can_neg_ttlm = mac80211_hwsim_can_neg_ttlm,
 };
 
 struct hwsim_new_radio_params {
-- 
2.34.1


