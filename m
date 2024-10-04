Return-Path: <linux-wireless+bounces-13541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F71A9912DB
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 01:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A941F23C44
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 23:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878914D2A2;
	Fri,  4 Oct 2024 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLE+dJEk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E3114BF8A
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083736; cv=none; b=jtUUSg4OkOFCLqRhNtw9gnWQ5GnYf+0OlwLw5P1k4zQneGXilaYCRNqs265NIdVcFxiFWhb6U6DQpnLNxuQ8suq3SK7FiyKDtNiX+ipe+4QkXpUepx0EWimEeF1PWQWWRujqNspFjA3aH5VUSVxHQV/WOfTMqg7DRBSiQR7rzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083736; c=relaxed/simple;
	bh=jxLWPsA4W1hZ22mcLl3CxDNLhM9wbfIpMh6/TzqAPSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHTr6Wa2lr4RSPaxkCTWvAZ4ScMRo6P1cMJFgrHFYqHToSQmn6S3fQK2YIa43lnHTA3grLft0BzrxMWGzhKAHBJmgpH6fE09e3Q5c8ECERutBFVcgWdOrUl11z3IvP7vn3GaY22eEWuqcd+Ow/H/JUteIhXMtqZqrahfKeoJ2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bLE+dJEk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71de9e1f431so938953b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2024 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728083735; x=1728688535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WzguejOpr9Zzzei9DMlIPR7PTK0xyQMVS8RUVT1QRAA=;
        b=bLE+dJEk9ALbpHbudAxJiQFE0tYkvdpLu3vgskYNnvwdx/8hOuQZrTKWcGZxpbwq85
         T6JWIC0fQtWA2jLWvY26cH0T8fZHalUQ8d/3sgtDTkEBZLHsfgZuMcFTbBM7TuDrc6wP
         VfJlCP+xLWg2inptmNjfdXoGWAA+uMxsUSCWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728083735; x=1728688535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzguejOpr9Zzzei9DMlIPR7PTK0xyQMVS8RUVT1QRAA=;
        b=UGgWkplBslA6PbN8u57Kz4IvThJlHk6aGCgc+o20ArQ8SOCeZnpFRyh6I5sbuP/TCo
         B5fx2mbSMhJ66vFBQhmnocaoXrHuJnq/CiUX/JoxRLTcpkx9k7eM+7nOXDhzPw3/Cf6B
         stZ+RLQS35XvFyNN1ATMsBhO/XE/fU6X4AvAYJs38gnGX6oc3qga1q/hcp1sTBu4Lehx
         Pa1fyG5dFJM6pCr6zM1amnv4oftcFyHvc/8AFo6g50V678Rri/Mr5lmTjkgTsPfs8iOL
         yi75J/BJv0k0vMf9y4jqk1nZ3yCRcYYJ0+5ZykdkajCAX5Xv04m8JjF/9lzE7OsHp2rl
         hRkg==
X-Forwarded-Encrypted: i=1; AJvYcCVaAWTDfJcWH4hhoPBgLKRtR9wnQO8v9E3//mZt4fule/9g00jtNqxCQ0GagmqKbw0lXYtWCoWarIwIg8hIXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVCn6XoC5SxdZ6zj8rs8xEbLryEa0cN/rOE0h4X4GdaKPCyiES
	4NbCdjoWLs3dbcDK0vEecCeopi8xQ5l1nFdOPjZkCaC/BZhyJP36TYc5SI3EdA==
X-Google-Smtp-Source: AGHT+IF29NydTcT0W6JEL2vynUGDOxkopPnw1KrQvImp7cvd9/dSCsbLdspKeHxIRxXXP6dunAkI4w==
X-Received: by 2002:a05:6a00:3908:b0:718:ddd7:dc3b with SMTP id d2e1a72fcca58-71de2445318mr7043618b3a.21.1728083734631;
        Fri, 04 Oct 2024 16:15:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:431c:f73a:93be:1ac2])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71df0ccd225sm415580b3a.52.2024.10.04.16.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 16:15:34 -0700 (PDT)
Date: Fri, 4 Oct 2024 16:15:32 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 02/12] wifi: mwifiex: fix MAC address handling
Message-ID: <ZwB3FCdpL85yA2Si@google.com>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
 <20240918-mwifiex-cleanup-1-v2-2-2d0597187d3c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-2-2d0597187d3c@pengutronix.de>

Hi Sascha,

Sorry for being a bit slow here. And even now, I probably don't have
enough time to review this whole series today.

But I'll still share some initial thoughts, in case you can help address
them before I next look at this:

On Wed, Sep 18, 2024 at 01:10:27PM +0200, Sascha Hauer wrote:
> The mwifiex driver tries to derive the MAC addresses of the virtual
> interfaces from the permanent address by adding the bss_num of the
> particular interface used. It does so each time the virtual interface
> is changed from AP to station or the other way round. This means that
> the devices MAC address changes during a change_virtual_intf call which
> is pretty unexpected by userspace.

Ack, the "change_virtual_intf" part looks wrong.

> Furthermore the driver doesn't use the permanent address to add the
> bss_num to, but instead the current MAC address increases each time
> we do a change_virtual_intf.
> 
> Fix this by initializing the MAC address once from the permanent MAC
> address during creation of the virtual interface and never touch it
> again. This also means that userspace can set a different MAC address
> which then stays like this forever and is not unexpectedly changed
> by the driver.
> 
> It is not clear how many (if any) MAC addresses after the permanent MAC
> address are reserved for a device, so set the locally admistered
> bit for all MAC addresses derived from the permanent address.

I think I'm generally supportive of the direction this changes things,
but I'm a bit hesitant about two things:
1. the potential user-visible changes and
2. the linux-stable backport (Cc stable below)

For 1: MAC addresses are important in some contexts, and this might
significantly change the addresses that devices get in practice. Such
users might not really care about the weird details of when the address
incremented; but they *probably* care that a certain sequence of "boot
device; run hostapd with <foo> config file" produces the same address.

Also, I'm not sure I know enough of the implications of potential
over-use of the locally administered bit. Are there significant
downsides to it (aside from the simple fact that it's a different
address)?

And I see that you rightly don't know how many addresses are actually
reserved, but I have an educated guess that it's not just 1. For one,
this driver used to default-create 3 interfaces:
1211c961170c mwifiex: do not create AP and P2P interfaces upon driver loading

and when we stopped doing that, we still kept support for a module
parameter for the old way:
0013c7cebed6 mwifiex: module load parameter for interface creation

Perhaps these "initial" interfaces should at least be allowed permanent
addresses?

So anyway, I don't really know for sure the right answer, but I want to
log my concerns, in case you had more thoughts on backward
compatibility.

And given all the uncertainty above, I'm extra hesitant about
backporting likely-user-visible changes to stable (#2).

> With this patch MWIFIEX_BSS_TYPE_ANY becomes unused, so it's removed.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable@vger.kernel.org

Regards,
Brian

