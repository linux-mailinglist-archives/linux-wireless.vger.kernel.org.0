Return-Path: <linux-wireless+bounces-17032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00482A00649
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 09:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D61D1881B9D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE11C5F09;
	Fri,  3 Jan 2025 08:53:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588494C62;
	Fri,  3 Jan 2025 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735894425; cv=none; b=sIqgndiR0vqOr0y50lpSTHIZZixBeGjO4t9mhykFGGaHE6ab2neKil4L3R04H4o7SQRXL4Z8fajl9CcV13oZa0niIQftC5LlvvxpccrVBvyAcHY0ZsW2MJ4A3tDvJhbniEbADREkxs66wdNMzghwCz1mf+bHwArjtkukFA6I+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735894425; c=relaxed/simple;
	bh=hnBq03WxBk2PG7EPavzS0kBmjxZJX+qxr5LBLBcNk+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKvMCAFA723yft6jwoMhWU+VpjfINIqLRauufistLhfHhli0xlvL4zMHJ9C1N5fQ9ISvZM0iUw4A/VMbSeZvAfZErVxxRlszlqTildvi0UH6TsEOumLWnNL7DPuWLO7nsvqfeGZD/D6o8yATxzef+vZqn7JS63S4ZkYOYrM5iiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51878d9511bso3484842e0c.0;
        Fri, 03 Jan 2025 00:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735894421; x=1736499221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j30abThuUeHkj5Ij3LGKLh6rqpnb67GZgQG4O9gJV1M=;
        b=gPTwaSqoHknGBvVxgMhyCJm09bM+SiANtOjWhwFKq7kI+KlR+KztyiMMK94p0lUju8
         KstY0xXLDVYPlKFVSJrY288/z829yIIwniF8AQYvFwubucThGgLYe4S8gtppxuaEsOXA
         InY7ANm8Cn4cmEuWicc44oB59mXc/wZwYq70pHLjL7YP7zQTDSAIVMiRl/9QH9kg4//G
         XAKhoK7M8HW9Y6cIscLujBtpnA8WtWH8I4OBFIC5hHEIvPnluymIXkY/aNhOqwtLPhDj
         QnMSPfWQIgHyYkLSgDaBsdBwkYKjJLU2DXiXrFAt3rbJS7QtEVNsAuTb3glc3WCfM4tI
         2Tdw==
X-Forwarded-Encrypted: i=1; AJvYcCVRiL7aoS83MptbJoU7qNiYG5yhdQ5Rfml9GJE7LAAiICn5DfeKPG5WCZif4/S6HxPxe3lTGjDLDv3yYOk=@vger.kernel.org, AJvYcCXNwEs6EswPk7wRTkdcT0MfeVH0g+zN1XP2jyU3j3bNk1yLH7KqVmraHMET/91a5ROnVN2wrG3VEPdDcVzDI1w=@vger.kernel.org, AJvYcCXXRvIyr/DI78z4ycVV+/oJ5y+Fv+6bZC9mzoTzSJIDR9QoMLHLgq9rgU2YxIs2pDfQOn2L5i4M@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7gxo+CpwBZk+R5E1ioJskW5NsXqs6s4ZU70/2vxA7qpv3Sa6
	dO5tq7/++EnaWUp5oocoYJLQqrkGtxLhfKDh+ahHMpBIK45ciy4RoV9sFbjo
X-Gm-Gg: ASbGncvIxtpCjjkCZILwqVzJDC3SzxtYIu0d/dkJGY/m0m2Tef26BqgZuYp79nIyb+e
	59iRLIBUw3XApjOJCpabC3JRRj1pTKDf/u5PBlhLbO66LRm+EjuBpHtfS3zO2R0015vFE5zGE5r
	p9KhvjMSW5tj0eNwtypUeFkyCIxRSvKiWk1sapDAnqLojOLt8wR6Rs48gWbTmyn4aq2o3ZY3Hxh
	dqLj3BwHeclixboqr6mWF14KhBRHk/rI5LmZKvwaEhzpYBbdTxHAfH55KumcUH+WmRFFudNKZOJ
	E6R0Ds9RU3Rhacluvmc=
