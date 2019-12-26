Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229D512AC62
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2019 14:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfLZNbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Dec 2019 08:31:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37193 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLZNbO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Dec 2019 08:31:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id o13so13332379ljg.4
        for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2019 05:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pniocxP2tMCxkDXbhuyQFX27RtjssI2Zb6+EKwRpmM8=;
        b=s2hWDNQGFbcJjonHoWlvGXkrC7NSdWwxdPP8ZU2jQptmpbar99oENUvB3dR/BqWdfN
         BexRNPv7SGeuww3FDq/E6yil7WXTDKcDz1qW83bi1mzMJtcClcb8pQ5eZq45jTdTRTjh
         PxZ4Di25eaxx9o26MWq2Pk1JO/KRyL8zQXAAA1IXtEtuhrxPTnof3m86a/HjBKwZCKCf
         5SY5HG7v2zu8xk8acoZtOVmRg605gssLt1sNabFawEofUI63PMa8JqOvIKCueUW/moKp
         2umPXqGtvRGaTQqdgUQkE3dhez3+BSny+UfXOJb2vdApAtYaTtBgUC8K6/tcOiQLBKcv
         xSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pniocxP2tMCxkDXbhuyQFX27RtjssI2Zb6+EKwRpmM8=;
        b=TV5r/75uUwdhupqpFzouxruv3Xzica33+6auXih/G8zGSimp5ywWqZ8tt9UgYNh1Wl
         o+L9fQZqT015JbMMLD31EI5HZcpArysuTpO+ud7RD0bzoU5EyxZybDqRFNkR69njMFXB
         nyRcZQoqHtHSw6WBl0S7zhW/r9G8zJKnvFDENPj/ee481mujAt+lqCzBxURmut7aqGO8
         kvUV5JXxS1lTQm80tb65d2/p51LkStZPoAGDA7r+j6ayi55NH/nXSuQrpAQAIlZKI/Cw
         DO7P9WP67BkOIdELIk+dnVcUW4LNlJa9K3HCC1eSY3vlPsKpuZ5eWKjL3rqNUHG3QFNG
         XSHA==
X-Gm-Message-State: APjAAAVIAUMORfml87VTEVL3rLsE2VUaM4vnbIWeWrI9R0ppjxafR9IN
        jV4zy4PoJNtTue11uq6QuMI=
X-Google-Smtp-Source: APXvYqxv8HznUgF67fJ2RNq6FGRp8ILXvEVUF0zl35x8efPeC0HIkiGSDJY7SXRzxlw4D++Tycb8Kw==
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr26345489ljo.54.1577367071841;
        Thu, 26 Dec 2019 05:31:11 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id m8sm13106720lfp.4.2019.12.26.05.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 05:31:11 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] brcmfmac: add initial support for monitor mode
Date:   Thu, 26 Dec 2019 14:30:50 +0100
Message-Id: <20191226133050.16838-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191226133050.16838-1-zajec5@gmail.com>
References: <20191226133050.16838-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Report monitor interface availability using cfg80211 and support it in
the add_virtual_intf() and del_virtual_intf() callbacks. This new
feature is conditional and depends on firmware flagging monitor packets.
Receiving monitor frames is already handled by the brcmf_netif_mon_rx().

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 112 ++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/core.c        |  68 ++++++++++-
 .../broadcom/brcm80211/brcmfmac/core.h        |   2 +
 .../broadcom/brcm80211/brcmfmac/feature.c     |   1 +
 .../broadcom/brcm80211/brcmfmac/feature.h     |   2 +
 .../broadcom/brcm80211/brcmfmac/fwil.h        |   2 +
 6 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 3ecb91aa765e..a2328d3eee03 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -11,6 +11,7 @@
 #include <linux/vmalloc.h>
 #include <net/cfg80211.h>
 #include <net/netlink.h>
+#include <uapi/linux/if_arp.h>
 
 #include <brcmu_utils.h>
 #include <defs.h>
@@ -619,6 +620,82 @@ static bool brcmf_is_ibssmode(struct brcmf_cfg80211_vif *vif)
 	return vif->wdev.iftype == NL80211_IFTYPE_ADHOC;
 }
 
