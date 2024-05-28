Return-Path: <linux-wireless+bounces-8216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCC8D22C1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA072818E7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 17:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214ED24B2F;
	Tue, 28 May 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB6n8E0D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD71B806
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918346; cv=none; b=CfDzvWy47OnXzPOehaGbTVIi2CoK8dyagQ5TBOWFcWiMMAxYu6YvsKGWsAbYLg9r5iOn13vZ9gNDGXTayz4oB00IN01q77na1NJtiAstx10lDZIkRpICR4CKvtEPjFZnQMG9M+mlxTOJ3YK8U9osnWAsw5/Cw/jZLa5cP12IePA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918346; c=relaxed/simple;
	bh=sKLWwnpnlmhE+bUX9QrAVOLuHKIQAriHb2GHbk54UC0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RmDetnEzjW7LBULkVEpqoBlBpJC+SAk5q1EWckHDOBPaqhCxuEexn0fhSSEzeNqn+K7P7dEbsdMl9t1qBd+Gn5VYHO7xZTjIol61MOkVsgWSQOgSahlnoEmloLMmOMGqCSVxHU++uNnAg/LE4fo4n+F2xJMCBvgGgDv0wtyBRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB6n8E0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADD4C3277B;
	Tue, 28 May 2024 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716918345;
	bh=sKLWwnpnlmhE+bUX9QrAVOLuHKIQAriHb2GHbk54UC0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=SB6n8E0DKc2y1A29J2akEghPSSOAngxwmBGoXhGOx//9nROxUl+sCay3NiBchHkwz
	 YqHx/qi7pByY+rsVhd+EdikmbSGv6WC6xLqGpZgRGFt7X/G6p4kCMQ6pBO+V803UFx
	 tLd45rGxgrwt7NkmuvqX9CF3lBBUphGfLCdpUY9+NW+hpPxTxU1nANhzOaBlao2LYg
	 j3v3fPn14KUZRoAF1RMctGf/H46VZJzncOmsMZ59Mz5aP2BWim4gL1v4XDx/8xkhrB
	 iiW3NxxPt1jRYkzo2DXdpxpouP5+3v7jTuCu7C30fu72i/p87tsI0kypNvSAirpJrB
	 8VDZZ+18bu2ow==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix wrong definition of CE ring's base
 address
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240524024021.37711-1-quic_bqiang@quicinc.com>
References: <20240524024021.37711-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171691834316.1700985.14768410364524258045.kvalo@kernel.org>
Date: Tue, 28 May 2024 17:45:44 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Base address of CE ring is defined as u32, currently this works
> because DMA mask configured as 32 bit:
> 
>         #define ATH12K_PCI_DMA_MASK     32
> 
> However this mask could be changed once firmware bugs are fixed
> to fully support 36 bit DMA addressing. So to protect against any
> future changes to the DMA mask, change the type of the fields that
> are dependent upon it.
> 
> This is found during code review. Compile tested only.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

0ae570703754 wifi: ath12k: fix wrong definition of CE ring's base address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240524024021.37711-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


