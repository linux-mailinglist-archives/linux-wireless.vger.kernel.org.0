Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF55EED06
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 07:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiI2FGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 01:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiI2FG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 01:06:28 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8366129689
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664427987; x=1695963987;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Idios7BGFiK7QcePd58hWBGbFHLsd+oKmdFC3+MapQ=;
  b=cwmO8Q1Qu0EGOzFkGjxolFBcjZBxQYdELyy2a+MVFupr7W7bDHw6912+
   qDqu1cVuvujNVvWspcyFS3wAAXgyBi/lPDo/JexqAlP7o0ZrjvIJ6SIiC
   jynFcZ//tCmdxsOBd53F6pN5w/2lpyD0MF9R5IIN3rs1LRu6D/MLlIaHR
   s=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="319475407"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="319475407"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 07:06:23 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 07:06:23 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 07:06:23 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 07:06:22 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264162890"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="264162890"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 07:06:22 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Sep 2022
 00:06:21 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 149221004E0;
        Thu, 29 Sep 2022 00:06:21 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 110279807D1; Thu, 29 Sep 2022 00:06:21 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 2/4] brcmfmac: support station interface creation version 1, 2 and 3
Date:   Thu, 29 Sep 2022 00:06:12 -0500
Message-ID: <20220929050614.31518-3-ian.lin@infineon.com>
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

To create virtual station interface for RSDB and VSDB, we add interface
creation version 1, 2 and 3 supports
The structures of each version are different and only version 3 and
later version are able to get interface creating version from firmware
side.

The patch has been verified two concurrent stations pings test with
 interface create version 1:
          89342(4359b1)-PCIE: 9.40.100
 interface create version 2:
         4373a0-sdio: 13.10.271
 interface create version 3:
         4373a0-sdio: 13.35.48

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 148 +++++++++++++++---
 1 file changed, 124 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e352bc6e015c..2082e255f031 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -234,17 +234,46 @@ struct parsed_vndr_ies {
 	struct parsed_vndr_ie_info ie_info[VNDR_IE_PARSE_LIMIT];
 };
 
+#define WL_INTERFACE_CREATE_VER_1		1
+#define WL_INTERFACE_CREATE_VER_2		2
+#define WL_INTERFACE_CREATE_VER_3		3
+#define WL_INTERFACE_CREATE_VER_MAX		WL_INTERFACE_CREATE_VER_3
+
 #define WL_INTERFACE_MAC_DONT_USE	0x0
 #define WL_INTERFACE_MAC_USE		0x2
 
 #define WL_INTERFACE_CREATE_STA		0x0
 #define WL_INTERFACE_CREATE_AP		0x1
 
-struct wl_interface_create {
-	u16	ver;
-	u32	flags;
-	u8	mac_addr[ETH_ALEN];
-	u8	pad[13];
+struct wl_interface_create_v1 {
+	u16	ver;			/* structure version */
+	u32	flags;			/* flags for operation */
+	u8	mac_addr[ETH_ALEN];	/* MAC address */
+	u32	wlc_index;		/* optional for wlc index */
+};
+
+struct wl_interface_create_v2 {
+	u16	ver;			/* structure version */
+	u8	pad1[2];
+	u32	flags;			/* flags for operation */
+	u8	mac_addr[ETH_ALEN];	/* MAC address */
+	u8	iftype;			/* type of interface created */
+	u8	pad2;
+	u32	wlc_index;		/* optional for wlc index */
+};
+
+struct wl_interface_create_v3 {
+	u16 ver;			/* structure version */
+	u16 len;			/* length of structure + data */
+	u16 fixed_len;			/* length of structure */
+	u8 iftype;			/* type of interface created */
+	u8 wlc_index;			/* optional for wlc index */
+	u32 flags;			/* flags for operation */
+	u8 mac_addr[ETH_ALEN];		/* MAC address */
+	u8 bssid[ETH_ALEN];		/* optional for BSSID */
+	u8 if_index;			/* interface index request */
+	u8 pad[3];
+	u8 data[];			/* Optional for specific data */
 };
 
 static u8 nl80211_band_to_fwil(enum nl80211_band band)
@@ -534,16 +563,14 @@ static int brcmf_get_first_free_bsscfgidx(struct brcmf_pub *drvr)
 	return -ENOMEM;
 }
 
