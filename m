Return-Path: <linux-wireless+bounces-27834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071C2BBF66C
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244483C3672
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C6256C84;
	Mon,  6 Oct 2025 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igLEaH4C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20728223DD1;
	Mon,  6 Oct 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759784018; cv=none; b=tEzBKtfV6rKtcbW0NTleaLkxjLDmGvCEkniuHKY2DzVU/CSvf3PTZ3ISnrZsmP3TfbMJ4PDPase/1PidJyjBuDtp3Da/lOmCc3mZTTMpNgWkojocZ6DdzbxyIIzeQ0peG472XEC8AyBAK7xYeFlJFbWWH18hnTsEMraBaoC6hqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759784018; c=relaxed/simple;
	bh=0tCd4WF0gQtfi6/fB2e1mBANwyNMnWMhiYWPsP6L4b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpSE44K+yj6jgPSIEdlVKuwJIbTASSV8M3Y8krXb+Q2f7Aqzr3EXz0j9gVUR+vlJsXEPD996ypMYBIJoVuWMuWzTbzDt7glv74KG9WKCmIRYJUvNyXod5ALprjPYnWreZi2ErxTBflTeiXXCeucxcVC/1zK+FAZEpC2R3lduQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igLEaH4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7199AC4CEF5;
	Mon,  6 Oct 2025 20:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759784017;
	bh=0tCd4WF0gQtfi6/fB2e1mBANwyNMnWMhiYWPsP6L4b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igLEaH4CU8kFnBHLB8+7B/C+/775mvsFWWGMwqL/+iOGRFpic5iwoBGBCMunOKQj1
	 caxJUTzwJQsFj2+GTKVA6x/Be2ciFIV2vsPxOfFlpyGSixxfYrPNA7mop0Y/RHFVwb
	 EpGtxCL4NdwCKZVUF9bL3615/Hxt7B+dxTWxJ+0vb6rRvgUWm2ViiTR5Vz0b5qmFq1
	 UYctq6gFsHmXYLXJvjJxwYlTilTF0ODJsEqgfztVaGXLR4iIPPcy7DEG0yGPHtDyfB
	 2Z1qb8LOySvxZP5qoUzlwxq91n1FVsrIWGyj0S7srBm56v0dsTqyYwM7gBAIuktG07
	 5SwJceazLJCBA==
Date: Mon, 6 Oct 2025 15:53:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-wireless@vger.kernel.org,
	Shayne Chen <shayne.chen@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH mt76 v2 2/3] dt-bindings: net: wireless: mt76: introduce
 backoff limit properties
Message-ID: <175978385977.561952.12777844195936444721.robh@kernel.org>
References: <20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
 <20250926-backoff-table-support-v2-2-16d3726646c4@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-backoff-table-support-v2-2-16d3726646c4@simonwunderlich.de>


On Fri, 26 Sep 2025 12:04:53 +0200, Sven Eckelmann (Plasma Cloud) wrote:
> Introduce path backoff limit properties in mt76 binding in order to specify
> beamforming and non-beamforming backoff limits for 802.11n/ac/ax.
> 
> Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml       | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Though I know nothing about this. Is there any reason why this is 
all specific to mt76 rather than being common? Perhaps these settings 
are all just part of the opaque "calibration data" in the QCom case?

Rob

