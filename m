Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90305761E69
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjGYQYN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjGYQYL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 12:24:11 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F2C212A
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 09:24:06 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1380:0:640:6985:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 32710600A9;
        Tue, 25 Jul 2023 19:24:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2ONSKkeDVKo0-QnX4HVtl;
        Tue, 25 Jul 2023 19:24:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690302243;
        bh=//OSBRL26x5nFYFfZsf6+B6wj2Dp91qSslbgcnyZs44=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=QDHmJab6EsM2PtR1/K0ihZHDfRTejFTMFfu9kHE3QGAeqy+ah+0DIjzVHvsSmhGGm
         xVG1xOp7yZfoYnsca1U3FrnB9rF3/8SZQ7LlZ9s/acNRKjIiel6vJo6j1YyvU1S1mQ
         ENu4dlIO0v+AKincTXGOK+fNbbUxuMOHAdY+TR0k=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: brcmsmac: cleanup SCB-related data types
Date:   Tue, 25 Jul 2023 19:23:46 +0300
Message-ID: <20230725162400.192357-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725162400.192357-1-dmantipov@yandex.ru>
References: <20230725162400.192357-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop unused and set-but-unused fields of 'struct scb_ampdu_tid_ini',
'struct scb_ampdu' and 'struct scb', as well as now unused argument
of 'brcms_c_ampdu_tx_operational()', adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../wireless/broadcom/brcm80211/brcmsmac/ampdu.c   |  6 ------
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |  8 +++-----
 .../wireless/broadcom/brcm80211/brcmsmac/main.c    |  2 --
 .../net/wireless/broadcom/brcm80211/brcmsmac/pub.h |  2 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/scb.h | 14 --------------
 5 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
