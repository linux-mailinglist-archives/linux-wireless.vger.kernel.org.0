Return-Path: <linux-wireless+bounces-23395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB0AC3744
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 00:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9AB173957
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 22:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FE8A29;
	Sun, 25 May 2025 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3pnkt2T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85660163
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210632; cv=none; b=oQ/f5Dgfa0iTHsouW5tDHDKZoLJBRZKeARkqzUHw/ITtu3BfyF7qukyH0DyzMi6HXVferNC+d8VXLm0qbr/pkc9GDarU06T9KYG5NFta9iBQ9xCsjo+WW2dVjBgNYlaKfgltXWzvKGI30wVFmbHBmxfWnkuo1NUYe+GUmILAY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210632; c=relaxed/simple;
	bh=feayTzJMdFb7qRb/HSQPneHNVWnDvpDRERguDJhHFIc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=qGwoZlsGmbygZoTRCBpmhLMaGgAyLBEWF/+q+dx3Uxd+p4EY5e/9NsMBwhs23tl4tY2SW9XOZDwSTgwzRIGL+oETTTd7/n1Fr+Dr0BLuEBtC3sK5OolxTLAWHp+gkHgn1x4GDObfDRTBEFeH8350li/CaW7rkaWd5n7tmC4jm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3pnkt2T; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad5566ac13cso242413766b.1
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748210629; x=1748815429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cap2M4nKoAJlvpKKZ5W2jUOqYu775Ge4fPw0tUCSpig=;
        b=j3pnkt2TwlVQLMN9HPdcum4mcIRfvshWP7KinLdD1eKma16CvPsQLDNggI9hUebrMV
         fFN0EqFEm9ew5Sy4LXl8x3CrqP/I+Xv0low+Ki+NjA2+1fhPNe5NOeitTyrqPFTaCtr+
         yT6oPux8O/8SQRIVaVTbYGRqXB8CMM9iBQmZs+I63VJ9cuh0S6UByAv40nrqH8OtUuIA
         4E3aE2UpUQmhAbvfHsyC074ZtB5VaB/y7rCfQer0NETFSoAGvpQ5XLsCW4x8XT9JwKD5
         HBKnfBErS3vF6Bd9G76rwkoYJOfcAiQu6rLiTvW9DS/gKGeHTmdfccD7jZvA+he2M5Zr
         he0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748210629; x=1748815429;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cap2M4nKoAJlvpKKZ5W2jUOqYu775Ge4fPw0tUCSpig=;
        b=kFVrFTKTFzZ9eQUvmaGI3Dr/UiUg/R47tWK/pVcuHJUnosjuK7I2V8EPZ9ZhPxhrWf
         M90Opi37o5TcIQ7qBDT8vX56yALiyeu2AddIXnhU0prnSGWu8yFNTNw/b5vcgRHaRaW0
         7NqoxuCKqrRMx9MuAtv9fI/7lW7kwD6NHBR5cnQMD7SGXIhlhb4oNvo+fcUseXn+EJpt
         yJfi7kRkwWCipYjMURA851BdmRjIuFi/2uw2PuHNLGNRm96I0Y+1cNke3phNC4j8X3+0
         /KILdSw4arHcLnGYin/6CuOhBpe4u6/o+qIaTtdoaKQ8Me81e/20DJYWS1O6PFMv0nN8
         GvMA==
X-Forwarded-Encrypted: i=1; AJvYcCUeJM6XkVJC4fgfTMddzTG19aUhYmLxFbMQfgSlHlfMLh2pPey9+Di2dAe3pbm5prkAvm4NsR/OTWyY4ofQQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7iJg95ODyzyKqx7tae0cqcnkmfyvSH+qfTqrWTNAy/R7zMYh2
	/UPbqj3D0RlYdXweQXZj1ipAzjchaKsOyvDEl7RiAdNYWXj4X3+Zra6ivnfaDg==
X-Gm-Gg: ASbGncv4i6S432XYx7fXoRlaDZoBUFqUCODPCo32OhCk0cjfPCptG6UlwvxnXU4HMXI
	eZmbMF4uSD5VUZICSBInFtdP6lP0l9Qdlq0Cfxs0mFu9NASV7U9GTFyJPoI0wHzaLfmrN470z4Y
	j18PQ1JQYPiwe6bldfkOtJmx6gNBuPAAiV6/oSB4k7VZzG7oCHaJlYeYWYyRpOpLb+dhEqs4MLz
	U3kW5/iJZtf9U5gpz/RcuO9JXtkrNyQfeIApVN4C0K1WOXiALDM4LZEUGoR39d7mveuLAB04kaA
	/fvPfGDlnmuwRxpnvTPosZZr8iJEgQ6vvgpYPwAFJtNruTva0pEQ1k4wCjI=
X-Google-Smtp-Source: AGHT+IFdfawRr1AxiMSnBByqL9JELmz5mvPZ+ERsEYIAyXJNAVErjvG6cM1+h0sV3OObcv/tO0Dt3w==
X-Received: by 2002:a17:907:3d09:b0:ace:5461:81dd with SMTP id a640c23a62f3a-ad85b00b904mr630477466b.3.1748210628801;
        Sun, 25 May 2025 15:03:48 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4cadc5sm1567751966b.167.2025.05.25.15.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 15:03:48 -0700 (PDT)
Message-ID: <3b3e10af-6b09-4943-876e-fd06f48722a1@gmail.com>
Date: Mon, 26 May 2025 01:03:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 00/13] wifi: rtw89: Add support for USB
 devices
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <d947c391577d46a4b110cb30cfa89ad0@realtek.com>
Content-Language: en-US
In-Reply-To: <d947c391577d46a4b110cb30cfa89ad0@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/05/2025 10:07, Ping-Ke Shih wrote:
> Ping-Ke Shih wrote:
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>
>>> Add support for USB devices, starting with just RTL8851BU.
>>
>> Thanks for your work!!
> 
> Have you also tested AP mode? If not, please add a patch to disable it
> temporarily as a transition solution, like rtw88. 
> 

I tested it only for a few minutes with RTL8851BU and RTL8832BU.
My phone can connect to both.

>>
>>> RTL8832BU/RTL8852BU can be supported easily later. RTL8832CU/RTL8852CU
>>> can be supported as well, but it keeps losing the connection.
>>>
>>> This is based on rtw88_usb and the official rtl8851bu driver
>>> v1.19.10-70-g84e35c28d.20231019 from here:
>>> https://github.com/fofajardo/rtl8851bu
>>>
>>> I didn't test with any PCI devices.
>>
>> I tested RTL8851BE. It works as usual.
> 


