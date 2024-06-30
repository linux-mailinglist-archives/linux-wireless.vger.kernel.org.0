Return-Path: <linux-wireless+bounces-9725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2394C91D0C6
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 11:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A9DB20F9B
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0560112D1FF;
	Sun, 30 Jun 2024 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en4uil1K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62143BBC9;
	Sun, 30 Jun 2024 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719738914; cv=none; b=EIkRrn0L6ench/hwgY/ELGdxMfrRl/DbW+lp8/OjeinPnXQZJiHKi+osFq4cvkaS5+j87XGalCnfBnz+SclZcOao9ms1xt9NXMo5LDkoaT77u3ORI8mE8tiJxP8t3aU/kYzAKGJ0JOX2wn4aZwgAItmjrm0Ac4uCveBwZpcCkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719738914; c=relaxed/simple;
	bh=tc+Ufg00udHbrhXlW8SdH881js1R768qk0khtQCwXfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgnXa9UVacxspO0n9NWLqClYvJLkTJwugyPUfRIMo97jkFf9+xANkinwgm1kDugZc/eHUp8Olht2o3tymcvcImA0OLnBAfiPmp54vAsrTITiGAnl5U6lF8HJJrGoelpmNPk7e6axLEPyyld7qGu9vDhsGzMUfZ1Ot90y8F0ycRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en4uil1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE12C4AF17;
	Sun, 30 Jun 2024 09:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719738914;
	bh=tc+Ufg00udHbrhXlW8SdH881js1R768qk0khtQCwXfM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=en4uil1KnZ/7MbdeOWy8vNN5qJWiUXY0l2SbZobfjZ8oplSyoWMu1lOkjeF8flaH3
	 /HV9bJ7Vv9kKv17jPnFYwEukaevW6iRTUbbr5QDOdTbDZa3n6lDKP1nTClVwZpq8+J
	 oLaPu6sLyqwDf8E5OWmtJo7s5wiOFHtSqV6PrOxjaurK1T+ap5dnqpfGVBAeURsbSe
	 TFAgfJQljWDYaCUdX8gxQiYJybypsxpSCGjM1obpaU26PlmwrDoAjm1+7EE7AWAQTh
	 jcCs2X75RvRjSA5W7N6I/D1JRGNwVEi8P24nBLFrROD6E/ZZHuaJSCEo8rj9dPsIHL
	 Z81Vj7v43wiTQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso23743541fa.0;
        Sun, 30 Jun 2024 02:15:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWakp4fEobeJm555EldJIGf93SwgK4DltWYxvEErGotj/jvDoK+D3wwIodLG65l+oThfZBKfhlltKdItd+DE3Fx76cLIgDWRYe4usgkx+9vTZDrFVcwzXZ3631WMAQGLmUHVwmpCU8JXfCMbwg2QzeUcQR0ntaGpntRLQcpRj8t/ZwlvI5n2mR9edoQ1qbffykCX5ervYnO2I8xyckHKYCp
X-Gm-Message-State: AOJu0YyG6hh/+ijapfwEZc/3LoR/jwV7deq7lbgRrVap+nj+UWuJEiUe
	hE7T6oBC2yCHHIGNV5HmW144Srt0wWVqIc+2visdmcUD1NzX+cx5tgicTcS4CXk+PeJvHVuW2an
	i9QKKeL3qmmx0M1viOU7rTX9qfKA=
X-Google-Smtp-Source: AGHT+IHYW4n5GnYJwHXqY+6mUXvauoz57bZueShtW/YuVL9pXD9MpL3q7Rr5kG0lABD6uVFGXFXO7kcRPrfoJTzNisI=
X-Received: by 2002:a2e:a179:0:b0:2ec:4fec:8bda with SMTP id
 38308e7fff4ca-2ee5e6cd6a7mr18022581fa.36.1719738912735; Sun, 30 Jun 2024
 02:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630073605.2164346-1-jacobe.zang@wesion.com>
 <20240630073605.2164346-5-jacobe.zang@wesion.com> <bd661690-1de8-4030-a209-ef26d3559221@gmx.net>
 <TYZPR03MB7001AC28827A86338BF2B77380D22@TYZPR03MB7001.apcprd03.prod.outlook.com>
In-Reply-To: <TYZPR03MB7001AC28827A86338BF2B77380D22@TYZPR03MB7001.apcprd03.prod.outlook.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 30 Jun 2024 17:15:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Vk8SMs1TOs+80Jy5fXumuYqCx59Tzd_N7wJAfyysQcw@mail.gmail.com>
Message-ID: <CAGb2v66Vk8SMs1TOs+80Jy5fXumuYqCx59Tzd_N7wJAfyysQcw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] wifi: brcmfmac: Add optional lpo clock enable support
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, 
	"kvalo@kernel.org" <kvalo@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"efectn@protonmail.com" <efectn@protonmail.com>, "dsimic@manjaro.org" <dsimic@manjaro.org>, 
	"jagan@edgeble.ai" <jagan@edgeble.ai>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arend@broadcom.com" <arend@broadcom.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "megi@xff.cz" <megi@xff.cz>, 
	"duoming@zju.edu.cn" <duoming@zju.edu.cn>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"minipli@grsecurity.net" <minipli@grsecurity.net>, 
	"brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>, 
	"brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>, Nick Xie <nick@khadas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 5:10=E2=80=AFPM Jacobe Zang <jacobe.zang@wesion.com=
> wrote:
>
> Hi Stefan,
>
> >> WiFi modules often require 32kHz clock to function. Add support to
> >> enable the clock to PCIe driver.
> > the low power clock is independent from the host interface like PCIe. S=
o
> > the clock handling should move to the common code. Sorry, not i cannot
> > give a good suggestion, what's the best place for this.
>
> I think the clock is used by the PCIe device so enable it in this file. A=
lso I checked
> use of clock which in spi[0] or sdio[0] device was enabled similarly to t=
his.
>
> [0] https://lore.kernel.org/all/20210806081229.721731-4-claudiu.beznea@mi=
crochip.com/

You're looking at the wrong driver. For brcmfmac, the lpo clock is toggled
by the MMC pwrseq code. And for the Bluetooth side (where it really matters=
)
for UARTs, it is in drivers/bluetooth/hci_bcm.c. and documented in the
binding Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml


ChenYu

