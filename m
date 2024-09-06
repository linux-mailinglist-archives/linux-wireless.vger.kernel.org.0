Return-Path: <linux-wireless+bounces-12609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1669C96F806
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 17:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60A61F25958
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B81A1D2F4F;
	Fri,  6 Sep 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="jdEsolRL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68A1D2F4C;
	Fri,  6 Sep 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635782; cv=none; b=UJVp0VoYXRqSiN+G4huENZQ8NMcqL1onxDe2nlt3Wj/Y8XSyLKXgnG5Z0XLeh9sYFhvVOsNRONi/ZQpU/fanVi3DsdPxQIdyNEacTrJn7IqQ935r2rDcrOy46vgZ8odGUJNqW61TTTw9tuA3LnNa/KFgjLMjoppX+nGPMAQW+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635782; c=relaxed/simple;
	bh=0cnblALVXilsBwgaZWaXgFghZwm1pN4rPUyt3fr1C0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1KsRQ2nAKwy0Gx5J20lY+SrlI0/HtZWqjMrHhZ3k+gBd2CxhemgvWLXf4tdgOkExHyYv5yGzV7MKB7Ol0ikAQGHbGX08ywpO/BnM0rZ5g2BE96Vu1Uu5dIcH6+5fMStlHU2Oe1DMi8uXTzyM6fB7DsZdvVUbzV+28kjonFshCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=jdEsolRL; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 97F3E1F9DF;
	Fri,  6 Sep 2024 17:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725635778;
	bh=du5Cq/ZSY2hH2IE0Yok5ZTR8FCH4ohJmUEjdIRzkA4s=; h=From:To:Subject;
	b=jdEsolRL5N581lLSre27QyAh4XDwbwOOGSk7Dg1sYnwqxQGQ1xC8G1VPOo1XzPHdo
	 IhnK8dpYdDcwNBlvGq0qf9mblNo2Dqtsl/78tX/EFlW+P9GMkhJv4jK7slglj5wy6B
	 PmXrgqbcwDRc/GmJca8nZfxw/3C9RX/KYMtvJrauA3lkXFEaPVllXsyFAcGW6tcvJk
	 Mu83qGMmX1EqX7jdGVgae2tkQAqKFfIOSFPmDvghuckfAawlA1mftHaVPVyiCq04Y9
	 jzPzYL2O8QgV/InTp1GqejAyKL5WKnuAwsxj++Yk6PX797vRVh56/FZZK6xEKSgva4
	 zIeazmhdh8fkQ==
Date: Fri, 6 Sep 2024 17:16:17 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] wifi: mwifiex: make locally used function static
Message-ID: <20240906151617.GH45399@francesco-nb>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-10-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-10-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:31PM +0200, Sascha Hauer wrote:
> mwifiex_is_tdls_off_chan() is only used locally. Make it static.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


