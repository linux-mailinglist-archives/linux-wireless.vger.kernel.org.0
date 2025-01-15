Return-Path: <linux-wireless+bounces-17555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B831CA1270D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051B818874F7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3970801;
	Wed, 15 Jan 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+spigIw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7171304B0;
	Wed, 15 Jan 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954218; cv=none; b=Ls6fgurH26P/0f0v2Ld52L/gqh4ZMPFNK4RLUGHuUpyGxZaDUD340D+nI/LiyiG3FMCNJgbqDbh7STULKhNAeRR0qwElVFjWFq060Lu+zRdehSKitMu+oDEYYbTwLcF/6QUaw7fHqfnUe9hE2NiomcI0xehFTYiVWNOnTD7Co4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954218; c=relaxed/simple;
	bh=e8H0zp7MNqacJBs9d1qkeznwR6hkG7iTAzUns3yznHk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Z2QIYRcJ8G1fGp98/ZDZGW4dNIUHZdtpLz4k/+CmAAULIDt+iW7lADb3aFXgBTkTUIyaoWM1673XrLHtNLg59T9SW+Pd8JjFwLtjcSQ9lWqlI6zu5dU1A6FQEFXFNuTJ9YvaLli44XTujt5XVAvj8muQM2LPatkoSpKdbZMRQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+spigIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9BCC4CED1;
	Wed, 15 Jan 2025 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736954217;
	bh=e8H0zp7MNqacJBs9d1qkeznwR6hkG7iTAzUns3yznHk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=N+spigIwsmVvcO+naMqY4IPzo8kCADHBlmCTv21F+N/bWa9updqD8nMB7AIvY+Giq
	 u+nY2s1Pz3UVP/sTFxoe6N43jSUHGKNcFm6wSomY8DbCUf07wrRPUH+CuwVM2FwSon
	 wZc0tLQLUNkQyE5wR1dFSOVPwIyArDcBAliYVVd8iuaQLprt+Xp/LbwJl0o9SUxbW+
	 dIApDrrPaR4NeBn6Qtdjo9w9ceevORLXWb1AC4ZOgkTyCPf2vh/a4aSnXqSl0Oaznu
	 RnUtyO58Vk4IbbYC6uGSyTQDcvrExOP0NxKB5uEOFiP5Wpa7Yuk0oSUcnMXbk8h+HD
	 jSN2sEVKH+nbw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] brcmfmac: NULL pointer dereference on tx statistic
 update
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250110134502.824722-1-marcel.hamer@windriver.com>
References: <20250110134502.824722-1-marcel.hamer@windriver.com>
To: Marcel Hamer <marcel.hamer@windriver.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, Marcel Hamer <marcel.hamer@windriver.com>,
 stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173695421441.512722.1081406482312817540.kvalo@kernel.org>
Date: Wed, 15 Jan 2025 15:16:56 +0000 (UTC)

Marcel Hamer <marcel.hamer@windriver.com> wrote:

> On removal of the device or unloading of the kernel module a potential
> NULL pointer dereference occurs.
> 
> The following sequence deletes the interface:
> 
>   brcmf_detach()
>     brcmf_remove_interface()
>       brcmf_del_if()
> 
> Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
> BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
> 
> After brcmf_remove_interface() call the brcmf_proto_detach() function is
> called providing the following sequence:
> 
>   brcmf_detach()
>     brcmf_proto_detach()
>       brcmf_proto_msgbuf_detach()
>         brcmf_flowring_detach()
>           brcmf_msgbuf_delete_flowring()
>             brcmf_msgbuf_remove_flowring()
>               brcmf_flowring_delete()
>                 brcmf_get_ifp()
>                 brcmf_txfinalize()
> 
> Since brcmf_get_ip() can and actually will return NULL in this case the
> call to brcmf_txfinalize() will result in a NULL pointer dereference
> inside brcmf_txfinalize() when trying to update
> ifp->ndev->stats.tx_errors.
> 
> This will only happen if a flowring still has an skb.
> 
> Although the NULL pointer dereference has only been seen when trying to update
> the tx statistic, all other uses of the ifp pointer have been guarded as well.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/

If you submit v3, please add 'wifi:'.

ERROR: 'wifi:' prefix missing: '[PATCH v2] brcmfmac: NULL pointer dereference on tx statistic update'

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250110134502.824722-1-marcel.hamer@windriver.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


