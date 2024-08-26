Return-Path: <linux-wireless+bounces-12007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3534495FD51
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 00:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A7B1F220C3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 22:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5019DF7A;
	Mon, 26 Aug 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iM2HYcUg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459619DF9A
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712287; cv=none; b=nHywDvl1TNXcU5ejN5E1dMWo3znRlYGXMxWaaudLOEqARWnnzkssD8q4dIaz0qGpHT0/ooixXGVE22Lhd0rr2vUkMPxT3Ae3jH30ExNqcV1FYvnktwywBBNXSGYBXNgI6e1i2ZFVOlcpIulinz5sAaGT9la4CM0KfjUpzaJMybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712287; c=relaxed/simple;
	bh=uwJweqgeCTTED5K/6X7SaDWohDy3XHJSFRBuGly0Daw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeP6b2CkEwFvwac+0c7wPd+nWMYu6/U2efOZGrTgz7GYhCLlRBmtkDL8xiGqU+kvXlnGSp4AOr4pSAZpAx3CZRLUaJKONVYIU+M6uzkOg//HvO9wV3dDiNyjPL2JsGW4MQLkznBxYnzTrkjq91xmC3aDBUIY4V8AxSFkAS488EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iM2HYcUg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7143165f23fso3567411b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724712286; x=1725317086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rP9S1KmGMHqf/jZ1mWqxHKUD0C7Gqq6pUqM5TETs1DQ=;
        b=iM2HYcUgKVZ2dPmUYcbkgQjDB9VBuoBP6z7n3RFzJvUrM2OtyuJY5TkA+v1yLUfbD6
         QFidE5y1b8NYG1qwZ3GP8Si3soMx/V3jCFKJFug93UJU5NYt17w9/dToB5U4IHpIvSfS
         eypoGKato5KJrHY//70Q847HUKz+MQt+zRnwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724712286; x=1725317086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP9S1KmGMHqf/jZ1mWqxHKUD0C7Gqq6pUqM5TETs1DQ=;
        b=UzKObqR2BBA8pht41VW+PrvgRh8JxUHXELvxmb0cXlAdLeAHMKZzE+hGiqp8Vs283q
         2s1+EA0X+9+WdJM58gJE8w3AsHaEzpBrT4R8Vkpfb0qTCv9/2o7hUt1Cbtyee78civA3
         n8BN3Dhu7BRc+n+8macBOwAhyljfQSncEeADglBpy/9PKvKCEVxwYb9VXVo6x84sSmBp
         acn40FptuGxnXpRZnVZt8meWR98RFNvGHnXepNPITh2swuI2oEc8PXPNiG6+XCdc1dJA
         pnmI6BlO6vOixZmyORdZ/umKL/2yinWLQkLUxVny6x2TmIbvR8gfLA2tfDf1sTQm//R4
         RZnA==
X-Forwarded-Encrypted: i=1; AJvYcCXTrZEXshGdabk03IeXqEY+1BSYG6FkvFdyFj2Sf+PUiXtid+ZptLQzvNMRMTIq7S26NPXnWHeJaM2VkfoEqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlv2s8XxaPbbFxWU3dtGZ961i6RbptjRXV0XfJ+zeFaytWHWwk
	XN8hYUzRhq+SBd4UllNd8bVR5ZSWKpuOfPf6mOogAIHsEhxB13XpL0l+8rcpYw==
X-Google-Smtp-Source: AGHT+IFr990qWYgRpotf4EezEdiBDxHfz9bNsR9fu2eXVa7psPrw8ra7VHNA4eNyQDyn3HEPJCRE0A==
X-Received: by 2002:a05:6a00:1703:b0:714:2198:26b9 with SMTP id d2e1a72fcca58-715bfffce43mr1404443b3a.13.1724712285659;
        Mon, 26 Aug 2024 15:44:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:7e40:430b:848a:1da6])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71434af17ebsm7443413b3a.3.2024.08.26.15.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 15:44:45 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:44:43 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/31] wifi: mwifiex: drop HostCmd_CMD_802_11_MAC_ADDRESS
 response handling
Message-ID: <Zs0FW-LPW0ShGXV5@google.com>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
 <20240820-mwifiex-cleanup-v1-3-320d8de4a4b7@pengutronix.de>
 <Zsd-ZxscUBmf0xsu@google.com>
 <ZsxFt19nQs4D7Q7t@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsxFt19nQs4D7Q7t@pengutronix.de>

Hi Sascha,

On Mon, Aug 26, 2024 at 11:07:03AM +0200, Sascha Hauer wrote:
> On Thu, Aug 22, 2024 at 11:07:35AM -0700, Brian Norris wrote:
> > Hi Sascha,
> > 
> > On Tue, Aug 20, 2024 at 01:55:28PM +0200, Sascha Hauer wrote:
> > > The command response handler copies the new MAC address over to
> > > priv->curr_addr. The same is done in the code issuing the call
> > > already, so drop the unnecessary HostCmd_CMD_802_11_MAC_ADDRESS
> > > handling.
> > 
> > It took a bit to figure out what you meant here -- I guess you're
> > referring to mwifiex_set_mac_address()? It could help to document what
> > you mean.
> 
> Ok, I can clarify this a bit when sending this next time.
> 
> Right now what we have is:
> 
> 1) mwifiex_set_mac_address() sets priv->curr_addr to the desired new MAC
>    address
> 2) mwifiex_cmd_802_11_mac_address() (called from mwifiex_send_cmd())
>    constructs the HostCmd_CMD_802_11_MAC_ADDRESS command, using the MAC
>    address in priv->curr_addr
> 3) mwifiex_ret_802_11_mac_address(), called from the response handler,
>    sets priv->curr_addr to the MAC address received with the command
>    response, which of course is the same as we initially copied there
>    in step 1), which makes 3) redundant and unnecessary

Ack, that's the understanding I got, but it took a bit of reading to get
there.

> > I'm also a bit torn; this command API ostensibly has a (unused so far,
> > for this command) HostCmd_ACT_GEN_GET mode, in which case this *is*
> > important.
> > 
> > If anything, I might consider dropping some of the handling in
> > mwifiex_set_mac_address(), because it seems to presume (and then has to
> > undo for failure) behavior of the underlying command.
> 
> What we could do instead of dropping 3) is:
> 
> 1) pass the new MAC address in the data_buf argument to
>    mwifiex_send_cmd()
> 2) instead of priv->curr_addr use data_buf in
>    mwifiex_cmd_802_11_mac_address()
> 
> With this the response handler would still set priv->curr_addr in case
> the command went through successfully. No need to undo priv->curr_addr
> to the previous MAC address in case the command failed.
> 
> Sounds good to me. Is that where you aiming at?

Yes, that seems about right.

Brian

