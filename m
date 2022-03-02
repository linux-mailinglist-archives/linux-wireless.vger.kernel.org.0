Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968254CA1FB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 11:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiCBKRh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Mar 2022 05:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbiCBKRg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Mar 2022 05:17:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DCB782D1A
        for <linux-wireless@vger.kernel.org>; Wed,  2 Mar 2022 02:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646216211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zQd2783TnPZvXRp3YcZvP32cETbkUxInXUbXRwjrh78=;
        b=XsjJ+/agGoDqB2S02duCTB5o79rcdpMIdUZWZVc5CwCfftOVN/hGN21FocXww/j+fVDZn6
        9pBdxk1Aq9yGFBP6lsSqdHdFrCxkh4Q7EpNHt+7jxKNGCt1tn9hvPN5BOF1RkFaLB/xDeu
        F1G8jNefjV3bx3aU8T0zF8iVzAvlgUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-pymoe-0VNkmCouNfvnik8g-1; Wed, 02 Mar 2022 05:16:50 -0500
X-MC-Unique: pymoe-0VNkmCouNfvnik8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7341E1006AA6;
        Wed,  2 Mar 2022 10:16:49 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE5A283182;
        Wed,  2 Mar 2022 10:16:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org, linux-staging@lists.linux.dev,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: Fix access-point mode deadlock
