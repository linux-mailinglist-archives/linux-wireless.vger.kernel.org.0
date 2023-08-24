Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43878673B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Aug 2023 07:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbjHXFyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Aug 2023 01:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbjHXFyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Aug 2023 01:54:14 -0400
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C7C10DD
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 22:54:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:287:0:640:7dd6:0])
        by forward103c.mail.yandex.net (Yandex) with ESMTP id B6CBB60107;
        Thu, 24 Aug 2023 08:54:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3sDNeg0WnqM0-VgsQLmOo;
        Thu, 24 Aug 2023 08:54:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1692856448;
        bh=xoUbqj1D8Su3iquJKrMFs64XhXmtbFkrY6+lI/LR/dI=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=VNVXv6lhqxai90mGB2uor/eEaMx8zErNuMdRprRcWqosVwcRBROgCbOAA/8z3Ul7G
         MGFS0B9Y1ulgo8ijFMvShKvIBCpN8Vtd8nbeM7CL8oph+7+y6uMH0tjlBK3GbjVPRC
         Uf8OIV+GZAZgo3kq83IJenjQ+eoFxOZqrTL/OVxc=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, ath10k@lists.infradead.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 5/6] [v3] wifi: ath10k: simplify ath10k_peer_assoc_h_vht()
Date:   Thu, 24 Aug 2023 08:51:10 +0300
Message-ID: <20230824055117.42309-5-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824055117.42309-1-dmantipov@yandex.ru>
References: <997f4b09-7087-4788-aa2a-ef835ce6ebb3@quicinc.com>
 <20230824055117.42309-1-dmantipov@yandex.ru>
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

Commit 3db24065c2c8 ("ath10k: enable VHT160 and VHT80+80 modes")
introduces 'get_160mhz_nss_from_maxrate()' which never returns 0,
which means that 'ath10k_peer_assoc_h_vht()' may be simplified.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: add Acked-by: otherwise unchanged
v2: adjust to match series
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

