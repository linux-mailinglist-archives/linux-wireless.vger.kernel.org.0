Return-Path: <linux-wireless+bounces-36663-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kkxYEASDDGrIigUAu9opvQ
	(envelope-from <linux-wireless+bounces-36663-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 17:34:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2558189B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9418B300B472
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1177725CC79;
	Tue, 19 May 2026 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkwUBgKf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1A1A3172
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204858; cv=none; b=R4a8/IpppFG0ZMdhnRryekO8z+EdR+f6CWLBgGguYvYegwNNLmy1OTS+Pwi3BBPsbpjN22s90odYt1OtqtxfN6Py2avEaYE8S1micXoCv66k3JnhpsZj6r6EsFObx6/e5NV9v1pwbi5xtkTL3hZRZaTqJVvFoEdOawqKzrJC0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204858; c=relaxed/simple;
	bh=XSarc6FRunJFDvO0DT2otOO6hhszPFn4ljtLoQ+NmeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OxO+prLsr5rI31gzLCKUE8wpVNzDYpkaP0eRw0g/IUTQmIbFSdkKRZRHPG9v1usoO+9HxEtiEyoExW7wh3uNpo2ZTutStI9rbwuTG+bFU/8SG5xDncbGTshGiHRZuvYqUqzH+1p40jyvD+enzCtfmLSNv48yoF8lFojCT0T1Wec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkwUBgKf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-459bf19e87bso2232797f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 08:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779204855; x=1779809655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8QHWSbgdDGS8eo2iN9v8RlgQnH8AM8INRGn/uRuYgZU=;
        b=NkwUBgKfkeggqRI9XEm+STelerhQvsogMjmGoV1Pxwpy28sVrL9KRaRIxjCRh4upU7
         n34m8dsHdvQ7kC8y9V0tgbbGi1Q0NgUJ+1K0mQ6tnM2/RoUI8O3LZpwK3XqQ55LlOsEv
         jPsATak6HxHQ3hqjNEzk1NygiNCCVGxDRr0ktVAtO6VfQDwGdb8X30+gsB8h5dS9ldRd
         eeL7PiJ/xHs8kUuprZKHptVM+FWoqD4jJuBOr1ek8D7Bl0MR6fAMtU+OtYuvgHlo7ipv
         hmtL0LPN/nyvHncn45aewSNI6WQ7xBWWno2wU1aQ4HD7ggfXcI209bA9u8c2U9kOVnqV
         nLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204855; x=1779809655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QHWSbgdDGS8eo2iN9v8RlgQnH8AM8INRGn/uRuYgZU=;
        b=rrSNPRGEDirovWcmEKtVlfJAOVvXt9kA318a4EQjYbi4CQamcoktDE0lXurPRAOTH3
         ntfS/0sGfAq2veLvKHcdmaGhs5PPDTWy4RyULbW68FTdTzpsrLeGZ+h0Y6EZ7x4MOB0R
         qjfxf1+qI3UVuYIf1KvylR4ZOBGjXDy3fL1g+KnBzFSvo+Qp7L94/37olwKbkvsEx7fQ
         KiZNZD5AfUby3UOlxV6Q85mabnuHIn7TdnhT7XXK2qJdg13I6uDB1wbfrOPtT460i7KG
         QkLTSGV/mlA1KZRj+27/Utb2um3WhmZVW24Zjpyy22nF2geZZetLlFJWwD/awguqajKU
         6u6w==
X-Forwarded-Encrypted: i=1; AFNElJ8PWpE6eblMwwnczHo1sM5M5s4cYS4TPxaOytNGhK9waNyoGgaEaA1LJzx4Llnf8B9HdpuXl+K8YJddGtaiyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwScO6LCPLnBcVIsplqPZAjBzEWGTDM3uuXX8gRLH3SB1edUOO5
	KbFV/4jMP4+ckysDSBEyfmmWcJOUPL8GQaLTNsY/eqbMLKCFrl0WSw4wZ1uN2A==
X-Gm-Gg: Acq92OENkMPlCbro6nmnXeMHt5z6dw3FObx7ADlhiZXxwpi3IGSMIgjkDOHwwHSM6kO
	1rL0d+UvGuhm/5UwknGSyL+YreanJgrTq/7lk2ZEbgkTiH9lkYjl+QeGn+FOck/Y6axfPzNinYQ
	1dtyZZBwCe5myotaOJWtdjk9+DYBdTrsOp8YrPwWUpbbAn8E2wwvEd2qsbalK6P3DXv3bQ/TffC
	2cO762nionBXktfGGt7ut4SUNHKiKYvgRjtPXRO6yc/85Z54dig3mT93tVWxZyt1FOuyOzjfvi/
	QV3SVYMrWTAdR5ikQHx25mdHh497URqfMKHqOkWpPgnfpyRLbLYrlOM9UDzJtZMkwNIqWXFJ/Uh
	CZLz0UWl6oyVkm/k0kMWqK4GXqgzZAX7FVbhmMHcm1aMfNEBJg4HoHcSlrCHQ17WLanoqcOgxwA
	wRbnkIHlUQe8nBBF/VQLARNtctUU/SqBI=
X-Received: by 2002:a05:6000:1885:b0:45e:8978:f176 with SMTP id ffacd0b85a97d-45e8978f1aemr5631672f8f.0.1779204854708;
        Tue, 19 May 2026 08:34:14 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm48503288f8f.29.2026.05.19.08.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 08:34:14 -0700 (PDT)
Message-ID: <b4da28cd-17e0-46f2-a73c-e77d9c96cca1@gmail.com>
Date: Tue, 19 May 2026 18:34:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v3] wifi: rtw89: usb: Support switching to USB 3
 mode
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <fcdde81a-97ec-458f-8e70-ac024938f1d7@gmail.com>
 <5fc263787831471f87585fb90a9b0fcb@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <5fc263787831471f87585fb90a9b0fcb@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36663-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:email]
