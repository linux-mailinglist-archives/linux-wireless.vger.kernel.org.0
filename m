Return-Path: <linux-wireless+bounces-17042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E86A00899
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 12:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F93A7A1787
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E941F9ABC;
	Fri,  3 Jan 2025 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxoM2NR5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C81F9437;
	Fri,  3 Jan 2025 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903735; cv=none; b=ehjNzelMTVXjHylpdU3vmwnFXm3jwcuN3ybk8kiKo0US8Ik1uj8y4qGDwJLKLK/BVcQ9FRHER35WU4fP4I8/+UJ2UDRJUnw9nBnYd3p+PLQMdXOwEQ2dKyzqMGpqVQwu9Alr2VOEY1R45H5WKYkMrWLE9jRYL94uIOqSdgOO0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903735; c=relaxed/simple;
	bh=U17cwY5+L9na4uLSzjw/cPO+Dtv1+qbGErw3xlcP9co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GC+hIrOY3suwp91Z6uNgn9QYHXmbmVvCWMk4xsduuYDJ2tHHriQn1LtKQZamHUaEpzioUnJ99y9Xph4P6EPHh8/H8kGGkZy0sjZ5Cx6krmKtulhoQL/vnV4lQSyEhkQyg5wv9UxztZchXi4kWtXAWcQbEPWSXAEENWJqZX2TDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxoM2NR5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so1411731a12.2;
        Fri, 03 Jan 2025 03:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735903731; x=1736508531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32PWNC7r6rHdSHh0MVozKUaF4TAx+dkDRht1Ruk2YR0=;
        b=JxoM2NR55d31Jiq1jHwkO1D900qmt4DWdsjSG8PsPxdw86mgO1j/shBHkgNVBBH5LI
         nUgG0y5vzJCFQ8xBDpEkXHm/3lk3XFhP2ZSSCv1huvTn4PjEltQOjVkXsQxM8pEGSC9z
         NOkRS7QqzUR+6cfIfU83X3CUJlhckbySqT40WgTQM8/1+QVnGEPK5YNJ0fT7Y9WK0488
         zfmSxm1KsJ5U+JmSawy4ZejBBAKurCDiRloifEO5Vuz9YTTkL1bJO1k9GMpLVnD4a7Vt
         UXSq93x7v4zBlZlzGXv7rTE/CDhNBlCH13dTdgAyqzJH1gryKZDX4YZEue3ljkHdYmLu
         rYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735903731; x=1736508531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32PWNC7r6rHdSHh0MVozKUaF4TAx+dkDRht1Ruk2YR0=;
        b=bMKtgFax6zpKAxL7BEg0FhwKm5lkuDD0Jqzn8IltGD7CAQnsX9l6VTSf/ei7BrpZ/s
         e2EDY+BlK2Cehm8r9tYoSKqsuHrnULqI7+MuywMEYuca00pAtaCk7NHTPPzndKBLI+Fm
         hZj3YA9owSePnqy96Srh/RiiYzrDzPIoYl4WcUaTIEVTIOyVwy5n3zHc/AyPDeIwH51U
         YaUsaLutfC69EWHtTZoV9610dXCZUldCthdMPnUtOFf61OwM/4VuNijP/ENVgPEhfhFl
         qjy4YQvrwWIWnPbTTD+cBm43CtUE8lF4XHFWE38HVACMnSVeTdNuQJmUed40+ECZyg2P
         mptg==
X-Forwarded-Encrypted: i=1; AJvYcCVJd4j8Ulrnu747UkXivixPWz953vrZX8GuFC5hIXiUNKHIFo73sO8g4PZZN+Un2JiFw1RK32nl@vger.kernel.org, AJvYcCVP86vQeZlKXrKtBTc98xvwOuX0J/e9icJoB1ImCtCsydQVpxdE4cu44Fb3m7Hhfr6cTQvd24Hgmna13dQ8bFQ=@vger.kernel.org, AJvYcCWS28j/pp15ck2h98AYhxv2LHCG7OfzXmHCGFG7PFjCNVYYlIsHeqBShFPubtnhP4uH899I3hv0+2YQ+vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5LFAW5XDajHUoWceillRO3HqT/AFXdW7Po9GHMHI1CANV4eA
	0n3VHpnHHBv84UdFAGiaoQdIdjBt4hMxsGEGpEqEN3gBw6vLLJS/
