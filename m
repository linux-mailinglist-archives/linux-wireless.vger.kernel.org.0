Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0855B74782D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jul 2023 20:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGDSHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jul 2023 14:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGDSHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jul 2023 14:07:43 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429210C9
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jul 2023 11:07:42 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:4001:0:640:bc2:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 5062F4230E;
        Tue,  4 Jul 2023 21:07:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id d7X30KGDciE0-3V3oOaun;
        Tue, 04 Jul 2023 21:07:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1688494060;
        bh=22mY0QPEck0fiKlwWh2OEii0jnfSb0ptV2wwb92Gw+o=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=pbar2clBj4tbVzM+7O9PCdpm+rhtBLA/6kSZp2Eq5KdRSF5Ws7qWni9stMh4K3Ixc
         RSSupVOTK4PQ92rcdNlnzhfqD+ZVMB8Jct9AS7OrpeWcW9ynIqruzyDzoVKyYfczMS
         dAgMTj+mq1FFZNtwP1tN6VsC/mSeiTm0ub0ZIPZg=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: simplify ath10k_peer_create()
Date:   Tue,  4 Jul 2023 21:06:07 +0300
Message-ID: <20230704180617.84948-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use convenient 'list_count_nodes()' in 'ath10k_peer_create()',
thus making the latter a bit smaller and simpler.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/mac.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 03e7bc5b6c0b..6d14e58b98af 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -728,20 +728,13 @@ static int ath10k_peer_create(struct ath10k *ar,
 			      const u8 *addr,
 			      enum wmi_peer_type peer_type)
 {
-	struct ath10k_vif *arvif;
 	struct ath10k_peer *peer;
-	int num_peers = 0;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	num_peers = ar->num_peers;
-
-	/* Each vdev consumes a peer entry as well */
-	list_for_each_entry(arvif, &ar->arvifs, list)
-		num_peers++;
-
-	if (num_peers >= ar->max_num_peers)
+	/* Each vdev consumes a peer entry as well. */
+	if (ar->num_peers + list_count_nodes(&ar->arvifs) >= ar->max_num_peers)
 		return -ENOBUFS;
 
 	ret = ath10k_wmi_peer_create(ar, vdev_id, addr, peer_type);
-- 
2.41.0

