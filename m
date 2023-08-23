Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F978581E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjHWMx6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjHWMx5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 08:53:57 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E66CD2
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 05:53:53 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2d98:0:640:9fb0:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 2F82946C5D;
        Wed, 23 Aug 2023 15:53:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HrJCc32DaKo0-IuEzmA2R;
        Wed, 23 Aug 2023 15:53:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692795198;
        bh=TvS7oPewsHvRj7cHCJ31B6RJrpHBvd2uEQans5lKIuI=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=u8m89gxxSm3eXAyxVyXM9DNOpEHn6rA16+EPyrTjAZXcQs2CEfn+7lI5wHWunQUgg
         s211qb8kI8kB9zsacqnl6AhjIAM6/9LJiLD83AMaoXNtahaOQd5J2FtYNLkxHyCxGN
         ZxE6w6o94NA0We2an1cvtYkMfSE7+paNWMA4Zh/U=
Authentication-Results: mail-nwsmtp-smtp-production-main-18.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: simplify ar9003_hw_process_ini()
Date:   Wed, 23 Aug 2023 15:52:13 +0300
Message-ID: <20230823125217.72483-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
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

