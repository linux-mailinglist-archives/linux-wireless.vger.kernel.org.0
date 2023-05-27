Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA85F713701
	for <lists+linux-wireless@lfdr.de>; Sun, 28 May 2023 00:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjE0W3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjE0W3I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 18:29:08 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1021BEC;
        Sat, 27 May 2023 15:29:04 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F1C05846E3;
        Sun, 28 May 2023 00:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685226542;
        bh=wnP21VChaBTxAaPJsoZYssejkrEL9X+Q26Zlv5EAZx0=;
        h=From:To:Cc:Subject:Date:From;
        b=yKYA2QxAd/MUR/OdurN1xNOEJ9qHzJ5mi2kV2JTXs6jMB2QpwfcXUKhbQ6xLw+Oca
         9J6MdTX62lNQ7tJKqrQjHXoLuJ9MfoSoZK9//FG36GnNNPJrErN5VBepwA7vfmlQuo
         FJbMj6cijY38OAT++2GsEYJC02fvZWyURlLzNn0OWqFoDnA7dUjvgiKSxVQRfk1l8P
         tvyIRL0NCCZqDsRWulhKYXD7ZWteoW0HfR73XI45VDvCpdTOj3neq+FXIfTZTfu3EH
         nMML6Un3c23G5tsoQLd+IGwwypQcr9Dh1ogrS1Z7AIu23VOStTrr9+chOYngGPnU8H
         pUxnMz5flADhg==
From:   Marek Vasut <marex@denx.de>
To:     linux-wireless@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Subject: [PATCH] wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
Date:   Sun, 28 May 2023 00:28:59 +0200
Message-Id: <20230527222859.273768-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It makes no sense to set MMC_PM_KEEP_POWER in shutdown. The flag
indicates to the MMC subsystem to keep the slot powered on during
suspend, but in shutdown the slot should actually be powered off.
Drop this call.

Fixes: 063848c3e155 ("rsi: sdio: Add WOWLAN support for S5 shutdown state")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jilin Yuan <yuanjilin@cdjrlc.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 6e33a2563fdbd..1911fef3bbad6 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1479,9 +1479,6 @@ static void rsi_shutdown(struct device *dev)
 	if (sdev->write_fail)
 		rsi_dbg(INFO_ZONE, "###### Device is not ready #######\n");
 
-	if (rsi_set_sdio_pm_caps(adapter))
-		rsi_dbg(INFO_ZONE, "Setting power management caps failed\n");
-
 	rsi_dbg(INFO_ZONE, "***** RSI module shut down *****\n");
 }
 
-- 
2.39.2

