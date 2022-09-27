Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2075EB8F1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 05:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiI0Dl6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 23:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiI0Dl4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 23:41:56 -0400
Received: from smtp3.infineon.com (smtp3.infineon.com [217.10.52.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BA0AE202
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 20:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664250113; x=1695786113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jy+/KODxjhVI+UhWKDzhcPfPBaz/uj89gZ0uiEjsmVg=;
  b=iYoZojRXvfPgc9Zm4LVnMH0qHhNvW38q3w8xzaPgrt+k51OAJsaSdF0o
   NyDyxpspb3j3sPucFs4jnDee3qyr8kPuR0bDqo8v71H6M5Tl9uhXMRGEl
   BAhvKvCXC8ewoj6ghqjUDzfCKOo2KNv0Xp+HCKhf42ufRaoKKhy1aUwTT
   8=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="2005934"
X-IronPort-AV: E=Sophos;i="5.93,348,1654552800"; 
   d="scan'208";a="2005934"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:41:51 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 05:41:49 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 05:41:49 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Tue, 27 Sep 2022 05:41:49 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="263480689"
X-IronPort-AV: E=Sophos;i="5.93,348,1654552800"; 
   d="scan'208";a="263480689"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 27 Sep 2022 05:41:48 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Mon, 26 Sep 2022
 22:41:47 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id AE93B10038C;
        Mon, 26 Sep 2022 22:41:47 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 A9A7D9807FB; Mon, 26 Sep 2022 22:41:47 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v3 3/5] brcmfmac: Avoiding Connection delay
Date:   Mon, 26 Sep 2022 22:41:36 -0500
Message-ID: <20220927034138.20463-4-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220927034138.20463-1-ian.lin@infineon.com>
References: <20220927034138.20463-1-ian.lin@infineon.com>
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

From: Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>

Channel info passed by supplicant is not given to firmware. This causes
delay (about 3seconds) due to full scan. Supplicant already provides the
channel info for the specific SSID. channel_hint carries this channel
info for the connect call back.

Patch has been verified on 43012 and 43455.

Signed-off-by: Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>
Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 182b61aa346e..6c37da42e61b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2049,6 +2049,12 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 		return -EOPNOTSUPP;
 	}
 
+	if (sme->channel_hint)
+		chan = sme->channel_hint;
+
+	if (sme->bssid_hint)
+		sme->bssid = sme->bssid_hint;
+
 	if (ifp->vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif) {
 		/* A normal (non P2P) connection request setup. */
 		ie = NULL;
-- 
2.25.0

