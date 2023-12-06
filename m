Return-Path: <linux-wireless+bounces-505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB52D80786A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 20:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E05B1C20EE1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1656A339;
	Wed,  6 Dec 2023 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dP62dgct"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F00D40
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 11:12:06 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce9e897aeaso151876b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 06 Dec 2023 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701889925; x=1702494725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKXwDoSk6eUw/PYkuaUJ/DPKIhb1MBkA5JKGxmqSVm0=;
        b=dP62dgctc5dJOsUJ+PFQLCJfwenf3L/GUC2WUqdy0Xhdah+SYLgm+DUm3wvokHMrLh
         hCCzgwj6kcSaw3KANT6Uz2KMYnwsHSHq6+zLh1gXCXwWvU/YXtKwhkM3a+oOsfWlQH21
         JsURo4naAGz2Y+/rHfM/kE4vst0slvH5nKbao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889925; x=1702494725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKXwDoSk6eUw/PYkuaUJ/DPKIhb1MBkA5JKGxmqSVm0=;
        b=PLdoLCr2HQB7cVPpk9+SPLNg9ppMyqdIznrvcEMp4RIsInATSvIACZUi/QJwfNYzU/
         K09rF0TqKjFw3waJZsd5Vr1qgsY75PhSlZuf4myHOCIUP71AyMTnv6s53IztcGmC0Hi5
         d3a04ht3bl61U5yqrh8uQFpe1msrF5Q1Ypa8ZJIqMCND+i+ZeyxLsgS79Kt09adMls1L
         +12F7xOvGY4QA6jfXWcLJMyQzKiAKm7FGUGDER9skLNxGVuxFUYTlr2qWpfMpGl854J6
         6BgKBiFwKPgKpqJeaZe+StMj2slqJ2oSKqe9Hd0+uMwvs6l1Ndz03Fp4YG4UyItLTrla
         DcUw==
X-Gm-Message-State: AOJu0YxrE47i5PPIsY+K3Drm9VYh2pnPoo0UDtxLUtqA3t4JHiBMpOoM
	ILzGzmfP2MCkPdAJHjwVu2CAEw==
X-Google-Smtp-Source: AGHT+IGdJRzVucMlxYBD9wNKRYWyoxQf1P8oLxsAK6R5Gjm4KiXF/9EzQwaztA006gC8JiiBA7SkyQ==
X-Received: by 2002:a05:6a20:938e:b0:18f:97c:8a37 with SMTP id x14-20020a056a20938e00b0018f097c8a37mr1695396pzh.98.1701889925521;
        Wed, 06 Dec 2023 11:12:05 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:5038:905b:ae7e:e6da])
        by smtp.gmail.com with UTF8SMTPSA id k15-20020aa7998f000000b006ce742b6b1fsm330430pfh.63.2023.12.06.11.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:12:05 -0800 (PST)
Date: Wed, 6 Dec 2023 11:12:02 -0800
From: Brian Norris <briannorris@chromium.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Amitkumar Karwar <akarwar@marvell.com>,
	Ganapathi Bhat <gbhat@marvell.com>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Restore USB8897 chipset support
Message-ID: <ZXDHgo5QnZjb237S@google.com>
References: <20231205210237.209332-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205210237.209332-1-knaerzche@gmail.com>

On Tue, Dec 05, 2023 at 10:02:37PM +0100, Alex Bee wrote:
> This patch restores USB8897 support which was removed with
> Commit 60a188a2715f ("mwifiex: remove USB8897 chipset support")

Did you look at the reason for that removal?

"if both mwifiex_pcie and mwifiex_usb modules are enabled by user,
sometimes mwifiex_usb wins the race even if user wants wlan interface to
be on PCIe and USB for bluetooth. This patch solves the problem."

That sounds like a legitimate problem, even if the solution isn't
perfect. Do you have any alternatives?

I don't have such hardware, so I don't know its behaviors nor can I test
it. But it'd be nice if we could differentiate USB-only vs PCIe+USB
somehow.

> There are quite some devices which use this chipset with USB interface.
> The firmware still exits in linux upstream firmware repo and this simple
> patch is all what is required to support it in upstream linux (again).
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
> Recently I upstreamed support for Geniatec XPI-3128 SBC which actually
> has one any of those boards soldered to the onboard USB Host controller.
> Geniatech has some boards [0], [1], [2] (maybe more) which have this
> variant soldered the same way. (optional)
> I've also read that "Xbox Wireless adapter for Windows" uses this chipset
> (unverified).
> I've also CC'ed Ganapathi Bhat who last updated the firmware for SDIO and
> PCIe variant of this chipset: It would be great if the firmware
> for USB variant could get an update too, as the one which we currently
> have is quite old - version 15.68.4.p103, while other have some 16.*
> firmware. 

The old maintainers here seem to have gone AWOL, so I wouldn't hold my
breath on getting any support from them.

Brian

> [0] https://www.geniatech.com/product/xpi-3288/
> [1] https://www.geniatech.com/product/xpi-imx8mm/
> [2] https://www.geniatech.com/product/xpi-s905x/
>  
>  drivers/net/wireless/marvell/mwifiex/Kconfig |  4 ++--
>  drivers/net/wireless/marvell/mwifiex/usb.c   | 14 ++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/usb.h   |  3 +++
>  3 files changed, 19 insertions(+), 2 deletions(-)