X-Rspamd-Queue-Id: CCD2558189B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 18/05/2026 10:51, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> The Realtek wifi 6/7 devices which support USB 3 are weird: when first
>> plugged in, they pretend to be USB 2. The driver needs to send some
>> commands to the device, which make it disappear and come back as a
>> USB 3 device.
>>
>> Implement the required commands in rtw89.
>>
>> Add a new function rtw89_usb_write32_quiet() to avoid the warnings
>> when writing to R_{AX,BE}_PAD_CTRL2. Even though the write succeeds,
>> usb_control_msg() returns -EPROTO, probably because the USB device
>> disappears immediately. This results in some confusing warnings in
>> the kernel log.
>>
>> When a USB 3 device is plugged into a USB 2 port, rtw89 will try to
>> switch it to USB 3 mode only once. The device will disappear and come
>> back still in USB 2 mode, of course.
> 
> As we always try to switch USB 3, is it needed to add a hint to users
> to plug USB 2 port if he has a bad performance on 2GHz band?
> 

I can add a message like "2.4 GHz performance may be better in a USB 2
port".

>>
>> Tested with RTL8832AU, RTL8832BU, RTL8832CU, and RTL8912AU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Some minor suggestions. Otherwise, 
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
>> index c6d55e669776..bfe004a49ccc 100644
>> --- a/drivers/net/wireless/realtek/rtw89/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
>> @@ -12,7 +12,7 @@
>>  static void rtw89_usb_read_port_complete(struct urb *urb);
>>
>>  static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
>> -                               void *data, u16 len, u8 reqtype)
>> +                               void *data, u16 len, u8 reqtype, bool warn)
>>  {
>>         struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
>>         struct usb_device *udev = rtwusb->udev;
>> @@ -52,7 +52,7 @@ static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
>>
>>                 if (ret == -ESHUTDOWN || ret == -ENODEV)
>>                         set_bit(RTW89_FLAG_UNPLUGGED, rtwdev->flags);
>> -               else if (ret < 0)
>> +               else if (ret < 0 && warn)
>>                         rtw89_warn(rtwdev,
>>                                    "usb %s%u 0x%x fail ret=%d value=0x%x attempt=%d\n",
>>                                    str_read_write(reqtype == RTW89_USB_VENQT_READ),
>> @@ -80,7 +80,7 @@ static u32 rtw89_usb_read_cmac(struct rtw89_dev *rtwdev, u32 addr)
>>
>>         for (count = 0; ; count++) {
>>                 rtw89_usb_vendorreq(rtwdev, addr32, &data, 4,
>> -                                   RTW89_USB_VENQT_READ);
>> +                                   RTW89_USB_VENQT_READ, true);
> 
> Not sure if you like to implement a __rtw89_usb_vendorreq(), and 
> preserve rtw89_usb_vendorreq() as a wrapper with original prototype.
> Then, no need to stir here. 
> 
> I mean:
> 
> __rtw89_usb_vendorreq(..., bool warn);
> 
> static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
> 				void *data, u16 len, u8 reqtype)
> {
> 	__rtw89_usb_vendorreq(rtwdev, addr, data, len, reqtype, true);
> }
> 
> (just a soft suggestion)
> 

Yes, that looks good.

>>
>>                 val32 = le32_to_cpu(data);
>>                 if (val32 != RTW89_R32_DEAD)
> 
> [...]
> 


