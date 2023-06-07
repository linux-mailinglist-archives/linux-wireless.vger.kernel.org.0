Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119F772659E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjFGQQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbjFGQQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 12:16:35 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F86199D
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 09:16:33 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:6e01:0:640:627f:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id C7A466004A;
        Wed,  7 Jun 2023 19:16:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KGX7fTADXSw0-Z7GhDIYG;
        Wed, 07 Jun 2023 19:16:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686154591;
        bh=FKy9jnvA+7Y7SWCGMGxUppexL6ZNvSWKfqcugwV1E6E=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=EjkbO0+btHmbhSYVMA1decB98dITHjccXiYIUAh9h/+3ontgIQ7s4/trnCtOTQsEM
         JQ2luVvdMEVSnjn67Je5C5kNZQY/6+kJvE9+i11ql6R6IlItWDrimOnLZ3z02PjzlQ
         HlWpRz9p8HDDcQZppfs9cnc16uAxhpTH1QxiypJ0=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Franky Lin <franky.lin@broadcom.com>
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/3] wifi: brcmfmac: handle possible WOWL configuration error
Date:   Wed,  7 Jun 2023 19:16:08 +0300
Message-Id: <20230607161611.85106-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert 'brcmf_configure_wowl()' to return 's32' which may be
an error raised by 'brcmf_fil_iovar_data_set()', pass the
value to 'brcmf_cfg80211_suspend()' and adjust related code.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index de8a2e27f49c..5a0b32322b4f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4175,12 +4175,13 @@ static s32 brcmf_cfg80211_resume(struct wiphy *wiphy)
 	return 0;
 }
 
-static void brcmf_configure_wowl(struct brcmf_cfg80211_info *cfg,
-				 struct brcmf_if *ifp,
-				 struct cfg80211_wowlan *wowl)
+static s32 brcmf_configure_wowl(struct brcmf_cfg80211_info *cfg,
+				struct brcmf_if *ifp,
+				struct cfg80211_wowlan *wowl)
 {
 	u32 wowl_config;
 	struct brcmf_wowl_wakeind_le wowl_wakeind;
+	s32 err = 0;
 	u32 i;
 
 	brcmf_dbg(TRACE, "Suspend, wowl config.\n");
@@ -4223,12 +4224,15 @@ static void brcmf_configure_wowl(struct brcmf_cfg80211_info *cfg,
 		wowl_config |= BRCMF_WOWL_UNASSOC;
 
 	memcpy(&wowl_wakeind, "clear", 6);
-	brcmf_fil_iovar_data_set(ifp, "wowl_wakeind", &wowl_wakeind,
-				 sizeof(wowl_wakeind));
-	brcmf_fil_iovar_int_set(ifp, "wowl", wowl_config);
-	brcmf_fil_iovar_int_set(ifp, "wowl_activate", 1);
-	brcmf_bus_wowl_config(cfg->pub->bus_if, true);
-	cfg->wowl.active = true;
+	err = brcmf_fil_iovar_data_set(ifp, "wowl_wakeind", &wowl_wakeind,
+				       sizeof(wowl_wakeind));
+	if (err == 0) {
+		brcmf_fil_iovar_int_set(ifp, "wowl", wowl_config);
+		brcmf_fil_iovar_int_set(ifp, "wowl_activate", 1);
+		brcmf_bus_wowl_config(cfg->pub->bus_if, true);
+		cfg->wowl.active = true;
+	}
+	return err;
 }
 
 static int brcmf_keepalive_start(struct brcmf_if *ifp, unsigned int interval)
@@ -4256,6 +4260,7 @@ static s32 brcmf_cfg80211_suspend(struct wiphy *wiphy,
 	struct net_device *ndev = cfg_to_ndev(cfg);
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_cfg80211_vif *vif;
+	s32 err = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
@@ -4293,18 +4298,19 @@ static s32 brcmf_cfg80211_suspend(struct wiphy *wiphy,
 		brcmf_set_mpc(ifp, 1);
 
 	} else {
-		/* Configure WOWL paramaters */
-		brcmf_configure_wowl(cfg, ifp, wowl);
+		/* Configure WOWL parameters */
+		err = brcmf_configure_wowl(cfg, ifp, wowl);
 
 		/* Prevent disassociation due to inactivity with keep-alive */
-		brcmf_keepalive_start(ifp, 30);
+		if (err == 0)
+			brcmf_keepalive_start(ifp, 30);
 	}
 
 exit:
 	brcmf_dbg(TRACE, "Exit\n");
 	/* clear any scanning activity */
 	cfg->scan_status = 0;
-	return 0;
+	return err;
 }
 
 static s32
-- 
2.40.1

