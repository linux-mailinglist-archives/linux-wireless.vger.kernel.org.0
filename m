Return-Path: <linux-wireless+bounces-3183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6356884AB63
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 02:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AEFB20A89
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6500C3FE4;
	Tue,  6 Feb 2024 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="n6MQR76J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A93FC2;
	Tue,  6 Feb 2024 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181758; cv=none; b=EnGmeCODMdEafZFmekkZZD2cXWyHH8hyZxluu+kcoAhx0tMm+ILxOUHU9O3mexcXKLGbt9w2ncmY7O1SK3kZh47ec+xqBB/KNHXC/X9nVnnfWrLoFONtXGqa3gt1g+H2FlSr7merUyFEpMnZ1LTF8UTXIxmZGQLalmqModiWW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181758; c=relaxed/simple;
	bh=nNftp9ph743X9d8nFNlesbB8RFWz8jdAbPVNRPEH30M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0DbG8WSjCBT0MVGFYOSPsCtZONqTuK5Tpd4zWJLT6O1oArbhriI5sYnAw2PrYHQug6G0X2rsZM3T+2y4nZ7b8hSEbD3q4L2+YYx/JsIy2TdfFtAQ7uFlfgwSc+bAoreuzOe9r5CNQL9Bf5nXDMAxlLSZjfb0jozyG9Xpm/4ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=n6MQR76J; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707181741; x=1707786541; i=fiona.klute@gmx.de;
	bh=nNftp9ph743X9d8nFNlesbB8RFWz8jdAbPVNRPEH30M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=n6MQR76JXuYbsiBJ0Ww++L0qOr8D6yIZgdze6aJxSsKIgh1hzep8nQPEsYOECFaM
	 ZCiEmJggsH2w74R0bkYjnb7DdOZerC9IbWEeYIjVreFjlkcBC6/4c0dc0BbDOaLZX
	 e8x6BRs+zzFDsdGpUYhlIxBiAVj052YbvIzxB0TZ/s7klzp2KBPzEudajb2GPDkS/
	 Kl1JkHezukvT9wpzJnPPfWWVwDHKwhYEhI63MugqXO5Jid0JbQSd8RBf2BIaHF3bU
	 NVrEaUgHlKevoiozP7vS5vedtHN3dyYVbjysLmDcToM4TOQprZZFS6yW1N8EecPFV
	 m6awLG7eLb26GEI1OA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.18.163]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1rIvxI3S3w-00L1xc; Tue, 06
 Feb 2024 02:09:00 +0100
Message-ID: <d122d08d-b364-449c-a959-3f40597b2e8e@gmx.de>
Date: Tue, 6 Feb 2024 02:08:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] wifi: rtw88: Add rtw8703b.h
Content-Language: en-US, de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-5-fiona.klute@gmx.de>
 <64e338d9e0dd43e69fa2e6e1dd3ecb2c@realtek.com>
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <64e338d9e0dd43e69fa2e6e1dd3ecb2c@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YKB6impyLBR8FTHof7rv68VmuL4gwFKxXhGuGY3gvq9jKpbxpBJ
 sIW9Lf+LlAn1mvcgZsvVYA8YHPAPmuMHKZyup+NjQ0Y6Dgb9BYtb2RooPNgg7zDL93G5ufb
 NnAj/fJgxLCrLIwQCuWd0ijQlRj7jQmiKSv6UmNL2DYZtMjw7eytmFLyxXce76tPvYCvIpa
 0QFNsJVjX7mBlutwRL9dQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JVXwh1Jnp/Y=;VXxb0j+iT3ZW/MznPRYLYlKiRJL
 G7K77n0Y2ZiTlHRySjLPJqUrGIfAMu4SjdFl6FAJnN0GVtuzaDBlxeSuRMfhhuesAxwwYzucP
 pVpCgo//UZyRmcgix3oqy15FQZeMvHl5th3z4cLd3clhKDXIizAHd7LoGEEZ4dMo0eM5gAiN/
 31h25cDLpc618eyWuGNWrvQrrRR867/05vaQUspYkw+/G4TsxdFxxBqY8u5SOrFe2B1zMmjKF
 qYRhACzNS6O2csYl6Ej9Q2N2hnwT3rLMoTRdcaage7z2TZ77RruyUS6M7piBuXpFReQ9gb9+Y
 scRGY7J3vzyN/cax4L5LCOsEp0sMEHkYkLi/y/+s0xs6a4O41Z9Xa8ovVNP3kfrnNsXy2l4OX
 q5/pbRM/G+xIqy2rGNJgbLCF7vcqe/dyyI7z91ky2lPbdYkEuORn0/qPICxUExA6thHFOS+4O
 67Jc6rHqXZDTgj+BXyKWc+ijSUM3lZqrvFE8gceLod3C2HImf2UT2dLu9HSqJKARtQv2QILvT
 Qe2MHPchsiF+YFqlvcoprJ+plzDLquelkjdKD2nqWXKs006wiR11w4GoqXeBzY8dMPCXWv6DQ
 xnIw74719LI0I8fofoJFQJcC4cBEb50ppCZWhctmGV6VHdZqyVPLAtgcP2AIWpHIDQ8njHFtP
 se1BC7YrJGhf+gGgW82Ib+p19c9AfsVD5zQ0wffnL5LnjgpyCH/YtBwNuxBvezvc7+IAcgZRZ
 vxGf3iVSUxev+hhnRkcPxHoVT+z+1TbQ5dsCUJwSKg/Q38BI5Or/qLOxI8AXtzxZEmMkE27al
 nlTlJ86Olqtw3zZm4wc9G3Ry/+25e2cvIU3iFp5hKalNM=

