Return-Path: <linux-wireless+bounces-20169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AD3A5BE95
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 12:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EFC18984D8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB68253B64;
	Tue, 11 Mar 2025 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqFu/7Ip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A342253B5C;
	Tue, 11 Mar 2025 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691588; cv=none; b=a1Vf0iNpr0EvtrcNPgORkfPBGTqpmQaYua3rx4IWgpalYv7fHVfZzn7+O+d0BKIVOio04dQ+Q5NVhOu9WiSlqZmheqLV+ltAhW1J8sBH1RG4ag6fjEDjirjX9YnbAJ4QXCMmA5cVd0PukCg75l44qZstdxg8h13YDzDBR7xqIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691588; c=relaxed/simple;
	bh=MCSFipezs08azWSv6XDg9ZURoBjjcv5P3dlnKmvdUpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLbcbFhADMua3waEo2nuG21AgnlGFrRqJHM8076JVggKdMrjQSJqwJwORsAmBAMypH9m/UZMSHnE5/UcAe1zqKjTcIW+wie1SQ8DW/9SlAKM9CH/EFpAep8zMhT4Nv9o99YVLug58K1hC6nNW/aA94mXX/7lXM/rhlnJt52KTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqFu/7Ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AE7C4CEE9;
	Tue, 11 Mar 2025 11:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741691587;
	bh=MCSFipezs08azWSv6XDg9ZURoBjjcv5P3dlnKmvdUpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqFu/7IpDtcBQ4/PT1umuRXF95PiBTRqR2DxX54smhTGURBCEYbsgHjeyK3ofIZ4t
	 JefS59LspRXUHhJcnRhulCNd1qrXR0VQTUCnvulwPmXOtVGM1kGGpiXG9WAcqcY2w8
	 tqsRgt8+U9FvSzzf73QDrtxLl38LExA4FgpB3hxiW29WTYqXE9PZljIkPv1vmlJMW9
	 Ookgy7IBhKoUHIm5dEepNUfI9BJUkpmfbkAL4OwN/QRMFXFEOLJ0BdOafrHIMiYOId
	 Jck67SEeFPW2X9O1kk1HGJ7gxyWhGeWfLJiboDRCLDa+orLhmBLNYwWUN9QqI9Hkg8
	 T7lhsXP1xncdg==
Date: Tue, 11 Mar 2025 12:13:01 +0100
From: Simon Horman <horms@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] netconsole: allow selection of egress
 interface via MAC address
Message-ID: <20250311111301.GL4159220@kernel.org>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-2-4aeafa71debf@purestorage.com>
 <20250225144035.GY1615191@kernel.org>
 <Z8tS5t+warQdwFTs@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8tS5t+warQdwFTs@dev-ushankar.dev.purestorage.com>

On Fri, Mar 07, 2025 at 01:11:18PM -0700, Uday Shankar wrote:
> On Tue, Feb 25, 2025 at 02:40:35PM +0000, Simon Horman wrote:
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Hey, since this has gotten quiet for a while, just wanted to confirm
> that there's no action needed from my end? Is this in the queue for
> net-next?

Hi Uday,

It seems that this series has been marked as Changes Requested in
patchwork, which may explain the lack of progress. But that designation
doesn't seem correct to me. So let's see if this can move this series
back into the queue for the maintainers.

-- 
pw-bot: under-review

