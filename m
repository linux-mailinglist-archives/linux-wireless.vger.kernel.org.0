Return-Path: <linux-wireless+bounces-16007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2579E8A3A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128F11883F74
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C0155C87;
	Mon,  9 Dec 2024 04:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HIfBgUg4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3415623A
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718049; cv=none; b=eAfJ4aPMoN2MS7yH+ui5TQVP+CBK+s+Rkey5OiyhHxUmdjlgz9Ir8YLsN/r3ELKM/JTv/I7KZp8aOQFrnjXhQTIWHW0awVNB+8vmNozzUlHCHh2VuXW7VMO7Wd+qaTk0cqvCQLTgNH8sc/N+TFOC2+nax5yXzBqjZATeN/TMUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718049; c=relaxed/simple;
	bh=i0dM9Hr5HyP/vIVVBKyn902HZ3bHfypemt2y7QM7YxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWOUji3irAGuf7B5xAxLNNaEZeyxNX96Y0ZJAc0cgRX5RolptPc1Wgo9CGpMbdmy3LbyOTSGgZlhBXQDrChVytbuWVoxtfVROlvJXRqWQCST+Ykw2aVJMwQbQQxxu/koZB33VbHmxcoeup0ljiA9OjSonDJh6vZVyULiRbuFFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HIfBgUg4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B94KiNkA004747, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733718044; bh=i0dM9Hr5HyP/vIVVBKyn902HZ3bHfypemt2y7QM7YxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HIfBgUg4nWzvX6r2DuscaA1ZHy9ikH+SqHvGwRhJoPE/8vp0AVAQd/UdZ3Z1c+qmM
	 6IPemr8atSzl+J/PAuoa5JpPnbiraofnde2MAEjLmkeEqh6gtKzJOjaydiw+uNZDYY
	 cntlKz5X0tk1p21ItlDiufL4BsLry8vQCOX4fWSnd9eyjaJrV8d8knbije1AGr6Ia3
	 4kOCWHorS3oukf+AATFfpy1Nxgso55+Q79sRoYTIm6KnRlIc+yKdEjGFQK5gVRq9Co
	 Nv95BNDX1hxROVa2rUvp6fxF4YE+5X7IOQGYESt9z9K4eMJ14onG6igOV3A7jZOfm0
	 mMEbfdTgf3Irw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B94KiNkA004747
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 9 Dec 2024 12:20:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 12:20:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 9 Dec
 2024 12:20:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: 8851b: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()
Date: Mon, 9 Dec 2024 12:20:20 +0800
Message-ID: <20241209042020.21290-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209042020.21290-1-pkshih@realtek.com>
References: <20241209042020.21290-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The return value of _dpk_dgain_read() is not used afterward, so remove
it safely.

Addresses-Coverity-ID: 1504753 ("Unused value")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 364e36354225..f72b3ac6f149 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -2199,7 +2199,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 			if (dgain > 0x5fc || dgain < 0x556) {
 				_dpk_one_shot(rtwdev, phy, path, D_SYNC);
-				dgain = _dpk_dgain_read(rtwdev);
+				_dpk_dgain_read(rtwdev);
 			}
 
 			if (agc_cnt == 0) {
-- 
2.25.1


