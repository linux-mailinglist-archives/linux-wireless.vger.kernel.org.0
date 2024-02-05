Return-Path: <linux-wireless+bounces-3162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985C784A6AF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F72B28C828
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29CB4CB41;
	Mon,  5 Feb 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="OlfCKssz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37A4F202;
	Mon,  5 Feb 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159990; cv=none; b=g6mUpLIfTesWV8rW5LR8s9UXxWDLXZAD889iFZYJ0nv8bFFbpnLfcxsmdatpjEkZHo+trGqutTqOEmvvUc5gnLtlo6IItfsGrejb8Nl/ZorB4577ypIAJHaxwJjuq4iVVjrABnkJBSq3xdiWA5rqFgvp9L1zV0eV8KJkPgx1Nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159990; c=relaxed/simple;
	bh=dYMg0BIjZVwZozAi7TyBSonClXcqLIrHYkmpEu9mwmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9yGVLuwWjCFAo33P8SJCU6TZeZ1rwsFp0rWwMQWB0rIveRQBm3xjyW79f8g7uQCL+ErlCJ34XO6chDQ+GY8MAkpU5Gzs1tmDkfYNd7BEcCPF4BirCPjFnQ/Jlf3Z7jkVWZNmfNvUMVJ37BJhKDdHA6GhNIK/gHcwLpKjI1XXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=OlfCKssz; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707159973; x=1707764773; i=fiona.klute@gmx.de;
	bh=dYMg0BIjZVwZozAi7TyBSonClXcqLIrHYkmpEu9mwmo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=OlfCKsszF4oDois+Pp7TDg9ihfUvInc0SJsqHl7YooKCuPpUlxn/q3UowlSB8qIs
	 RggJYG22oVjfqHjPzJt+aSxLcZO5dZ5rbuDsuX6uHCnT9/NeBxYhwtrA1TvNATBcv
	 yWUkk5fABdBWKhiaJxdt065MPiO169nc+XsU7iPL/iOh2+osIfL1ujoE/C1A+v5Ha
	 j3eD7lA2/xes1q+m5A/HaAdFK7Tg6hrmkoRndYduqFBbx/x4B8BpgTy19EiRHeYG/
	 pMo0gKNuBOkEXqPddA7T07WIekGJ4mbVcfHkHaudCClsrHDTJf/b2GBpJ3WOLSmnS
	 Db3iI7ammiqGVLm3fA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.18.163]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1qw6rW14Wp-017GXm; Mon, 05
 Feb 2024 20:06:13 +0100
Message-ID: <09d93cef-5338-4463-b656-dab934029c63@gmx.de>
Date: Mon, 5 Feb 2024 20:06:11 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] wifi: rtw88: Add rtw8703b.c
Content-Language: de-DE, en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-6-fiona.klute@gmx.de>
 <8b20f91585694702bac414680ba937c9@realtek.com>
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <8b20f91585694702bac414680ba937c9@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:s5Dm3cjAG5zp3MAFZZo+9iempFPIdZPwz5aAxwvAIa10mR8eFV+
 81lM+Lh0fB40fxxd8yLdrBAeX9PjdLxjL+2touu3zpcARSU9qPA9HMeSRbUPYpruYTdkd2J
 foBustK8ZNxYF0lmvdUN/biB9xj5tZ10KPx1E/pQYmCAHJcsqf535vESCFcu8SPc02gmRtk
 NOjDWlGY1cnDclOyViCOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l+ZbVGbNKY0=;ogV8kcSWzOsl+IIHPY0WoYN9pqG
 Zr0YfGsFnS7sGzVVkP1vUsaZfWMhXpK9u5wSDK0dbxbfGggQS+7QmDntav87ZTBPcdua5duBG
 fHZUvvvgWKKlayW8cNuLa9GIBWMlYxrCKi+fCutNtzhwGkh/Gwwq+cUjTWgpIOLo7FELZcaVj
 Zks6tFx3vJyKC+A6iy0edB1rs9CR1XpskBwBANz0YUMv6807Gh2pEfY8/+wpFoWwzusJYmr5E
 ZS1fP2s/IGskxZoe7LvQVIBuGm8NczzQ/Q1RkyWdrLrDru6YGCuyoSa+o5nGvDzL+QF3HrhsJ
 4VmgkyCNtdB77krmX2hhlxH5klR+gke8DDCTRsuPQFXkdd8UxGujosYEKzVno4V0ST/tksUXl
 TA2TAWIfNlTVzmuNjjeZWAbwEqhKBWSWEpBHWBxduA1IF6mPwyOWfkYN6fi8XBuOL6HwYRA5K
 dERt5u+YKwW5zCcCUzjjrofXGlZvSC33dyLDo0am/8oy0QBop1jDoc2JekGlVP4P7DiKlm3iJ
 DKGaUC190CuoJZ/XIZxGXDc8ulf4vgdZRomUO+Ciwim9ju3SJ4mBCDogrlhFJbZa0HVSy7Ofy
 pA7Rp+XKDQFMI7XEwnsyh/coJhTEKCUWx3tHPwiFbitZ1ADzHnaae3BWtBwvLT4tIzW6hf625
 495bzdcr8RGx9En22tRGbiyqhAy96XsmZup1dKFZ0HGPTqarSofT0mQT8hXpNXWeGLghRWfZy
 OELtGvuHdAzMDN1Yt+WJ5Ob2YUsq1Cuuv+LNoIDd+XlLrAy577DkSXohpIjLeA9KqexBPCAfm
 p1GnarXmn4elnQgw0BDMo9yKrR8xgaME3EBIqjH4Xj9Fo=

