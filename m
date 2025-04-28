Return-Path: <linux-wireless+bounces-22120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890EAA9E938
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 09:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3596189B99E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF5C1D54E9;
	Mon, 28 Apr 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GblMsCOI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C24A00;
	Mon, 28 Apr 2025 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825045; cv=none; b=a87br7M5dXxqtmyPo3XMiO+0FpaD6fdn9gCN+MD/0vUaFxhJjKBn3o3pmP1AS5s2mkVwJ9WFFpF7yCxXGeWFZiC29t0H1tfk5r8M5ITuIeg6P2FDPfn0XosUqaaItkjNMHPFCrgsC/NpPj+/CCwgX98Lr4RAokN1H6AyN/nRemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825045; c=relaxed/simple;
	bh=TTX5/45iPOhYm2FPDqk1S3zuQrLTJXMpfmpEbPNn+XA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=AstE5neeHZPvGHiSOi2sdXbOngCrz2/g11NyEASgWQ46LgUaHZEkRCvO24djsJN5QdmDlpwJel2MSWoFOLlKfFsfZHtAYASxbUdpDlcfzsibEVVyLwI0AhK4PYZE/oWMiXtlMseCYZ9AfTsC/M4J2iCPT04u11DifRgodLqqzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GblMsCOI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53S7MxwA61728456, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745824979; bh=TTX5/45iPOhYm2FPDqk1S3zuQrLTJXMpfmpEbPNn+XA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=GblMsCOI5wDUaaD9ZNjGcP3tmIjfyXhEvkaNK1PsSHUQBoesH/s6fv7tqmaAy/bmn
	 9W1nJvYdCAjakXLr5emJvPClvdgoP7GJSuJpKOZ7TdsvTjFnexh2JJDxewU0pQ655+
	 sIccn1w2ywFsT8LjVqOVVC03VIbWRohAARwF5tn34L0uLa01doaTSAAP8SckpV3m2W
	 Trs0rry4cpZeARhqErSMKU+mSCbwKoSBHrOIUP8aydCXV0whXMZ07EykwXyW+Mbnq2
	 smLfmN6RydAiiU9TCp3/kMeobhJYcm1vcRcvAmaxqaCWjxxV8gcx0B9klAXBhnkdHI
	 48UF6rs5dRyKw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53S7MxwA61728456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:22:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 15:22:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 15:22:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingcong Bai <jeffbai@aosc.io>, Ping-Ke Shih <pkshih@realtek.com>
CC: Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>,
        <stable@vger.kernel.org>, Liangliang Zou <rawdiamondmc@outlook.com>,
        "Larry
 Finger" <Larry.Finger@lwfinger.net>,
        "John W. Linville"
	<linville@tuxdriver.com>,
        "open list:REALTEK WIRELESS DRIVER (rtlwifi
 family)" <linux-wireless@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rtw-next v2] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723
In-Reply-To: <20250422061755.356535-1-jeffbai@aosc.io>
References: <20250422061755.356535-1-jeffbai@aosc.io>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <d12c14c2-c883-47af-a747-fe26594753c2@RTEXMBS04.realtek.com.tw>
Date: Mon, 28 Apr 2025 15:22:57 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Mingcong Bai <jeffbai@aosc.io> wrote:

> RTL8723BE found on some ASUSTek laptops, such as F441U and X555UQ with
> subsystem ID 11ad:1723 are known to output large amounts of PCIe AER
> errors during and after boot up, causing heavy lags and at times lock-ups:
> 
>   pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
>   pcieport 0000:00:1c.5: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
>   pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
>   pcieport 0000:00:1c.5:    [ 0] RxErr
> 
> Disable ASPM on this combo as a quirk.
> 
> This patch is a revision of a previous patch (linked below) which
> attempted to disable ASPM for RTL8723BE on all Intel Skylake and Kaby Lake
> PCIe bridges. I take a more conservative approach as all known reports
> point to ASUSTek laptops of these two generations with this particular
> wireless card.
> 
> Please note, however, before the rtl8723be finishes probing, the AER
> errors remained. After the module finishes probing, all AER errors would
> indeed be eliminated, along with heavy lags, poor network throughput,
> and/or occasional lock-ups.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: a619d1abe20c ("rtlwifi: rtl8723be: Add new driver")
> Reported-by: Liangliang Zou <rawdiamondmc@outlook.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218127
> Link: https://lore.kernel.org/lkml/05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net/T/
> Tested-by: Liangliang Zou <rawdiamondmc@outlook.com>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

77a6407c6ab2 wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

---
https://github.com/pkshih/rtw.git


