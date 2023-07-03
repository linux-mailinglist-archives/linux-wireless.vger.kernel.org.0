Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EBF7460A2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jul 2023 18:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGCQVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jul 2023 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCQVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jul 2023 12:21:54 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F78AD
        for <linux-wireless@vger.kernel.org>; Mon,  3 Jul 2023 09:21:52 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:58f:0:640:3768:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id C09D946CE8;
        Mon,  3 Jul 2023 19:21:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id mLUutK3DZKo0-Y6cmgCXZ;
        Mon, 03 Jul 2023 19:21:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688401309;
        bh=xFlgheiWD4TrQ5F02FnDUsXl+2z4emDHq7Ekku2Efmw=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=j7TbdnSVuhFnOtL91stqnVh04JpuJBX6IOvdeEwy9Zb093dr1tpgyIGWEespE6drv
         CSFqyq2JFiccXW6mi36i1Bx8QwbjGmjMkz0zm1QB0wzAihrFHTDHWy3rHt4FHkcHlP
         bpqyhGawlRl3JDxL7TndWu8N2EcmFWrI0ThZMR88=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Arend van Spriel <aspriel@gmail.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] [v2] wifi: brcmsmac: use generic lists to manage timers
Date:   Mon,  3 Jul 2023 19:21:22 +0300
Message-ID: <20230703162128.154451-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prefer generic lists over ad-hoc quirks to manage
timers, adjust related code.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: add missing list_del() in removal loop within brcms_free()
---
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c | 36 +++++--------------
 .../broadcom/brcm80211/brcmsmac/mac80211_if.h |  4 +--
 2 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 0bd4e679a359..18a06290af1c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -314,8 +314,8 @@ static void brcms_free(struct brcms_info *wl)
 		schedule();
 
 	/* free timers */
-	for (t = wl->timers; t; t = next) {
-		next = t->next;
+	list_for_each_entry_safe(t, next, &wl->timers, list) {
+		list_del(&t->list);
 #ifdef DEBUG
 		kfree(t->name);
 #endif
@@ -1152,6 +1152,8 @@ static struct brcms_info *brcms_attach(struct bcma_device *pdev)
 	spin_lock_init(&wl->lock);
 	spin_lock_init(&wl->isr_lock);
 
+	INIT_LIST_HEAD(&wl->timers);
+
 	/* common load-time initialization */
 	wl->wlc = brcms_c_attach((void *)wl, pdev, unit, false, &err);
 	if (!wl->wlc) {
@@ -1502,8 +1504,7 @@ struct brcms_timer *brcms_init_timer(struct brcms_info *wl,
 	t->wl = wl;
 	t->fn = fn;
 	t->arg = arg;
-	t->next = wl->timers;
-	wl->timers = t;
+	list_add(&t->list, &wl->timers);
 
 #ifdef DEBUG
 	t->name = kstrdup(name, GFP_ATOMIC);
@@ -1561,35 +1562,14 @@ bool brcms_del_timer(struct brcms_timer *t)
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

