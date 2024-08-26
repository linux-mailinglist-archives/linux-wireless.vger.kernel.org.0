Return-Path: <linux-wireless+bounces-11963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F295EE09
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 12:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A2E284F43
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F519146585;
	Mon, 26 Aug 2024 10:06:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCC804;
	Mon, 26 Aug 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666811; cv=none; b=XZXC0sMiyf1TtWKv8GMyipKvdmcz55d5DekOED2QlFtYin6Rl2nLQe/AWC0kEzD4Vaomx3eh57leuNwNDUdTAWJ7ruOv6CunWvZwqt4sS5cBCEgGuJ3dsYDtpPqKkZc1uSDOmDAhxkIw3ZWBb6xMJhqm4un85pDASq5YGIR807w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666811; c=relaxed/simple;
	bh=c7iGIBmPQ0+X5ed9jb4ofzKU/5N8V6B+VMyfLL4JSoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oJQPqSTYf0hi7p3gHOZ1v6Vab5zZ8bY1luIaXepMc+yJ5WtnIaf01gQUpwpy1VBKktdvBhQfTU7Ield1Dg/RYUnOacVbgDJs40uSPhmB3L938GW9WtMtZs/0zl4NOcU73tZvHVlvTkjCJ1/nMQ75WMSdwjXH6wh4VUbSaf1tHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAC3v0ubU8xmAXKgCg--.13784S2;
	Mon, 26 Aug 2024 18:06:32 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	allen.ye@mediatek.com,
	johannes.berg@intel.com,
	chui-hao.chiu@mediatek.com,
	ruanjinjie@huawei.com,
	make24@iscas.ac.cn,
	howard-yh.hsu@mediatek.com,
	greearb@candelatech.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] mt76: mt7915: check devm_kasprintf() returned value
Date: Mon, 26 Aug 2024 18:06:18 +0800
Message-Id: <20240826100618.2605161-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3v0ubU8xmAXKgCg--.13784S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW7ZFW5Ww13Zw4xXFWxCrg_yoWDAFbEgr
	W8Zrn3GFyrGwn0kr47Cry3Cryaya4kZF1kJ393trW5GrW8AFW7WryfZrn8J397Cws29r15
	Gwn8AryrZ398ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRH7K3UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

devm_kasprintf() can return a NULL pointer on failure but this returned
value is not checked. Fix this lack and check the returned value.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 6ae39b7c7ed4 ("wifi: mt76: mt7921: Support temp sensor")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index a978f434dc5e..7bc3b4cd3592 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -194,6 +194,8 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7915_%s",
 			      wiphy_name(wiphy));
+	if (!name)
+		return -ENOMEM;
 
 	cdev = thermal_cooling_device_register(name, phy, &mt7915_thermal_ops);
 	if (!IS_ERR(cdev)) {
-- 
2.25.1


