Return-Path: <linux-wireless+bounces-10396-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA2937CD5
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 21:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472251C21428
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 19:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6BE1482F3;
	Fri, 19 Jul 2024 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WjKCmP3O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640D8C06
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415906; cv=none; b=T4giFsC3UI67kHXnYL3hAUOHRYfV3R9PC1Y8vjysAtiiiJjUK/09NbTYdUab2faemBX02puC02gAXVkz1PZZ+Jezz6m+e8s9ENF3EiNM7gH6ZoOyDDWpU49oJFuSj1yrXl03tGKZOwJL69kYxesWITKa/pBZIGBcd0BV6IilC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415906; c=relaxed/simple;
	bh=J0iZWzPv9tuzSn96jNkzFCrECkH9O3OQra/Km6dfIS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8WczPHCdBIwkmLGa2nJg9D6+PV97/+n5+v3pL8a4W1ocR71sVdb555aqpqRbHJgMev83F1LhxNoCrIr6weJcjYPEpFbBnur35Kd3gkfn8hY+lfnr2pL4/j20oDrN1efYR0vcmKD0uRqKtyp5iZL4jYhRnwS2aNnr7I0YzkAnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WjKCmP3O; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b7a528331so753712b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721415905; x=1722020705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKleR+lXMztIafiPT9HsuWNtnPTeHMXhs4SK2dagfFE=;
        b=WjKCmP3OGTf05ADpfhDOcYl3iU3lN30CHEHYozL76G8moh2DXP9hPnPkWNl/DHjitl
         A82wJIdKMvZ3K2B/3IBF9JstHtxob2uQ3l8AsSoUzFFXtO1MfLekm0RojOtpfO0+0+gC
         seMhew3f1s1ZhuiYSG3HiQc+mzu5JMz3YZxqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721415905; x=1722020705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKleR+lXMztIafiPT9HsuWNtnPTeHMXhs4SK2dagfFE=;
        b=Jc/BifpbXc96fGp3HEeOJ7dUhZ3o31Tq2gzVP4oMc1ASQTk1Ifb/qKkUDGxsfvLtFq
         0b38HCFy06L0GvpYlvLYKqTzfQG8dcPE2sVhP37LRm2vORm8exK4HKEjjyH0Gl/NJDPL
         pf5fgxRZdezNV3zuu5El/6d69/7k+/lbZ98+leT+kSu2jPCa77+TFzeBuZrBLY+GhFn2
         Kr92SW5xG2VvOAgeH1PfLOg6yL4W4q1UEbjON9WsYebWBkVcs86Wf/Frqt81PXafhYQX
         Aq2Qb5qrjacT8YN0VEtzRzLI0h7weFY8Lde4hcjlv6+hhmnFCWAkUDY7AwxcJNdCUUHv
         0PPw==
X-Forwarded-Encrypted: i=1; AJvYcCXbzf/5IK8kaUxmaKdeaLya6FKYfMmQnh4lKcPoG+BoNp07mVFq9duwTLF5q1m/cwePldEARzCjbPqZNhKNaGK0yAm5QmqpgQCSmV53I5A=
X-Gm-Message-State: AOJu0Yw0K7QmmYeXpzjYbvza55kjrw+dg79vCI2SRQtzRcetNj8dY49R
	0gbuE+Dc4hupwBEspU82u4dOu/dbI+ZrEJkKPEBJU9S4QBRLbschBcgdNyRdNQ==
X-Google-Smtp-Source: AGHT+IEbkQzzNCnmyDj+uI6xoOE+O1v8XWzQ5R3YOoTXExBP8AHsDBfBXCO/euBcJOYg+9/xxZwilw==
X-Received: by 2002:a05:6a00:b49:b0:70b:1811:3efa with SMTP id d2e1a72fcca58-70ce507e02dmr11257102b3a.22.1721415904520;
        Fri, 19 Jul 2024 12:05:04 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:bc77:954b:4e8f:b43d])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-70cff59e2d7sm1552552b3a.170.2024.07.19.12.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 12:05:03 -0700 (PDT)
