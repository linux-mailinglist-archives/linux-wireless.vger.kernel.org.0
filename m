Return-Path: <linux-wireless+bounces-4423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5F873241
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 10:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBB81F25AA3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C845F56A;
	Wed,  6 Mar 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHJZmM/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A05F49B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716447; cv=none; b=Oq9KtPXBGVCNRDZGFaQqJzleG6CU/oXV3b1NP47rEsbI5Jl0VHXzsSCAeSyLUsVkNm9lFDu70gwCeEAiMqZ/eqDY2arLVEqSoeL1TpiD5Hhfco2aFXAO7eJIqqjt8rt5EIkVFz35DYoJzl/nqvNtD7j0XnFJIIETBQcNq4HutEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716447; c=relaxed/simple;
	bh=gYzMZ/+cPGxLTP+zBtocfjmFMnBIyF7p6unjEf2f0y8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=j4uxTkTjwkvdGbld+PxLAMDVSgr5J6fAfwQ7ImwIVIuhO7f4VS9EiDdWLArnJcJ/E9TC2ZTS6eiw1tHkpADXI7sZHsu6qXA65hlJatbo6fpPSF/yVvaWmb8o2CNbhqIexiPkl3pDEZ2aN8pAWBYAw2MUz4H+s138jHOl3pufcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHJZmM/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF40BC433C7;
	Wed,  6 Mar 2024 09:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709716446;
	bh=gYzMZ/+cPGxLTP+zBtocfjmFMnBIyF7p6unjEf2f0y8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FHJZmM/hFT9X8RegrSI675wAQbs7xeT42clmaFOuipTPm3V1AmBXcOMCixkUdLcNE
	 yCF4YPDIV6PVYIn3yTr5jS/n5TJ6mw5E04Rq9YkIaq1u6mfaI4k1ZnM/km7uu3Ml8T
	 J8qq3AqIIMsCAWtoIFcPrT84zRaWRGYn039/mIvN9/Ktm1VwngaIyCJJwFVtxktrIF
	 SP88lpHnkApEJGODAy2tFSzmZsEqGDPPL6TUXfuQsCGbGdTckZbcns1y1GPSARoBSq
	 7tD/5hklgUWtdKFFcLfER366i9SFJxLY/e/ucY7kRHo/iWT8/i3FyRtO2opmAwYbnT
	 cYaLoCVvsO0WA==
From: Kalle Valo <kvalo@kernel.org>
To: Kevin Lo <kevlo@kevlo.org>
Cc: ath11k@lists.infradead.org,  Jeff Johnson <quic_jjohnson@quicinc.com>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath11k: adjust a comment to reflect reality
References: <ZeWEqGVibkMg2APi@ns.kevlo.org>
Date: Wed, 06 Mar 2024 11:14:03 +0200
In-Reply-To: <ZeWEqGVibkMg2APi@ns.kevlo.org> (Kevin Lo's message of "Mon, 4
	Mar 2024 16:22:00 +0800")
Message-ID: <87le6vhgdg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Lo <kevlo@kevlo.org> writes:

> On QCA6390/QCN9074/WCN6855, MHISTATUS may still have SYSERR bit set
> after SOC_GLOBAL_RESET.
>
> changes for v2:
> - update comment about resetting MHICTRL to clear SYSERR
>
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>

This didn't apply and I manually edited the patch. I also removed the
changelog from the commit message, please check my changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=709cd1c88a11bc1969cf573575b0a2027e720146

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

