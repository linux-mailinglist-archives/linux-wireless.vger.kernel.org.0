Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F751785F80
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjHWSYj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbjHWSYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 14:24:38 -0400
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF743CE6
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 11:24:34 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:790e:0:640:fcb1:0])
        by forward100c.mail.yandex.net (Yandex) with ESMTP id 3AD296006A;
        Wed, 23 Aug 2023 21:24:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ROPbM94DYCg0-N3uGUmJR;
        Wed, 23 Aug 2023 21:24:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692815070;
        bh=WqK+ZXtMSoDEe5DZJSYCZVwD7vC/XhwLm31MSa6iSCw=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=KpIyJg9TbyabKfifUf9s8o/Qn8Fy0zJVsvu+IXkoLNRAxrbC1x0c1XKMZmHd+O8b9
         lheQXougiM0p3yOg0BEipTAQNHvrRhRJl657KpTeWjWCeGLD9bZjLpYeb5+qBpwqFx
         Axwi870ZYe8PHkDP/3Mbsjrx7qSx7oZKuRn6DALM=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: ath9k: use u32 for txgain indexes
Date:   Wed, 23 Aug 2023 21:23:34 +0300
Message-ID: <20230823182401.196270-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823182401.196270-1-dmantipov@yandex.ru>
References: <574813ed-b9aa-458f-9758-29662eb60689@quicinc.com>
 <20230823182401.196270-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since both 'ar9550_hw_get_modes_txgain_index()' and
'ar9561_hw_get_modes_txgain_index()' never returns
negative values, prefer 'u32' over 'int' and adjust
'ar9003_hw_process_ini()' accordingly.

Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/ar9003_phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
index 4731e6618209..6274d1624261 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -766,10 +766,10 @@ static void ar9003_hw_prog_ini(struct ath_hw *ah,
 	}
 }
 
-static int ar9550_hw_get_modes_txgain_index(struct ath_hw *ah,
+static u32 ar9550_hw_get_modes_txgain_index(struct ath_hw *ah,
 					    struct ath9k_channel *chan)
 {
-	int ret;
+	u32 ret;
 
 	if (IS_CHAN_2GHZ(chan)) {
 		if (IS_CHAN_HT40(chan))
@@ -791,7 +791,7 @@ static int ar9550_hw_get_modes_txgain_index(struct ath_hw *ah,
 	return ret;
 }
 
-static int ar9561_hw_get_modes_txgain_index(struct ath_hw *ah,
+static u32 ar9561_hw_get_modes_txgain_index(struct ath_hw *ah,
 					    struct ath9k_channel *chan)
 {
 	if (IS_CHAN_2GHZ(chan)) {
@@ -916,7 +916,7 @@ static int ar9003_hw_process_ini(struct ath_hw *ah,
 	 * TXGAIN initvals.
 	 */
 	if (AR_SREV_9550(ah) || AR_SREV_9531(ah) || AR_SREV_9561(ah)) {
-		int modes_txgain_index = 1;
+		u32 modes_txgain_index = 1;
 
 		if (AR_SREV_9550(ah))
 			modes_txgain_index = ar9550_hw_get_modes_txgain_index(ah, chan);
-- 
2.41.0

