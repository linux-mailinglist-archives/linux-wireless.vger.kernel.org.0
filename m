Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4925E6015
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 12:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiIVKmw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 06:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiIVKmu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 06:42:50 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A5ABF09
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663843369; x=1695379369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yiLzuxY1XeKOnKqZU8sImt9fGqgl3ZVI/9TS9FzmXjA=;
  b=NPLWELV0j/ET+JulqW+d2Qa7TBx8P/N69/ryc1+yIvnJsTJDuQ1c9Ti2
   Kkqa7haP01AGG1lUF1xMJ6M0AY2N7CTRboP5ETKAS84L3X1uKP68fhwJ9
   /0PRu9S0brDT47WcVq3Baaf0hqALH+cP0RmbPNTFJXVV6Wz0pZ0n2nSzJ
   8=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="142360891"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="142360891"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:42:47 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 12:42:47 +0200 (CEST)
Received: from MUCSE804.infineon.com (172.23.29.30) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 12:42:47 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay1.infineon.com (172.23.29.5) with Microsoft SMTP Server id
 15.2.986.29; Thu, 22 Sep 2022 12:42:47 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="259403396"
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="259403396"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 22 Sep 2022 12:42:46 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Sep 2022
 05:42:45 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 6DA521004DF;
        Thu, 22 Sep 2022 05:42:45 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 6B6A09807D1; Thu, 22 Sep 2022 05:42:45 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v2 1/5] brcmfmac: correctly remove all p2p vif
Date:   Thu, 22 Sep 2022 05:42:25 -0500
Message-ID: <20220922104229.12119-2-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220922104229.12119-1-ian.lin@infineon.com>
References: <20220922104229.12119-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Brian Henriquez <brian.henriquez@cypress.com>

When deleting a P2P AGO interface we should make sure that
relevant entry in bss_idx[] array is removed. We were always
removing only 'vif' at P2PAPI_BSSCFG_CONNECTION before,
regardless of the number of created P2P AGO interfaces.
brcmfmac: correctly remove all p2p vif

Signed-off-by: Brian Henriquez <brian.henriquez@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 479041f070f9..b3d706a2e68c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2424,8 +2424,12 @@ int brcmf_p2p_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
 	brcmf_remove_interface(vif->ifp, true);
 
 	brcmf_cfg80211_arm_vif_event(cfg, NULL);
-	if (iftype != NL80211_IFTYPE_P2P_DEVICE)
-		p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif = NULL;
+	if (iftype != NL80211_IFTYPE_P2P_DEVICE) {
+		if (vif == p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif)
+			p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif = NULL;
+		if (vif == p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION2].vif)
+			p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION2].vif = NULL;
+	}
 
 	return err;
 }
-- 
2.25.0

