Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F517365C0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjFTIJT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 04:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjFTIJS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 04:09:18 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550DB1
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 01:09:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:31b:0:640:fdf8:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id 973AD46CE6;
        Tue, 20 Jun 2023 11:09:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id v8cEIqsDXeA0-WoxGkl3S;
        Tue, 20 Jun 2023 11:09:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687248548;
        bh=s67ry7Co9MPhktxsgxXhz8/DBce/8Tak4qy6/Iz1lww=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=kxAX+Rqr/AGt/MD7gNJ1MkroAkFWIGHXKLO72eW9HSrVhc5GXoxGgRH3Y371aKMEc
         ivQTKWWLr3tyqtvJzU4JvujcLxb0bVC66EIdSnagmttxy+S1RZPFa8AHpC2MrkFTdP
         Lh+KbQ8OhinTUrWGG2M+aWLSHIBsGz0liVxcdXeA=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] [v2] wifi: ath9k: avoid using uninitialized array
Date:   Tue, 20 Jun 2023 11:08:40 +0300
Message-ID: <20230620080855.396851-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In 'ath_tx_count_frames()', 'ba' array may be used uninitialized, so
add 'memset()' call similar to one used in 'ath_tx_complete_aggr()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index f6f2ab7a63ff..8babaaacacf5 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -466,6 +466,8 @@ static void ath_tx_count_frames(struct ath_softc *sc, struct ath_buf *bf,
 	*nframes = 0;
 
 	isaggr = bf_isaggr(bf);
+	memset(ba, 0, WME_BA_BMP_SIZE >> 3);
+
 	if (isaggr) {
 		seq_st = ts->ts_seqnum;
 		memcpy(ba, &ts->ba_low, WME_BA_BMP_SIZE >> 3);
-- 
2.41.0

