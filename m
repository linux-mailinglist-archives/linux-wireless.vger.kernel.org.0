Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD225EED05
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 07:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiI2FGb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 01:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiI2FG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 01:06:28 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6C126B73
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 22:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664427985; x=1695963985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lO3eK2dsRRhrjIGpEeUWT5klG6bsuDE/XU1dVgef8rw=;
  b=ofMiT2IjKMy7Sp6yfZHlW0JmlTWPz+4YQ9LmFu9hDOR0LcE254XhoePz
   pOsBXpPxrDWD/BO+4czwm2C1hy2xy6+3/voDtKY8Q02zVzPTHXs+d32iJ
   QEat6C7624va3VuDFcsKJUPC4ThYdPJXKXUy+4IH05SDZgc8KSHfZ1coD
   c=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="319475406"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="319475406"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 07:06:23 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 07:06:22 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 07:06:22 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 07:06:22 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264162886"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="264162886"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 07:06:21 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Sep 2022
 00:06:20 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 42BAC1004DF;
        Thu, 29 Sep 2022 00:06:20 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 3F6DB9807D1; Thu, 29 Sep 2022 00:06:20 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 1/4] brcmfmac: add creating station interface support
Date:   Thu, 29 Sep 2022 00:06:11 -0500
Message-ID: <20220929050614.31518-2-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929050614.31518-1-ian.lin@infineon.com>
References: <20220929050614.31518-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

With RSDB device, it is able to control two station interfaces
concurrently. So we add creating station interface support and
allow user to create it via cfg80211.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 81 ++++++++++++++++---
 .../broadcom/brcm80211/brcmfmac/core.h        |  1 +
 2 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index dfcfb3333369..e352bc6e015c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -234,6 +234,19 @@ struct parsed_vndr_ies {
 	struct parsed_vndr_ie_info ie_info[VNDR_IE_PARSE_LIMIT];
 };
 
+#define WL_INTERFACE_MAC_DONT_USE	0x0
+#define WL_INTERFACE_MAC_USE		0x2
+
+#define WL_INTERFACE_CREATE_STA		0x0
+#define WL_INTERFACE_CREATE_AP		0x1
+
+struct wl_interface_create {
+	u16	ver;
+	u32	flags;
+	u8	mac_addr[ETH_ALEN];
+	u8	pad[13];
+};
+
 static u8 nl80211_band_to_fwil(enum nl80211_band band)
 {
 	switch (band) {
@@ -521,6 +534,42 @@ static int brcmf_get_first_free_bsscfgidx(struct brcmf_pub *drvr)
 	return -ENOMEM;
 }
 
+static void brcmf_set_sta_iface_macaddr(struct brcmf_if *ifp,
+					struct wl_interface_create *iface)
+{
+	u8 mac_idx = ifp->drvr->sta_mac_idx;
+
+	/* set difference MAC address with locally administered bit */
+	iface->flags |= WL_INTERFACE_MAC_USE;
+	memcpy(iface->mac_addr, ifp->mac_addr, ETH_ALEN);
+	iface->mac_addr[0] |= 0x02;
+	iface->mac_addr[3] ^= mac_idx ? 0xC0 : 0xA0;
+	mac_idx++;
+	mac_idx = mac_idx % 2;
+	ifp->drvr->sta_mac_idx = mac_idx;
+}
+
+static int brcmf_cfg80211_request_sta_if(struct brcmf_if *ifp, u8 *macaddr)
+{
+	struct wl_interface_create iface;
+	int err;
+
+	memset(&iface, 0, sizeof(iface));
+
+	iface.ver = 0;
+	iface.flags = WL_INTERFACE_CREATE_STA;
+	if (!is_zero_ether_addr(macaddr)) {
+		/* set MAC address in cfg80211 params */
+		memcpy(iface.mac_addr, macaddr, ETH_ALEN);
+	} else {
+		brcmf_set_sta_iface_macaddr(ifp, &iface);
+	}
+
+	err = brcmf_fil_iovar_data_get(ifp, "interface_create", &iface,
+				       sizeof(iface));
+	return err;
+}
+
 static int brcmf_cfg80211_request_ap_if(struct brcmf_if *ifp)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
@@ -546,15 +595,17 @@ static int brcmf_cfg80211_request_ap_if(struct brcmf_if *ifp)
 }
 
 /**
- * brcmf_ap_add_vif() - create a new AP virtual interface for multiple BSS
+ * brcmf_apsta_add_vif() - create a new AP or STA virtual interface
  *
  * @wiphy: wiphy device of new interface.
  * @name: name of the new interface.
- * @params: contains mac address for AP device.
+ * @params: contains mac address for AP or STA device.
+ * @type: interface type.
  */
 static
