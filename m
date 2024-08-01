Return-Path: <linux-wireless+bounces-10818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C047944EA2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 16:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D191D1F22873
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D601A7F79;
	Thu,  1 Aug 2024 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZwVXPrV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242F1A721D;
	Thu,  1 Aug 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524370; cv=none; b=H5LcKriMF4RoJ/cLekr14oOtbr1pdOfSuzHQpmjQwI0jKPOwTjbVGoAyPJ18unwvuR2whua4VhgEKXgkoZ2bb3S2btHp9HQYHULBZU1KFKsi8ajpNq3QN2C/gkxERNf9qGtlTmNrMf+UX18LyAbKc65RDyNpz0rBfyNyjbHr9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524370; c=relaxed/simple;
	bh=EbE3n0o+B68BvsxQThEMUzM6psOXOv3iNd5lpzYHxFw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=EmJ93Mc2/2iG2aw2h7/T/bpY/7UrEQKAdUjPRpMBpKQmeVKzO5vtQKhRSr+orbUTBs93xn/IriUXkq9ithK5WvYyhqPaVuzbVsBIWHD+1U2+uRFa/lzsY+Eio77mwqQINVY665w8QGs9pqyHi2wdDt53gBADxJkC4ReqW+9MINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZwVXPrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D48C32786;
	Thu,  1 Aug 2024 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524369;
	bh=EbE3n0o+B68BvsxQThEMUzM6psOXOv3iNd5lpzYHxFw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rZwVXPrVbctH9qAboI2x3Xo4Fdhbyv3B0ue+UVHofD0SAkVBz93/Idab80xL0B7vr
	 Jszgq28EvHyM9ipHMA4Ve3zLRY+paeyjO8ry+Ob5vCZBQNQS4ZcBFUiTn38hHBDJsF
	 gFEKi64EVUtH3+sXfQfIsR2qReiFNcammDB3l7SHkX1SPT8YlT+KiXsgeV2PSvu1As
	 MFnSMDxShBgFfwru3KImaVoTX4vecz64Xk0LPfBwLMIzdbUOChzRn4hZFIEToySHeC
	 UxTnZkSSIlbxzOOJJnoWF+8gkdOyu1r7pxqbeTyYqm/1HbU+E/NmsCP7qCHGFEoW5Q
	 xiX4YNFbUfRBA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: Use swap() to improve
 ath9k_hw_get_nf_hist_mid()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240710185743.709742-2-thorsten.blum@toblux.com>
References: <20240710185743.709742-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: toke@toke.dk, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172252436655.2450489.13205282881651123345.kvalo@kernel.org>
Date: Thu,  1 Aug 2024 14:59:28 +0000 (UTC)

Thorsten Blum <thorsten.blum@toblux.com> wrote:

> Use the swap() macro to simplify the ath9k_hw_get_nf_hist_mid() function
> and improve its readability.
> 
> Fixes the following Coccinelle/coccicheck warning reported by
> swap.cocci:
> 
>   WARNING opportunity for swap()
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

215a19631d11 wifi: ath9k: Use swap() to improve ath9k_hw_get_nf_hist_mid()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240710185743.709742-2-thorsten.blum@toblux.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


