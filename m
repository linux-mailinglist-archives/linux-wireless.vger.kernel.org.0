Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36A077B8E3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjHNMne (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 08:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjHNMnZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 08:43:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30151E4A
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 05:43:25 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPYt84q9nzTmq9;
        Mon, 14 Aug 2023 20:41:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 20:43:22 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <kvalo@kernel.org>, <briannorris@chromium.org>,
        <johannes.berg@intel.com>, <Jason@zx2c4.com>, <toke@toke.dk>,
        <tj@kernel.org>, <mukesh.sisodiya@intel.com>,
        <quic_vjakkam@quicinc.com>,
        <johannes.wiesboeck@aisec.fraunhofer.de>,
        <linux-wireless@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH net-next 1/2] wifi: ath: Use is_multicast_ether_addr() to check multicast Ether address
Date:   Mon, 14 Aug 2023 20:42:11 +0800
Message-ID: <20230814124212.302738-2-ruanjinjie@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use is_multicast_ether_addr() to perform the Checking.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/wireless/ath/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/key.c b/drivers/net/wireless/ath/key.c
index b7b61d4f02ba..21a93fec284d 100644
--- a/drivers/net/wireless/ath/key.c
+++ b/drivers/net/wireless/ath/key.c
@@ -104,7 +104,7 @@ bool ath_hw_keysetmac(struct ath_common *common, u16 entry, const u8 *mac)
 		 * Not setting this bit allows the hardware to use the key
 		 * for multicast frame decryption.
 		 */
-		if (mac[0] & 0x01)
+		if (is_multicast_ether_addr(mac))
 			unicast_flag = 0;
 
 		macLo = get_unaligned_le32(mac);
-- 
2.34.1