-struct wireless_dev *brcmf_ap_add_vif(struct wiphy *wiphy, const char *name,
-				      struct vif_params *params)
+struct wireless_dev *brcmf_apsta_add_vif(struct wiphy *wiphy, const char *name,
+					 struct vif_params *params,
+					 enum nl80211_iftype type)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
@@ -562,18 +613,24 @@ struct wireless_dev *brcmf_ap_add_vif(struct wiphy *wiphy, const char *name,
 	struct brcmf_cfg80211_vif *vif;
 	int err;
 
+	if (type != NL80211_IFTYPE_STATION && type != NL80211_IFTYPE_AP)
+		return ERR_PTR(-EINVAL);
+
 	if (brcmf_cfg80211_vif_event_armed(cfg))
 		return ERR_PTR(-EBUSY);
 
 	brcmf_dbg(INFO, "Adding vif \"%s\"\n", name);
 
-	vif = brcmf_alloc_vif(cfg, NL80211_IFTYPE_AP);
+	vif = brcmf_alloc_vif(cfg, type);
 	if (IS_ERR(vif))
 		return (struct wireless_dev *)vif;
 
 	brcmf_cfg80211_arm_vif_event(cfg, vif);
 
-	err = brcmf_cfg80211_request_ap_if(ifp);
+	if (type == NL80211_IFTYPE_STATION)
+		err = brcmf_cfg80211_request_sta_if(ifp, params->macaddr);
+	else
+		err = brcmf_cfg80211_request_ap_if(ifp);
 	if (err) {
 		brcmf_cfg80211_arm_vif_event(cfg, NULL);
 		goto fail;
@@ -720,15 +777,15 @@ static struct wireless_dev *brcmf_cfg80211_add_iface(struct wiphy *wiphy,
 	}
 	switch (type) {
 	case NL80211_IFTYPE_ADHOC:
-	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_MESH_POINT:
 		return ERR_PTR(-EOPNOTSUPP);
 	case NL80211_IFTYPE_MONITOR:
 		return brcmf_mon_add_vif(wiphy, name);
+	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_AP:
-		wdev = brcmf_ap_add_vif(wiphy, name, params);
+		wdev = brcmf_apsta_add_vif(wiphy, name, params, type);
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
@@ -848,8 +905,8 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 	return err;
 }
 
-static int brcmf_cfg80211_del_ap_iface(struct wiphy *wiphy,
-				       struct wireless_dev *wdev)
+static int brcmf_cfg80211_del_apsta_iface(struct wiphy *wiphy,
+					  struct wireless_dev *wdev)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct net_device *ndev = wdev->netdev;
@@ -906,15 +963,15 @@ int brcmf_cfg80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_MESH_POINT:
 		return -EOPNOTSUPP;
 	case NL80211_IFTYPE_MONITOR:
 		return brcmf_mon_del_vif(wiphy, wdev);
+	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_AP:
-		return brcmf_cfg80211_del_ap_iface(wiphy, wdev);
+		return brcmf_cfg80211_del_apsta_iface(wiphy, wdev);
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 340346c122d3..2e71b5c2a975 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -136,6 +136,7 @@ struct brcmf_pub {
 	struct work_struct bus_reset;
 
 	u8 clmver[BRCMF_DCMD_SMLEN];
+	u8 sta_mac_idx;
 };
 
 /* forward declarations */
-- 
2.25.0

