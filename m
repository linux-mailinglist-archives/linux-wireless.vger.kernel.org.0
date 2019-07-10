Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2706427D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2019 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfGJHTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jul 2019 03:19:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfGJHTc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jul 2019 03:19:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D199260C42CCD55D419;
        Wed, 10 Jul 2019 15:19:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 10 Jul 2019 15:19:19 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <amitkarwar@gmail.com>, <nishants@marvell.com>,
        <gbhat@marvell.com>, <huxinming820@gmail.com>,
        <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "Mao Wenan" <maowenan@huawei.com>
Subject: [net-next] mwifiex: use eth_broadcast_addr() to assign broadcast address
Date:   Wed, 10 Jul 2019 15:25:24 +0800
Message-ID: <20190710072524.65953-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch is to use eth_broadcast_addr() to assign broadcast address
insetad of memcpy().

Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/net/wireless/marvell/mwifiex/tdls.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
index 18e654d..0931304 100644
--- a/drivers/net/wireless/marvell/mwifiex/tdls.c
+++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
@@ -731,7 +731,6 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 				    u16 status_code, struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt;
-	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	int ret;
 	u16 capab;
 	struct ieee80211_ht_cap *ht_cap;
@@ -765,7 +764,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
 		memmove(pos + ETH_ALEN, &mgmt->u.action.category,
 			sizeof(mgmt->u.action.u.tdls_discover_resp));
 		/* init address 4 */
-		memcpy(pos, bc_addr, ETH_ALEN);
+		eth_broadcast_addr(pos);
 
 		ret = mwifiex_tdls_append_rates_ie(priv, skb);
 		if (ret) {
-- 
2.7.4

