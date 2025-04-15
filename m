Return-Path: <linux-wireless+bounces-21541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D9A89782
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A993A011C
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC127B4EB;
	Tue, 15 Apr 2025 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HqECEJQs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72801EDA24
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708065; cv=none; b=P2/hDO7lChG1xB6aX5Tf93l83xbtdMQEvg6FoBpN9c2wCIwRsfqN2DwaFUSWWOM/pJj3d8UGucqEAEEas8zcBhmG2OcLo7iDWzcjO8raC1QBB+7pU/LSkSNIXOGHlNntaZEhNCreGaIy0p80hqyGDP7B8uxaNlNN2fsmtJfIM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708065; c=relaxed/simple;
	bh=X3Vna8Sy8yMt6yp6wiM1uFIJie0caRgCS7TmHCMs8BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDMDPSn9ryXjO8VVNuESRU4IrXk470ZSbuckGk+qUZDwPOwu+n9/h1Mpa3OuPdjAH5rwa646KDs8bPQ6U8YuLIQQUa4uxUxqJadZG2zTxjPHdsdDdvTuTn2VxZdZdyBv1q461vZ6nB3/qWvTIsNn+51cNuxTqySmcWaAcDsoxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HqECEJQs; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c83:0:640:aa07:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id E30B946F26;
	Tue, 15 Apr 2025 12:07:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id W7DXtFALfSw0-Fxz7aKHr;
	Tue, 15 Apr 2025 12:07:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1744708053; bh=E8yFLbL7ouJJ4xtQKNosRon0txv+XOE85fTdTJV32LE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=HqECEJQspyD5lptYnK3CPQj6mxmHIR9CiR9wDAAJ+NPQ2dkFG2cWDUNXUd8U2wmbi
	 csGH5qBV/XO7YGMOAfBdEc6p5H+pYM2dIgM+OnhNt1Tj99hYdrWEef5TQPl924+9Mk
	 yRcrM6H+RBQt3+zPBO95/SxlfVV59y/VwJGMcDr0=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: rtw88: do not ignore hardware read error during DPK
Date: Tue, 15 Apr 2025 12:07:20 +0300
Message-ID: <20250415090720.194048-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'rtw8822c_dpk_cal_coef1()', do not ignore error returned
by 'check_hw_ready()' but issue a warning to denote possible
DPK issue. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5227c2ee453d ("rtw88: 8822c: add SW DPK support")
Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 5e53e0db177e..8937a7b656ed 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3951,7 +3951,8 @@ static void rtw8822c_dpk_cal_coef1(struct rtw_dev *rtwdev)
 	rtw_write32(rtwdev, REG_NCTL0, 0x00001148);
 	rtw_write32(rtwdev, REG_NCTL0, 0x00001149);
 
-	check_hw_ready(rtwdev, 0x2d9c, MASKBYTE0, 0x55);
+	if (!check_hw_ready(rtwdev, 0x2d9c, MASKBYTE0, 0x55))
+		rtw_warn(rtwdev, "DPK stuck, performance may be suboptimal");
 
 	rtw_write8(rtwdev, 0x1b10, 0x0);
 	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SUBPAGE, 0x0000000c);
-- 
2.49.0


