Return-Path: <linux-wireless+bounces-25685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD52BB0B1E3
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711BC3B902A
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0181C861B;
	Sat, 19 Jul 2025 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcaclMLJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839CC9476;
	Sat, 19 Jul 2025 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752958649; cv=none; b=ZqWj3CgYUDNiUhq7N0NMMkbAYg6R5EnFcsj4u0fEQmOjI+gFcXwsyifnopcZa7TiDLKAinlBujhowSUVGnNizB4Q7NYkd4wqmddHtbeYOBzhMdWSWTRPhCvkQrBXWrDqY64qZi6hClCIY6X9ZzFrIFtYpz2WGLw0gV/knRx0dlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752958649; c=relaxed/simple;
	bh=JFEUBLXTOcCv/4N0Mp/tCI4SIosRp/cR4vxQ6pkYVlA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S45yHSRTzGTzyrIaJr/zj/EJvo8+/x2IXqj6IpWnH1Lv52hgO1FfGDVgZ9kTGfqD463Cg89+20JWbTVcWbbrKBXIw+b4Y2FuGczGhsDk+NCjJg/gAgEvGMeL4rR7ZSLENhYj+qtWG+yNas6XTyjJja6oJIPk9+CdDOYsFIiOOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcaclMLJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso5643909a12.2;
        Sat, 19 Jul 2025 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752958646; x=1753563446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1pxSQc8IFFh0/t7y5+pYbGbktW/qqWoII3Ry8ywKIxo=;
        b=WcaclMLJM6iliaDlMcf7OCfDMkE3/rRDzxXb3jHPPLg4b6nxJfzGxlBcl/+JgSMbt/
         39AYRslTHvWFQU3Y7PKHkcy1EL4q/cOAJM+/vdK8PhouLXPYHlCr+9yZI5JaT5C5bYxi
         Xy6Nd47M1OmgrZ9vc0CnrbyGj7uig2klCHIckfUoQCkk5bXmQ0DoQdYyE58q97cy17ec
         kQfmjd8tqY1KtKKC5dEsZxmRdIeYmKk5wGadZOsboanqyCkWdvzE2UZjhLPUrxzidl4c
         BxoPZ3pMl5+ZNw/U36Kk480my7NJBYvOxJYOpVfh237lKp2lilgv4x8p/+oIx4As+mEN
         igqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752958646; x=1753563446;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pxSQc8IFFh0/t7y5+pYbGbktW/qqWoII3Ry8ywKIxo=;
        b=i63usivseIXRGy4V73U6Oz8rr3thxAmFIPMVRhRkZ/jywyVxF3x6LwAj5mQlPRvA7l
         9r5ZyKCL/qP+IYgsN0pOppnmJ62PoJGfEy6YDzVm0lQ61wVv2pl6E9ecF2hEYo+tGApJ
         +9H2i16s++NgfWnv4jhcIRRBDDLotzdZ4u1sP6Cg3fE3c5bHGjAIivAd1lwX9kOxarbi
         zFoFTgQkdK63q07SUwXw//+Jg5FGKYvhqz/b7ak7lkuooiyj2uAvICWWT0UmFPU0ulbU
         8wHqLyzsJEfHfXB207+urJVQlu3OoxdhE7LzhB28b92X5it8vJaSX7os40xdCnnEYiSX
         7SOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVhWyBx0CqZ3BwzPzOaBialGCSCjsq6YlBRsgL5tohtoGP0+4lMbDIvSSs8LzE574kGZLzrti+inmZHAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfCrO/1VBXeYxgnLSZrWVckiYA4eWQUai4IZK4WeAjr25muV1
	0cHddfSukwz2WgSpnBEjySjj6W9f6ZZ30V/jB0WUxBOewLe/VFx4SVsAiOXShQ==
