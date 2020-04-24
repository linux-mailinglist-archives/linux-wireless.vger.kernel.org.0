Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583B81B8199
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 23:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDXVUf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 17:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXVUe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 17:20:34 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C2AC09B048
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 14:20:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g10so8845173lfj.13
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 14:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3kT0cc3ZZfHtoX9bPaCd1aTY0IS4rgWLowp9jL1PTU=;
        b=hjc+mDQzDZb23OdZx+JfSmKWkSl+/ntGZZyHDY0+3Z2UsSXkAd9xf9Wnwsca6X1dFk
         r1NFgwsWZ0ccTKeWZLMNf6y4o4WZkFFkHhn1uz6vCnwAi/SXBXHP8YuCrKv2u0g0SMWH
         H9GmsLaNnRNSux1Yvd28oAJgI1zgYQ+a5FaDQ/bAqRVabIygKL3XakYkiHGUGiJvjHmd
         ljaRiVnKpoyCCFkGvylwIUHa8UZ4CScn23AuldSrV/bIx+FFcBAXrH2cKdMx6JCxmjK+
         7Ui0yLMCURZcTggcOb/lHXYahKOB/n5pjUfxV8KoWzczqIGM4hMfahq2SmyJVRpxHzr1
         BY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3kT0cc3ZZfHtoX9bPaCd1aTY0IS4rgWLowp9jL1PTU=;
        b=iJV2PaqCS/AUivCc1fR4V+zDwfHLIqLvH/0TC3uBWtUM6S3wp7P8DhB/DcV5vbXTqv
         0+wzhaJEpZh1BYi2dQLDC8TJju3mhU9nStL6101qGmGOcVqxXks3I/qPnztfrY4T8BpE
         cac+Lne+/pXj1DoSXPqH7WN5evSOSIyImAbwBbHk6BgM3SzywoDhDYHdd0dcBa8pUq1X
         UtJ4jQoLfOIRPYuuE6aXsLx80AsQoDrYAW8bW/aj3J8lyEL9aQIxfeFJG2JTyKmQr0FO
         eQx93Yzf6IRkaf7bgjFrN1zT8iTJcoT5LerlGEJ0W/+VT6Lb+wzuijqclTZsJsn0BQ4S
         4rZA==
X-Gm-Message-State: AGi0PuYArQdO54po/IEW7sx7X9r6u+jzM+2ZwIrZ7eaShjOTofPVexrr
        UpfGNb8AZYRwkf2upte6zh8Y3LnS
X-Google-Smtp-Source: APiQypIhMdt7zMX3kEVRZRvSgz4+Gk0Pg+QoARQRz1pjA8WlYdSn1J+VgPqPALWPH1G2iPPaKvsgJg==
X-Received: by 2002:a19:c3c5:: with SMTP id t188mr7798177lff.199.1587763232375;
        Fri, 24 Apr 2020 14:20:32 -0700 (PDT)
Received: from localhost.localdomain (pppoe.178-66-130-79.dynamic.avangarddsl.ru. [178.66.130.79])
        by smtp.googlemail.com with ESMTPSA id w24sm5226283lfe.58.2020.04.24.14.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 14:20:30 -0700 (PDT)
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Simran Singhal <singhalsimran0@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH] staging: rtl8723bs, wilc1000: update management frame registration API
Date:   Sat, 25 Apr 2020 00:24:54 +0300
Message-Id: <20200424212454.230080-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Management frame registration API has been updated in wireless core and
all the wireless drivers. Update staging wireless drivers as well.

Fixes: 6cd536fe62ef ("cfg80211: change internal management frame registration API")

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 .../rtl8723bs/include/ioctl_cfg80211.h        |  1 +
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 21 ++++---
 drivers/staging/wilc1000/cfg80211.c           | 57 ++++++++++++-------
 drivers/staging/wilc1000/netdev.c             | 35 +++++++-----
 drivers/staging/wilc1000/netdev.h             |  1 +
 5 files changed, 73 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h b/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h
index 931599d8b08a..2080ea1f18a0 100644
--- a/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h
+++ b/drivers/staging/rtl8723bs/include/ioctl_cfg80211.h
@@ -83,6 +83,7 @@ struct rtw_wdev_priv
 	u8 bandroid_scan;
 	bool block;
 	bool power_mgmt;
+	u32 mgmt_mask;
 };
 
 #define wiphy_to_adapter(x) (*((struct adapter **)wiphy_priv(x)))
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1ba85a43f05a..8d01e5f3e606 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3163,25 +3163,31 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	return ret;
 }
 
