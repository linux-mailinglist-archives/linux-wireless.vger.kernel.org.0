Return-Path: <linux-wireless+bounces-4401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0793872721
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 19:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E3CB28F7C
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC41BF3C;
	Tue,  5 Mar 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKU15OYn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A91BDC9
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665079; cv=none; b=JyN2UKw48hkrne8wouWdcE47yy5ag4UIfpZ6k6OgluvVgqzWUslTdw0EXweE4sUrK0/GHBHJ4CMWS8Q0LsEquAdFcA81CYOz2gibQ5KYXypmjYftNwpxSMoOTr0KJpLkItWjpIdUsWNOY6UrTtxP+ZKUSLhQeGQ0tOe/57D6sOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665079; c=relaxed/simple;
	bh=h+7wf7RO/SXTi2xMW6pf3osdjV68Mp9fLkZgtd5hih4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=qjTzB1Eb+JdhqGF/JUKbJU+h1iqpivs8X1f11dv5NH5U2oYUetMiXSKlrMoWJsPiev1KZ6tFXMSBk2rjjVHpretCp7iQLd975rgEFyZxZqhe45NjKcDis8fWFMFg5NsddOK1taBugJIhRMm48A3X7L4OjUVKOk9GePQ5enT4VIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKU15OYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C184AC433C7;
	Tue,  5 Mar 2024 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709665079;
	bh=h+7wf7RO/SXTi2xMW6pf3osdjV68Mp9fLkZgtd5hih4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LKU15OYndlqoUpe+hKbrfJ+mvdmFeEfKbMIH2ClOwkKJuKlBXYCS7evt4I4h4iluW
	 x9V8B2ML55oWp3wsx1J85622naSoN2ulNMWAuCZojtCtPOSXHed17mjJrqnsUcozuo
	 12u/OOjR+nVThUMzmVOaVpbHtZNwpUoNF8wzJbDsKmmN/ZQRoxaQ4VSFULd3SS/TtY
	 eVs8sVrGwQ/fkXTmUb2sVMAC8FYgPTskbQc4Dr8UEaCkoS1U7DYFx85oaOfFzkFElJ
	 uwQcsv3YwPWGDuPD9KGAAE++OIBikYYBWSwQjGrAqkN3oZ2bpbl0ak+clYN8rNFX9i
	 1J5HV0NAwB8tg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-next-20240305
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <87y1awh8kj.fsf@kernel.org>
References: <87y1awh8kj.fsf@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org,
 quic_jjohnson@quicinc.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170966507585.424347.4426290600622256900.kvalo@kernel.org>
Date: Tue,  5 Mar 2024 18:57:57 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Hi,
> 
> Please pull, more information in the tag below.
> 
> Kalle
> 
> 
> The following changes since commit a4634aa71fee11f5e3e13bf7d80ee1480a64ce70:
> 
>   bonding: rate-limit bonding driver inspect messages (2024-02-22 19:13:18 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next-20240305
> 
> for you to fetch changes up to 776c9c93bb0511d04e6222546499e5ea20ad51b0:
> 
>   wifi: ath12k: fix license in p2p.c and p2p.h (2024-02-28 16:09:29 +0200)
> 
> ----------------------------------------------------------------
> ath.git patches for v6.9
> 
> Only some minor cleanup in ath11k and ath12k. Adding Jeff as the
> maintainer for ath10k, ath11k and ath12k DT bindings.
> 
> ----------------------------------------------------------------
> Baochen Qiang (5):
>       wifi: ath11k: rearrange IRQ enable/disable in reset path
>       wifi: ath11k: remove MHI LOOPBACK channels
>       wifi: ath11k: do not dump SRNG statistics during resume
>       wifi: ath11k: fix warning on DMA ring capabilities event
>       wifi: ath11k: decrease MHI channel buffer length to 8KB
> 
> Jeff Johnson (2):
>       dt-bindings: net: wireless: qcom: Update maintainers
>       wifi: ath11k: constify MHI channel and controller configs
> 
> Kalle Valo (2):
>       wifi: ath11k: thermal: don't try to register multiple times
>       wifi: ath12k: fix license in p2p.c and p2p.h
> 
> Kang Yang (1):
>       wifi: ath12k: add rcu lock for ath12k_wmi_p2p_noa_event()
> 
>  .../bindings/net/wireless/qcom,ath10k.yaml         |  1 +
>  .../bindings/net/wireless/qcom,ath11k-pci.yaml     |  1 +
>  .../bindings/net/wireless/qcom,ath11k.yaml         |  1 +
>  drivers/net/wireless/ath/ath11k/core.c             |  8 ++-
>  drivers/net/wireless/ath/ath11k/mhi.c              | 68 ++--------------------
>  drivers/net/wireless/ath/ath11k/qmi.c              |  5 +-
>  drivers/net/wireless/ath/ath11k/thermal.c          |  5 +-
>  drivers/net/wireless/ath/ath11k/wmi.c              |  3 +-
>  drivers/net/wireless/ath/ath12k/p2p.c              |  2 +-
>  drivers/net/wireless/ath/ath12k/p2p.h              |  2 +-
>  drivers/net/wireless/ath/ath12k/wmi.c              |  5 +-
>  11 files changed, 29 insertions(+), 72 deletions(-)

Pulled, thanks.

f654e228ed6b Merge tag 'ath-next-20240305' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/87y1awh8kj.fsf@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