Am 05.02.24 um 03:24 schrieb Ping-Ke Shih:
>> -----Original Message-----
>> From: Fiona Klute <fiona.klute@gmx.de>
>> Sent: Friday, February 2, 2024 8:11 PM
>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>=
; linux-mmc@vger.kernel.org; Pavel
>> Machek <pavel@ucw.cz>; Ond=C5=99ej Jirman <megi@xff.cz>; Fiona Klute <f=
iona.klute@gmx.de>
>> Subject: [PATCH 4/9] wifi: rtw88: Add rtw8703b.h
>>
>> This is the main header for the new rtw88_8703b chip driver.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>>   drivers/net/wireless/realtek/rtw88/rtw8703b.h | 62 ++++++++++++++++++=
+
>>   1 file changed, 62 insertions(+)
>>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>> b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>> new file mode 100644
>> index 0000000000..f5ff23f2ee
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>> @@ -0,0 +1,62 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
>> +
>> +#ifndef __RTW8703B_H__
>> +#define __RTW8703B_H__
>> +
>> +extern const struct rtw_chip_info rtw8703b_hw_spec;
>> +
>> +/* phy status parsing */
>> +#define GET_PHY_STAT_AGC_GAIN_A(phy_stat)                             =
      \
>> +       (le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(6, 0)))
>
> We are planning to use struct and le32_get_bits() directly, so don't int=
roduce
> this old style anymore. An example is
>
> struct rtw8703b_phy_stat {
> 	__le32 w0;
> 	__le32 w1;
> 	...
> };
>
> #define RTW8703B_PHY_STAT_W0_AGC_GAIN_A GENMASK(6, 0)
>
> val_s8 =3D le32_get_bits(stat->w0, RTW8703B_PHY_STAT_W0_AGC_GAIN_A);

Sorry, of all your mails this one got stuck in the spam filter. This
answers my question about what you meant by struct style, I hadn't
thought of using __le types. I assume you'd still want to use
appropriately sized types/arrays for elements that are multiples of one
byte?

>> +
>> +#define GET_PHY_STAT_PWDB(phy_stat)                                   =
      \
>> +       le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(7, 0))
>> +#define GET_PHY_STAT_VGA(phy_stat)                                    =
      \
>> +       le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(12, 8))
>> +#define GET_PHY_STAT_LNA_L(phy_stat)                                  =
      \
>> +       le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(15, 13))
>> +/* the high LNA stat bit if 4 bit format is used */
>> +#define GET_PHY_STAT_LNA_H(phy_stat)                                  =
      \
>> +       le32_get_bits(*((__le32 *)(phy_stat) + 0x01), BIT(23))
>> +#define BIT_LNA_H_MASK BIT(3)
>> +#define BIT_LNA_L_MASK GENMASK(2, 0)
>> +
>> +#define GET_PHY_STAT_CFO_TAIL_A(phy_stat)                             =
      \
>> +       (le32_get_bits(*((__le32 *)(phy_stat) + 0x02), GENMASK(15, 8)))
>> +#define GET_PHY_STAT_RXEVM_A(phy_stat)                                =
      \
>> +       (le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(15, 8)))
>> +#define GET_PHY_STAT_RXSNR_A(phy_stat)                                =
      \
>> +       (le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(31, 24))=
)
>> +
>> +/* Baseband registers */
>> +#define REG_BB_PWR_SAV5_11N 0x0818
>> +/* BIT(11) should be 1 for 8703B *and* 8723D, which means LNA uses 4
>> + * bit for CCK rates in report, not 3. Vendor driver logs a warning if
>> + * it's 0, but handles the case.
>> + *
>> + * Purpose of other parts of this register is unknown, 8723cs driver
>> + * code indicates some other chips use certain bits for antenna
>> + * diversity.
>> + */
>> +#define REG_BB_AMP 0x0950
>> +#define BIT_MASK_RX_LNA (BIT(11))
>> +
>> +/* 0xaXX: 40MHz channel settings */
>> +#define REG_CCK_TXSF2 0x0a24  /* CCK TX filter 2 */
>> +#define REG_CCK_DBG 0x0a28  /* debug port */
>> +#define REG_OFDM0_A_TX_AFE 0x0c84
>> +#define REG_TXIQK_MATRIXB_LSB2_11N 0x0c9c
>> +#define REG_OFDM0_TX_PSD_NOISE 0x0ce4  /* TX pseudo noise weighting */
>> +/* is !=3D 0 when IQK is done */
>
> Is this comment for 0x0e90? move to rear of the line?

Yes, I'll do that.

>> +#define REG_IQK_RDY 0x0e90
>> +
>> +/* RF registers */
>> +#define RF_RCK1 0x1E
>> +
>> +#define AGG_BURST_NUM 3
>> +#define AGG_BURST_SIZE 0 /* 1K */
>> +#define BIT_MASK_AGG_BURST_NUM (GENMASK(3, 2))
>> +#define BIT_MASK_AGG_BURST_SIZE (GENMASK(5, 4))
>> +
>> +#endif /* __RTW8703B_H__ */
>> --
>> 2.43.0
>>
>


