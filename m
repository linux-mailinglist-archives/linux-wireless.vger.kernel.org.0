Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831BBC47D2
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfJBGfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57711 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfJBGfp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:45 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZeEc013072, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZeEc013072
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:40 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:39 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 08/14] rtw88: fix beaconing mode rsvd_page memory violation issue
Date:   Wed, 2 Oct 2019 14:35:25 +0800
Message-ID: <20191002063531.18135-9-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

When downloading the reserved page, the first page always contains
a beacon for the firmware to reference. For non-beaconing modes such
as station mode, also put a blank skb with length=1.

And for the beaconing modes, driver will get a real beacon with a
length approximate to the page size. But as the beacon is always put
at the first page, it does not need a tx_desc, because the TX path
will generate one when TXing the reserved page to the hardware. So we
could allocate a buffer with a size smaller than the reserved page,
when using memcpy() to copy the content of reserved page to the buffer,
the over-sized reserved page will violate the kernel memory.

To fix it, add the tx_desc before memcpy() the reserved packets to
the buffer, then we can get SKBs with correct length when counting
the pages in total. And for page 0, count the extra tx_desc_sz that
the TX path will generate. This way, the first beacon that allocated
without tx_desc can be counted with the extra tx_desc_sz to get
actual pages it requires.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 52 ++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 51649df7cc98..65594393dd1e 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -672,9 +672,6 @@ static void rtw_rsvd_page_list_to_buf(struct rtw_dev *rtwdev, u8 page_size,
 {
 	struct sk_buff *skb = rsvd_pkt->skb;
 
-	if (rsvd_pkt->add_txdesc)
-		rtw_fill_rsvd_page_desc(rtwdev, skb);
-
 	if (page >= 1)
 		memcpy(buf + page_margin + page_size * (page - 1),
 		       skb->data, skb->len);
@@ -799,16 +796,37 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
 		iter = rtw_get_rsvd_page_skb(hw, vif, rsvd_pkt->type);
 		if (!iter) {
-			rtw_err(rtwdev, "fail to build rsvd packet\n");
+			rtw_err(rtwdev, "failed to build rsvd packet\n");
 			goto release_skb;
 		}
+
+		/* Fill the tx_desc for the rsvd pkt that requires one.
+		 * And iter->len will be added with size of tx_desc_sz.
+		 */
+		if (rsvd_pkt->add_txdesc)
+			rtw_fill_rsvd_page_desc(rtwdev, iter);
+
 		rsvd_pkt->skb = iter;
 		rsvd_pkt->page = total_page;
-		if (rsvd_pkt->add_txdesc)
+
+		/* Reserved page is downloaded via TX path, and TX path will
+		 * generate a tx_desc at the header to describe length of
+		 * the buffer. If we are not counting page numbers with the
+		 * size of tx_desc added at the first rsvd_pkt (usually a
+		 * beacon, firmware default refer to the first page as the
+		 * content of beacon), we could generate a buffer which size
+		 * is smaller than the actual size of the whole rsvd_page
+		 */
+		if (total_page == 0) {
+			if (rsvd_pkt->type != RSVD_BEACON) {
+				rtw_err(rtwdev, "first page should be a beacon\n");
+				goto release_skb;
+			}
 			total_page += rtw_len_to_page(iter->len + tx_desc_sz,
 						      page_size);
-		else
+		} else {
 			total_page += rtw_len_to_page(iter->len, page_size);
+		}
 	}
 
 	if (total_page > rtwdev->fifo.rsvd_drv_pg_num) {
@@ -821,13 +839,24 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev,
 	if (!buf)
 		goto release_skb;
 
+	/* Copy the content of each rsvd_pkt to the buf, and they should
+	 * be aligned to the pages.
+	 *
+	 * Note that the first rsvd_pkt is a beacon no matter what vif->type.
+	 * And that rsvd_pkt does not require tx_desc because when it goes
+	 * through TX path, the TX path will generate one for it.
+	 */
 	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list) {
 		rtw_rsvd_page_list_to_buf(rtwdev, page_size, page_margin,
 					  page, buf, rsvd_pkt);
-		page += rtw_len_to_page(rsvd_pkt->skb->len, page_size);
-	}
-	list_for_each_entry(rsvd_pkt, &rtwdev->rsvd_page_list, list)
+		if (page == 0)
+			page += rtw_len_to_page(rsvd_pkt->skb->len +
+						tx_desc_sz, page_size);
+		else
+			page += rtw_len_to_page(rsvd_pkt->skb->len, page_size);
+
 		kfree_skb(rsvd_pkt->skb);
+	}
 
 	return buf;
 
@@ -880,6 +909,11 @@ int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
 		goto free;
 	}
 
+	/* The last thing is to download the *ONLY* beacon again, because
+	 * the previous tx_desc is to describe the total rsvd page. Download
+	 * the beacon again to replace the TX desc header, and we will get
+	 * a correct tx_desc for the beacon in the rsvd page.
+	 */
 	ret = rtw_download_beacon(rtwdev, vif);
 	if (ret) {
 		rtw_err(rtwdev, "failed to download beacon\n");
-- 
2.17.1

