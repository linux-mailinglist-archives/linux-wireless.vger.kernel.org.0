Return-Path: <linux-wireless+bounces-14221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DF9A440D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 18:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36111F22B5D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57DC202F9F;
	Fri, 18 Oct 2024 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR8orQ2v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7D813C3CD
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269750; cv=none; b=hX+Jh+PuXM+elK1Z4tzZM22tIGlfjjlX14Qg4bgLbauYSDZd1P3vqon0h3CyMwe351QBQCuLNaFGLIyAwVEAcGcJm0yo5lrVDtpjZWsKyoPjUmwfc6xald6bN/a6s9sLBM3AqUzN7Svk1mfY+TJA9VUSUEeoWPxaQQRu3OhI+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269750; c=relaxed/simple;
	bh=xqjoIkVp1BgFpcaACLzCp+hnxEcl28ApDfstdy4HDW0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ALkOk32n4gpacas83BoChild1D9xZkhHIosby6i9utZZAMsW7YjtSd0k5hFWUL26muQNiD64bhShXQxz+oM2JysW1y26rrNDlecg+ycY9XzX3TylKo6fp7quZRC7lqCDghrFNuCT2gOvj/2KnMKda9Hu1juJbQtMgvKPQllSk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR8orQ2v; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so1807110f8f.2
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729269747; x=1729874547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJlJXmduTGTN+gfGEStcvylokZCPbPchmJxiw92dZOA=;
        b=iR8orQ2vhjzQMRr1Bxm4hPH4h1pDLY7vfKLOK3qm6+veSIhFrfjsty25qaQUhgzP45
         CH5N6DyeH0f8NHYuX28gXQzuAVhKitypmchmxVe4Uy2yMKU1Wokp3aPW+WNkixE7uGnQ
         T63VWebf4wcmsOMEVW9nGsjuISNFBq27fLOOArzfh94ZglWU6wuGDz20eOwPe5s80IU8
         X3aYhf0bfW9MFr1baWKTocEqe9VqBsWtKi3j/g/sIYTfLIOSRZ37sW+CMadUhtwfE2hY
         iQFXwKDlwgDg7FYZo+7+CaoZToWUEQmWMfV7ZNYn6itC8/vX7e6RqH22z5dX5Tja+0x2
         mEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729269747; x=1729874547;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJlJXmduTGTN+gfGEStcvylokZCPbPchmJxiw92dZOA=;
        b=DliDElpHW90KAv5SEOnzDI2ZBPjMpdtqdVegIHsM34n47gN7SjfeKViN2tD1D3usqn
         Q+33t/Uv7wHWXKswz/lxxuY29Xq4fob4DrB1xEUR0LnNEI3G1gzqlD8f/fZM33jY3j2u
         10SxrgIUt4GkS5OdKShd76Y4u9O2uRcWIE9zdaPbLfQj1WFUevjyTtfSibfOcu71rjQ/
         Oa5Fwd4HkcbSD934pG26fEmp74hWaJsYkTg3EDDn/4wgFOmobRqMN6Y5FmFg8bn16KIH
         QyELoM0BAb8QOOxPJtY03OyZMTY4KnB7NNN9FoRPGo2OYHtdL6kPj++CYiPG/IQGgaZ7
         /7HA==
X-Forwarded-Encrypted: i=1; AJvYcCVPmdmUxVP9lf1yzQEWkScdZDSQMUT5IHjYvP6OJFbNO22IrmzZafXdkRIMFAAm78effkUCDoXuR55zJoGeNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSIXfuoGlwrfc7lE0d3Fray65x36ZMPjn971sr9elv4BX3lpE
	iE/8TDShtaibjvvQsTn+eBXu9xG9yu/1dh04ckbv53N3fVNLwhBme44vsA==
X-Google-Smtp-Source: AGHT+IE48hmylvB1GTslHC7eOOt2uMx6xwO3tGMDbOaEYS8uapWFJyFA8rQr4pwnTh8sbd2h8mB0RA==
X-Received: by 2002:a05:6000:ed0:b0:37d:4a16:81d6 with SMTP id ffacd0b85a97d-37eb4861ademr2196431f8f.24.1729269746692;
        Fri, 18 Oct 2024 09:42:26 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf139b54sm2330814f8f.109.2024.10.18.09.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:42:26 -0700 (PDT)
Message-ID: <f666fd9b-6010-469c-aca4-71a1e2cf7e07@gmail.com>
Date: Fri, 18 Oct 2024 19:42:25 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v2 21/22] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <45604f31-a992-4188-b8c6-2d8e43981d77@gmail.com>
 <5222819febaf463797e11fd64d87f7fe@realtek.com>
Content-Language: en-US
In-Reply-To: <5222819febaf463797e11fd64d87f7fe@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2024 10:36, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> +
>> +static const struct usb_device_id rtw_8821au_id_table[] = {
>> +       { USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x011e, 0xff, 0xff, 0xff),
>> +         .driver_info = (kernel_ulong_t)&(rtw8821a_hw_spec) },
> 
> Module description says "8821au/8811au", but only one device ID. Do they
> share the same ID?
> 

This one and 2604:0012 (RTL8812AU) were the devices I had when
I started this work. Then I pushed the code to Larry Finger's
github, where Larry and Nick Morrow added many other device IDs.
I will send their patches after this series.

>> +       {},
>> +};
>> +MODULE_DEVICE_TABLE(usb, rtw_8821au_id_table);
>> +
>> +static struct usb_driver rtw_8821au_driver = {
>> +       .name = "rtw_8821au",
>> +       .id_table = rtw_8821au_id_table,
>> +       .probe = rtw_usb_probe,
>> +       .disconnect = rtw_usb_disconnect,
>> +};
>> +module_usb_driver(rtw_8821au_driver);
>> +
>> +MODULE_AUTHOR("Bitterblue Smith <rtl8821cerfe2@gmail.com>");
>> +MODULE_DESCRIPTION("Realtek 802.11ac wireless 8821au/8811au driver");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> --
>> 2.46.0
> 


