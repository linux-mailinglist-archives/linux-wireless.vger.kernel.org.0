Return-Path: <linux-wireless+bounces-10546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C693D287
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 13:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D40E281F74
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE05219EA;
	Fri, 26 Jul 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="NiQlaDrr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8F2B9C4
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721994434; cv=none; b=Ft50XPKxov0EUpKXbLniEHbNWVMGvWr5blh4YI29jmZ8rRAZBBTemEfzKn421sKT6sh4Nq5oLpOxRPWFknNBBxuSNSNfHRT+wdD8EqQhGj/JR0Dn1FwnvJ5uzdDkLrCESL1MckcbdrfvR8X4LGa4oYQqYQ1rZ3PtbvbOCkuAIn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721994434; c=relaxed/simple;
	bh=+9cDj2A2sm7YxBxGE/6lhrwn76uK5Sx/QRjMOH8xrE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHmhjXtL7MWG04qRNqMf9bWNJ2tldrCZlIewuvIBfgLf6BU2Wn+FsiskA3hs/YVpvw+pic3+jbBkHVJymugwa2IUBzbVBQSqVecNggL5ZFmRprYDFLOuZWqA+DxkAB5WsqQKclJt+nU22Me0Js3pIu/BslCZlrK9tICLDR53Wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=NiQlaDrr; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2146:0:640:e7:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 2BD0A60B10;
	Fri, 26 Jul 2024 14:47:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xkPI1j7Ula60-qj0zupLe;
	Fri, 26 Jul 2024 14:47:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1721994421; bh=TpI/0MBn/Ut28fZ++un9uklnz1cRFnzwLgLELxrAcnE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=NiQlaDrr/BlQPPwFHPekSwDD0ClN7L2ZT4HhO1vLafyK0rd7GcIOH2C9E3GQpuBd8
	 KdLQz1ocTPalySUGxfXRydProCA6RtRZ2uYFCReSZk2diDpk1Gygl6vS6HsxJbEPoC
	 oJAp2DDP6+bBRzX3Xzx2DUaJBuaROQR10102trBE=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Chin-Yen Lee <timlee@realtek.com>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com
Subject: [PATCH] wifi: rtw88: always wait for both firmware loading attempts
Date: Fri, 26 Jul 2024 14:46:57 +0300
Message-ID: <20240726114657.25396-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'rtw_wait_firmware_completion()', always wait for both (regular and
wowlan) firmware loading attempts. Otherwise if 'rtw_usb_intf_init()'
has failed in 'rtw_usb_probe()', 'rtw_usb_disconnect()' may issue
'ieee80211_free_hw()' when one of 'rtw_load_firmware_cb()' (usually
the wowlan one) is still in progress, causing UAF detected by KASAN.

Fixes: c8e5695eae99 ("rtw88: load wowlan firmware if wowlan is supported")
Reported-by: syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c6c08700f9480c41fe3
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7ab7a988b123..33a7577557a5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1313,20 +1313,21 @@ static int rtw_wait_firmware_completion(struct rtw_dev *rtwdev)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fw_state *fw;
+	int ret = 0;
 
 	fw = &rtwdev->fw;
 	wait_for_completion(&fw->completion);
 	if (!fw->firmware)
-		return -EINVAL;
+		ret = -EINVAL;
 
 	if (chip->wow_fw_name) {
 		fw = &rtwdev->wow_fw;
 		wait_for_completion(&fw->completion);
 		if (!fw->firmware)
-			return -EINVAL;
+			ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static enum rtw_lps_deep_mode rtw_update_lps_deep_mode(struct rtw_dev *rtwdev,
-- 
2.45.2


