Return-Path: <linux-wireless+bounces-14513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6889AFE18
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B76287624
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811CB1DD54B;
	Fri, 25 Oct 2024 09:21:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BF1DD53F
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848103; cv=none; b=Xn/cVIFGcYSf2hkZoMMiZwAPTny3t0YZvjG2o4ZPU7TCtnYfnthZX6zCtvGl/on/qJrmNk7N4w1g93QlzibNs4RNaCMC6kwJdEg3M0L+cFUZUSSRzbi/Ql2FxIAFJkekFwTFRixBZYkvwX5BD8T4anyThMxmoK7+9HNQTCDVKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848103; c=relaxed/simple;
	bh=n2K0xvqmtKxEeoB3qNg2a8s0jjFV0lDlrRjU7THma7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EwIAWV2gqgIuKU/xikVtQFUHQKNSWBArnejffXy7RI6bsT7e6j6xQi0+9PZ7k41VaSEhVWUsGq3aWgj3Jj8g/f1atyoGz/ZnM4kPW6Y4Uqk3cdxuBx/mafQYrwtme34PQYD+QkAp250MuClD1iLNHDcuGqH8Mve0Dqmgrxiq6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XZcjj4w1pz1ynTL;
	Fri, 25 Oct 2024 17:21:45 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 0707B1402E1;
	Fri, 25 Oct 2024 17:21:38 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Oct
 2024 17:21:37 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>, <ryder.lee@mediatek.com>,
	<shayne.chen@mediatek.com>, <sean.wang@mediatek.com>, <kvalo@kernel.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<linux-wireless@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH] wifi: mt76: mt7925: Fix a potential array out-of-bounds access
Date: Fri, 25 Oct 2024 17:16:47 +0800
Message-ID: <20241025091647.48613-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Fix a potential array-index-out-of bounds access in mt7925_load_clc(),
when the array index equals to the array size.

Fixes: 9679ca7326e5 ("wifi: mt76: mt7925: fix a potential array-index-out-of-bounds issue for clc")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410250608.Ly4Aj2NI-lkp@intel.com/
Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 748ea6adbc6b..0c2a2337c313 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -638,7 +638,7 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	for (offset = 0; offset < len; offset += le32_to_cpu(clc->len)) {
 		clc = (const struct mt7925_clc *)(clc_base + offset);
 
-		if (clc->idx > ARRAY_SIZE(phy->clc))
+		if (clc->idx >= ARRAY_SIZE(phy->clc))
 			break;
 
 		/* do not init buf again if chip reset triggered */
-- 
2.17.1


