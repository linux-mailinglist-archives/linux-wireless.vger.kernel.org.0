Return-Path: <linux-wireless+bounces-12607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199696F7E8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B301C23EB3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97421D1F77;
	Fri,  6 Sep 2024 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="K+37fkaY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821341C9EA4;
	Fri,  6 Sep 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635491; cv=none; b=WivW8A5hjWc6U5heq0FmCwkPUWvtZYsyEtjQdhr37lFA2jUG4YR9efi8TdfTVZuBMKULBuDoMcz8K4nmsJZfnPYDDNjlExTyzyd44CgBqsMCTtrRBF82FDtaKTvicBHPicJZL8zPYfARUBtf3oV3Q6LhK+4wusxAM27nIB2FhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635491; c=relaxed/simple;
	bh=QfohptCH1YybDziFw3maSoGKjNk+02vIgJIn5egzYX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXmiEf2A6sZtQTLOs2p7tNwcEq2lsdvsBrajS1//EpnVfQUP+8JRG7+HwgEJliXN9v+YkLat9C6CeCJYGvaq7EaueSppEW7MKywXwd2wwzr/hU6BQX0hFXdSq5e0BnABYGqnLo6jVtHX/0mxN2z0e0JUqmPsqaFAdO+RqlTeVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=K+37fkaY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 769AD1F9DF;
	Fri,  6 Sep 2024 17:11:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725635487;
	bh=fu1sBhFir8dVvtH/eI/ueXu9sJmcAaMiaHF3cRac+Zk=; h=From:To:Subject;
	b=K+37fkaYFC29NjhCq72WFr9nayUrFNJhJlNXJ9RnpRmucFTpJbuCtxyEIfskuttoj
	 o3+1JLJH18kewXTA0M+Gh0H56L46agfScZFbnUtXZGvhVzE3kHydevvNrjOw8MSIzs
	 ssp4xSC4+WGCXL38lEFSWFFht0pFyieSM+0w6pygYrR5X7qexlf/clFZpXUNpUXUWB
	 TtKuDH5MBerd+6yecObyTKKLU6HhC+kqrIQW1eyK7DEJeNjCuoP0t8yqKA0Am1QCMc
	 8CgmheFpDCLhiuz/aL2ixqKv2AzP4gHrhQ53CRsNlBMqIMXXE/Ma6hBASGTnJ9SiuL
	 t+TyGCoGgdCpg==
Date: Fri, 6 Sep 2024 17:11:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] wifi: mwifiex: pass adapter to
 mwifiex_dnld_cmd_to_fw()
Message-ID: <20240906151126.GF45399@francesco-nb>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-7-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-7-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:28PM +0200, Sascha Hauer wrote:
> priv is not needed in mwifiex_dnld_cmd_to_fw(), so pass the adapter to
> it as context pointer.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


