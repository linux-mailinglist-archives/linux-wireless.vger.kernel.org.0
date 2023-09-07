Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3B797486
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjIGPjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjIGPXj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:39 -0400
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C56CF
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 08:23:28 -0700 (PDT)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
        by forward201b.mail.yandex.net (Yandex) with ESMTP id 8AAB34D93D
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 11:40:01 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:440b:0:640:fa3a:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id 49EDF600F1;
        Thu,  7 Sep 2023 11:39:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xcUAm5CDg0U0-FaGNTqKz;
        Thu, 07 Sep 2023 11:39:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1694075940; bh=9FbNb2hLEj+l+n3nB2/nkJfvnnk4vB2t5rmfg+pfk6A=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=k6xHiEX5h6bpjINRmBzThT6OJ828aE4kgDuAm1lz4Ow29UEZT82ei8lDX/mARY1lS
         huw4YYovRAeaWm0lZjghFGeZhRshS9sxoQReigP1ixPRpOb13y+D1ixqvnAlGicpnX
         MigZ4fSKidTOXQ183PpikA8Y+WFFo+JY8UdS0tkg=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath11k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath11k: drop NULL pointer check in ath11k_dp_rx_mon_dest_process()
Date:   Thu,  7 Sep 2023 11:38:38 +0300
Message-ID: <20230907083852.10775-1-dmantipov@yandex.ru>
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

Since 'srng_list' is a fixed-size array of 'struct hal_srng'
in 'struct ath11_hal', any of its member can't be NULL and
so relevant check may be dropped.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 146201d8dba2..4463e308968c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5094,13 +5094,6 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
 
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

