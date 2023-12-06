Return-Path: <linux-wireless+bounces-506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24B580786D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 20:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52808B20DCF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2974660B96;
	Wed,  6 Dec 2023 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H6smL0l6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E866DD44
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 11:13:43 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c659db0ce2so83144a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 Dec 2023 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701890023; x=1702494823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9JTl2Ob5990E2xo2ynBpvDirXKr70Qj24AYoBKEABw=;
        b=H6smL0l6yi7qXtoQMqD3d7rlecjM9KbFlvKR5aoYnz001g+ZjM3xNJPnf2ijR+HTok
         bZj+HZUin8nTk5E87k0xmD8Rc5RZPRTJHnaXhgUzR+kNdhmG0Ri79iGCwh+hvGWpfxaP
         ITEYtDO/OaMEBthdrtXUFwcpSEZNgxnJ+hN5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701890023; x=1702494823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9JTl2Ob5990E2xo2ynBpvDirXKr70Qj24AYoBKEABw=;
        b=h2nMS1uyscVdc7wfYcQfR6fotZRmVZgeAWvlMwil5LeNwV0/rq7gg1O8ou8ykb6sf0
         s0Z0DfRRnO29qzPjWNL+mgcOHOXX0CDpUGBB45RGxXU9SIrUs1PAkM1haKmzg1nnKWDh
         pFABlNXnVgpBW/3jHRnmToy9spF5oChdoxzDXGX/GaB9K/hmlWJFSiW+u7JnraOTNE+5
         aPvVQ2tCmo5KxSokBP0ZDTyNraUdjVfBcV9PrEtV8YH0ciU9MzsOj4n4A6zyAiAzn1X2
         +n7xWwh6/E2KGf0r3tLm1mH6XgAAdHr4m5LrlGL2C9b2wVhRbbPbwgrA1raKdcaV1BM1
         pqtw==
X-Gm-Message-State: AOJu0Yxtabo5GuHFcgoZ1F/3RPC3piEiNrT48ub3LmzmU62tOVjunUM2
	i6FatEoqtm5+/es/boTxXyZOvw==
X-Google-Smtp-Source: AGHT+IH7OUxc5WA/EaAqeHciu7u12n2fYF7bSOYPD35YM1E/5mRG8hyDMQjaN11W3CPwVzZxpjYK/g==
X-Received: by 2002:a05:6a21:8195:b0:18d:c72:63b3 with SMTP id pd21-20020a056a21819500b0018d0c7263b3mr1518317pzb.16.1701890023286;
        Wed, 06 Dec 2023 11:13:43 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:5038:905b:ae7e:e6da])
        by smtp.gmail.com with UTF8SMTPSA id y13-20020a056a00180d00b006cde06a7b66sm320845pfa.172.2023.12.06.11.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:13:42 -0800 (PST)
Date: Wed, 6 Dec 2023 11:13:41 -0800
From: Brian Norris <briannorris@chromium.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Ganapathi Bhat <ganapathi.bhat@nxp.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Restore USB8897 chipset support
Message-ID: <ZXDH5S7rM32y48Fc@google.com>
References: <20231205210237.209332-1-knaerzche@gmail.com>
 <ZXDHgo5QnZjb237S@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXDHgo5QnZjb237S@google.com>

(Altering CC list; sorry, I didn't notice the RESEND at first)

On Wed, Dec 06, 2023 at 11:12:02AM -0800, Brian Norris wrote:
> On Tue, Dec 05, 2023 at 10:02:37PM +0100, Alex Bee wrote:
> > This patch restores USB8897 support which was removed with
> > Commit 60a188a2715f ("mwifiex: remove USB8897 chipset support")
> 
> Did you look at the reason for that removal?
> 
> "if both mwifiex_pcie and mwifiex_usb modules are enabled by user,
> sometimes mwifiex_usb wins the race even if user wants wlan interface to
> be on PCIe and USB for bluetooth. This patch solves the problem."
> 
> That sounds like a legitimate problem, even if the solution isn't
> perfect. Do you have any alternatives?
> 
> I don't have such hardware, so I don't know its behaviors nor can I test
> it. But it'd be nice if we could differentiate USB-only vs PCIe+USB
> somehow.
> 
> > There are quite some devices which use this chipset with USB interface.
> > The firmware still exits in linux upstream firmware repo and this simple
> > patch is all what is required to support it in upstream linux (again).
> > 
> > Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > ---
> > Recently I upstreamed support for Geniatec XPI-3128 SBC which actually
> > has one any of those boards soldered to the onboard USB Host controller.
> > Geniatech has some boards [0], [1], [2] (maybe more) which have this
> > variant soldered the same way. (optional)
> > I've also read that "Xbox Wireless adapter for Windows" uses this chipset
> > (unverified).
> > I've also CC'ed Ganapathi Bhat who last updated the firmware for SDIO and
> > PCIe variant of this chipset: It would be great if the firmware
> > for USB variant could get an update too, as the one which we currently
> > have is quite old - version 15.68.4.p103, while other have some 16.*
> > firmware. 
> 
> The old maintainers here seem to have gone AWOL, so I wouldn't hold my
> breath on getting any support from them.
> 
> Brian
> 
> > [0] https://www.geniatech.com/product/xpi-3288/
> > [1] https://www.geniatech.com/product/xpi-imx8mm/
> > [2] https://www.geniatech.com/product/xpi-s905x/
> >  
> >  drivers/net/wireless/marvell/mwifiex/Kconfig |  4 ++--
> >  drivers/net/wireless/marvell/mwifiex/usb.c   | 14 ++++++++++++++
> >  drivers/net/wireless/marvell/mwifiex/usb.h   |  3 +++
> >  3 files changed, 19 insertions(+), 2 deletions(-)
> 

