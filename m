Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C565EED04
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 07:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiI2FG3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 01:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiI2FG2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 01:06:28 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BBC128A37
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664427986; x=1695963986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dy+cycoXEprUSjx2MVskQDDmgWHuV14+fePByvBEjRg=;
  b=GzGsSWJOP8al0o9uuAwXT9zYzehYud3xVm6aydVzbXFj2kOWIGRNHj6v
   zjuaOfz/GSwAZwLwpDJjVe9IKiuz1hv1YCNknUX/xBASqo9VIOOCT4ugu
   aSi6DMOdspxwWtAEjwJTaebiQY4k6awhBu6Nkwk2BIIDnSWmgfFs3YGVz
   w=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="2374992"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="2374992"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 07:06:24 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 07:06:24 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 07:06:24 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 07:06:23 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264162893"
X-IronPort-AV: E=Sophos;i="5.93,354,1654552800"; 
   d="scan'208";a="264162893"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 07:06:23 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 29 Sep 2022
 00:06:22 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id D29C31004E1;
        Thu, 29 Sep 2022 00:06:21 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 CF5529807D1; Thu, 29 Sep 2022 00:06:21 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 3/4] brcmfmac: Fix AP interface delete issue
Date:   Thu, 29 Sep 2022 00:06:13 -0500
Message-ID: <20220929050614.31518-4-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929050614.31518-1-ian.lin@infineon.com>
References: <20220929050614.31518-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Prasanna Kerekoppa <prasanna.kerekoppa@infineon.com>

Fixes the ap interface delete issue. Fix is to make sure interface
is created with supported version.
Patch has been verified by creating and deleting AP interface.

Signed-off-by: Prasanna Kerekoppa <prasanna.kerekoppa@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 101 ++++++++++++++++--
 1 file changed, 90 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2082e255f031..d0aee6c1aa0d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -672,24 +672,103 @@ static int brcmf_cfg80211_request_sta_if(struct brcmf_if *ifp, u8 *macaddr)
 
 static int brcmf_cfg80211_request_ap_if(struct brcmf_if *ifp)
 {
+	struct wl_interface_create_v1 iface_v1;
+	struct wl_interface_create_v2 iface_v2;
+	struct wl_interface_create_v3 iface_v3;
+	u32 iface_create_ver;
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct brcmf_mbss_ssid_le mbss_ssid_le;
 	int bsscfgidx;
 	int err;
 
-	memset(&mbss_ssid_le, 0, sizeof(mbss_ssid_le));
-	bsscfgidx = brcmf_get_first_free_bsscfgidx(ifp->drvr);
-	if (bsscfgidx < 0)
-		return bsscfgidx;
+	/* interface_create version 1 */
+	memset(&iface_v1, 0, sizeof(iface_v1));
+	iface_v1.ver = WL_INTERFACE_CREATE_VER_1;
+	iface_v1.flags = WL_INTERFACE_CREATE_AP |
+			 WL_INTERFACE_MAC_USE;
 
-	mbss_ssid_le.bsscfgidx = cpu_to_le32(bsscfgidx);
-	mbss_ssid_le.SSID_len = cpu_to_le32(5);
-	sprintf(mbss_ssid_le.SSID, "ssid%d" , bsscfgidx);
+	brcmf_set_vif_sta_macaddr(ifp, iface_v1.mac_addr);
 
-	err = brcmf_fil_bsscfg_data_set(ifp, "bsscfg:ssid", &mbss_ssid_le,
-					sizeof(mbss_ssid_le));
-	if (err < 0)
-		bphy_err(drvr, "setting ssid failed %d\n", err);
+	err = brcmf_fil_iovar_data_get(ifp, "interface_create",
+				       &iface_v1,
+				       sizeof(iface_v1));
+	if (err) {
+		brcmf_info("failed to create interface(v1), err=%d\n",
+			   err);
+	} else {
+		brcmf_dbg(INFO, "interface created(v1)\n");
+		return 0;
+	}
+
+	/* interface_create version 2 */
+	memset(&iface_v2, 0, sizeof(iface_v2));
+	iface_v2.ver = WL_INTERFACE_CREATE_VER_2;
+	iface_v2.flags = WL_INTERFACE_MAC_USE;
+	iface_v2.iftype = WL_INTERFACE_CREATE_AP;
+
+	brcmf_set_vif_sta_macaddr(ifp, iface_v2.mac_addr);
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
+		iface_v3.iftype = WL_INTERFACE_CREATE_AP;
+		brcmf_set_vif_sta_macaddr(ifp, iface_v3.mac_addr);
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
+		brcmf_info("Does not support interface_create (%d)\n",
+			   err);
+		memset(&mbss_ssid_le, 0, sizeof(mbss_ssid_le));
+		bsscfgidx = brcmf_get_first_free_bsscfgidx(ifp->drvr);
+		if (bsscfgidx < 0)
+			return bsscfgidx;
+
+		mbss_ssid_le.bsscfgidx = cpu_to_le32(bsscfgidx);
+		mbss_ssid_le.SSID_len = cpu_to_le32(5);
+		sprintf(mbss_ssid_le.SSID, "ssid%d", bsscfgidx);
+
+		err = brcmf_fil_bsscfg_data_set(ifp, "bsscfg:ssid", &mbss_ssid_le,
+						sizeof(mbss_ssid_le));
+
+		if (err < 0)
+			bphy_err(drvr, "setting ssid failed %d\n", err);
+	}
 
 	return err;
 }
-- 
2.25.0

