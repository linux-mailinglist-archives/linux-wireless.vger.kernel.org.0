Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083EC6537C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfGKJFX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 05:05:23 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:59746 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfGKJFX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 05:05:23 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 862A730C004;
        Thu, 11 Jul 2019 02:05:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 862A730C004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562835921;
        bh=VjJNh4MWRf/tu2DoDMhq420fEFEG552W2S/Ub8ekiRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qhg8wej3oMTt68NfN4mRwTNRiCGWYKQQQYS//GDanlyvKfo6fP6x6JIgSwbFH5CfX
         61g+e7v59uipCUaDTFpEmdcn681CJDis5j/PYzanAs+eI7FN7z+g4Ej6V0z/W92hKZ
         zvjVVuloJk9VHx43M+Ms/5LMiLEMgngipfAnmaGE=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 7CCC660D1D;
        Thu, 11 Jul 2019 02:05:21 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 132A9B00668; Thu, 11 Jul 2019 11:05:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/7] brcmfmac: change the order of things in brcmf_detach()
Date:   Thu, 11 Jul 2019 11:05:07 +0200
Message-Id: <1562835912-1404-3-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When brcmf_detach() from the bus layer upon rmmod we can no longer
communicate. Hence we will set the bus state to DOWN and cleanup
the event and protocol layer. The network interfaces need to be
deleted before brcmf_cfg80211_detach() because the latter does the
wiphy_unregister() which issues a warning if there are still network
devices linked to the wiphy instance.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    | 27 +++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index fda6044..80d54d2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1307,25 +1307,26 @@ void brcmf_detach(struct device *dev)
 	unregister_inet6addr_notifier(&drvr->inet6addr_notifier);
 #endif
 
-	/* stop firmware event handling */
-	brcmf_fweh_detach(drvr);
-	if (drvr->config)
-		brcmf_p2p_detach(&drvr->config->p2p);
-
 	brcmf_bus_change_state(bus_if, BRCMF_BUS_DOWN);
-
-	/* make sure primary interface removed last */
-	for (i = BRCMF_MAX_IFS-1; i > -1; i--)
-		brcmf_remove_interface(drvr->iflist[i], false);
-
-	brcmf_cfg80211_detach(drvr->config);
-	drvr->config = NULL;
-
 	brcmf_bus_stop(drvr->bus_if);
 
+	brcmf_fweh_detach(drvr);
 	brcmf_proto_detach(drvr);
 
+	/* make sure primary interface removed last */
+	for (i = BRCMF_MAX_IFS - 1; i > -1; i--) {
+		if (drvr->iflist[i])
+			brcmf_del_if(drvr, drvr->iflist[i]->bsscfgidx, false);
+	}
+
+	if (drvr->config) {
+		brcmf_p2p_detach(&drvr->config->p2p);
+		brcmf_cfg80211_detach(drvr->config);
+		drvr->config = NULL;
+	}
+
 	bus_if->drvr = NULL;
+
 	wiphy_free(drvr->wiphy);
 }
 
-- 
1.9.1

