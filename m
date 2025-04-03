Return-Path: <linux-wireless+bounces-21153-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC6A7AD8F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104A817C719
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 20:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4F28CF57;
	Thu,  3 Apr 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osoQnYQk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82A28CF55;
	Thu,  3 Apr 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707463; cv=none; b=DIjp7Qyr9ptf/lHQ6deXK61WbxmRW5PCvPH0qwb8nZoJAvIiD3xiW8U3VGtnQKzmTtQf6fl7/0qLHb4NbJ28P4kfvSd/jJDPnNP/IzHYpiTrZnWlnR6F2HJg0oxw9EvWgJUFrSDO+L+p/gaju7aiO0QyRnPB/3DA0t9jebWXRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707463; c=relaxed/simple;
	bh=p0tKKu06Y829F+DUE1Ct7xBxdEYR3/AUxIgzVvJ3Lyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3+ShjtOX747ruLstFlf/hN8HuVRTP+Ubpmx20ARmWw/qzKjyfEOoCGWpggKCCTxF4fzRzIbC0nDrey4EVX5arBuAPWoMoHheTc0BuVnYvpmIObH3wlwXvQ16ft+y8rawaYqEejUbTGzGXFh4zRa81/KlN4c/1C4kpnA9Ojj7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osoQnYQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3234C4CEE3;
	Thu,  3 Apr 2025 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707463;
	bh=p0tKKu06Y829F+DUE1Ct7xBxdEYR3/AUxIgzVvJ3Lyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osoQnYQkpnINrA2CaWCLL5cG7z/TKM10yEBblFUqLTLLW9w4lP2Tb63pu9/qqHG6j
	 Uh7Q9b8wVdxkTc5IRfRpDYc+DqLnVp3vbdzJAaAqFkokDdSpw01jHtXTXYB5RcXtFW
	 QtX/4kcFG3+cODEMiTGsxxAvKKRTng6voP64QUrIOf39jRSS6IRG3EwOL0YQ7Vi0n8
	 hQArBsUBbUMwoGpXwlfLkRebkmbHx+6kHSB9BT/66FY0o0Qr65ECJ0jp+la2UyMcN+
	 VX9GOdgUFHxTKU0Iy3WX104n/FlHgL6NxtWimsZRYjOJhqv9Xk5YdFBR2k+O4k6HiY
	 678SbobnicPTA==
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
Subject: [PATCH AUTOSEL 5.4 11/14] wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table
Date: Thu,  3 Apr 2025 15:10:33 -0400
Message-Id: <20250403191036.2678799-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191036.2678799-1-sashal@kernel.org>
References: <20250403191036.2678799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 96a2b7ba6764b..8c392d55d59ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -19,6 +19,7 @@ static const struct usb_device_id mt76x2u_device_table[] = {
 	{ USB_DEVICE(0x0846, 0x9053) },	/* Netgear A6210 */
 	{ USB_DEVICE(0x045e, 0x02e6) },	/* XBox One Wireless Adapter */
 	{ USB_DEVICE(0x045e, 0x02fe) },	/* XBox One Wireless Adapter */
+	{ USB_DEVICE(0x2357, 0x0137) },	/* TP-Link TL-WDN6200 */
 	{ },
 };
 
-- 
2.39.5


