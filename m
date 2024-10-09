Return-Path: <linux-wireless+bounces-13744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB608995C65
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 02:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C51B212D9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 00:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA307462;
	Wed,  9 Oct 2024 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mOMKb1rf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBAD530
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728434606; cv=none; b=hwSoXB1IUp0+0SVKlTklr05YfgGrKXrhywJmH8QV8K4psu6d5y9cTOekTZzHt1NFUWh/k2nrQZxCmZZ2cZU8NOCKgMPB+j6iAkLa/JVJxvg8BOgTmcZD8bwNaSucv9sUoiSf9oypXfVnBMzpjJjbcdFlh8Wg3IDXB7QVri8Jntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728434606; c=relaxed/simple;
	bh=e7InX5wrhtFywDNutUiVw9Nys9uU9fPOJO3V/Lk529w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLTYiFSJjC5PQObXGuPY+MNzurnYvCxXTzFW1KQpIz+9KomnBONxfmrBKNb+R5pDTYuREWIiZYnLolFNddN8mIEixZP5A5vz4BzLhAHHcFYpjRvzffAvI7Ab5ylIRiJpie+kS/vq6fKg+fGAQ6J4lZ7IxNMJpXgW5CKOm0PkHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mOMKb1rf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4990hM9A14153176, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728434603; bh=e7InX5wrhtFywDNutUiVw9Nys9uU9fPOJO3V/Lk529w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mOMKb1rfJuQnW5kkQ93mMZlND5RbHNPSFuuRize5OcoKRH39fz22XG50Ta1ydu+A/
	 IkNy7ifRCEY/D+FaZYouZXH/sNRiTE/QWJz6pn0VLkrEakc6ItUdGBb8CMsszA+cet
	 t2ukgBSOo1D7PnBDZwmjw6CL7Ci6sXj6Jf1mF0hLg+yu4iaKiWRX+utYXFR91qaPOp
	 cXzIZ4kzxz0qeNa/TbV+/z7IHtjWBIXr8aY3Q+WjRU+KmkWuiVM674pbkojH+U7W51
	 N6/7sducGk8okd0uzfSI6JHipzv8jGAHUgzffF7q2JnNs+tM9N6LJQEXgkTZ93/6L3
	 3L2QG3h7dTOhQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4990hM9A14153176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Oct 2024 08:43:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 08:43:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Oct
 2024 08:43:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: 8851b: use 'int' as return type of error code pwr_{on,off}_func()
Date: Wed, 9 Oct 2024 08:42:57 +0800
Message-ID: <20241009004300.8144-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009004300.8144-1-pkshih@realtek.com>
References: <20241009004300.8144-1-pkshih@realtek.com>
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

The return type of error code of rtw8851b_pwr_{on,off}_func() and its
callee is 'int'. Correct it.

Addresses-Coverity-ID: 1624679 ("Overflowed constant")
Addresses-Coverity-ID: 1630970 ("Overflowed constant")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index f9766bf30e71..1d70f7140827 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -282,7 +282,7 @@ static int rtw8851b_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
 	u8 val8;
-	u32 ret;
+	int ret;
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_AFSM_WLSUS_EN |
 						    B_AX_AFSM_PCIE_SUS_EN);
@@ -401,7 +401,7 @@ static void rtw8851b_patch_swr_pfm2pwm(struct rtw89_dev *rtwdev)
 static int rtw8851b_pwr_off_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
-	u32 ret;
+	int ret;
 
 	ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_ANAPAR_WL, XTAL_SI_RFC2RF,
 				      XTAL_SI_RFC2RF);
-- 
2.25.1


