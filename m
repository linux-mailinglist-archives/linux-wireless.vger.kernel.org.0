Return-Path: <linux-wireless+bounces-1936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD582DC52
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 16:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C91D2810EE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA521773D;
	Mon, 15 Jan 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4PNZUYb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2A1773B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a997f3dfso669041266b.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705332548; x=1705937348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PqMYeapUrano0oj7siaxnxCMM8e8Sv/rjoHmbx8c7s=;
        b=k4PNZUYb3COvzcSGZnlcPGSiINCDnKnwwJ/saICsjGhUhq3Tz7yiarftMGoHEeFc4J
         cuuPXmS5ZOsLlKxuCGZpqZxr4afV0gylhXe0fr6hLs2P0gWUokKDqwS5BVZcHdt+SVUq
         2wYsNhFQ2ap3/Ze7/bHAOYqqZ11qify9XIjoHt+ECiR2+0ja3dtV0bthvBaThvsMV/hA
         22VGy+tIXO1GICuZVHHrvHPezpwb8dPaqoekK5G110Pmqag0ZHBo9oKAnFHrW0dxjbFX
         Zo65QERs8pAZxuUfrbMV+rkzFzdXC0tlQBT4/FYpUY5+d7K0anqjh/O9nSrXQxf4L5Ci
         Wlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705332548; x=1705937348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3PqMYeapUrano0oj7siaxnxCMM8e8Sv/rjoHmbx8c7s=;
        b=MrXmH5Zsf+6COnBqZjR4n+BtQu/mEKhFRuQ4KZ4P4Vghu69wsq3kFs3/tbt3+vsFmr
         Bm+FvK7sdS9W7tybh1YZ+bqUakIQrPqayx7nVQ2hDvk1ZsQU0hqo57I9dr4fsvI3Ei4o
         D57OyHBwussk55+vz8ICSiPQC/GRjqoPg+n8bv2qtkGjnbNZ1BnkjCm59MSRzVWCcNVh
         CboKCLt7NWbjeN5IrLcK5+0kRu/dUiMmmmSkEisjDFbpYdAf100ZbemGNIYoYgkxkw5j
         NYRjPa0R/ax8XxL0pi33VfqwqR0ygjVKBClPaOKrEAZLqevO6yLAbCryE35mTtAnesR5
         6nKg==
X-Gm-Message-State: AOJu0Yypzt4j+74rbXDEO3PvPVXx0YHJBi8BshJ/uSAnusbG0dxyJjc6
	D82ycQyXsQ0dA/2WBrZZ3Ao=
X-Google-Smtp-Source: AGHT+IEGruAW9SdVSeGKZ6cUE7ldQREJQW0psD8AhODn+mT0Wt9d2iy21C9EkNiiOq3l63QQZiRgzg==
X-Received: by 2002:a17:907:c9a2:b0:a2c:6c2:35b7 with SMTP id uj34-20020a170907c9a200b00a2c06c235b7mr2447383ejc.38.1705332547679;
        Mon, 15 Jan 2024 07:29:07 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090639c400b00a27a766c6c8sm5392691eje.218.2024.01.15.07.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 07:29:07 -0800 (PST)
Message-ID: <303651da-7ab7-4e49-8331-f541318b851a@gmail.com>
Date: Mon, 15 Jan 2024 17:29:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: Speed up firmware loading for USB
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
References: <0d262acd-4f94-41c2-8d15-83486aeb976b@gmail.com>
 <7d8e8424b768418ea1d2a38ba874c400@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <7d8e8424b768418ea1d2a38ba874c400@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 02:50, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Saturday, January 13, 2024 3:51 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; Larry Finger <Larry.Finger@lwfinger.net>
