Return-Path: <linux-wireless+bounces-29763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D65BCBF5DD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 19:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95EB83027E0B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 18:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47313376B0;
	Mon, 15 Dec 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnkXfI5d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D853385BC
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821968; cv=none; b=hz5AuAOA06qjJiChPl4j6sPmhyIXn0dc69Vy33jCcPjMUnIGeYTa7TZz9Y7ZLLRhxluwZB/mhEvqoVm6njtU5Nlw54r3iUgGN/MORyDSLSs/NP539oD2lTibK21r81WeVG9KDGYMn4GxJ7LkqdO/VvVgIP6XJLVu4GtakUBvmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821968; c=relaxed/simple;
	bh=9x3KEWl4wQ0zOq66NyRuWasQhNFnyj+B4rAG9m8gQTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boLHTX3gBkdOuQAaATsQz9S5iF/8ss9tGT9QsK09uyf+p3agMq+1WVKc/ZMszbiKrsU7CviIHIoo2QrdQT0wpSYCxk2MUzCf4Eu7GuNrKFuqoq4++3C8Sl2tdnQbye8FRWrHXrGUZSHT3z+Bqf47fnGcpTOTEkXWmSglLItxIeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnkXfI5d; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so2265519f8f.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 10:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765821965; x=1766426765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WW3VOmJ5UjcME6Ji+nprtb6mqIdDBLQbx6sMGQfZYAI=;
        b=mnkXfI5dihQhQcN1Mr0ySMi1R4gQiabKINvuwn8gFwxZmK7GzD5aFaz+IvDf1uAcib
         n7Y5zBXMZyY/OQtAyeBNn64rgELxcuVTSrNrkueVfUHd9Y1qcY4Xa26fO5G49EJIcq2N
         U7VDF43G0wyzZGP4DQ3Z0VCtqPMBCEeGIqsw/DN0fKG7ep/J5IsUF7sNJhVBGme+iGdK
         UWn+j3OJMiURIF/0K08/e7+sE6BWL0xOhgPY0urktqs5IkfBN8N2JorRG/q0jtMjipx/
         aJXXtZz9Op8Pin+ZJo/uXfC2nz0tcQlJz0rCF8gVDTYj+dUerP8m7GOx4D3b0GNZ9W7r
         9iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765821965; x=1766426765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WW3VOmJ5UjcME6Ji+nprtb6mqIdDBLQbx6sMGQfZYAI=;
        b=CsoeoFCFPNXwJ5NejV5QdUXm4LQfu8naItGYDvr8sOcsXaBc3VQ/CGxNITjYm23+Fp
         AiH7T6YQ6mTcx5A0u9EByzuxUAUIjy/U1sMZhFhu7Wcf9azGRElJpPUxLYCCySkS7YtF
         jmzNupWrGF+SEVRJHGu75kN0nXvffmYfVCtmIzBsxprbMnTgNo6AE4P8KCxZ1RCYQzA/
         0vPm1F4gNj7se2bok48VbJyPpGjbkt+zzAnQbuhyr5xxv31mciKDw6iaTWQWf+H5sMbG
         zddbc6/i/M+QQbmOOuPymObeYNmYxYhKbnFM5bV7briV80xfvJxlk9h2dVNJST6+k4CL
         MtQw==
X-Forwarded-Encrypted: i=1; AJvYcCVVKr58ewqpEjgf4QjFTsxEQPf/T65V5oF9XrmRO9dfAkyTJOo+UCauCXICN6BpSclNrXt7UEYiBTh657XRbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfj5rP5D1YqRbLqQj94f9GqLXehMi/hyES0nCuvVr8sFflQP+F
	n05g4O7pKO9X/41aSmwAXJNfye6jZUGi31Ri4qUn85upBr3ngdPfniwd