Am 05.02.24 um 04:01 schrieb Ping-Ke Shih:
>> -----Original Message-----
>> From: Fiona Klute <fiona.klute@gmx.de>
>> Sent: Friday, February 2, 2024 8:11 PM
>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>=
; linux-mmc@vger.kernel.org; Pavel
>> Machek <pavel@ucw.cz>; Ond=C5=99ej Jirman <megi@xff.cz>; Fiona Klute <f=
iona.klute@gmx.de>
>> Subject: [PATCH 5/9] wifi: rtw88: Add rtw8703b.c
>>
>> This is the main source for the new rtw88_8703b chip driver.
>>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>>
>> rtw8703b_read_efuse retrieves the MAC address from DT, if
>> available. The code is not tied to any particular hardware, but
>> required to get a persistent address on the Pinephone. Do I need to
>> add a DT binding for this? Also, I think this could be moved into
>> rtw_chip_efuse_info_setup(), in preference to falling back to a random
>> MAC if there isn't a valid one in EFUSE. Would that be acceptable? If
>> yes, should EFUSE or DT take priority?
>>
>> All the RTL8723CS EFUSE samples I've seen so far contain almost
>> entirely invalid data (all 0xff, except rtl_id, afe, and
>> thermal_meter), so I've added fallbacks in the EFUSE parser. In some
>> cases they alter specific bits so parsing in rtw_chip_efuse_info_setup
>> will get the right results. I'm not sure if this is the best approach:
>> The good part is that it works without changing the core EFUSE code,
>> the negative is that it's not visible to the core code that a fallback
>> has been applied. What do you think?
>
> I think efuse take priority, but you have said most are invalid data, so
> you can write a rule to determine efuse is valid before using them. If
> invalid, just use DT.

That's no problem, I could use is_valid_ether_addr() like
rtw_chip_efuse_info_setup() in main.c already does. That's why I'm
wondering if it'd make sense to move getting the MAC from DT to there,
and use MAC from EFUSE, DT, or random in that order of preference for
all rtw88 devices.

> Sorry, I'm not familiar with DT, could you show me an example of DT node=
?

I'm afraid I'm not familiar with the details either, but this is how the
SDIO wifi device for the Pinephone is defined (in
arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi, as of v6.8-rc2):

&mmc1 {
	pinctrl-names =3D "default";
	pinctrl-0 =3D <&mmc1_pins>;
	vmmc-supply =3D <&reg_vbat_wifi>;
	vqmmc-supply =3D <&reg_dldo4>;
	bus-width =3D <4>;
	non-removable;
	status =3D "okay";

	rtl8723cs: wifi@1 {
		reg =3D <1>;
	};
};

As far as I understand the "reg =3D <1>;" line implies that the bootloader
can provide some setup (like the MAC address). I hope someone with more
knowledge can correct me or add missing details.

>>   drivers/net/wireless/realtek/rtw88/rtw8703b.c | 2106 ++++++++++++++++=
+
>>   1 file changed, 2106 insertions(+)
>>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> new file mode 100644
>> index 0000000000..ac9b1bf6ea
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
>> @@ -0,0 +1,2106 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
>> +
>> +#include <linux/of_net.h>
>> +#include "main.h"
>> +#include "coex.h"
>> +#include "debug.h"
>> +#include "mac.h"
>> +#include "phy.h"
>> +#include "reg.h"
>> +#include "rx.h"
>> +#include "rtw8703b.h"
>> +#include "rtw8703b_tables.h"
>> +#include "rtw8723x.h"
>> +
>> +#define GET_RX_DESC_BW(rxdesc)                                        =
      \
>> +       (le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(31, 24)))
>
> use struct and le32_get_bits() directly.

Do you mean to create a struct to represent the RX descriptor and then
use le*_get_bits() on the fields to get the values? I could try, but I'd
have to replace all the other GET_RX_DESC_* macros defined in rx.h (and
shared by the other chip drivers), too, or it won't really make a
difference (more below).

[...]

