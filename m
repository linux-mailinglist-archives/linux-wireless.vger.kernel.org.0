Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0793D6C1D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 04:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhG0CM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jul 2021 22:12:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7061 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhG0CM3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jul 2021 22:12:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GYh5c5NPJzYcmn;
        Tue, 27 Jul 2021 10:47:00 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 10:52:55 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 27 Jul 2021 10:52:54 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <zajec5@gmail.com>, <kvalo@codeaurora.org>, <hauke@hauke-m.de>,
        <linville@tuxdriver.com>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 2/2] bcma: Drop the unused parameter of bcma_scan_read32()
Date:   Tue, 27 Jul 2021 10:52:32 +0800
Message-ID: <20210727025232.663-3-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20210727025232.663-1-yuzenghui@huawei.com>
References: <20210727025232.663-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As it had never been used since the initial commit 8369ae33b705 ("bcma: add
Broadcom specific AMBA bus driver").

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/bcma/scan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index d49e7c0de2b6..26d12a7e6ca0 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -141,8 +141,7 @@ static const char *bcma_device_name(const struct bcma_device_id *id)
 	return "UNKNOWN";
 }
 
-static u32 bcma_scan_read32(struct bcma_bus *bus, u8 current_coreidx,
-		       u16 offset)
+static u32 bcma_scan_read32(struct bcma_bus *bus, u16 offset)
 {
 	return readl(bus->mmio + offset);
 }
@@ -443,7 +442,7 @@ void bcma_detect_chip(struct bcma_bus *bus)
 
 	bcma_scan_switch_core(bus, BCMA_ADDR_BASE);
 
-	tmp = bcma_scan_read32(bus, 0, BCMA_CC_ID);
+	tmp = bcma_scan_read32(bus, BCMA_CC_ID);
 	chipinfo->id = (tmp & BCMA_CC_ID_ID) >> BCMA_CC_ID_ID_SHIFT;
 	chipinfo->rev = (tmp & BCMA_CC_ID_REV) >> BCMA_CC_ID_REV_SHIFT;
 	chipinfo->pkg = (tmp & BCMA_CC_ID_PKG) >> BCMA_CC_ID_PKG_SHIFT;
@@ -465,7 +464,7 @@ int bcma_bus_scan(struct bcma_bus *bus)
 	if (bus->nr_cores)
 		return 0;
 
-	erombase = bcma_scan_read32(bus, 0, BCMA_CC_EROM);
+	erombase = bcma_scan_read32(bus, BCMA_CC_EROM);
 	if (bus->hosttype == BCMA_HOSTTYPE_SOC) {
 		eromptr = ioremap(erombase, BCMA_CORE_SIZE);
 		if (!eromptr)
-- 
2.19.1

