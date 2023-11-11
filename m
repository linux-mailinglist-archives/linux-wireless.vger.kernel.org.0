Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7F7E86D0
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 01:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjKKAKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Nov 2023 19:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344708AbjKKAKd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Nov 2023 19:10:33 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539C420B
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 16:10:28 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AACC1B00077
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 00:10:26 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 5329A13C2B0;
        Fri, 10 Nov 2023 16:10:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5329A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699661425;
        bh=YoodoAM5IP6e6zuGrtc5M5qq5XBYoUsd2WFRIPdv35k=;
        h=From:To:Cc:Subject:Date:From;
        b=o8+t0itH91TZMvCLRT0zdF50LUG3O32EeXYtySmOjvkUzWvZS4vWrzgZYdcLWVR4r
         QIRd3gCpDq48zulzJB3ho/mzrmZY920ADjTNVDX8IwTIFRyTf2j2T5NrI5/AAsjr8r
         lCUFB3NzXjooMbzhzBG1QYz2H13XIZq5H0bmr0j4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211:  Ensure links are cleaned up when driver fails.
Date:   Fri, 10 Nov 2023 16:10:23 -0800
Message-ID: <20231111001023.1335122-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1699661427-m53deCoLz6Zs
X-MDID-O: us5;ut7;1699661427;m53deCoLz6Zs;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

On cleanup paths, links need to be deleted even if the driver fails
to do so.  Add a flag to cause driver errors to be ignored in
appropriate cases.

This appears to fix some kernel warnings and crashes.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/cfg.c         |  4 ++--
 net/mac80211/ieee80211_i.h |  7 ++++---
 net/mac80211/iface.c       |  2 +-
 net/mac80211/link.c        | 30 +++++++++++++++++++-----------
 net/mac80211/mlme.c        | 29 +++++++++++++++--------------
 5 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 08c284c4984a..1c2b88429ce4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4894,7 +4894,7 @@ static int ieee80211_add_intf_link(struct wiphy *wiphy,
 	if (wdev->use_4addr)
 		return -EOPNOTSUPP;
 
-	return ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
+	return ieee80211_vif_set_links(sdata, wdev->valid_links, 0, false);
 }
 
 static void ieee80211_del_intf_link(struct wiphy *wiphy,
@@ -4905,7 +4905,7 @@ static void ieee80211_del_intf_link(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	ieee80211_vif_set_links(sdata, wdev->valid_links, 0);
+	ieee80211_vif_set_links(sdata, wdev->valid_links, 0, false);
 }
 
 static int sta_add_link_station(struct ieee80211_local *local,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9ce7f7d2b573..34412ac5db71 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2040,10 +2040,11 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 			 struct ieee80211_bss_conf *link_conf);
 void ieee80211_link_stop(struct ieee80211_link_data *link);
 int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
-			    u16 new_links, u16 dormant_links);
-static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
+			    u16 new_links, u16 dormant_links, bool ignore_driver_failures);
+static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata,
+					     bool ignore_driver_failures)
 {
-	ieee80211_vif_set_links(sdata, 0, 0);
+	ieee80211_vif_set_links(sdata, 0, 0, ignore_driver_failures);
 }
 
 /* tx handling */
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 0c7ec6ef9136..c71e6c786b28 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -864,7 +864,7 @@ static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		ieee80211_mesh_teardown_sdata(sdata);
 
-	ieee80211_vif_clear_links(sdata);
+	ieee80211_vif_clear_links(sdata, true);
 	ieee80211_link_stop(&sdata->deflink);
 }
 
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 2dc0f46ee053..19c085a143e4 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -225,7 +225,9 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 		if (sdata->vif.active_links)
 			break;
 		sdata->vif.active_links = valid_links & ~dormant_links;
-		WARN_ON(hweight16(sdata->vif.active_links) > 1);
+		if (WARN_ON(hweight16(sdata->vif.active_links) > 1))
+			sdata_err(sdata, "ERROR: set-vif-links-bitmaps: too many active-links,  valid_links: 0x%x  dormant_links: 0x%x  active_links: 0x%x\n",
+				  valid_links, dormant_links, sdata->vif.active_links);
 		break;
 	default:
 		WARN_ON(1);
@@ -234,7 +236,8 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 
 static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 				      struct link_container **to_free,
-				      u16 new_links, u16 dormant_links)
+				      u16 new_links, u16 dormant_links,
+				      bool ignore_driver_failures)
 {
 	u16 old_links = sdata->vif.valid_links;
 	u16 old_active = sdata->vif.active_links;
@@ -325,13 +328,17 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (ret) {
-		/* restore config */
-		memcpy(sdata->link, old_data, sizeof(old_data));
-		memcpy(sdata->vif.link_conf, old, sizeof(old));
-		ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
-		/* and free (only) the newly allocated links */
-		memset(to_free, 0, sizeof(links));
-		goto free;
+		sdata_info(sdata, "driver error applying links: %d  Restoring old configuration, old_links: 0x%x  dormant_links: 0x%x requested new_links: 0x%x ignore-driver-failures: %d\n",
+			   ret, old_links, dormant_links, new_links, ignore_driver_failures);
+		if (!ignore_driver_failures) {
+			/* restore config */
+			memcpy(sdata->link, old_data, sizeof(old_data));
+			memcpy(sdata->vif.link_conf, old, sizeof(old));
+			ieee80211_set_vif_links_bitmaps(sdata, old_links, dormant_links);
+			/* and free (only) the newly allocated links */
+			memset(to_free, 0, sizeof(links));
+			goto free;
+		}
 	}
 
 	/* use deflink/bss_conf again if and only if there are no more links */
@@ -352,13 +359,14 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 }
 
 int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
