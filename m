Return-Path: <linux-wireless+bounces-4300-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE2486E5B1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852E5B21A72
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539416FF40;
	Fri,  1 Mar 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="CvM8YO8i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A61FAB;
	Fri,  1 Mar 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310950; cv=none; b=eka0XZdKonWhDVXTeJEDnyQ/4bpQTj/uN9yPEaqEgBqMPjjaYgO6JIkQPg/Sb7PrXOkO4B8mGJ6SBHbhjQ/DfA+x/7MekEDmCouth+Lvrd8dyrXwe3xjYg0XMspi0XoIqptlZw29xij6oM3oZsZOKQz4rDvMnTnZGsTvAxvlSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310950; c=relaxed/simple;
	bh=RuFu5qT5bSNPnSU95/TeXe7JmP945VbQoKMPKNPXVtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkKLCOJnkDxMfXDs7/rDxRaWAnc3czL1HIPnH2FLXBAJOE7QFp0RT4Sel+3JSBjKyA8wKr7YBS0S9GVpBIuQVrEJ8uDoA2sxOTzWL7WpfTTKt9pzMzgpRhhbj9gyLO1i3PLolmtrURubhTUao1Dmch9tsXOgeC+yqdvNShPG+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=CvM8YO8i; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709310933; x=1709915733; i=fiona.klute@gmx.de;
	bh=RuFu5qT5bSNPnSU95/TeXe7JmP945VbQoKMPKNPXVtw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=CvM8YO8i0/yV3zHajx2lFdwz1wYwCymsc4ONZ67Ew9Cc9yUtlCRLzFBm31M92qwd
	 VMbZRwxvOHRce4+lwSTQvVsGsITDgYkoaBe78kgyi0LPJ8y5aQ+SvlqcEtKDt9OP+
	 cYYMX8UBQq7AXScSKSUobTEJR/x7pSjHqoikTu9OQCme7XztxOxbQec7FWy626W1N
	 vNC6jF6YApJ6ye/H+05yE8gRQ2oIYbRm7QembVZVlYSwTnhS4WhEunKIBeP90cOrH
	 Mo4IAlaXbHdwkUMmKt6ArIr/OTDvArUbr5SQ00viKxOe2gPRXwpykE6DqbFqkfpby
	 8PSRSrZsqDmMcR8J5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.26.244]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIx3I-1rQDfT2GL4-00KR9a; Fri, 01
 Mar 2024 17:35:33 +0100
Message-ID: <db9e7f0d-a60f-467b-82df-da6170d02151@gmx.de>
Date: Fri, 1 Mar 2024 17:35:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Content-Language: en-US, de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz" <megi@xff.cz>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-5-fiona.klute@gmx.de>
 <368ebc04c2ec436791a27b5661189783@realtek.com>
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <368ebc04c2ec436791a27b5661189783@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fly4DCvxUxdviREPXEV579g8/uqkqnH9LlkCgLsGcNMhheWxmWj
 Il5i6I8494VrfYFPs9WTtUbBuEU1Fl5Xk4pVcso8KZUzJbi3QRMg3/60JiB2RFkon+twgXA
 RfHjcmAXFH57wOgaTH9ufVSsKBjoQ1qvkM6zBdfOIL4QPuEQYvTu85sGJRyjdhr6eFJa3po
 7z1f0OSyGKQ7hAWWjyp+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bX+6Ku/gxMQ=;ywOOhIGdjzVq5s6REff41GB6uo7
 tKGkaVlhoP+f+50sonzHToEmMxLQQVmZp/iFS9U1fZYsIzCzhMdh056I03CBNdWwnzD2gHikm
 Voc2P23BrgZyWkFzVobC2YxCLXo7PH8xbMI7VJY+rcQPk5imsYTVEXpdMswNVtocvbFBI00o6
 X/fLBd3JVgC0+zrZak8JTSElUcSX0VghZqA/4AaLjqXxxgRF6XlEaniliaX9mPap/XtebX/aF
 wontkA7xXucqm0kybxl75BLe1gXnH26/qiiKDCFO5TeJsweF4UbwBcipDaZEc3XL5oFCCaNti
 Vij+lqcHv6O0JEoIGGkMvc99ytt2e8qmXtzNYB+4CRbLibcAhpzKMY7DjNACPGWP4/98n7Q19
 5LFq54hCq/FjXirEbWtlON2Y32nh4pCU//rE/OsTrPvCQpr8HDAU0Gmhgf4j9l+FEatXJ1jAh
 ub7cFWsr0Hf+duuvXXbQz8ZprATAPsb3hg87U4I31XiE28TY3VGAxxBPMsXdiwUygoj4qXxEp
 SD4A+oLkSSxk6UON0KOuYc1Dd9TtdDQiKaSG2HRFaikqvhufA7pngBSdLo/AVzYVpupOS64Jz
 zeju+LhvWWVjhzPdBfIe5yriwDOZnPHyoBoKlSN5hTcPGGBlo2pnemIpDwGuT/w7192ngVl5Y
 5GZmpar/SYcgiiGDHO3b0bC8Sm2UFfc8YpwVJzKSRVw04v+8bmPzIiZPZY4Akv8E24vgq08x9
 ypTgLTqpHl6thV4QwThYQ3uEj06AwEe9YrfwVIEymEJ7xMgz7ffDP1b2pdMcFulhbq81QcoWS
 NbuOHms5iuQDPFf6rCxgSvg/5Crsx602/VEFYwSmH5x6M=

