Return-Path: <linux-wireless+bounces-15505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B399D2867
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EE3283869
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D31CEEA3;
	Tue, 19 Nov 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="T+Skah1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527D1CBEAD;
	Tue, 19 Nov 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027373; cv=none; b=fIlajtE0XDUdHgeO0jqZuBxe2+J/OWnPiE3cb1WcNn4+Zdr6768IRkUiwDoti+VIdfi6NiShosqjeV0R9YnH8dE9hZplGayQulmciVWup/b8yI9WJvdx9IAepadB5LdcOWZKNuwdZyUajFk1r/9VdRXo8JRMDtRnH8G6nG9fTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027373; c=relaxed/simple;
	bh=hrOJnp6uw/S7AuyjkakdDSA5Zg13TNT4jJ6P95hU7JI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDtkBINshaeO7Yl7vcA4GdXAUTthZDNvz1LtiLnAsDEg7yuirUgmUfZt7j6iDc366NpbTPm2TMh3t8SHroKRL4bL9svwhSDkdjYv0NgBTWbkLKKLoCtjXjRop/cTML1IEOgwJNo5V3bu4K/4GvlGhr8OR2mkaHQktKKpPIVs3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=T+Skah1F; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 620B2403E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1732027370; bh=S7Mai6xFGBYX5PLF0oowGY9tbWsB+DPe1mZxbg4En+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T+Skah1FkKdt0HwItZfkgqz0YLC5XTymeP4Oz+Q/qvhI4hpIZEEnUXyf/iD67yZHd
	 qmSL4sp9T2i/m30/zSVP/Bqk44q/QL269v7OR0w9w82+RAzrKzfCRX5pk37fZcELdX
	 jGJJyzEzNwgOfDaZYSxXzDhFzAfxjLeqZCWTz161GAjQsn4OaBJJZqw9dzwBQWEufW
	 vGBSNBqHtMAKy/jGSaSWddASbH+x3j/T6H5RjOe99PzgAGlRaov4kIrzmR97L4I4jb
	 9Z6yQfQ+mqGCT0gTLzMSXyzSYQL40RS7agcP1gygRdtEd9Ygm8xhkdfdjVP657Jebu
	 kiZh3BQdMQsnA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 620B2403E5;
	Tue, 19 Nov 2024 14:42:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jakub Kicinski <kuba@kernel.org>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pablo@netfilter.org, richardcochran@gmail.com,
 johannes@sipsolutions.net, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, dsahern@kernel.org, wintera@linux.ibm.com,
 hawk@kernel.org, ilias.apalodimas@linaro.org, jhs@mojatatu.com,
 jiri@resnulli.us, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 netfilter-devel@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
In-Reply-To: <20241118163308.318d8a6b@kernel.org>
References: <20241115163612.904906-1-kuba@kernel.org>
 <ZzjHH-L-ylLe0YhU@shell.armlinux.org.uk>
 <20241118163308.318d8a6b@kernel.org>
Date: Tue, 19 Nov 2024 07:42:49 -0700
Message-ID: <87v7wjffo6.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Sat, 16 Nov 2024 16:23:59 +0000 Russell King (Oracle) wrote:
>> On Fri, Nov 15, 2024 at 08:36:12AM -0800, Jakub Kicinski wrote:
>> > kernel-doc -Wall warns about missing Return: statement for non-void
>> > functions. We have a number of kdocs in our headers which are missing
>> > the colon, IOW they use
>> >  * Return some value
>> > or
>> >  * Returns some value
>> > 
>> > Having the colon makes some sense, it should help kdoc parser avoid
>> > false positives. So add them. This is mostly done with a sed script,
>> > and removing the unnecessary cases (mostly the comments which aren't
>> > kdoc).  
>> 
>> I wonder about this... I suspect it's going to be a constant battle to
>> ensure that docs use Return: or Returns: because it's not "natural"
>> when writing documentation.
>> 
>> Maybe the tooling should accept a sentence starting "Return(s?)" and
>> convert it to "Return(s):" in generated documentation?
>
> I missed this merge window, so we have time, let's ask Jon.
>
> Jon, do you have a preference on making the kernel-doc formatting
> accept "* Return" without the colon? vs fixing all the mis-formatting?
> Looks like we have roughly 100 of those in networking headers 
> (just counting those under include/).

I guess my preference would be to fix the comments and keep the tighter
rule for the format.  It's not something I feel hugely strongly about,
though, so I don't think I would try to block an attempt to go the other
way.

Thanks,

jon

