Return-Path: <linux-wireless+bounces-15473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496739D1C8D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 01:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56F5B20BAC
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 00:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC88825;
	Tue, 19 Nov 2024 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9X0HpuO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729A17BA3;
	Tue, 19 Nov 2024 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731976390; cv=none; b=sYXSKwiM18FyEL/FH9RudzBL3syNX4M/DFP7OfAiVM9kwl0othDbn+RKTUSiXc0ktZxkvXUNXZJILrTwhlYvudspRLj+Hhuel689hN3vpqpkyKr79++YOJsRqwcAI7oPEyi+BGBsSOVMmcNuqkkrVQYQA8FJZZ+1iy8vUMC0B9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731976390; c=relaxed/simple;
	bh=CEd6Fd/PAqPbWm8HzeWUjVzbSOF2TjU6ZiKeFeqCky0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/EP7TiNfkQmuRS0gslxMElRvF8+N9YEtecMyxrJA3oodkcQAAl7paNUeTZftJnPQthA6nWBx39zB6gsLMgobLoauXxEv736pqqhR+4r2dFgTOXmu0WD47wmQ621gPWJcSjQc4Am/hd7lESB/5misWmU4oy7WqVzaLx0ngaQcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9X0HpuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F489C4CECC;
	Tue, 19 Nov 2024 00:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731976390;
	bh=CEd6Fd/PAqPbWm8HzeWUjVzbSOF2TjU6ZiKeFeqCky0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A9X0HpuOiP3/ezfCh72ujWi97i3RXLrJLQnLybRYfY1c1l+A7XSa/V2qT7RXHVleN
	 7X4bxZMVcUd2/wOpdCRbS6Na/xFtp0koaXsGaDU4hHbzQ6KTwjG0EvU0ZiHpGgS1To
	 yN9pF+ucpwtpRihydIkCT/yNVF1yljfZ4Y9gjc9jDYkYkRIGjcUAv11/EqaxL13KB/
	 eg6BFwyCp72Imc9YDpndSnSQp395ecx7eKb8kfK6xH0u9eIeSTyvKxav8yyM7BjLYx
	 j6w2H4hQdl+jL3n6aJLnB4vj5+kdNWOBr1F4abmRHNED879PovVYJY5EDw5agdLHN4
	 L8irqtjM1vN9g==
Date: Mon, 18 Nov 2024 16:33:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Jonathan Corbet
 <corbet@lwn.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pablo@netfilter.org, richardcochran@gmail.com,
 johannes@sipsolutions.net, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
 dsahern@kernel.org, wintera@linux.ibm.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, jhs@mojatatu.com, jiri@resnulli.us,
 ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 netfilter-devel@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
Message-ID: <20241118163308.318d8a6b@kernel.org>
In-Reply-To: <ZzjHH-L-ylLe0YhU@shell.armlinux.org.uk>
References: <20241115163612.904906-1-kuba@kernel.org>
	<ZzjHH-L-ylLe0YhU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Nov 2024 16:23:59 +0000 Russell King (Oracle) wrote:
> On Fri, Nov 15, 2024 at 08:36:12AM -0800, Jakub Kicinski wrote:
> > kernel-doc -Wall warns about missing Return: statement for non-void
> > functions. We have a number of kdocs in our headers which are missing
> > the colon, IOW they use
> >  * Return some value
> > or
> >  * Returns some value
> > 
> > Having the colon makes some sense, it should help kdoc parser avoid
> > false positives. So add them. This is mostly done with a sed script,
> > and removing the unnecessary cases (mostly the comments which aren't
> > kdoc).  
> 
> I wonder about this... I suspect it's going to be a constant battle to
> ensure that docs use Return: or Returns: because it's not "natural"
> when writing documentation.
> 
> Maybe the tooling should accept a sentence starting "Return(s?)" and
> convert it to "Return(s):" in generated documentation?

I missed this merge window, so we have time, let's ask Jon.

Jon, do you have a preference on making the kernel-doc formatting
accept "* Return" without the colon? vs fixing all the mis-formatting?
Looks like we have roughly 100 of those in networking headers 
(just counting those under include/).

FWIW we catch new instances of the missing return problem, so it
shouldn't be getting worse.

