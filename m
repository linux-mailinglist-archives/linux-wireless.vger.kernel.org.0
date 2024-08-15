Return-Path: <linux-wireless+bounces-11450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC049528C9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACBB2876FE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 05:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698C755893;
	Thu, 15 Aug 2024 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pj6hhC9L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2918D63B;
	Thu, 15 Aug 2024 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698490; cv=none; b=WzQCwOhifxxanLbck6ncL+fDJoLFK58Bezai7C760MIr4NPpxY069CZZDQh16MnmOuNGyz4r5bvq6X3ErtoISJDNbSQo3Rfi+HefVY/2HuCNVjpTIJPW2EBtYbTyBDxcTmOBYOiF388tMig/JdY+EZrCu+htQodX1PxdY927rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698490; c=relaxed/simple;
	bh=2iudgbOfhquC4Glr/MdgvdB6yDwPJq6YHMzr5OIFlGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdUifF45k4/cR6A0KZZ1lyvQg4kENZfA4blxdwyH9BuleqaYHPkLqIJsp0b3i6vFv08knxdHwlp/f6RoxOs87amdCjFS3hfkHklyvbEylbPjPNFu94bMrZvL9DJD8fdbQ2jZtDzNw3VVpU9YJJHqTYJkXEOYGmF2C3O5uywNdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pj6hhC9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199EEC4AF09;
	Thu, 15 Aug 2024 05:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723698489;
	bh=2iudgbOfhquC4Glr/MdgvdB6yDwPJq6YHMzr5OIFlGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pj6hhC9LOMlKVW2nUGM4YOA+01aGmrkpetYu76Gewy0hz75/ytxMvOG828FOlmcdU
	 Hb5g1bUQkTeObepmqMP9COuMpgAMOnMzyq04ig9eUQy8cK0FuY1o14xfu8s8CpwDJc
	 WM6KkIzvnZLkpmGR0vTb8vLrP1HUk9+wlkYIlRCk=
Date: Thu, 15 Aug 2024 07:08:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 40/43] wifi: nxpwifi: add wmm.h
Message-ID: <2024081523-curator-pronounce-4619@gregkh>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <20240809094533.1660-41-yu-hao.lin@nxp.com>
 <2024081430-derail-diocese-78dc@gregkh>
 <PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Thu, Aug 15, 2024 at 01:52:18AM +0000, David Lin wrote:
> Hi Greg,
> 
> 	Following the guideline for new driver, it should let every file as a single patch for review and generate a final
> 	single patch after reviewing. I think stuffs mentioned by you can be got from cover letter.
> 
> 	If I misunderstood anything, please let me know.

Please read the kernel documentation for how to submit kernel changes in
a way that we can properly review, and accept them.  As-is, there is
nothing we can do with this series at all, sorry.

greg k-h

