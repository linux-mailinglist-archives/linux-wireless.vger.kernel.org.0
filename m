Return-Path: <linux-wireless+bounces-17040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569EEA00832
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 12:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3231884487
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5872C1B6D1A;
	Fri,  3 Jan 2025 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRbXs7D8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E438B;
	Fri,  3 Jan 2025 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735902172; cv=none; b=HFa97PYB7nVU5RY11aSB9TSG1FVGxrHSnbg+bvcOdodDcOEhJXnN7y95VEH+qRktEXFlODdaiG6ZIzQYM0KN7bRIgDjtaVDYoajCFS2Pv2ol+GxyRus0D7+sdnTKpKuBA0hZzT2XWK+AKoGvOIjRgo0omycV8wxVPTTzCdXXCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735902172; c=relaxed/simple;
	bh=/rOuOQCXPeEPXSdaRhoiaWfBCbmAh7K8VZCZZW8dAIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFswxjgKjmQhoNJOUG5KQt3udpAEzUowFdaYj9e5w1sJrDuWI6kWK7jQaElA9Ynrhxbu2ZWEjvhqEszO0SPdAFbstDtvty5VEuL0vOD3ibok8xq/EEm2v+KGqynaowdIzzosThozD7/GQ1zD3p9sS/Oh0E8dTBsYVDvNnrsZnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRbXs7D8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so19556180a12.0;
        Fri, 03 Jan 2025 03:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735902169; x=1736506969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rOuOQCXPeEPXSdaRhoiaWfBCbmAh7K8VZCZZW8dAIM=;
        b=kRbXs7D83xNoMcJyO8FH6HUfHqMKvl/fzbB3NwmB0ISMWQgCnY8WJ3nWNCSdTmpZwR
         EnOWGg+S6CtlX63VjdvbsAb6XsTQuZcF3DqRG+ZLxph0n9zhOm5Eeave/rKedfdAjjBm
         bhGS6zR4th5L4pYOV+s4oUWDjS2aYMcOpI8j2U4tlRt+Vyz9lR2kko5cPKNsug5BM1XM
         VT2YDoDtU1qDhyx2y0hDPggfRVq5izBguD8OUdCq5GW494kuUzfdSbAc8+3hYTWAdm0n
         pWGM5mO4F24G1Zu5NgrWZLhljReEAnN1HE0uxbJaboHvN/LUWKxF80CfOZZEVS7o61SO
         hSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735902169; x=1736506969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rOuOQCXPeEPXSdaRhoiaWfBCbmAh7K8VZCZZW8dAIM=;
        b=jqRI0YMubmqF/iigmn5B5XEDhMJ5Qj70IUtXpXYFIMkzX1Fdmvew3yvxfKHaWb3D9s
         np7/vUYJoB3w9Tc498DRQSYTpLI0J0C/mBdoATqyusw8+zo7SThY68vKR9biapnuiyYZ
         4hVgKo849zixa4emscvuyHwiF3PVJpckgL+nB9BHl0cNMLTm0CJnhyOkuKSX+A6yZCPb
         Ng/w/5jjUB1Ezb9l9gY6tdl9ZmJLBsBkLNlmciQLCboeHyFztpEnLz1hnf0Bqav+Hist
         0wwDOx1KutlADOFEemvXJwppkyiUOT8NMCwAWVx263gKuJz0Lau8TDoaQ/82quYkvPCd
         ye8A==
X-Forwarded-Encrypted: i=1; AJvYcCVCKhawskuqwnRsxDvAAKFt+ehrBS786ubDxeoYBLtpQLQHijvdxn0uBonOSo2Kp33uoObB94jO6M0+8Ek=@vger.kernel.org, AJvYcCVjdmfV51wkt4TZKqg2WW22Y6R0hcLTsQuB2I/VqsVfAZoI3l2BWwvUMNs5urMVYOXANIaY5Skj@vger.kernel.org, AJvYcCWA1l5Y3Xyn0LyJ+wktmG0B8bPEWHTVNStuSw/qCdZfTZLzQBbAK6a54YOj+uCEHJEN3bqBmX32SnkQqLUFX+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlqBMkYKO0oPYKxv5YEkx/Mo7CpSUwrAchwy4kw4fzA/Bi3ES
	c4xo2U4/uanaxom+4ub+G7mft4SbPyQ3Ca58VFaNzV0Q4CMKiQqo
X-Gm-Gg: ASbGncvj4MTtscoOFT9LttWPS9N5VpI6+ISNZhwPPjc1o07dUnadQ+R0iXH2+Vvb9Tz
	TC+pEQCb+AEXlGY8+A5aq626lRY3f6f4d3L4L/CGsFvx3anYhCCVw55fIQQGdTLWLpdNqI1mURD
	Lmc/MxwSPTyU8lOR0VFS9yuUOogQRMx/gXYbC7bp5Ih8I6BsOZYa6X3N6tr8ToAsOSAzpyWgeYy
	OzEHGymB0WdKEQ5r2JLVmoHaSTcxXvkU8DJ3YDtEE+K0caHmHJg+Wd39Vd1x2z7+A9YksU3lDFO
	EybIse/KBQNLtp3kdweDyriyR8CMP3afbqypW1rN
X-Google-Smtp-Source: AGHT+IELOj3ljb0yz/zpTAl091B9waIEdRafqL0QKOui6kqdPzcOHU9l3lR4G6t4WMgvS5W/cdGrCw==
X-Received: by 2002:a05:6402:26d6:b0:5d3:cd5b:64da with SMTP id 4fb4d7f45d1cf-5d81ddfd841mr38618019a12.23.1735902168650;
        Fri, 03 Jan 2025 03:02:48 -0800 (PST)
Received: from ?IPV6:2a02:3033:600:7448:4613:e00c:fbb7:1d60? ([2a02:3033:600:7448:4613:e00c:fbb7:1d60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701bf20sm19347935a12.83.2025.01.03.03.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 03:02:47 -0800 (PST)
Message-ID: <8dfe122d-ce0e-4a1d-9a2f-f7585036b989@gmail.com>
Date: Fri, 3 Jan 2025 12:02:43 +0100
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
 Gregory Greenman <gregory.greenman@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-staging@lists.linux.dev,
 linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>, Christoph Hellwig <hch@lst.de>
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
 <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
 <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com>
 <CAMuHMdVGdpVqkdvoFxu84YgBh_0fsAKeBhWFEg+nDyGLwbruig@mail.gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <CAMuHMdVGdpVqkdvoFxu84YgBh_0fsAKeBhWFEg+nDyGLwbruig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.01.25 09:53, Geert Uytterhoeven wrote:
> Care to tell us where the fix is?
Hi Geert,

please find all patches for T2 on this page:
https://wiki.t2linux.org/guides/kernel/
More exact here:
git clone --depth=1 https://github.com/t2linux/linux-t2-patches patches

Bye Philipp




