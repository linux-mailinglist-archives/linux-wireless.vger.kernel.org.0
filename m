Return-Path: <linux-wireless+bounces-21825-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B6A95DC5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 08:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1433D3B7E24
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153471E9B3B;
	Tue, 22 Apr 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BdLIPs3M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23231DE8B3;
	Tue, 22 Apr 2025 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302165; cv=none; b=Dcne53oAGkWdCrcfFYlMW0COCpC4PC8Nb4sYDv1iHVFMRCWF7ZBmBZINIk3E2tbIwn0yi0YB9X0DZxwYVR8ZmnnbRF+rKK9c834nX2YGFrozEZ18sFwZv0/MZsY7QXWEyXLXJsv473hEEzsb9negbXNisSDV6bYQ92R/BIGMHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302165; c=relaxed/simple;
	bh=IwA39pqV6CL+2rcWfGOdsnRR0Msq/kLwxa8WtIp/xQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUVCqNt5okSCspDkIhDwDscbDcTBqU0ZKh5V3cv/d1YTAIso1u4KjjAKwQAFkFeTI+fjazO+d1WaNLCZRMvfwgeC137veRN5zcZsDp4ZEbtgrDsys38q0pdX7QGTNEOHR8WVWY70neSy0DxBDXcIKGqiZTTknpeCNbefnKv2t5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BdLIPs3M; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M68KPJ0085015, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745302101; bh=IwA39pqV6CL+2rcWfGOdsnRR0Msq/kLwxa8WtIp/xQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BdLIPs3MgCEHKfbl9AXuW+Cu+GE59wmxlB1CncZCBr/XmZZN5KEkyQhSMkxvm2F93
	 vHmtW9xtoed9jf/g0jOYd4bFleoVhdFl/N9+9d9unNLssEmg8ryEGtMFRyOVgtDf6X
	 TN2EgW3r6X/scQmyqTZSdoUtCiiFIZKVXprQWweRWoUFUBJvxQUQJZbSASnBIe8iDZ
	 W2h4Po6CDFjz/+bmTs92m3kEoDJQ79VKCPbIWjfojecTcmUYG0ZervkLkhAbc+1HSa
	 b9nSBQ7YLMIWl8PRqZBy6h0CLatBJey9qWky8M8qd1Nf4Dr2TKHbf1nhwLp+H3yB2m
	 qKrn9CDUvIkcg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M68KPJ0085015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 14:08:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 14:08:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 22 Apr 2025 14:08:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 22 Apr 2025 14:08:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingcong Bai <jeffbai@aosc.io>
CC: Kexy Biscuit <kexybiscuit@aosc.io>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Liangliang Zou <rawdiamondmc@outlook.com>,
        "John W.
 Linville" <linville@tuxdriver.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "open list:REALTEK WIRELESS DRIVER (rtlwifi family)"
	<linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723
Thread-Topic: [PATCH rtw-next] wifi: rtlwifi: disable ASPM for RTL8723BE with
 subsystem ID 11ad:1723
Thread-Index: AQHbszW7c9+Tjxh0Ckyy3/cPdXvVgrOvByag
Date: Tue, 22 Apr 2025 06:08:20 +0000
Message-ID: <1ab6f74b5b9d4f0d8023eb43d41906be@realtek.com>
References: <20250422032132.348598-1-jeffbai@aosc.io>
In-Reply-To: <20250422032132.348598-1-jeffbai@aosc.io>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Mingcong Bai <jeffbai@aosc.io> wrote:
>=20
> RTL8723BE found on some ASUSTek laptops, such as F441U and X555UQ with
> subsystem ID 11ad:1723 are known to output large amounts of PCIe AER
> errors during and after boot up, causing heavy lags and at times lock-ups=
:
>=20
>   pcieport 0000:00:1c.5: AER: Correctable error message received from 000=
0:00:1c.5
>   pcieport 0000:00:1c.5: PCIe Bus Error: severity=3DCorrectable, type=3DP=
hysical Layer, (Receiver ID)
>   pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=3D0000000=
1/00002000
>   pcieport 0000:00:1c.5:    [ 0] RxErr
>=20
> Disable ASPM on this combo as a quirk.
>=20
> This patch is a revision of a previous patch (linked below) which
> attempted to disable ASPM for RTL8723BE on all Intel Skylake and Kaby Lak=
e
> PCIe bridges. I take a more conservative approach as all known reports
> point to ASUSTek laptops of these two generations with this particular
> wireless card.
>=20
> Please note, however, before the rtl8723be finishes probing, the AER
> errors remained. After the module finishes probing, all AER errors would
> indeed be eliminated, along with heavy lags, poor network throughput,
> and/or occasional lock-ups.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")

This Fixes is weird to me. The subject is RTL8192CE, but you are adding thi=
s
for RTL8723BE. More, at that time, HARDWARE_TYPE_RTL8723BE isn't defined ye=
t.

This might be more suitable?

Fixes: a619d1abe20c ("rtlwifi: rtl8723be: Add new driver")

> Reported-by: Liangliang Zou <rawdiamondmc@outlook.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218127
> Link: https://lore.kernel.org/lkml/05390e0b-27fd-4190-971e-e70a498c8221@l=
wfinger.net/T/
> Tested-by: Liangliang Zou <rawdiamondmc@outlook.com>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>  drivers/net/wireless/realtek/rtlwifi/pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wir=
eless/realtek/rtlwifi/pci.c
> index 0eafc4d125f9..898f597f70a9 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> @@ -155,6 +155,16 @@ static void _rtl_pci_update_default_setting(struct i=
eee80211_hw *hw)
>             ((u8)init_aspm) =3D=3D (PCI_EXP_LNKCTL_ASPM_L0S |
>                                 PCI_EXP_LNKCTL_ASPM_L1 | PCI_EXP_LNKCTL_C=
CC))
>                 ppsc->support_aspm =3D false;
> +
> +       /* RTL8723BE found on some ASUSTek laptops, such as F441U and
> +        * X555UQ with subsystem ID 11ad:1723 are known to output large
> +        * amounts of PCIe AER errors during and after boot up, causing
> +        * heavy lags, poor network throughput, and occasional lock-ups.
> +        */
> +       if (rtlpriv->rtlhal.hw_type =3D=3D HARDWARE_TYPE_RTL8723BE &&
> +           (rtlpci->pdev->subsystem_vendor =3D=3D 0x11ad &&
> +            rtlpci->pdev->subsystem_device =3D=3D 0x1723))
> +               ppsc->support_aspm =3D false;
>  }
>=20
>  static bool _rtl_pci_platform_switch_device_pci_aspm(
> --
> 2.49.0
>=20