Date:   Wed,  2 Mar 2022 11:16:36 +0100
Message-Id: <20220302101637.26542-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit 54659ca026e5 ("staging: rtl8723bs: remove possible deadlock when
disconnect (v2)") split the locking of pxmitpriv->lock vs sleep_q/lock
into 2 locks in attempt to fix a lockdep reported issue with the locking
order of the sta_hash_lock vs pxmitpriv->lock.

But in the end this turned out to not fully solve the sta_hash_lock issue
so commit a7ac783c338b ("staging: rtl8723bs: remove a second possible
deadlock") was added to fix this in another way.

The original fix was kept as it was still seen as a good thing to have,
but now it turns out that it creates a deadlock in access-point mode:

[Feb20 23:47] ======================================================
[  +0.074085] WARNING: possible circular locking dependency detected
[  +0.074077] 5.16.0-1-amd64 #1 Tainted: G         C  E
[  +0.064710] ------------------------------------------------------
[  +0.074075] ksoftirqd/3/29 is trying to acquire lock:
[  +0.060542] ffffb8b30062ab00 (&pxmitpriv->lock){+.-.}-{2:2}, at: rtw_xmit_classifier+0x8a/0x140 [r8723bs]
[  +0.114921]
              but task is already holding lock:
[  +0.069908] ffffb8b3007ab704 (&psta->sleep_q.lock){+.-.}-{2:2}, at: wakeup_sta_to_xmit+0x3b/0x300 [r8723bs]
[  +0.116976]
              which lock already depends on the new lock.

[  +0.098037]
              the existing dependency chain (in reverse order) is:
[  +0.089704]
              -> #1 (&psta->sleep_q.lock){+.-.}-{2:2}:
[  +0.077232]        _raw_spin_lock_bh+0x34/0x40
[  +0.053261]        xmitframe_enqueue_for_sleeping_sta+0xc1/0x2f0 [r8723bs]
[  +0.082572]        rtw_xmit+0x58b/0x940 [r8723bs]
[  +0.056528]        _rtw_xmit_entry+0xba/0x350 [r8723bs]
[  +0.062755]        dev_hard_start_xmit+0xf1/0x320
[  +0.056381]        sch_direct_xmit+0x9e/0x360
[  +0.052212]        __dev_queue_xmit+0xce4/0x1080
[  +0.055334]        ip6_finish_output2+0x18f/0x6e0
[  +0.056378]        ndisc_send_skb+0x2c8/0x870
[  +0.052209]        ndisc_send_ns+0xd3/0x210
[  +0.050130]        addrconf_dad_work+0x3df/0x5a0
[  +0.055338]        process_one_work+0x274/0x5a0
[  +0.054296]        worker_thread+0x52/0x3b0
[  +0.050124]        kthread+0x16c/0x1a0
[  +0.044925]        ret_from_fork+0x1f/0x30
[  +0.049092]
              -> #0 (&pxmitpriv->lock){+.-.}-{2:2}:
[  +0.074101]        __lock_acquire+0x10f5/0x1d80
[  +0.054298]        lock_acquire+0xd7/0x300
[  +0.049088]        _raw_spin_lock_bh+0x34/0x40
[  +0.053248]        rtw_xmit_classifier+0x8a/0x140 [r8723bs]
[  +0.066949]        rtw_xmitframe_enqueue+0xa/0x20 [r8723bs]
[  +0.066946]        rtl8723bs_hal_xmitframe_enqueue+0x14/0x50 [r8723bs]
[  +0.078386]        wakeup_sta_to_xmit+0xa6/0x300 [r8723bs]
[  +0.065903]        rtw_recv_entry+0xe36/0x1160 [r8723bs]
[  +0.063809]        rtl8723bs_recv_tasklet+0x349/0x6c0 [r8723bs]
[  +0.071093]        tasklet_action_common.constprop.0+0xe5/0x110
[  +0.070966]        __do_softirq+0x16f/0x50a
[  +0.050134]        __irq_exit_rcu+0xeb/0x140
[  +0.051172]        irq_exit_rcu+0xa/0x20
[  +0.047006]        common_interrupt+0xb8/0xd0
[  +0.052214]        asm_common_interrupt+0x1e/0x40
[  +0.056381]        finish_task_switch.isra.0+0x100/0x3a0
[  +0.063670]        __schedule+0x3ad/0xd20
[  +0.048047]        schedule+0x4e/0xc0
[  +0.043880]        smpboot_thread_fn+0xc4/0x220
[  +0.054298]        kthread+0x16c/0x1a0
[  +0.044922]        ret_from_fork+0x1f/0x30
[  +0.049088]
              other info that might help us debug this:

[  +0.095950]  Possible unsafe locking scenario:

[  +0.070952]        CPU0                    CPU1
[  +0.054282]        ----                    ----
[  +0.054285]   lock(&psta->sleep_q.lock);
[  +0.047004]                                lock(&pxmitpriv->lock);
[  +0.074082]                                lock(&psta->sleep_q.lock);
[  +0.077209]   lock(&pxmitpriv->lock);
[  +0.043873]
               *** DEADLOCK ***

[  +0.070950] 1 lock held by ksoftirqd/3/29:
[  +0.049082]  #0: ffffb8b3007ab704 (&psta->sleep_q.lock){+.-.}-{2:2}, at: wakeup_sta_to_xmit+0x3b/0x300 [r8723bs]

Analysis shows that in hindsight the splitting of the lock was not
a good idea, so revert this to fix the access-point mode deadlock.

Note this is a straight-forward revert done with git revert, the commented
out "/* spin_lock_bh(&psta_bmc->sleep_q.lock); */" lines were part of the
code before the reverted changes.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215542
Fixes: 54659ca026e5 ("staging: rtl8723bs: remove possible deadlock when disconnect (v2)")
Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  7 ++++--
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 10 ++++++---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  | 22 +++++++++----------
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 16 ++++++++------
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  2 ++
 5 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 0f82f5031c43..49a3f45cb771 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5907,6 +5907,7 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
 	struct sta_info *psta_bmc;
 	struct list_head *xmitframe_plist, *xmitframe_phead, *tmp;
 	struct xmit_frame *pxmitframe = NULL;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct sta_priv  *pstapriv = &padapter->stapriv;
 
 	/* for BC/MC Frames */
@@ -5917,7 +5918,8 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
 	if ((pstapriv->tim_bitmap&BIT(0)) && (psta_bmc->sleepq_len > 0)) {
 		msleep(10);/*  10ms, ATIM(HIQ) Windows */
 
-		spin_lock_bh(&psta_bmc->sleep_q.lock);
+		/* spin_lock_bh(&psta_bmc->sleep_q.lock); */
+		spin_lock_bh(&pxmitpriv->lock);
 
 		xmitframe_phead = get_list_head(&psta_bmc->sleep_q);
 		list_for_each_safe(xmitframe_plist, tmp, xmitframe_phead) {
@@ -5940,7 +5942,8 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
 			rtw_hal_xmitframe_enqueue(padapter, pxmitframe);
 		}
 
-		spin_unlock_bh(&psta_bmc->sleep_q.lock);
+		/* spin_unlock_bh(&psta_bmc->sleep_q.lock); */
+		spin_unlock_bh(&pxmitpriv->lock);
 
 		/* check hi queue and bmc_sleepq */
 		rtw_chk_hi_queue_cmd(padapter);
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 36a50bccef08..d8d394b67eeb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -957,8 +957,10 @@ static signed int validate_recv_ctrl_frame(struct adapter *padapter, union recv_
 		if ((psta->state&WIFI_SLEEP_STATE) && (pstapriv->sta_dz_bitmap&BIT(psta->aid))) {
 			struct list_head	*xmitframe_plist, *xmitframe_phead;
 			struct xmit_frame *pxmitframe = NULL;
+			struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
-			spin_lock_bh(&psta->sleep_q.lock);
+			/* spin_lock_bh(&psta->sleep_q.lock); */
+			spin_lock_bh(&pxmitpriv->lock);
 
 			xmitframe_phead = get_list_head(&psta->sleep_q);
 			xmitframe_plist = get_next(xmitframe_phead);
@@ -989,10 +991,12 @@ static signed int validate_recv_ctrl_frame(struct adapter *padapter, union recv_
 					update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 				}
 
-				spin_unlock_bh(&psta->sleep_q.lock);
+				/* spin_unlock_bh(&psta->sleep_q.lock); */
+				spin_unlock_bh(&pxmitpriv->lock);
 
 			} else {
-				spin_unlock_bh(&psta->sleep_q.lock);
+				/* spin_unlock_bh(&psta->sleep_q.lock); */
+				spin_unlock_bh(&pxmitpriv->lock);
 
 				if (pstapriv->tim_bitmap&BIT(psta->aid)) {
 					if (psta->sleepq_len == 0) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 0c9ea1520fd0..beb11d89db18 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -293,48 +293,46 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 	/* list_del_init(&psta->wakeup_list); */
 
-	spin_lock_bh(&psta->sleep_q.lock);
+	spin_lock_bh(&pxmitpriv->lock);
+
 	rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
 	psta->sleepq_len = 0;
-	spin_unlock_bh(&psta->sleep_q.lock);
-
-	spin_lock_bh(&pxmitpriv->lock);
 
 	/* vo */
-	spin_lock_bh(&pstaxmitpriv->vo_q.sta_pending.lock);
+	/* spin_lock_bh(&(pxmitpriv->vo_pending.lock)); */
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
 	list_del_init(&(pstaxmitpriv->vo_q.tx_pending));
 	phwxmit = pxmitpriv->hwxmits;
 	phwxmit->accnt -= pstaxmitpriv->vo_q.qcnt;
 	pstaxmitpriv->vo_q.qcnt = 0;
-	spin_unlock_bh(&pstaxmitpriv->vo_q.sta_pending.lock);
+	/* spin_unlock_bh(&(pxmitpriv->vo_pending.lock)); */
 
 	/* vi */
-	spin_lock_bh(&pstaxmitpriv->vi_q.sta_pending.lock);
+	/* spin_lock_bh(&(pxmitpriv->vi_pending.lock)); */
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
 	list_del_init(&(pstaxmitpriv->vi_q.tx_pending));
 	phwxmit = pxmitpriv->hwxmits+1;
 	phwxmit->accnt -= pstaxmitpriv->vi_q.qcnt;
 	pstaxmitpriv->vi_q.qcnt = 0;
-	spin_unlock_bh(&pstaxmitpriv->vi_q.sta_pending.lock);
+	/* spin_unlock_bh(&(pxmitpriv->vi_pending.lock)); */
 
 	/* be */
-	spin_lock_bh(&pstaxmitpriv->be_q.sta_pending.lock);
+	/* spin_lock_bh(&(pxmitpriv->be_pending.lock)); */
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
 	list_del_init(&(pstaxmitpriv->be_q.tx_pending));
 	phwxmit = pxmitpriv->hwxmits+2;
 	phwxmit->accnt -= pstaxmitpriv->be_q.qcnt;
 	pstaxmitpriv->be_q.qcnt = 0;
-	spin_unlock_bh(&pstaxmitpriv->be_q.sta_pending.lock);
+	/* spin_unlock_bh(&(pxmitpriv->be_pending.lock)); */
 
 	/* bk */
-	spin_lock_bh(&pstaxmitpriv->bk_q.sta_pending.lock);
+	/* spin_lock_bh(&(pxmitpriv->bk_pending.lock)); */
 	rtw_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
 	list_del_init(&(pstaxmitpriv->bk_q.tx_pending));
 	phwxmit = pxmitpriv->hwxmits+3;
 	phwxmit->accnt -= pstaxmitpriv->bk_q.qcnt;
 	pstaxmitpriv->bk_q.qcnt = 0;
-	spin_unlock_bh(&pstaxmitpriv->bk_q.sta_pending.lock);
+	/* spin_unlock_bh(&(pxmitpriv->bk_pending.lock)); */
 
 	spin_unlock_bh(&pxmitpriv->lock);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 13b8bd5ffabc..f466bfd248fb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1734,12 +1734,15 @@ void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv, struct __queue *pfram
 	struct list_head *plist, *phead, *tmp;
 	struct	xmit_frame	*pxmitframe;
 
+	spin_lock_bh(&pframequeue->lock);
+
 	phead = get_list_head(pframequeue);
 	list_for_each_safe(plist, tmp, phead) {
 		pxmitframe = list_entry(plist, struct xmit_frame, list);
 
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 	}
+	spin_unlock_bh(&pframequeue->lock);
 }
 
 s32 rtw_xmitframe_enqueue(struct adapter *padapter, struct xmit_frame *pxmitframe)
@@ -1794,7 +1797,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	struct sta_info *psta;
 	struct tx_servq	*ptxservq;
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
-	struct xmit_priv *xmit_priv = &padapter->xmitpriv;
 	struct hw_xmit	*phwxmits =  padapter->xmitpriv.hwxmits;
 	signed int res = _SUCCESS;
 
@@ -1812,14 +1814,12 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	ptxservq = rtw_get_sta_pending(padapter, psta, pattrib->priority, (u8 *)(&ac_index));
 
-	spin_lock_bh(&xmit_priv->lock);
 	if (list_empty(&ptxservq->tx_pending))
 		list_add_tail(&ptxservq->tx_pending, get_list_head(phwxmits[ac_index].sta_queue));
 
 	list_add_tail(&pxmitframe->list, get_list_head(&ptxservq->sta_pending));
 	ptxservq->qcnt++;
 	phwxmits[ac_index].accnt++;
-	spin_unlock_bh(&xmit_priv->lock);
 
 exit:
 
@@ -2202,10 +2202,11 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 	struct list_head *xmitframe_plist, *xmitframe_phead, *tmp;
 	struct xmit_frame *pxmitframe = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	psta_bmc = rtw_get_bcmc_stainfo(padapter);
 
-	spin_lock_bh(&psta->sleep_q.lock);
+	spin_lock_bh(&pxmitpriv->lock);
 
 	xmitframe_phead = get_list_head(&psta->sleep_q);
 	list_for_each_safe(xmitframe_plist, tmp, xmitframe_phead) {
@@ -2306,7 +2307,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 _exit:
 
-	spin_unlock_bh(&psta->sleep_q.lock);
+	spin_unlock_bh(&pxmitpriv->lock);
 
 	if (update_mask)
 		update_beacon(padapter, WLAN_EID_TIM, NULL, true);
@@ -2318,8 +2319,9 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 	struct list_head *xmitframe_plist, *xmitframe_phead, *tmp;
 	struct xmit_frame *pxmitframe = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
-	spin_lock_bh(&psta->sleep_q.lock);
+	spin_lock_bh(&pxmitpriv->lock);
 
 	xmitframe_phead = get_list_head(&psta->sleep_q);
 	list_for_each_safe(xmitframe_plist, tmp, xmitframe_phead) {
@@ -2372,7 +2374,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 		}
 	}
 
-	spin_unlock_bh(&psta->sleep_q.lock);
+	spin_unlock_bh(&pxmitpriv->lock);
 }
 
 void enqueue_pending_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index b5d5e922231c..15810438a472 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -502,7 +502,9 @@ s32 rtl8723bs_hal_xmit(
 			rtw_issue_addbareq_cmd(padapter, pxmitframe);
 	}
 
+	spin_lock_bh(&pxmitpriv->lock);
 	err = rtw_xmitframe_enqueue(padapter, pxmitframe);
+	spin_unlock_bh(&pxmitpriv->lock);
 	if (err != _SUCCESS) {
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 
-- 
2.35.1

