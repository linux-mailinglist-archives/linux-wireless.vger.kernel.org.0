Return-Path: <linux-wireless+bounces-11464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A3895298F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE2A1C2161A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4C178CCA;
	Thu, 15 Aug 2024 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzj4dlJz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298D43155;
	Thu, 15 Aug 2024 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705033; cv=none; b=iHaycQBhCTjgFb56trUcmAL6skeaCDRU5mEpVMDL2c0R34hObDkP4O2/1Bh2JNax3aNGLMQinAGGmdOyoo+XFNLUU8pgACP/AO6EVFi5QZxj1k8HcSAPDLhtNq8N1waHqrFm/Cw9G4/h8h0G09bEqpk68es5jqDZbeB8NZu5YKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705033; c=relaxed/simple;
	bh=b7LjGN1zgCWQWh0SzfZYNuLiCaLfGCo0AaOv2p75qwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd9uAcPnFYp0HN53w04QSggO00IiLojHUDgoXNC+oGvtNwtDL+YZ5TokOJHzSKeQ/X/xCkBkTAw4jOIQp0aY2HhyPuvs57ZY0Qe/P/1gvpUJ7PhLmWd1oHq9LDzX85JifRuiytdvibxYYxQglq9b4v5WKSCeyx4+KLGa/p6j7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzj4dlJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B0BC4AF09;
	Thu, 15 Aug 2024 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723705032;
	bh=b7LjGN1zgCWQWh0SzfZYNuLiCaLfGCo0AaOv2p75qwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzj4dlJzf+QDt76LXeKtLbViC3R8nbDVA1qlFQv4qo+xz45ItEh+BmORgsoItSAKI
	 qmprNDk6bzo1iw+g4V/wj+aHaQLOn17QUeirbby9Di2ZVefiOAAA7tP6grqgvsQrS1
	 XuebJxtpgsNiWAUiC+S2JgRMAvx5clyvSFmEKrYM=
Date: Thu, 15 Aug 2024 08:57:09 +0200
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
Message-ID: <2024081501-rarity-strategic-cd90@gregkh>
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
 <20240809094533.1660-41-yu-hao.lin@nxp.com>
 <2024081430-derail-diocese-78dc@gregkh>
 <PA4PR04MB9638C1186FC4D56569D7D0E4D1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <2024081523-curator-pronounce-4619@gregkh>
 <PA4PR04MB963855F4620A2E2C48B2DC2CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB963855F4620A2E2C48B2DC2CD1802@PA4PR04MB9638.eurprd04.prod.outlook.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Thu, Aug 15, 2024 at 06:20:48AM +0000, David Lin wrote:
> Hi Greg,
> 
> 	So that mean I still need to add description for every file, right?

Of course, how else would you want to review such a change?

Think about being on the recieving end of a patch set.  What would you
need and want in order to be able to properly review it (hint, it is NOT
one patch per file).

thanks,

greg k-h