X-Gm-Gg: AY/fxX4oAPJd1NNTQBRv8Ho7leO4A/CBTkMCBccxc4TWYMdfhZMjDM6+e6t4tJ+VRLF
	EkubEsI7r8L3RD9NZYcHMJ/398ocjb6XjFs0dkJELNsXLxt6j84PYZn8fsYY8ez627l56JmjwWO
	0tP6TB7e9PXfOq7ERGyWaS9Wlk4TiaNV109O0rR3wsr2GqLHsZG/byO1emJNEGNE4YVEjRXG7WF
	17rst5ScArSpDL4Aiv0JT4sgF6Loc+u7t8iNUSfCJmTA7SfCSwfi/vCOvAK7jehNHeyx5fnAWPR
	PCAJ8UK8ogBEgkSSj7Amg+MZbAtnZ0fxGAP7eRs7i2+9WRDFn6UQU/aBhqaJhqwpFt30P357o1z
	KviNTsMNteYYGiA7NXliCtelpxPVZojCXlxDbNNXxSTAAxtUcqGxD8zSz8ESfY5qW+LTzj7laRA
	u64Hy9qmHwwHoS4qVgWHoWvLeptUwIOH0=
X-Google-Smtp-Source: AGHT+IGvsOxksPIgeNwip/4cDAxFY5tbbBdwRJTaPuya9RfheriGRugoswJ6WQ7vBSWZeVF4jLqkiw==
X-Received: by 2002:a05:6000:420e:b0:430:f241:a11f with SMTP id ffacd0b85a97d-430f241a3cfmr10102142f8f.30.1765821964508;
        Mon, 15 Dec 2025 10:06:04 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fbbeb5298sm19346619f8f.20.2025.12.15.10.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 10:06:04 -0800 (PST)
Message-ID: <13ea776b-8ae7-468c-baed-ae0b5adb2a5f@gmail.com>
Date: Mon, 15 Dec 2025 20:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 04/12] wifi: rtw89: mac: reset power state before
 switching to power on
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Gary Chang <gary.chang@realtek.com>, Damon Chen <damon.chen@realtek.com>,
 Zong-Zhe Yang <kevin_yang@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
 <20251212031303.19882-5-pkshih@realtek.com>
 <efc58c87-d391-4970-b9af-abdef9861342@gmail.com>
 <05f1a2bbc0d344ea8c37481f9e1d26d4@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <05f1a2bbc0d344ea8c37481f9e1d26d4@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2025 04:05, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote;
