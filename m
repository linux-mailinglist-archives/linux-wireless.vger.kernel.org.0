Return-Path: <linux-wireless+bounces-30596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67464D07F1F
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 09:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 634F83052ED8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A18350D51;
	Fri,  9 Jan 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmYEV4VD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A4350D46;
	Fri,  9 Jan 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948318; cv=none; b=egKec4w/o4FZhw7BMxaC6rkd93OvP3eRH09Bhsr2xnM7yryk8gmXyOMnIPOpLn7xM1flpthoqogCMdkrT7/4reqRF7n0Em/XIiKrf9VNQbqey1iM5QDhPni01mLmR5qkeT8bQJOTVNPBDXc62sXOl5/aKKxp8/P9TfOlJRRhX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948318; c=relaxed/simple;
	bh=IRVowPBCW2vlETszGAMTQ3bg2gWLbqEp3pG15VhO8P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmFNfU5uRwJtyysF7RhM0tbkWUg8Blm/V1iFVCcu8fVox9gh4fzY9QDp94JRRC7mrW2O6egbArE1d3DLFwTpmGfFq7HnHm53PkTcysfuFSozHISpJW7ddUd4JYoynxbgSjMb65S2d6AGjd65woR2y1dgJWQ2ARJbQbmZUStDWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmYEV4VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4105C4CEF1;
	Fri,  9 Jan 2026 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767948318;
	bh=IRVowPBCW2vlETszGAMTQ3bg2gWLbqEp3pG15VhO8P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmYEV4VDbX1OOFIo0+CAZ5kEyuueYE/C0CcRA7G/q/TMCGGoIuMzMO1VaqWU0iBW1
	 tdWrVhBYcH9q4vRb79EgP1clzWrQQOzsbEmpbV22E+6srHt8aHXmOUnfa4Dt8PTaxm
	 VLuiVj7CpLgXCysZEcjBFHUkxC7pE7mAhLDrdZG2TMy61X/o6ym9DLHrJ2mx0Ts3EZ
	 3yPqAC63mfKClnPuzGjLN/UtCr6/Nu/O0twsyCRceb8L8ZfGE9GPRu3jqZ6vkCxlaW
	 rBLZqAJyFhU1SwSH5FT5X2vpyGKcvNk0aYURkLWMVirM/OUE0C2S13vlcmwn0LpFL1
	 caYElfOVDqNIQ==
Date: Fri, 9 Jan 2026 09:45:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jjohnson@kernel.org, ath11k@lists.infradead.org, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt: bindings: net: ath11k: add IPQ9574 compatible
Message-ID: <20260109-neon-conscious-gorilla-1c4514@quoll>
References: <20260109044457.3074510-1-mr.nuke.me@gmail.com>
 <20260109044457.3074510-2-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109044457.3074510-2-mr.nuke.me@gmail.com>

On Thu, Jan 08, 2026 at 10:44:53PM -0600, Alexandru Gagniuc wrote:
> Add IPQ9574 device support for ath11k. The schema is identical to
> ipq6018, so add the compatible string where needed.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> Changes since v1:
>  - place compatible strings after instead of before ipq8074
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml          | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


