Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF07AC6E8
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Sep 2023 09:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjIXHFe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Sep 2023 03:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXHFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Sep 2023 03:05:33 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Sep 2023 00:05:27 PDT
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98B5AFA
        for <linux-wireless@vger.kernel.org>; Sun, 24 Sep 2023 00:05:27 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id kJ3wqxINJLxWbkJ3zqOyHM; Sun, 24 Sep 2023 08:57:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695538676;
        bh=PSnDJBNGC1tP4164Wnhkgh8HavtiyRUWc4qNKuLAPY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HLMnRd41/RUlgoc93i1SIhYkHq4NIqC574gjkWB0wtvQ55rvb2zCtXdUMPKd0zAGr
         a4laNmOjx1eAun7nxTaLBZ678kfZtjMV29BjIoT2jUFKy8m82k22xZ7gQuelOTfDQa
         8zwsYXndljlF4XHMVhTjzATM11djyI9GlEXFmTqv9pTdtnEMHBpYn0boBcOIEkh5KZ
         k4p1NNnKDF8NQzMDYPrFBH3H6qhyyhLccHjViohypu5My4lSTlr0aObzdWbkSJ4RZ0
         pDHyfWfsU1vTWFQx4kYZcbysaMC9r2KOWYB9JOZQbL5NLVoADv1Pq7bLPWTPAC9BHO
         LeTyhIKgQjDRw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Sep 2023 08:57:56 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 2/2] ath: dfs_pattern_detector: Use flex array to simplify code
Date:   Sun, 24 Sep 2023 08:57:50 +0200
Message-Id: <1920cc38db2e570633e13b37d50852f3202a7270.1695538105.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
References: <ad8c55b97ee4b330cb053ce2c448123c309cc91c.1695538105.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

At the time of the writing, the value of 'num_radar_types' is 7 or 9. So
on a 64 bits system, only 56 or 72 bytes are allocated for the
'detectors' array.

Turn it into a flex array, in order to simplify memory management and save
an indirection when the array is used.

Doing so, cd->detectors can't be NULL, and channel_detector_exit() can be
simplified as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Patch #1/2 is a fix, for for wireless.
Patch #2/2 is for wireless-next I guess, but depnds on #1

Not sure if we can mix different target in the same serie. Let me know.
---
 .../net/wireless/ath/dfs_pattern_detector.c   | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/dfs_pattern_detector.c b/drivers/net/wireless/ath/dfs_pattern_detector.c
index 2788a1b06c17..700da9f4531e 100644
--- a/drivers/net/wireless/ath/dfs_pattern_detector.c
+++ b/drivers/net/wireless/ath/dfs_pattern_detector.c
@@ -161,7 +161,7 @@ get_dfs_domain_radar_types(enum nl80211_dfs_regions region)
 struct channel_detector {
 	struct list_head head;
 	u16 freq;
-	struct pri_detector **detectors;
+	struct pri_detector *detectors[];
 };
 
 /* channel_detector_reset() - reset detector lines for a given channel */
@@ -183,14 +183,13 @@ static void channel_detector_exit(struct dfs_pattern_detector *dpd,
 	if (cd == NULL)
 		return;
 	list_del(&cd->head);
-	if (cd->detectors) {
-		for (i = 0; i < dpd->num_radar_types; i++) {
-			struct pri_detector *de = cd->detectors[i];
-			if (de != NULL)
-				de->exit(de);
-		}
+
+	for (i = 0; i < dpd->num_radar_types; i++) {
+		struct pri_detector *de = cd->detectors[i];
+		if (de != NULL)
+			de->exit(de);
 	}
-	kfree(cd->detectors);
+
 	kfree(cd);
 }
 
@@ -200,16 +199,12 @@ channel_detector_create(struct dfs_pattern_detector *dpd, u16 freq)
 	u32 i;
 	struct channel_detector *cd;
 
-	cd = kmalloc(sizeof(*cd), GFP_ATOMIC);
+	cd = kzalloc(struct_size(cd, detectors, dpd->num_radar_types), GFP_ATOMIC);
 	if (cd == NULL)
 		goto fail;
 
 	INIT_LIST_HEAD(&cd->head);
 	cd->freq = freq;
-	cd->detectors = kcalloc(dpd->num_radar_types,
-				      sizeof(*cd->detectors), GFP_ATOMIC);
-	if (cd->detectors == NULL)
-		goto fail;
 
 	for (i = 0; i < dpd->num_radar_types; i++) {
 		const struct radar_detector_specs *rs = &dpd->radar_spec[i];
-- 
2.34.1