>> +
>> +       if (ret !=3D 0)
>> +               return ret;
>> +
>> +#ifdef CONFIG_OF
>> +       /* Prefer MAC from DT, if available. On some devices like the
>> +        * Pinephone that might be the only way to get a valid MAC.
>> +        */
>> +       struct device_node *node =3D rtwdev->dev->of_node;
>
> Should move this statement to topmost of this function? no compiler warn=
ing?
>
> Or, make an individual function to read mac addr from DT?

I can move that to a separate function if you prefer, see below for the
compiler warning.

>> +
>> +       if (node) {
>> +               ret =3D of_get_mac_address(node, efuse->addr);
>> +               if (ret =3D=3D 0) {
>> +                       rtw_dbg(rtwdev, RTW_DBG_EFUSE,
>> +                               "got wifi mac address from DT: %pM\n",
>> +                               efuse->addr);
>> +               }
>> +       }
>> +#endif /* CONFIG_OF */
>> +
>> +       /* If TX power index table in EFUSE is invalid, fall back to
>> +        * built-in table.
>> +        */
>> +       u8 *pwr =3D (u8 *)efuse->txpwr_idx_table;
>> +       bool valid =3D false;
>
> I tend to move these declaration to top of this function too, but not su=
re why
> compiler also doesn't warn this in my side. Seemingly kernel changes def=
ault
> compiler flags?

Yes, I learned about that while working on this driver. First the move
to gnu11, and then removing -Wdeclaration-after-statement with
b5ec6fd286dfa466f64cb0e56ed768092d0342ae in 6.5. The commit message says
"It will still be recommeneded [sic!] to place declarations at the start
of a scope where possible, but it will no longer be enforced", so I'll
move these up.

For the struct device_node pointer I think it makes sense to leave the
declaration within the #ifdef CONFIG_OF section (unless we restructure
that into a separate function) because it's unused otherwise.

[...]

>> +static void rtw8703b_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc=
,
>> +                                  struct rtw_rx_pkt_stat *pkt_stat,
>> +                                  struct ieee80211_rx_status *rx_statu=
s)
>> +{
>> +       struct ieee80211_hdr *hdr;
>> +       u32 desc_sz =3D rtwdev->chip->rx_pkt_desc_sz;
>> +       u8 *phy_status =3D NULL;
>> +
>> +       memset(pkt_stat, 0, sizeof(*pkt_stat));
>> +
>> +       pkt_stat->phy_status =3D GET_RX_DESC_PHYST(rx_desc);
>> +       pkt_stat->icv_err =3D GET_RX_DESC_ICV_ERR(rx_desc);
>> +       pkt_stat->crc_err =3D GET_RX_DESC_CRC32(rx_desc);
>> +       pkt_stat->decrypted =3D !GET_RX_DESC_SWDEC(rx_desc) &&
>> +                             GET_RX_DESC_ENC_TYPE(rx_desc) !=3D RX_DES=
C_ENC_NONE;
>> +       pkt_stat->is_c2h =3D GET_RX_DESC_C2H(rx_desc);
>> +       pkt_stat->pkt_len =3D GET_RX_DESC_PKT_LEN(rx_desc);
>> +       pkt_stat->drv_info_sz =3D GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
>> +       pkt_stat->shift =3D GET_RX_DESC_SHIFT(rx_desc);
>> +       pkt_stat->rate =3D GET_RX_DESC_RX_RATE(rx_desc);
>> +       pkt_stat->cam_id =3D GET_RX_DESC_MACID(rx_desc);
>> +       pkt_stat->ppdu_cnt =3D 0;
>> +       pkt_stat->tsf_low =3D GET_RX_DESC_TSFL(rx_desc);
>
> Could you add a separate patch to convert these macros to struct style?
> It is fine to keep as it was, and do this conversion afterward.

In principle yes, but as I mentioned above I'd basically have to
reinvent all the definitions from rx.h to make it work, I'm not sure if
that really simplifies things. If you want to refactor those I think
it'd be best to do it for all chip drivers together.

The GET_PHY_STAT_* macros are a different matter. The PHY status
structure is different between 8703b and the other supported chips, so
those could be replaced with a struct without duplication. Or at least
mostly, some elements are bit fields or values with < 8 bits, where I
think a macro is simpler than a struct with different definitions
depending on endianess. I am worried about introducing an endianess
error though, so I'd have to ask for careful review of such a patch.

[...]

>> +MODULE_FIRMWARE("rtw88/rtw8703b_wow_fw.bin");
>
> Just curious. Have you tried WOW for this chip?

Kind of. It definitely doesn't work with this code, that's why I haven't
filled wowlan_stub yet. I already know the check if WOW has been enabled
would have to be changed in wow.c (I'd probably add a "legacy" function
like for the firmware download), but there must be some other details
because I couldn't get it to work yet. But others got it to work with
the out-of-tree driver, so it must be possible.

I've applied the other minor changes you suggested.


