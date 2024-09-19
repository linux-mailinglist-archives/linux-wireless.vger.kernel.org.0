Return-Path: <linux-wireless+bounces-13005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49B97C5A3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565701F236FB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2065198A30;
	Thu, 19 Sep 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q4s3+diu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41C198A29
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733594; cv=none; b=EjxuzCIrgY24Z4e0rCt2Y2vz762JHnMVH+qrL/IeVVNyTq9IGKUfOYGvIcZVZfy9pwZ8fFo8QVTNvwKvPMQ5zwN/qdtqkEEzsWN09qvp9d6H9J/fyk1cLHxWrMCXtNIu1ikI57KpQhaz6Fwo3OtoDSXXEQIsNd5E4pAu2DaHOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733594; c=relaxed/simple;
	bh=2Gqaj7rX3FKBPaoUf1Yli3FP6+r+0WD09Di35j2SRfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+xw4xxf0RAVqWKHTo+MyfaI0nwGLXPZiB37XjTLyw2KmlMk7GuQSqiSO55dcGftk1O/mo0VzAK4t3T4PJ0IR5lgy3pvwcB2GkQSoNmJUheXKjQXgFDm7unyAzBh92MRAjoS4KeTmPeJE6GyzhnMcIoL3Z7WYYB1kqS7JxUj0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q4s3+diu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48J8DAMC03453239, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726733590; bh=2Gqaj7rX3FKBPaoUf1Yli3FP6+r+0WD09Di35j2SRfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Q4s3+diubr0vzL9gxogo/4ech5+dD1WpoGmaj7dRDG9sByV6WiSa8rkYK3VGCYuOF
	 6WxvdJEFxDkNSinPDD057dI80WhRMBVPTNhX0t4ssKHIPug2du36805cP+Z196ROrt
	 fq7jWmNhdGoGc6lj6yOSw4c/VKY1xerUMtGMZ9VFc60OkUkIqOyu1IDgfWsLEk0E1S
	 iotmLLilt+z4VAZYh0i818JVDrEyCHOm2e8l2ihaQ+3c6B4j6K1z00IbSjq2Sxml8a
	 FhkiLYrBqdKLmaDeQ5os7uy+IfvFG4dLU0gy3+cx3NJocMBJu7rJ7/bSmxRKdj5LDh
	 j5hc03H5ZEYmw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48J8DAMC03453239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 16:13:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:13:10 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 19 Sep
 2024 16:13:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: 8852c: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()
Date: Thu, 19 Sep 2024 16:12:16 +0800
Message-ID: <20240919081216.28505-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919081216.28505-1-pkshih@realtek.com>
References: <20240919081216.28505-1-pkshih@realtek.com>
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
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 211c051c2967..3281ee9d7523 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -2350,7 +2350,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 			if (dgain > 0x5fc || dgain < 0x556) {
 				_dpk_one_shot(rtwdev, phy, path, D_SYNC);
-				dgain = _dpk_dgain_read(rtwdev);
+				_dpk_dgain_read(rtwdev);
 			}
 
 			if (agc_cnt == 0) {
-- 
2.25.1


