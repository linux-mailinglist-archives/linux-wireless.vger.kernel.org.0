Return-Path: <linux-wireless+bounces-4632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC987985C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E17D1F227EE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF787CF29;
	Tue, 12 Mar 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8MniqIG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D67CF01
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258743; cv=none; b=tDbs/15FdJ4d2m/4WrkfWTOpPdmWeNVCVslrHipDZJ4eBzDA46AaUPLf8rk3bPogMMCZLwcZBRx2f/Kz/10OOnfyQQr6x7WwQzMoS9mOQh6MEmPiWskZtuKXQ05KBp88GLU67QoxulXgqpPJFDtzjsG4WDiFfJ5fw2IKyfJCyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258743; c=relaxed/simple;
	bh=mtbSRIPvbViwXMrn8ElRlBH+5PRYe0IF62ONmRRLyqI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RcJWXSbidyRvmG0aroVXhygUBVgNfKm7Ql7DJZJqL6/T1YT2BRL3qKSBMeeTrKOydkX7WL1YqO39f4K5HL+H6E415OKgkeubqyx7gpd4enc1TOHP/Ih9PlkEMtB2W56sVnug2JLiZnp1rqUieGUsI9w4bHwpkom+epF8wuwU/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8MniqIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4B4C433C7;
	Tue, 12 Mar 2024 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710258743;
	bh=mtbSRIPvbViwXMrn8ElRlBH+5PRYe0IF62ONmRRLyqI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=F8MniqIGPZjaPyQRBJFTeOR0DTrgFb6IA79l9RaRRs3NwZl+I3pK2cBe0mbobJ3WT
	 A09CCDfjcCp/0GjhsFUD6jwz1e1yHIt7akMkSPVnbEZPn4sZ6l4zASL0qAK9n4XwX5
	 VxLShNkPCrsQKISmzT+NUAirt0JlRKMkRMJs9v0ohg6cwrl4nqNwBOUAO3wPEH001r
	 kkP/0OXjiQ6EB5h8NgTwaAF5bnpKUY0mMyiHW1slsOM0JeQMIFB1iSkac2aB2iHI7d
	 kstSK2DLY3VZa1ieyTcIKSFhw7wLzB8015vc/q5V2Iu/02PZKDsWe9N7bEWUehnFv2
	 voDt0+tlgto5g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix wrong definition of
 ath12k_hw_ring_mask_qcn9274
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <CAD73Kh8_Ks0Fb6EsG6ks0oKKONfwr98uRccV5bbmEb15PLPvow@mail.gmail.com>
References: 
 <CAD73Kh8_Ks0Fb6EsG6ks0oKKONfwr98uRccV5bbmEb15PLPvow@mail.gmail.com>
To: Weng Lin Puah <wlpuah@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171025874055.2085908.13856941842998116352.kvalo@kernel.org>
Date: Tue, 12 Mar 2024 15:52:22 +0000 (UTC)

Weng Lin Puah <wlpuah@gmail.com> wrote:

> ath12k_hw_ring_mask_qcn9274.tx[3] does not match with its counterpart
> wbm_ring_num. This will cause the corresponding
> ath12k_dp_tx_completion_handler is not entered. Thus, some of the dma
> memory is not free and eventually runs out of the dma memory.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00148-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: WL Puah <wl_puah@compex.com.sg>

>From and s-o-b don't match (gmail.com vs compex.com.sg)

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/CAD73Kh8_Ks0Fb6EsG6ks0oKKONfwr98uRccV5bbmEb15PLPvow@mail.gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


