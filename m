Return-Path: <linux-wireless+bounces-15217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC69C6295
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0231F23833
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDFD218D7C;
	Tue, 12 Nov 2024 20:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="ElWnp6yW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C72185B3
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443395; cv=none; b=O/uMgnEsEkpkpqut6leeF2E3tsEXE5iRygu+Lxv1haZls6QuyjUXqoe/91TpHiCIIjHLWT7oq+Yr2C6IxkYv/VvGyMKiVSAD3803AOd+ciCKD8y/yO/4q3NM1Z+4iMA53lfaK+22nKueDrf2F7coeAB404qSuf71D2Xb79qG+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443395; c=relaxed/simple;
	bh=QxRKYQVqbAmRALwOjSZYmG18JSk0pW3AtOi87IeEqYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UzdoGa/MskNlKqkfhLeULjCTAzjeW4xTBDSyJp2WRoBf3y6IbudXtCf22vAIAhuSjyEoIypbHh4UecQ4lqCqqBIgoc6M91Ko7t+ilE0WxAIb0OBSKs62V8D747m31K/jwjlc10MH3ycF8iV40S5V2zGD4N/SKjI2VE6kbyz8Lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=ElWnp6yW; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1731443390; bh=QxRKYQVqbAmRALwOjSZYmG18JSk0pW3AtOi87IeEqYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ElWnp6yW4x627PW/AMjj7lKWW6ZcvqytIItBbMG0RpJMszuj+49Jlrn7LvkFVuP+F
	 elUeZ1EY7i5QZfKfbL5YqX2r/Gj9DwNy2DW1jezYKtvg/MV18Xx8hZq3DW74Bm3gcd
	 ycKIyNtfjySnLZhlT0NLlHgGeNfNELJnVR2rSISHXmX2L1TVKACoqqYguFZtxaXPfo
	 DnR3aDzabNbuxL5yhxLKFHymG7igKUmVJqTkloArtscYngm0pOoTnXpetL9mirUzqc
	 zj2jj0/6egAWEIEikof+Me56u3g5hBryo1qpnlC1dkmZn7XmqdwFxNq3HLUvOdpm/i
	 qtqznRzuvtepE5Iji8zBN5Dy5yW09jf/vzEGStOXSVb7PwJFOs5SbDz3kpHo2ewDgo
	 SjGsE9rH+lOE1NJCZhJy543JhrlnD2GO83/ee7H6nkpbpE5Q0FtQ+ZNMdPzXgSh8jt
	 kq/QCVjvoYDGqlMDDwt+mQTjsQrcjza7D5Ma5vdalOQ26dHfaDn3oJXPSvoSW1EHeU
	 fkgDmfKB7xpc+s9Tqtwtfw6I7pu1jpFznh3WNLYQUYeb1+1DNvrsXaonaGltjicCdz
	 xctEA7eS04yQb3ZOrLwjinDGnvrCduTfzQ5RqrvbzSsHfg6WECO+xilT/IUIdepHci
	 AeMatceTIjmWc5pwcDNWYpPU=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 5C5FF18DEE7;
	Tue, 12 Nov 2024 21:29:50 +0100 (CET)
Message-ID: <4737329a-6d7d-4244-92f0-3ec4849f5893@ijzerbout.nl>
Date: Tue, 12 Nov 2024 21:29:47 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] wifi: rtw88: Add rtw8821a.{c,h}
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <435af284-0794-48e0-81a5-5a88b3c454bf@gmail.com>
 <37218648-ada7-4fad-b7bd-d2aee28cefb9@gmail.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <37218648-ada7-4fad-b7bd-d2aee28cefb9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 30-10-2024 om 19:28 schreef Bitterblue Smith:
> These contain code specific to RTL8821AU.
>
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> v2:
>   - Patch is new in v2.
>   - All of this used to be in patch 18/20 in v1.
>   - Use "k < 3" instead of "k <= 2" in the IQK code.
>   - Replace some while loops with for loops in the IQK code.
>   - Use rtw_write8 instead of rtw_write8_mask in
>     rtw8821a_coex_cfg_ant_switch. The mask was 0xff.
>   - Constify structs/arrays.
>
> v3:
>   - No change.
>
> v4:
>   - No change.
> ---
>   drivers/net/wireless/realtek/rtw88/rtw8821a.c | 1197 +++++++++++++++++
>   drivers/net/wireless/realtek/rtw88/rtw8821a.h |   10 +
>   2 files changed, 1207 insertions(+)
>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
>   create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
>
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821a.c b/drivers/net/wireless/realtek/rtw88/rtw8821a.c
> [...]
> +		for (cal_retry = 0; cal_retry < 10; cal_retry++) {
> +			/* one shot */
> +			rtw_write32(rtwdev, REG_IQK_COM64, 0xfa000000);
> +			rtw_write32(rtwdev, REG_IQK_COM64, 0xf8000000);
> +
> +			mdelay(10);
> +
> +			rtw_write32(rtwdev, REG_RFECTL_A, 0x00000000);
> +
> +			for (delay_count = 0; delay_count < 20; delay_count++) {
> +				iqk_ready = rtw_read32_mask(rtwdev,
> +							    REG_IQKA_END,
> +							    BIT(10));
> +
> +				/* Originally: if (~iqk_ready || delay_count > 20)
> +				 * that looks like a typo so make it more explicit
> +				 */
> +				iqk_ready = true;
This looks a bit suspicious. Why ignore the result from rtw_read32_mask()?
What do you mean by "Originally ... so make it more explicit"?
> +
> +				if (iqk_ready)
> +					break;
> +
> +				mdelay(1);
> +			}
> +
> +			if (delay_count < 20) {
> +				/* ============TXIQK Check============== */
> +				tx_fail = rtw_read32_mask(rtwdev,
> +							  REG_IQKA_END,
> +							  BIT(12));
> +
> +				/* Originally: if (~tx_fail) {
> +				 * It looks like a typo, so make it more explicit.
> +				 */
> +				tx_fail = false;
This also looks suspicious. Again, why ignore the result of 
rtw_read32_mask()?
> +
> +				if (!tx_fail) {
> +					rtw_write32(rtwdev, REG_RFECTL_A,
> +						    0x02000000);
> +					vdf_x[k] = rtw_read32_mask(rtwdev,
> +								   REG_IQKA_END,
> +								   0x07ff0000);
> +					vdf_x[k] <<= 21;
> +
> +					rtw_write32(rtwdev, REG_RFECTL_A,
> +						    0x04000000);
> +					vdf_y[k] = rtw_read32_mask(rtwdev,
> +								   REG_IQKA_END,
> +								   0x07ff0000);
> +					vdf_y[k] <<= 21;
> +
> +					*tx0iqkok = true;
> +					break;
> +				}
> +
The next rtw_write32_mask()'s are dead code because of tx_fail = false
> +				rtw_write32_mask(rtwdev, REG_IQC_Y,
> +						 0x000007ff, 0x0);
> +				rtw_write32_mask(rtwdev, REG_IQC_X,
> +						 0x000007ff, 0x200);
> +			}
> +
> +			*tx0iqkok = false;
> +		}
> +	}
> +
>

