Return-Path: <linux-wireless+bounces-8-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617D87F68FD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934C91C209CC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2AC33092;
	Thu, 23 Nov 2023 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rHax5LHP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704D9D64
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TKYfuNSNeNnvEUmjh4pr20odwS4M+QXd1x4w8HGydEo=;
	t=1700778476; x=1701988076; b=rHax5LHP7d/G8cuvAEErQeGrxEphbMd5baKhQqv+nuZIofU
	rHev2Rc9rDghPLfFZ9K1UvQ+8xtDQDJuryjAKt6rH9ve5pfUvm/790jhmZBsi+XdCL+pvJeqvtm05
	sg0pdCNCTNyiGnn3PiyTQwO3+uF6qxxRxoroniK24b69DnLnxhDBbc/W4uBj86rx5ZeDncseI+fZk
	5LW+llOLr+s1hLzAT5PYuKw7yu4u40VS8QQKwzzX6VeiJJPXU2GDNu9oVXti5xMmfeGyuKCNTBzyn
	E6ASxIfPWgw92IoU/UYXUj3+wMLoUHptzVwJokpzTJ1ABGRR/QWGcVQPVXc35H4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAr-00000001Y53-2Ru6;
	Thu, 23 Nov 2023 23:27:53 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 02/13] wifi: mac80211: take EML capa/delay from assoc response
Date: Thu, 23 Nov 2023 23:14:39 +0100
Message-ID: <20231123231436.5bd5d9a20c39.I545e955675e2269a52496a22ae7822d95b40235e@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
---
 net/mac80211/mlme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 778eef2f06f1..2cdafabe46e0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3068,6 +3068,9 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(sdata->vif.bss_conf.tx_pwr_env, 0,
 	       sizeof(sdata->vif.bss_conf.tx_pwr_env));
 
+	sdata->vif.cfg.eml_cap = 0;
+	sdata->vif.cfg.eml_med_sync_delay = 0;
+
 	memset(&sdata->u.mgd.ttlm_info, 0,
 	       sizeof(sdata->u.mgd.ttlm_info));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
@@ -4961,14 +4964,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
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
-		}
 	}
 
 	/* Allow VHT if at least one channel on the sband supports 80 MHz */
@@ -5416,6 +5413,11 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 					goto abandon_assoc;
 				}
 			}
+
+			sdata->vif.cfg.eml_cap =
+				ieee80211_mle_get_eml_cap((const void *)elems->ml_basic);
+			sdata->vif.cfg.eml_med_sync_delay =
+				ieee80211_mle_get_eml_med_sync_delay((const void *)elems->ml_basic);
 		}
 
 		sdata->vif.cfg.aid = aid;
-- 
2.42.0


