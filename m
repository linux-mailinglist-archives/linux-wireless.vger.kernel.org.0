Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744825BF343
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Sep 2022 04:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIUCEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 22:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiIUCEr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 22:04:47 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ADD11A29
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663725885; x=1695261885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRjHBShcdu8WYlmDJmIwcvjp0yuRZsjxlAmrAc4hpPQ=;
  b=Hp+hXb+6F8Nq4En6/RlCLaJAENnERR/5LGFFJ+yy2yRKDEvxhkUC88a4
   3wh5ZeoKvpyJ1jsKRrFXK3kFonWCGP59BtlCQ3IB+5ZkZTgG1GpGvk6oh
   wILw5jgphbEvFz53MLRYBra4nD90F5Hhvn7t/GOvLkQSsnElJKzKOp39R
   s=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="142118252"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="142118252"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 04:04:42 +0200
Received: from MUCSE803.infineon.com (MUCSE803.infineon.com [172.23.29.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 04:04:41 +0200 (CEST)
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 21 Sep
 2022 04:04:41 +0200
Received: from mailrelay-cypress4.infineon.com (172.23.18.56) by
 SMTP-MailRelay2.infineon.com (172.23.29.9) with Microsoft SMTP Server id
 15.2.986.29; Wed, 21 Sep 2022 04:04:41 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="258959952"
X-IronPort-AV: E=Sophos;i="5.93,332,1654552800"; 
   d="scan'208";a="258959952"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress4.infineon.com with ESMTP; 21 Sep 2022 04:04:40 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Sep 2022
 21:04:39 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id E8BB51004ED;
        Tue, 20 Sep 2022 21:00:44 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 E4AB19806AB; Tue, 20 Sep 2022 21:00:44 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH 2/3] brcmfmac: Fix interoperating DPP and other encryption network access
Date:   Tue, 20 Sep 2022 20:59:50 -0500
Message-ID: <20220921015951.16178-3-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220921015951.16178-1-ian.lin@infineon.com>
References: <20220921015951.16178-1-ian.lin@infineon.com>
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

From: Kurt Lee <kurt.lee@cypress.com>

1. If firmware supports 4-way handshake offload but not supports DPP
4-way offload, when user first connects encryption network, driver will
set "sup_wpa 1" to firmware, but it will further result in DPP
connection failure since firmware won't send EAPOL frame to host.

2. Fix DPP AP mode handling action frames.

3. For some firmware without fwsup support, the join procedure will be
skipped due to "sup_wpa" iovar returning not-support. Check the fwsup
feature before do such iovar.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 68 ++++++++++---------
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  5 ++
 2 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4a8aceda8fe8..c0e184db0e5d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2128,44 +2128,50 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 		goto done;
 	}
 
-	if (sme->crypto.psk &&
-	    profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
-		if (WARN_ON(profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE)) {
-			err = -EINVAL;
-			goto done;
+	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_FWSUP)) {
+		if (sme->crypto.psk) {
+			if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
+				if (WARN_ON(profile->use_fwsup !=
+					BRCMF_PROFILE_FWSUP_NONE)) {
+					err = -EINVAL;
+					goto done;
+				}
+				brcmf_dbg(INFO, "using PSK offload\n");
+				profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
+			}
+		} else {
+			profile->use_fwsup = BRCMF_PROFILE_FWSUP_NONE;
 		}
-		brcmf_dbg(INFO, "using PSK offload\n");
-		profile->use_fwsup = BRCMF_PROFILE_FWSUP_PSK;
-	}
 
-	if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
-		/* enable firmware supplicant for this interface */
-		err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 1);
-		if (err < 0) {
-			bphy_err(drvr, "failed to enable fw supplicant\n");
-			goto done;
+		if (profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE) {
+			/* enable firmware supplicant for this interface */
+			err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 1);
+			if (err < 0) {
+				bphy_err(drvr, "failed to enable fw supplicant\n");
+				goto done;
+			}
+		} else {
+			err = brcmf_fil_iovar_int_set(ifp, "sup_wpa", 0);
 		}
-	}
 
-	if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
-		err = brcmf_set_pmk(ifp, sme->crypto.psk,
-				    BRCMF_WSEC_MAX_PSK_LEN);
-	else if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) {
-		/* clean up user-space RSNE */
-		err = brcmf_fil_iovar_data_set(ifp, "wpaie", NULL, 0);
-		if (err) {
-			bphy_err(drvr, "failed to clean up user-space RSNE\n");
-			goto done;
-		}
-		err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
-					     sme->crypto.sae_pwd_len);
-		if (!err && sme->crypto.psk)
+		if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_PSK)
 			err = brcmf_set_pmk(ifp, sme->crypto.psk,
 					    BRCMF_WSEC_MAX_PSK_LEN);
+		else if (profile->use_fwsup == BRCMF_PROFILE_FWSUP_SAE) {
+			/* clean up user-space RSNE */
+			if (brcmf_fil_iovar_data_set(ifp, "wpaie", NULL, 0)) {
+				bphy_err(drvr, "failed to clean up user-space RSNE\n");
+				goto done;
+			}
+			err = brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
+						     sme->crypto.sae_pwd_len);
+			if (!err && sme->crypto.psk)
+				err = brcmf_set_pmk(ifp, sme->crypto.psk,
+						    BRCMF_WSEC_MAX_PSK_LEN);
+		}
+		if (err)
+			goto done;
 	}
-	if (err)
-		goto done;
-
 	/* Join with specific BSSID and cached SSID
 	 * If SSID is zero join based on BSSID only
 	 */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 4636fc27e915..3d96ad872593 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1318,6 +1318,10 @@ static s32 brcmf_p2p_abort_action_frame(struct brcmf_cfg80211_info *cfg)
 	brcmf_dbg(TRACE, "Enter\n");
 
 	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+
+	if (!vif)
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe_abort", &int_val,
 					sizeof(s32));
 	if (err)
@@ -1867,6 +1871,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 	/* validate channel and p2p ies */
 	if (config_af_params.search_channel &&
 	    IS_P2P_SOCIAL_CHANNEL(le32_to_cpu(af_params->channel)) &&
+	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif &&
 	    p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->saved_ie.probe_req_ie_len) {
 		afx_hdl = &p2p->afx_hdl;
 		afx_hdl->peer_listen_chan = le32_to_cpu(af_params->channel);
-- 
2.25.0

