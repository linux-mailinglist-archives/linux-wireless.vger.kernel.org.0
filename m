Return-Path: <linux-wireless+bounces-11171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA894CBFC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 10:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB831F21B24
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 08:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A3718CBE2;
	Fri,  9 Aug 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXFy7XqZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBDC8D1;
	Fri,  9 Aug 2024 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191281; cv=none; b=KXo80ZxDg71NvkBSHc24N+p7rYYqoiv6sx4drRLYx61yrUyaQ0EvrlHpN60L9Pefl9Yu6ElPZKUlrWya83bZQ0C0T++aBOQxcgEVOvaeCGomQyZsdACX3PpF42JGkV39YySV5GF2G1cU9vMP8T12Ffo6L41t1R9hsWDdfEa+KbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191281; c=relaxed/simple;
	bh=a/g1SiizDFUuREfKCvBDyOSvAerNfT2kcq2x19KzR+k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DqIFra99NH86XPTwRpIFRbcpV/VPijOg1ALqUU+fEftkayZEp4qP0DAUL6prQJeF9gH6LqJN80KinJDlftMPf7sJ0Tzx5Isf+axNeXThx41tWHIbw56Cex5C5FwN5Zwsl1GJJYU2Ng3tIdFIf1l7OFQdfXrOypg9qYFnYU320h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXFy7XqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E744FC32782;
	Fri,  9 Aug 2024 08:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723191281;
	bh=a/g1SiizDFUuREfKCvBDyOSvAerNfT2kcq2x19KzR+k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iXFy7XqZurXVUjl5/OmYqh4vuK7lSx8DpAneuhZbmMcjjznXteTVli+/gkKqaQTgU
	 gQDQTkvRvyVU9q4RpVIiNUILNfGOabRXgnRHIgE+oGsUx7rbzlQp/XSj4w0N4eheEM
	 dSnHnIIwhqxfXPsBh0/OKpvzPBd30qjFQFbSdOpGnbEyhBgV5MHbhN06GxqjJSL33x
	 shWrq964AzNLN1NzUMYHJAqkppt1JicVrsTJyiVRVGCQOO1wXNI/x/uuIxby0/wJGE
	 5NHpc54Ptiet4HBRoTpkcBMc0WsGOJijl0kVUz0y0Y2LVLtvL1AeVAwFQsB/TvkI9m
	 8niloLYyLfe1A==
From: Kalle Valo <kvalo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,  Francesco Dolcini
 <francesco@dolcini.it>,  Yogesh Ashok Powar <yogeshp@marvell.com>,  Bing
 Zhao <bzhao@marvell.com>,  "John W. Linville" <linville@tuxdriver.com>,
  Amitkumar Karwar <akarwar@marvell.com>,  Avinash Patil
 <patila@marvell.com>,  Kiran Divekar <dkiran@marvell.com>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  kernel@pengutronix.de,  stable@vger.kernel.org
Subject: Re: [PATCH] mwifiex: duplicate static structs used in driver instances
References: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
Date: Fri, 09 Aug 2024 11:14:36 +0300
In-Reply-To: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
	(Sascha Hauer's message of "Fri, 09 Aug 2024 10:11:33 +0200")
Message-ID: <875xsai043.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sascha Hauer <s.hauer@pengutronix.de> writes:

> mwifiex_band_2ghz and mwifiex_band_5ghz are statically allocated, but
> used and modified in driver instances. Duplicate them before using
> them in driver instances so that different driver instances do not
> influence each other.
>
> This was observed on a board which has one PCIe and one SDIO mwifiex
> adapter. It blew up in mwifiex_setup_ht_caps(). This was called with
> the statically allocated struct which is modified in this function.
>
> Cc: stable@vger.kernel.org
> Fixes: d6bffe8bb520 ("mwifiex: support for creation of AP interface")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Should this go to wireless tree for v6.11?

"wifi:" missing in subject but I can add that, no need to resend because
of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

