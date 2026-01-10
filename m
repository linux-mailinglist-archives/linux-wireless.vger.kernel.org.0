Return-Path: <linux-wireless+bounces-30630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A61D0D38D
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7A73016CDE
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F722A4E8;
	Sat, 10 Jan 2026 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RbfmRbi6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B19155389;
	Sat, 10 Jan 2026 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768035142; cv=none; b=bMEdSOU2KJMKILMuTGl6xWEE9a6chxGRvB76yXHtBRCa07cGo8VuZlkBVTYZ00PqBggZ+UneBEz+s9/O4J3SUpUtkWZaUHrqGMFJ/IBiqrF4ToyZ88m1yzvFGkciz3iVvI+7yNY6vDdzYgPrF7uvwfmCGa4O/SPgDFzjifEGPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768035142; c=relaxed/simple;
	bh=2lCUbHm4p9Js717yLPhZVbjba/FXP/NrgfND4KrdiW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntdt++etUlT+HqNX1xkhVoAir3vFhAb6nDvLpJOND6KiX59SmryMg1qOiF9KSgQskdW1rG3WNxQYR7zZEF0iIcYpHW4mTd7llHfT2zZiRmRcVyAtWCy9edoqL4tBDxn76T2hR924Bb9mTs72lJbL5xWvG1/H4C0fSiGsH3NYbG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RbfmRbi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECB6C4CEF1;
	Sat, 10 Jan 2026 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768035142;
	bh=2lCUbHm4p9Js717yLPhZVbjba/FXP/NrgfND4KrdiW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbfmRbi6pQ3s3qAVVSwITfEuwlX8Cl15V74mJTATA3wzNoAA4NxWsAA/R9wPz6c56
	 /KvbL3YQpM++QSZtCObsRqa3o5G7iAcDdx/CXEaqtyatPcdyQ4YrGXubI8C/ZBz34x
	 dLUxXG0zGeDZpCsX8NXWj9ejPsnWBhFoq4JZgh2c=
Date: Sat, 10 Jan 2026 09:52:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: cjz <guagua210311@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PING] [PATCH v4 0/3] rtl8723bs: Remove redundant atomic op and
 replace global io error var
Message-ID: <2026011039-defection-crumpled-94c7@gregkh>
References: <tencent_B133BBCA4EA4D43FD897B55AE9EE9DEBFA06@qq.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_B133BBCA4EA4D43FD897B55AE9EE9DEBFA06@qq.com>

On Sat, Jan 10, 2026 at 03:53:47PM +0800, cjz wrote:
> Hi Greg,
> 
> I'm glad to inform you that I have just successfully resent the complete v4 patch series (with "RESEND" tag) directly to your mailbox (gregkh@linuxfoundation.org), since the original linux-staging@vger.kernel.org address was bounced.

I do not see them.  Please send patches in public, and cc the
linux-staging list.

Please try sending them again.

thanks,

greg k-h

