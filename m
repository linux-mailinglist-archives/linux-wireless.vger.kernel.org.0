Return-Path: <linux-wireless+bounces-11006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C93F948BF9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 11:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586672867A0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEFD1BD4EB;
	Tue,  6 Aug 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZlsZzwm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E11BCA06;
	Tue,  6 Aug 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935329; cv=none; b=R8bwGS3cL0R3JVFeLstg90/ZBykXxwUqY40xyfOa8PB3b6KzRfKdsh59avSMpdW+t9Zbsu5gqhYh5oVwGBzWepe+cTM2YwcJqbO62KuUocC0GiM3n4pE76UiFuu9dTMr8QDhppEowrZHZD+Id1u/HkHdtkElSMDHXpPv7la8H90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935329; c=relaxed/simple;
	bh=PNIhN1OA39eePQKFIv/4WBPmd1br52RQkAIJIsKUxJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlhB7wa9aIH208c+iOhSHpW1q56Y/yHj29W0uCaS/Gv7wgub/LPTtpKHLfRuFPTOTH6abjE98cH0qqbYkamZTZyeY4xSqPoA8p/G4Qu+h1yrZiG1LWfd+UMonxD75n8avDocH65YV6JAR/50L7bTQ6+cH29Lm9TeTHI6r5UhaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZlsZzwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DD2C32786;
	Tue,  6 Aug 2024 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722935328;
	bh=PNIhN1OA39eePQKFIv/4WBPmd1br52RQkAIJIsKUxJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZlsZzwmemXD2j1kwHnE9TY/Utd7B01BX4iN2z19YzeCTF2VGhQkNqM2SLYysbP9t
	 vdVN0Fd+9mCOENATjsiSUck0RG+rMNdNtiVkA1pCdfzH5ilZauHsiy6J/vCmOrkUeA
	 gIf/+srKRV+l7rX+wFBmnWgH+9c7U9GnAHv63PxfquUw+1RTUOlGNIrYZv7GQJcIlo
	 YEgrm1rfhCLj5MQrGSN5J2fG5Vwdo/BiaigDm9LUpNa64Mv9pdabvNDnwX9LTBMdQP
	 nEVablE52ycG054zZn99VnDZ/xjCtGvgDWtk0zRn4Niu2xqup1Ve5EPk6sCjd4qZLP
	 IpbPhvCQ9nY+w==
Date: Tue, 6 Aug 2024 10:08:44 +0100
From: Simon Horman <horms@kernel.org>
To: hhorace <hhoracehsu@gmail.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Guillaume Nault <gnault@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH] wifi: cfg80211: fix bug of mapping AF3x to incorrect
 User Priority
Message-ID: <20240806090844.GR2636630@kernel.org>
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805071743.2112-1-hhoracehsu@gmail.com>

+ Guillaume and Ido

On Mon, Aug 05, 2024 at 03:17:42PM +0800, hhorace wrote:
> According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26), 
> AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4 
> and AC_VI (Video).
> 
> However, the original code remain the default three Most Significant
> Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
> and AC_BE (Best Effort).
> 
> Signed-off-by: hhorace <hhoracehsu@gmail.com>

Adding Guillaume and Ido as this relates to DSCP.

> ---
>  net/wireless/util.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index 082c6f9..4e04618 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -998,7 +998,6 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
>  	 * Diffserv Service Classes no update is needed:
>  	 * - Standard: DF
>  	 * - Low Priority Data: CS1
> -	 * - Multimedia Streaming: AF31, AF32, AF33
>  	 * - Multimedia Conferencing: AF41, AF42, AF43
>  	 * - Network Control Traffic: CS7
>  	 * - Real-Time Interactive: CS4
> @@ -1026,6 +1025,12 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
>  		/* Broadcasting video: CS3 */
>  		ret = 4;
>  		break;
> +	case 26:
> +	case 28:
> +	case 30:
> +		/* Multimedia Streaming: AF31, AF32, AF33 */
> +		ret = 4;
> +		break;
>  	case 40:
>  		/* Signaling: CS5 */
>  		ret = 5;
> -- 
> 2.42.0.windows.2
> 
> 

