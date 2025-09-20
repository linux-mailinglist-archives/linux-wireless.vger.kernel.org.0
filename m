Return-Path: <linux-wireless+bounces-27537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A603B8C8FA
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 15:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6747E682B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722BC2EF655;
	Sat, 20 Sep 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="A5SD+BFB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1F21ABB9;
	Sat, 20 Sep 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374847; cv=none; b=itFdh5kdy6C3nH2mFzaVOgiNpEzfb+Z1v1hZy12WH6MDRDzkd5UgKX0DxLagTyAoqGl64mV9b9Gd6n1rKwJCIQe5e/vj4zAorcPIgEyjOkTrXM9Zm/kMiJWzIa8ZBvMcciamZe330Uh/Z/MzD8czdBQhODbufKTyGeryvW5S5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374847; c=relaxed/simple;
	bh=+5zJJBMp28b3RNV11cXcoPk2KlYvFeu/RpmblKNF1cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYDewXK0G9Z/07wE+jln+00o1Psi6Bu9zuNplQpN8Ed8zCHzVOEiLedksUJea2hjPbwMp8By254yD/cKy9ETiog8FUgZ7fwOZfGsc2Baa9z7SMSS+4lpt+J9M8jMV4gNIQh2fxMpkqpd6DUAOqScPyh4wWxTAU1y/mtUh/tzvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=A5SD+BFB; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with ESMTPSA id 827484076196;
	Sat, 20 Sep 2025 13:27:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 827484076196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758374840;
	bh=qYEgn/oW7K3hUvrvd7wicZlY1XzT2y1JP1X8K1louj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5SD+BFBNI70Q9PNRtXBy+5WkEenYtQkcZC21JTYERPSbA9o+cvqxjHS2mdEvHC3D
	 +KTtUiAd6cN3jC+ThQP/llr0OiL1ZVK+7Ey8KFxnphfnQot6YQT9BkykKcISPqxuJT
	 G0CIhC5VDubzzJOneaIlIdDzv02xVppQFnM7gI2I=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next 1/6] wifi: rtw89: usb: fix leak in rtw89_usb_rx_handler()
Date: Sat, 20 Sep 2025 16:26:06 +0300
Message-ID: <20250920132614.277719-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920132614.277719-1-pchelkin@ispras.ru>
References: <20250920132614.277719-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free allocated skb on the error handling path.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 2135c28be6a8 ("wifi: rtw89: Add usb.{c,h}")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..3435599f4740 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -422,6 +422,7 @@ static void rtw89_usb_rx_handler(struct work_struct *work)
 			rtw89_debug(rtwdev, RTW89_DBG_HCI,
 				    "failed to allocate RX skb of size %u\n",
 				    desc_info.pkt_size);
+			dev_kfree_skb_any(rx_skb);
 			continue;
 		}
 
-- 
2.51.0


