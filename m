Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2365379
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2019 11:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfGKJFZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 05:05:25 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:59788 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728285AbfGKJFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 05:05:24 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id B092F30C02B;
        Thu, 11 Jul 2019 02:05:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com B092F30C02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1562835922;
        bh=3fqjl86LgJebGpfrNfd0GEIL/RzsXxiL0uyPv6CB+Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VTclBEFaXpX2WhBqkJIXfw5wsNKGehJ6cSpdOz9rNKV+QhjjG7Z3hOeSrQZirQExs
         CxxPIP+BJ51qoP/TCdvwAMdrBfyojNfbAaclrdURwhvN1Uwqakj3d7hbCb3cZy1x/X
         WEpIt9Dcn0pXS/pRVbW+2xYpNpD/yPRv9Egnuc0E=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id D4ED860D94;
        Thu, 11 Jul 2019 02:05:22 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 14EEDB02D0B; Thu, 11 Jul 2019 11:05:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/7] Revert "brcmfmac: fix NULL pointer derefence during USB disconnect"
Date:   Thu, 11 Jul 2019 11:05:06 +0200
Message-Id: <1562835912-1404-2-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1562835912-1404-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This reverts commit 5cdb0ef6144f47440850553579aa923c20a63f23. Subsequent
changes make rework the driver code fixing the issue differently.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c  | 11 ++---------
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h  |  6 ++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c  |  4 +---
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c  | 16 ++++------------
 .../net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h  |  3 +--
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c | 10 ++--------
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h |  3 +--
 7 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
index 322e913..2c95a08 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
@@ -479,18 +479,11 @@ int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr)
 	return -ENOMEM;
 }
 
-void brcmf_proto_bcdc_detach_pre_delif(struct brcmf_pub *drvr)
-{
-	struct brcmf_bcdc *bcdc = drvr->proto->pd;
-
-	brcmf_fws_detach_pre_delif(bcdc->fws);
-}
-
-void brcmf_proto_bcdc_detach_post_delif(struct brcmf_pub *drvr)
+void brcmf_proto_bcdc_detach(struct brcmf_pub *drvr)
 {
 	struct brcmf_bcdc *bcdc = drvr->proto->pd;
 
 	drvr->proto->pd = NULL;
-	brcmf_fws_detach_post_delif(bcdc->fws);
+	brcmf_fws_detach(bcdc->fws);
 	kfree(bcdc);
 }
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h
index 102e693..b051d28 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h
@@ -7,16 +7,14 @@
 
 #ifdef CONFIG_BRCMFMAC_PROTO_BCDC
 int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr);
-void brcmf_proto_bcdc_detach_pre_delif(struct brcmf_pub *drvr);
-void brcmf_proto_bcdc_detach_post_delif(struct brcmf_pub *drvr);
+void brcmf_proto_bcdc_detach(struct brcmf_pub *drvr);
 void brcmf_proto_bcdc_txflowblock(struct device *dev, bool state);
 void brcmf_proto_bcdc_txcomplete(struct device *dev, struct sk_buff *txp,
 				 bool success);
 struct brcmf_fws_info *drvr_to_fws(struct brcmf_pub *drvr);
 #else
 static inline int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr) { return 0; }
-static void brcmf_proto_bcdc_detach_pre_delif(struct brcmf_pub *drvr) {};
-static inline void brcmf_proto_bcdc_detach_post_delif(struct brcmf_pub *drvr) {}
+static inline void brcmf_proto_bcdc_detach(struct brcmf_pub *drvr) {}
 #endif
 
 #endif /* BRCMFMAC_BCDC_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index bf18491..fda6044 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1314,8 +1314,6 @@ void brcmf_detach(struct device *dev)
 
 	brcmf_bus_change_state(bus_if, BRCMF_BUS_DOWN);
 
-	brcmf_proto_detach_pre_delif(drvr);
-
 	/* make sure primary interface removed last */
 	for (i = BRCMF_MAX_IFS-1; i > -1; i--)
 		brcmf_remove_interface(drvr->iflist[i], false);
