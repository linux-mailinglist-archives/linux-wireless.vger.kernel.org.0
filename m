Return-Path: <linux-wireless+bounces-3139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7769F849FC0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFAE1C208DF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D333CF6A;
	Mon,  5 Feb 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="ogjpCz0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C53CF4B;
	Mon,  5 Feb 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151668; cv=none; b=YedILifuMtpl+7x4JNcL6AFo8ONnFwPpXzOxaGDWwIz8j1Ip5Q1KU8lMwPQaH17jEcMc5y+WrbJVN3uMZFgLDw597RYEF465d3Lq0L0naAB2IGNB/l/Qv7OqleKMGOmyMf8DklE5CoGbgFao0s1N0ZWtzLkg4iRLjZGo3lAtXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151668; c=relaxed/simple;
	bh=bo3HQwApf0/5rgYzToEQzOKEI2pgeLRw1q5w0CK+n0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsfdOSVYmP29GS4B8gZFPKgcXWVPv+38JvEpDRnE8EgxayYXjytdQudrW4JdQSN66dpWv0OirbglvpWPupboYDgaGbWpe1f34oy0wSRtXAtwICjLn6n6OKbYckw8McYQCT4LyuR1DkGRxJz9Iz9QzD7zVPt7RI7APGfejbziTJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=ogjpCz0w; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707151650; x=1707756450; i=fiona.klute@gmx.de;
	bh=bo3HQwApf0/5rgYzToEQzOKEI2pgeLRw1q5w0CK+n0U=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ogjpCz0wvaO4Iu3WnaydlqHCC7GbOiZuAbUE6yw8t9fJEsUC3yH7ZJCnIicbolDs
	 WZQ4Dn45gtUjgn6gMvPgfS00ojvuRtvGclRl1h44pExjv33jMbyuUpMxi8ufeL8eS
	 TL3HULKsJ6pu5TOOf9hkWMMZR+T+ZN+igBREgwQi1QGh2yJOlmL1DXMfwfL70FZYE
	 8Vmpi5qlctTN7JEWpKx6+0w3B3oIxiRtNCTR69BGpHRoKTseQGzcwuHN1tVA+hMVf
	 BYjnikdNIkHXqXKFkSXxatZpqX6rpFWPC0l7w4qlAzrN2ItyIlgfPs+5aragAaYSl
	 77yXQs2NKD8D7Rp6Vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.18.163]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1rIofN3o2W-00Kvsy; Mon, 05
 Feb 2024 17:47:30 +0100
Message-ID: <080d2209-151c-4493-93bb-8fddd51f0e1b@gmx.de>
Date: Mon, 5 Feb 2024 17:47:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-2-fiona.klute@gmx.de>
 <ef2a9567a01642a99eb20d67269713e2@realtek.com>
Content-Language: en-US, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <ef2a9567a01642a99eb20d67269713e2@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WcfgcZXDsfAPwakWcVMs7k9qX9PZtj/NFAl1i/yN/B526E3Yd/X
 LYPrg1ExEIXNFKAkt08hsU/CjMVMDXHAKiN9hldM93AExYFG6BZJKcCpjGtvKaYpAvvse46
 qSAT8tBzRqS9+mc4E40B7SNeiDfkn2yBI1p5jlGT7nxfM/82E+E+J1XzV6SiBf6aCzrOxys
 JvlBiC5d7M9b3V4b7UN9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nLDgcOe3LCs=;P0Idmh9/uX0q0jX/ha+bqGOhDEW
 EQLxvFP9rSvemuF6+unXZ+AvoLlXDztRJGbH4yd7ZqFIkqcQcEjPybYCdZdc2sbdSeviC1F1b
 ZRL33L3YtBF1sIMz/7h9HGe38cDrZw/BUX6uS7MbL/Md9zBle4tJCjjo2SUZKsZ8XoROmmnu6
 K3tsO5BudJnkzZF6NK2HIFLgs5qSpe/ahEjI/e0A4S+/6oXefTNDl9P7Lz7b1BNRmr5UQGiUP
 QVhnyfLGhqKVTbAI5I/5BcFnbtJjl2tmoqhtsig1yB4ozAb41A2gFOsEsDKOrTQJjf/Fina88
 kEjXh1cVP1DqNa5mRkkUVU5nfKVlZDgQvSYF7TGkHJA6Ipt4W9oY97nLfg3nPS4mhOBzLMU/v
 NWJ1SHm602o8Ur5Tgj2K++DmRlsUJrQtb+N1nwUTYHNS6tT5sQtkDjMAcP8rhj0pk2piJeAzC
 P8qrz9Bz89PGKo4ed+ZBuQmjehDmhG2afcl4k638U3Wwv7wxjkrIheHAEpZ5QngLpu0YNLu1n
 ce3ePRGTJKaCXP6YZjEysCrj3DKXKvHy75vqBVHHny6JOKYEM4aHe/yXw6kGPOYT/UXooL1YG
 xMAEez4BkZinjw5F7FKLgK84jMIEsjf8CkoQIt4lR5H298crvwhdbcyrHY4Umra0Ia4RC96Vv
 UUFsigjiBEpk30x6qzWwYkr3g55aM+FXppY0JUlhQHtX/sVzKTNlzrKny6dV+3yA8N4qkkFIQ
 2CdYH6OS+bccHSGh2xhT8O3xohOrv6PZaHck/87Z4cVhP1PGzpn7Ws/EjqkB44dSLwuB59LZ8
 5UmcXyX+R0UIRVhCfyiKWugSmjNO2/xhbPr/+YEBa7knU=