X-Google-Smtp-Source: AGHT+IHYZTID8FLH83OiPee0ltfKHbHyS0FaQxXgHt3Nfk8yMFb93SAt68MWCv/tticBZtpqx69eCA==
X-Received: by 2002:a05:6122:25db:b0:51b:b750:8303 with SMTP id 71dfb90a1353d-51bb75083dcmr20282265e0c.11.1735894421059;
        Fri, 03 Jan 2025 00:53:41 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b7f003249sm2870172e0c.40.2025.01.03.00.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 00:53:40 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85b8c94a6b4so2454190241.0;
        Fri, 03 Jan 2025 00:53:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9Vs7/QONNIlahBG35u6zJkfsdqG13Ewqh1IwVIICkNE6UyGAuS+Gf+Gvkc8Za66L00LISrrHEV/3dkI4=@vger.kernel.org, AJvYcCVcPg7iywaumaIN12TzrOIOfT8RsYOkvkcz8LJiqn+dIJDhxBE6Zdjr7udvWm82IWr1/KndyF/G@vger.kernel.org, AJvYcCWqbkjw/mE1EuSq+AAJ4NpMqy12dOYnOgzIjz/Dyrri1XOp47S/CFTa4KYcDFj8jnovrOQgz/jDum3OK6Dwlqg=@vger.kernel.org
X-Received: by 2002:a05:6102:160e:b0:4b2:bdf1:c1ba with SMTP id
 ada2fe7eead31-4b2cc380883mr40018988137.13.1735894419660; Fri, 03 Jan 2025
 00:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
 <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net> <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com>
In-Reply-To: <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Jan 2025 09:53:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVGdpVqkdvoFxu84YgBh_0fsAKeBhWFEg+nDyGLwbruig@mail.gmail.com>
Message-ID: <CAMuHMdVGdpVqkdvoFxu84YgBh_0fsAKeBhWFEg+nDyGLwbruig@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: toshiba: ps3_gelic_wireless: Remove driver
 using deprecated API wext
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Geoff Levand <geoff@infradead.org>, 
	Simon Horman <horms@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Larry Finger <Larry.Finger@lwfinger.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Pavel Machek <pavel@ucw.cz>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Gregory Greenman <gregory.greenman@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Stefan Lippers-Hollmann <s.l-h@gmx.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

CC hch

On Fri, Jan 3, 2025 at 7:44=E2=80=AFAM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
> T2 is working but to make this happen the T2 Author has an own repo for
> patches to apply. In the following video he publishes his view on how
> well the ps3disk is maintained and tested by the linux kernel community.
> My impression of this is that ps3disk is not tested on hardware at all.
> You can find this in a youtube video: =E2=80=9CI can't believe VIP Linux =
kernel
> developer BROKE PS3 support=E2=80=9D but watch out that you are in a good=
 mood
> otherwise it is pulling you down like me...
>
> The commit that is breaking the function is:
> commit a7f18b74dbe171625afc2751942a92f71a4dd4ba

Thanks, I see no evidence of this ever being reported upstream, which
makes it rather difficult to be aware of the issue...

> This fixes are not in Mainline up to today. So who beside T2 Linux is
> using this? You can find more of those breaking patches... and videos...

Care to tell us where the fix is?

/me looks at the bad commit...

Oh, dev->bounce_size is used before set. Patch sent.
https://lore.kernel.org/06988f959ea6885b8bd7fb3b9059dd54bc6bbad7.1735894216=
.git.geert+renesas@glider.be

> The following points are also in the list of reasons:
> - This driver has a maximum 54MBit/s as it supports only 802.11 b/g.
> - Using this hardware is security wise not state of the art as WPA3 is
>    not supported.

If you only do VPN over such an insecure link, I guess it's still safe?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

