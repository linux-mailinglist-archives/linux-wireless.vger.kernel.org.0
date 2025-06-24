Return-Path: <linux-wireless+bounces-24415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B57AE5F67
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 10:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F02C1887B9B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 08:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C5725B676;
	Tue, 24 Jun 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxafShcX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBE25B31A;
	Tue, 24 Jun 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753955; cv=none; b=DpimDOCoSLdQzoVbr1xAsvY5tbqqcFE6TAL3aeRP2AXt8j7I1e9BpN1sxMKxUU9FiGCj4B32oIJvY1MRdnDEB/IpJn2JMUag7asGDGVebJFy9KldKuvYc03LfsEPoI8rpz6eo91jxctFpNoSUG42N5hNN7sO4nU/pvcdRYWOHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753955; c=relaxed/simple;
	bh=qF/2TqDtDQ1C1He5ZDDsFMx7oY/Nxq3SWripk0LkMzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H68QCRllsZgPWZzEgd3yJhfGrugmlFyyxIjaWiX9lNreK1FhjNFN2sO7tOoTgwHD2mkoQUGaXG86ADhyfhkY0x12OMy62UPiL7fYj84FrGW68l/cmZzStk5nyNs/oKd7zx0NIe/CZD4pL5+qHO2BpEKZPU1nJ5UPGTA4fuGIr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxafShcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7178BC4CEE3;
	Tue, 24 Jun 2025 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753953;
	bh=qF/2TqDtDQ1C1He5ZDDsFMx7oY/Nxq3SWripk0LkMzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxafShcXQIsDd0+CRV9gM6VsU8rGAI/MN95JrKIUDu9Crz0q3c4P+bNq0Tc+XUfTc
	 WCvnMyc+LQIBFCIY+LCj4ct98GSo2KM369SFlKXGijTPJ+x+/Mqp4K9YfTcceePNG6
	 wb2GH882UcIC8SaPude3vGVZ9Y0VOAQhPwNZy7/wiNQYSitR+/HLerQ3JrPweXeg9O
	 j+tmJArYNECwYe1h01GvPaH/lxdEeI9no5pdyWNzdeAGAoEyw6jqsc7pL0eo/OhlMg
	 5ykU5yqciHmxRQ5lMnwyC17duk9jC9Frleho1mVqyuaUGCzA0SNL8NGLaQLl7vi/MP
	 08Uri3raOvA9w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uTz4w-000000005Nb-49UH;
	Tue, 24 Jun 2025 10:32:31 +0200
Date: Tue, 24 Jun 2025 10:32:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>
Subject: Re: [PATCH] wifi: ath11k: fix suspend use-after-free after probe
 failure
Message-ID: <aFpingRwP3foaKJ9@hovoldconsulting.com>
References: <20250624082022.15469-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624082022.15469-1-johan+linaro@kernel.org>

On Tue, Jun 24, 2025 at 10:20:22AM +0200, Johan Hovold wrote:
> Make sure to deregister the PM notifier to avoid a use-after-free on
> suspend in case core initialisation fails (e.g. due to missing
> firmware).

Not sure it matters in this case, but forgot to include:

Tested-on: WCN6855 hw2.0 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

> Fixes: 32d93b51bc7e ("wifi: ath11k: choose default PM policy for hibernation")
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com/
> Cc: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Johan

