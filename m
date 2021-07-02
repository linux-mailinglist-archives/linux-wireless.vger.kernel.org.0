Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0121E3B9BC1
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 07:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhGBFDs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 01:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhGBFDs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 01:03:48 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8CAC061762
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jul 2021 22:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XMuXnPoTDjQkYUgcFFGhqMYCAdHbGQMxVZxKtjVRDpI=; b=IdHYs+j2R666VuMcPpR/PpKWnI
        yQ2BN5jo0SUnnxMdbwf2LMyeDj1OdHyrdvWt4WobgVk7gRLcVeMQrE2dsfybJZ+jjFbPZ/kgCGsTr
        ftVirL9YD++dTQVeHjst6Y7Rhx/wlo3p+49cg0f8IJq0q43/vQfKZp1kpF/BhcB37gH8=;
Received: from p54ae93f7.dip0.t-ipconnect.de ([84.174.147.247] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lzBIf-0003nG-6L; Fri, 02 Jul 2021 07:01:13 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.14] mac80211: fix enabling 4-address mode on a sta vif after assoc
Date:   Fri,  2 Jul 2021 07:01:11 +0200
Message-Id: <20210702050111.47546-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Notify the driver about the 4-address mode change and also send a nulldata
packet to the AP to notify it about the change

Fixes: 1ff4e8f2dec8 ("mac80211: notify the driver when a sta uses 4-address mode")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/cfg.c         | 19 +++++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        |  4 ++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 84cc7733ea66..4e6f11e63df3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -152,6 +152,8 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 				  struct vif_params *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+	struct sta_info *sta;
 	int ret;
 
 	ret = ieee80211_if_change_type(sdata, type);
@@ -162,7 +164,24 @@ static int ieee80211_change_iface(struct wiphy *wiphy,
 		RCU_INIT_POINTER(sdata->u.vlan.sta, NULL);
 		ieee80211_check_fast_rx_iface(sdata);
 	} else if (type == NL80211_IFTYPE_STATION && params->use_4addr >= 0) {
+		struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+
+		if (params->use_4addr == ifmgd->use_4addr)
+			return 0;
+
 		sdata->u.mgd.use_4addr = params->use_4addr;
+		if (!ifmgd->associated)
+			return 0;
+
+		mutex_lock(&local->sta_mtx);
+		sta = sta_info_get(sdata, ifmgd->bssid);
+		if (sta)
+			drv_sta_set_4addr(local, sdata, &sta->sta,
+					  params->use_4addr);
+		mutex_unlock(&local->sta_mtx);
+
+		if (params->use_4addr)
+			ieee80211_send_4addr_nullfunc(local, sdata);
 	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 22549b95d1aa..30ce6d2ec7ce 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2201,6 +2201,8 @@ void ieee80211_dynamic_ps_timer(struct timer_list *t);
 void ieee80211_send_nullfunc(struct ieee80211_local *local,
 			     struct ieee80211_sub_if_data *sdata,
 			     bool powersave);
+void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
+				   struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 			     struct ieee80211_hdr *hdr, bool ack, u16 tx_time);
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a00f11a33699..c0ea3b1aa9e1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1095,8 +1095,8 @@ void ieee80211_send_nullfunc(struct ieee80211_local *local,
 	ieee80211_tx_skb(sdata, skb);
 }
 
-static void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
-					  struct ieee80211_sub_if_data *sdata)
+void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
+				   struct ieee80211_sub_if_data *sdata)
 {
 	struct sk_buff *skb;
 	struct ieee80211_hdr *nullfunc;
-- 
2.30.1

