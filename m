Return-Path: <linux-wireless+bounces-9533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214FB916D8B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72204B2631F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34B16FF59;
	Tue, 25 Jun 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxptkDUG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63DD45978
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330841; cv=none; b=JqJg4pjA5DWhPubNkm8z980KrwcCjh6Q6fem9EN5fmWDHdTBMn3+u4wsGPOrmVaoq2P/heWf4cwodpUcvGlf+qKmhHJnxXe0+Bhqj8GOcj7CAnSwTF4tuJc4KBCJg/9391yvh7f+lktEdkEdny/DtJUUr/wModQCTa73xDPsTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330841; c=relaxed/simple;
	bh=MM9rEZjt1n3fUQ17F0SoJjGbm5zXc4odPQRTmAJEi/8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=I07rcgcn8XyJh7GHzGfmWR9EPsB0Q8b+Y8Qdkd0CvcjEc5MiCWNdZM74beMLrM2a1OSsSYSSjbmsRaCDtj+tszRK+jFTog/RUOxE03xMha+20HKCMv6QxXYmgQUxJvQj1BDGr6GgE113YjCdmrOGcS1V3IVfhm+YiGtxBEZbakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxptkDUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EDCC32786;
	Tue, 25 Jun 2024 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330841;
	bh=MM9rEZjt1n3fUQ17F0SoJjGbm5zXc4odPQRTmAJEi/8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mxptkDUGmtZ18r2xS28etP7Nl/GfLhsLMaHpdqE3gLZra3+NFPRvo1xcI4SphOj6o
	 rXE8fBpNY65G2DMwJKDwWQDQiY1EZbxHM8BjX0pCeyjlEUwrswy2reS19ltYbGxHdW
	 zVUCzdxJXoje5WdDCtWT5Es359sjO64jT5uj63C/KwVRY0kcU7TNNY55oCoFGnPDgk
	 uZ1xtvKqG0biKUCpGfHNW6iL/zJT1dKUoNWu5yUF8MDZR6aBg4RIgGjEGLe7puXvAW
	 hg1qPMG8qdEd5L1IeNYC5c2fPryeaHVL6wp8IysTieGtVUnuz2k9JcsanrHSKmCp96
	 vHO/eOc/3ja8g==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fix peer metadata parsing
References: <20240624145418.2043461-1-quic_periyasa@quicinc.com>
Date: Tue, 25 Jun 2024 18:53:58 +0300
In-Reply-To: <20240624145418.2043461-1-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Mon, 24 Jun 2024 20:24:18 +0530")
Message-ID: <87frt1hvc9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the Rx data path only supports parsing peer metadata of version
> zero. However, the QCN9274 platform configures the peer metadata version
> as V1B. When V1B peer metadata is parsed using the version zero logic,
> invalid data is populated, causing valid packets to be dropped. To address
> this issue, refactor the peer metadata version and add the version based
> parsing to populate the data from peer metadata correctly.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Fixes: 287033810990 ("wifi: ath12k: add support for peer meta data version")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

[...]

> +static u16 ath12k_dp_rx_get_peer_id(enum ath12k_peer_metadata_version ver,
> +				    __le32 peer_metadata)
> +{
> +	switch (ver) {
> +	default:
> +		WARN_ON(1);
> +		fallthrough;

I'm a bit wary of using WARN_ON() in data path, so in the pending branch
I changed this to ath12k_warn():

	default:
		ath12k_warn(ab, "Unknown peer metadata version: %d", ver);
		fallthrough;

The benefit is also that now we print the unknown value. Would this
work?

Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=0228ca402186a123e5c90187f952121de50bf64f

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

