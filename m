Return-Path: <linux-wireless+bounces-18047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE29A20179
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 00:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A773A4E40
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F618D626;
	Mon, 27 Jan 2025 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJasCqu8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBD2904
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019910; cv=none; b=MA7nuyavAioAQB0/4GHxO4YptS0S2vbxEIeOLXl5tvkEfhSerYpfSiBE0djwd6q29WncE52bfaT8iz7Wooow4iuIA0ulAjmnPPSGakqP1k+cwM1FUe3nhnktBgnTqbcpU4KINkYq6E8aa4QXk7m+SbTwpT050cM5KaDTo8hpvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019910; c=relaxed/simple;
	bh=aD780y9lxC+CIBZNqkhapFa/x14xmmHagYXZ8AsY2qE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=LrbYYp2u7RZnrfhS9n0pJlQB+Yq8UDNgDTUsaRF2Ms8MiSOU0ddq1WqQPKFECy6AZYizQbz5x1dcnkRrUwkOAJojabc1RLhWBpC9sZ+CfhzxBlBwrbBwPPiiQR/fqumvY8tXjQQRK3pLZkvQ9gdhBPKJACyelOLxPy8aMhkgcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJasCqu8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385eed29d17so2613189f8f.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 15:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738019907; x=1738624707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMO9C1pHVMehqArNZLu9gG29iNzauueUN9kvLnxUtBw=;
        b=DJasCqu8qTs8bqEBLd7xgEmQLX+ZzkQxlZWp7akXuvwrJwfu8PPRU6X682ZXE/Fj/d
         PRtWXt+FNrp2rRDmmmQNoOnNnGjjSVR/fW36bHF36ZuT26bFyeJarxw1iZ4F4vOG8xNN
         BMMTlzCEK3i3BXQsWaFaFrTHkdl+vYRLthCMGcWlUvTol5j+VsMdeyRTM0YJTrIfw8m6
         BcZSbm/1m+lZHPcEHJ6ynhIlfeLu8KL5G5NP4S9WGixQFCNi9g1E0/fg6q2QNogHa5KS
         EAdpdXOB/z0Ah4NI8ekN/dtFWP86uply4xBE85gs/W0FbYy54nW4F8rEAK7HqUx+Hgf4
         d2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738019907; x=1738624707;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMO9C1pHVMehqArNZLu9gG29iNzauueUN9kvLnxUtBw=;
        b=UYDeXih3IQkD98fF8keTw2x+UTJtCEVtsHqGGvhKCtOPSIk7rYa4K2Trjbty9TNKBc
         rpeZ/1c1WkBCR05dq/JXBX6ShfAb/hQG2nwCXqQTnqMtOoGoZ9KVzvKpvqyhqmEQQDFc
         X1JYvyIyLIp56xNYBJQ3QOjfaDkWFX5OpjOOEzHUIBKxwHgQV704otIu+sdBCarPRaxh
         mG4T6a1wtf7hgkz7BRmajaRu0mSmMt27dLjsGy6Tko49d3jwN0PLGyvUfw0Ze9Oc9HHi
         z0yG759TzX8qksGRyjcBZCy94/8E6eWchY8rlh4c0S9RMlRy86fCIQ76A1x6beE+PxnE
         zPXg==
X-Forwarded-Encrypted: i=1; AJvYcCVKh75uMidjx+j2QadBJIyaZovpziHrJRpQS5hn5wTJ6RoaivJ6ZfT+4HevgENps3EwnhrVaQluHbQbpq+4HA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8ucMZFq5dwLikTh+uaf9fz4OCAbKJAvvhW9AbGOx0A6093vQ
	vH3auHCn9h30RVHA9WYHvI68owjrMRFS06p3EdcShxm0S9OAI6IAMfua/w==
X-Gm-Gg: ASbGncsdfmxiAzpRRtq9OUF+cna/NVT80Hvs8TFSSEm56nec0cUedyZZq8eZR4BTLIp
	32k0EdGEm/M3xdwD1zXXfKkfdiSHKkty/CojwfMinmY2RAX86vvbbT8bzXUMzi0aceeNjyjPCO9
	17JDbPNyzkdsGfFskLQRUDfnhoxgFUbWvgusO20oX61+1sYZVxel6ruvXwSeI3i6wa61oxCpl7x
	Ukj47gxHTv7dbDfvrRHSFsKiNxameIFB+QHF8zpkPwpbjveepGMxuKQU+iut6u44o28PYZ2Wo1r
	N419+MLzcfC7
X-Google-Smtp-Source: AGHT+IGl8SoUavtALdzyPyatDE+A8w8kMmAigGNjCuN4FV68PiACBIVGdvlEHoaUbm1zPS6lg4bkrw==
X-Received: by 2002:a05:6000:2aa:b0:385:fc97:9c76 with SMTP id ffacd0b85a97d-38bf5654fc8mr40307299f8f.3.1738019907098;
        Mon, 27 Jan 2025 15:18:27 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c4199sm12101460f8f.89.2025.01.27.15.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 15:18:26 -0800 (PST)
Message-ID: <d05ba9e5-d5e3-4761-bd1e-f7c2b63f5a36@gmail.com>
Date: Tue, 28 Jan 2025 01:18:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
 <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
 <ca7380d8560046c4a2a2badde9302691@realtek.com>
Content-Language: en-US
In-Reply-To: <ca7380d8560046c4a2a2badde9302691@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/01/2025 08:36, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> The existing code is suitable for chips with up to 2 spatial streams.
>> Inform the firmware about the rates it's allowed to use when
>> transmitting 3 spatial streams.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
>>  drivers/net/wireless/realtek/rtw88/fw.h |  1 +
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>> index 02389b7c6876..0ca1b139110d 100644
>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>> @@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
>>  {
>>         u8 h2c_pkt[H2C_PKT_SIZE] = {0};
>>         bool disable_pt = true;
>> +       u32 mask_hi;
>>
>>         SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
>>
>> @@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
>>         si->init_ra_lv = 0;
>>
>>         rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
>> +
>> +       if (rtwdev->chip->rf_tbl[RF_PATH_C]) {
> 
> Using `efuse->hw_cap.nss >= 3` would be consistent with latter patch. 
> 

I would like that, but nss is 2 when RTL8814AU is in USB 2 mode.
I assume this is to keep the current draw under the 500 mA limit
of USB 2.

What about rtwdev->hal.rf_path_num >= 3 ? I don't remember why
I didn't do that.

>> +               SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO_HI);
>> +
>> +               mask_hi = si->ra_mask >> 32;
>> +
>> +               SET_RA_INFO_RA_MASK0(h2c_pkt, (mask_hi & 0xff));
>> +               SET_RA_INFO_RA_MASK1(h2c_pkt, (mask_hi & 0xff00) >> 8);
>> +               SET_RA_INFO_RA_MASK2(h2c_pkt, (mask_hi & 0xff0000) >> 16);
>> +               SET_RA_INFO_RA_MASK3(h2c_pkt, (mask_hi & 0xff000000) >> 24);
>> +
>> +               rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
>> +       }
>>  }
> 
> Prefer calling RA_INFO LO/HI in the same level. I meant
> 
> rtw_fw_send_ra_info()
> {
>         rtw_fw_send_ra_info_lo(); // original RA info
>     
>         if (efuse->hw_cap.nss <= 2)
>                 return;
> 
>         rtw_fw_send_ra_info_hi();
> }
> 


