Return-Path: <linux-wireless+bounces-3686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB248582AE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 17:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D45BB24066
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231112FB20;
	Fri, 16 Feb 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUpmOZ9I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73E12FB1E
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101345; cv=none; b=N/h3fYfM1N5zynD157OXixHJuzH1wJQY6zoD89i3hVmCvCYCa9n0Cn07X7cmOJwGGg55iImFl1+MQ4+PV/1hZzesDH962yIkfF7eKbnHlD5d8HJwqbQknVh2uACxmxRlz1Y6mDvN2K++TlaEeBu6p5bTkUA/e0UHzaPYVGMPgOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101345; c=relaxed/simple;
	bh=Ln8SvTSKUBvAst/PdaGwGh7GdSDxPCTOFBToh/EUHKU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NEj63gFKlwQrhHIjkty5fJRsuVeo+qLVwaoicp1uiCv06xvxWVbfeEXMgezExXajiv1q55Z+npWnAlM8rASkXwoWPVMmEiktbiJcvuq085pMFaacvVPClTg12/TaaEUIFitzjKuL38vxq4KdDGwL0eGu0T0KxJCCmf2e1tkZxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUpmOZ9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C561C433C7;
	Fri, 16 Feb 2024 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708101344;
	bh=Ln8SvTSKUBvAst/PdaGwGh7GdSDxPCTOFBToh/EUHKU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YUpmOZ9I0aLwJcrYutr+JPvg/qE+8Y+Msy6FvdjxUX133kIQQCavXVwJV4xuSYzSt
	 OBahGWxivh0b3PVDpGHQ+abXaRDW71xGgqqZ5aAoixRVDsDgqssa4M5onDbQyyXxLm
	 mXqGIrKvZJSSFJk/FNFZI/cl+HfqKj9vLxCjEijEVgxi9SCOb7oCHSqHWuSotNajJz
	 gdiM49diHqL3sT6ChuBS+374wHeLFhteeEgeJR31RCoguDKLT6P6qAp5dpS3e8l/wB
	 DPEqEVTcc57NIWAM8qigHg8Fd0KCKFJL0xBGgAJVuU0/N8Ijts3WOqeRsFyEYNqauz
	 MWWkD9J8z7jwg==
From: Kalle Valo <kvalo@kernel.org>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Sriram
 R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v2 03/12] wifi: ath12k: modify ath12k mac start/stop ops
 for single wiphy
References: <20240206091954.4144454-1-quic_ramess@quicinc.com>
	<20240206091954.4144454-4-quic_ramess@quicinc.com>
Date: Fri, 16 Feb 2024 18:35:41 +0200
In-Reply-To: <20240206091954.4144454-4-quic_ramess@quicinc.com> (Rameshkumar
	Sundaram's message of "Tue, 6 Feb 2024 14:49:45 +0530")
Message-ID: <8734tsnz8i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:

> From: Sriram R <quic_srirrama@quicinc.com>
>
> When mac80211 does drv start/stop, apply the state change
> for all the radios within the wiphy in ath12k.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>

I haven't reviewed the patchset fully yet, first quick impressions:

> +static void ath12k_drain_tx(struct ath12k_hw *ah)
> +{
> +	int i;
> +	struct ath12k *ar;

We usually try to have reverse xmas style, of course not always possible
but here it is.

> +	ar = ah->radio;
> +
> +	for (i = 0; i < ah->num_radio; i++) {
> +		ath12k_mac_drain_tx(ar);
> +		ar++;
> +	}
> +}

Please avoid pointer arithmetic (in this case 'ar++') as much as
possible, it's just so easy to shoot yourself in the foot. In patch 1
you add ath12k_ah_to_ar(), why not use it?

And I see this pattern quite a lot, should we have
ath12k_for_each_radio() or something like that? Or did I see that macro
in some patch already?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

