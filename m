Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074945BF342
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 04:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiIUCEv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 22:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiIUCEr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 22:04:47 -0400
Received: from smtp12.infineon.com (smtp12.infineon.com [217.10.52.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CF41408D
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663725885; x=1695261885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8d74GWEhfjl6aXSB4ay4hundRV81+ueMayg3Ot59v0Q=;
  b=YkVyKQ4s5OzSeTMBmgEmJFOtLAHpKazwZVqgceTK1Et4ef3C3ZXNhuvT
   5GhSa5IdNhUWdv/epv77aiy7U8ZV/CRs1nmWdBZkJJFvkoi5iqdSUHT2R
   eByPbYwMcBbOoEd4qbMywyyUCqhRFlJSrhrJR4Cdwi/9rJfnRDcxTBG5u
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="318191320"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="318191320"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 04:04:43 +0200
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 04:04:42 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 04:04:42 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Wed, 21 Sep 2022 04:04:42 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="258959956"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="258959956"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 21 Sep 2022 04:04:41 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Sep 2022
 21:04:40 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 3A92B1004EE;
        Tue, 20 Sep 2022 21:00:46 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 375639806AB; Tue, 20 Sep 2022 21:00:46 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 3/3] brcmfmac: Fix connecting enterprise AP failure
Date:   Tue, 20 Sep 2022 20:59:51 -0500
Message-ID: <20220921015951.16178-4-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220921015951.16178-1-ian.lin@infineon.com>
References: <20220921015951.16178-1-ian.lin@infineon.com>
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

From: Kurt Lee <kurt.lee@cypress.com>

Use alternative to check AKM-DPP enabled thus this change won't let
status un-sync on use_fwsup between driver and firmware

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index c0e184db0e5d..98b42925887e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1821,6 +1821,7 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 			break;
 		case WLAN_AKM_SUITE_DPP:
 			val = WFA_AUTH_DPP;
+			profile->use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
 			break;
 		default:
 			bphy_err(drvr, "invalid akm suite (%d)\n",
@@ -2139,8 +2140,6 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 				brcmf_dbg(INFO, "using PSK offload\n");
 				profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
 			}
-		} else {
-			profile->use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
 		}
 
 		if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
-- 
2.25.0