Date: Fri, 19 Jul 2024 12:05:01 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH v2 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <Zpq43ZxnICn5vEIu@google.com>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com>
 <ZpoCC042qMcOQ83N@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpoCC042qMcOQ83N@pengutronix.de>

[ +CC David, in case he has thoughts ]

On Fri, Jul 19, 2024 at 08:04:59AM +0200, Sascha Hauer wrote:
> On Thu, Jul 18, 2024 at 03:55:18PM -0700, Brian Norris wrote:
> > On Wed, Jul 17, 2024 at 10:30:08AM +0200, Sascha Hauer wrote:
> > > This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> > > method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> > > using key_mgmt=WPA-PSK-SHA256.
> > > 
> > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
> > >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
> > >  2 files changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> > > index 3adc447b715f6..1c76754b616ff 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> > > +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> > > @@ -415,6 +415,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
> > >  #define KEY_MGMT_NONE               0x04
> > >  #define KEY_MGMT_PSK                0x02
> > >  #define KEY_MGMT_EAP                0x01
> > > +#define KEY_MGMT_PSK_SHA256         0x100
> > >  #define CIPHER_TKIP                 0x04
> > >  #define CIPHER_AES_CCMP             0x08
> > >  #define VALID_CIPHER_BITMAP         0x0c
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > index 7f822660fd955..c055fdc7114ba 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > @@ -60,6 +60,9 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
> > >  		case WLAN_AKM_SUITE_PSK:
> > >  			bss_config->key_mgmt = KEY_MGMT_PSK;
> > >  			break;
> > > +		case WLAN_AKM_SUITE_PSK_SHA256:
> > > +			bss_config->key_mgmt = KEY_MGMT_PSK_SHA256;
> > > +			break;
> > 
> > I feel like this relates to previous questions you've had [1], and while
> > I think the answer at the time made sense to me (basically, EAP and PSK
> > are mutually exclusive), it makes less sense to me here that PSK-SHA256
> > is mutually exclusive with PSK. And in particular, IIUC, this means that
> > the ordering in a wpa_supplicant.conf line like
> > 
> >   key_mgmt=WPA-PSK WPA-PSK-SHA256
> > 
> > matters -- only the latter will actually be in use.
> > 
> > Is that intended? Is this really a single-value field, and not a
> > multiple-option bitfield?
> 
> It seems that when only the KEY_MGMT_PSK_SHA256 is set, then
> KEY_MGMT_PSK also works. Likewise, when only KEY_MGMT_SAE is set, then
> also KEY_MGMT_PSK_SHA256 and KEY_MGMT_PSK work.
> I gave it a test and also was surprised to see that we only have to set
> the "most advanced" bit which then includes the "less advanced" features
> automatically.

Huh, that's interesting. So these KEY_MGMT* flags don't really mean what
they say. It might be nice to have some additional commentary in the
driver in that case.

> I could change setting the key_mgmt bits to |= as it feels more natural
> and raises less eyebrows, but in my testing it didn't make a difference.

That would make sense to me, but I think that's in conflict with what
David Lin said here:

https://lore.kernel.org/all/PA4PR04MB9638B7F0F4E49F79057C15FBD1CD2@PA4PR04MB9638.eurprd04.prod.outlook.com/

"Firmware can only support one of WLAN_AKM_SUITE_8021X,
WLAN_AKM_SUITE_PSK, or WLAN_AKM_SUITE_SAE."

If that's true, then it seems like we need some kind of priority
conditions here (e.g., if PSK is provided, but then we see PSK_SHA256,
let PSK_SHA256 override -- but not vice versa). That might be pretty
ugly though.

> BTW wpa_supplicant parses the key_mgmt options into a bitfield which is
> then evaluated elsewhere, so the order the AKM suites are passed to the
> kernel is always the same, regardless of the order they appear in the
> config.

I hear you, but that's not really how we define kernel APIs -- by the
particular implementation of a single commonly-used user space.

Brian

