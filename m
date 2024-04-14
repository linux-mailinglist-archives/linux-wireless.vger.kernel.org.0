Return-Path: <linux-wireless+bounces-6291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103868A44AD
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C581C20DC6
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Apr 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207EA29B0;
	Sun, 14 Apr 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw1yPGfP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0B3B297
	for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120421; cv=none; b=EXTfoxKtsvI5CJHUYbzU1WafsgOV2rQE1m0EWxQK+QjceR9GUtVdsI7/XV6BinvtMa91CnxkNROaZ7RFO0qYoHPcnQVXoRYPT7nWYqxzdtP3bJ3pRAPU8MPa4xDZVzF6siAQU0u8/VBZRKA6A8WR2rE9bLSXAWQ0hwx8Er5zWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120421; c=relaxed/simple;
	bh=pqhGJtwQslFbUGpNxpYTU7oibYu424G03kMktrgJYfo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bfe26xmmxmwMHkVvqgZhq11K6yGXqiFzdDUS3W78T6LelKc+/y+lSfKVLpgyyW/42AirUBKQfgfpAW76m76rsSWnfTcQWC1fwue6gmoMuAyKbxc0RSjaa0u1oX6l/YGIX/0QZykNY3QayYt/5TKKZSJ5jFIDFh8JYYs8VKGcDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw1yPGfP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343cfe8cae1so1848136f8f.3
        for <linux-wireless@vger.kernel.org>; Sun, 14 Apr 2024 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713120418; x=1713725218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hydkhOGT8jdQaHPQIeaulKD0dZycs+e8hAzFTAWHVhM=;
        b=Iw1yPGfPkR4+KEuFHVHoBE5He0ELloQl06mEiCNXdgECJia0D/RWbYWJjqBtYoj7SQ
         Z81MmnKrv3lA2QTqJDhliWFVSupX+dQ34uiezRAKkcmfUIkX63JLmNryzNeaNUcaqCav
         wW7gfBtGlqlu4rVv+EIHPskMjckyn9Mg5glcl5vFIuXpiNHAv1F03EQJbbzdxl5IMDjH
         ZOH6OCwuiJsSkX1nRFHRYsOCIAGgDVtYBKh0FBCg5HXquu4+ipGzPPgUVjkcNiyt5pjh
         egNT/Zjv6LZhKpShOqKAbh10KtKL1kIh0iHdJtOmeGZrCbt42pBvJyb1blc77+W111BK
         wQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713120418; x=1713725218;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hydkhOGT8jdQaHPQIeaulKD0dZycs+e8hAzFTAWHVhM=;
        b=Trk9lCm/5aqBzTX/lvexFyFYAf3qhN0+vBtBlSvjdNxDSohxaV1Z0RRQ6uWA8lR1Mr
         zLHDG3tlRzNAByaszWgZQ5u5qDvIKFbNHcOZf4ZO6SxYM+4mJFjVIerNdveEIFOh+FtS
         HOcwDTAPMt1d2lA5R+ENvIC/kU2t5Mqwm1ZqvoPmAwbBsm+ENh/bA5e3Nkf7yvl12HGQ
         NETdoXTDxeNgvic2axcd8jaNfUFMwTdAOOYI7DIXog5Z+SkJoobrlhq2nBIQNK9Df40Y
         1xupglBYZ3jNjHc916VxGg8Xd25X15tezXaZ4zZfluWLlhxHUGMUd48JelQ2zsL0s3Wv
         35lg==
X-Forwarded-Encrypted: i=1; AJvYcCWooLsrYnNb8ZbceQNMCvp57fFZrqmBY2htCT1u4x2WCc7SGKmNXpevAmhK/wiVo5OqvnZoaG8WHDdby4jVNDrXFsrxkHzq7yWVkXr9Cws=
X-Gm-Message-State: AOJu0YyAofdpyJEA/uy9KyGTxJ9bjFkhS/qg8e8YV5IY1HSs6opoxWa2
	oGXn+2XDvgsqZZaEc5+HiHsl9JqEaKGIOdClTXo5QVLcEuS2QOdW9FWjfKMz
X-Google-Smtp-Source: AGHT+IGW6m/9Xgrod2LOp0q3EGHXCQHRteAOWlqLvPply7dhgz2tJ3ivRUQWtSvdc9NMjtVGVJl76g==
X-Received: by 2002:a05:6000:178e:b0:346:f850:c21f with SMTP id e14-20020a056000178e00b00346f850c21fmr6337261wrg.0.1713120417496;
        Sun, 14 Apr 2024 11:46:57 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id l11-20020adffe8b000000b00343d504d7afsm9722222wrr.30.2024.04.14.11.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 11:46:57 -0700 (PDT)
Message-ID: <601c4f3c-8069-48ea-aae8-b1e814eba283@gmail.com>
Date: Sun, 14 Apr 2024 21:46:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v4 03/14] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
 <6e18882f-3da3-4c17-8bce-4ebffe022713@gmail.com>
 <c2956068d98142e3b527f1faa94ce2aa@realtek.com>
