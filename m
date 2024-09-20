Return-Path: <linux-wireless+bounces-13031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E897CFF2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 04:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D551C22A1D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 02:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1381A63B9;
	Fri, 20 Sep 2024 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ng+/1T9n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290DB665;
	Fri, 20 Sep 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726800324; cv=none; b=LQWilJgGcgir3DWbHdYWn7htmGaaq7XoHG/1RLs0DW7LEDEGFAkm0QxG34hw/DnPLFE46vxA0vg409MI93F2aIRuJ2ASvhFbFzpyA4QtdUcFFWJHgTMYdq3eIsYwfy4x9NLO2ioUhDbIeLMpJzd+OPs1Q2hf5kjX3NEn1gLD68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726800324; c=relaxed/simple;
	bh=Q7EKc4AMj6UfREXNIXBXfyFtCeCwq/L0BOCMj4Mh+70=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=DpHbA258Q3uOZKGmUyrGYPQhDcZ43OABy3fTbEb6JDx//iESjJIWII3oXpWm8SJ/c5l8Tj0WU3Yx4a9kDzPvUN3rII8bn2KwiEjZWg9M4r8nTs4w962nPlo1lZLUE3NoRbWyFEW1ipkNBytEd6Ih4+5D6eDVthhToanH4Nk5V0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ng+/1T9n; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48K2j3uK5450393, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726800303; bh=Q7EKc4AMj6UfREXNIXBXfyFtCeCwq/L0BOCMj4Mh+70=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=Ng+/1T9n6N3DiKc70nftgvgrIEIK/3kbW3wxaKl8WOorNnO3uB8PNIRCFdByC8uVk
	 IQXg4wBGhHWag5EHGMAz8vcHf+i40GBuq6KDIECqDTdn8ze6yZMQrXvUcbq4uHpz9/
	 HAWuFe014WMvOVF/6A1uVf5HPZbqeWw+fQRhsLjgl8JwZpeUtGgLBxi4s8KOOjmVRC
	 d8QC/IvbkLgnvizucll1h224ixZkz7yaKvia1PPg3clvNtZsMA6TE2jL0dNeqees31
	 KwuamR2lDYdRaG0DyQG8P50HzcEatzQSvmSit0xtjU/CYe9g18Nu+ghzIKhbXYvM2I
	 jSWkwbFOu/h3g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48K2j3uK5450393
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 10:45:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 10:45:03 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 20 Sep
 2024 10:45:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        Dmitry Antipov
	<dmantipov@yandex.ru>,
        <linux-wireless@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] wifi: rtlwifi: make read-only arrays static const
In-Reply-To: <20240912135335.590464-1-colin.i.king@gmail.com>
References: <20240912135335.590464-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <7fb38f2c-9494-4965-82b5-8ff73c7b89a3@RTEXMBS04.realtek.com.tw>
Date: Fri, 20 Sep 2024 10:45:02 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only arrays params, toshiba_smid1, toshiba_smid2,
> samsung_smid and lenovo_smid on the stack at run time, instead make them
> static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9e698af3a42f wifi: rtlwifi: make read-only arrays static const

---
https://github.com/pkshih/rtw.git