Am 05.02.24 um 02:45 schrieb Ping-Ke Shih:
>> -----Original Message-----
>> From: Fiona Klute <fiona.klute@gmx.de>
>> Sent: Friday, February 2, 2024 8:11 PM
>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>=
; linux-mmc@vger.kernel.org; Pavel
>> Machek <pavel@ucw.cz>; Ond=C5=99ej Jirman <megi@xff.cz>; Fiona Klute <f=
iona.klute@gmx.de>
>> Subject: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
>>
>> The already supported 8723d chip is very similar to 8703b/8723cs,
>> split code that can be shared into a new module. The spec definition
>> tables are combined into a struct so we only need one EXPORT_SYMBOL
>> for them all.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>> I'm not sure how who should be MODULE_AUTHOR in rtw8723x.c. Most of
>> the code is from rtw8723d, I created the separate module. I don't want
>> to claim authorship over code I didn't write, but assigning authorship
>> unasked (by copying the MODULE_AUTHOR from rtw8723d.c) also seems
>> wrong.
>
> If two MODULE_AUTHOR are allowed, maybe list both?

I just checked the macro documentation, it says to use multiple
MODULE_AUTHOR for multiple authors, so I'll do that. :-)

> [...]
>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
>> index c575476a00..68245f34b5 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
>
> [...]
>
>> @@ -930,6 +532,8 @@ static u8 rtw8723d_iqk_check_rx_failed(struct rtw_d=
ev *rtwdev,
>>          return 0;
>>   }
>>
>> +#define IQK_LTE_WRITE_VAL 0x0000ff00
>> +
>>   static void rtw8723d_iqk_one_shot(struct rtw_dev *rtwdev, bool tx,
>>                                    const struct rtw_8723d_iqk_cfg *iqk_=
cfg)
>>   {
>> @@ -937,7 +541,7 @@ static void rtw8723d_iqk_one_shot(struct rtw_dev *r=
twdev, bool tx,
>>
>>          /* enter IQK mode */
>>          rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, =
EN_IQK);
>> -       rtw8723d_iqk_config_lte_path_gnt(rtwdev);
>> +       rtw8723x_iqk_config_lte_path_gnt(rtwdev, IQK_LTE_WRITE_VAL);
>
> It would be better to discriminate IQK_LTE_WRITE_VAL_8723D and
> IQK_LTE_WRITE_VAL_8703B to prevent misreading.

Good point, I'll do that. Same for the ADDA_ON_VAL.

>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
>> new file mode 100644
>> index 0000000000..2b58064547
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
>> @@ -0,0 +1,561 @@
>
> [...]
>
>> +const struct rtw8723x_common rtw8723x_common =3D {
>> +       .iqk_adda_regs =3D {
>> +               0x85c, 0xe6c, 0xe70, 0xe74, 0xe78, 0xe7c, 0xe80, 0xe84,
>> +               0xe88, 0xe8c, 0xed0, 0xed4, 0xed8, 0xedc, 0xee0, 0xeec
>> +       },
>> +       .iqk_mac8_regs =3D {0x522, 0x550, 0x551},
>> +       .iqk_mac32_regs =3D {0x40},
>> +       .iqk_bb_regs =3D {
>> +               0xc04, 0xc08, 0x874, 0xb68, 0xb6c, 0x870, 0x860, 0x864,=
 0xa04
>> +       },
>> +
>> +       .ltecoex_addr =3D {
>> +               .ctrl =3D REG_LTECOEX_CTRL,
>> +               .wdata =3D REG_LTECOEX_WRITE_DATA,
>> +               .rdata =3D REG_LTECOEX_READ_DATA,
>> +       },
>> +       .rf_sipi_addr =3D {
>> +               [RF_PATH_A] =3D { .hssi_1 =3D 0x820, .lssi_read    =3D =
0x8a0,
>> +                               .hssi_2 =3D 0x824, .lssi_read_pi =3D 0x=
8b8},
>> +               [RF_PATH_B] =3D { .hssi_1 =3D 0x828, .lssi_read    =3D =
0x8a4,
>> +                               .hssi_2 =3D 0x82c, .lssi_read_pi =3D 0x=
8bc},
>> +       },
>> +       .dig =3D {
>> +               [0] =3D { .addr =3D 0xc50, .mask =3D 0x7f },
>> +               [1] =3D { .addr =3D 0xc50, .mask =3D 0x7f },
>> +       },
>> +       .dig_cck =3D {
>> +               [0] =3D { .addr =3D 0xa0c, .mask =3D 0x3f00 },
>> +       },
>> +       .prioq_addrs =3D {
>> +               .prio[RTW_DMA_MAPPING_EXTRA] =3D {
>> +                       .rsvd =3D REG_RQPN_NPQ + 2, .avail =3D REG_RQPN=
_NPQ + 3,
>> +               },
>> +               .prio[RTW_DMA_MAPPING_LOW] =3D {
>> +                       .rsvd =3D REG_RQPN + 1, .avail =3D REG_FIFOPAGE=
_CTRL_2 + 1,
>> +               },
>> +               .prio[RTW_DMA_MAPPING_NORMAL] =3D {
>> +                       .rsvd =3D REG_RQPN_NPQ, .avail =3D REG_RQPN_NPQ=
 + 1,
>> +               },
>> +               .prio[RTW_DMA_MAPPING_HIGH] =3D {
>> +                       .rsvd =3D REG_RQPN, .avail =3D REG_FIFOPAGE_CTR=
L_2,
>> +               },
>> +               .wsize =3D false,
>> +       },
>> +
>> +       .lck =3D __rtw8723x_lck,
>> +       .read_efuse =3D __rtw8723x_read_efuse,
>> +       .mac_init =3D __rtw8723x_mac_init,
>> +       .cfg_ldo25 =3D __rtw8723x_cfg_ldo25,
>> +       .set_tx_power_index =3D __rtw8723x_set_tx_power_index,
>> +       .efuse_grant =3D __rtw8723x_efuse_grant,
>> +       .false_alarm_statistics =3D __rtw8723x_false_alarm_statistics,
>> +       .iqk_backup_regs =3D __rtw8723x_iqk_backup_regs,
>> +       .iqk_restore_regs =3D __rtw8723x_iqk_restore_regs,
>> +       .iqk_similarity_cmp =3D __rtw8723x_iqk_similarity_cmp,
>> +       .pwrtrack_get_limit_ofdm =3D __rtw8723x_pwrtrack_get_limit_ofdm=
,
>> +       .pwrtrack_set_xtal =3D __rtw8723x_pwrtrack_set_xtal,
>> +       .coex_cfg_init =3D __rtw8723x_coex_cfg_init,
>> +       .fill_txdesc_checksum =3D __rtw8723x_fill_txdesc_checksum,
>> +};
>> +EXPORT_SYMBOL(rtw8723x_common);
>
> I think these are just copy-and-paste stuff. Is there anything special y=
ou want
> me look deeper?

It should be just copy-and-paste. If you (or anyone else reading this)
have the opportunity to test with an 8723D device to make sure I didn't
make any mistake that breaks things there that'd be great.

>> +
>> +MODULE_AUTHOR("Fiona Klute <fiona.klute@gmx.de>");
>> +MODULE_DESCRIPTION("Common functions for Realtek 802.11n wireless 8723=
x drivers");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h
>> b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
>> new file mode 100644
>> index 0000000000..d3930f1f2c
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
>
> [...]
>
>
>> +/* IQK helper functions, defined as inline so they can be shared
>> + * without needing an EXPORT_SYMBOL each.
>> + */
>> +inline void
>
> These inline functions should be 'static'.
> (I believe you have addressed this, and will change them by v2.)

Yes, that was what broke building the driver into the kernel (not as a
module) as reported by Pavel Machek.

>> +rtw8723x_iqk_backup_path_ctrl(struct rtw_dev *rtwdev,
>> +                             struct rtw8723x_iqk_backup_regs *backup)
>> +{
>> +       backup->btg_sel =3D rtw_read8(rtwdev, REG_BTG_SEL);
>> +       rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] original 0x67 =3D 0x%x\n",
>> +               backup->btg_sel);
>> +}
>> +
>
> [...]
>


