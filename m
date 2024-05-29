Return-Path: <linux-wireless+bounces-8268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A88D3A72
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984F61F25B91
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A778A17DE09;
	Wed, 29 May 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9RGkqp0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBA20328;
	Wed, 29 May 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995754; cv=none; b=KOilhp9QKdiBXjGecP/zbpemdUDAt3LTQCiRTu1CV1Wh1J9OsGPxmBXY+jVRL0UTjYU+SRbdUzqTLiIt8ZcZz3dID4lMrUZSGwNnwW73+1NiIScKQH8GYsCfbyWy7KkrQNM/hSqwZICMHFVxwHGx86LtWAf9MO3CsdD1N89l+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995754; c=relaxed/simple;
	bh=eWUByR0VEiRUW96ijAZ5GiNZ6VAiv1wvv2G+yWAVIMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUlIyYuRi9l5rKB71zU347WXBMaNRLAruhmVqEoApMDPb+lUIc8+Jy5mUhDYPvUaOk9O9LFEpiuk3UFYnxNpozk4JqrwiW6VphQWcokWaBURDTsW+t8FiJNVHhIfinFSAMW/7XEQDXJ5vGgwMyABRL0d8LwoxsCWeSEx4NK0GRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9RGkqp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FFAC113CC;
	Wed, 29 May 2024 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716995754;
	bh=eWUByR0VEiRUW96ijAZ5GiNZ6VAiv1wvv2G+yWAVIMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9RGkqp0sAdEZhLCuT0KAmONCe0N9V3i3TP9LujkWb1Peph3Bbpm59h01mNhvBp+y
	 zSCtIFc52nB47iBl28g4GxQohnd9QDR1rhbJ7fEitzTvzu6MIWBJYj+gIYnkirIg0M
	 K+c5FOIEaWmJbwRu8FDwktmVMql9TDHUteqS0py5Z066a9TEmj0LNXfuySFY2uXkya
	 /Ry+iD6ktMlxGh23arxufMnZX+sZ+UPD4XqLX6cCB+9S1dCwLO99ssnHTlBqHqRuw9
	 miQpI+h0GCjr8dp/+LJEdmk9pTcGjljxGDFxJNjlJRwPsqrpiVhbllhz+LD8HQcmsc
	 at1XrTcYdKazQ==
Date: Wed, 29 May 2024 10:15:52 -0500
From: Rob Herring <robh@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: wireless: ath11k: Drop
 "qcom,ipq8074-wcss-pil" from example
Message-ID: <20240529151552.GA2525043-robh@kernel.org>
References: <20240528134610.4075204-1-robh@kernel.org>
 <171697351470.2158278.1110328163301153386.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171697351470.2158278.1110328163301153386.kvalo@kernel.org>

On Wed, May 29, 2024 at 09:05:16AM +0000, Kalle Valo wrote:
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
> 
> > Convention for examples is to only show what's covered by the binding,
> > so drop the provider "qcom,ipq8074-wcss-pil". It is also not documented
> > by a schema which caused a warning.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I'll take this to our ath.git tree, ok?

Yes, that's what I'm expecting.

Rob

