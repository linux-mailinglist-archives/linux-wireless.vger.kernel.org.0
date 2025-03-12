Return-Path: <linux-wireless+bounces-20258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB4A5E48F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 20:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32EB172F7E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 19:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF12571A5;
	Wed, 12 Mar 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDXTJiGw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA951E8353;
	Wed, 12 Mar 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808243; cv=none; b=EFCpfN5giOymp2R7r0hV5V4fvFsT/Y2VxUzgsH5FaT4lDMy1nwp1IijepwKsIsumu68OaZFehGrKSKKulsEzIHIzp/7+HnfZ5HZIhTITAzwfMzmwzhrJ6E9Km+i/Rds+FBPWxkvoUWMOLye8kg3YhFKrT85q3uKrLfBR7ANTP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808243; c=relaxed/simple;
	bh=ftQ3e44e8+7vyawaED0yk3fGaevmW38KxYSauz7PqDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeNI0S5Lt6IF/VgB+knkpE1oMASApV+LgFbwVPh0XzVpLDJ73j0WbaC8UDF4ZLFTKgxb9FeQzI0e1vjbbPB1gVthsWumOTomPWXZRrt0cRTG1STQfDnfWqxwYP/07XZayA6VhiWJEij2XKzOw+2QPjdIxgOkwk0PGBlKMYqZarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDXTJiGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B325DC4CEDD;
	Wed, 12 Mar 2025 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741808243;
	bh=ftQ3e44e8+7vyawaED0yk3fGaevmW38KxYSauz7PqDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JDXTJiGwDVKNtJaELzQnrZwv6Ke1nuJjfQ3w1/1rHpqtGscGR3JRRqNcTpMLQPH6p
	 H/NVapRPNVh4F7wx7HNXc998/+3GbwtQ8XdZQk8OxxNVA0kRJNzdGSGmvbCWPdxzso
	 cr2S6rcgFXkjBSDgd558uzcvyKS5p8nmVvKD/QpawS4FMDsnxs5Edu6gs+pP5aqqDt
	 6DKHcxT+JjaF6GjVSevqXwDm2cn90huOY6G3MlXnniRHyoSZ6XoIS/I7LXZ73a6z7R
	 y3m8nqYy15yudqMIkOe8kd3zb4Fqhlf4AM1MskJiWpT4PTdtQR283A19w+2VC9xL0h
	 sczxH83we5FUA==
Date: Wed, 12 Mar 2025 20:37:16 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Uday Shankar <ushankar@purestorage.com>, Breno Leitao
 <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Andrew Morton
 <akpm@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] netconsole: allow selection of egress
 interface via MAC address
Message-ID: <20250312203716.110b6677@kernel.org>
In-Reply-To: <20250311111301.GL4159220@kernel.org>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
	<20250220-netconsole-v5-2-4aeafa71debf@purestorage.com>
	<20250225144035.GY1615191@kernel.org>
	<Z8tS5t+warQdwFTs@dev-ushankar.dev.purestorage.com>
	<20250311111301.GL4159220@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 12:13:01 +0100 Simon Horman wrote:
> On Fri, Mar 07, 2025 at 01:11:18PM -0700, Uday Shankar wrote:
> > On Tue, Feb 25, 2025 at 02:40:35PM +0000, Simon Horman wrote:  
> > > Reviewed-by: Simon Horman <horms@kernel.org>  
> > 
> > Hey, since this has gotten quiet for a while, just wanted to confirm
> > that there's no action needed from my end? Is this in the queue for
> > net-next?  
> 
> It seems that this series has been marked as Changes Requested in
> patchwork, which may explain the lack of progress. But that designation
> doesn't seem correct to me. So let's see if this can move this series
> back into the queue for the maintainers.

Unclear why the designation was chosen, indeed, but let's get this
reposted per normal process. The posting is a month old.

