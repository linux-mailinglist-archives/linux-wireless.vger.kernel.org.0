Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C05381694
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 09:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhEOHbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 03:31:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2988 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhEOHbO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 03:31:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FhxnG6MdjzmVnP;
        Sat, 15 May 2021 15:27:46 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 15:29:54 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Michael Buesch <m@bues.ch>,
        "John W . Linville" <linville@tuxdriver.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ssb: Fix error return code in ssb_bus_scan()
Date:   Sat, 15 May 2021 15:29:49 +0800
Message-ID: <20210515072949.7151-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix to return -EINVAL from the error handling case instead of 0, as done
elsewhere in this function.

Fixes: 61e115a56d1a ("[SSB]: add Sonics Silicon Backplane bus support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/ssb/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ssb/scan.c b/drivers/ssb/scan.c
index f49ab1aa2149ab2..4161e5d1f276e11 100644
--- a/drivers/ssb/scan.c
+++ b/drivers/ssb/scan.c
@@ -325,6 +325,7 @@ int ssb_bus_scan(struct ssb_bus *bus,
 	if (bus->nr_devices > ARRAY_SIZE(bus->devices)) {
 		pr_err("More than %d ssb cores found (%d)\n",
 		       SSB_MAX_NR_CORES, bus->nr_devices);
+		err = -EINVAL;
 		goto err_unmap;
 	}
 	if (bus->bustype == SSB_BUSTYPE_SSB) {
-- 
2.26.0.106.g9fadedd


