Return-Path: <linux-wireless+bounces-11346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430F9501CD
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 11:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC501F2244A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D822187327;
	Tue, 13 Aug 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol6gISiO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21799433C0;
	Tue, 13 Aug 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543090; cv=none; b=l0+lSNVNt1PmrKmjUSoVUsGYRSK550Z5SOrc/i33HLoWD9RICxHHXzatgY+kZ+aLorJbt2dcgEjAhL9YaTCyHj41/dWx0LMWRBNZGFSWDdou5GVEcA9M0MHfmOXH2+RgW1LlLe4XNxJrJAVqXq/sVjNuiorwqjs1ba7tbTYEug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543090; c=relaxed/simple;
	bh=oCWdJoqR68mNq02OIr39vLyhkB1ZwkCRALBQGE6D6ls=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=J1YqPIazD0agMX0Kq3L37Nn3WqCbwV8gc2IVgr9KNiExyq2u0JrPLPGGdw4w/VIOxDVbUqVF9Rgi8T9AYPxJeJ9/3KkuHIIdwp+tUxDxSUab9OQkpwj6h3V6FmtrZKf3xJgbCozjjBt0YALRHDQduX2udFiJ71SmaDUmyQefhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol6gISiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A182BC4AF10;
	Tue, 13 Aug 2024 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723543089;
	bh=oCWdJoqR68mNq02OIr39vLyhkB1ZwkCRALBQGE6D6ls=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ol6gISiOQMyXu18cHDM3cbxgLftP26dlyx060LgZ1BrEdSCgY4eiaFI/WREAT7uPY
	 2uGsjtvThB8rYg63LNcdXdpWi0YcDSFRq8VlROdri/JEt65DmoCshx7HX/NpMWCtVe
	 V38j36Zdddy3O7VwTBVJTzxADQD+Fw4pQB4Uai8nTpkx6ihbiM5bFTtoGcdN0y+O0m
	 jCGwb+SUmT+W+MgzKTrBDpYuZzfBMKGTgv/NdHHVBStzp0WYRLdVMuxjWZI4WwO7F6
	 CgiBE5coOIabDZsHObQWJK9gRZ8Ue+DrZ9+LL36o9/hWQBC7mc4vg9BFj3gRF1lC7G
	 3eCi7dUlRZUtw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: mwl8k: Use static_assert() to check struct
 sizes
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZrVCg51Q9M2fTPaF@cute>
References: <ZrVCg51Q9M2fTPaF@cute>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172354308655.731215.15975309925744151452.kvalo@kernel.org>
Date: Tue, 13 Aug 2024 09:58:08 +0000 (UTC)

"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Commit 5c4250092fad ("wifi: mwl8k: Avoid -Wflex-array-member-not-at-end
> warnings") introduced tagged `struct mwl8k_cmd_pkt_hdr`. We want to
> ensure that when new members need to be added to the flexible structure,
> they are always included within this tagged struct.
> 
> We use `static_assert()` to ensure that the memory layout for both
> the flexible structure and the tagged struct is the same after any
> changes.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

748e21d94a34 wifi: mwl8k: Use static_assert() to check struct sizes

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZrVCg51Q9M2fTPaF@cute/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


