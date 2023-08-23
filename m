Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D866E785F81
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbjHWSYi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 14:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHWSYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 14:24:38 -0400
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13B4CC7
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 11:24:31 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:790e:0:640:fcb1:0])
        by forward101b.mail.yandex.net (Yandex) with ESMTP id BECD860076;
        Wed, 23 Aug 2023 21:24:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ROPbM94DYCg0-Hj7JIhgF;
        Wed, 23 Aug 2023 21:24:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692815068;
        bh=TvS7oPewsHvRj7cHCJ31B6RJrpHBvd2uEQans5lKIuI=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=bGq3q9lhkUrGXPSjmYitT+MXPenxP/IponbNEFEKNSk7dMzv7r/XRV7uNAxD7c/dH
         BUaksTcCeHz61Wfus32Qg0Uz9nJARriV8dVRq3cBOClZFqgDcfeZxozNQdF5GJ09Ml
         Q8a9zIKt+WtsDM26uiYUvvvvpF3zc8NOmuZF1Llc=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: ath9k: simplify ar9003_hw_process_ini()
Date:   Wed, 23 Aug 2023 21:23:33 +0300
Message-ID: <20230823182401.196270-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <574813ed-b9aa-458f-9758-29662eb60689@quicinc.com>
References: <574813ed-b9aa-458f-9758-29662eb60689@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since commit 8896934c1684 ("ath9k_hw: remove direct accesses to channel
mode flags") changes 'ar9550_hw_get_modes_txgain_index()' so it never
returns -EINVAL, and 'ar9561_hw_get_modes_txgain_index()' never returns
negative value too, an extra check in 'ar9003_hw_process_ini()' may be
dropped.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/ar9003_phy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_phy.c b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
index a29c11f944a5..4731e6618209 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_phy.c
+++ b/drivers/net/wireless/ath/ath9k/ar9003_phy.c
@@ -925,9 +925,6 @@ static int ar9003_hw_process_ini(struct ath_hw *ah,
 			modes_txgain_index =
 				ar9561_hw_get_modes_txgain_index(ah, chan);
 
-		if (modes_txgain_index < 0)
-			return -EINVAL;
-
 		REG_WRITE_ARRAY(&ah->iniModesTxGain, modes_txgain_index,
 				regWrites);
 	} else {
-- 
2.41.0

