Return-Path: <linux-wireless+bounces-16526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B18C9F5FB1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 08:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE54816748D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE8157472;
	Wed, 18 Dec 2024 07:54:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E945005;
	Wed, 18 Dec 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734508477; cv=none; b=H52ZFUGutpmVo6rT7kZrSuvzil4dnDPszgrkLfwlYrRUWkYylNRTesvDUo2TR2vyvqnxdCYLi2WuMO4q2FKYENg9XRVQ2Xm37sbX1FV4S2hu02PO+/WUgLecAsAQV5k5E1H99ZmAkaT0bAlmAtiui1lGq9YYMlICXTLiLfs9i+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734508477; c=relaxed/simple;
	bh=FoXQxrpSIFNXBbZxJ+eZiuYCc7S6Xa6lWKo+/yrtvLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVk7WSKlwAM2SzNAMjESb0ppG0B072N5HOfxNE0tDsC88lYCpSUghhPxfR8S64N08BBKlqPZtYvla5MndV5vg3ACh5SraUYDHDZQ0WO6zXBeuBs4xSZ6f9LyqsMzWFMOiAN48NQQBgM2jzotwx8sYcXZvIwISeNAQ3nHesb5pV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YCmB02cwVzqVFH;
	Wed, 18 Dec 2024 15:52:40 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 37C10140416;
	Wed, 18 Dec 2024 15:54:26 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Dec
 2024 15:54:25 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <sean.wang@mediatek.com>, <kvalo@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<deren.wu@mediatek.com>, <mingyen.hsieh@mediatek.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<chris.zjh@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH -next] wifi: mt76: mt7925:: replace zero-length array with flexible-array member
Date: Wed, 18 Dec 2024 07:45:52 +0000
Message-ID: <20241218074552.3271542-1-zhangkunbo@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100007.china.huawei.com (7.202.181.92)

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1],
introduced in C99:

struct foo {
	int stuff;
	struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last, which is beneficial
to cultivate a high-quality code.[2]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 748ea6adbc6b..956d62062730 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -388,7 +388,7 @@ mt7925_mcu_tx_done_event(struct mt792x_dev *dev, struct sk_buff *skb)
 	struct mt7925_mcu_txs_event {
 		u8 ver;
 		u8 rsv[3];
-		u8 data[0];
+		u8 data[];
 	} __packed * txs;
 	struct tlv *tlv;
 	u32 tlv_len;
-- 
2.34.1


