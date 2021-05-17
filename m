Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D045382670
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhEQIQF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3004 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhEQIQD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:03 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkBgz3d38zmW8n;
        Mon, 17 May 2021 16:12:31 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:45 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Nick Kossifidis" <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 01/11] net: ath: ath5k: Fix wrong function name in comments
Date:   Mon, 17 May 2021 13:01:31 +0800
Message-ID: <20210517050141.61488-2-shenyang39@huawei.com>
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

 drivers/net/wireless/ath/ath5k/pcu.c:865: warning: expecting prototype for at5k_hw_stop_rx_pcu(). Prototype was for ath5k_hw_stop_rx_pcu() instead

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/net/wireless/ath/ath5k/pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/pcu.c b/drivers/net/wireless/ath/ath5k/pcu.c
index f2db7cf16566..3f4ce4e9c532 100644
--- a/drivers/net/wireless/ath/ath5k/pcu.c
+++ b/drivers/net/wireless/ath/ath5k/pcu.c
@@ -855,7 +855,7 @@ ath5k_hw_start_rx_pcu(struct ath5k_hw *ah)
 }

 /**
- * at5k_hw_stop_rx_pcu() - Stop RX engine
+ * ath5k_hw_stop_rx_pcu() - Stop RX engine
  * @ah: The &struct ath5k_hw
  *
  * Stops RX engine on PCU
--
2.17.1