-			    u16 new_links, u16 dormant_links)
+			    u16 new_links, u16 dormant_links,
+			    bool ignore_driver_failures)
 {
 	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
 	int ret;
 
 	ret = ieee80211_vif_update_links(sdata, links, new_links,
-					 dormant_links);
+					 dormant_links, ignore_driver_failures);
 	ieee80211_free_links(sdata, links);
 
 	return ret;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bbb337005766..21ae23531f5f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3215,7 +3215,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(&sdata->u.mgd.ttlm_info, 0,
 	       sizeof(sdata->u.mgd.ttlm_info));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
-	ieee80211_vif_set_links(sdata, 0, 0);
+	ieee80211_vif_set_links(sdata, 0, 0, true);
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -3379,7 +3379,8 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif)))
+	if (WARN_ONCE(ieee80211_vif_is_mld(&sdata->vif),
+		      "mgd-probe-ap called for MLD station: %s", sdata->dev->name))
 		return;
 
 	if (!ieee80211_sdata_running(sdata))
@@ -3654,7 +3655,7 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 		sdata->u.mgd.flags = 0;
 
 		ieee80211_link_release_channel(&sdata->deflink);
-		ieee80211_vif_set_links(sdata, 0, 0);
+		ieee80211_vif_set_links(sdata, 0, 0, true);
 	}
 
 	cfg80211_put_bss(sdata->local->hw.wiphy, auth_data->bss);
@@ -3711,7 +3712,7 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 		}
 
 		ieee80211_link_release_channel(&sdata->deflink);
-		ieee80211_vif_set_links(sdata, 0, 0);
+		ieee80211_vif_set_links(sdata, 0, 0, true);
 	}
 
 	kfree(assoc_data);
@@ -5268,7 +5269,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			}
 		}
 
-		ieee80211_vif_set_links(sdata, valid_links, dormant_links);
+		ieee80211_vif_set_links(sdata, valid_links, dormant_links, false);
 	}
 
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
@@ -5348,7 +5349,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* links might have changed due to rejected ones, set them again */
-	ieee80211_vif_set_links(sdata, valid_links, dormant_links);
+	ieee80211_vif_set_links(sdata, valid_links, dormant_links, false);
 
 	rate_control_rate_init(sta);
 
@@ -5915,7 +5916,7 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 	new_dormant_links = sdata->vif.dormant_links & ~sdata->u.mgd.removed_links;
 
 	ret = ieee80211_vif_set_links(sdata, new_valid_links,
-				      new_dormant_links);
+				      new_dormant_links, false);
 	if (ret)
 		sdata_info(sdata, "Failed setting valid links\n");
 
@@ -6045,12 +6046,12 @@ static void ieee80211_tid_to_link_map_work(struct wiphy *wiphy,
 		return;
 	}
 
-	ieee80211_vif_set_links(sdata, sdata->vif.valid_links, 0);
+	ieee80211_vif_set_links(sdata, sdata->vif.valid_links, 0, false);
 	new_active_links = BIT(ffs(new_active_links) - 1);
 	ieee80211_set_active_links(&sdata->vif, new_active_links);
 
 	ret = ieee80211_vif_set_links(sdata, sdata->vif.valid_links,
-				      new_dormant_links);
+				      new_dormant_links, false);
 
 	sdata->u.mgd.ttlm_info.active = true;
 	sdata->u.mgd.ttlm_info.switch_time = 0;
@@ -6165,7 +6166,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			 */
 			ret = ieee80211_vif_set_links(sdata,
 						      sdata->vif.valid_links,
-						      0);
+						      0, false);
 			if (ret) {
 				sdata_info(sdata, "Failed setting valid/dormant links\n");
 				return;
@@ -7229,12 +7230,12 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 		mlo = true;
 		if (WARN_ON(!ap_mld_addr))
 			return -EINVAL;
-		err = ieee80211_vif_set_links(sdata, BIT(link_id), 0);
+		err = ieee80211_vif_set_links(sdata, BIT(link_id), 0, false);
 	} else {
 		if (WARN_ON(ap_mld_addr))
 			return -EINVAL;
 		ap_mld_addr = cbss->bssid;
-		err = ieee80211_vif_set_links(sdata, 0, 0);
+		err = ieee80211_vif_set_links(sdata, 0, 0, false);
 		link_id = 0;
 		mlo = false;
 	}
@@ -7386,7 +7387,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 
 out_err:
 	ieee80211_link_release_channel(&sdata->deflink);
-	ieee80211_vif_set_links(sdata, 0, 0);
+	ieee80211_vif_set_links(sdata, 0, 0, true);
 	return err;
 }
 
@@ -8037,7 +8038,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		}
 
 		/* if there was no authentication, set up the link */
-		err = ieee80211_vif_set_links(sdata, BIT(assoc_link_id), 0);
+		err = ieee80211_vif_set_links(sdata, BIT(assoc_link_id), 0, false);
 		if (err)
 			goto err_clear;
 	} else {
-- 
2.41.0