-static void cfg80211_rtw_mgmt_frame_register(struct wiphy *wiphy,
-	struct wireless_dev *wdev,
-	u16 frame_type, bool reg)
+static void cfg80211_rtw_update_mgmt_frame_register(struct wiphy *wiphy,
+						    struct wireless_dev *wdev,
+						    struct mgmt_frame_regs *upd)
+
 {
+	u32 rtw_mask = BIT(IEEE80211_STYPE_PROBE_REQ >> 4);
 	struct net_device *ndev = wdev_to_ndev(wdev);
+	struct rtw_wdev_priv *wd;
 	struct adapter *adapter;
 
 	if (ndev == NULL)
 		goto exit;
 
 	adapter = (struct adapter *)rtw_netdev_priv(ndev);
+	wd = adapter_wdev_data(adapter);
 
 #ifdef DEBUG_CFG80211
-	DBG_871X(FUNC_ADPT_FMT" frame_type:%x, reg:%d\n", FUNC_ADPT_ARG(adapter),
-		frame_type, reg);
+	DBG_871X(FUNC_ADPT_FMT " old_regs:%x new_regs:%x\n",
+		 FUNC_ADPT_ARG(adapter), wd->mgmt_mask, upd->interface_stypes);
 #endif
 
-	if (frame_type != (IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_PROBE_REQ))
+	if ((upd->interface_stypes & rtw_mask) == (wd->mgmt_mask & rtw_mask))
 		return;
+
+	wd->mgmt_mask = upd->interface_stypes;
 exit:
 	return;
 }
