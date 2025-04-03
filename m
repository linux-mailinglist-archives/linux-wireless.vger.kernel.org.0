Return-Path: <linux-wireless+bounces-21142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA043A7AA5F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 21:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B9188D185
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152F25D1F0;
	Thu,  3 Apr 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nehykLpi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755725D1EA;
	Thu,  3 Apr 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707027; cv=none; b=nHm+G1ot6d2Pbw9pXfDKUoMMpq5EmWENZ1nC5UefiWMDJwUySHZNK8dhYJqM7igEtOuaSwpjXdgVpRD9m1SLkJ3eg9MRLMoKgFTqbdIKWZZje6KgWxWJe2w3Rx/p9Cz7c4uADuc2sHkwtwys8YN5oMp1K1a+Dgp4i3g8h6R+log=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707027; c=relaxed/simple;
	bh=NilAVgNUnea1icERfhytbZ+XwefVTD71Tzk6Trb40CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWbC7VfqpS6fPO0CXpCIZbDx2A1aApLt49XG0SZYlUL9ySR8wCTIlgJH6InE9oZuWUDKAwKjwvyedoxjY5r/iFE9pZeUXbx59+JeELfLWRgArW7RiHWBHTGoiTcymSrwZftDZaDSYryjwq8q+/t0+h4CVa6H5B4DLnQkbo7YdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nehykLpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7611C4CEE8;
	Thu,  3 Apr 2025 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707027;
	bh=NilAVgNUnea1icERfhytbZ+XwefVTD71Tzk6Trb40CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nehykLpiNWWTY5Ru3hy218VWrDu+1h74rnoUTcurv1WZMnUqF59GbqbeR8cahkRHz
	 Q4ijOiiIop6gUGFBxWIs8QZ7BfgDV1V099KcU3ymcLVM6ZOG+j+dQss9pRNnGF1I4+
	 zYBHSkliyNtNqeEB4aVq7fftwc1hB/UWrKbeAr1iGG393JEKLLMEvBPYaejXlQL7Lq
	 /DrpvcsiIRkyekAA8LEjMgCqm6uD40o9pKtlEvdpiN8xO0iv4BaCnBvtFvYPpsfSdB
	 qnxSkiOfjEHEbdmhyKQSJ8LLiyLXHxtxijkk2x/5GsfcjsCQ7AmdTQmlwBZx/++f+K
	 yOGOLJ38kZPNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Icenowy Zheng <uwu@icenowy.me>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 42/54] wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table
Date: Thu,  3 Apr 2025 15:01:57 -0400
Message-Id: <20250403190209.2675485-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Icenowy Zheng <uwu@icenowy.me>

[ Upstream commit 06cccc2ebbe6c8a20f714f3a0ff3ff489d3004bb ]

The TP-Link TL-WDN6200 "Driverless" version cards use a MT7612U chipset.

Add the USB ID to mt76x2u driver.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Link: https://patch.msgid.link/20250317102235.1421726-1-uwu@icenowy.me
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index e832ad53e2393..a4f4d12f904e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -22,6 +22,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x2357, 0x0137) },	/* TP-Link TL-WDN6200 */
 	{ },
 };
 
-- 
2.39.5


