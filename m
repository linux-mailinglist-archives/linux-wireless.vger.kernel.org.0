Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5364572E48A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbjFMNrR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbjFMNrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 09:47:15 -0400
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BD110DA
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 06:47:14 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e2b:0:640:94b5:0])
        by forward100b.mail.yandex.net (Yandex) with ESMTP id CEBC4600DE;
        Tue, 13 Jun 2023 16:47:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wka7QGsDTW20-aokR6FWz;
        Tue, 13 Jun 2023 16:47:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686664032;
        bh=PUVPnEcSBpXHviFcoMikLWFZsHJISsWRrJCZqe/yfSw=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=tmAl7ygg3o0pw0fyHWwOFGsmL0+Ar+u+fYMqoAhw+2HMWR7tChRh6anttS3KEJC1I
         uksEGL6kCiFo8C/TDfiPk+6t8Kev5xAEYE1dLo13tHB/aDo9b/YJmTVIC8x896/lSu
         zuT2FH5wWIexJSYUyd5Q6XENxpTseod4/H/rh2Ac=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath9k: convert msecs to jiffies where needed
Date:   Tue, 13 Jun 2023 16:46:55 +0300
Message-Id: <20230613134655.248728-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'ieee80211_queue_delayed_work()' expects timeout in
jiffies and not milliseconds, 'msecs_to_jiffies()' should
be used in 'ath_restart_work()' and '__ath9k_flush()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index a4197c14f0a9..8311a45c5ea8 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -203,7 +203,7 @@ void ath_cancel_work(struct ath_softc *sc)
 void ath_restart_work(struct ath_softc *sc)
 {
 	ieee80211_queue_delayed_work(sc->hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 
 	if (AR_SREV_9340(sc->sc_ah) || AR_SREV_9330(sc->sc_ah))
 		ieee80211_queue_delayed_work(sc->hw, &sc->hw_pll_work,
@@ -2239,7 +2239,7 @@ void __ath9k_flush(struct ieee80211_hw *hw, u32 queues, bool drop,
 	}
 
 	ieee80211_queue_delayed_work(hw, &sc->hw_check_work,
-				     ATH_HW_CHECK_POLL_INT);
+				     msecs_to_jiffies(ATH_HW_CHECK_POLL_INT));
 }
 
 static bool ath9k_tx_frames_pending(struct ieee80211_hw *hw)
-- 
2.40.1

