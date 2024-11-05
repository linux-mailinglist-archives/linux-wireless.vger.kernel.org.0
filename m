Return-Path: <linux-wireless+bounces-14919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3239BCB0E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 11:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0173284BB4
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724B31D318B;
	Tue,  5 Nov 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/e75Dfg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9751D27A9
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804041; cv=none; b=YCtR9JHmTDePOUKQl4i27kekRWEQArBoOWw+OFqrYK+y7/Fq7EKw+zGN8jp7dYdxsDYyB5+zHRVAl49WBy6GAVCMHvF9GNYyU0phuJhrYG5QeC4ah7nX00zGaT3zwAoSociTT1nJakT4lUTgUP2MplbQwpsko+ONZdCd+fDETMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804041; c=relaxed/simple;
	bh=XnQvnXGm3KZ4JMpueMF36Dd3fxrnUpVISFGD5BXapmo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Ex3BaptoEic/eouqK4bU4NxXCwigBhKNTqged8fqSPUlbeZKM41RWacogiEr8i5LzRqQDCu1v3Fx0tcPZMIo8VJ2SgKwR3fQzrM6sQrYixzs6m/1ICzVaMapuy6c9cyO0aJyuOvGWyLP9lilns2qkoGJC6LpUKOhuc9yk5fs7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/e75Dfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED71C4CECF;
	Tue,  5 Nov 2024 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730804040;
	bh=XnQvnXGm3KZ4JMpueMF36Dd3fxrnUpVISFGD5BXapmo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Y/e75DfgIKC0KrHZclcEncigfxYCqbdmCubnCgIBIdJ6kndVpEqzece73XpcHRkAp
	 yFrhWx9hL2aZYM15vUW75IArIswOp4KwjiJ8VIXyuN30g47V2t9ZOJ7wmLo/fIVzqK
	 Abtv5WPgFDBs8RKYER1grayFN72NXjHMf95U5DtB63hkJx+n0KCrRwMC4ePCWAX9yj
	 bkoM7tDKMsvGtWlaH0XLbW8m9clpPuSAH4txEm+0obTdagQDp4bTdMazrNPQg5f2Qb
	 ZiBgHtaQlIUp0R4YJ8Z/zJszTj4E+GBc7vviZSCrAox2N+8nse8T0aB4m6vuIAmvyT
	 YfFOP4h79e4QQ==
From: Kalle Valo <kvalo@kernel.org>
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,
  mathias.kretschmer@fit.fraunhofer.de,  Simon Wunderlich
 <simon.wunderlich@open-mesh.com>,  Simon Wunderlich
 <sw@simonwunderlich.de>,  Sven Eckelmann <se@simonwunderlich.de>
Subject: Re: [PATCH 2/2] wifi: ath9k: Reset chip on potential deaf state
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
	<20241104171627.3789199-2-ih@simonwunderlich.de>
Date: Tue, 05 Nov 2024 12:53:57 +0200
In-Reply-To: <20241104171627.3789199-2-ih@simonwunderlich.de> (Issam Hamdi's
	message of "Mon, 4 Nov 2024 18:16:27 +0100")
Message-ID: <87jzdix86y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Issam Hamdi <ih@simonwunderlich.de> writes:

> From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
>
> The chip is switching seemingly random into a state which can be described
> as "deaf". No or nearly no interrupts are generated anymore for incoming
> packets. Existing links either break down after a while and new links will
> not be established.
>
> The driver doesn't know if there is no other device available or if it
> ended up in an "deaf" state. Resetting the chip proactively avoids
> permanent problems in case the chip really was in its "deaf" state but
> maybe causes unnecessary resets in case it wasn't "deaf".
>
> This patch originally developed by "Simon Wunderlich <simon.wunderlich@open-mesh.com>"
> and "Sven Eckelmann <sven.eckelmann@open-mesh.com>"
>
> Co-developed-by: Simon Wunderlich <sw@simonwunderlich.de>
> Co-developed-by: Sven Eckelmann <se@simonwunderlich.de>
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>

s-o-b missing here as well.

> --- a/drivers/net/wireless/ath/ath9k/link.c
> +++ b/drivers/net/wireless/ath/ath9k/link.c
> @@ -162,13 +162,59 @@ static bool ath_hw_hang_deadbeef(struct ath_softc *sc)
>  	return true;
>  }
>  
> +static bool ath_hw_hang_deaf(struct ath_softc *sc)
> +{
> +#if !defined(CPTCFG_ATH9K_DEBUGFS) || defined(CPTCFG_ATH9K_TX99)
> +	return false;
> +#else

We don't use CPTCFG_ in upstream.

Try to avoid '#if' if possible, what about IS_ENABLED():

if (!IS_ENABLED(CONFIG_ATH9K_DEBUGFS) || !IS_ENABLED(CONFIG_ATH9K_TX99)
	return false;

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