index e24228e60027..e859075db716 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c
@@ -476,11 +476,9 @@ static int brcms_c_ffpld_check_txfunfl(struct brcms_c_info *wlc, int fid)
 
 void
 brcms_c_ampdu_tx_operational(struct brcms_c_info *wlc, u8 tid,
-	u8 ba_wsize,		/* negotiated ba window size (in pdu) */
 	uint max_rx_ampdu_bytes) /* from ht_cap in beacon */
 {
 	struct scb_ampdu *scb_ampdu;
-	struct scb_ampdu_tid_ini *ini;
 	struct ampdu_info *ampdu = wlc->ampdu;
 	struct scb *scb = &wlc->pri_scb;
 	scb_ampdu = &scb->scb_ampdu;
@@ -491,10 +489,6 @@ brcms_c_ampdu_tx_operational(struct brcms_c_info *wlc, u8 tid,
 		return;
 	}
 
-	ini = &scb_ampdu->ini[tid];
-	ini->tid = tid;
-	ini->scb = scb_ampdu->scb;
-	ini->ba_wsize = ba_wsize;
 	scb_ampdu->max_rx_ampdu_bytes = max_rx_ampdu_bytes;
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 0bd4e679a359..543e93ec49d2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -810,7 +810,6 @@ brcms_ops_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	brcms_c_init_scb(scb);
 
 	wl->pub->global_ampdu = &(scb->scb_ampdu);
-	wl->pub->global_ampdu->scb = scb;
 	wl->pub->global_ampdu->max_pdu = 16;
 
 	/*
@@ -831,7 +830,6 @@ brcms_ops_ampdu_action(struct ieee80211_hw *hw,
 	struct ieee80211_sta *sta = params->sta;
 	enum ieee80211_ampdu_mlme_action action = params->action;
 	u16 tid = params->tid;
-	u8 buf_size = params->buf_size;
 
 	if (WARN_ON(scb->magic != SCB_MAGIC))
 		return -EIDRM;
@@ -863,11 +861,11 @@ brcms_ops_ampdu_action(struct ieee80211_hw *hw,
 		/*
 		 * BA window size from ADDBA response ('buf_size') defines how
 		 * many outstanding MPDUs are allowed for the BA stream by
-		 * recipient and traffic class. 'ampdu_factor' gives maximum
-		 * AMPDU size.
+		 * recipient and traffic class (this is actually unused by the
+		 * rest of the driver). 'ampdu_factor' gives maximum AMPDU size.
 		 */
 		spin_lock_bh(&wl->lock);
-		brcms_c_ampdu_tx_operational(wl->wlc, tid, buf_size,
+		brcms_c_ampdu_tx_operational(wl->wlc, tid,
 			(1 << (IEEE80211_HT_MAX_AMPDU_FACTOR +
 			 sta->deflink.ht_cap.ampdu_factor)) - 1);
 		spin_unlock_bh(&wl->lock);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index 11b33e78127c..b3663c5ef382 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -3147,10 +3147,8 @@ void brcms_c_init_scb(struct scb *scb)
 	scb->flags = SCB_WMECAP | SCB_HTCAP;
 	for (i = 0; i < NUMPRIO; i++) {
 		scb->seqnum[i] = 0;
-		scb->seqctl[i] = 0xFFFF;
 	}
 
-	scb->seqctl_nonqos = 0xFFFF;
 	scb->magic = SCB_MAGIC;
 }
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
index 4da38cb4f318..bfc63b2f0537 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/pub.h
@@ -297,7 +297,7 @@ struct brcms_pub *brcms_c_pub(struct brcms_c_info *wlc);
 void brcms_c_ampdu_flush(struct brcms_c_info *wlc, struct ieee80211_sta *sta,
 			 u16 tid);
 void brcms_c_ampdu_tx_operational(struct brcms_c_info *wlc, u8 tid,
-				  u8 ba_wsize, uint max_rx_ampdu_bytes);
+				  uint max_rx_ampdu_bytes);
 int brcms_c_module_register(struct brcms_pub *pub, const char *name,
 			    struct brcms_info *hdl,
 			    int (*down_fn)(void *handle));
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h
index 3a3d73699f83..d65561227da0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/scb.h
@@ -36,19 +36,13 @@
 
 /* structure to store per-tid state for the ampdu initiator */
 struct scb_ampdu_tid_ini {
-	u8 tid;		  /* initiator tid for easy lookup */
 	/* tx retry count; indexed by seq modulo */
 	u8 txretry[AMPDU_TX_BA_MAX_WSIZE];
-	struct scb *scb;  /* backptr for easy lookup */
-	u8 ba_wsize;	  /* negotiated ba window size (in pdu) */
 };
 
 struct scb_ampdu {
-	struct scb *scb;	/* back pointer for easy reference */
-	u8 mpdu_density;	/* mpdu density */
 	u8 max_pdu;		/* max pdus allowed in ampdu */
 	u8 release;		/* # of mpdus released at a time */
-	u16 min_len;		/* min mpdu len to support the density */
 	u32 max_rx_ampdu_bytes;	/* max ampdu rcv length; 8k, 16k, 32k, 64k */
 
 	/*
@@ -64,15 +58,7 @@ struct scb_ampdu {
 struct scb {
 	u32 magic;
 	u32 flags;	/* various bit flags as defined below */
-	u32 flags2;	/* various bit flags2 as defined below */
-	u8 state;	/* current state bitfield of auth/assoc process */
-	u8 ea[ETH_ALEN];	/* station address */
-	uint fragresid[NUMPRIO];/* #bytes unused in frag buffer per prio */
-
 	u16 seqctl[NUMPRIO];	/* seqctl of last received frame (for dups) */
-	/* seqctl of last received frame (for dups) for non-QoS data and
-	 * management */
-	u16 seqctl_nonqos;
 	u16 seqnum[NUMPRIO];/* WME: driver maintained sw seqnum per priority */
 
 	struct scb_ampdu scb_ampdu;	/* AMPDU state including per tid info */
-- 
2.41.0

