Return-Path: <linux-wireless+bounces-5159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1988764F
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Mar 2024 02:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92375B21A52
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Mar 2024 01:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74273A31;
	Sat, 23 Mar 2024 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DWrLVsnB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90A7F
	for <linux-wireless@vger.kernel.org>; Sat, 23 Mar 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711155986; cv=none; b=s4CtdAfGGGzJucrtxtJUBbrTjz0d9BaJ6k7WJ2afBZA37dgkvAWP2jwk5KtK+twPD6/nEygqLkg4wUyrC5CZcFp0xcmIjvKmWif7EL7nIOg/0/5rqcJZItOW1ih6tpsNo9yGW9vvo+QVV2FOBopdQPIgGerKyjwEbBkCZU9OPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711155986; c=relaxed/simple;
	bh=3gLvESUK5UC75YDBVHWZc2EJ/CKDDBHHCcGPHgFUCRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU/Bk1J1I0UUZGjsR20Dybs06WjAGQLYDl319n8M9+2bkg09VDybdiKKQzLRlUvK4aEG2S+7iIIJ1/9uYVStjaJlnKfg7thfILA1FIEp7adsCuU8wkca8x7Gd1KNDZT6DL4+fo6YwwJCIT7OSilZiYGDVVz8Xsdo9EtJe2IoSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DWrLVsnB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1697496a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 18:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711155984; x=1711760784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoGw6YHEdglNmqSwRO2JM8exateakHGbGs5iaMd0pYI=;
        b=DWrLVsnBSBhmDeE6oTdkS+Jiyp3sqU/Lf8S8ilR0XrAMu+DvVkNbvsoo1HAygz1IaS
         8yWwNwfEvVyc2wOJT+ZQTWAHWlSumOJo33AZ47YH4b2ySUiimQ0Ny1vCw/bvdZyajc6p
         zMwg0hLgqQTrHdSDcaHeMcMXF/QISjpj2V5uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711155984; x=1711760784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoGw6YHEdglNmqSwRO2JM8exateakHGbGs5iaMd0pYI=;
        b=dy3LjP9qOMz1B5aLt8N3JsoCB4AJRBTKvWee74E1TFrzlifoggzV6/Y28UyxnIIF/i
         Ebfocq5wC4jeViBUdhgE3a/VSHmMMl7GAMBiInifQk2awZoF+isWIbWo0wU0AqNKGqCO
         KY7dxIOP5pWJvP2JoR9sJq1LFRONM3O4VxGEwcTWEfUAYIJaSVOO5miPp3XcM/FoC5qe
         ka8mu5Eoemld7zp1Ny334E1V9rbcsKHrGmknF8codUf2CKXwSiUmDQDPx6lNZZ3utP+g
         mzTn33wTuFYY3OVxGeqhKggoLcsIy1IWHVV5QWqYxm+o2vek7sPfiYGE/W8zZcEZBrFP
         +yVA==
X-Forwarded-Encrypted: i=1; AJvYcCUvLHhwzhEpEETNvUuhMlPTvJ/eKqt7GOfAw54Ymah0T0euOggS2kOR1qcsmtL/nzEpweCPeuxZSzC4kWIjjEMI68PVJLdogxUsEM+qsHw=
X-Gm-Message-State: AOJu0Yy6xmngj9LUhUna3QtxtkobnXBn0NGfvpwmldAjt9Wc7mAkQIRF
	7qD7OvhsA9H8ZseiHvj3UsYVotrDsvhU0uH/TYSQ6C40fcjunNh/Nq/YQGoj1Z1jU0kS3muRKTj
	X0w==
X-Google-Smtp-Source: AGHT+IE9zfwMdjMcPEX9RGO6P8AKfFkD4sqloy7P8Uq/ZXC30MK+RiSuq41FRbT55B/cRzOu2/aSQw==
X-Received: by 2002:a17:90a:bf02:b0:29b:2d64:68e5 with SMTP id c2-20020a17090abf0200b0029b2d6468e5mr1357425pjs.31.1711155984240;
        Fri, 22 Mar 2024 18:06:24 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:c164:9ab4:de9f:5f33])
        by smtp.gmail.com with UTF8SMTPSA id c5-20020a170902d48500b001dee4bd73e0sm391692plg.59.2024.03.22.18.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 18:06:23 -0700 (PDT)
Date: Fri, 22 Mar 2024 18:06:22 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Francesco Dolcini <francesco@dolcini.it>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"rafael.beims" <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Message-ID: <Zf4rDifM6bLuqpX2@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb>
 <ZfTspRKFgrO9xCTH@google.com>
 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
 <ZftaJEIeNfV7YrVo@google.com>
 <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638F5037D1AB9BCF51CC9D9D1322@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Thu, Mar 21, 2024 at 04:07:58AM +0000, David Lin wrote:
> > From: Brian Norris <briannorris@chromium.org>
> > 
> > On Wed, Mar 20, 2024 at 10:12:45AM +0100, Johannes Berg wrote:
> > > On Wed, 2024-03-20 at 01:10 +0000, David Lin wrote:

> > > > BTW, vendor should have the choice to use cfg80211 or mac80211 for their
> > chips, right?
> > >
> > > No, that's not how it works. The choice should be what makes sense
> > > architecturally.
> > 
> > And to put some specifics on it, that's what's described here:

[strip mangled URLs]

> > "SoftMAC devices allow for a finer control of the hardware, allowing for
> > 802.11 frame management to be done in software for them, for both parsing
> > and generation of 802.11 wireless frames"
> > 
> > AFAICT, mwifiex firmware still isn't allowing "parsing and generation of
> > 802.11 wireless frames" in any general form -- everything I see is still wrapped
> > in custom firmware command protocols. I do see that the AUTH frame looks
> > like it's essentially duplicating the standard mgmt format, and uses the driver's
> > TX path for it, but there isn't a corresponding ASSOC management frame that I
> > can see...
> > ...so I really can't tell how much control this firmware *does* give the host
> > regarding arbitrary 802.11 frame management.
> > 
> > But that's pretty much business as usual for anybody but the vendor in
> > priorietary firmware land; I can't answer pretty much any question, other than
> > what I can glean from a driver.
> 
> Yes. This change is to offload wpa3 features to host. It's well tested
> and doesn't impact existing features.

We appreciate it's well tested, but testing is still orthogonal to the
architectural questions. Architectural questions are important because
they affect the future maintainability of the mainline Linux wireless
stack. If the assumption is that *either* a driver is a cfg80211 driver
(with firmware-MLME, etc.) or a mac80211 driver (with host MLME), then
your series is breaking those assumptions. It may be harder to add
future additions to the mac80211 stack [*], if we have to add new
concerns of a non-mac80211 implementation in the mix.

Is it not possible to implement these features via CONNECT? Does your
firmware not provide any kind of NL80211_EXT_FEATURE_SAE_OFFLOAD
support, or otherwise handle WPA3 MLME?

Or, *does* your firmware also provide low-level 802.11 framing support?
If so, then maybe Johannes is suggesting you'd need a (new)
mac80211-based driver to go down this path... although I'm sure that's a
lot of work on its own.

Anyway, I definitely want Johannes's thoughts, although some additional
info from David might help too.

Brian

[*] We definitely need Johannes to weigh in here.