Am 01.03.24 um 03:09 schrieb Ping-Ke Shih:
>> -----Original Message-----
>> From: Fiona Klute <fiona.klute@gmx.de>
>> Sent: Wednesday, February 28, 2024 7:55 AM
>> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org; ulf.hansson@lin=
aro.org; linux-mmc@vger.kernel.org;
>> pavel@ucw.cz; megi@xff.cz
>> Subject: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
>>
>> This is the main header for the new rtw88_8703b chip driver.
>>
>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>> Tested-by: Pavel Machek <pavel@ucw.cz>
>> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
>> ---
>>   drivers/net/wireless/realtek/rtw88/rtw8703b.h | 103 +++++++++++++++++=
+
>>   1 file changed, 103 insertions(+)
>>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>> b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>> new file mode 100644
>> index 00000000000..69dac101d33
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
>> @@ -0,0 +1,103 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
>> +
>> +#ifndef __RTW8703B_H__
>> +#define __RTW8703B_H__
>> +
>> +#include <linux/types.h>
>> +#include <linux/compiler_attributes.h>
>
> Removing these two headers can still compiled pass in my side. Please ch=
eck why
> you need them.

If I remove them whether the code compiles depends on the order of
#includes. If some other header that includes those two is included
before rtw8703b.h it works, otherwise it will break. I don't think
that's desirable, though other rtw88 headers already behave that way
(e.g. main.h must be included before the others). Also, clangd will
complain about undefined types (u8, s8), which is less important but
still annoying when working on the code. So I'd prefer to keep the include=
s.

> By the way, rtw8723d.h does
>     #include "rtw8723x.h"
>
> Can we use the same stuff?

I don't think so. The vendor driver has different code paths: With 8723D
it takes one for "PHYSTS_2ND_TYPE_IC" [1], with 8703B the one for
"ODM_IC_11N_SERIES" a few lines below. For those "2nd type" ICs there
are different structs depending on the page number
(phy_sts_rpt_jgr2_type[0-2]), while the "11N series" ones always use
phy_status_rpt_8192cd (all defined in [2]).

However, the mainline rtlwifi driver has an equivalent struct called
"phy_status_rpt" in
drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h. I don't know if
sharing such definitions between different drivers is desirable. If yes,
please let me know where the header should go.

[1]
https://xff.cz/git/linux/tree/drivers/staging/rtl8723cs/hal/phydm/phydm_ph=
ystatus.c?h=3Dorange-pi-6.7#n3142
[2]
https://xff.cz/git/linux/tree/drivers/staging/rtl8723cs/hal/phydm/phydm_ph=
ystatus.h?h=3Dorange-pi-6.7

>> +
>> +extern const struct rtw_chip_info rtw8703b_hw_spec;
>> +
>> +/* phy status parsing */
>> +#define VGA_BITS GENMASK(4, 0)
>> +#define LNA_L_BITS GENMASK(7, 5)
>> +#define LNA_H_BIT BIT(7)
>> +/* masks for assembling LNA index from high and low bits */
>> +#define BIT_LNA_H_MASK BIT(3)
>> +#define BIT_LNA_L_MASK GENMASK(2, 0)
>> +
>> +struct phy_rx_agc_info {
>> +#ifdef __LITTLE_ENDIAN
>> +       u8 gain: 7;
>> +       u8 trsw: 1;
>> +#else
>> +       u8 trsw: 1;
>> +       u8 gain: 7;
>> +#endif
>> +} __packed;
>
> This struct is quite simple, or I will suggest to define MASK and access=
 them
> by u8_get_bits(), like
>
> #define RX_AGC_GAIN GENMASK(6, 0)
> gain =3D u8_get_bits(RX_AGC_GAIN, raw);
>
> Then,
> struct phy_status_8703b {
> 	u8 path_agc[2];
> 	...
>
> Just for reference. You can decide if changing to this style.
>
>> +
>> +/* This struct is called phy_status_rpt_8192cd in the vendor driver,
>> + * there might be potential to share it with drivers for other chips
>> + * of the same generation.
>> + */
>> +struct phy_status_8703b {
>> +       struct phy_rx_agc_info path_agc[2];
>> +       u8 ch_corr[2];
>> +       u8 cck_sig_qual_ofdm_pwdb_all;
>> +       /* for CCK: bits 0:4: VGA index, bits 5:7: LNA index (low) */
>> +       u8 cck_agc_rpt_ofdm_cfosho_a;
>> +       /* for CCK: bit 7 is high bit of LNA index if long report type =
*/
>> +       u8 cck_rpt_b_ofdm_cfosho_b;
>> +       u8 reserved_1;
>> +       u8 noise_power_db_msb;
>> +       s8 path_cfotail[2];
>> +       u8 pcts_mask[2];
>> +       s8 stream_rxevm[2];
>> +       u8 path_rxsnr[2];
>> +       u8 noise_power_db_lsb;
>> +       u8 reserved_2[3];
>> +       u8 stream_csi[2];
>> +       u8 stream_target_csi[2];
>> +       s8 sig_evm;
>> +       u8 reserved_3;
>> +
>> +#ifdef __LITTLE_ENDIAN
>> +       u8 antsel_rx_keep_2: 1;
>> +       u8 sgi_en: 1;
>> +       u8 rxsc: 2;
>> +       u8 idle_long: 1;
>> +       u8 r_ant_train_en: 1;
>> +       u8 ant_sel_b: 1;
>> +       u8 ant_sel: 1;
>> +#else /* __BIG_ENDIAN */
>> +       u8 ant_sel: 1;
>> +       u8 ant_sel_b: 1;
>> +       u8 r_ant_train_en: 1;
>> +       u8 idle_long: 1;
>> +       u8 rxsc: 2;
>> +       u8 sgi_en: 1;
>> +       u8 antsel_rx_keep_2: 1;
>> +#endif
>> +} __packed;
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
>> +#define REG_IQK_RDY 0x0e90  /* is !=3D 0 when IQK is done */
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