>> Subject: [PATCH] wifi: rtlwifi: Speed up firmware loading for USB
>>
>> Currently it takes almost 6 seconds to upload the firmware for RTL8192CU
>> (and 11 seconds for RTL8192DU). That's because the firmware is uploaded
>> one byte at a time.
>>
>> Also, after plugging the device, the firmware gets uploaded three times
>> before a connection to the AP is established.
>>
>> Maybe this is fine for most users, but when testing changes to the
>> driver it's really annoying to wait so long.
>>
>> Speed up the firmware upload by writing chunks of 64 bytes at a time.
>> This way it takes about 110 ms for RTL8192CU (and about 210 ms for
>> RTL8192DU).
>>
>> PCI devices could upload it in chunks of 4 bytes, but I don't have any
>> to test and commit 89d32c9071aa ("rtlwifi: Download firmware as bytes
>> rather than as dwords") decided otherwise anyway.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtlwifi/efuse.c  | 65 +++++++++++++++++--
>>  drivers/net/wireless/realtek/rtlwifi/efuse.h  |  4 +-
>>  .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |  6 +-
>>  drivers/net/wireless/realtek/rtlwifi/usb.c    |  9 +++
>>  drivers/net/wireless/realtek/rtlwifi/wifi.h   |  8 +++
>>  5 files changed, 82 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c
>> b/drivers/net/wireless/realtek/rtlwifi/efuse.c
>> index 2e945554ed6d..870a276299f5 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
>> @@ -1287,18 +1287,73 @@ int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
>>  }
>>  EXPORT_SYMBOL_GPL(rtl_get_hwinfo);
>>
>> -void rtl_fw_block_write(struct ieee80211_hw *hw, const u8 *buffer, u32 size)
>> +static void _rtl_fw_block_write_usb(struct ieee80211_hw *hw, u8 *buffer, u32 size)
>> +{
>> +       struct rtl_priv *rtlpriv = rtl_priv(hw);
>> +       u32 blockcount, blockcount8, blockcount4;
>> +       u32 remain8 = 0, remain4 = 0, remain = 0;
>> +       const u32 blocksize = 64;
>> +       const u32 blocksize8 = 8;
>> +       const u32 blocksize4 = 4;
>> +       u32 i, offset;
>> +
>> +       blockcount = size / blocksize;
>> +       remain8 = size % blocksize;
>> +       for (i = 0; i < blockcount; i++) {
>> +               offset = i * blocksize;
>> +               rtl_write_chunk(rtlpriv,
>> +                               START_ADDRESS + offset,
>> +                               blocksize, buffer + offset);
>> +       }
>> +
>> +       if (remain8) {
>> +               offset = blockcount * blocksize;
>> +               blockcount8 = remain8 / blocksize8;
>> +               remain4 = remain8 % blocksize8;
>> +
>> +               for (i = 0; i < blockcount8; i++)
>> +                       rtl_write_chunk(rtlpriv,
>> +                                       START_ADDRESS + offset + i * blocksize8,
>> +                                       blocksize8,
>> +                                       buffer + offset + i * blocksize8);
>> +       }
>> +
>> +       if (remain4) {
>> +               offset += blockcount8 * blocksize8;
>> +               blockcount4 = remain4 / blocksize4;
>> +               remain = remain8 % blocksize4;
>> +
>> +               for (i = 0; i < blockcount4; i++)
>> +                       rtl_write_dword(rtlpriv,
>> +                                       START_ADDRESS + offset + i * blocksize4,
>> +                                       cpu_to_le32(*(u32 *)(buffer + offset + i)));
> 
> Here should be le32_to_cpu(). 
> 

Right. But now I realise that rtl_write_dword is called at most once here,
so there is not much point using it.

>> +       }
>> +
>> +       if (remain) {
>> +               offset += blockcount4 * blocksize4;
>> +
>> +               for (i = 0; i < remain; i++)
>> +                       rtl_write_byte(rtlpriv, START_ADDRESS + offset + i,
>> +                                      *(buffer + offset + i));
>> +       }
>> +}
> 
> I think we can increase 'start' and 'buffer' addresses after writing, so 
> arithmetic can be simple. And, combine 64/8/4/1 block writing into single
> loop. Pseudo code like
> 
> static void _rtl_fw_block_write_usb(struct ieee80211_hw *hw, u8 *buffer, u32 size)
> {
> 	u32 start = START_ADDRESS;
> 	u32 n;
> 
> 	while (size > 0) {
> 		if (size >= 64) {
> 			n = 64;
> 			rtl_write_chunk(rtlpriv, start, 64, buffer);
> 		} else if (size >= 8) {
> 			n = 8;
> 			rtl_write_chunk(rtlpriv, start, 8, buffer);
> 		} else if (size >= 4) {
> 			n = 4;
> 			rtl_write_dword(rtlpriv, start, le32_to_cpu(*(u32 *)buffer));
> 		} else {
> 			n = 1;
> 			rtl_write_byte(rtlpriv, start, *buffer);
> 		}
> 
> 		start += n;
> 		buffer += n;
> 		size -= n;
> 	}
> }
> 

