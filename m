Return-Path: <linux-wireless+bounces-20521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B8A67F5F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 23:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1023BEC7C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 22:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D352139AC;
	Tue, 18 Mar 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAjz0BFa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E62C2066F1;
	Tue, 18 Mar 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335704; cv=none; b=hvrxqg8xqrVGZ0De2GrpNaY4H20z5LoaDw4Ef1LaYxX+NcA+uE6GmmfN3TRLnIc8FtrPgUd92A4KZrT+5u7saR7H21zSszZsK/9leQAHlkwHCGs5Ze7Cf5pC8FuvO5qRYRcHCFN+L8vqSTjvMtSXpDYoYWyRnlExAZMbed9o9JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335704; c=relaxed/simple;
	bh=SmjpdsMx0C5U8VqJSTB915t1SGGlxmMx8O/OzABs9e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9/JOCpiAWb0Qu/rBiaKh0ooEyOVEqD1mot0qdD5YCV7mw1eg2bpQGIjh0/K5GTdfelRqq52e+RyYFar4FMQxc05eW/sSXasR3NOhPo3ICxDAvZYhUFeWc06OBL4rACc0lOLCYKPTDPuG7nTzUmn0bBux/oa5pA+qcYpWm4nFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAjz0BFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A59C4CEDD;
	Tue, 18 Mar 2025 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335704;
	bh=SmjpdsMx0C5U8VqJSTB915t1SGGlxmMx8O/OzABs9e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAjz0BFaZ25YwBZXG7u8tasw+EsInTujNBKEVpeTNiQJFeltGVnu+jxv75wnSBEs4
	 7298WR7NQEi6Nig8df2NaxNdEL7v0ctd8zM0H/WAfXmH7lHBsbXmmO3nHfsiUpFFuY
	 f5NfaTr2gQevM1D/ozXl66BWuSR1mi92k1GasfvWWWrcye+uVRxMKUmKZL9jdpBG0x
	 Q/jeSEIInNJS03DIRyurWVldM5pQb4UTHkdflhnK+oRsM+xACuDk+d7s3WA41abYgr
	 CdbUoVKX16aElY5xDo9MIpwtqdKkQ9kqHhDwj1WeBM5TWwIilQqafUCYeNLs5z02ii
	 Kz+Nu3p8crR/A==
Date: Tue, 18 Mar 2025 17:08:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Janne Grunau <j@jannau.net>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-kernel@vger.kernel.org, van Spriel <arend@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Gross <agross@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
	Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Re: [PATCH v3 3/5] dt-bindings: wireless: bcm4329-fmac: Use
 wireless-controller.yaml schema
Message-ID: <174233570227.4032670.15649222512672727997.robh@kernel.org>
References: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
 <20250318-dt-bindings-network-class-v3-3-4d8d04ddfb61@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-dt-bindings-network-class-v3-3-4d8d04ddfb61@ixit.cz>


On Tue, 18 Mar 2025 20:56:46 +0100, David Heidelberg wrote:
> From: Janne Grunau <j@jannau.net>
> 
> The wireless-controller schema specifies local-mac-address as
> used in the bcm4329-fmac device nodes of Apple silicon devices
> (arch/arm64/boot/dts/apple).
> 
> Fixes `make dtbs_check` for those devices.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


