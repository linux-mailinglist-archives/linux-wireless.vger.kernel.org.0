Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7644351D063
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389033AbiEFE4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 00:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbiEFE4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 00:56:40 -0400
X-Greylist: delayed 586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 21:52:57 PDT
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB359B86
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 21:52:57 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4KvdH12wPVz9sRy;
        Fri,  6 May 2022 06:43:09 +0200 (CEST)
From:   =?UTF-8?q?Pavel=20L=C3=B6bl?= <pavel@loebl.cz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loebl.cz; s=MBO0001;
        t=1651812187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7eQed5dRweJAll1O3an8gZhqdQSlwhOnYacfFaFZE7Y=;
        b=YVvlhZTdd+rlEHxbY9g1o/54E8JwbUjMl6X9raXXmBbMIotOG7cqD8oJFS41iUxCaHK6dF
        X95feoHxbdxi3z8vT/FIkEWD1b1iF+KN6LlUHDwmxVgsu/TwDAAIzIhbfQVuuLXCVJpDSP
        Ps1QTnJg658n+tdiKkided27n7tax3h6urXIgPrTiuqNB2mm5OzuQUu79u9qaBymHcaPgT
        /HzCcFTUiJjUScBJd0JFSi2RUswjGXc33TCN8ht9neunFgG0z6AXcMejejnEt9nC9+eRYV
        LnPC8azq1rbd4SweSKlBakXIjD5vwjDTs1MLeF/mJTHg12s8wkIqkzKa5tGi2g==
To:     linux-wireless@vger.kernel.org
Cc:     davem@davemloft.net, kvalo@kernel.org,
        =?UTF-8?q?Pavel=20L=C3=B6bl?= <pavel@loebl.cz>
Subject: [PATCH] brcmfmac: allow setting wlan MAC address using device tree
Date:   Fri,  6 May 2022 06:42:46 +0200
Message-Id: <20220506044246.67146-1-pavel@loebl.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows firmware to provide MAC address using device tree. Like in
case there is no MAC burned in wlan NVRAM.

Signed-off-by: Pavel Löbl <pavel@loebl.cz>
---
 .../broadcom/brcm80211/brcmfmac/common.c      | 23 ++++++++++++++-----
 .../broadcom/brcm80211/brcmfmac/common.h      |  1 +
 .../broadcom/brcm80211/brcmfmac/core.c        |  4 +++-
 .../wireless/broadcom/brcm80211/brcmfmac/of.c |  3 +++
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index e3758bd86acf..fe01da9e620d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -202,13 +202,24 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 	char *ptr;
 	s32 err;
 
-	/* retreive mac address */
-	err = brcmf_fil_iovar_data_get(ifp, "cur_etheraddr", ifp->mac_addr,
-				       sizeof(ifp->mac_addr));
-	if (err < 0) {
-		bphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
-		goto done;
+	if (is_valid_ether_addr(ifp->mac_addr)) {
+		/* set mac address */
+		err = brcmf_fil_iovar_data_set(ifp, "cur_etheraddr", ifp->mac_addr,
+					       ETH_ALEN);
+		if (err < 0) {
+			bphy_err(ifp->drvr, "Setting cur_etheraddr failed, %d\n", err);
+			goto done;
+		}
+	} else {
+		/* retrieve mac address */
+		err = brcmf_fil_iovar_data_get(ifp, "cur_etheraddr", ifp->mac_addr,
+					       sizeof(ifp->mac_addr));
+		if (err < 0) {
+			bphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
+			goto done;
+		}
 	}
+
 	memcpy(ifp->drvr->mac, ifp->mac_addr, sizeof(ifp->drvr->mac));
 	memcpy(ifp->drvr->wiphy->perm_addr, ifp->drvr->mac, ETH_ALEN);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
index 8b5f49997c8b..15accc88d5c0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.h
@@ -50,6 +50,7 @@ struct brcmf_mp_device {
 	bool		ignore_probe_fail;
 	struct brcmfmac_pd_cc *country_codes;
 	const char	*board_type;
+	unsigned char	mac[ETH_ALEN];
 	union {
 		struct brcmfmac_sdio_pd sdio;
 	} bus;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 26fab4bee22c..87aef211b35f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -7,6 +7,7 @@
 #include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/inetdevice.h>
+#include <linux/property.h>
 #include <net/cfg80211.h>
 #include <net/rtnetlink.h>
 #include <net/addrconf.h>
@@ -1197,7 +1198,8 @@ static int brcmf_bus_started(struct brcmf_pub *drvr, struct cfg80211_ops *ops)
 	brcmf_dbg(TRACE, "\n");
 
 	/* add primary networking interface */
-	ifp = brcmf_add_if(drvr, 0, 0, false, "wlan%d", NULL);
+	ifp = brcmf_add_if(drvr, 0, 0, false, "wlan%d",
+			   is_valid_ether_addr(drvr->settings->mac) ? drvr->settings->mac : NULL);
 	if (IS_ERR(ifp))
 		return PTR_ERR(ifp);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index 8623bde5eb70..083ac58f466d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/of_net.h>
 
 #include <defs.h>
 #include "debug.h"
@@ -99,6 +100,8 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	if (err)
 		brcmf_err("failed to get OF country code map (err=%d)\n", err);
 
+	of_get_mac_address(np, settings->mac);
+
 	if (bus_type != BRCMF_BUSTYPE_SDIO)
 		return;
 
-- 
2.35.1

