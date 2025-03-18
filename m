Return-Path: <linux-wireless+bounces-20520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218FA67F5A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 23:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BE188583E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631B212F8F;
	Tue, 18 Mar 2025 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz1+N7Vx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360B2066F1;
	Tue, 18 Mar 2025 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335677; cv=none; b=Dn+TAk+4pIjnA3+YLFs+pdhBzvkwMSm0W+qw84ZvLKzFnelNwiddwImfT/Px0MeuKU2CZw3ICp+nKOiyDNtcuk4g/T9llhxw1YkcfiwCN41rfxkD2kfJuOQXMZzJkoEBDfUQ4juqHKdimRWH4kSb3CFYwXe0zqJ7E3WAlPJrBT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335677; c=relaxed/simple;
	bh=YfuR1zs/gRrNrysU99AgEhTO1EMJ2cqH3DMgQKV1rSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orvxUNQoKAIjZOXQDKd9IQ2qCEy5PQneTnvOwgBbwnnkudCuAUBD86dGJm0N1M2VN5F9mSrjKE8QyICJeLkxYT1DLlu45vHiuyCyQEGm1HM4HRf7PtlWm9jucKX/A8bZuMksZlss3I7ARnjzpV+o7IB1Yj2ZKY+WclXaA3vY7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz1+N7Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764A1C4CEDD;
	Tue, 18 Mar 2025 22:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335676;
	bh=YfuR1zs/gRrNrysU99AgEhTO1EMJ2cqH3DMgQKV1rSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zz1+N7VxfMTI7IkQg9f3UCHejSOWCyfJnyOkHwewB6UOeJY4QBCIuP1u9dMVYhG3G
	 NMMBlXXBU/p+iNk9Rv36d9f4sonQzFMkJGR6U/LjxZGi8Bb+RtU7lEjfYQhn7g+nMo
	 AgMolh10aw8Lg513Thlbjy7L/xv4/BcwyjIMOiQQbW5+suA+p2LoBVNUwlwEW4Qtbj
	 /y6W0my2vhUnHb5liGw6i2tlu2abhVwdrzYaL8wMfQQDYyBoi79gVQRZwF8eqp3rGr
	 tj6qU7wchiw2nMYPJ40gtuWdv/KOMYylf3zcrMG+yUN7fG7H8Tfj9Pi3YQMxuqJWOc
	 BV75WeNDsWCsQ==
Date: Tue, 18 Mar 2025 17:07:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	van Spriel <arend@broadcom.com>, Andy Gross <agross@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Janne Grunau <j@jannau.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	=?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
	linux-arm-msm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: net: Add generic wireless controller
Message-ID: <174233567479.4031904.3453384651972663945.robh@kernel.org>
References: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
 <20250318-dt-bindings-network-class-v3-2-4d8d04ddfb61@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-dt-bindings-network-class-v3-2-4d8d04ddfb61@ixit.cz>


On Tue, 18 Mar 2025 20:56:45 +0100, David Heidelberg wrote:
> Wireless controllers share the common properties.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/net/wireless/wireless-controller.yaml | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


