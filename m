Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D43215009E
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 04:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBCCxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Feb 2020 21:53:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbgBCCxl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Feb 2020 21:53:41 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB685D8930ABEAA66619;
        Mon,  3 Feb 2020 10:53:37 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 3 Feb 2020 10:53:27 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chin-Yen Lee <timlee@realtek.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] rtw88: use kfree_skb() instead of kfree()
Date:   Mon, 3 Feb 2020 02:48:01 +0000
Message-ID: <20200203024801.177044-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use kfree_skb() instead of kfree() to free sk_buff.

Fixes: b6c12908a33e ("rtw88: Add wowlan net-detect support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 243441453ead..5bdfc70c4529 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -745,7 +745,7 @@ static struct sk_buff *rtw_nlo_info_get(struct ieee80211_hw *hw)
 		loc  = rtw_get_rsvd_page_probe_req_location(rtwdev, ssid);
 		if (!loc) {
 			rtw_err(rtwdev, "failed to get probe req rsvd loc\n");
-			kfree(skb);
+			kfree_skb(skb);
 			return NULL;
 		}
 		nlo_hdr->location[i] = loc;