@@ -1325,7 +1323,7 @@ void brcmf_detach(struct device *dev)
 
 	brcmf_bus_stop(drvr->bus_if);
 
-	brcmf_proto_detach_post_delif(drvr);
+	brcmf_proto_detach(drvr);
 
 	bus_if->drvr = NULL;
 	wiphy_free(drvr->wiphy);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index b8452cb..2bd892d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -2432,25 +2432,17 @@ struct brcmf_fws_info *brcmf_fws_attach(struct brcmf_pub *drvr)
 	return fws;
 
 fail:
-	brcmf_fws_detach_pre_delif(fws);
-	brcmf_fws_detach_post_delif(fws);
+	brcmf_fws_detach(fws);
 	return ERR_PTR(rc);
 }
 
-void brcmf_fws_detach_pre_delif(struct brcmf_fws_info *fws)
+void brcmf_fws_detach(struct brcmf_fws_info *fws)
 {
 	if (!fws)
 		return;
-	if (fws->fws_wq) {
-		destroy_workqueue(fws->fws_wq);
-		fws->fws_wq = NULL;
-	}
-}
 
-void brcmf_fws_detach_post_delif(struct brcmf_fws_info *fws)
-{
-	if (!fws)
-		return;
+	if (fws->fws_wq)
+		destroy_workqueue(fws->fws_wq);
 
 	/* cleanup */
 	brcmf_fws_lock(fws);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
index 10184ee..b486d57 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
@@ -7,8 +7,7 @@
 #define FWSIGNAL_H_
 
 struct brcmf_fws_info *brcmf_fws_attach(struct brcmf_pub *drvr);
-void brcmf_fws_detach_pre_delif(struct brcmf_fws_info *fws);
-void brcmf_fws_detach_post_delif(struct brcmf_fws_info *fws);
+void brcmf_fws_detach(struct brcmf_fws_info *fws);
 void brcmf_fws_debugfs_create(struct brcmf_pub *drvr);
 bool brcmf_fws_queue_skbs(struct brcmf_fws_info *fws);
 bool brcmf_fws_fc_active(struct brcmf_fws_info *fws);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
index e3d1b07..2e911d4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
@@ -56,22 +56,16 @@ int brcmf_proto_attach(struct brcmf_pub *drvr)
 	return -ENOMEM;
 }
 
-void brcmf_proto_detach_post_delif(struct brcmf_pub *drvr)
+void brcmf_proto_detach(struct brcmf_pub *drvr)
 {
 	brcmf_dbg(TRACE, "Enter\n");
 
 	if (drvr->proto) {
 		if (drvr->bus_if->proto_type == BRCMF_PROTO_BCDC)
-			brcmf_proto_bcdc_detach_post_delif(drvr);
+			brcmf_proto_bcdc_detach(drvr);
 		else if (drvr->bus_if->proto_type == BRCMF_PROTO_MSGBUF)
 			brcmf_proto_msgbuf_detach(drvr);
 		kfree(drvr->proto);
 		drvr->proto = NULL;
 	}
 }
-
-void brcmf_proto_detach_pre_delif(struct brcmf_pub *drvr)
-{
-	if (drvr->proto && drvr->bus_if->proto_type == BRCMF_PROTO_BCDC)
-		brcmf_proto_bcdc_detach_pre_delif(drvr);
-}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h
index 8d55fad..bd08d3a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h
@@ -43,8 +43,7 @@ struct brcmf_proto {
 
 
 int brcmf_proto_attach(struct brcmf_pub *drvr);
-void brcmf_proto_detach_pre_delif(struct brcmf_pub *drvr);
-void brcmf_proto_detach_post_delif(struct brcmf_pub *drvr);
+void brcmf_proto_detach(struct brcmf_pub *drvr);
 
 static inline int brcmf_proto_hdrpull(struct brcmf_pub *drvr, bool do_fws,
 				      struct sk_buff *skb,
-- 
1.9.1

