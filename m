Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20601B34BA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 04:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgDVCA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 22:00:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbgDVCA1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 22:00:27 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6582072279BD57595341;
        Wed, 22 Apr 2020 10:00:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Apr 2020 10:00:17 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Erel Geron <erelx.geron@intel.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH net-next] mac80211_hwsim: use GFP_ATOMIC under spin lock
Date:   Wed, 22 Apr 2020 02:01:54 +0000
Message-ID: <20200422020154.112088-1-weiyongjun1@huawei.com>
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

A spin lock is taken here so we should use GFP_ATOMIC.

Fixes: 5d44fe7c9808 ("mac80211_hwsim: add frame transmission support over virtio")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 7c4b7c31d07a..0528d4cb4d37 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4068,7 +4068,7 @@ static void hwsim_virtio_rx_work(struct work_struct *work)
 	}
 	vq = hwsim_vqs[HWSIM_VQ_RX];
 	sg_init_one(sg, skb->head, skb_end_offset(skb));
-	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
+	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_ATOMIC);
 	if (WARN(err, "virtqueue_add_inbuf returned %d\n", err))
 		nlmsg_free(skb);
 	else



