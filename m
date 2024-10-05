Return-Path: <linux-wireless+bounces-13545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B699156B
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 10:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D983B21B15
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634584D3E;
	Sat,  5 Oct 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="keeIyN6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16813DBBC;
	Sat,  5 Oct 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728118527; cv=none; b=Ek2Q7ACjXDMiATRI/IDd4Wo6UGfupGqiWmywwOLtGP3B3AN3zvcqvjXr3cFYz8BNCUEeoOE+zeKUXl2w2M+AuTBkcgYxL5rTK0+XybNQ1iCnSGMNTQsGr55/0BZegWmQ8YowOVeZmcMSL9QriLXrKiBejKtKO8mMBXfjb3Lnkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728118527; c=relaxed/simple;
	bh=Q9fN4mIljgWDFimuOMbRoPT+LKzZXB/LgeqSeq5NyoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZVeDmf4Buusm3cDnnVLlZSMRjYvpwLOm++OVgddznFNJppTD9Ba2cBtea5Y6h1w4TpUsACHR6FguMYex+6iXaM8mGyfHZ/EQZ/+kBQaUdu4vsI2ofwluZi3zfFnr9GbCAMzU6gIxSVYVKykF83VfXlmSSpcnlYnV/37fvvJyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=keeIyN6L; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 004411F921;
	Sat,  5 Oct 2024 10:55:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728118519;
	bh=CDFLEKcKHVxpFqH0nXKpZpV/aXgTu4xt6u1XvUqG51s=;
	h=Received:From:To:Subject;
	b=keeIyN6LSR25JuIY2SIcSA+mnr/DCGLQzTsrn/acIHK2dkEUN3tAxBFH6t27LHW3K
	 wDGljIO2kHOF3ued7Lf0GJvPCF9Ex0Y/KZwaccJ/f60eacB9EauMTDDWmG5V7Jr7q9
	 NZNi5M3wqnKOeSK++fiD+ojYcamoqXKYUKun6+URKuDjJDsIuZBmEgi7N+ln879T5s
	 swISV2oNbpfsrgxlwzvRfHx+LxwDtLNIZ2dR++sQtMppy3OD4eiaFrLcGbtk3NFXwn
	 l7ssm7ZJTBpgP00w7pS09JvetBeKisWeMXCesB3eWYG4E84+2FiOTTb72NKH97IsQf
	 yFVdJDkCO2d0w==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id A99417F96B; Sat,  5 Oct 2024 10:55:18 +0200 (CEST)
Date: Sat, 5 Oct 2024 10:55:18 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Brian Norris <briannorris@chromium.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 02/12] wifi: mwifiex: fix MAC address handling
Message-ID: <ZwD-9nV3o2fOpEYb@gaggiata.pivistrello.it>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
 <20240918-mwifiex-cleanup-1-v2-2-2d0597187d3c@pengutronix.de>
 <ZwB3FCdpL85yA2Si@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwB3FCdpL85yA2Si@google.com>

On Fri, Oct 04, 2024 at 04:15:32PM -0700, Brian Norris wrote:
> On Wed, Sep 18, 2024 at 01:10:27PM +0200, Sascha Hauer wrote:
> > Furthermore the driver doesn't use the permanent address to add the
> > bss_num to, but instead the current MAC address increases each time
> > we do a change_virtual_intf.
> > 
> > Fix this by initializing the MAC address once from the permanent MAC
> > address during creation of the virtual interface and never touch it
> > again. This also means that userspace can set a different MAC address
> > which then stays like this forever and is not unexpectedly changed
> > by the driver.
> > 
> > It is not clear how many (if any) MAC addresses after the permanent MAC
> > address are reserved for a device, so set the locally admistered
> > bit for all MAC addresses derived from the permanent address.
> 
> I think I'm generally supportive of the direction this changes things,
> but I'm a bit hesitant about two things:

FTR, I am hesitant for similar reasons. In addition there is my comment
from the previous version on a specific use case potentially broken.

> And I see that you rightly don't know how many addresses are actually
> reserved, but I have an educated guess that it's not just 1. For one,
> this driver used to default-create 3 interfaces:

The MAC addresses on the module are not allocated by the Wi-Fi chip vendor (NXP,
and before Marvell), but by whom is integrating the chip. I can try to ask
a couple of vendors what they are doing on this regard, and if this is somehow
suggested by NXP or they are just doing whatever they believe is right. Just to
add a couple of more data points to this discussion.

Francesco


