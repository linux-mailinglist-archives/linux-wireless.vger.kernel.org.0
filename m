Return-Path: <linux-wireless+bounces-15431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FAA9D07BD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 03:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03CB1B218E0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 02:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71BD1E511;
	Mon, 18 Nov 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nH4anWAx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C6C2FD
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895787; cv=none; b=DgK0NsxZjX6ve3PKrjXTCLGrsNrxzaqXNKC2Ynvh2ozYKYoZKoFTNlJGIIKyn4xfVOnbe3y8IBC/myOOqclG4F9tusGZetuFi7pSz/V0FD28L5DcwzGypbnucfTHiOP9HHG1S+PInmBIF9AOZ6EeQrev6U6JW+/V3HkPt3Oonj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895787; c=relaxed/simple;
	bh=J0DrdZZYOOQ7MXNH+jMGwlhgNE5sG0yp8NENtSLyLQI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date; b=Zs76cwbwu5ZOSfLydWtNh+wihXszUAjOWymP9Are8cK+hgFC0a+yLlB6BaWIrcQhRZeD9fK+k2/xRVj40zoJ7h6Q8rUAtakrHuFK1oJ3fdZxeStgh2KL2gWH8SfcDaOJ/5gHlKSpqbvqwXFnJD8kiKYrGlZHRNTjjpBzU5M9XRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nH4anWAx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI29iNeA4156234, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731895784; bh=J0DrdZZYOOQ7MXNH+jMGwlhgNE5sG0yp8NENtSLyLQI=;
	h=From:To:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Message-ID:Date;
	b=nH4anWAxTy17cjAVAIqbOdKBFQdDyZWtkxXwmlyVf4FnBDyWpuImrvjInz2DTQVRJ
	 F5gJM94c20ZTWXAoSPf0YwwTcDyWHvYiyXGSvyoqQr3qVV7mcLZMyfwvQR2GAXX0oJ
	 K4W/Iz/qokoL4+n/qFflrLLP862ZjpVo/bnfWA2up7MZoQ9e27TdKXVdxfgXnScgoE
	 OfJ9nU+XyFd74870kOOACq/NoHUEbzCWh0+AGzzFu/riHI7zSz+eD9BSW1ZHXF7jlj
	 sTZO6PEaF5Vl2cB1oiRU4UD5gk4nzumy66M3pB/GaARmn+Ic2oTE2+B+ya+eRySqAr
	 RYMZqAlGSDsuQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI29iNeA4156234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 10:09:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 10:09:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 10:09:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
In-Reply-To: <20241111063835.15454-1-pkshih@realtek.com>
References: <20241111063835.15454-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <5c459c97-7808-4874-acda-23df472aadbf@RTEXMBS04.realtek.com.tw>
Date: Mon, 18 Nov 2024 10:09:42 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
> going down, clear this bit to prevent waking up host unexpectedly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9c1df813e088 wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit

---
https://github.com/pkshih/rtw.git


