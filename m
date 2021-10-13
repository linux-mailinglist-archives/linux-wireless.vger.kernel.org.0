Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1042C562
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhJMP67 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 11:58:59 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33132 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229653AbhJMP67 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 11:58:59 -0400
X-UUID: 2bd223d179064fceae852238189dfbda-20211013
X-UUID: 2bd223d179064fceae852238189dfbda-20211013
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 157776308; Wed, 13 Oct 2021 23:56:52 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Oct 2021 23:56:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 13 Oct
 2021 23:56:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Oct 2021 23:56:50 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH v2] MAINTAINERS: mt76: update MTK folks
Date:   Wed, 13 Oct 2021 23:56:41 +0800
Message-ID: <eb888ae0e43a980c2c1aaed372a9b5e8098ea4ef.1634107511.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add more MTK folks to actively maintain the wireless chipsets across
segments. The work is becoming increasingly complicated and various
and we can provides hardware related perspectives to offload 
Felix's workload, especially for the 11ax and upcoming 11be devices

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
@Kalle, I explain some more in the commit and hope you can rethink this change.
The name we list here will definitely take responsibility.
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..c2ebcf848205 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11818,7 +11818,9 @@ F:	drivers/mmc/host/mtk-sd.c
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
 M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
-R:	Ryder Lee <ryder.lee@mediatek.com>
+M:	Ryder Lee <ryder.lee@mediatek.com>
+R:	Shayne Chen <shayne.chen@mediatek.com>
+R:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wireless/mediatek/mt76/
-- 
2.29.2

