Return-Path: <linux-wireless+bounces-16498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BE19F5730
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D413D16394F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E96148850;
	Tue, 17 Dec 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/S3T4Dc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C693192D69
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465120; cv=none; b=YpStuSbvgMNV2vsLbWkIM7y4DQV1TA8/RQzq4LPnqjXyBqxS+urLcMM6mE7YbzzLz0xdgRV/JNyvJ7yymp2Y2HGFzk/VQU95OZh8kqCj4/6BAaeAm484kwpbkRJE7LaNjhK9Hl3jtHG6xod89OpcCUDAVbn9dtaLnJCZW4EqJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465120; c=relaxed/simple;
	bh=PFdVW3M2zsV6E+4/fr78kUGR4v72BEibCHPd8gxtqss=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rkjMJ1oOZrAuKPnvGfbJBT7yTgFvub4PQTVWhuiZIOfbXg39yV9ISKJfDDdt85OYo/nhaK4SmpVsy3XJN6mKTSdpMODcvbXs2d0JLgzuSJOGkpmQX5RH7x9YCC0GbewOp27SS+v9Or2JQ+8AXd6H9T90WrmxCgG27gvn5unfWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/S3T4Dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283FEC4CED3;
	Tue, 17 Dec 2024 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734465120;
	bh=PFdVW3M2zsV6E+4/fr78kUGR4v72BEibCHPd8gxtqss=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=l/S3T4Dc1n2R1QznnwpPCRpSVMIoqc3hCN3lhSNWGtg7QY7LWjdtFe043yQmpsD0Y
	 bw5Hk2wmeAqMeK10gkV7H3hMWVx5AYA9CfFzYcfmeDAk0JbZV5CwhimQi72NdcsU6/
	 u819DufXKfXvnTtedWotXxial7NYU7rHZu89yBWS+jshyZzuH4tvYiKm1XAP4ZB7pe
	 wOnVdiAHzpYH55pOufZulxBbzTkjO+nqHtbzQXl2GKsZ5JphNuzt8foJBR+fjQo4Bt
	 n6tdGafY2KYBl710bWWyeG8P5H9DMHnV+fKt9Tbl55AqlOAq7Pp4ZdeDzYKdNfPoVr
	 QXAW5AlZIVLXw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 4/8] wifi: ath12k: Fix the misspelled of hal TLV tag
 HAL_PHYRX_GENERICHT_SIG
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-5-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:51:57 +0200
In-Reply-To: <20241217084511.2981515-5-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:07 +0530")
Message-ID: <87v7vijdeq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> There is "HAL_PHYRX_GENERICHT_SIG" misspelled as
> "HAL_PHYRX_GENERIC_EHT_SIG" in the comments. Fix the spelling.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

That's just a german variation ;)

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

