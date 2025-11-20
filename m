Return-Path: <linux-wireless+bounces-29209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD5C7533F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 914B431BF2
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96936215F;
	Thu, 20 Nov 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHVvjXqQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859D6376BEF
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654317; cv=none; b=dw1FVR4YYHzPIT/EJNi9pgVKYQUSXmHas6Ylor8QYnqaR4j642rYvS4VVeAHiPC8b9z5qZ4MMl8M4TsrloPSEScLmYg1Apy4jDBF2SArrD8GIB6/Pxvn4cBF4+uUXvsJpp2nYs8++AdK37I5jZZpcKbGTk5XQspDmD9bOQFIgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654317; c=relaxed/simple;
	bh=WNuap7absK6lAtucjrajzfMyXhK03+dzT1XbMmcXZ24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l21IZMrgPzSpC9P02jH0oULfkzrsbRMArsid0L2nsxkP6+jwdLUp6cpzcJgSLwZ2xm+M8gU/VaCTy/RogzY3+7jcATMh03qpTxcN3m/kFL7SnbjcboZwKDK0MLz9Ty9lc/DVnjpy4bkLN+/x7T4OCPqSCwV0Qdef6C/ltKZS7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHVvjXqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E00C4AF0E;
	Thu, 20 Nov 2025 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763654316;
	bh=WNuap7absK6lAtucjrajzfMyXhK03+dzT1XbMmcXZ24=;
	h=From:To:Cc:Subject:Date:From;
	b=rHVvjXqQRwxehxusb/zaSyMFzSUvKHvQDdwb97TXCP11xcTnTywmClxRncatwCZz5
	 IQx/dnMRZPI5oMQeFyaQKC4sErxr8F/fJJOswU7oAewjAydFZD8j+WjBZACUd48al8
	 c9Dyp4jaVCYsF4+1Ss3j28kZ/jQFODScapoPl7czs9DwwKcrqaawYtkgv1b5NnAm5u
	 JuoYltiN7T2pZ/0WhZA27e1xKNFd0xw+b8Kh4/ALhZln/UxagFeyzkxzPVEv8w8iel
	 qaEw8AG8nr+KKvooZv/ip58WEY6uKFlA8gp8et+pegWcZiMa8hBtP3rT8Mjb/zl8m7
	 H9xvZo1J5mFCw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: Strip whitespace from build ddate
Date: Thu, 20 Nov 2025 09:58:27 -0600
Message-ID: <20251120155829.3494747-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems I have with mt7925 cards I've been noticing a blank line in my
kernel logs.  IE:
```
[   17.294105] mt7925e 0000:c3:00.0: HW/SW Version: 0x8a108a10, Build Time: 20250721232852a

[   17.314233] r8169 0000:c4:00.0 enp196s0f0: Link is Down
```

This is because the build_date from the header has a newline character
as does the dev_info() print.  As the firmware isn't guaranteed to always
have a newline but the print is, copy the firmware build date to a
temporary variable and strip any whitespace from it before showing it in
the logs.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fc3e6728fcfbf..eeba6deb100c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -3101,6 +3101,7 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 	int i, ret, sem, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
 	const struct mt76_connac2_patch_hdr *hdr;
 	const struct firmware *fw = NULL;
+	char build_date[17];
 
 	sem = mt76_connac_mcu_patch_sem_ctrl(dev, true);
 	switch (sem) {
@@ -3124,8 +3125,11 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 	}
 
 	hdr = (const void *)fw->data;
+	strscpy(build_date, hdr->build_date, sizeof(build_date));
+	build_date[16] = '\0';
+	strim(build_date);
 	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
-		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
+		 be32_to_cpu(hdr->hw_sw_ver), build_date);
 
 	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
 		struct mt76_connac2_patch_sec *sec;
-- 
2.43.0


