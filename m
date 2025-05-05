Return-Path: <linux-wireless+bounces-22490-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583BFAAA080
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1943B07D9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C83E292912;
	Mon,  5 May 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvH/6fF5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9229290C;
	Mon,  5 May 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483444; cv=none; b=DqCJ2ji+CnQ/kMcklfmMudBAVjc4VK0ka29/3l2O//RAkwoiQVfggVmJUrr48c4P+Z+IzNWkboqDWrlgy5bd6N+a119yRzrFxGEDRqt7J6EOCPnHAkqwOGEU+bSgbIdeaWVKjIVvdf/Q1jA7CI1cgQJfUXUu8bWNWlsOs476t9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483444; c=relaxed/simple;
	bh=MzX9AmNrEMzOaOZaVzfQFEUOLYHVPhdROtRvsA3H9+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbvsqvWqfNFqXwlAfigBSWMt8DJgmAC6Qc4E+sBSFq7u1w638tatppNU152nxBSdXUDdVpWplbsoKjqGS7n7fA2gf33FF8MdaRZ9XAYTTy9p+Nvc/QulV9NVw/ZxLakzd4iFtD2YWnV6ueo735bgRf9yGo0KITX0TNFHKpNwkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvH/6fF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3B7C4CEF9;
	Mon,  5 May 2025 22:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483444;
	bh=MzX9AmNrEMzOaOZaVzfQFEUOLYHVPhdROtRvsA3H9+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvH/6fF5SgBsBjf0T/4CZx+Fco7uL9bHWUimJHlM586/J50+4lalJb74PD9SZJ7bN
	 8AA6TpylJ+RgKiRPfcJRocHwqgTUjW/1T+ayp3uJ7TrNaaa4MZkJaLmZJpJeexjbE2
	 WNp4vyQOiffaeRyR921TRD7obHTvTAC4pGp2Eq1zXcwT6SR7IgWFE2VNGL3kFXQzU3
	 hKqHerAWcxfktosKdALfl6IWIjaWIa5iiXv7WSA0TW1bZ+qzCFdJvHYtccfEgO6AZO
	 1TAE1TxC+OxYNwxA5RpsdirnMXNyJdCdCEfFxD1YsztKDyxMdTnuEzXIVdRaFrILNK
	 TsjLsvKyUd58w==
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
Subject: [PATCH AUTOSEL 6.14 082/642] wifi: mt76: mt7925: fix fails to enter low power mode in suspend state
Date: Mon,  5 May 2025 18:04:58 -0400
Message-Id: <20250505221419.2672473-82-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index e6d053c0cdbd2..8dc5dc0af1b1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3294,6 +3294,9 @@ int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		else
 			uni_txd->option = MCU_CMD_UNI_EXT_ACK;
 
+		if (cmd == MCU_UNI_CMD(HIF_CTRL))
+			uni_txd->option &= ~MCU_CMD_ACK;
+
 		goto exit;
 	}
 
-- 
2.39.5