X-Gm-Gg: ASbGncvmzlU4p0XAl8X1JAszO15ffdJ/N9Hzw+xeeLKRs+CLexkENaOxWWjAZ1k39OZ
	NuBdsfWA3m7enFP0qsF2YK3Kt2dUhVWeKZBNtPJ/9JGqlFHXLkXi1euZHS9WJE7cfQVCqMb8fUH
	CgjrYRxFx796kTmhC0yB/cm5psCCKAKZu4fIghs/XJeWVoZQPt9dVd+s+8dclm9y5l2iT24VAAn
	XgVDfFBgSdWVr0Jz6nl6Zz2i7O+UBT0YAex3/erGn3FApy644tdEyMFzVUpx2XxBJEDFWxzysVM
	L4oqduKSw0jb1U5hVeayI1Au4+gMO54c6fr7MD6M/eTgC5iX7MnVYZb/7Xbvbv7rlQ+tG3XnLqI
	Z5q29ofEFBZfzSnaJknvo5K3TCrQ/RWl/mKONwUKlM8Ga3pCzOutplG7I9gEt0nDrumFLWE6IT6
	rSdEvL7eOaXJ3zmSoGa1h5FcgG34S994Hi6Urfins=
X-Google-Smtp-Source: AGHT+IHXhGO5KtDinw3HUKi8PDwr0g/iIoKLRi1pDk0QepKJRFGMapsKVykydsSE++8MamKKDvuz0g==
X-Received: by 2002:a17:906:d7df:b0:ae9:ca8f:9642 with SMTP id a640c23a62f3a-aec4fa95412mr1174178266b.15.1752958645525;
        Sat, 19 Jul 2025 13:57:25 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:7706:e3e2:69b7:ae8? (2a02-a466-68ed-1-7706-e3e2-69b7-ae8.fixed6.kpn.net. [2a02:a466:68ed:1:7706:e3e2:69b7:ae8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca3001esm367235966b.89.2025.07.19.13.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 13:57:25 -0700 (PDT)
Message-ID: <dc05e447-06a1-4865-8252-c4a0710d6da9@gmail.com>
Date: Sat, 19 Jul 2025 22:57:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ferry Toth <fntoth@gmail.com>
Subject: brcmfmac: Can not completely turn off AP (BCM43340/2)
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
References: <20250407042028.1481-1-vulab@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <20250407042028.1481-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have an Intel Edison board with BCM43340/2.

I am currently running 6.12.39-edison-acpi-preempt-rt which is mostly 
mainline with a Yocto 5.0.11 (scarthgap) user space.

When I turn on tethering (using connman) it seems to be working fine.

But when I turn off tethering, connman seems to be believe it is off, 
but I can still see the AP with my phone.

After this wifi is dead (can not scan, connect, tether on again, 
nothing) and connman believes wifi is not supported. The only way to get 
it working after this is reboot.

While AP is up I do see in the logs:

Jul 19 22:06:34 yuna kernel: brcmfmac: brcmf_fil_cmd_data Firmware 
error: BCME_UNSUPPORTED (-23)
Jul 19 22:06:34 yuna kernel: brcmfmac: brcmf_configure_arp_nd_offload 
failed to configure (0) ND offload err = -52

But maybe more importantly when tearing down I see:
...
Jul 19 22:07:23 yuna kernel: brcmfmac mmc2:0001:1 wlan0: left 
allmulticast mode
Jul 19 22:07:23 yuna kernel: brcmfmac mmc2:0001:1 wlan0: left 
promiscuous mode
...
Jul 19 22:07:23 yuna kernel: brcmfmac: brcmf_configure_arp_nd_offload 
successfully configured (1) ARP offload to 0x9
Jul 19 22:07:23 yuna kernel: brcmfmac: brcmf_fil_iovar_data_set ifidx=0, 
name=ndoe, len=4
...
Jul 19 22:07:23 yuna kernel: brcmfmac: brcmf_fil_cmd_data Firmware 
error: BCME_UNSUPPORTED (-23)
Jul 19 22:07:23 yuna kernel: brcmfmac: brcmf_configure_arp_nd_offload 
failed to configure (1) ND offload err = -52
...

This has regressed from some older kernels (it used to work fine) , but 
I don't know exactly when, since I hadn't been testing AP for a while.

Any ideas are welcome to debug this. Or any patches to try, I can build 
on current kernel (6.16-rc6) easily and capture logs.

Currently I am using:
echo 0x1006 > /sys/module/brcmfmac/parameters/debug
journalctl -k | grep -e brcm -e "000000" -e ieee > debug.log

Thanks
Ferry

