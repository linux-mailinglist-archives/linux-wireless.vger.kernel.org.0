Return-Path: <linux-wireless+bounces-19412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E20FA43804
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 09:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EDE3B231B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8642144BB;
	Tue, 25 Feb 2025 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K30fuygb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84213A88A;
	Tue, 25 Feb 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473256; cv=none; b=e/rmBDnnxAl7TxOx3apf3HL2B3ATAhr5SkA01EWE0xgtyLuqxeyQJAl4CoAjSADpN4mGm85JinTMVYILri8kx5i1WFRifWyRGdPk/wGzWNfo/lQ6Ly8Oq2cvgMpzTinD9OLGYJTlRBZnVDvcYQyrA4RZ6eB/A5xCnvXkFqd9M8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473256; c=relaxed/simple;
	bh=jkoutzfuhyhscH3rYrY6wsqgU+1ykH7c9nmt11/wUgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKq2AZjEFM+AQO3w20vRXWrHSdWydFZDa+NUbnxh2wjzceMAa4bqpDvDt6OU+JMM3MjRaVd2Uolft2wahxv7ZFblr0kGOaHuPZ498aaE2w1VAMnThrE9whUuU/Td8nTEQdTSI9gwrtsRVjiOhAH8urTjBOSxuzUY2nRBbbIfxfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K30fuygb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204D0C4CEE2;
	Tue, 25 Feb 2025 08:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740473255;
	bh=jkoutzfuhyhscH3rYrY6wsqgU+1ykH7c9nmt11/wUgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K30fuygbSJHkOo+oklTE+KOeEMMAX06jAIb81BHPEmuKxL77/5/qHIAo39C6Nhqp6
	 cf503saHuLaJwoWWnxAzpoI/uW+lk7xPdQRwvuXEC6Bi6ZjtSIY3GlOMCc/rtbI5CT
	 s55NsDpPJwUCPN4aMnx45r8NMjou5CTl6VVqHyjnhChFA8Zvrwn9p7MzoVfZOmqAo0
	 47lVtbueWpZ9Orz9mYaDJWMJc8uoG7AqdZMc73hs2GBS1iwyue+XG2FPiYwOCKRAjs
	 NIXYZjGKP05DP8M82XA7bBEIXbFXUevMq6lxrfecxV8uLHbnE5UfQWSzY3SHK86jD7
	 Ltf3op4wqQstg==
Date: Tue, 25 Feb 2025 09:47:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/13] dt-bindings: net: wireless: describe the ath12k
 AHB module for IPQ5332
Message-ID: <20250225-abstract-arcane-chimpanzee-ca7e4f@krzk-bin>
References: <20250225064834.2002499-1-quic_rajkbhag@quicinc.com>
 <20250225064834.2002499-2-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225064834.2002499-2-quic_rajkbhag@quicinc.com>

On Tue, Feb 25, 2025 at 12:18:22PM +0530, Raj Kumar Bhagat wrote:
> +  memory-region:
> +    description:
> +      Memory regions used by the ath12k firmware.
> +    items:
> +      - description: Q6 memory region
> +      - description: m3 dump memory region
> +      - description: Q6 caldata memory region
> +      - description: Multi Link Operation (MLO) Global memory region
> +
> +  memory-region-names:
> +    items:
> +      - const: q6-region
> +      - const: m3-dump
> +      - const: q6-caldb
> +      - const: mlo-global-mem
> +
> +  qcom,ath12k-calibration-variant:

qcom,calibration-variant

Best regards,
Krzysztof


