Return-Path: <linux-wireless+bounces-11065-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFED94A261
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EE01F24536
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079E19A28F;
	Wed,  7 Aug 2024 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL1pKJzw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3612868D
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018097; cv=none; b=WachNarDxWGtdWnRgJvO7pfO08fZwzbpkrkb6/TqiPyx+qT1IMuT0p+8iyN+owUtxbRq8uaMLE1ZnSP7XLu0/17uP5ScRV2TR22wbl721Y/0t8famcbFvaU3P+ngaHtTXlgs1iwVWTV9EMkWp/RbY+l2qo8KHz27JFGQcfzMm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018097; c=relaxed/simple;
	bh=p5jWc7E4nec0zKzsQD/hvBZJwNiUqTyjGqv2Q6SL3bI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=u7EqaDpxWGF7X4XfLS/TltfJgLmsCi+b8DGzWfKNNpAfb/DrHqwHbIqXtptq06O4sBqrdhmv3tgMQxP8zdzWFvGRHSifko+Ekm3om9yg1Ai6qElHaun0WiZv46IEGSci8abKxhQQ6Mb+fFQPxyIm1BgaWjvRdpaJamU8HdSrPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL1pKJzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D35C32782;
	Wed,  7 Aug 2024 08:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723018097;
	bh=p5jWc7E4nec0zKzsQD/hvBZJwNiUqTyjGqv2Q6SL3bI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=JL1pKJzwHjyDfP3lJFSC/ejvnHuzkatBmIqMoUzL3Aq4r4HQi1OVJdpP1qV1kyHpM
	 29oVE/ANAoenb2IAVZjeItAarg+yXhzk4Orx7dIY95rSIVnUCrVtDH5BlLheM062em
	 iCLsJS8h1eJiemCCNQ2Lpj8M9+kSIRangHzkk47EF1Uo2N8Owyce0xe/XZYLKznza2
	 l/D0/WW9U+PYMnOTReMLd7FRI9T2o4wkdwj5ARu8qtGIMaUewtsSC2oLIel8EtdvFD
	 nEkjGV2jr3b7F3O1I2sXJ+dkoVZK9SitajEVkt4fAgeHIGIlZmieC6kBYnp/xM7dgz
	 CugaOGaWKuSRg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240731210243.7467-1-rosenp@gmail.com>
References: <20240731210243.7467-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172301809456.3837211.3718133893665019485.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 08:08:16 +0000 (UTC)

Rosen Penev <rosenp@gmail.com> wrote:

> Avoids having to manually call free_irq(). Simplifies code slightly.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

92da4ce847bc wifi: ath9k: use devm for request_irq()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240731210243.7467-1-rosenp@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


