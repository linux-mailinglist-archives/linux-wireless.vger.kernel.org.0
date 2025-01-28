Return-Path: <linux-wireless+bounces-18076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C6EA20F80
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D13B7A2B00
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4351AF0B6;
	Tue, 28 Jan 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5kW4m5T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664501684AE
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084671; cv=none; b=Vo5qevh9QzANYShoNHhaE+hBzkLLctPVvC8viY2DN7YwXo0ZjdVT3jAffHprjMGHrn/fJaj/O6qhknkOmBYd1Nm4GXBJQNuNDUN3NvQdpVTinvP45h6XdXwuGQojeSSBf22VZksPnhHCIYF2Wjk4iHT5hIrOf+qOLXW1tGo54ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084671; c=relaxed/simple;
	bh=9NhEEJi8+ZjiYBFHRuvYtSltaovuG3Uec9fIMaaEmW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hqBfxBhyniHTjpQUh1Wd5jMXw/ufjgmnARcC+9BZ49mJk6nPCLVzdHw2Kyh/7UiaqffKsoUJMOon1XORuJ/gY2pyt0AHJ/QnWQaZNsXQLxzTx5B3oPkKFQpy49iqOgoQkd+F1u34qN/DxPSEhIXGEA4I3VYs1daBbRzPry9xLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5kW4m5T; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de59c1a0so3401593f8f.2
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 09:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738084668; x=1738689468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YOAa/qzp0c+N/R7MoQCwDoMAfuxAsjRzYXwyLz5skbo=;
        b=Y5kW4m5TWJy/ls6ExLKWH4nY3wKMKisSmtBjTFu74uKSezlX6OdM/XHBdx5bbpT6RQ
         AVC68Y00caKi+8jQyA65AJNdeRhH+XSURfcgJiWkxBKirshSPwecvfURtBrPx8EQIHZV
         LgQq/OJ2DxPoLOOC2dvMt4x+S7CHCLlY8CLVIEFR73dwO1A6NCbv4K9gn6c/7Ux+tAOc
         BcKBI7pVx8lonUSGGaiLGJRZmFhDrtU41FfQ7OYi7LDkAmoRFziC6M+HsbEyX5dya06D
         gKxNLpn5vdPQPm+9ZYvbusUn9YLPPJTDozonbZbXU2EV8r2Dd9opvcCwoJ4RETudETrY
         /K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738084668; x=1738689468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOAa/qzp0c+N/R7MoQCwDoMAfuxAsjRzYXwyLz5skbo=;
        b=HFskVeIZM4YLT7jsiQ6tIs83WTzxXnNanQuk9WiczlWdlZ0rTa6F5loBr367hy2+a3
         aUfFigLU4/F8h0w8ffXeyzicrKToICgw1k1mpgucd4syXdgIv1voBdkhVTI3ZS0M4lTR
         5mzbWwZOuQtdmm2jQkrlQosZLkVTJFmttcQqWXC+NZjgHjKEV4nLRSK9j/RYUaP0ZVPL
         CQ7NjWTTC7dJomiLdLJaf+04cSGdLWdYUkZVyk4U6ge97UXfLHjlK4f4fbziCNbKf1aY
         sMIK5I3xr+zLsq080SlwTsytKpGp5z7/PT46EeAINbJD52JNOJ0v6JzEChVfUrYhYFdV
         wPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpsjzsrP/ATWobIzGFyRCFT+VT0S2H2yO61Z3/5tTidarQ8syp5ViegT46/cjGL9sMCIj6UX+OiFdk1l9JjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNW2b/kc+VILbXLLEp8AnZaxNiRCsnOeEAlSIHpCm3wMrhhaeV
	O4AwXPDxnoL8f4EBYCmBDUB54I2V5Pd1lsv9HoGp42q+tE2CKUYigfkMYA==
X-Gm-Gg: ASbGnct+J0a0bUbQng523ITz+zmxoW1dwtQuMxVR+Ugj6zYF/1VUXBLtcbTMHvpUXZV
	yNBdKql+dFPEnSM6eR8yBJRnFQ77Iv0nPeNvR3rjQyNdpuAgLFhUkq8qKZrX8pMJr77H9tcoqcK
	+lY1i+3WFKFAFDyzFYk6BGGZ7ouxC73bjR6JIeGmgxR/dliQqSAIKfUN+845B1MmZ+1L0mMDcOC
	1cxVshGWs7EU/Rs1CBnrfRxXC+/RIhApnuGaeswK/lbtc7XjjZVfwdHwVPnLkMkDkso+cevuGGX
	uyNCKFwsM5qP4fgq+J6Ob6Y=
