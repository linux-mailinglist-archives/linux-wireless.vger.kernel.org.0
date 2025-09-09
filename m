Return-Path: <linux-wireless+bounces-27175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA53B4AA77
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 12:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E91188D085
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6C2D480E;
	Tue,  9 Sep 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNWJNJWl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A0298CCF;
	Tue,  9 Sep 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413427; cv=none; b=p5hAHgfo+mGoQ18o7ssS+7yqaZEanPqTfgk3NQxXOs9jvX/Bn99tsmeeXhCBSOh5vZMti2cABs3s+nb80K7c2VQH5Ylj3snTgptg0dZNJeqyeH09GGEKkKQOqZp6aXH+B5avelneAfQr/nWD+cqAmML4AjyDbiyjsFGt43gFxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413427; c=relaxed/simple;
	bh=11+X7VTSOjv3vZy6h82lZuVsJGyhHKouWgVJe3jMT68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1YB+i+vAQRbzH9GI6t9LWCPkc9ATWmLF8zA5ZFR3lNEwukxtWlrDQUJ/D57xf0DLoAsDwAWV6UTgh9WWuNRPyBUoNs/se6ZTsJA0dtCxzdS3pDkM/fhJiyEJpVxlHGiMPjWiZoUCT8WV2ov/dwgdQsYAxDPHJz2hRupA7wVhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNWJNJWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE41C4CEF5;
	Tue,  9 Sep 2025 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757413427;
	bh=11+X7VTSOjv3vZy6h82lZuVsJGyhHKouWgVJe3jMT68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNWJNJWlfUmJris+JwfAW7HLJHBXzseahbm/LnxtMtp6X2izkj7Y+78iZ/qe2jOuO
	 mWBX5iQzJfhJR7r4sdH+fKqKxdNz0ZPVB4bQpefa+C5LgZh/MVTtCmVBmNCC3Vx2PF
	 ot2xfZEXY97fRqTyAUmMv3UAWHRxV5QvfRJ5LNSg=
Date: Tue, 9 Sep 2025 12:23:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, Netdev <netdev@vger.kernel.org>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 5.4 00/45] 5.4.299-rc1 review
Message-ID: <2025090919-tantrum-everyone-f593@gregkh>
References: <20250907195600.953058118@linuxfoundation.org>
 <CA+G9fYt3xc6DmR+EYZD1cAiBSf0VxH6jqbdf0PK-8uGPivw8ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYt3xc6DmR+EYZD1cAiBSf0VxH6jqbdf0PK-8uGPivw8ew@mail.gmail.com>

On Tue, Sep 09, 2025 at 01:22:42PM +0530, Naresh Kamboju wrote:
> On Mon, 8 Sept 2025 at 01:40, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.4.299 release.
> > There are 45 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.299-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> NOTE:
> Following list of new build warnings noticed on arm build with gcc-12 and clang.
> 
> drivers/net/wireless/marvell/libertas/cfg.c: In function 'lbs_associate':
> include/linux/kernel.h:843:43: warning: comparison of distinct pointer
> types lacks a cast
>   843 |                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                           ^~
> 
> drivers/net/wireless/st/cw1200/sta.c:1292:20: warning: comparison of
> distinct pointer types ('typeof (ssidie[1]) *' (aka 'const unsigned
> char *') and 'typeof (32) *' (aka 'int *'))
> [-Wcompare-distinct-pointer-types]
>  1292 |                         join.ssid_len = min(ssidie[1],
> IEEE80211_MAX_SSID_LEN);
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> drivers/net/wireless/marvell/libertas/cfg.c:1106:18: warning:
> comparison of distinct pointer types ('typeof (ssid_eid[1]) *' (aka
> 'const unsigned char *') and 'typeof (32) *' (aka 'int *'))
> [-Wcompare-distinct-pointer-types]
>  1106 |                 u32 ssid_len = min(ssid_eid[1], IEEE80211_MAX_SSID_LEN);
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Not much I can do about this one, as the call to min() is correct.  It's
a type-check issue :(

thanks,

greg k-h

