Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5E6B1933
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 03:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCIC3y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 21:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIC3x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 21:29:53 -0500
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Mar 2023 18:29:52 PST
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693CE9F06F
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 18:29:51 -0800 (PST)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3292JBih021312-3292JBik021312
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Mar 2023 10:19:16 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: rtw88: fix memory leak in rtw_usb_probe()
Date:   Thu,  9 Mar 2023 10:16:36 +0800
Message-Id: <20230309021636.528601-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

drivers/net/wireless/realtek/rtw88/usb.c:876 rtw_usb_probe()
warn: 'hw' from ieee80211_alloc_hw() not released on lines: 811

Fix this by modifying return to a goto statement.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
v1->v2: modify the commit title
 drivers/net/wireless/realtek/rtw88/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 2a8336b1847a..68e1b782d199 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -808,7 +808,7 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	ret = rtw_usb_alloc_rx_bufs(rtwusb);
 	if (ret)
-		return ret;
+		goto err_release_hw;
 
 	ret = rtw_core_init(rtwdev);
 	if (ret)
-- 
2.39.2