@@ -3397,7 +3403,8 @@ static struct cfg80211_ops rtw_cfg80211_ops = {
 	.change_bss = cfg80211_rtw_change_bss,
 
 	.mgmt_tx = cfg80211_rtw_mgmt_tx,
-	.mgmt_frame_register = cfg80211_rtw_mgmt_frame_register,
+	.update_mgmt_frame_registrations =
+		cfg80211_rtw_update_mgmt_frame_register,
 
 #if defined(CONFIG_PNO_SUPPORT)
 	.sched_scan_start = cfg80211_rtw_sched_scan_start,
diff --git a/drivers/staging/wilc1000/cfg80211.c b/drivers/staging/wilc1000/cfg80211.c
index 4bdcbc5fd2fd..d6877381b493 100644
--- a/drivers/staging/wilc1000/cfg80211.c
+++ b/drivers/staging/wilc1000/cfg80211.c
@@ -1217,33 +1217,50 @@ static int mgmt_tx_cancel_wait(struct wiphy *wiphy,
 	return 0;
 }
 
-void wilc_mgmt_frame_register(struct wiphy *wiphy, struct wireless_dev *wdev,
-			      u16 frame_type, bool reg)
+void wilc_update_mgmt_frame_registration(struct wiphy *wiphy,
+					 struct wireless_dev *wdev,
+					 struct mgmt_frame_regs *upd)
 {
-	struct wilc *wl = wiphy_priv(wiphy);
 	struct wilc_vif *vif = netdev_priv(wdev->netdev);
-
-	if (!frame_type)
+	struct wilc *wl = wiphy_priv(wiphy);
+	u32 new_mask = upd->interface_stypes;
+	u32 old_mask = vif->mgmt_bitmask;
+	static const struct {
+		u32 mask, type;
+	} updates[NUM_REG_FRAME] = {
+		{
+			.mask = BIT(IEEE80211_STYPE_PROBE_REQ >> 4),
+			.type = IEEE80211_STYPE_PROBE_REQ,
+		},
+		{
+			.mask = BIT(IEEE80211_STYPE_ACTION >> 4),
+			.type = IEEE80211_STYPE_PROBE_REQ,
+		},
+	};
+	unsigned int i;
+	u32 type;
+	u32 mask;
+	bool reg;
+
+	if (new_mask == old_mask)
 		return;
 
-	switch (frame_type) {
-	case IEEE80211_STYPE_PROBE_REQ:
-		vif->frame_reg[0].type = frame_type;
-		vif->frame_reg[0].reg = reg;
-		break;
+	for (i = 0; i < NUM_REG_FRAME; i++) {
+		type = updates[i].type;
+		mask = updates[i].mask;
+		reg = new_mask & mask;
 
-	case IEEE80211_STYPE_ACTION:
-		vif->frame_reg[1].type = frame_type;
-		vif->frame_reg[1].reg = reg;
-		break;
+		if ((new_mask & mask) == (old_mask & mask))
+			continue;
 
-	default:
-		break;
+		vif->frame_reg[i].type = type;
+		vif->frame_reg[i].reg = reg;
+
+		if (wl->initialized)
+			wilc_frame_register(vif, type, reg);
 	}
 
-	if (!wl->initialized)
-		return;
-	wilc_frame_register(vif, frame_type, reg);
+	vif->mgmt_bitmask = new_mask;
 }
 
 static int set_cqm_rssi_config(struct wiphy *wiphy, struct net_device *dev,
@@ -1665,7 +1682,7 @@ static const struct cfg80211_ops wilc_cfg80211_ops = {
 	.cancel_remain_on_channel = cancel_remain_on_channel,
 	.mgmt_tx_cancel_wait = mgmt_tx_cancel_wait,
 	.mgmt_tx = mgmt_tx,
-	.mgmt_frame_register = wilc_mgmt_frame_register,
+	.update_mgmt_frame_registrations = wilc_update_mgmt_frame_registration,
 	.set_power_mgmt = set_power_mgmt,
 	.set_cqm_rssi_config = set_cqm_rssi_config,
 
diff --git a/drivers/staging/wilc1000/netdev.c b/drivers/staging/wilc1000/netdev.c
index f94a17babd12..08345d603ffc 100644
--- a/drivers/staging/wilc1000/netdev.c
+++ b/drivers/staging/wilc1000/netdev.c
@@ -570,6 +570,7 @@ static int wilc_mac_open(struct net_device *ndev)
 	struct wilc_vif *vif = netdev_priv(ndev);
 	struct wilc *wl = vif->wilc;
 	unsigned char mac_add[ETH_ALEN] = {0};
+	unsigned int i;
 	int ret = 0;
 
 	if (!wl || !wl->dev) {
@@ -602,14 +603,12 @@ static int wilc_mac_open(struct net_device *ndev)
 		return -EINVAL;
 	}
 
-	wilc_mgmt_frame_register(vif->ndev->ieee80211_ptr->wiphy,
-				 vif->ndev->ieee80211_ptr,
-				 vif->frame_reg[0].type,
-				 vif->frame_reg[0].reg);
-	wilc_mgmt_frame_register(vif->ndev->ieee80211_ptr->wiphy,
-				 vif->ndev->ieee80211_ptr,
-				 vif->frame_reg[1].type,
-				 vif->frame_reg[1].reg);
+	for (i = 0; i < NUM_REG_FRAME; i++) {
+		if (wl->initialized && vif->frame_reg[i].type)
+			wilc_frame_register(vif, vif->frame_reg[i].type,
+					    vif->frame_reg[i].reg);
+	}
+
 	netif_wake_queue(ndev);
 	wl->open_ifcs++;
 	vif->mac_opened = 1;
@@ -786,19 +785,25 @@ void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size,
 
 void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size)
 {
-	int srcu_idx;
 	struct wilc_vif *vif;
+	struct frame_reg *fr;
+	unsigned int i;
+	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&wilc->srcu);
 	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
 		u16 type = le16_to_cpup((__le16 *)buff);
 
-		if (vif->priv.p2p_listen_state &&
-		    ((type == vif->frame_reg[0].type &&
-		      vif->frame_reg[0].reg) ||
-		     (type == vif->frame_reg[1].type &&
-		      vif->frame_reg[1].reg)))
-			wilc_wfi_p2p_rx(vif, buff, size);
+		if (vif->priv.p2p_listen_state) {
+			for (i = 0; i < NUM_REG_FRAME; i++) {
+				fr = &vif->frame_reg[i];
+
+				if (fr->type && fr->reg && type == fr->type) {
+					wilc_wfi_p2p_rx(vif, buff, size);
+					break;
+				}
+			}
+		}
 
 		if (vif->monitor_flag)
 			wilc_wfi_monitor_rx(wilc->monitor_dev, buff, size);
diff --git a/drivers/staging/wilc1000/netdev.h b/drivers/staging/wilc1000/netdev.h
index 61cbec674a62..9291dbc830ba 100644
--- a/drivers/staging/wilc1000/netdev.h
+++ b/drivers/staging/wilc1000/netdev.h
@@ -202,6 +202,7 @@ struct wilc_vif {
 	struct wilc_priv priv;
 	struct list_head list;
 	struct cfg80211_bss *bss;
+	u32 mgmt_bitmask;
 };
 
 struct wilc {
-- 
2.26.2

