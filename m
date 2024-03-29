Return-Path: <linux-wireless+bounces-5527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B6891411
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 08:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1811C288F28
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 07:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51853BB55;
	Fri, 29 Mar 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIYd5J/0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009133CCC
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696684; cv=none; b=gny0Tkw/uA683wZx7GCY9LW9OAeb1NRsOYVU2QnwkynWzZd78pxUxR1YiAxfVGwYy7saSFwoli8M4a+aIw5IEH20GGgPewC00WswUB3c0/pTR14pzRbyM1st6sY0g08g/2ACIgwheHX1T97cmxXGIVUdhYOK+F69U6MUhzTiXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696684; c=relaxed/simple;
	bh=hzwW+m82naT9oUQusEVw+iFltSi86tfAlL260aYbFXc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V6OsaKFC0j8Q1v5FCGRkLtJ/aMoLBQKNrgahg6NolkRoilRRc+lAjR1Go6CSC9rNnIuk9xRCngy6r7x0p5Sl0EDO3Ifx83pmICNnstza5Mjqbek3/O3ZJv01u0d3j6sP3eIsHtLrivGVWUPulIniIUEvhq9rjtFoGX1a8Orb1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIYd5J/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB83EC433C7;
	Fri, 29 Mar 2024 07:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711696684;
	bh=hzwW+m82naT9oUQusEVw+iFltSi86tfAlL260aYbFXc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BIYd5J/0isUrZ0/Fz6Nh86X1CSHE/017a4b3lXJQGStUn1RZrnOxa97RZxbIAQw6r
	 1Y0xl+oh+QH+Qn48o6viYTyjlOgVxrOA4ndr6u4GJfDIAT/fK0jsDyCtiCqDx6WuRA
	 hx8hmEb7nE4xMTcME4vF08y6VaSHzjJCTne0RFmx2foocTJ3U+H1tPMzqDz07nHRKF
	 xtyv2EfdWYGmYhjXXv/WgpdQcI6lTzes538U+rC1b/fM0gPe4pHoP/Z82RW0eyHkXA
	 L7/lN1EFD7aqKSAbVHFXoutbhy8PnvK+oGMcWoSRdLlMLvzz1Gcg20M9WrLEAAH/Um
	 G/r7khkXBWn1Q==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id B3A0C5FA0C;
	Fri, 29 Mar 2024 15:18:01 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Andrew Yong <me@ndoo.sg>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20240217014542.12971-1-me@ndoo.sg>
References: <20240217014542.12971-1-me@ndoo.sg>
Subject: Re: [PATCH] Revert "wireless-regdb: Update and disable
 5470-5730MHz band according to TPC requirement for Singapore (SG)"
Message-Id: <171169668171.2570046.3810446623986203022.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 15:18:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Sat, 17 Feb 2024 09:45:42 +0800, Andrew Yong wrote:
> Singapore's regulatory authority has confirmed that 3 dBm EIRP reduction may be used in lieu of TPC support:
> 
> > Dear Mr Yong
> >
> > We refer to our email of 17 January 2024.
> >
> > RLAN operations at sub-band 34 and 35 is allowed to transmit at ≤1000mw eirp with TPC and DFS employed. IMDA TS SRD Table 1 sub-band 34 and 35 can take reference from either ETSI EN 301 893 or FCC Part15 §15.407.
> >
> > As stated earlier, FCC has pointed out that the TPC will not be required if eirp is less than 500mW.
> > However, as the latest revision of TS SRD has just been published in Sep 2023, we will consider making modifications to it in the next release.
> >
> > - IMDA INFO (IMDA) <info@imda.gov.sg> on 2024-01-26
> 
> [...]

Applied, thanks!

[1/1] Revert "wireless-regdb: Update and disable 5470-5730MHz band according to TPC requirement for Singapore (SG)"
      commit: 73529a882f83afa26402b18680025334b0215d92

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


