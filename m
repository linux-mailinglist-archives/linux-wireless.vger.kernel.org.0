Return-Path: <linux-wireless+bounces-4979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B91588116D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 13:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC1D1C2292A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5383D57E;
	Wed, 20 Mar 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkDj9gJ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CD3D393
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936125; cv=none; b=J5BxFx6ns8zAqrelh8o9SG+5tqbQmUKJoGEDY+1r8MyzjoKngFRsHpZxCgXqE59uPHtOZVk+KDx+rEKX2Mi+IfgY4CGneulCYCumBw4YKd1qYkUCK8AlMJoLaDXYDo1xnX78BNsndUha3x9Xnnnt/1Jl0U9XRe/S8tar64akCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936125; c=relaxed/simple;
	bh=sgGC0WQisFn/sGQ3msTWQSi18AFa/uPbtXXxTNrXZTU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ITIJoEL5MFTKXA+b9iaU36dSc1ftZpd/j12qgBUstf5sskmqH28uOPMLECKkTXWkpdWyqJxrpuLOcIm7cK9oIcx6dD3Ge2DoxPqNEwRHhlc516XKn1auoBCE3RxguqVn2u3rVFUBy0VOy/ry4OUDhi6mq4mMgZJyPwqwFfyr+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkDj9gJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77492C433C7;
	Wed, 20 Mar 2024 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710936125;
	bh=sgGC0WQisFn/sGQ3msTWQSi18AFa/uPbtXXxTNrXZTU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tkDj9gJ5s27iu7hUF6eGe0ZCrIP9Gh5YTu8j9iYTrxZgJLxC4bbGpVXowgiBZkLyn
	 lJqeaeCM6zukts+8KtKhgOSzG0KPEHbRtdJX6gt0Ybj+Ht5XE0W+0jgbomJMWPfu6B
	 7MkOAlauBeswKpVJkQicV4D/9A97w3K2tQ/ExfQqEhTs7E4pnNpSQoZN62E5E4CDoT
	 pb0MO8x/NO9bN6S1te340PWWR4MPZpvDxQAyG26xDx5xLZHmkWDcdzcKK7qrp1tDbN
	 cgY0Sj2xBtxqULaeQvmlwJvHI/Sf4kwfeKnpz1ixsHE2yIZJl17Ysce7SFLwFPxGCT
	 t0m4tLN0LmJCQ==
From: Kalle Valo <kvalo@kernel.org>
To: quic_tmariyap@quicinc.com
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath12k: fix desc address calculation in wbm tx
 completion
References: <20240311180708.9334-1-quic_tmariyap@quicinc.com>
Date: Wed, 20 Mar 2024 14:02:02 +0200
In-Reply-To: <20240311180708.9334-1-quic_tmariyap@quicinc.com> (quic
	tmariyap's message of "Mon, 11 Mar 2024 23:37:08 +0530")
Message-ID: <875xxhaz7p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

quic_tmariyap@quicinc.com writes:

> From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
>
> In tx completion, status desc is obtained from offsetting the address
> from wbm ring. Having HTT_TX_WBM_COMP_STATUS_OFFSET(8) and reserved 8
> bytes in status desc offsets the address twice and read the values
> from the incorrect address. Hence, remove the
> HTT_TX_WBM_COMP_STATUS_OFFSET from wbm completion address calculation.
>
> Also this patch is applicable for WCN7850.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>

BTW please fix your email setup. Your From header has now:

From: quic_tmariyap@quicinc.com

But it should contain your full name as well:

From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>

That way there's no need to have an extra From header in the email body.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