X-Gm-Gg: ASbGncvHwevjz5XemrgGtTA2s/gf1izn/5R5JR0Y43q87rAvoDM3GzW0g13r9cN1c+6
	JxHg/4jGgSl7RHEwUebnl2ZEfkCTDAwnFXeVQvzQ4SYl6cutRJ06EKtx69nS3iwP0+WC7vW7HHd
	nW+mrfaaquLprNrfF6CksDd86WjbyoUYUPMiiVMsQ0NA6ejs12Mfvb0d41OA2Hu6pl0TvqhNgqs
	SwIh8QPEhFELAaTIIuixlSIf/z4SQvZz8Qq0g1KLJqaZ+QE5RoigppLYczibBYML2zbzecmRK1c
	p6czltN0bKQY0P6+xz+IVsW2Ukj+Q++DCOvIAdFX
X-Google-Smtp-Source: AGHT+IHEcdLqUHL2H3ucyXJoB8McZg4PpIJmWOrwxm+YDc8ziukB1qD/VdAnjm5hkaddAJsOcvw6OA==
X-Received: by 2002:a05:6402:2809:b0:5d1:2377:5b07 with SMTP id 4fb4d7f45d1cf-5d81dd4ef8emr43942219a12.6.1735903731101;
        Fri, 03 Jan 2025 03:28:51 -0800 (PST)
Received: from ?IPV6:2a02:3033:600:7448:4613:e00c:fbb7:1d60? ([2a02:3033:600:7448:4613:e00c:fbb7:1d60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701abc6sm19336866a12.75.2025.01.03.03.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 03:28:50 -0800 (PST)
Message-ID: <9e7e5b13-ece0-462b-bfa9-21a395612354@gmail.com>
Date: Fri, 3 Jan 2025 12:28:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: toshiba: ps3_gelic_wireless: Remove driver
 using deprecated API wext
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geoff Levand <geoff@infradead.org>, Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Pavel Machek <pavel@ucw.cz>,
 Stanislaw Gruszka <stf_xl@wp.pl>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-staging@lists.linux.dev,
 linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>, Christoph Hellwig <hch@lst.de>
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
 <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
 <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com>
 <CAMuHMdVGdpVqkdvoFxu84YgBh_0fsAKeBhWFEg+nDyGLwbruig@mail.gmail.com>
 <8dfe122d-ce0e-4a1d-9a2f-f7585036b989@gmail.com>
 <CAMuHMdX_P9WGBiShm6Dp64Y9GRvESH-Nn=b=rRrsGbwza81VeA@mail.gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CAMuHMdX_P9WGBiShm6Dp64Y9GRvESH-Nn=b=rRrsGbwza81VeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.01.25 12:16, Geert Uytterhoeven wrote:
> Hi Philipp,
> 
> On Fri, Jan 3, 2025 at 12:02 PM Philipp Hortmann
> <philipp.g.hortmann@gmail.com> wrote:
>> On 03.01.25 09:53, Geert Uytterhoeven wrote:
>>> Care to tell us where the fix is?
>>
>> please find all patches for T2 on this page:
>> https://wiki.t2linux.org/guides/kernel/
>> More exact here:
>> git clone --depth=1 https://github.com/t2linux/linux-t2-patches patches
> 
> Thanks, but I cannot find a ps3disk fix there?
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

He Geert,

I think there are some regarding PS3 and also Sparc, not only ps3disk.
You can leave this to me. I will go through it. If anybody else is doing 
this please CC me so we do not do the work twice.

I am OOO so it will take some days.

Thanks for your support.

Bye Philipp