>> On 12/12/2025 05:12, Ping-Ke Shih wrote:
>>> To run power on function properly, reset power states (off/on/PS) to
>>> initial state. Otherwise, it might be unusable due to fail to power on.
>>>
>>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>>> ---
>>>  drivers/net/wireless/realtek/rtw89/mac.c    |  89 ++++++++++++--
>>>  drivers/net/wireless/realtek/rtw89/mac.h    |   1 +
>>>  drivers/net/wireless/realtek/rtw89/mac_be.c | 130 ++++++++++++++++++++
>>>  drivers/net/wireless/realtek/rtw89/reg.h    |  27 ++++
>>>  4 files changed, 240 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>>> index d78fbe73e365..ba4344a640f5 100644
>>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>>> @@ -1478,13 +1478,11 @@ static void rtw89_mac_power_switch_boot_mode(struct rtw89_dev *rtwdev)
>>>
>>>  static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>>>  {
>>> -#define PWR_ACT 1
>>>       const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
>>>       const struct rtw89_chip_info *chip = rtwdev->chip;
>>>       const struct rtw89_pwr_cfg * const *cfg_seq;
>>>       int (*cfg_func)(struct rtw89_dev *rtwdev);
>>>       int ret;
>>> -     u8 val;
>>>
>>>       rtw89_mac_power_switch_boot_mode(rtwdev);
>>>
>>> @@ -1499,10 +1497,10 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>>>       if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags))
>>>               __rtw89_leave_ps_mode(rtwdev);
>>>
>>> -     val = rtw89_read32_mask(rtwdev, R_AX_IC_PWR_STATE, B_AX_WLMAC_PWR_STE_MASK);
>>> -     if (on && val == PWR_ACT) {
>>> -             rtw89_err(rtwdev, "MAC has already powered on\n");
>>> -             return -EBUSY;
>>> +     if (on) {
>>> +             ret = mac->reset_pwr_state(rtwdev);
>>> +             if (ret)
>>> +                     return ret;
>>>       }
>>>
>>>       ret = cfg_func ? cfg_func(rtwdev) : rtw89_mac_pwr_seq(rtwdev, cfg_seq);
>>> @@ -1529,7 +1527,6 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
>>>       }
>>>
>>>       return 0;
>>> -#undef PWR_ACT
>>>  }
>>>
>>>  int rtw89_mac_pwr_on(struct rtw89_dev *rtwdev)
>>> @@ -3931,6 +3928,83 @@ static int rtw89_mac_feat_init(struct rtw89_dev *rtwdev)
>>>       return 0;
>>>  }
>>>
>>> +static int rtw89_mac_reset_pwr_state_ax(struct rtw89_dev *rtwdev)
>>> +{
>>> +     enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
>>> +     u32 val32;
>>> +     int ret;
>>> +
>>> +     val32 = rtw89_read32(rtwdev, R_AX_SYSON_FSM_MON);
>>> +     val32 &= WLAN_FSM_MASK;
>>> +     val32 |= WLAN_FSM_SET;
>>> +     rtw89_write32(rtwdev, R_AX_SYSON_FSM_MON, val32);
>>> +
>>> +     ret = read_poll_timeout(rtw89_read32_mask, val32, val32 == WLAN_FSM_IDLE,
>>> +                             1000, 2000000, false,
>>> +                             rtwdev, R_AX_SYSON_FSM_MON, WLAN_FSM_STATE_MASK);
>>> +     if (ret) {
>>> +             rtw89_err(rtwdev, "[ERR]Polling WLAN PMC timeout= %X\n", val32);
>>> +             return ret;
>>> +     }
>>
>> I get this error message with every AX chip the first time
>> rtw89_mac_pwr_on() is called:
>>
>> [  +0.007286] rtw89_8852bu 2-4:1.0: loaded firmware rtw89/rtw8852b_fw-1.bin
>> [  +2.001260] rtw89_8852bu 2-4:1.0: [ERR]Polling WLAN PMC timeout= 100
>>
>> They still work, because the second attempt in rtw89_mac_pwr_on()
>> succeeds.
>>
>> Before this patch, the message was "MAC has already powered on".
>> The new message says it's an error, so it will confuse people.
> 
> I borrow a 8852AU and a 8852CU that both don't have error messages.
> The "first time" you meant is just to plug the USB adapter?
> If so, I have not idea about the difference between yours and mine.
> 

Yes, the error only appears right after the adapter is plugged in.
I put a message at the top of rtw89_mac_power_switch():

[  +0.721188] usb 1-4: new high-speed USB device number 8 using xhci_hcd
[  +0.126425] usb 1-4: New USB device found, idVendor=0bda, idProduct=8832, bcdDevice= 0.00
[  +0.000014] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000005] usb 1-4: Product: 802.11ac WLAN Adapter
[  +0.000004] usb 1-4: Manufacturer: Realtek
[  +0.000003] usb 1-4: SerialNumber: 00e04c000001
[  +0.007757] rtw89_8852au 1-4:1.0: loaded firmware rtw89/rtw8852a_fw.bin
[  +0.000338] rtw89_mac_power_switch enter, on 1
[  +2.005000] rtw89_8852au 1-4:1.0: [ERR]Polling WLAN PMC timeout= 100
[  +0.000010] rtw89_mac_power_switch enter, on 0
[  +0.007867] rtw89_mac_power_switch enter, on 1
[  +0.020254] rtw89_8852au 1-4:1.0: Firmware version 0.13.36.2 (52acc807), cmd version 0, type 1
[  +0.000010] rtw89_8852au 1-4:1.0: Firmware version 0.13.36.2 (52acc807), cmd version 0, type 3
[  +0.963868] rtw89_8852au 1-4:1.0: chip rfe_type is 1
[  +0.103131] rtw89_mac_power_switch enter, on 0
[  +0.011027] rtw89_8852au 1-4:1.0: rfkill hardware state changed to enable
[  +0.051507] rtw89_8852au 1-4:1.0 wlp3s0f3u4: renamed from wlan0
[  +0.020062] rtw89_mac_power_switch enter, on 1