+/**
+ * brcmf_mon_add_vif() - create monitor mode virtual interface
+ *
+ * @wiphy: wiphy device of new interface.
+ * @name: name of the new interface.
+ */
+static struct wireless_dev *brcmf_mon_add_vif(struct wiphy *wiphy,
+					      const char *name)
+{
+	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct brcmf_cfg80211_vif *vif;
+	struct net_device *ndev;
+	struct brcmf_if *ifp;
+	int err;
+
+	if (cfg->pub->mon_if) {
+		err = -EEXIST;
+		goto err_out;
+	}
+
+	vif = brcmf_alloc_vif(cfg, NL80211_IFTYPE_MONITOR);
+	if (IS_ERR(vif)) {
+		err = PTR_ERR(vif);
+		goto err_out;
+	}
+
+	ndev = alloc_netdev(sizeof(*ifp), name, NET_NAME_UNKNOWN, ether_setup);
+	if (!ndev) {
+		err = -ENOMEM;
+		goto err_free_vif;
+	}
+	ndev->type = ARPHRD_IEEE80211_RADIOTAP;
+	ndev->ieee80211_ptr = &vif->wdev;
+	ndev->needs_free_netdev = true;
+	ndev->priv_destructor = brcmf_cfg80211_free_netdev;
+	SET_NETDEV_DEV(ndev, wiphy_dev(cfg->wiphy));
+
+	ifp = netdev_priv(ndev);
+	ifp->vif = vif;
+	ifp->ndev = ndev;
+	ifp->drvr = cfg->pub;
+
+	vif->ifp = ifp;
+	vif->wdev.netdev = ndev;
+
+	err = brcmf_net_mon_attach(ifp);
+	if (err) {
+		brcmf_err("Failed to attach %s device\n", ndev->name);
+		free_netdev(ndev);
+		goto err_free_vif;
+	}
+
+	cfg->pub->mon_if = ifp;
+
+	return &vif->wdev;
+
+err_free_vif:
+	brcmf_free_vif(vif);
+err_out:
+	return ERR_PTR(err);
+}
+
+static int brcmf_mon_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = wdev->netdev;
+
+	ndev->netdev_ops->ndo_stop(ndev);
+
+	brcmf_net_detach(ndev, true);
+
+	cfg->pub->mon_if = NULL;
+
+	return 0;
+}
+
 static struct wireless_dev *brcmf_cfg80211_add_iface(struct wiphy *wiphy,
 						     const char *name,
 						     unsigned char name_assign_type,
@@ -641,9 +718,10 @@ static struct wireless_dev *brcmf_cfg80211_add_iface(struct wiphy *wiphy,
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_WDS:
-	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_MESH_POINT:
 		return ERR_PTR(-EOPNOTSUPP);
+	case NL80211_IFTYPE_MONITOR:
+		return brcmf_mon_add_vif(wiphy, name);
 	case NL80211_IFTYPE_AP:
 		wdev = brcmf_ap_add_vif(wiphy, name, params);
 		break;
@@ -826,9 +904,10 @@ int brcmf_cfg80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_WDS:
-	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_MESH_POINT:
 		return -EOPNOTSUPP;
+	case NL80211_IFTYPE_MONITOR:
+		return brcmf_mon_del_vif(wiphy, wdev);
 	case NL80211_IFTYPE_AP:
 		return brcmf_cfg80211_del_ap_iface(wiphy, wdev);
 	case NL80211_IFTYPE_P2P_CLIENT:
@@ -6547,9 +6626,10 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 	struct ieee80211_iface_limit *c0_limits = NULL;
 	struct ieee80211_iface_limit *p2p_limits = NULL;
 	struct ieee80211_iface_limit *mbss_limits = NULL;
-	bool mbss, p2p, rsdb, mchan;
-	int i, c, n_combos;
+	bool mon_flag, mbss, p2p, rsdb, mchan;
+	int i, c, n_combos, n_limits;
 
+	mon_flag = brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MONITOR_FLAG);
 	mbss = brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MBSS);
 	p2p = brcmf_feat_is_enabled(ifp, BRCMF_FEAT_P2P);
 	rsdb = brcmf_feat_is_enabled(ifp, BRCMF_FEAT_RSDB);
