Return-Path: <linux-wireless+bounces-26298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6ECB22069
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DF8161F58
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7522D6635;
	Tue, 12 Aug 2025 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lRu9r0cv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3892882C9
	for <linux-wireless@vger.kernel.org>; Tue, 12 Aug 2025 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986304; cv=none; b=RYsAv2fP421lQtKCkIaIcvak3OxpPXY1heAsWtX5RPEiJ6FULpJkAbECtT0EkafaEntqLwUUYas5v7leVaYPe33j0SJDVenH+5NkxC+8kKcAUiKlqX2y4Hd3u33Ow7ktC6oBg0vmecZEHVhfXkYZ419ShgoKsVB//XZsJTpPurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986304; c=relaxed/simple;
	bh=mSghMgbaKauyD6cWeK3YZXIQf9f6YUVNqhroWrd2RJY=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=H+h3QRLEXN3eE2f61MJiUXeautmstTdCLGvFpOXJDY2gcf86q9Sq8tCvTuAYkEiQHnCub6W0VXzo+ODZSeeqlHPHgHvP5pyR4QE0k2Kpdy1b3vPPwaa3iIhq/uNBZ46l+Jf8gMMU0kfk/E0nwdZiTl7AuOaHq8mga6KEjcmiaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lRu9r0cv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57C8BcUrA2127434, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754986298; bh=D/h8cyeN/jPOUM8+VwmquGcwH9M5OK79bgyz7SR6nHI=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=lRu9r0cvgBiHEpCDP7CYdxKHaDJ9Cu6iShfr0kYhzluGARZbZqEfAZ3jUFpZfw+Tr
	 AeUrJx9PkABEryVJS3Z1exHRsonmh5QZ3D05gemZGrRifw+t9x+9PngMXspEUSaMg/
	 Z7QXeYDqkSwT3OQrKJcsTcv+PhgXV0KIw2hf6TlfvLT7fSNxEd315Cj6JHD/uSeK9J
	 B+cFsli3q3l4D7X93HvABj8lopbgwX95bIwG1PFomEYHq6ahBN3csvbK272Lb7CQFb
	 dTSi7s6tl4pFMBbX517d9/2WakojWi6kPW0BeVJ52yAnjQspQlpmKITKdNqDLT6sbQ
	 OB7Hj9dYYBpkA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57C8BcUrA2127434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:11:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 16:11:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 16:11:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: Lock rtwdev->mutex before setting the LED
In-Reply-To: <ed69fa07-8678-4a40-af44-65e7b1862197@gmail.com>
References: <ed69fa07-8678-4a40-af44-65e7b1862197@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <fa1cc0df-8d7e-4b32-95c9-d55cc9a144a4@RTKEXHMBS06.realtek.com.tw>
Date: Tue, 12 Aug 2025 16:11:38 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Some users report that the LED blinking breaks AP mode somehow. Most
> likely the LED code and the dynamic mechanism are trying to access the
> hardware registers at the same time. Fix it by locking rtwdev->mutex
> before setting the LED and unlocking it after.
> 
> Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
> Link: https://github.com/lwfinger/rtw88/issues/305
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

26a8bf978ae9 wifi: rtw88: Lock rtwdev->mutex before setting the LED

---
https://github.com/pkshih/rtw.git


