Return-Path: <linux-wireless+bounces-15419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4AB9CFFD6
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 17:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749621F22653
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 16:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7DC38385;
	Sat, 16 Nov 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c/DwxpEA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D79C8C7;
	Sat, 16 Nov 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774251; cv=none; b=eUms1XMw/0N3UvP/5j4ylOvS5vau5ZH3JXX/T471HwwyJWRK9CmxZJpsfIEQgl3qtjohDk/Za7+wpz4nHS57myAHtyJuQv71pUznkvlLnXAOg9SZcDpf8eUaxUUntsys0qETCBAckDg0iDpMmb9zx9gDxjSFBm2WMT4JP9xeQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774251; c=relaxed/simple;
	bh=ur4279Lg4Jkiv5ioc4Um20xDbX+FLxdWzXYF38k8Nsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDRAczN8B1UmIAs8F0Kz++/1x2553vHyDLjD0V/zJb0Bql2BPPeCcCaxItWOrSGZSYiFgLqZLIVGrAd7ywRW2A9/TAjoj2l/84XxRRwzPTdGvpJBT3IHtV+cFDocH0PT6DZ4bLaVdfAaD0pCWcyiebmsixGO3QIYEh6bZsKJRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c/DwxpEA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EalHJFRoCP7b1Ph196PU6hDFcS9BrRYGeJ156HOiPDE=; b=c/DwxpEAaOMyfP7HPhIZvJ4i7R
	2L27n2h6b6pVSsubAULxW3oXEm/MdtI9vqFKAyqy0AXcnMPDEL3Cyau2xVE60WOW0r0SYPJrhXF0z
	U082tLTvfW8imCuV//9EJNECF3WCA9AkKbFXcoEHlX5/GXlduutsVys8SjF3csfzf/X/RJb1aDfT3
	A2Y9nA4NVfDFqqgwKNFUMjXGuTQXwIyKt1dy7Bo7/UiWxpQhJBAooPJds4Vefzu6nPkDpVaoHd6Rx
	6ktktOGO3i5zpN5Ibu2lWGOGw6heIVO0i5hjjg7g6/Nu3sZxWSSnU8fQorAthh84vXnQhpATP3RVv
	4O5/x9eg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52222)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tCLac-0007OI-3D;
	Sat, 16 Nov 2024 16:24:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tCLaZ-0003FM-0s;
	Sat, 16 Nov 2024 16:23:59 +0000
Date: Sat, 16 Nov 2024 16:23:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, pablo@netfilter.org, richardcochran@gmail.com,
	johannes@sipsolutions.net, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, dsahern@kernel.org, wintera@linux.ibm.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org, jhs@mojatatu.com,
	jiri@resnulli.us, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, netfilter-devel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
Message-ID: <ZzjHH-L-ylLe0YhU@shell.armlinux.org.uk>
References: <20241115163612.904906-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115163612.904906-1-kuba@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 15, 2024 at 08:36:12AM -0800, Jakub Kicinski wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>  * Return some value
> or
>  * Returns some value
> 
> Having the colon makes some sense, it should help kdoc parser avoid
> false positives. So add them. This is mostly done with a sed script,
> and removing the unnecessary cases (mostly the comments which aren't
> kdoc).

I wonder about this... I suspect it's going to be a constant battle to
ensure that docs use Return: or Returns: because it's not "natural"
when writing documentation.

Maybe the tooling should accept a sentence starting "Return(s?)" and
convert it to "Return(s):" in generated documentation?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

