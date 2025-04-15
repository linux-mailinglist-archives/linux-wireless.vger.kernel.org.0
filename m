Return-Path: <linux-wireless+bounces-21549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 196FEA89CBC
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 13:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DE7164E9D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B2029115F;
	Tue, 15 Apr 2025 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wP5Owd+z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2852B9A7;
	Tue, 15 Apr 2025 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717396; cv=none; b=FByT9avgoI80y/mYsbXoFHjbcejNNUIb6rPqj5ulfLPtgi3EjIx5PASRHLsHF5iCFsrkTBPC38OadSiqmcqPrBvKi/sG3nB8VqyzsiZ/nUM4rFq8XpQIhIZ/2M9w4dDDZt9ZpiHWTM5ox4e2jmPRvk4YTaQmeCWz6r+jBWPgVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717396; c=relaxed/simple;
	bh=trG5DdsOiG8NeThA812fgykRNksnpDmhYLcOXxGaqGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9oIahXXfLFMqqY8v44GVSfLhBagLb4mkC0LnmHz0QPk/ibArSnSfwzIwb56sQFgnRy2qgJaqRRg1FPpR3+POm4I+dHGrYbfhd64A7MdBtYyEROb1V0/K1A+c7zNJNvnZpNmDFhQ2EWQrVImPpJPV+IkbY17tDT6Me0pr0wpwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wP5Owd+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADCDC4CEDD;
	Tue, 15 Apr 2025 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744717396;
	bh=trG5DdsOiG8NeThA812fgykRNksnpDmhYLcOXxGaqGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wP5Owd+zjv497is2T2hpPymcDdeNsHMTU7TaEX0bI31pqzumlXFjw3izhest8gx00
	 7AjefdryygCNGgEYbzz8Kb2+fI8nE6BN4MDBuq9K9GMoENep8FxawgJLk8DhYk3ll1
	 bmets7KsVJqTCmeb1OXJ3dmHC3UiR+iJGy1Re4kc=
Date: Tue, 15 Apr 2025 13:43:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: vulab@iscas.ac.cn, brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Erick Archer <erick.archer@outlook.com>,
	Jacobe Zang <jacobe.zang@wesion.com>, Kalle Valo <kvalo@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2] brcm80211: fmac: Add error handling
 forbrcmf_usb_dl_writeimage()
Message-ID: <2025041507-proclaim-frigidity-da8c@gregkh>
References: <20250415072048.2629-1-vulab@iscas.ac.cn>
 <af72dff7-8ad1-476f-81f2-6f7d76761b12@web.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af72dff7-8ad1-476f-81f2-6f7d76761b12@web.de>

On Tue, Apr 15, 2025 at 01:21:23PM +0200, Markus Elfring wrote:
> …
> > brcmf_usb_dl_cmd() but dose not check its return value. The
> > 'state.state' and the 'state.bytes' are uninitialized if the
> …
> 
> Would you ever like to benefit any more from change descriptions
> which may contain text lines that would occasionally be longer
> than 60 characters?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

