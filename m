Return-Path: <linux-wireless+bounces-21286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91498A81ACB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 04:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920BC1B64241
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 02:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6213A265;
	Wed,  9 Apr 2025 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dVOhdP6h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CB78F3E
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744164425; cv=none; b=b3TPYiRQJjScks0/3jBZgpYVxeEZ6tBym/VBqPDcCjylj5S5TJ+Ep97w5g+XvAPWgsPHiccpJ2RdPxh8htMw9u3vK9CGmpbotcfPjR6zETS1876WNiCGgoCVlW5tRgF0C4x1LWs+jVtMurm3Q/l23H8slaqsS9tNhI7RfWx8cvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744164425; c=relaxed/simple;
	bh=RFX1V7rTXjtSsPQ6HS0nxigbX0tbnLdtt9gYMZ7pJ+E=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=KM+T+cWvLDKJgdxxJTNMdF0iPNKkxMS3ezRzkCUHLU8/9xVJvN5zspDWeHed441jfJR2DEHApBx7s4SanYEphrfi17VBjZKoZWGeZbYa3RYA/UaYPMLQiPnQGzOyl/KnjzBrUXPyxKmsKbYmRyLMz8ysJsOwKLXSaHJ/D9D9xag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dVOhdP6h; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53926xv66455515, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744164419; bh=RFX1V7rTXjtSsPQ6HS0nxigbX0tbnLdtt9gYMZ7pJ+E=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=dVOhdP6hZnpH/g9i+NTd8Sk+Y599M0N3Pzkle0NK7JX1tlTle3vvj7SBDI1NVIS1b
	 P9FF7qPEEX66L18eY8I7bBhWl0zpt0xW1BrozTegh5M6FY4iZYC3UorqjRGOkPUfQr
	 a8EwsST2Z6ioBUCc0l90LNoY0EaAtRgs/zVQagah/9rgIsji0Sp5Ipj1XEkPte8/cx
	 uzTIfOBUarOWFOQy5rdIQeZuBQ8ySv509J3MuRDU0O56kZ8YNNYeEx8d/JTDBlX1jU
	 2jbWMtgFgo0cb34c20+uPu5VLlCGxVltV13LObvwLIPoS32Q3B+BRFgfbaBCB+Bwf7
	 OkMJtsXskdIlA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53926xv66455515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 10:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Apr 2025 10:06:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Apr
 2025 10:06:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH rtw-next v3 1/4] wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
In-Reply-To: <d3608f70-e04f-4f6b-987a-022c8e317165@gmail.com>
References: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com> <d3608f70-e04f-4f6b-987a-022c8e317165@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <d40b8c76-f7bb-4148-bb53-68958cc05cc1@RTEXMBS04.realtek.com.tw>
Date: Wed, 9 Apr 2025 10:06:58 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> The Realtek wifi 5 devices which support USB 3 are weird: when first
> plugged in, they pretend to be USB 2. The driver needs to send some
> commands to the device, which make it disappear and come back as a
> USB 3 device.
> 
> The method used to switch the RTL8812AU also works for the RTL8814AU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

4 patch(es) applied to rtw-next branch of rtw.git, thanks.

bf1103654df9 wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
dcbb7bb3a364 wifi: rtw88: usb: Enable RX aggregation for RTL8814AU
0d2a88690e58 wifi: rtw88: Set AMPDU factor to hardware for RTL8814A
b8d49bb8d16a wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU

---
https://github.com/pkshih/rtw.git


