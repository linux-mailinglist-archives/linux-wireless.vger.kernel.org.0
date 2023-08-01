Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C99676A81D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 07:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjHAFAN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 01:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHAFAL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 01:00:11 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654051FC0
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 22:00:08 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id CCD7446D44;
        Tue,  1 Aug 2023 08:00:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 40Ji1unDfW20-sjL1kzYh;
        Tue, 01 Aug 2023 08:00:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1690866005;
        bh=GSsKorbx5RHJKMUhD6krP0e+LaWLX/fDEBFkpcT41kY=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=pitjjJdCXYp1+L3VCuu2u/HU1W9x6ovyToYbq4xa8+/L03n0c8W4ILQ8j3wlI1QB5
         AULqhbDgog3K2yjD8S/uWEwu/ow407fXaOVCHvvXUuQ69Bi9vtVMxKrn+qLfoO+d89
         td7OwGiIkJXJA610tq4S9Gd4eiyzA7FN+xhJAU6I=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/4] wifi: mt76: handle possible error returned by sdio_set_host_pm_flags()
Date:   Tue,  1 Aug 2023 07:57:20 +0300
Message-ID: <20230801050000.18864-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'mt7663s_suspend()', drop nested declaration of 'err' and
handle possible error returned by 'sdio_set_host_pm_flags()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index fc547a0031ea..6607577d22cf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -188,14 +188,14 @@ static int mt7663s_suspend(struct device *dev)
 
 	if (!test_bit(MT76_STATE_SUSPEND, &mdev->mphy.state) &&
 	    mt7615_firmware_offload(mdev)) {
-		int err;
-
 		err = mt76_connac_mcu_set_hif_suspend(&mdev->mt76, true);
 		if (err < 0)
 			return err;
 	}
 
-	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
+	err = sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
+	if (err)
+		return err;
 
 	err = mt7615_mcu_set_fw_ctrl(mdev);
 	if (err)
-- 
2.41.0