Content-Language: en-US
In-Reply-To: <c2956068d98142e3b527f1faa94ce2aa@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 11:22, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> 
>>
>> Create the new module rtl8192d-common and move some code into it from
>> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
>> (USB) can share some of the code.
>>
>> This is mostly the code that required little effort to make it
>> shareable. There are a few more functions which they could share, with
>> more changes.
>>
>> Add phy_iq_calibrate member to struct rtl_hal_ops to allow moving the
>> TX power tracking code from dm.c.
>>
>> The other changes in this patch are adjusting whitespace, renaming some
>> functions, making some arrays const, and making checkpatch.pl less
>> unhappy.
>>
>> rtl8192de is compile-tested only. rtl8192d-common is tested with the
>> new rtl8192du driver.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/Kconfig
>> b/drivers/net/wireless/realtek/rtlwifi/Kconfig
>> index 9f6a4e35543c..2319eaa8845a 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/Kconfig
>> +++ b/drivers/net/wireless/realtek/rtlwifi/Kconfig
>> @@ -37,6 +37,7 @@ config RTL8192SE
>>  config RTL8192DE
>>         tristate "Realtek RTL8192DE/RTL8188DE PCIe Wireless Network Adapter"
>>         depends on PCI
>> +       select RTL8192D_COMMON
>>         select RTLWIFI
>>         select RTLWIFI_PCI
>>         help
>> @@ -142,6 +143,11 @@ config RTL8192C_COMMON
>>         depends on RTL8192CE || RTL8192CU
>>         default y
>>
>> +config RTL8192D_COMMON
>> +       tristate
>> +       depends on RTL8192DE
>> +       default y
>> +
> 
> Existing RTL8723_COMMON also uses both 'depends on' and 'select', which are
> mutual reference, so I think choosing only one of them would be better.
> 
>>  config RTL8723_COMMON
>>         tristate
>>         depends on RTL8723AE || RTL8723BE
> 

I'm not sure about this. Isn't there a good reason why the
"common" drivers do it this way?

[...]
 
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
>> new file mode 100644
>> index 000000000000..467e285280dc
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h
> 
> [...]
> 
>> +struct rx_fwinfo_92d {
>> +       u8 gain_trsw[4];
>> +       u8 pwdb_all;
>> +       u8 cfosho[4];
>> +       u8 cfotail[4];
>> +       s8 rxevm[2];
>> +       s8 rxsnr[4];
>> +       u8 pdsnr[2];
>> +       u8 csi_current[2];
>> +       u8 csi_target[2];
>> +       u8 sigevm;
>> +       u8 max_ex_pwr;
>> +       u8 ex_intf_flag:1;
>> +       u8 sgi_en:1;
>> +       u8 rxsc:2;
>> +       u8 reserve:4;
>> +} __packed;
>> +
>> +struct rx_desc_92d {
>> +       u32 length:14;
>> +       u32 crc32:1;
>> +       u32 icverror:1;
>> +       u32 drv_infosize:4;
>> +       u32 security:3;
>> +       u32 qos:1;
>> +       u32 shift:2;
>> +       u32 phystatus:1;
>> +       u32 swdec:1;
>> +       u32 lastseg:1;
>> +       u32 firstseg:1;
>> +       u32 eor:1;
>> +       u32 own:1;
>> +
>> +       u32 macid:5;
>> +       u32 tid:4;
>> +       u32 hwrsvd:5;
>> +       u32 paggr:1;
>> +       u32 faggr:1;
>> +       u32 a1_fit:4;
>> +       u32 a2_fit:4;
>> +       u32 pam:1;
>> +       u32 pwr:1;
>> +       u32 moredata:1;
>> +       u32 morefrag:1;
>> +       u32 type:2;
>> +       u32 mc:1;
>> +       u32 bc:1;
>> +
>> +       u32 seq:12;
>> +       u32 frag:4;
>> +       u32 nextpktlen:14;
>> +       u32 nextind:1;
>> +       u32 rsvd:1;
>> +
>> +       u32 rxmcs:6;
>> +       u32 rxht:1;
>> +       u32 amsdu:1;
>> +       u32 splcp:1;
>> +       u32 bandwidth:1;
>> +       u32 htc:1;
>> +       u32 tcpchk_rpt:1;
>> +       u32 ipcchk_rpt:1;
>> +       u32 tcpchk_valid:1;
>> +       u32 hwpcerr:1;
>> +       u32 hwpcind:1;
>> +       u32 iv0:16;
>> +
>> +       u32 iv1;
>> +
>> +       u32 tsfl;
>> +
>> +       u32 bufferaddress;
>> +       u32 bufferaddress64;
>> +
>> +} __packed;
> 
> These are not compatible to big-endian machine. 

rx_desc_92d is almost unused, so I deleted it and used the
get_rx_desc_* functions instead. rx_fwinfo_92d is easier to fix.

> 
> [...]
> 
> After going through this patch again, I really want you (or someone) can help
> to refine this driver. The major problem is readability including
>  - should declare in reverse X'mas tree
>  - large function
>  - no proper blank lines
>  - unreadable indent to fit 80 characters limit of checkpatch
>  - ...
> 
> These problems are existing for a long time, and now may be a good time to
> adjust some of them we are touching.
> 
> A way to adjust them is to add patches to convert above items I list 
> one by one. I can ignore flaws (not introduce by this patch though) in this
> patch, and review coming patches (but still hope in the same patchset) that
> fix these flaws. Since this patchset contains 14 patches already, maybe we
> should have first patchset to adjust codes you will touch, and then add 8192DU
> by second patchset. 
> 
> Ping-Ke 
> 

Okay, I did all the things you mentioned, and a bit more.

