Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299C624D0E4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 10:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHUIzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgHUIzD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 04:55:03 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CCEC061385
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tYmGpit2WzdR714I533v7RCEMSRHkF01kQPnAt4kQlw=; b=FoLh2wRx1AdUSPSgtIcJD2p/Le
        0GFYVoq2NEca89L02EAN1EkC1P9ZIbKHe/fx8h9i1BDvwISSM0QOgbJPxZwEzumaYv+c51B2SgIOt
        A+fvS5RIKNaZjqojMm1NhClJj8lww+eonsKAAMPEpe+iaZfziJWAxLdrDqruSeF0FakY=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k92jr-0005lO-5X; Fri, 21 Aug 2020 10:49:31 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v3 11/13] mac80211: notify the driver when a sta uses 4-address mode
Date:   Fri, 21 Aug 2020 10:49:24 +0200
Message-Id: <20200821084926.10650-12-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821084926.10650-1-nbd@nbd.name>
References: <20200821084926.10650-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is needed for encapsulation offload of 4-address mode packets

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h    |  4 ++++
 net/mac80211/cfg.c        |  1 +
 net/mac80211/driver-ops.h | 14 ++++++++++++++
 net/mac80211/mlme.c       |  3 +++
 net/mac80211/trace.h      | 27 +++++++++++++++++++++++++++
 5 files changed, 49 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index aaec7688e965..31bfe1b445e2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3843,6 +3843,8 @@ enum ieee80211_reconfig_type {
  *	This callback may sleep.
  * @update_vif_config: Update virtual interface offload flags
  *	This callback may sleep.
+ * @sta_set_4addr: Called to notify the driver when a station starts/stops using
+ *	4-address mode
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4156,6 +4158,8 @@ struct ieee80211_ops {
 				struct ieee80211_sta *sta, u8 tids);
 	void (*update_vif_offload)(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif);
+	void (*sta_set_4addr)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta, bool enabled);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ea6f4d83f529..7b6c43e46a44 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1701,6 +1701,7 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 
 			rcu_assign_pointer(vlansdata->u.vlan.sta, sta);
 			__ieee80211_check_fast_rx_iface(vlansdata);
+			drv_sta_set_4addr(local, sta->sdata, &sta->sta, true);
 		}
 
 		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index e3dfb9307fae..bcdfd19a596b 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1399,4 +1399,18 @@ static inline void drv_update_vif_offload(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_sta_set_4addr(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_sta *sta, bool enabled)
+{
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	trace_drv_sta_set_4addr(local, sdata, sta, enabled);
+	if (local->ops->sta_set_4addr)
+		local->ops->sta_set_4addr(&local->hw, &sdata->vif, sta, enabled);
+	trace_drv_return_void(local);
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f241decf843d..50a9b9025725 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3523,6 +3523,9 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
+	if (sdata->wdev.use_4addr)
+		drv_sta_set_4addr(local, sdata, &sta->sta, true);
+
 	mutex_unlock(&sdata->local->sta_mtx);
 
 	/*
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 50a0a83e96fc..89723907a094 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2740,6 +2740,33 @@ DEFINE_EVENT(local_sdata_addr_evt, drv_update_vif_offload,
 	TP_ARGS(local, sdata)
 );
 
+TRACE_EVENT(drv_sta_set_4addr,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta, bool enabled),
+
+	TP_ARGS(local, sdata, sta, enabled),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		STA_ENTRY
+		__field(bool, enabled)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		STA_ASSIGN;
+		__entry->enabled = enabled;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " enabled:%d",
+		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->enabled
+	)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.28.0

