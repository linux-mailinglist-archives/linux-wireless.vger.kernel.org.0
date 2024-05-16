Return-Path: <linux-wireless+bounces-7737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7118C72D9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 10:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7026284BB7
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE85F134738;
	Thu, 16 May 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPbah6xf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1180C03
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848155; cv=none; b=I2JIibbcfvAuwlGR0dU2EY94Y1YH4X9qTjw9OlAsvFPcnp5RFO3OIE9Ufdwr3tXz58eJaFXRC+pS3mAiOONBYP0r209xARNi6UFZFQIx+cu2xh3m7UEFrQuIxGZtcB8dAUrkUFhGoL7qn8v43Bt4xh/F0Km6YAkzvfbmKW9rqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848155; c=relaxed/simple;
	bh=og+BKY1v/57bu87sOKGVbi0FZ9OZo43TWjKpRV2xXHM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=U2PeABnhozRG7P1n37JCbEg7d7J1btFRzgx2vDsLuFb1cs3oSwD7bv6LJ4tGJpHUoQRx6UV18U3qPVPT04QMn1xpmtmQ9ONPqkqEvyonyxcMImUBPFwzNWzXOfUE9/HeMim+1Os8+jUf74+AtLUUHWeOGpFJeKOAlZNAWzHnfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPbah6xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A9AC113CC;
	Thu, 16 May 2024 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848155;
	bh=og+BKY1v/57bu87sOKGVbi0FZ9OZo43TWjKpRV2xXHM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LPbah6xfCDj1SyA+ArVIs7nQX8XpGXDQQB3MAYDNPtl9/Cg8DTi4CjDb5rn88D4Mf
	 K4tTvx0tNVDIGsE9iSkYsgaOGoKXnvaQKM2i5WQGaQ6B8WFkZ1E842Fkj7uKTaO2Pv
	 xjXXFnhu36VtVXsXGP2gJpg+2X2xsXBfbOfxZjiAC44y0xQuO9YAQEudvpkjSTsueg
	 +qacEZXBGYgHc2scGP6QIjGkHt34uS6Repw1O6S+041XmKBgGnHbO4zoZWI56Nv9x8
	 aQnA3tAr1G+wFSJs4ZdIwBPAmjW2aGwnXqzNCpJ9epMvSzJAhspCLp4AY86AfQmhlN
	 avyQqdgj8LXoQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ath12k: remove duplicate definition of
 MAX_RADIOS
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240514063412.3483723-2-quic_periyasa@quicinc.com>
References: <20240514063412.3483723-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171584815207.2786544.13771582254842962889.kvalo@kernel.org>
Date: Thu, 16 May 2024 08:29:13 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Remove the duplicate definition of MAX_RADIOS from the core header file.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

28bfc1c9c9d0 wifi: ath12k: remove duplicate definition of MAX_RADIOS
7678f8bfd74c wifi: ath12k: use correct MAX_RADIOS

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240514063412.3483723-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


