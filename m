Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A64382673
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhEQIQH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2993 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbhEQIQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:04 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkBfb2VRSzQpTf;
        Mon, 17 May 2021 16:11:19 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:47 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:46 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 08/11] net: realtek: rtlwifi: Fix wrong function name in comments
Date:   Mon, 17 May 2021 13:01:38 +0800
Message-ID: <20210517050141.61488-9-shenyang39@huawei.com>
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

 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c:124: warning: expecting prototype for writeLLT(). Prototype was for rtl92c_llt_write() instead
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c:154: warning: expecting prototype for rtl92c_init_LLT_table(). Prototype was for rtl92c_init_llt_table() instead

Cc: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
index 8d2c6d8d32d9..4ff0d4118193 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
@@ -112,7 +112,7 @@ void rtl92c_read_chip_version(struct ieee80211_hw *hw)
 }
 
 /**
- * writeLLT - LLT table write access
+ * rtl92c_llt_write - LLT table write access
  * @hw: Pointer to the ieee80211_hw structure.
  * @address: LLT logical address.
  * @data: LLT data content
@@ -144,7 +144,7 @@ bool rtl92c_llt_write(struct ieee80211_hw *hw, u32 address, u32 data)
 }
 
 /**
- * rtl92c_init_LLT_table - Init LLT table
+ * rtl92c_init_llt_table - Init LLT table
  * @hw: Pointer to the ieee80211_hw structure.
  * @boundary: Page boundary.
  *
-- 
2.17.1

