Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87C8745CFC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjGCNSu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCNSp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 09:18:45 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CEBDD
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 06:18:42 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2f8a:0:640:b50b:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id A5A7546C90;
        Mon,  3 Jul 2023 16:18:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id cIRqFk1DguQ0-Dh206JCm;
        Mon, 03 Jul 2023 16:18:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688390319;
        bh=SoDPmGnBxEBpHdJE7Oo5/qbnsyjN79pI8/QSDnUk30A=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=E4QOkIXRy8eK8+jRza3JmAHBALP19uDDRRrE593frCfiLAUBskXRkxy2jWF4oAqsC
         96N95AioEVJTiqYr8qoD33Pi84GVyAmub1sCda7gwrs0t99M3xef5cyUyzOCes0LUI
         vh1quL8fuWquoLsxrle6tJVJ7KAyxAxMF5zGBYn0=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmsmac: use generic lists to manage timers
Date:   Mon,  3 Jul 2023 16:17:21 +0300
Message-ID: <20230703131730.99500-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prefer generic lists over ad-hoc quirks to manage
timers, adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c | 35 ++++---------------
 .../broadcom/brcm80211/brcmsmac/mac80211_if.h |  4 +--
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 0bd4e679a359..d5fb47144943 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -314,8 +314,7 @@ static void brcms_free(struct brcms_info *wl)
 		schedule();
 
 	/* free timers */
-	for (t = wl->timers; t; t = next) {
-		next = t->next;
+	list_for_each_entry_safe(t, next, &wl->timers, list) {
 #ifdef DEBUG
 		kfree(t->name);
 #endif
@@ -1152,6 +1151,8 @@ static struct brcms_info *brcms_attach(struct bcma_device *pdev)
 	spin_lock_init(&wl->lock);
 	spin_lock_init(&wl->isr_lock);
 
+	INIT_LIST_HEAD(&wl->timers);
+
 	/* common load-time initialization */
 	wl->wlc = brcms_c_attach((void *)wl, pdev, unit, false, &err);
 	if (!wl->wlc) {
@@ -1502,8 +1503,7 @@ struct brcms_timer *brcms_init_timer(struct brcms_info *wl,
 	t->wl = wl;
 	t->fn = fn;
 	t->arg = arg;
-	t->next = wl->timers;
-	wl->timers = t;
+	list_add(&t->list, &wl->timers);
 
 #ifdef DEBUG
 	t->name = kstrdup(name, GFP_ATOMIC);
@@ -1561,35 +1561,14 @@ bool brcms_del_timer(struct brcms_timer *t)
  */
 void brcms_free_timer(struct brcms_timer *t)
 {
-	struct brcms_info *wl = t->wl;
-	struct brcms_timer *tmp;
-
 	/* delete the timer in case it is active */
 	brcms_del_timer(t);
 
-	if (wl->timers == t) {
-		wl->timers = wl->timers->next;
+	list_del(&t->list);
 #ifdef DEBUG
-		kfree(t->name);
+	kfree(t->name);
 #endif
-		kfree(t);
-		return;
-
-	}
-
-	tmp = wl->timers;
-	while (tmp) {
-		if (tmp->next == t) {
-			tmp->next = t->next;
-#ifdef DEBUG
-			kfree(t->name);
-#endif
-			kfree(t);
-			return;
-		}
-		tmp = tmp->next;
-	}
-
+	kfree(t);
 }
 
 /*
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
index eaf926a96a88..c2c3d90f4ed3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
@@ -41,7 +41,7 @@ struct brcms_timer {
 	uint ms;
 	bool periodic;
 	bool set;		/* indicates if timer is active */
-	struct brcms_timer *next;	/* for freeing on unload */
+	struct list_head list;	/* for freeing on unload */
 #ifdef DEBUG
 	char *name;		/* Description of the timer */
 #endif
@@ -75,7 +75,7 @@ struct brcms_info {
 
 	/* timer related fields */
 	atomic_t callbacks;	/* # outstanding callback functions */
-	struct brcms_timer *timers;	/* timer cleanup queue */
+	struct list_head timers;	/* timer cleanup queue */
 
 	struct tasklet_struct tasklet;	/* dpc tasklet */
 	bool resched;		/* dpc needs to be and is rescheduled */
-- 
2.41.0