X-Google-Smtp-Source: AGHT+IGHWw5qLmYfpJVak2eKsZtsYmqbURHN0gY3R1kb7HOvS5oLbCuAKRUr3adQbmoP0GvxjHgwow==
X-Received: by 2002:a5d:6c66:0:b0:385:fae2:f443 with SMTP id ffacd0b85a97d-38bf57a91a1mr37655420f8f.34.1738084667310;
        Tue, 28 Jan 2025 09:17:47 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c418esm14826985f8f.95.2025.01.28.09.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 09:17:46 -0800 (PST)
Message-ID: <d80fe4e2-1e38-4e84-b169-8c2699d7c764@gmail.com>
Date: Tue, 28 Jan 2025 19:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
 <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
 <ca7380d8560046c4a2a2badde9302691@realtek.com>
 <d05ba9e5-d5e3-4761-bd1e-f7c2b63f5a36@gmail.com>
 <53740c9ec74a4aa0a5a3c51b895eb385@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <53740c9ec74a4aa0a5a3c51b895eb385@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/01/2025 07:52, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 27/01/2025 08:36, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> The existing code is suitable for chips with up to 2 spatial streams.
>>>> Inform the firmware about the rates it's allowed to use when
>>>> transmitting 3 spatial streams.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>>  drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
>>>>  drivers/net/wireless/realtek/rtw88/fw.h |  1 +
>>>>  2 files changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>>>> index 02389b7c6876..0ca1b139110d 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>> @@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
>>>>  {
>>>>         u8 h2c_pkt[H2C_PKT_SIZE] = {0};
>>>>         bool disable_pt = true;
>>>> +       u32 mask_hi;
>>>>
>>>>         SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
>>>>
>>>> @@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
>>>>         si->init_ra_lv = 0;
>>>>
>>>>         rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
>>>> +
>>>> +       if (rtwdev->chip->rf_tbl[RF_PATH_C]) {
>>>
>>> Using `efuse->hw_cap.nss >= 3` would be consistent with latter patch.
>>>
>>
>> I would like that, but nss is 2 when RTL8814AU is in USB 2 mode.
>> I assume this is to keep the current draw under the 500 mA limit
>> of USB 2.
>>
>> What about rtwdev->hal.rf_path_num >= 3 ? I don't remember why
>> I didn't do that.
> 
> I think `rtwdev->hal.rf_path_num >= 3` is suitable to initialize/configure
> hardware registers, because no matter USB 2 or 3 mode should be the same.
> 
> For this case (RA info), this is related to protocol, so I feel 
> `efuse->hw_cap.nss >= 3` is suitable, but I have not seen a patch to declare
> supported NSS in register_hw(), or I missed it? Or, without RA_INFO_HI,
> it gets abnormal rate to RTL8814AU in your test?
> 

You didn't miss it, that will be in part 3. You can see the code here:

https://github.com/lwfinger/rtw88/blob/21a3fa7ec11a0cbb3be14145f45cdca35c3d3217/rtw8814a.c#L82

I get a steady 300 Mbps even without RA_INFO_HI. The problem is only
cosmetic. Right after connecting to the AP the first C2H_RA_RPT comes
a bit later than usual, after the first CTRL-EVENT-SIGNAL-CHANGE, so
we see a TX rate of 0:

Jan 28 19:00:06 ideapad2 NetworkManager[504]: <info>  [1738083606.4996] manager: NetworkManager state is now CONNECTED_SITE
Jan 28 19:00:06 ideapad2 NetworkManager[504]: <info>  [1738083606.5003] device (wlp3s0f3u2): Activation: successful, device activated.
Jan 28 19:00:06 ideapad2 wpa_supplicant[1480]: wlp3s0f3u2: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-42 noise=9999 txrate=0
Jan 28 19:00:06 ideapad2 NetworkManager[504]: <info>  [1738083606.6020] manager: NetworkManager state is now CONNECTED_GLOBAL

With RA_INFO_HI the first C2H_RA_RPT comes at the normal time,
before the first CTRL-EVENT-SIGNAL-CHANGE:

Jan 28 19:09:44 ideapad2 NetworkManager[504]: <info>  [1738084184.2400] manager: NetworkManager state is now CONNECTED_SITE
Jan 28 19:09:44 ideapad2 NetworkManager[504]: <info>  [1738084184.2407] device (wlp3s0f3u2): Activation: successful, device activated.
Jan 28 19:09:44 ideapad2 wpa_supplicant[1480]: wlp3s0f3u2: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-44 noise=9999 txrate=780000
Jan 28 19:09:44 ideapad2 NetworkManager[504]: <info>  [1738084184.3810] manager: NetworkManager state is now CONNECTED_GLOBAL


