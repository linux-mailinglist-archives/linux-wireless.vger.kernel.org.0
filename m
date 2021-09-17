Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C440240F4BA
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 11:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbhIQJ07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 05:26:59 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53666
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245571AbhIQJXN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 05:23:13 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA6CC402D8
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870510;
        bh=8kRdq1h/rOcp7tDUe+pfYyXLAzVzwB4YRYsXoc7emlw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ocm0CEQtD72JeY9Gz2auIp6JaeNizCb2LGMJdduwOVpyIsnfffZE68vocQDf9gWDd
         P8Ds26h2Ylo5dZfbs3TIH6TxiNsxPX5VFFLLE1MhGtilIfaGHcRS1uIA/s4Q1mabUq
         GKCXIDAlRuVDPqHHiG5AGpqwF9envdm+xKj6HvcpUFjrUXfrUX29KrxJnMwhwLYPB5
         OFCvrg2gmkRXlqF013LBoVgl/p76Dmd/66LtC4JcKuBEMWDXquOfWzeR89jgofiDsn
         /SvH21VHDYKF1IoS00DhglxAbd+PEjMmUWaC5NXmm11cQjRDP+Ra6hRRUvUdiJsLME
         IXsjuvodBWPSA==
Received: by mail-wr1-f69.google.com with SMTP id q14-20020a5d574e000000b00157b0978ddeso3482362wrw.5
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 02:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kRdq1h/rOcp7tDUe+pfYyXLAzVzwB4YRYsXoc7emlw=;
        b=RmkD1KcHgUyTLTwWSjTrO1VZjQVMqErjJrOixl4nMtXG7TOYQiD2e04gqpm1W1Q3Vy
         cEMEOJywHINzRDGZHlPMUhP4Xw7G4fw1YHwgUBhPriz/iZsOr34uPjLntZLTO8t+4lHQ
         4eO4RSr4A0VnaqDvd9vGQl3j1IXeNgvn6XhohiuxLE6rfDtmj1sSVKb3Hq4kcA1Qo8lI
         6tL7p+O/oV+IfJEzb0XoxzEiL2RImvuKneOsm6ujxBFJOX9ElUjMsEdNk9TqQ8NRCAsY
         KHS3PX6o2dauAtAROSSlu8j/+DME4gYBF7x8+Lq9Dhkkv4WNY7BHlOaITPI3ZD2r29dC
         Kq/A==
X-Gm-Message-State: AOAM5306eFi9ngKDAwRPy+reegZfXxJkT0Ikpn2OJNYGhvWRKlucLYVQ
        O0o+dp7KrK0G79CfmReRsweKxS7z+wgePUhf2gx/c6V5zLtlKi8SloOg9jSjYIvZTMsScFgecoj
        al69wqZej7vvoHZwcNNT1qf8HOTxDvrOiifIPDV9C6MA0
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr9069043wma.183.1631870510135;
        Fri, 17 Sep 2021 02:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHa4EHrl3+qnJ9pDMOBd42Fw6stTQhTc5YNaXUo3xg5W4hvB+dYpYzD3TTfy1so3q3hGtBuw==
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr9068979wma.183.1631870509293;
        Fri, 17 Sep 2021 02:21:49 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm5921163wmi.0.2021.09.17.02.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:21:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Pontus Fuchs <pontus.fuchs@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zd1211-devs@lists.sourceforge.net
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] ar5512: remove duplicate USB device ID
Date:   Fri, 17 Sep 2021 11:21:07 +0200
Message-Id: <20210917092108.19497-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917092108.19497-1-krzysztof.kozlowski@canonical.com>
References: <20210917092108.19497-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The device 0x157e,0x3006 is already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 49cc4b7ed516..0e9bad33fac8 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1772,9 +1772,8 @@ static const struct usb_device_id ar5523_id_table[] = {
 	AR5523_DEVICE_UG(0x0846, 0x5f00),	/* Netgear / WPN111 */
 	AR5523_DEVICE_UG(0x083a, 0x4506),	/* SMC / EZ Connect
 						   SMCWUSBT-G2 */
-	AR5523_DEVICE_UG(0x157e, 0x3006),	/* Umedia / AR5523_1 */
+	AR5523_DEVICE_UG(0x157e, 0x3006),	/* Umedia / AR5523_1, TEW444UBEU*/
 	AR5523_DEVICE_UX(0x157e, 0x3205),	/* Umedia / AR5523_2 */
-	AR5523_DEVICE_UG(0x157e, 0x3006),	/* Umedia / TEW444UBEU */
 	AR5523_DEVICE_UG(0x1435, 0x0826),	/* Wistronneweb / AR5523_1 */
 	AR5523_DEVICE_UX(0x1435, 0x0828),	/* Wistronneweb / AR5523_2 */
 	AR5523_DEVICE_UG(0x0cde, 0x0012),	/* Zcom / AR5523 */
-- 
2.30.2

