Return-Path: <linux-wireless+bounces-23042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E895AB9334
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 02:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF437AF377
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 00:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070404B1E50;
	Fri, 16 May 2025 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iWLh3Hhn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541032114
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747355578; cv=none; b=KaeZkregQacQEeH9piSG5YApH9D51YAO/+iZFBAh/mJbsFBy5oLIcOvUMszVt40nGZhMs8aaLOsFIokGcTAEaDmZSFSBDYgOwQrPOKHNvwdtHygSKmEGnXKNadSf7KmqEQYPK6/fcZNLY1OIXtvJNEwDh8MtTQsyEuMclunl/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747355578; c=relaxed/simple;
	bh=cQQuLGi8aDPsV/nAjyKcA4zXXEI4ZZCwR/tVQFgQiwU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=Q+omyqPlhYvfukWAS6b8xLRQUpv2vyZr1lBQqGQgYRY0v2sA0Aq8wRv6NEAcD5v0cO6pPMGlgZHbNyClFKCime3/gS731BOlk5Q9617zcqi2FG4Zsjt42q5Gxai1c2lLyZp3+r9s1DUyOCrMJf6wnPUIzHUliqzdxUQPuyMOUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iWLh3Hhn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G0WqfJ6036727, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747355572; bh=cQQuLGi8aDPsV/nAjyKcA4zXXEI4ZZCwR/tVQFgQiwU=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=iWLh3HhnR5TAK9REkD3XJ9bNZHoG3ET3mKHQ+hg+ommJ/KH7FfddKfW2UVfMkg+bE
	 9atnySlkKj4A+fispcXW67D+zfGLnhyWK+kxKtYlcCr3sXaYLhGgETPKgvUXfiYTZ/
	 BrNWIbprx09tKT9q94JRW8kcuIW/OuKNE3h3aJ1JlSEhlWpUgi+ioYzC4fnDkj67I1
	 Jekz8hvhFiTo6QN+xo9qABOlHbTxB7r+r33VV5VQnarC8V+kM6XzR7isrR7o2CMq3z
	 d3XpKK1kQGPn8YqWMskivHtnOGGTO5LHiKT1YdikHzC58lJaCZvVX7kZajbCl8lMEs
	 nTXUR7++tdR6A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G0WqfJ6036727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 08:32:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 08:32:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 08:32:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <zohrlaffz@gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw89: pci: enlarge retry times of RX tag to 1000
In-Reply-To: <20250509013433.7573-1-pkshih@realtek.com>
References: <20250509013433.7573-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <4f552d2b-1ee5-4b91-aa13-c2fd711830f5@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 08:32:51 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> RX tag is sequence number to ensure RX DMA is complete. On platform
> Gigabyte X870 AORUS ELITE WIFI7, sometimes it needs longer retry times
> to complete RX DMA, or driver throws warnings and connection drops:
> 
>   rtw89_8922ae 0000:07:00.0: failed to update 162 RXBD info: -11
>   rtw89_8922ae 0000:07:00.0: failed to update 163 RXBD info: -11
>   rtw89_8922ae 0000:07:00.0: failed to update 32 RXBD info: -11
>   rtw89_8922ae 0000:07:00.0: failed to release TX skbs
> 
> Fixes: 0bc7d1d4e63c ("wifi: rtw89: pci: validate RX tag for RXQ and RPQ")
> Reported-by: Samuel Reyes <zohrlaffz@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/f4355539f3ac46bbaf9c586d059a8cbb@realtek.com/T/#t
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

dda27a47c036 wifi: rtw89: pci: enlarge retry times of RX tag to 1000

---
https://github.com/pkshih/rtw.git