>>
>> Is it possible this code related to R_AX_SYSON_FSM_MON is not
>> applicable to USB? My adapters still work if I delete it.
> 
> I'm checking internal experts. Quickly checking vendor driver, I don't see
> it avoids calling this because of USB devices. 
> 
> If you delete code related to R_AX_SYSON_FSM_MON, will it show below messages
> under the case 'val32 == MAC_AX_MAC_ON'?
> 
>    "[ERR]Polling MAC state timeout= %X\n"
> 

No, I never see that error. I checked the value of R_AX_IC_PWR_STATE.
My RTL8832BU with the Windows driver onboard:

[  +4.566707] usb 1-4: new high-speed USB device number 20 using xhci_hcd
[  +0.125152] usb 1-4: New USB device found, idVendor=0bda, idProduct=1a2b, bcdDevice= 0.00
[  +0.000008] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  +0.000002] usb 1-4: Product: DISK
[  +0.000002] usb 1-4: Manufacturer: Realtek
[  +0.000544] usb-storage 1-4:1.0: USB Mass Storage device detected
[  +0.000160] usb-storage 1-4:1.0: device ignored
[  +0.629850] usb 1-4: USB disconnect, device number 20
[  +0.723342] usb 1-4: new high-speed USB device number 21 using xhci_hcd
[  +0.125493] usb 1-4: New USB device found, idVendor=0bda, idProduct=b832, bcdDevice= 0.00
[  +0.000013] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000005] usb 1-4: Product: 802.11ac WLAN Adapter
[  +0.000004] usb 1-4: Manufacturer: Realtek
[  +0.000004] usb 1-4: SerialNumber: 00e04c000001
[  +0.007910] rtw89_8852bu 1-4:1.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[  +0.005682] rtw89_mac_reset_pwr_state_ax R_AX_IC_PWR_STATE=0x2200104
[  +2.000406] rtw89_8852bu 1-4:1.0: [ERR]Polling WLAN PMC timeout= 100
[  +0.017635] rtw89_mac_reset_pwr_state_ax R_AX_IC_PWR_STATE=0x2200004
[  +0.043991] rtw89_8852bu 1-4:1.0: Firmware version 0.29.128.0 (418a672d), cmd version 0, type 5
[  +0.000009] rtw89_8852bu 1-4:1.0: Firmware version 0.29.128.0 (418a672d), cmd version 0, type 3
[  +1.462646] rtw89_8852bu 1-4:1.0: chip rfe_type is 1
[  +0.135147] rtw89_8852bu 1-4:1.0: rfkill hardware state changed to enable
[  +0.045006] rtw89_8852bu 1-4:1.0 wlp3s0f3u4: renamed from wlan0
[  +0.016726] rtw89_mac_reset_pwr_state_ax R_AX_IC_PWR_STATE=0x2200004

And another RTL8832BU without a Windows driver onboard:

[Dec15 19:46] usb 1-4: new high-speed USB device number 22 using xhci_hcd
[  +0.125532] usb 1-4: New USB device found, idVendor=0bda, idProduct=b832, bcdDevice= 0.00
[  +0.000010] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000003] usb 1-4: Product: 802.11ax WLAN Adapter
[  +0.000003] usb 1-4: Manufacturer: Realtek
[  +0.000002] usb 1-4: SerialNumber: 00e04c000001
[  +0.007667] rtw89_8852bu 1-4:1.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[  +0.002684] rtw89_mac_reset_pwr_state_ax R_AX_IC_PWR_STATE=0x2200004
[  +0.045258] rtw89_8852bu 1-4:1.0: Firmware version 0.29.128.0 (418a672d), cmd version 0, type 5
[  +0.000015] rtw89_8852bu 1-4:1.0: Firmware version 0.29.128.0 (418a672d), cmd version 0, type 3
[  +1.462130] rtw89_8852bu 1-4:1.0: chip rfe_type is 1
[  +0.133511] rtw89_8852bu 1-4:1.0: rfkill hardware state changed to enable
[  +0.043307] rtw89_8852bu 1-4:1.0 wlp3s0f3u4: renamed from wlan0
[  +0.017936] rtw89_mac_reset_pwr_state_ax R_AX_IC_PWR_STATE=0x2200004

Maybe your borrowed adapters don't have the Windows drivers onboard either?

>>
>> (I don't get the error with RTL8912AU.)
>>
> 
> I'm adding this patch for WiFi 7 chips mainly, and this seems to be expected.
> 

My RTL8912AU does have the Windows driver onboard, but no error:

[  +5.365639] usb 1-4: new high-speed USB device number 25 using xhci_hcd                                                                                                  
[  +0.124722] usb 1-4: New USB device found, idVendor=0bda, idProduct=1a2b, bcdDevice= 0.00                                                                                
[  +0.000007] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  +0.000002] usb 1-4: Product: DISK                                                 
[  +0.000002] usb 1-4: Manufacturer: Realtek 
[  +0.000540] usb-storage 1-4:1.0: USB Mass Storage device detected
[  +0.000143] usb-storage 1-4:1.0: device ignored
[  +0.629713] usb 1-4: USB disconnect, device number 25
[  +0.420492] usb 1-4: new high-speed USB device number 26 using xhci_hcd
[  +0.125490] usb 1-4: New USB device found, idVendor=0bda, idProduct=8912, bcdDevice= 0.00
[  +0.000009] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  +0.000002] usb 1-4: Product: 802.11be WLAN Adapter                 
[  +0.000002] usb 1-4: Manufacturer: Realtek 
[  +0.000002] usb 1-4: SerialNumber: 00e04c000001
[  +0.008039] rtw89_8922au 1-4:1.0: loaded firmware rtw89/rtw8922a_fw-4.bin
[  +0.005192] rtw89_mac_reset_pwr_state_be R_AX_IC_PWR_STATE=0x2200104
[  +0.055131] rtw89_8922au 1-4:1.0: Firmware version 0.35.80.3 (8ef4f0cf), cmd version 1, type 1
[  +0.000009] rtw89_8922au 1-4:1.0: Firmware version 0.35.80.3 (8ef4f0cf), cmd version 1, type 3
[  +1.419275] rtw89_8922au 1-4:1.0: chip rfe_type is 1 
[  +0.042634] rtw89_8922au 1-4:1.0: Firmware version 0.1.0.0 (7b393818), cmd version 0, type 64
[  +0.000012] rtw89_8922au 1-4:1.0: Firmware element BB version: 00 49 00 00
[  +0.000014] rtw89_8922au 1-4:1.0: Firmware element radio A version: 00 33 00 00
[  +0.000015] rtw89_8922au 1-4:1.0: Firmware element NCTL version: 00 0f 00 00
[  +0.000118] rtw89_8922au 1-4:1.0: Firmware element TXPWR version: 00 40 00 00
[  +0.000005] rtw89_8922au 1-4:1.0: Firmware element PWR_TRK version: 00 33 00 00
[  +0.000010] rtw89_8922au 1-4:1.0: Firmware element REGD version: 00 48 00 06
[  +0.024441] rtw89_8922au 1-4:1.0: rfkill hardware state changed to enable
[  +0.042643] rtw89_8922au 1-4:1.0 wlp3s0f3u4: renamed from wlan0
[  +0.012737] rtw89_mac_reset_pwr_state_be R_AX_IC_PWR_STATE=0x2200004


