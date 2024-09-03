Return-Path: <linux-wireless+bounces-12407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F4F96A6FF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212F2283E22
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A81C7687;
	Tue,  3 Sep 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1F7Uwdp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50B1C6F7B;
	Tue,  3 Sep 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389966; cv=none; b=a8vTxcTNbsX4g+0XTizP7P8Oa4eBcFD3CmG20lsjxHyJLg/i98s2k6I1He0TgQxjqCbDGazp3rCqH10scf/ebq1+wc7E/nzYTf6jlCOmj5oNqW4sdClLk2xmhqZh3YdAP3vQzjQblpN2yP4WwQ1dCPuySOoTAJ3vO682ZxsfHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389966; c=relaxed/simple;
	bh=9TTFd2hhLualP7P0anivRWZJQY9eJQxI1ngy05lrXxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpDmymoLsrdL7wdhCHTs44IoYUHYW01aY4hFI1moC98MLbAXV3p41w/K9e6Gqb/gBeLJNoQlL4e6HzpNyH+XrX8gx0CBGJOC97PjlBjepQAXLdQNVwFePOusKouBlUYWuC6F5An0XxczORXJ9PpACgMQSyUTNG9ak44AycGfimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1F7Uwdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1ACC4CECD;
	Tue,  3 Sep 2024 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725389966;
	bh=9TTFd2hhLualP7P0anivRWZJQY9eJQxI1ngy05lrXxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J1F7UwdpA/pPZEwuZ0/4B+dyQecUZs4ue4kj+s2CJEyPYfHPZ0IqIEJOgD3Ifhorx
	 5qMQc8p2qsGAGR9PPwxY9F2GjEfx2J9/X8wMagcmlpMy0GAGaBedOOiO/PT/oyqrlB
	 C8HqFblUQ905PsjMgdgNV5ftgrRJJRB8r4+njGopFECEoSKrtgJe7QtYL76ssT3E0G
	 kW2RBzcGNjIUnx4QxV6/rgUR1A+sbfP67u4Hx3nU7DmTxE7ijdJOpaJLhzHiP9g3Yd
	 gCT0r06mtKL3lS7yikFsz7UR2Wf12g+lGZcRwizQ2K/b56Oq4UdTYc1jUQIAfPzQc2
	 KBcc6yWpODipw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5343d2af735so5630239e87.1;
        Tue, 03 Sep 2024 11:59:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUe2hfD/BMdqCHn0fVZCLVzo9p6SmTBWxQnBo+IbzeHCtfRnfTdFULvQDZUqhzhApVrPtozdmKRmYRxeFHtAaE=@vger.kernel.org, AJvYcCV5wGXPampX2hK6/vsEbNlbnXjKpgRhfuFYlV/Xe3mn//saIXU/3Ppxp/nNg057jm5Q9R5eqmQbX3B68mmj@vger.kernel.org, AJvYcCWzvkCJBOwuIfhdHD+sDYyjfnWGwZSQtjrhTckZEUnUyk+VLEl6+1jnyUi4NKP4cFX8wLc40n7b@vger.kernel.org, AJvYcCXZxC87KyH4g79omGOdHlAwMvyDC4e8klMo/QTpd6XQNYMSstYERHMymD6YesOXOEqbAai9AHPR9ycp@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmWtvaZEFW8fm250Gjap1jTkJzUzlW2wQNKEgk3vkGZkGRNlc
	NB2s1SzZFMbKIUBR6wiWq0CSaOaIEPymr5IDeJpzM+nBVRYnB+Xd6zwuhk51LjMf7+0ehJwxjSy
	kYA7sXLBvfpi+xXojBCDXngL79g==
X-Google-Smtp-Source: AGHT+IFpL/WAwaJEUddqnN23QW8H5LGR9Grih1m7MNNFfq750+qLMqm2X5GBNRTbFyO1BzABy+6jr6rWs+y4p6UfciU=
X-Received: by 2002:a05:6512:3d8d:b0:52e:7f18:176b with SMTP id
 2adb3069b0e04-53546afd8famr11677026e87.11.1725389964567; Tue, 03 Sep 2024
 11:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902225534.130383-1-vassilisamir@gmail.com>
 <20240902225534.130383-8-vassilisamir@gmail.com> <172537438003.978249.2559307502514402788.robh@kernel.org>
 <ZtckM-uRzxAnS15o@smile.fi.intel.com>
In-Reply-To: <ZtckM-uRzxAnS15o@smile.fi.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 3 Sep 2024 13:59:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+bQx-0KsN3ZWsZbQuAs0rV9DDTAjT_jJy2OBfH1WXeA@mail.gmail.com>
Message-ID: <CAL_JsqJ+bQx-0KsN3ZWsZbQuAs0rV9DDTAjT_jJy2OBfH1WXeA@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] of/irq: Make use of irq_get_trigger_type()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, nico@fluxnic.net, pabeni@redhat.com, 
	daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com, 
	saravanak@google.com, linux-kernel@vger.kernel.org, mripard@kernel.org, 
	edumazet@google.com, netdev@vger.kernel.org, 
	brcm80211-dev-list.pdl@broadcom.com, f.fainelli@gmail.com, 
	linux-wireless@vger.kernel.org, airlied@gmail.com, linus.walleij@linaro.org, 
	brcm80211@lists.linux.dev, andrew@lunn.ch, devicetree@vger.kernel.org, 
	linux@armlinux.org.uk, alsi@bang-olufsen.dk, tzimmermann@suse.de, 
	kvalo@kernel.org, arend.vanspriel@broadcom.com, 
	maarten.lankhorst@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 9:59=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 03, 2024 at 09:39:43AM -0500, Rob Herring (Arm) wrote:
> > On Tue, 03 Sep 2024 00:55:34 +0200, Vasileios Amoiridis wrote:
>
> ...
>
> > Applied, thanks!
>
> It was fast :-)

You're right. I didn't really look at that and was catching up from holiday=
s.

> Vasileios, consider my previous comment as a material for followup,
> if Rob likes the idea.

Yes. I've dropped the patch for now.

Rob

