Return-Path: <linux-wireless+bounces-11961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932C95EDCA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D969F284876
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0351146588;
	Mon, 26 Aug 2024 09:56:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E96F145A01;
	Mon, 26 Aug 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666165; cv=none; b=nTqisFI1jyqegiRKvnrHx0eXRSkwvRNivXlKiNnSSHdoS11AmTYeox/xlrAUTFkWaeZPNjp8J/ugNLIy++DY05jjlhyKZ0tqBp6n64lWfIQ1wJHEWo1OiWaJwtdgaPlKvY3mOeWZppSKSzH58wTD15Ht9D+K/pkgpr67oq2T6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666165; c=relaxed/simple;
	bh=wsAv2DCs81Krot2H6B+GkuNI1BslfDtsdnmozEw5rcU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n8sAK9FAKCMpgbN5P5OAfSG1TjQYtVcih0s/UM4FzJU3jceCAYevoOfeItpTVIoRFxvFURUqwZ9oMlEf5wJK712uTh2Eadj/rQ7b/ICAovt/NUDvGfAzFYvKd4JqTBYtDHKQJfl3lq9cxYpGbBDOsI9TboCWGbhT1DcCQt/sGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowACnr0sYUcxmptCfCg--.39812S2;
	Mon, 26 Aug 2024 17:55:46 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mingyen.hsieh@mediatek.com,
	deren.wu@mediatek.com,
	make24@iscas.ac.cn,
	ruanjinjie@huawei.com,
	greearb@candelatech.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7921: Check devm_kasprintf() returned value
Date: Mon, 26 Aug 2024 17:55:35 +0800
Message-Id: <20240826095535.2603538-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnr0sYUcxmptCfCg--.39812S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFW7ZFW5Ww13Zw4xXFWxCrg_yoWDAFbEgr
	409rn7XryrGFn8Kr42yry3CrW2kaykZr18XFsxtrWrJrWxGrWUur93Zrn8J392k397uryU
	urn0kFy8uws8ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiSfO3UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

devm_kasprintf() can return a NULL pointer on failure but this returned
value is not checked. Fix this lack and check the returned value.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 6ae39b7c7ed4 ("wifi: mt76: mt7921: Support temp sensor")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index ef0c721d26e3..5ab395d9d93e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -52,6 +52,8 @@ static int mt7921_thermal_init(struct mt792x_phy *phy)
 
 	name = devm_kasprintf(&wiphy->dev, GFP_KERNEL, "mt7921_%s",
 			      wiphy_name(wiphy));
+	if (!name)
+		return -ENOMEM;
 
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
 						       mt7921_hwmon_groups);
-- 
2.25.1


