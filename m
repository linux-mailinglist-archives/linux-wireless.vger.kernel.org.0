Return-Path: <linux-wireless+bounces-17612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E0A1423C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 20:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E107A3AF9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DF22F15D;
	Thu, 16 Jan 2025 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xydex+Uv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD922CBC1;
	Thu, 16 Jan 2025 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055602; cv=none; b=I+j60BUFkhLmdI9UJ6o37GixL63zw/yW1I+NmUpSM3+NE6D/WF4Ektv02F8Nnk8oKMq1SyMTSs7OHQIrU2Wwy/gajWbocHBrF0LiQatUe5TeSwYQH7KerjHAF9xb38RQOlERhRdpVNxMzLgorn1YAvWB5376c7iF+OGe1zS8OTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055602; c=relaxed/simple;
	bh=8ThmTuSD+p+yUGcgkVwYu3Bc0AbV2kbau4K4ECiY/jM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=OtSewmEeJp4u94M7k47BSbAqnjWCgiuyMb3ccHuBd6A3Zx4OOaV6mbppS+ALN0wCJ73rVNuInYYL8CVZvmCq5+f4FQSOgzIAgdAcpJi8wejtBmUjWafhpvP14ghhP3WtNLEDmHPVKPrrV8HeSs1CFnoM/3FdPF2g9/6amotgVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xydex+Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C0DC4CED6;
	Thu, 16 Jan 2025 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737055600;
	bh=8ThmTuSD+p+yUGcgkVwYu3Bc0AbV2kbau4K4ECiY/jM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Xydex+UvKpdzXzsUEq3rPGmdHp5rf+rfE50hN9iMTECIimgEf++FUcwCZHCJzkOzi
	 Bpbwq0lybvjJUqoCP49tI4pVpg3/nzL+hP27ZL4DPXtlvcnWriQWVj14AxEMdaSrNW
	 zIkHwoRk26/fiqQJTGyke6mxvjKpF08+HnTinoiMvAojziMbQjg1UoSPeKHFcv92AE
	 x6Wep07iA1UJ4Si20pnigjdbDuBNJq7VoJztvwMbw5g0k1jUJWYX26Pp6hRPD6ssj8
	 dJYrX125HS5eV+d+055/QqdVYU2u6yTcnYUFxKYl6jxx9RjWcYnhcmRaQy27S8NROZ
	 dAY/sVET5l4Ow==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: brcmfmac: fix NULL pointer dereference in
 brcmf_txfinalize()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250116132240.731039-1-marcel.hamer@windriver.com>
References: <20250116132240.731039-1-marcel.hamer@windriver.com>
To: Marcel Hamer <marcel.hamer@windriver.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, Marcel Hamer <marcel.hamer@windriver.com>,
 stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173705559759.574756.7473249345995457663.kvalo@kernel.org>
Date: Thu, 16 Jan 2025 19:26:39 +0000 (UTC)

Marcel Hamer <marcel.hamer@windriver.com> wrote:

> On removal of the device or unloading of the kernel module a potential NULL
> pointer dereference occurs.
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
> call to brcmf_txfinalize() will result in a NULL pointer dereference inside
> brcmf_txfinalize() when trying to update ifp->ndev->stats.tx_errors.
> 
> This will only happen if a flowring still has an skb.
> 
> Although the NULL pointer dereference has only been seen when trying to
> update the tx statistic, all other uses of the ifp pointer have been
> guarded as well with an early return if ifp is NULL.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> Link: https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
> Acked-by: Arend van Spriel  <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

68abd0c4ebf2 wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250116132240.731039-1-marcel.hamer@windriver.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


