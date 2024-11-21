Return-Path: <linux-wireless+bounces-15543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6F49D4B17
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 11:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B99281755
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487FE1C2DCF;
	Thu, 21 Nov 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O95CaL+c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F51BBBDC
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186440; cv=none; b=WsVNY/PvG3mHgMsBDb7olcvlwDrabKYGxKp+dVNxXpuhVObaR97Locr4GV+lbpIm91uRHAIyILHzpXyNiLT/2EByACzip+PcpuV8y1W3PwyuCRc6u9ettgcMbeDJjooMp7/20fpChQwwfKzgC/Knfqd2w8mfFD5Dp7RTE3gDlTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186440; c=relaxed/simple;
	bh=qnEmZ1q4aRHhC+DGzQ0EUXHnh+YiuLzBeV4gA2ljTxE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HdTfNARVXTDdL+ua21xjN61Awfxiqq3qUNKKgKMJssjydXOnnhLbIJyQIoaW6iQ1Odo9aI2vIjS3ivAbpsgJCNtiBF7UgJfOUgn2vwbpPxGkAyXmxqcD8rf1X+eerctRwIYYjHZHmWi1Fae/bDI1jnzuNDMKthe+eJYcsHCWgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O95CaL+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF189C4CECC;
	Thu, 21 Nov 2024 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732186439;
	bh=qnEmZ1q4aRHhC+DGzQ0EUXHnh+YiuLzBeV4gA2ljTxE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=O95CaL+cxyAAtsbKvuiMvRAmrGJf3dQrQ3hN1YBYrhoqmbNpi2b40mVRcvb1R/ihv
	 aqXWy7HevZUafV8FpiGWCdgK20gmRHtlhMxsF5u1uhoT0FVMnLyhRPxf0PWzIp7Bgb
	 xag3welmWiAjz5S3kFZYUVC8M0XUPIuldC0PqN+GZWIYLsQ5xWGmb3ev7i0ywEVrB/
	 ZeImhmlNEAas4O3B3AIDyRHWFs+ckdyKyfmFgrzx0RvdDzVCcikJfiw91onvHtfg6s
	 xsXqPKCn3SEzvHsCZwsxIcF4+SVvR13C2Inv1siC3BQ+GLQF5q0+BcNx0mNYb09GHI
	 hVhz6bOWfmsfQ==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Fix inappropriate use of
 print_array_to_buf_index()
References: <20241118035722.1755373-1-quic_rdevanat@quicinc.com>
Date: Thu, 21 Nov 2024 12:53:56 +0200
In-Reply-To: <20241118035722.1755373-1-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Mon, 18 Nov 2024 09:27:22 +0530")
Message-ID: <87serkyi0r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> Currently in ath12k_htt_print_tx_pdev_mumimo_grp_stats_tlv() the
> htt_stats_buf->ul_mumimo_grp_best_usrs array is printed using
> print_array_to_buf_index() with a stats_index of 1. This is meant
> to convey the semantic that first entry in ul_mumimo_grp_best_usrs
> is associated with user 1. However, unlike some of the other "usr"
> arrays which have that semantic, ul_mumimo_grp_best_usrs does not
> have that semantic. Instead the first entry corresponds to user 0.
>
> Fix the issue by calling the API - print_array_to_buf(), instead of
> print_array_to_buf_index().
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

