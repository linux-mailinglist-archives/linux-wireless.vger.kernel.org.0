Return-Path: <linux-wireless+bounces-30304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3955CEF582
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 22:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45875300CAD3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 21:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F5221554;
	Fri,  2 Jan 2026 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5xGIv8F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C011125A0;
	Fri,  2 Jan 2026 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767388671; cv=none; b=mqagCo+Gy8vhJcnUGWQkU8saM7HavxFn0rlShnkc84cGKyVt6jNziP0SIQXCJdhGhVDxgWXqCEA60YKN7L5DgbOIpQ80j3NI4S38kX0QnfRRDF0v1QviAjfy4syo139hCI1pIweOcB7IRa9jBDMwbtTuflVUlsdxJH1VaUeef7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767388671; c=relaxed/simple;
	bh=Wmy5ed3YGxGb0MZ2kcqjFsdOicrxvlhnA+MzPNdvS0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMZmrx5Vf7lQP5qCXl4Kxs0GAXPVzMu4W8REJiyBpNICHZpp3d1ce7iDBthQXS1hbY9KZisTQ4ocNx4PV6H/eKT83gYKALfrLszIL5OcsITiHvAYOZJZA59BhxGb4pC0csZivlnPUGJ60MROy3HMfWcqRp+b6Y37b+RBkJ9ehuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5xGIv8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7D1C116B1;
	Fri,  2 Jan 2026 21:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767388670;
	bh=Wmy5ed3YGxGb0MZ2kcqjFsdOicrxvlhnA+MzPNdvS0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5xGIv8F6/8OGvVPxvNzX8YceW4K4uHRDomjvOgegHCBjt/GQ+EWb25FTbPoFF0WH
	 sEecm/DwXbS9mjP5EPL4XXnqEp85x/YHC00pR7dMRZfsc4z44Qq05eVwMfmAKlISkG
	 jYHwY5G08vdw25NipaXB52j9MUust7cKUBhG/WD8eMZ7kfaatOZFPMUFFGXIgSVcYR
	 75ChhFFQEK/1bxqn/pMsDRw+VWn/m83Hl+wTXwrG6HFD59jL0M9mtXeb1yI0293z4z
	 OD/bNBZx6pUFr1Nr3GqFCjYs4KYtW1MYvYHasUijUGYqjpt6h3dOiFVI1yV8SHs0e5
	 IyDKA0qX1miAA==
Date: Fri, 2 Jan 2026 15:17:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: wireless: ath11k: Combine two if:then:
 clauses
Message-ID: <176738866889.203763.17293474751487788708.robh@kernel.org>
References: <20251230114835.52504-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230114835.52504-2-krzysztof.kozlowski@oss.qualcomm.com>


On Tue, 30 Dec 2025 12:48:36 +0100, Krzysztof Kozlowski wrote:
> Simplify the binding by combining two if:then: clauses which have
> exactly the same conditional part.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml    | 9 ---------
>  1 file changed, 9 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


