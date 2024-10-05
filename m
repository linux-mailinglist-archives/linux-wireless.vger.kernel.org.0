Return-Path: <linux-wireless+bounces-13547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E931E991576
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 11:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 598BCB228E6
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Oct 2024 09:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1315647F;
	Sat,  5 Oct 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVT6dHFx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB6A2595;
	Sat,  5 Oct 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728119185; cv=none; b=gP+i7QKwXSlJTSuNjc0pbvdWWK+eJgKDFMoFEr+OxguKrRbj1pWQAQQykxTweDEK5m479mYtjdsnSpGiUY8yyKL8i6QJP8tOzsLAGZtdFVH3F56X3H/KS1iln/3eoOh0a4CMbEtMGY7VGAGGtAJKpchEEsoABBzVwehpOgSR4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728119185; c=relaxed/simple;
	bh=gFzbMBzOCvxbVhqmTHMWSG+b34vrxrIYmw/N7CwA7IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsZ//c+lE4t/M7KnmXC7++zVmxJydiUK8vVCzh43cy1vdg7zokAi8ErqAI25eyVHX3XGCIu+t1MnTbJwiN6WL+KFBlHygTJ9d1dvrMSrj+4t4/g7YowwZq+oW4SbO2iJfV5gfkZKL8nADBnZ3RHF0tykot5Msn4/wDP5TZstkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVT6dHFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54046C4CEC2;
	Sat,  5 Oct 2024 09:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728119184;
	bh=gFzbMBzOCvxbVhqmTHMWSG+b34vrxrIYmw/N7CwA7IA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVT6dHFx1mmdP9TfLJTLEY4ixcAiXN/qjadB44zoR2EKAx4X4ebv2tAXomlbYc9WR
	 /CQeDZ2JnijuJyS0RmfHe7LaESCiTvabBg00mJJHLjLtsznWNMjfaN46qRhawg3zhI
	 JwcT2FFSF/L+DNR9WM9eX9qebsqwqDYYxt7Vb+lo=
Date: Sat, 5 Oct 2024 11:06:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Dmitry Kandybka <d.kandybka@gmail.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>, kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 001/139] wifi: ath9k: fix possible integer
 overflow in ath9k_get_et_stats()
Message-ID: <2024100542-chewable-unbent-f099@gregkh>
References: <20240925121137.1307574-1-sashal@kernel.org>
 <ZwD/fw1i0jb4eKGz@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwD/fw1i0jb4eKGz@duo.ucw.cz>

On Sat, Oct 05, 2024 at 10:57:35AM +0200, Pavel Machek wrote:
> Hi!
> 
> It may be good to introuce cover letters for AUTOSEL series, because
> otherwise it is hard to reply to series as a whole.

Why would you want to respond to an AUTOSEL series as a whole?  They are
individual patches, the only thing that links them together is the
kernel version they are being reviewed for.

greg k-h

