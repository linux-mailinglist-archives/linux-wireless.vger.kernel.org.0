Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A880269BBA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Sep 2020 04:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIOCDD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Sep 2020 22:03:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbgIOCDC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Sep 2020 22:03:02 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 13E2EA2A064A615D3F29;
        Tue, 15 Sep 2020 10:03:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 10:02:50 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <m@bues.ch>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] ssb: Remove meaningless jump label to simplify the code
Date:   Tue, 15 Sep 2020 10:03:30 +0800
Message-ID: <20200915020330.96067-1-jingxiangfeng@huawei.com>
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

The out jump label has nothing to do. So remove it to simplify the code.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/ssb/pci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
index 7c3ae52f2b15..dac54041ad8d 100644
--- a/drivers/ssb/pci.c
+++ b/drivers/ssb/pci.c
@@ -1164,17 +1164,12 @@ void ssb_pci_exit(struct ssb_bus *bus)
 int ssb_pci_init(struct ssb_bus *bus)
 {
 	struct pci_dev *pdev;
-	int err;
 
 	if (bus->bustype != SSB_BUSTYPE_PCI)
 		return 0;
 
 	pdev = bus->host_pci;
 	mutex_init(&bus->sprom_mutex);
-	err = device_create_file(&pdev->dev, &dev_attr_ssb_sprom);
-	if (err)
-		goto out;
 
-out:
-	return err;
+	return device_create_file(&pdev->dev, &dev_attr_ssb_sprom);
 }
-- 
2.17.1

