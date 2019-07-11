Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9E6537A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 11:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfGKJFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 05:05:24 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:59772 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfGKJFX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 05:05:23 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 4CB1130C011;
        Thu, 11 Jul 2019 02:05:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 4CB1130C011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562835922;
        bh=evJ2YgywfvGgaEQWOgqUwRBphKeGsIL/tlAue/L5lfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4CLRWpfX3QVZYWNwKBY/kkWi0cwskf99g/NgZUpMOMXKSxsffaVd2/iDdAbIhz2f
         j1Il1+MiBzIN9bppT/VUEty52leeqZu+HJVsH9GKRYsxxgd8JOdd2TKv+eZdcKWknP
         9JSuKs3QAiz3zbTNJuZg9IDyr9obHsHgY/d76WXM=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 3EAFB60D1D;
        Thu, 11 Jul 2019 02:05:22 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 14686B02F12; Thu, 11 Jul 2019 11:05:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 3/7] brcmfmac: avoid firmware command in brcmf_netdev_open() when bus is down
Date:   Thu, 11 Jul 2019 11:05:08 +0200
Message-Id: <1562835912-1404-4-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No point in sending a firmware command when bus is down so make it
conditional checking the state.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 80d54d2..705b8cc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -579,7 +579,8 @@ static int brcmf_netdev_stop(struct net_device *ndev)
 
 	brcmf_cfg80211_down(ndev);
 
-	brcmf_fil_iovar_data_set(ifp, "arp_hostip_clear", NULL, 0);
+	if (ifp->drvr->bus_if->state == BRCMF_BUS_UP)
+		brcmf_fil_iovar_data_set(ifp, "arp_hostip_clear", NULL, 0);
 
 	brcmf_net_setcarrier(ifp, false);
 
-- 
1.9.1

