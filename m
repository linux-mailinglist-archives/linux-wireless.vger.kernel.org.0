Return-Path: <linux-wireless+bounces-3129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BD9849EAC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21708B240AB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3903532C96;
	Mon,  5 Feb 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQo26lez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCA32C6C
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148004; cv=none; b=cv6gbnIJPr8ddg28vQHO5p4R0dPXjtMVY/F+VT/viI5klQ/oQR6h+gqflMi92veg8Y5cjjCUwRrfHniGJdioen0Fc0mFfQUNfzf4/0qwZrQhhob6Q7Hxa5h4S5HTOB+TDxx9wfQkw8fXwJulxZ++izoH/RmxSC/4epnbbkjvIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148004; c=relaxed/simple;
	bh=wOYus2KV7H9zl64+dCvGqXqXOnxoX0AZshbkkve11Ao=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Nwry3JowYKZAgcOz07lKIT5vSUBHGH+RwOsa3zWBc7ZVTB5fTC59UThZtS6XXa+QlU090ADO9HiBqczCazJd/BL4q+pU1YtErgp4U8zYUnksvjUKseB5XzROvNPP9MrjB0XKHUI4K9ZOidYmHXrU3xmprBzccNp2LbxNFBsCYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQo26lez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A47DC433F1;
	Mon,  5 Feb 2024 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707148003;
	bh=wOYus2KV7H9zl64+dCvGqXqXOnxoX0AZshbkkve11Ao=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=SQo26lezeAEOk2xSsdnNb4lXYiwwB2gGkRJRMnkHDk1y7kyaFzp0mKLp2YEIFjS3b
	 kvJYUMhzPAP/owOY+rOdwcHYONVmU/Od8GOcHXfWOS6FqmJPquq6q3Jj2+jS8GP7JH
	 gQRN82FvR4JRdP5iflxGHo8sZ+/wwNvh4CQlr7EoabCWiAW6hNAblwAuHOzTISDav4
	 IJL/CnXgkRklXhbo7+OS4nJ9cR13/lN+ZZRAAimfam6Cm8nXUgOiExymArBFHdldO6
	 uQpjQzRXnBRimCGKVxg2bcO73guVPBSClYpGu0JOOgxh6AIn/WrMunpHdT7ai0t3kq
	 Zo5ucvgzbWQZA==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] wifi: ath12k: fix broken structure
 wmi_vdev_create_cmd
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-2-quic_kangyang@quicinc.com>
Date: Mon, 05 Feb 2024 17:46:40 +0200
In-Reply-To: <20240130040303.370590-2-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Tue, 30 Jan 2024 12:02:53 +0800")
Message-ID: <87jznisylb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> Current structure wmi_vdev_create_cmd is not matched to the firmware
> definition. So update it.
>
> And update vdev_stats_id_valid for vdev_stats_id.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>
> v6: position adjustment.
> v5: no change.
> v4: no change.
> v3: no change.
> v2:
>     1. add Tested-on tag of QCN9274.
>     2. update copyright.

BTW it's quite a lot of work to add changelog to every patch, especially
if there are 11 patches. It's totally fine to have the list of changes
between versions in the cover letter, no need to add them individually
to every patch. Though this is not a problem, just trying to reduce your
workload.

> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 3 +++
>  drivers/net/wireless/ath/ath12k/wmi.h | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 2fa724e5851a..d8ebaf4b8359 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -826,6 +826,9 @@ int ath12k_wmi_vdev_create(struct ath12k *ar, u8 *macaddr,
>  	cmd->vdev_stats_id = cpu_to_le32(args->if_stats_id);
>  	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
>  
> +	if (args->if_stats_id != ATH12K_INVAL_VDEV_STATS_ID)
> +		cmd->vdev_stats_id_valid = cpu_to_le32(true);

Using 'true' in a firmware interface looks odd to me and I think what we
mean is BIT(0), right? I'll change this in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

