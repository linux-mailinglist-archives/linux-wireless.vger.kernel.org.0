Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6A786904
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 09:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjHXHzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbjHXHzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 03:55:00 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A591709
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 00:54:52 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e2b:0:640:94b5:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id BC170600E1;
        Thu, 24 Aug 2023 10:54:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nsFdET9WwmI0-GTj9EgxE;
        Thu, 24 Aug 2023 10:54:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692863690;
        bh=gRxIt5Uc0nHGnrNXrZxMBAiIJgwTs4LCIPesCrXLLdY=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=jAIcYWqMJU2dYQ4uxo6zyyzgGClzws7W3ZNuwpf3h6Fx1gq1csdF28/xsTLg12FEb
         CtYsOhB+k18Vxibb3oUBgxddU1voo/QnlKmf7VQhsRmqo1KnVvG1pCemfik61q9qEi
         fQbU7NYlruEqmgzQEiAJkclTcVnH+P9KvfEbP80g=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath11k@lists.infradead.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/5] wifi: ath11k: drop redundant check in ath11k_dp_rx_mon_dest_process()
Date:   Thu, 24 Aug 2023 10:50:44 +0300
Message-ID: <20230824075121.121144-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'ath11k_dp_rx_mon_dest_process()', 'mon_dst_srng' points to
a member of 'srng_list', which is a fixed-size array inside
'struct ath11k_hal'. This way, if 'ring_id' is valid (i. e.
between 0 and HAL_SRNG_RING_ID_MAX - 1 inclusive), 'mon_dst_srng'
can't be NULL and so relevant check may be dropped.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 1e488eed282b..3f315547878a 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5097,13 +5097,6 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 
 	mon_dst_srng = &ar->ab->hal.srng_list[ring_id];
 
-	if (!mon_dst_srng) {
-		ath11k_warn(ar->ab,
-			    "HAL Monitor Destination Ring Init Failed -- %p",
-			    mon_dst_srng);
-		return;
-	}
-
 	spin_lock_bh(&pmon->mon_lock);
 
 	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
-- 
2.41.0