Why didn't I think of that? (Because I didn't think much, just copied
the code from the RTL8192DU driver and cleaned it a bit.)

>> +
>> +void rtl_fw_block_write(struct ieee80211_hw *hw, u8 *buffer, u32 size)
>>  {
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>> -       u8 *pu4byteptr = (u8 *)buffer;
>>         u32 i;
>>
>> -       for (i = 0; i < size; i++)
>> -               rtl_write_byte(rtlpriv, (START_ADDRESS + i), *(pu4byteptr + i));
>> +       if (rtlpriv->rtlhal.interface == INTF_PCI) {
>> +               for (i = 0; i < size; i++)
>> +                       rtl_write_byte(rtlpriv, (START_ADDRESS + i),
>> +                                      *(buffer + i));
>> +       } else if (rtlpriv->rtlhal.interface == INTF_USB) {
>> +               _rtl_fw_block_write_usb(hw, buffer, size);
>> +       }
>>  }
>>  EXPORT_SYMBOL_GPL(rtl_fw_block_write);
>>
>> -void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, const u8 *buffer,
>> +void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, u8 *buffer,
>>                        u32 size)
>>  {
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.h
>> b/drivers/net/wireless/realtek/rtlwifi/efuse.h
>> index 1ec59f439382..4821625ad1e5 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/efuse.h
>> +++ b/drivers/net/wireless/realtek/rtlwifi/efuse.h
>> @@ -91,8 +91,8 @@ void efuse_power_switch(struct ieee80211_hw *hw, u8 write, u8 pwrstate);
>>  int rtl_get_hwinfo(struct ieee80211_hw *hw, struct rtl_priv *rtlpriv,
>>                    int max_size, u8 *hwinfo, int *params);
>>  void rtl_fill_dummy(u8 *pfwbuf, u32 *pfwlen);
>> -void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, const u8 *buffer,
>> +void rtl_fw_page_write(struct ieee80211_hw *hw, u32 page, u8 *buffer,
>>                        u32 size);
>> -void rtl_fw_block_write(struct ieee80211_hw *hw, const u8 *buffer, u32 size);
>> +void rtl_fw_block_write(struct ieee80211_hw *hw, u8 *buffer, u32 size);
>>  void rtl_efuse_ops_init(struct ieee80211_hw *hw);
>>  #endif
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
>> index 20b4aac69642..9f4cf09090d6 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
>> @@ -40,7 +40,7 @@ static int rtl92cu_init_sw_vars(struct ieee80211_hw *hw)
>>         rtlpriv->dm.thermalvalue = 0;
>>
>>         /* for firmware buf */
>> -       rtlpriv->rtlhal.pfirmware = vzalloc(0x4000);
>> +       rtlpriv->rtlhal.pfirmware = kmalloc(0x4000, GFP_KERNEL);
> 
> Why should we use kmalloc instead? I don't see any description about this in
> commit message. 
> 

That's because usb_control_msg() can't use memory allocated by vmalloc:

Jan 09 19:39:29 ideapad2 kernel: xhci_hcd 0000:03:00.3: rejecting DMA map of vmalloc memory

I will mention this in the commit message.

>>         if (!rtlpriv->rtlhal.pfirmware) {
>>                 pr_err("Can't alloc buffer for fw\n");
>>                 return 1;
>> @@ -61,7 +61,7 @@ static int rtl92cu_init_sw_vars(struct ieee80211_hw *hw)
>>                                       fw_name, rtlpriv->io.dev,
>>                                       GFP_KERNEL, hw, rtl_fw_cb);
>>         if (err) {
>> -               vfree(rtlpriv->rtlhal.pfirmware);
>> +               kfree(rtlpriv->rtlhal.pfirmware);
>>                 rtlpriv->rtlhal.pfirmware = NULL;
>>         }
>>         return err;
>> @@ -72,7 +72,7 @@ static void rtl92cu_deinit_sw_vars(struct ieee80211_hw *hw)
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>
>>         if (rtlpriv->rtlhal.pfirmware) {
>> -               vfree(rtlpriv->rtlhal.pfirmware);
>> +               kfree(rtlpriv->rtlhal.pfirmware);
>>                 rtlpriv->rtlhal.pfirmware = NULL;
>>         }
>>  }
> 
> [...]
> 
> 


