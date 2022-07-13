Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F45573339
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiGMJpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiGMJpO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89376ED16E
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=aR8xXe114aJAehqr8Jc5p3h/YIxKzBQkJU8IyhhIkHQ=;
        t=1657705513; x=1658915113; b=PI1jH2Qjwo1VL1EOMrI0ZplDYNb6VKo3iZdVeXxDOjaBo8B
        +vdgiMT5zkLa6YWzGZ14jjtvojZMMbHm9zu5iBr6a99M9Z9+iJQoer5YzIaTP5Iu8bZYD6Vc0bIIV
        RrzejMGprBckfIZgjb3S9xSIaysWLfnBKq+bQ+r9TXWilvi+IlZynQ0Ao90ueumxHoPI6p95PHEm9
        jDMEVc3rWlVw5NmT68GtnE6de1zTgsvL0ERVRXDyCg2lplgO4QZEOU5Svjcru1fHgOsPOSOkcctRm
        2HsisVjTVvEVTvCUXPed8arEPEyeZeVH6kdJ8TM3o+Mtyc9ry8hlRQmPmu++uLLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvf-00EgvB-Ii;
        Wed, 13 Jul 2022 11:45:11 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 24/76] wifi: mac80211: move ieee80211_request_smps_mgd_work
Date:   Wed, 13 Jul 2022 11:44:10 +0200
Message-Id: <20220713114425.bb3db277cf4b.I49a95fb92f5b3d4366e31f4120c72ae6ac37eb3b@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This function can be static.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ht.c          | 12 ------------
 net/mac80211/ieee80211_i.h |  1 -
 net/mac80211/mlme.c        | 12 ++++++++++++
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index ea7ce87b7ec4..8c24817cd497 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -550,18 +550,6 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-void ieee80211_request_smps_mgd_work(struct work_struct *work)
-{
-	struct ieee80211_link_data *link =
-		container_of(work, struct ieee80211_link_data,
-			     u.mgd.request_smps_work);
-
-	sdata_lock(link->sdata);
-	__ieee80211_request_smps_mgd(link->sdata, link,
-				     link->u.mgd.driver_smps_mode);
-	sdata_unlock(link->sdata);
-}
-
 void ieee80211_request_smps(struct ieee80211_vif *vif, unsigned int link_id,
 			    enum ieee80211_smps_mode smps_mode)
 {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 154ff50e99a0..8c14274c9aaf 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1951,7 +1951,6 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 			       enum ieee80211_smps_mode smps, const u8 *da,
 			       const u8 *bssid);
-void ieee80211_request_smps_mgd_work(struct work_struct *work);
 bool ieee80211_smps_is_restrictive(enum ieee80211_smps_mode smps_mode_old,
 				   enum ieee80211_smps_mode smps_mode_new);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5a208a01e278..73742f1a88ff 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5017,6 +5017,18 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 	sdata_unlock(sdata);
 }
 
+static void ieee80211_request_smps_mgd_work(struct work_struct *work)
+{
+	struct ieee80211_link_data *link =
+		container_of(work, struct ieee80211_link_data,
+			     u.mgd.request_smps_work);
+
+	sdata_lock(link->sdata);
+	__ieee80211_request_smps_mgd(link->sdata, link,
+				     link->u.mgd.driver_smps_mode);
+	sdata_unlock(link->sdata);
+}
+
 /* interface setup */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 {
-- 
2.36.1

