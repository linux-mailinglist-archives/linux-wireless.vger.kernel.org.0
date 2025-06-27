Return-Path: <linux-wireless+bounces-24604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6CFAEAFD0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 09:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC1F1746E4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94224219EAD;
	Fri, 27 Jun 2025 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaY4RI4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CC1922DE;
	Fri, 27 Jun 2025 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008248; cv=none; b=LctMrY4BmRZdiJxPibWeDW/l+LnX22M4dHqnoEq2aWWESywrVnNCdqyM9p1MgHZZBUH5ZGD6btU9qc47ed2vv6V/dUYWc2BA0pjymzItySssMBi0DzZZjoGVS8kM+Q+i+Y/Y17EoHvDancTk/Q3iOoguP3LPN07ooJWg+O4mVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008248; c=relaxed/simple;
	bh=nnswXYndmbNMxoIgrEQe1qpxvAMbKFPmz+5XgVZHh8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/6POMKG8LjcbYCVPYsH0QEBU8UbQj8JAaZ0F90apiFIqKEa4DChpM0HcKlY4K04D478C2kekGDhXKk5vlxr191P9YHQs6vALWz4OPblwIqTQapyXtPGJZ+zxv5O+TgCSgvZrEn7/6cvSIQfn/hXcAU2H8+CwD4hLPRylkZIfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaY4RI4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC32C4CEE3;
	Fri, 27 Jun 2025 07:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751008248;
	bh=nnswXYndmbNMxoIgrEQe1qpxvAMbKFPmz+5XgVZHh8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AaY4RI4gh/7Lu88584y3ELtmCSxOUwcsAVy9dP2R62yVxlB5k7cSkRWO35zMQrBHD
	 ahM2K5UV1sJu3w5Z1RXOlSbyVLj8xgWw6VYFOg/tOx5BF0FOOc12D7MGo3fQdxNTFZ
	 6cMt+VeF+IYwilKUo3u8l9XRz46YZkDDmc9UuXnVEQa08ljv+qWuZKLMNuGFhZsgzx
	 yXKLTy2vkP7mddjyJUkFRLmFWg2KlsZaagLaco1LjDqvBIxk8hN7SpaJa01jeRapBo
	 er2azhDOlTFQfvYDwkXFm1VAvDQ85vWwfEww0aKG/TJKmGYT0XxARdUsTU4uoSY/8l
	 0ZmI44RQTzk5g==
Date: Fri, 27 Jun 2025 09:10:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: mgreer@animalcreek.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	conor+dt@kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	martijn.de.gouw@prodrive-technologies.com
Subject: Re: [PATCH v3 1/2] dt-bindings: net/nfc: ti,trf7970a: Add
 ti,rx-gain-reduction-db option
Message-ID: <20250627-helpful-venomous-tanuki-3bca5f@krzk-bin>
References: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
 <20250626141242.3749958-2-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626141242.3749958-2-paul.geurts@prodrive-technologies.com>

On Thu, Jun 26, 2025 at 04:12:41PM +0200, Paul Geurts wrote:
> Add option to reduce the RX antenna gain to be able to reduce the
> sensitivity.
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> ---
>  Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> index d0332eb76ad2..5f49bd9ac5e6 100644
> --- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> +++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> @@ -55,6 +55,12 @@ properties:
>      description: |
>        Regulator for supply voltage to VIN pin
>  
> +  ti,rx-gain-reduction-db:

I'll add db unit to the dtschema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


