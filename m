Return-Path: <linux-wireless+bounces-8213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A50E18D22B6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A596B231E6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAB438DFC;
	Tue, 28 May 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk6A3wre"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D1383B1;
	Tue, 28 May 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918185; cv=none; b=FC+az66KG7gjEwgVF4CudcXEZ2s+Ub9Cap/I/Uk6dv/g1/sa/VBPn2sEwESAN/LEW6RrVQHtLmR71+f7Mp3tiOnzB+U9jYUNbv2ctrXRxOnxM2zGs3hRX7uwmLX7hCfZdhjgPYYf7iEcxsKLpN0aIASsO6vprOetOoNfngDyNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918185; c=relaxed/simple;
	bh=1t/2nyJD90QWoKEkfj3SOxB3g/QFZrSpyN4KN1vGGnU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TSPJqKN/mWnESjL1ero7x5sXPjNeOF1FOn9GtQqLOjsDJpaaVi52uAuNlBkld7UbpP7gRTNVplSSzwhp6tnRN5+Qwpckfy9N/zxcHa20Dn0c8S3W2BVBgHUj+U0Nh1Q6fMOGsAfLLocBoswcPafwdnRzeWIFELDDbXZ7aMDwkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk6A3wre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4ABC3277B;
	Tue, 28 May 2024 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918185;
	bh=1t/2nyJD90QWoKEkfj3SOxB3g/QFZrSpyN4KN1vGGnU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mk6A3wreOpylOAIEsWPFXtLqkosBIeqOxTRhd4mq6Q7L6w2M2RcPgzjuvzo1utXtm
	 InUqj2KTBoCyeh/hZe7rAijOd1Wm3u1WEQ8cP3kxpa3Zk0bg2vPxNdrg8ZZy+X2dA5
	 s5YmLOxA530fO0r6FhKFwUbWUHimZrnr/w5XZECMC33JHLmThPk1OFa9gkWA0SVeFj
	 20J+oLFISxG0lVSdVFcwYiE4r7wQ+zeKdEkGiKOCHNedxGHdJt5Oo4TfY0+RE1O4iz
	 gC+kQam6pStHbYMDe1eRwq9/Eng8rvrMFQtDgNTf3EZ+UVWUBxu9tdkLNNHCG/xvlM
	 BHuoG4/rkLbQg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Fix devmem address prefix when logging
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240523-ox-v1-1-112ae7350059@quicinc.com>
References: <20240523-ox-v1-1-112ae7350059@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171691818162.1700985.17832746813476815446.kvalo@kernel.org>
Date: Tue, 28 May 2024 17:43:03 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently when ath12k QMI logging is enabled, messages such as the
> following can be logged:
> 
> ath12k_pci 0000:03:00.0: devmem [0] start ox113000 size 20480
> 
> Replace ox% with 0x% to get a proper hex address prefix:
> 
> ath12k_pci 0000:03:00.0: devmem [0] start 0x113000 size 20480
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

af69d862a8ba wifi: ath12k: Fix devmem address prefix when logging

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240523-ox-v1-1-112ae7350059@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


