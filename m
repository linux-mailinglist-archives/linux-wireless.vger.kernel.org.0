Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A1C784661
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 17:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbjHVP5B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 11:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbjHVP5A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 11:57:00 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBAFCDF
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 08:56:41 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1d9d:0:640:49d1:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id 2CE2F60089;
        Tue, 22 Aug 2023 18:56:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4uL3vjKWqKo0-czQgZIdE;
        Tue, 22 Aug 2023 18:56:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692719767;
        bh=QopfTMY6oIByo/1txuoicCgv2X2OIIw12H4G6BeLezs=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=gpnW/kTT5ZfRVYVCIcU/aTFAxfQ3GrvoGndLWnQ3TKXmzeHMa6pl2E1jCxjc7X+Do
         uuGGXL46fi6atUuF4bCYu/w1u0rrhyplbD4PYDi4aIVTRnuUbGJXaeioPLVb3AZcdR
         GDY/4MQYK2dP1zPmrke1cfG7YVu7hKKUl9d/z9gs=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] wifi: ath10k: simplify ath10k_peer_assoc_h_vht()
Date:   Tue, 22 Aug 2023 18:54:25 +0300
Message-ID: <20230822155532.95983-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822155532.95983-1-dmantipov@yandex.ru>
References: <20230822155532.95983-1-dmantipov@yandex.ru>
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

Commit 3db24065c2c8 ("ath10k: enable VHT160 and VHT80+80 modes")
introduces 'get_160mhz_nss_from_maxrate()' which never returns 0,
which means that 'ath10k_peer_assoc_h_vht()' may be simplified.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/mac.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 03e7bc5b6c0b..148d0fab4418 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2631,12 +2631,8 @@ static void ath10k_peer_assoc_h_vht(struct ath10k *ar,
 		u32 max_rate;
 
 		max_rate = arg->peer_vht_rates.rx_max_rate;
-		rx_nss = get_160mhz_nss_from_maxrate(max_rate);
-
-		if (rx_nss == 0)
-			rx_nss = arg->peer_num_spatial_streams;
-		else
-			rx_nss = min(arg->peer_num_spatial_streams, rx_nss);
+		rx_nss = min(arg->peer_num_spatial_streams,
+			     get_160mhz_nss_from_maxrate(max_rate));
 
 		max_rate = hw->vht160_mcs_tx_highest;
 		rx_nss = min(rx_nss, get_160mhz_nss_from_maxrate(max_rate));
-- 
2.41.0

