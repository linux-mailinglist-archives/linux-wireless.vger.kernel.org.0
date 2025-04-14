Return-Path: <linux-wireless+bounces-21496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC165A87A9F
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF01C1726A3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CDF2580CD;
	Mon, 14 Apr 2025 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Rod1DXIg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194315DBB3
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620113; cv=none; b=QrwFVXmLY56aTqmc0XL4p2g2jLG20oDcL44nM4Zr4ZYYnT570ZpOZhvV1TLMpbECB9bXsY3g7D00kbQaCpOXzjEHA5pI+nB0qPdRci81m9dMPc3XMtawOsqh8tkFIsMCIofa/a8HX/Ed8o0bhuPhE5IoxdtSh8dP09HU87XQOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620113; c=relaxed/simple;
	bh=SbypxFFQrsvtr0LTqtO6BioaFRQQoENE/7g3iEJPaz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JE+JmzBWWRR0Du5MxGmSV9e3el49Xz/gl80KQ7CTEOfSgaQ2pcnYzatfwzGysCyYAI2DZk++uAi7jnMU6gZhLPAahBu2P0xYAiMGusgw9Fq7uoreXr0R4nwmMZ3pXUs/VmHEKdEfrXM4k/yPqAQ/OrWOUUAbcUke3raNkPQwkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Rod1DXIg; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id 409F563DA6
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 11:34:14 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2db2:0:640:9334:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id D9FFB60F04;
	Mon, 14 Apr 2025 11:34:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4YB5bOjLc4Y0-F2IB6xZx;
	Mon, 14 Apr 2025 11:34:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1744619645; bh=KFFYN8y6ggqJWZtTKjrzHfyLxc01ET1wdJWSkdxMulI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Rod1DXIgO5Cqu833CGJ3t8uUIA/h7ByN2YO7Dxl+TSDpsbu4OrQIBhrkSidN6b/el
	 TkWK3HEEAk2WWcT9M99VUTiBqS0iU8A4zNH7tSgNHxP1ZogMD97rtLZqNXo7lPWWLU
	 M95f6K6jkqRGQW8MTwtn15UpiBMAfSyK/UXa9l9U=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmfmac: avoid calling platform_driver_unregister() more than once
Date: Mon, 14 Apr 2025 11:34:03 +0300
Message-ID: <20250414083403.561646-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'platform_driver_probe()' may call to 'platform_driver_unregister()'
itself (and denote such a case with -ENODEV), this case should be catched
to avoid calling 'platform_driver_unregister()' for a driver which is not
actually registered. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index cfcf01eb0daa..d60ed50e8bde 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -602,11 +602,11 @@ static struct platform_driver brcmf_pd = {
 
 static int __init brcmfmac_module_init(void)
 {
-	int err;
+	int err, probe;
 
 	/* Get the platform data (if available) for our devices */
-	err = platform_driver_probe(&brcmf_pd, brcmf_common_pd_probe);
-	if (err == -ENODEV)
+	probe = platform_driver_probe(&brcmf_pd, brcmf_common_pd_probe);
+	if (probe == -ENODEV)
 		brcmf_dbg(INFO, "No platform data available.\n");
 
 	/* Initialize global module paramaters */
@@ -615,7 +615,7 @@ static int __init brcmfmac_module_init(void)
 	/* Continue the initialization by registering the different busses */
 	err = brcmf_core_init();
 	if (err) {
-		if (brcmfmac_pdata)
+		if (probe != -ENODEV)
 			platform_driver_unregister(&brcmf_pd);
 	}
 
-- 
2.49.0


