Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A616AB1B7
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 19:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCES3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 13:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCES3l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 13:29:41 -0500
X-Greylist: delayed 1721 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Mar 2023 10:29:40 PST
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D86CC11;
        Sun,  5 Mar 2023 10:29:39 -0800 (PST)
Received: from dslb-188-097-214-098.188.097.pools.vodafone-ip.de ([188.97.214.98] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pYsf6-0003fc-Uv; Sun, 05 Mar 2023 19:00:45 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Martin Kaiser <martin@kaiser.cx>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtl8xxxu: mark Edimax EW-7811Un V2 as tested
Date:   Sun,  5 Mar 2023 18:59:32 +0100
Message-Id: <20230305175932.719103-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Edimax V2 (vid 0x7392, pid 0xb811) works well with the rtl8xxxu driver
since rtl8188eu support has been added. Remove the untested flag for this
device.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 620a5cc2bfdd..e619ed21fbfe 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7016,7 +7016,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		}
 		break;
 	case 0x7392:
-		if (id->idProduct == 0x7811 || id->idProduct == 0xa611)
+		if (id->idProduct == 0x7811 || id->idProduct == 0xa611 || id->idProduct == 0xb811)
 			untested = 0;
 		break;
 	case 0x050d:
-- 
2.30.2

