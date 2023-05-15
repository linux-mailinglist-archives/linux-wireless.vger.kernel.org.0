Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A489A702824
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 11:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbjEOJTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbjEOJTG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 05:19:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131F2272D;
        Mon, 15 May 2023 02:14:00 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QKYTx1CBjzqSV0;
        Mon, 15 May 2023 17:09:41 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 17:13:58 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <johannes@sipsolutions.net>, <kvalo@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <jaewan@google.com>, <steen.hegelund@microchip.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>,
        <syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com>
Subject: [PATCH net-next,v2] mac80211_hwsim: fix memory leak in hwsim_new_radio_nl
Date:   Mon, 15 May 2023 17:22:27 +0800
Message-ID: <20230515092227.2691437-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When parse_pmsr_capa failed in hwsim_new_radio_nl, the memory resources
applied for by pmsr_capa are not released. Add release processing to the
incorrect path.

Fixes: 92d13386ec55 ("mac80211_hwsim: add PMSR capability support")
Reported-by: syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
v2: move the value assigned to pmsr_capa before parse_pmsr_capa
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9a8faaf4c6b6..89c7a1420381 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5964,10 +5964,11 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 			ret = -ENOMEM;
 			goto out_free;
 		}
+		param.pmsr_capa = pmsr_capa;
+
 		ret = parse_pmsr_capa(info->attrs[HWSIM_ATTR_PMSR_SUPPORT], pmsr_capa, info);
 		if (ret)
 			goto out_free;
-		param.pmsr_capa = pmsr_capa;
 	}
 
 	ret = mac80211_hwsim_new_radio(info, &param);
-- 
2.34.1