@@ -6563,6 +6643,8 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
 				 BIT(NL80211_IFTYPE_ADHOC) |
 				 BIT(NL80211_IFTYPE_AP);
+	if (mon_flag)
+		wiphy->interface_modes |= BIT(NL80211_IFTYPE_MONITOR);
 	if (p2p)
 		wiphy->interface_modes |= BIT(NL80211_IFTYPE_P2P_CLIENT) |
 					  BIT(NL80211_IFTYPE_P2P_GO) |
@@ -6570,18 +6652,18 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 
 	c = 0;
 	i = 0;
-	if (p2p && rsdb)
-		c0_limits = kcalloc(4, sizeof(*c0_limits), GFP_KERNEL);
-	else if (p2p)
-		c0_limits = kcalloc(3, sizeof(*c0_limits), GFP_KERNEL);
-	else
-		c0_limits = kcalloc(2, sizeof(*c0_limits), GFP_KERNEL);
+	n_limits = 1 + mon_flag + (p2p ? 2 : 0) + (rsdb || !p2p);
+	c0_limits = kcalloc(n_limits, sizeof(*c0_limits), GFP_KERNEL);
 	if (!c0_limits)
 		goto err;
 
 	combo[c].num_different_channels = 1 + (rsdb || (p2p && mchan));
 	c0_limits[i].max = 1 + rsdb;
 	c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
+	if (mon_flag) {
+		c0_limits[i].max = 1;
+		c0_limits[i++].types = BIT(NL80211_IFTYPE_MONITOR);
+	}
 	if (p2p) {
 		c0_limits[i].max = 1;
 		c0_limits[i++].types = BIT(NL80211_IFTYPE_P2P_DEVICE);
@@ -6630,14 +6712,20 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 	if (mbss) {
 		c++;
 		i = 0;
-		mbss_limits = kcalloc(1, sizeof(*mbss_limits), GFP_KERNEL);
+		n_limits = 1 + mon_flag;
+		mbss_limits = kcalloc(n_limits, sizeof(*mbss_limits),
+				      GFP_KERNEL);
 		if (!mbss_limits)
 			goto err;
 		mbss_limits[i].max = 4;
 		mbss_limits[i++].types = BIT(NL80211_IFTYPE_AP);
+		if (mon_flag) {
+			mbss_limits[i].max = 1;
+			mbss_limits[i++].types = BIT(NL80211_IFTYPE_MONITOR);
+		}
 		combo[c].beacon_int_infra_match = true;
 		combo[c].num_different_channels = 1;
-		combo[c].max_interfaces = 4;
+		combo[c].max_interfaces = 4 + mon_flag;
 		combo[c].n_limits = i;
 		combo[c].limits = mbss_limits;
 	}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index d3ddd97fe768..23627c953a5e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -673,7 +673,7 @@ int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
 	return -EBADE;
 }
 
-static void brcmf_net_detach(struct net_device *ndev, bool rtnl_locked)
+void brcmf_net_detach(struct net_device *ndev, bool rtnl_locked)
 {
 	if (ndev->reg_state == NETREG_REGISTERED) {
 		if (rtnl_locked)
@@ -686,6 +686,72 @@ static void brcmf_net_detach(struct net_device *ndev, bool rtnl_locked)
 	}
 }
 
