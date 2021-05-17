Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F2382672
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhEQIQG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3715 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhEQIQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:04 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkBgQ5x4vz16QnL;
        Mon, 17 May 2021 16:12:02 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:47 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>
Subject: [PATCH 07/11] net: marvell: libertas_tf: Fix wrong function name in comments
Date:   Mon, 17 May 2021 13:01:37 +0800
Message-ID: <20210517050141.61488-8-shenyang39@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517050141.61488-1-shenyang39@huawei.com>
References: <20210517050141.61488-1-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema704-chm.china.huawei.com (10.3.20.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/marvell/libertas_tf/if_usb.c:56: warning: expecting prototype for if_usb_wrike_bulk_callback(). Prototype was for if_usb_write_bulk_callback() instead

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/net/wireless/marvell/libertas_tf/if_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/if_usb.c b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
index a92916dc81a9..fe0a69e804d8 100644
--- a/drivers/net/wireless/marvell/libertas_tf/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas_tf/if_usb.c
@@ -48,7 +48,7 @@ static int if_usb_submit_rx_urb(struct if_usb_card *cardp);
 static int if_usb_reset_device(struct lbtf_private *priv);

 /**
- *  if_usb_wrike_bulk_callback -  call back to handle URB status
+ *  if_usb_write_bulk_callback -  call back to handle URB status
  *
  *  @urb:		pointer to urb structure
  */
--
2.17.1

