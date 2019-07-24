Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91CB7282F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 08:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfGXGUi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 02:20:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfGXGUi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 02:20:38 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A1A274D138ECE27611AD;
        Wed, 24 Jul 2019 14:20:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Jul 2019 14:20:29 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <kvalo@codeaurora.org>, <amitkarwar@gmail.com>,
        <nishants@marvell.com>, <gbhat@marvell.com>,
        <huxinming820@gmail.com>
CC:     <linux-wireless@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH wireless-drivers-next v2] mwifiex: use eth_broadcast_addr() to assign broadcast address
Date:   Wed, 24 Jul 2019 14:25:45 +0800
Message-ID: <20190724062545.119041-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <878sso0yzx.fsf@kamboji.qca.qualcomm.com>
References: <878sso0yzx.fsf@kamboji.qca.qualcomm.com>
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
 v1->v2: change subject from net-next to wireless-drivers-next.
 
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

