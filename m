Return-Path: <linux-wireless+bounces-26585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E140B342EF
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D208178A8B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D58D2F99AA;
	Mon, 25 Aug 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rULe/YQD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD11F5842
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131400; cv=none; b=l8+ccVWy6MttsG8ObN9C3HhpaM5yQgPInDLGgtGewjbpDx2QNLJbVaJAkkfJKm/QxFRyE+qeAofX4CqYUrqn1DK58ppObmNRVCYv2YHDBINTR1sJnhBY7nQ5hL4AF6ZnNYwq+YhlNI8Ck0dF8c++uAxUA+B7vMJ5ihiklaRyFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131400; c=relaxed/simple;
	bh=DAkNUWaAsBm1lw6VTGZJ/+UxXQTrfojMhcM119Al1fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=sO/UMm1m2vBHpsXGaRmhw/i2kuvdSfnwye0iV3Q8plrRMco0WzURsJtVx1nVOzEgSCh7Fg1A/UiRzZS5dU5Wc1FNZkQQDTVtSkqOyn3BMpib/Pd1QbmNDg9serRmBOg+eiIsjaUUYOQl/9AYU7tD4w+jHDPkW3S2QrUO0Y8LPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rULe/YQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2096C4CEF4;
	Mon, 25 Aug 2025 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756131400;
	bh=DAkNUWaAsBm1lw6VTGZJ/+UxXQTrfojMhcM119Al1fU=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=rULe/YQD6BE8PwF3in+poFlBfuaF/vqUlkkG1kL22vhAypn9l1aUz01/0YsiH19Fg
	 WQd+WzPDZusdyMv5N8Pknl2om8koHNxJmf2cxcf0qgRSIpzbFPnCC950ZF/UA45cji
	 RR9gBQa9tjaISPza328aLpDUhBVd0B25EB892tHkWR4d51iHaqC+vUp8eOLt84AiAG
	 UepuWuP8OoeXuRq+EXzLAxp0qRPnxx2Mbe+RjfL63gNG2RB+HuXLJqVScQQ/6RmR3P
	 aU+mnF+ouaurE8i/SBLHxFNbD1bg5WlbaZSNqITNUqjUr73FttAmQS+aNJBOyLjx+D
	 W77bmFBYLRyXQ==
Message-ID: <511a143b-183d-40aa-926c-25931e03b2f4@kernel.org>
Date: Mon, 25 Aug 2025 08:16:38 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VRF and UDP broadcast frames
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <39bf5755-254b-e7b8-cc15-500be99d0a6b@candelatech.com>
Cc: Ido Schimmel <idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <39bf5755-254b-e7b8-cc15-500be99d0a6b@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ cc'ed Ido ]

On 8/22/25 1:16 PM, Ben Greear wrote:
> Hello,
> 
> Assume I have a network interface assigned to a VRF (wifi AP interface
> is what I'm testing now).
> I would like to have it be able to send and receive UDP broadcast
> frames.  I am binding the socket
> to the AP netdev with SO_BINDTODEVICE.  From what I can tell, the socket
> at least cannot receive
> UDP broadcasts sent to it.  I do see the broadcast arriving on the AP
> interface if I run tshark.
> 
> Is there any particular issue with UDP broadcast sockets in VRF?  Do I
> have to instead
> bind to the vrf netdev instead of the ap netdev?

I am not aware of any issues with VRF and broadcast, but the fcnal-test
suite (covers permutations across the uapi) is lacking broadcast tests.

As I recall you tend to run relatively new kernels, so either device
should work.

I use the fib:* tracepoints as a start point for debugging cases like this.

> 
> And always possible I doing something wrong in my socket code, my
> current test setup
> is quite complicated.
> 
> Thanks,
> Ben
> 