+static int brcmf_net_mon_open(struct net_device *ndev)
+{
+	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_pub *drvr = ifp->drvr;
+	u32 monitor;
+	int err;
+
+	brcmf_dbg(TRACE, "Enter\n");
+
+	err = brcmf_fil_cmd_int_get(ifp, BRCMF_C_GET_MONITOR, &monitor);
+	if (err) {
+		bphy_err(drvr, "BRCMF_C_GET_MONITOR error (%d)\n", err);
+		return err;
+	} else if (monitor) {
+		bphy_err(drvr, "Monitor mode is already enabled\n");
+		return -EEXIST;
+	}
+
+	monitor = 3;
+	err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_SET_MONITOR, monitor);
+	if (err)
+		bphy_err(drvr, "BRCMF_C_SET_MONITOR error (%d)\n", err);
+
+	return err;
+}
+
+static int brcmf_net_mon_stop(struct net_device *ndev)
+{
+	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_pub *drvr = ifp->drvr;
+	u32 monitor;
+	int err;
+
+	brcmf_dbg(TRACE, "Enter\n");
+
+	monitor = 0;
+	err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_SET_MONITOR, monitor);
+	if (err)
+		bphy_err(drvr, "BRCMF_C_SET_MONITOR error (%d)\n", err);
+
+	return err;
+}
+
+static const struct net_device_ops brcmf_netdev_ops_mon = {
+	.ndo_open = brcmf_net_mon_open,
+	.ndo_stop = brcmf_net_mon_stop,
+};
+
+int brcmf_net_mon_attach(struct brcmf_if *ifp)
+{
+	struct brcmf_pub *drvr = ifp->drvr;
+	struct net_device *ndev;
+	int err;
+
+	brcmf_dbg(TRACE, "Enter\n");
+
+	ndev = ifp->ndev;
+	ndev->netdev_ops = &brcmf_netdev_ops_mon;
+
+	err = register_netdevice(ndev);
+	if (err)
+		bphy_err(drvr, "Failed to register %s device\n", ndev->name);
+
+	return err;
+}
+
 void brcmf_net_setcarrier(struct brcmf_if *ifp, bool on)
 {
 	struct net_device *ndev;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 6699637d3bf8..33b2ab3b54b0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -210,6 +210,8 @@ void brcmf_txflowblock_if(struct brcmf_if *ifp,
 void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success);
 void brcmf_netif_rx(struct brcmf_if *ifp, struct sk_buff *skb);
 void brcmf_netif_mon_rx(struct brcmf_if *ifp, struct sk_buff *skb);
+void brcmf_net_detach(struct net_device *ndev, bool rtnl_locked);
+int brcmf_net_mon_attach(struct brcmf_if *ifp);
 void brcmf_net_setcarrier(struct brcmf_if *ifp, bool on);
 int __init brcmf_core_init(void);
 void __exit brcmf_core_exit(void);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 1c9c74cc958e..5da0dda0d899 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -38,6 +38,7 @@ static const struct brcmf_feat_fwcap brcmf_fwcap_map[] = {
 	{ BRCMF_FEAT_MCHAN, "mchan" },
 	{ BRCMF_FEAT_P2P, "p2p" },
 	{ BRCMF_FEAT_MONITOR, "monitor" },
+	{ BRCMF_FEAT_MONITOR_FLAG, "rtap" },
 	{ BRCMF_FEAT_MONITOR_FMT_RADIOTAP, "rtap" },
 	{ BRCMF_FEAT_DOT11H, "802.11h" },
 	{ BRCMF_FEAT_SAE, "sae" },
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index 280a1f6412d4..cda3fc1bab7f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -23,6 +23,7 @@
  * GSCAN: enhanced scan offload feature.
  * FWSUP: Firmware supplicant.
  * MONITOR: firmware can pass monitor packets to host.
+ * MONITOR_FLAG: firmware flags monitor packets.
  * MONITOR_FMT_RADIOTAP: firmware provides monitor packets with radiotap header
  * MONITOR_FMT_HW_RX_HDR: firmware provides monitor packets with hw/ucode header
  * DOT11H: firmware supports 802.11h
@@ -44,6 +45,7 @@
 	BRCMF_FEAT_DEF(GSCAN) \
 	BRCMF_FEAT_DEF(FWSUP) \
 	BRCMF_FEAT_DEF(MONITOR) \
+	BRCMF_FEAT_DEF(MONITOR_FLAG) \
 	BRCMF_FEAT_DEF(MONITOR_FMT_RADIOTAP) \
 	BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR) \
 	BRCMF_FEAT_DEF(DOT11H) \
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
index 0ff6f5212a94..ae4cf4372908 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.h
@@ -49,6 +49,8 @@
 #define BRCMF_C_GET_PM				85
 #define BRCMF_C_SET_PM				86
 #define BRCMF_C_GET_REVINFO			98
+#define BRCMF_C_GET_MONITOR			107
+#define BRCMF_C_SET_MONITOR			108
 #define BRCMF_C_GET_CURR_RATESET		114
 #define BRCMF_C_GET_AP				117
 #define BRCMF_C_SET_AP				118
-- 
2.21.0

