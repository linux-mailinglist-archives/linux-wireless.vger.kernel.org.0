Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66861E444
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfD2OH4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:07:56 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:60966 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728119AbfD2OHz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:07:55 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id EB85530C055;
        Mon, 29 Apr 2019 07:07:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com EB85530C055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1556546873;
        bh=+njzF/MkWyQUo99XszOttuAyYfxImuTEyzZXCSrj/MA=;
        h=From:Date:Subject:To:From;
        b=QzzNydw0zIPBycE5OmTDzwh2Aonsho60wXrQIq3YaQU0KdspPJZwKrhZ8I+c4rUO0
         cW6KpONT/oF6T8bqpy9HfjbQGuIb+9Ex7LHI8ojCYi0Iz+6+6yECXQ54AuTqjegCUP
         EnEtUZO1YMMGEmomqFYVkhKoshk8JjgvlarzB5RE=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 72997147535;
        Mon, 29 Apr 2019 04:59:48 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 3F444B02A68; Mon, 29 Apr 2019 13:59:46 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Date:   Mon, 29 Apr 2019 11:06:07 +0200
Subject: [PATCH] brcmfmac: change the order of things in brcmf_detach()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20190429115947.3F444B02A68@bld-bun-01.bun.broadcom.com>
To:     undisclosed-recipients:;
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

This change solves a null pointer dereference issue which happened
upon issueing rmmod while there are packets queued in bus protocol
layer.

Reported-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Hi Piotr,

While working on an issue with msgbuf protocol (used for PCIe devices)
your change 5cdb0ef6144f ("brcmfmac: fix NULL pointer derefence during
USB disconnect") conflicted. I suspect my reordering stuff in
brcmf_detach() also fixes your issue so could you retest this patch,
which basically reverts your change and applies my reordering, and see
whether my suspicion can be confirmed.

Regards,
Arend
---
 .../wireless/broadcom/brcm80211/brcmfmac/bcdc.c    | 11 ++-------
 .../wireless/broadcom/brcm80211/brcmfmac/bcdc.h    |  6 ++---
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    | 27 +++++++++++-----------
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         | 16 ++++---------
 .../broadcom/brcm80211/brcmfmac/fwsignal.h         |  3 +--
 .../wireless/broadcom/brcm80211/brcmfmac/proto.c   | 10 ++------
 .../wireless/broadcom/brcm80211/brcmfmac/proto.h   |  3 +--
 7 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
index 98b1687..73d3c1a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
@@ -490,18 +490,11 @@ int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr)
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
index 4bc5224..3b0e9ef 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.h
@@ -18,16 +18,14 @@
 
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
index bc73a2e..db49381 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1322,27 +1322,26 @@ void brcmf_detach(struct device *dev)
 	unregister_inet6addr_notifier(&drvr->inet6addr_notifier);
 #endif
 
-	/* stop firmware event handling */
-	brcmf_fweh_detach(drvr);
-	if (drvr->config)
-		brcmf_p2p_detach(&drvr->config->p2p);
-
 	brcmf_bus_change_state(bus_if, BRCMF_BUS_DOWN);
+	brcmf_bus_stop(drvr->bus_if);
 
-	brcmf_proto_detach_pre_delif(drvr);
+	brcmf_fweh_detach(drvr);
+	brcmf_proto_detach(drvr);
 
 	/* make sure primary interface removed last */
-	for (i = BRCMF_MAX_IFS-1; i > -1; i--)
-		brcmf_remove_interface(drvr->iflist[i], false);
-
-	brcmf_cfg80211_detach(drvr->config);
-	drvr->config = NULL;
-
-	brcmf_bus_stop(drvr->bus_if);
+	for (i = BRCMF_MAX_IFS-1; i > -1; i--) {
+		if (drvr->iflist[i])
+			brcmf_del_if(drvr, drvr->iflist[i]->bsscfgidx, false);
+	}
 
-	brcmf_proto_detach_post_delif(drvr);
+	if (drvr->config) {
+		brcmf_p2p_detach(&drvr->config->p2p);
+		brcmf_cfg80211_detach(drvr->config);
+		drvr->config = NULL;
+	}
 
 	bus_if->drvr = NULL;
+
 	wiphy_free(drvr->wiphy);
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index c22c49a..d48b8b2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -2443,25 +2443,17 @@ struct brcmf_fws_info *brcmf_fws_attach(struct brcmf_pub *drvr)
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
index 749c06d..4e68357 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h
@@ -19,8 +19,7 @@
 #define FWSIGNAL_H_
 
 struct brcmf_fws_info *brcmf_fws_attach(struct brcmf_pub *drvr);
-void brcmf_fws_detach_pre_delif(struct brcmf_fws_info *fws);
-void brcmf_fws_detach_post_delif(struct brcmf_fws_info *fws);
+void brcmf_fws_detach(struct brcmf_fws_info *fws);
 void brcmf_fws_debugfs_create(struct brcmf_pub *drvr);
 bool brcmf_fws_queue_skbs(struct brcmf_fws_info *fws);
 bool brcmf_fws_fc_active(struct brcmf_fws_info *fws);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
index c7964cc..024c643 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.c
@@ -67,22 +67,16 @@ int brcmf_proto_attach(struct brcmf_pub *drvr)
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
index 72355ae..d3c3b9a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h
@@ -54,8 +54,7 @@ struct brcmf_proto {
 
 
 int brcmf_proto_attach(struct brcmf_pub *drvr);
-void brcmf_proto_detach_pre_delif(struct brcmf_pub *drvr);
-void brcmf_proto_detach_post_delif(struct brcmf_pub *drvr);
+void brcmf_proto_detach(struct brcmf_pub *drvr);
 
 static inline int brcmf_proto_hdrpull(struct brcmf_pub *drvr, bool do_fws,
 				      struct sk_buff *skb,
-- 
1.9.1

