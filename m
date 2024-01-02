Return-Path: <linux-wireless+bounces-1409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A39A82222D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614A71C22A89
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE62168B2;
	Tue,  2 Jan 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyxN8Qpz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096F3168C4
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224206; x=1735760206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yGCCiSN7NUAiXMgbIDpYtHfEK84P0nO43OMAg4uMp7g=;
  b=lyxN8QpzWYYp1ajEF+/cqiatfEosM8W82Hf9C+93/y5f0YnuR4Eb/5LY
   jh/bd328me3yyUPalORqIikZu5+ZJWDrCEuwh72T61n1w2KrE1k+3+pj1
   QWSaIRRs+JCcoN+NnotAoEF2pZSaRrAcJl9B7003451HkhiZ4m1002eYT
   TgAzZZBzvM9Pkp0Wr4l2h9YUfFHIJa6x0SN0bjFxx8v2DWS0X889/Ys3I
   ilLB81y1PHLZwEzDNDQe5TpYDEg8wf3/WcvbccCoMML1KMsWjasP2XfJz
   YNxnGB8JGnSIXLPoB64Wmvc69+lVAuHHB3bkasC0bCryMCtfbkIAJKtax
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314348"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314348"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624614"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624614"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:43 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: mac80211: take EML/MLD capa from assoc response
Date: Tue,  2 Jan 2024 21:35:43 +0200
Message-Id: <20240102213313.1d10f1d1dbab.I545e955675e2269a52496a22ae7822d95b40235e@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

The association response is more likely to be correct
than a random scan result, which really also should be
correct, but we generally prefer to take data from the
association response, so do that here as well.

Also reset the data so it doesn't hang around from an
old connection to a non-MLO connection, drivers would
hopefully not look at it, but less surprise this way.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fba596d81280..576ba6b25db9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3086,9 +3086,14 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(sdata->vif.bss_conf.tx_pwr_env, 0,
 	       sizeof(sdata->vif.bss_conf.tx_pwr_env));
 
+	sdata->vif.cfg.eml_cap = 0;
+	sdata->vif.cfg.eml_med_sync_delay = 0;
+	sdata->vif.cfg.mld_capa_op = 0;
+
 	memset(&sdata->u.mgd.ttlm_info, 0,
 	       sizeof(sdata->u.mgd.ttlm_info));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
+
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->neg_ttlm_timeout_work);
 	ieee80211_vif_set_links(sdata, 0, 0);
@@ -4981,16 +4986,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		    eht_ml_elem &&
 		    ieee80211_mle_type_ok(eht_ml_elem->data + 1,
 					  IEEE80211_ML_CONTROL_TYPE_BASIC,
-					  eht_ml_elem->datalen - 1)) {
+					  eht_ml_elem->datalen - 1))
 			supports_mlo = true;
-
-			sdata->vif.cfg.eml_cap =
-				ieee80211_mle_get_eml_cap(eht_ml_elem->data + 1);
-			sdata->vif.cfg.eml_med_sync_delay =
-				ieee80211_mle_get_eml_med_sync_delay(eht_ml_elem->data + 1);
-			sdata->vif.cfg.mld_capa_op =
-				ieee80211_mle_get_mld_capa_op(eht_ml_elem->data + 1);
-		}
 	}
 
 	/* Allow VHT if at least one channel on the sband supports 80 MHz */
@@ -5432,6 +5429,13 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 					   assoc_data->ap_addr);
 				goto abandon_assoc;
 			}
+
+			sdata->vif.cfg.eml_cap =
+				ieee80211_mle_get_eml_cap((const void *)elems->ml_basic);
+			sdata->vif.cfg.eml_med_sync_delay =
+				ieee80211_mle_get_eml_med_sync_delay((const void *)elems->ml_basic);
+			sdata->vif.cfg.mld_capa_op =
+				ieee80211_mle_get_mld_capa_op((const void *)elems->ml_basic);
 		}
 
 		sdata->vif.cfg.aid = aid;
-- 
2.34.1


