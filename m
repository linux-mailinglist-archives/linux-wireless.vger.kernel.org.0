Return-Path: <linux-wireless+bounces-16378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F11D9F0CC2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 13:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB27162945
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC422B640;
	Fri, 13 Dec 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOi+Y/6/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C791B1D8DFB
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094522; cv=none; b=rs9rEn0JiBW1Ihi+QnY1Yo4vadSzJWSgsXi06XemQ+JJweVawyxX1DxtUbqvXwmGo5NFA2FJ2ASonWcf21WO/Z/Wf3f7oPkNtSBD1TlLAwe4XfiSC86tVOLR3iFNYl+GReUMCCTbn7ydMw496jQ/gpBjYTROy46yNd4cEJGqdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094522; c=relaxed/simple;
	bh=aU5WJofoEiSXO3GZm9bnLo4fZasgiXbDz6m1RaUR3BQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=U7bftIvCb8HgJtVg7iwQ6QO8jGD12gskg3hILW+6QofNTNEdnYi5+9q+PHTS4B5PVI37wK5v0Od+YEUXcVwSeR36ncboYYdoWxE2joi9i6CVnba1u40V+DX9vCWtJet6fxd9g/IuIfoH+w0lNC+04tGOK+aONtAAgnVmtbfZU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOi+Y/6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCF3C4CED0;
	Fri, 13 Dec 2024 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734094522;
	bh=aU5WJofoEiSXO3GZm9bnLo4fZasgiXbDz6m1RaUR3BQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=vOi+Y/6/ZA+9+sPrpWNIvTbQlFiVdJzwQ0046JWUzSfVEZfCm7jeAQEE45r/HjgfZ
	 Z+TjtWsJyiinQgU3b+xJYKmUtZ4mxC3KNg6TN6hfu3Ji0Lsto2Y/fyufbPY4A5ACal
	 W+H2cA+f5oANnjCw1Lkl1C1g3Fm4SLAsqyo8OGZJhr9aU2cWVeQ04PcwuvUmw/Clk7
	 +uspk95wd+rEk9GW8dvhp9FEiqXCl3h4Txagakfiir8OnJs6GjPKDaLuDO+tF9tIuY
	 8oINn5lvqqp+bROuqo16A+AebBGXT/TOceDarQo4T3u0ie7Qvh2t8ULZYNR0q03KN1
	 CaKuDZ/RsuGgw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmsmac: add gain range check to
 wlc_phy_iqcal_gainparams_nphy()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241210070441.836362-1-dmantipov@yandex.ru>
References: <20241210070441.836362-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173409452004.1115965.5359701846780992779.kvalo@kernel.org>
Date: Fri, 13 Dec 2024 12:55:21 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'wlc_phy_iqcal_gainparams_nphy()', add gain range check to WARN()
> instead of possible out-of-bounds 'tbl_iqcal_gainparams_nphy' access.
> Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

3f4a0948c352 wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241210070441.836362-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


