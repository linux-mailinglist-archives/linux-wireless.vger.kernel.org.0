Return-Path: <linux-wireless+bounces-22555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A5AAA8F1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA7C188483E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472792777FC;
	Mon,  5 May 2025 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCdxXisJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B402BD03D;
	Mon,  5 May 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484896; cv=none; b=W4D/HdX53Ybd4AiEud3HYSFeaNAxAukOfw9MhkwKOR0PU1Q9XU41MZGdlvnexUxIV92i3aNjU98fs9nzIoYfE05t19R41cjO4yYu8jHoL31fobo9mmQFEZMLwdj0VbL/QQUJ//LFoCT/FSFo+pzzLOotr2oH8dK7sVWR9hX9b1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484896; c=relaxed/simple;
	bh=MsfzYwsNlKmyBj46lG/HudGhcLZp4s/BlfAOyrpQhEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuYV+Qj/wNsw2OjAcFMALK0MSdDZmKoNkdM3ZT/uEGS3tzxNd0VnpML7TVlb4ily47vZMXpVWFnxjw79HUFutM0oiBRIpIuPRoTiCrQecnSH7l1lI1fp3AuWKsfLY0Wxl61+4ymRFeApMn4ms/aG34+NSbzkjD7MZHemf9DbhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCdxXisJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092FEC4CEE4;
	Mon,  5 May 2025 22:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484894;
	bh=MsfzYwsNlKmyBj46lG/HudGhcLZp4s/BlfAOyrpQhEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCdxXisJ7g9BOxvsZb9TevcHtyKxtxoA8xyhrZ/NIHN41sfE7gGGkW7aM1pZHkSz1
	 Ove8aHZRKhRwBt8kgxgNPQXm/Fc7zGkV4Yk5/w6m9jtCmSpdQzs1Ya0d47uFhymQ95
	 74WALpJp9NLSUuTBrUAgyBesQHANnat6mlJuCbau2pF8d0nZyi70ZdxTrMn4h4ZChI
	 8zoTJk1cOWJGt3fqoQzb3UcX3ZyyUnl2aLfRCUIE7ULCtaNjv7HwhUnXxmHqK6HSre
	 9PU5XA8hO2Mzpz3WsmvzLfAi8hSZf/qb+x4K5HDhkHpsQ/KMp/AC5f6CV7HSPb9tPn
	 9825V66p3Fhdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quan Zhou <quan.zhou@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	sean.wang@mediatek.com,
	mingyen.hsieh@mediatek.com,
	deren.wu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 064/486] wifi: mt76: mt7925: fix fails to enter low power mode in suspend state
Date: Mon,  5 May 2025 18:32:20 -0400
Message-Id: <20250505223922.2682012-64-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Quan Zhou <quan.zhou@mediatek.com>

[ Upstream commit 2d5630b0c9466ac6549495828aa7dce7424a272a ]

The mt7925 sometimes fails to enter low power mode during suspend.
This is caused by the chip firmware sending an additional ACK event
to the host after processing the suspend command. Due to timing issues,
this event may not reach the host, causing the chip to get stuck.
To resolve this, the ACK flag in the suspend command is removed,
as it is not needed in the MT7925 architecture. This prevents the
firmware from sending the additional ACK event, ensuring the device
can reliably enter low power mode during suspend.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Link: https://patch.msgid.link/d056938144a3a0336c3a4e3cec6f271899f32bf7.1736775666.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 5b14bf434df36..2396e1795fe17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3287,6 +3287,9 @@ int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		else
 			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
 
+		if (cmd == MCU_UNI_CMD(HIF_CTRL))
+			uni_txd->option &= ~MCU_CMD_ACK;
+
 		goto exit;
 	}
 
-- 
2.39.5


