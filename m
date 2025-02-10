Return-Path: <linux-wireless+bounces-18686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4AA2E2C9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 04:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5B9165E64
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 03:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAD35959;
	Mon, 10 Feb 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H4X0Cw1q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D6EAF9;
	Mon, 10 Feb 2025 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739158256; cv=none; b=e8BCQfzxqC69pUpSBJTCWr9/IKc8kp2sAB4Q+rEkRt3EyDaIVkO/uYMm3fdGcA1m9I5Mgl5nTstH2avEn87TB8DuG6IdofQhpfjwDd0vrrs64aRIeIGgXshj8P5GT6hSidT8D59isTDqGOJRBG9QzPS9pEjYO53aEWB0FMi2HGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739158256; c=relaxed/simple;
	bh=Q1Su3D5c2gr1CavN3lDfl6QRAYE429ak8JkjXvZzV3Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=AtKwXBTtTPn/lKajLOrwnJ1MWjg8XrHb/o+FQOW4rDOSJLhw9mFmyMKpKLi2e7QgSkHq2sQYCFxpA+0OtaHWA+CF7qtK9UhB9qZWPYPJPfBjx55+pk0f4Ccmj5aDdYpS6L8NWEc4ldr5dRL1PCPqHo5dAmE0GlEATqfzHs6Xeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H4X0Cw1q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A3Uj3P21575411, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739158245; bh=Q1Su3D5c2gr1CavN3lDfl6QRAYE429ak8JkjXvZzV3Y=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=H4X0Cw1qC7wDAS4EEV1NwTHFCNC77chBrlnpYOadni56LFDk10gdcdXmW5DYAAE1n
	 E0mitnHqFC9wtdfqPPOncQ/j2h5yFEeqOEl2JdcIxiuS57OtTUosFqVCBT3yn1cBzi
	 Ss/vnbRGVLZG4zZWtsULzzGu/hCS6TVhjAfb/0t8dNIP2XL6eQzUyGzp7eh/WRM27S
	 JdWy3N8tAurkoUzGv2dUUh5J2PXjbF/F3hviPF/grUdtzwyH4fcQhuvw+zuwwxUoSE
	 +RYEIEWW8PCQZRvFQIIsgvcGO60ROl1xDpYatdCku/Jlbao/gh2Wttxz0vHWq3zbJq
	 j6QPNTiK42svw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A3Uj3P21575411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 11:30:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 11:30:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 11:30:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrew Kreimer <algonell@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Andrew Kreimer <algonell@gmail.com>
Subject: Re: [PATCH net-next] wifi: rtw88: Fix a typo
In-Reply-To: <20250203180913.5435-1-algonell@gmail.com>
References: <20250203180913.5435-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <d4f2bcde-3bb4-4ab4-941f-255510bfc1bc@RTEXMBS04.realtek.com.tw>
Date: Mon, 10 Feb 2025 11:30:44 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Andrew Kreimer <algonell@gmail.com> wrote:

> There is a typo in debug messages:
>  - afer -> after
> 
> Fix it via codespell.
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

105dc94233e4 wifi: rtw88: Fix a typo of debug message in rtw8723d_iqk_check_tx_failed()

---
https://github.com/pkshih/rtw.git


