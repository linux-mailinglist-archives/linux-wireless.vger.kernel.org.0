Return-Path: <linux-wireless+bounces-27929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FBEBCD85C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 16:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D83B4FEA4F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A422F532F;
	Fri, 10 Oct 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpzpcZ/d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9F287268;
	Fri, 10 Oct 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106329; cv=none; b=JlyFYN80TJWLnrYFMU+YdgmOLBSgRlWgK78I7uPl+6o/0YndB7bYjf9xy5mBq8bzhnlwgd/qp06nVtF/rx0v+wiGqyJ1AxSw5pa79VH6cbwfb6kLJFFOGmi2Yj7JmCFJHTj5cQoSy7wk0yxBRSeUaJF97LOIplScLfXwerXaGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106329; c=relaxed/simple;
	bh=2cqoklTmnWcMBIxfli3d/ARO/y0tQWg6ESZXPMf9q0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZBN3ekLVMFLUylxOkqbyLCMD5V90mkkmBFce4TO2lKNJUTE0JIkRSMJPhQl9FzzV7ij0fu5n14wRLjceEE1BXR7sowRIkLlrjY2SoARdsHkhUMKHDiqkRynqRc6TMRtKD9hN75u+E4h0j4vKZ99LK3vvkAQCsXrjiE84Ao8P+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpzpcZ/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727E1C4CEF1;
	Fri, 10 Oct 2025 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760106328;
	bh=2cqoklTmnWcMBIxfli3d/ARO/y0tQWg6ESZXPMf9q0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpzpcZ/dKsdtgEk2sydCmYgvR99u1H5iNfrZ6WIpCTfgdKaLAtChsAxBatdre8cI6
	 mpqUg3lak6r+Pb1sJ1/kWOKdj75Vz6tsnHq1KQ9FfQTAJH1v0sLcqaPwXfeN7z//GV
	 Z+K8aiV1pKme6p7fSxbEAy/lwmQJFJdjOffDf5ThZ6ISFlJ2apU2Sp3BhyeV3Fujuo
	 tSX2icvdUoZ2pz7Efhc8TA7bpOYqvuEffH+yf2W411C7fW3KFTaycjCzzN7IzkXXk9
	 IxXn7gPwybpY/E8CL9ry/3lwDr9gun4ZrVUQ8jsh3v4zTNC4y8JVXqbJuo2SJ7tdfi
	 YO4UPHzhl451w==
Date: Fri, 10 Oct 2025 09:25:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	linux-stm32@st-md-mailman.stormreply.com,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH mt76 v3 1/3] dt-bindings: net: wireless: mt76: Document
 power-limits country property
Message-ID: <176010632601.241034.1894010503665386462.robh@kernel.org>
References: <20251007-backoff-table-support-v3-0-fd6e2684988f@simonwunderlich.de>
 <20251007-backoff-table-support-v3-1-fd6e2684988f@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-backoff-table-support-v3-1-fd6e2684988f@simonwunderlich.de>


On Tue, 07 Oct 2025 10:11:14 +0200, Sven Eckelmann (Plasma Cloud) wrote:
> The commit 22b980badc0f ("mt76: add functions for parsing rate power limits
> from DT") added filtering of the power limits based on two properties:
> 
> * regdomain
> * country
> 
> If either the country or the regdomain matches, the power limits are
> applied and the search is aborted. If none of the two is defined for the
> power limit, it is a global (or "fallback") power limit. The last
> "fallback" power limit in the list will be returned when not matching
> regdomain or country was found.
> 
> The idea is here to allow to specify "overwriting" country limits in front
> of the list - just in case a regdomain is shared but a country has
> additional limitations.
> 
> But this property was forgotten to be defined in commit 2de6ccebe0e7
> ("dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node").
> 
> Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
> ---
>  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