-static void brcmf_set_sta_iface_macaddr(struct brcmf_if *ifp,
-					struct wl_interface_create *iface)
+static void brcmf_set_vif_sta_macaddr(struct brcmf_if *ifp, u8 *mac_addr)
 {
 	u8 mac_idx = ifp->drvr->sta_mac_idx;
 
 	/* set difference MAC address with locally administered bit */
-	iface->flags |= WL_INTERFACE_MAC_USE;
-	memcpy(iface->mac_addr, ifp->mac_addr, ETH_ALEN);
-	iface->mac_addr[0] |= 0x02;
-	iface->mac_addr[3] ^= mac_idx ? 0xC0 : 0xA0;
+	memcpy(mac_addr, ifp->mac_addr, ETH_ALEN);
+	mac_addr[0] |= 0x02;
+	mac_addr[3] ^= mac_idx ? 0xC0 : 0xA0;
 	mac_idx++;
 	mac_idx = mac_idx % 2;
 	ifp->drvr->sta_mac_idx = mac_idx;
@@ -551,23 +578,96 @@ static void brcmf_set_sta_iface_macaddr(struct brcmf_if *ifp,
 
 static int brcmf_cfg80211_request_sta_if(struct brcmf_if *ifp, u8 *macaddr)
 {
-	struct wl_interface_create iface;
+	struct wl_interface_create_v1 iface_v1;
+	struct wl_interface_create_v2 iface_v2;
+	struct wl_interface_create_v3 iface_v3;
+	u32 iface_create_ver;
 	int err;
 
-	memset(&iface, 0, sizeof(iface));
+	/* interface_create version 1 */
+	memset(&iface_v1, 0, sizeof(iface_v1));
+	iface_v1.ver = WL_INTERFACE_CREATE_VER_1;
+	iface_v1.flags = WL_INTERFACE_CREATE_STA |
+			 WL_INTERFACE_MAC_USE;
+	if (!is_zero_ether_addr(macaddr))
+		memcpy(iface_v1.mac_addr, macaddr, ETH_ALEN);
+	else
+		brcmf_set_vif_sta_macaddr(ifp, iface_v1.mac_addr);
 
-	iface.ver = 0;
-	iface.flags = WL_INTERFACE_CREATE_STA;
-	if (!is_zero_ether_addr(macaddr)) {
-		/* set MAC address in cfg80211 params */
-		memcpy(iface.mac_addr, macaddr, ETH_ALEN);
+	err = brcmf_fil_iovar_data_get(ifp, "interface_create",
+				       &iface_v1,
+				       sizeof(iface_v1));
+	if (err) {
+		brcmf_info("failed to create interface(v1), err=%d\n",
+			   err);
 	} else {
-		brcmf_set_sta_iface_macaddr(ifp, &iface);
+		brcmf_dbg(INFO, "interface created(v1)\n");
+		return 0;
 	}
 
-	err = brcmf_fil_iovar_data_get(ifp, "interface_create", &iface,
-				       sizeof(iface));
-	return err;
+	/* interface_create version 2 */
+	memset(&iface_v2, 0, sizeof(iface_v2));
+	iface_v2.ver = WL_INTERFACE_CREATE_VER_2;
+	iface_v2.flags = WL_INTERFACE_MAC_USE;
+	iface_v2.iftype = WL_INTERFACE_CREATE_STA;
+	if (!is_zero_ether_addr(macaddr))
+		memcpy(iface_v2.mac_addr, macaddr, ETH_ALEN);
+	else
+		brcmf_set_vif_sta_macaddr(ifp, iface_v2.mac_addr);
+
+	err = brcmf_fil_iovar_data_get(ifp, "interface_create",
+				       &iface_v2,
+				       sizeof(iface_v2));
+	if (err) {
+		brcmf_info("failed to create interface(v2), err=%d\n",
+			   err);
+	} else {
+		brcmf_dbg(INFO, "interface created(v2)\n");
+		return 0;
+	}
+
+	/* interface_create version 3+ */
+	/* get supported version from firmware side */
+	iface_create_ver = 0;
+	err = brcmf_fil_bsscfg_int_get(ifp, "interface_create",
+				       &iface_create_ver);
+	if (err) {
+		brcmf_err("fail to get supported version, err=%d\n", err);
+		return -EOPNOTSUPP;
+	}
+
+	switch (iface_create_ver) {
+	case WL_INTERFACE_CREATE_VER_3:
+		memset(&iface_v3, 0, sizeof(iface_v3));
+		iface_v3.ver = WL_INTERFACE_CREATE_VER_3;
+		iface_v3.flags = WL_INTERFACE_MAC_USE;
+		iface_v3.iftype = WL_INTERFACE_CREATE_STA;
+		if (!is_zero_ether_addr(macaddr))
+			memcpy(iface_v3.mac_addr, macaddr, ETH_ALEN);
+		else
+			brcmf_set_vif_sta_macaddr(ifp, iface_v3.mac_addr);
+
+		err = brcmf_fil_iovar_data_get(ifp, "interface_create",
+					       &iface_v3,
+					       sizeof(iface_v3));
+
+		if (!err)
+			brcmf_dbg(INFO, "interface created(v3)\n");
+		break;
+	default:
+		brcmf_err("not support interface create(v%d)\n",
+			  iface_create_ver);
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	if (err) {
+		brcmf_info("station interface creation failed (%d)\n",
+			   err);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static int brcmf_cfg80211_request_ap_if(struct brcmf_if *ifp)
@@ -7030,7 +7130,7 @@ brcmf_txrx_stypes[NUM_NL80211_IFTYPES] = {
  *
  * p2p, mchan, and mbss:
  *
- *	#STA <= 1, #P2P-DEV <= 1, #{P2P-CL, P2P-GO} <= 1, channels = 2, 3 total
+ *	#STA <= 2, #P2P-DEV <= 1, #{P2P-CL, P2P-GO} <= 1, channels = 2, 3 total
  *	#STA <= 1, #P2P-DEV <= 1, #AP <= 1, #P2P-CL <= 1, channels = 1, 4 total
  *	#AP <= 4, matching BI, channels = 1, 4 total
  *
@@ -7076,7 +7176,7 @@ static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 		goto err;
 
 	combo[c].num_different_channels = 1 + (rsdb || (p2p && mchan));
-	c0_limits[i].max = 1;
+	c0_limits[i].max = 1 + (p2p && mchan);
 	c0_limits[i++].types = BIT(NL80211_IFTYPE_STATION);
 	if (mon_flag) {
 		c0_limits[i].max = 1;
-- 
2.25.0

