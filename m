Return-Path: <linux-wireless+bounces-16434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDBF9F3F41
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 01:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC87A2579
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 00:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E12B9CD;
	Tue, 17 Dec 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmTTTeOg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9F15AF6;
	Tue, 17 Dec 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396100; cv=none; b=mdalHybnQVBV6qNTNDEeVc7Vzjk0Ft3HCrqvkLWpb7Pe4j2CT0Dtyswk3F5Kt57EqStz8/ZiIdAjGnRTN15TxNBjtfdnycCDSkDWu8OsvwpH22TdwZBu70tq9PX7j6SA1jMu03xIMBGKd89Ti7gUAhXn6XXJGInvqFOY5wVaDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396100; c=relaxed/simple;
	bh=Ka+OMSaqE1tqko01dYUFN1zerLG7QyUuZt4Xtr1VtVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hapUjnrH1AnL7Jj4rM+IX6OQruagV2ZO8W6mMMxUImo0257I758d+Mq9soCBANiiFMUnqn0rKF7R2MF/EMcXPYyGMT7LcUCmSfHTt9Q0RQTctjt3iJp+j5/QYhYu/0XYJyEYLFAgQeqeQFPCRjPb+VAJPwYr2fWyLj5aMDMZukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmTTTeOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12F7C4CED0;
	Tue, 17 Dec 2024 00:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734396099;
	bh=Ka+OMSaqE1tqko01dYUFN1zerLG7QyUuZt4Xtr1VtVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FmTTTeOgGwQUKcETSk7JN9uS1HwjCzwU8/9sGIO3Bmrw15uctQ/lYEqdK/Y2LSc36
	 sVRGyQIDFzYTswQB4XJjQuHhYx9O1fqa3MCoBjBngnZMdDWjTdZ1vQSA4ZnrXq1apM
	 H9uWgDD5vchsL3JqZrjjgkuSeehBzjVSoBOMqyfhJeaaEIeN1NvM+1Le09/EnfsIoJ
	 LTKU4scWe5S2hdTTM1QCmRn2znete1zt7t3IduwDQoj7szNb484ObmGOcP7KP82AIq
	 qDk9g26Henr6xwrF7vH+dSu3Evhh1aTu0S+f/QCuMBGKj44cWhlYq5V+wuUrlOwuwA
	 acPDcBfFbH4vQ==
Date: Mon, 16 Dec 2024 16:41:36 -0800
From: Kees Cook <kees@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	x86@kernel.org, linux-snps-arc@lists.infradead.org,
	linux-wireless@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, ocfs2-devel@lists.linux.dev,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 5/7] security: Replace get_task_comm() with %pTN
Message-ID: <202412161641.8209C666@keescook>
References: <20241213054610.55843-1-laoar.shao@gmail.com>
 <20241213054610.55843-6-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213054610.55843-6-laoar.shao@gmail.com>

On Fri, Dec 13, 2024 at 01:46:08PM +0800, Yafang Shao wrote:
> Since task->comm is guaranteed to be NUL-terminated, we can print it
> directly without the need to copy it into a separate buffer. This
> simplifies the code and avoids unnecessary operations.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Looks good to me; thanks!

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

