Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE248127802
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 10:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLTJWg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 04:22:36 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47445 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfLTJWf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 04:22:35 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBK9MSXZ025738, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBK9MSXZ025738
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Dec 2019 17:22:28 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Dec 2019 17:22:28 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 10/11] rtw88: assign NULL to skb after being kfree()'ed
Date:   Fri, 20 Dec 2019 17:21:55 +0800
Message-ID: <20191220092156.13443-11-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220092156.13443-1-yhchuang@realtek.com>
References: <20191220092156.13443-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Should assign NULL to skb after kfree(), in case of driver
trying to free the same skb again.

This could happen if driver failed to allocate an skb when
building reserved page.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index b8c581161f61..92cefb79e09b 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -857,13 +857,16 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 			page += rtw_len_to_page(rsvd_pkt->skb->len, page_size);
 
 		kfree_skb(rsvd_pkt->skb);
+		rsvd_pkt->skb = NULL;
 	}
 
 	return buf;
 
 release_skb:
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list)
+	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
 		kfree_skb(rsvd_pkt->skb);
+		rsvd_pkt->skb = NULL;
+	}
 
 	return NULL;
 }
-- 
2.17.1

