Return-Path: <linux-wireless+bounces-13023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF697CC7B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 18:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4DD1C22A4E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523691A01C1;
	Thu, 19 Sep 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzYeltOI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1111CA1;
	Thu, 19 Sep 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762814; cv=none; b=czSXrhaGJooZRHQlRmetPvo9I8eNrnFCag8UXCePjbt70WJufiALICyEmOpoUBktgDyWKGoVdfrmeaY3WctYGUL6ziq1KxpUJPbe9G8ccPuEHT0ew2ZUblER/lvYu7yLQsxTvSZ/jByb+6tQXK7b8ExL9bdMDa0qCbgdls7flRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762814; c=relaxed/simple;
	bh=dPHsoE4n2Y3warmWrIaqW15tm8fNW/FDhzG4JvDougY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=lzo3CjMvogmWhJ7wbebnYos15EfhfMa1ZH6n6uGaNw87Sx41CuPCp4NxJhu0AmzLDKT3YP/VS3b79M/of6OkW9pZ1e+9r/WZgHZdQ2ywgQ9xJqszGz/w+1W7enN52E/IlYb2DK0iXFr2peA1urR+w8p/zd+zy3UKFBhsdEfr/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzYeltOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A637C4CEC6;
	Thu, 19 Sep 2024 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726762813;
	bh=dPHsoE4n2Y3warmWrIaqW15tm8fNW/FDhzG4JvDougY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mzYeltOIF+z0r4hPqBSz4ECGeqvOkRp22Jgnjz44SbrARcR8zqg3udMPnLIRLb8MT
	 PejeibcGlby/kUiUVN47bRxKw+Wk/58upQgJpdn38UJ4tT78ErhoNVl0i0SK9J3sCa
	 JLKTMkzKpWEFzEvXhaGMldnVz7S59jC2Sam7S8+T0niWbMh9iMGNSPhm2H67iIGvOq
	 bhNGjqPgOSkxyT0Jqsp4dFRHsc1wRi1ooQFchgGIgbQC2srLr5F+rjgD/6yEvQjTk3
	 Rz9/uVxwot0jmF6bvsABbyt3AciuJdzY+MKfzgAlto1R5tC5uN3GEZoXlKeSs45B5Q
	 1SHL5ZvfM01TQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath6kl: fix typos
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240913094818.14456-1-algonell@gmail.com>
References: <20240913094818.14456-1-algonell@gmail.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andrew Kreimer <algonell@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172676281033.263986.8967175339499015035.kvalo@kernel.org>
Date: Thu, 19 Sep 2024 16:20:12 +0000 (UTC)

Andrew Kreimer <algonell@gmail.com> wrote:

> Fix typos in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

07211778c0ca wifi: ath6kl: fix typos in struct wmi_rssi_threshold_params_cmd and wmi_snr_threshold_params_cmd comments

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240913094818.14456-1-algonell@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


