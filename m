Return-Path: <linux-wireless+bounces-22419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F80AA8A9C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 03:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C4F3B00B8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE52D052;
	Mon,  5 May 2025 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="lUFwlEfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31529A5;
	Mon,  5 May 2025 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746408724; cv=none; b=QkENELYhqj6wZKlHhDF37si8rCDTY7Kq6b77r0lEe0EszT8gEbQWkBqP+723CHvqOqdjdGkVl1eOOc0g9EocBJRvSKx7NEgohNs0IIx99fncDXblKpEfiJHuKoSKMsBUajhQuwFKm+Uqyd/sCwx5mj5Jf6QIsBpnCScYYTo3sCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746408724; c=relaxed/simple;
	bh=Yg3Y4Z1tP5uMCgx+nZFM1yJ1/G5SK/T+i154u4PXB+o=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=olVnuSGhQqL/r6PEzGmDSjfnOY0Pxxx40h8Pz5qo1SaM9cf3yRv9rLa0xxRutP3ziL0TDAUYPhnCf8EpD+4KE+13H7WtgIPK2zxcxdzWyf5lrCPZbFHjmLfbUjVmG1FvuiJ0nCfGthV56azy/pgxQFComynjZbFmEGOhiEqlESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=lUFwlEfm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5451VqXxA3359505, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746408712; bh=Yg3Y4Z1tP5uMCgx+nZFM1yJ1/G5SK/T+i154u4PXB+o=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=lUFwlEfm3ApzIhd6uDvEXxbQ/YgQ45oHE/5n+Nvioug6/NemvWyYzwPdbmf7dB/S1
	 gGmgedfwFsl2uj9Ln7dtsT/DL5bGaMXs6Ddt3AkAJ8A75hdXmpuJOhMS7Ffx4fMieC
	 FJbTue+OwMcC1qB7BmEgBNOG1AoagPGXxEsfPZ9NrLlO+gFWRihLaJoslPUSD+U7Xp
	 wB2imKsBZusnIpYMsZ5GSFqzKb1CJIpWswpBaC/S1aHE+1q+UWHSKHXB8QKcVzFDW0
	 g3Tpf919omcpPL5zM306dfznyVYa4ltiF5mLW0ZDzDqlcXljUyFOzkg/Zzxyr06NW8
	 0mGfueWK3QyHg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5451VqXxA3359505
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 09:31:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 09:31:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 09:31:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux@treblig.org>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert"
	<linux@treblig.org>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
In-Reply-To: <20250425235340.288340-2-linux@treblig.org>
References: <20250425235340.288340-1-linux@treblig.org> <20250425235340.288340-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c92a8101-e8fe-4727-9f85-e1e96ef5392c@RTEXMBS04.realtek.com.tw>
Date: Mon, 5 May 2025 09:31:53 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> rtl_usb_resume() and rtl_usb_suspend() are trivial stubs that were
> added in 2011's
> commit 2ca20f79e0d8 ("rtlwifi: Add usb driver")
> but aren't wired up anywhere (though commit 442888c706e9 ("rtlwifi:
> rtl8192cu: Add routines dm, fw, led and sw")  added commented
> out assignments).
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

3 patch(es) applied to rtw-next branch of rtw.git, thanks.

d559636e382a wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
2d867b18eb93 wifi: rtlwifi: Remove uncalled stub rtl*_phy_ap_calibrate
406dac790c25 wifi: rtlwifi: Remove unused rtl_bb_delay()

---
https://github.com/pkshih/rtw.git


