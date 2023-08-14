Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118A77B8E0
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjHNMnd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjHNMn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 08:43:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D46E4A
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 05:43:26 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPYs91HfPz2BdQV;
        Mon, 14 Aug 2023 20:40:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 20:43:24 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <kvalo@kernel.org>, <briannorris@chromium.org>,
        <johannes.berg@intel.com>, <Jason@zx2c4.com>, <toke@toke.dk>,
        <tj@kernel.org>, <mukesh.sisodiya@intel.com>,
        <quic_vjakkam@quicinc.com>,
        <johannes.wiesboeck@aisec.fraunhofer.de>,
        <linux-wireless@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH net-next 2/2] wifi: mwifiex: Use helpers to check multicast addresses
Date:   Mon, 14 Aug 2023 20:42:12 +0800
Message-ID: <20230814124212.302738-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814124212.302738-1-ruanjinjie@huawei.com>
References: <20230814124212.302738-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use is_multicast_ether_addr() and is_unicast_ether_addr()
to check the addresses.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/wmm.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index ba4e29713a8c..d8c0f90a86fc 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3356,7 +3356,7 @@ static int mwifiex_set_wowlan_mef_entry(struct mwifiex_private *priv,
 		}
 
 		if (!wowlan->patterns[i].pkt_offset) {
-			if (!(byte_seq[0] & 0x01) &&
+			if (is_unicast_ether_addr(byte_seq) &&
 			    (byte_seq[MWIFIEX_MEF_MAX_BYTESEQ] == 1)) {
 				mef_cfg->criteria |= MWIFIEX_CRITERIA_UNICAST;
 				continue;
diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 00a5679b5c51..8558995e8fc7 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -871,7 +871,7 @@ mwifiex_wmm_add_buf_txqueue(struct mwifiex_private *priv,
 		}
 	} else {
 		memcpy(ra, skb->data, ETH_ALEN);
-		if (ra[0] & 0x01 || mwifiex_is_skb_mgmt_frame(skb))
+		if (is_multicast_ether_addr(ra) || mwifiex_is_skb_mgmt_frame(skb))
 			eth_broadcast_addr(ra);
 		ra_list = mwifiex_wmm_get_queue_raptr(priv, tid_down, ra);
 	}
-- 
2.34.1

