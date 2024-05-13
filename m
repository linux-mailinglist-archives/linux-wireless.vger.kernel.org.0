Return-Path: <linux-wireless+bounces-7593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0F8C42ED
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 16:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC672814FD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC282153819;
	Mon, 13 May 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Qq5mYV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88143153817
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609586; cv=none; b=GIva9OK4h711PJjfTPvWCCgON66cdl9yVksBcktCxJxN/EbrUyvLTvaGElfkbPeKdsGMsiFogWQkYs65fgxS+aziRmhUi65dhzlBBGFydsT6VBr1fj/NTBQvXl4SCayz9lT8qWV4tfU9ex/nopRaX4DFl59FAPIttazv3idJfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609586; c=relaxed/simple;
	bh=k5hs2jo2DPrq9jeuC5BRr/1EQid+vELuPYJpggcc5IQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=nR+juo7YfC45/rfS5L8Z/Zr5dkm7PcriP6Rw8CcyQUERJ6tZGdtlMBmQmnOXbuR9LwlgweD5okwyRJA0ala6NdPYLsTF4Ju1hnEkDNv/ZooUMo+Uy1gzJOeZ9gge7z7BYLtPXnQpXfIeltFRJKubtr0BeAJKo79K5jOLA82c1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1Qq5mYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C15C113CC;
	Mon, 13 May 2024 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609586;
	bh=k5hs2jo2DPrq9jeuC5BRr/1EQid+vELuPYJpggcc5IQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=L1Qq5mYVBoc2UN8qllh8m7QnNxhAHiG7Cg8s1/7TIzQATUIaLh1o1OUvpbldPsQ4g
	 90FPj9leTVU3TVz84LGLh1W046yr3TLFFHgRg/r8LuTsvGCkI/gL7QoXL7kZt2sb/t
	 qzbxIlONTmpwYFRVCYXS4sCM6QQFswiE99TjgCdCo1t7EbLaDUXVoBwPnBUqvA963B
	 AJknkyjHOZVbQePq7lPJFZo33UMPL07Gg2jarhM6PUHSFWyOdvM8LA1ly+YsusMSIy
	 p9947eIwt5/rV503ZhSF6U9bPOq5K5IgnwUizuAi+tNPNROOrkkIJ8UMYp5PFDh/L/
	 hq80FusdIrdVQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: avoid double SW2HW_MACID conversion
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240506173017.597715-1-quic_periyasa@quicinc.com>
References: <20240506173017.597715-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171560958344.1690511.4558865719984074214.kvalo@kernel.org>
Date: Mon, 13 May 2024 14:13:05 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, ath12k_wmi_pdev_dma_ring_cfg() fails due to an invalid pdev_id
> parameter passed to the WMI_PDEV_DMA_RING_CFG_REQ_CMDID WMI command. This
> invalid pdev_id is caused by a double conversion of the MAC ID. Since the
> the caller of ath12k_wmi_pdev_dma_ring_cfg() already performs the MAC ID
> conversion, it is unnecessary to do it again within the function. To fix
> this, remove the software (SW) to hardware (HW) MAC ID conversion from
> ath12k_wmi_pdev_dma_ring_cfg() to avoid this redundant conversion.
> 
> Found in code review.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2db7a82fd150 wifi: ath12k: avoid double SW2HW_MACID conversion

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240506173017.597715-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


