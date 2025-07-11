Return-Path: <linux-wireless+bounces-25236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65CB01025
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 02:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AEB1C27C75
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6767653A7;
	Fri, 11 Jul 2025 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4xD+tEz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C410A1E;
	Fri, 11 Jul 2025 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193434; cv=none; b=lUt0LZbMF4VGFemw689VsqwHLAyEGM8/PfDeb79iaA5LQquTTujRQdyhA2rkjnEi8l9/IfnBJKB0QcU5T/6EvJX5c0c9y7+E/awrsEV7NzLUh2AwhPmVKZ2hNdXrwD1chuOnkas8G5SH/9FdlGPvJZB5MiObpZyPIHc1Pq7wz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193434; c=relaxed/simple;
	bh=jD0b1/EzO34pQ+IPH8yM0h45FrCA/k/WnFgUaydU/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ks5SCe+RTvjxbS5/WH0I4XipGQ42amFp5GINFUb4sS8QO20yTOBY5Q98L/+zdWNaD4l6w9aTyokfpEVn42AMc8ViAwxCRAbpZ4V1lJA4dzeiTMrW7sL6qdQ55jmbyRrHCZ42LRNEhjLwdlL3vUKnZg9xsjHWQS/hel4E2rToH+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4xD+tEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9FFC4CEE3;
	Fri, 11 Jul 2025 00:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752193433;
	bh=jD0b1/EzO34pQ+IPH8yM0h45FrCA/k/WnFgUaydU/mM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4xD+tEzooXiawiBph8KPKWDQ2tIUzqUPHU9FPkv0GuJQVXAPziA1W+O/OpihYmm8
	 0DgwbndgOlmc018KjGFux0S5tLqrdtznm+0KBPs80YdiLo+lFcovmkR88zmPxndQbq
	 qD4f2xPgxuwT4aBDJis6KyZupvpBJzBT4mX9SFEPj3hVMc1MgS3mu9QycKvf8U2J7j
	 laURMtCsAyUooWJA1rfXkk6JzIjH6nS7j5ZU/Om+XOlJilqYXAOpSVVZXQC47V86Sz
	 lV4OC4KSz+dtklSamndW3c+pkhpZm/uzA0opnIGLBsxH1P69T3MAk40sXixqBe8h7K
	 hDpbPeb/kSgpQ==
Date: Thu, 10 Jul 2025 17:23:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-2025-07-10
Message-ID: <20250710172352.3ccd34ec@kernel.org>
In-Reply-To: <20250710122212.24272-3-johannes@sipsolutions.net>
References: <20250710122212.24272-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 14:21:06 +0200 Johannes Berg wrote:
> So I have more fixes than I'd like at this point, but a few
> were under discussion for a while, mt76 fixes were just not
> forthcoming until now, and all of them really don't seem
> wrong to put into the tree at this point...
> 
> Please pull and let us know if there's any problem.

Some good news and some bad news. Bad news is that this missed today's
PR. Good news is that we shipped a bug to Linus which is likely to
break nl80211 users:
https://lore.kernel.org/all/20250711001121.3649033-1-kuba@kernel.org/
so I'm gonna send a second PR tomorrow, with the netlink fix and I'll
include your fixes in it. I suppose you may want to wait with the fast
forward until then. 
Now that I typed this I guess it may be two pieces of bad news..

