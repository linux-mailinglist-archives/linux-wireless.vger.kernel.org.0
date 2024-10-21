Return-Path: <linux-wireless+bounces-14252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5939A5FB5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 11:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9761C21545
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D721E1C2A;
	Mon, 21 Oct 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewvHbr94"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45C195980;
	Mon, 21 Oct 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501675; cv=none; b=FQpl4MnyotX2D9EHjeabSafDq5VS35YU1LHfwtgSsm1MGMriTIra8edLiEZs8pnWOIxANY0mAnxQa+2KADASTPL2QoPsaQ7eLWyNX4FKl3fjUPyhiWYwRmltet0TeIs1smjjxOXyXFPz2v7shBm5sjvR8xQefr7rfA5iFHGsIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501675; c=relaxed/simple;
	bh=qJJnzJLApLm/pC+hOcBl9ymUBb/nq+DK3zkjkMbl4xg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=E9qbtaiaDQleqqbDOs6fIGghLK6fRcnt76gCs8WH+8ZEL+V1QoEvznAFrRrxAuSKpUm9lYbqx1gRjoB+b/eA6np3mwIHqLKOEioM36IJqkhyCrqYrGv3vmG3TlFaVZkDdd5iS5mjDtUtgu3ddHiqhx7sZ/fQCnJVd4xuSQ20Hgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewvHbr94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C14C4CEC7;
	Mon, 21 Oct 2024 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729501675;
	bh=qJJnzJLApLm/pC+hOcBl9ymUBb/nq+DK3zkjkMbl4xg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ewvHbr943bKfo7CFKbWFsUXxk+/pOh9bc2GAX26iN+K1Sw1FgA/ahvkd4SRJSODdz
	 vN+n9NomPM/V5UvDa44rhYDiJOzDtZLfhrEw0hB5ebC/y887eVAjR99dlY9WPeYVLh
	 BNLpb5XRNZx81op/PJ+kE73I2sng0EXEtxGUisQy5KTGJxzL7zK7t73g0+Vnv7TJ6v
	 JqtvNNZ78U7wYZrqB4uxQXXxXpRbvDqUn8eBJADEK1Rzq0F8UfYluRovc/zNVzUR+5
	 yoK7fazYvBO6QTS7puSua1KQLuMSX/xWe5FY2yfdVBp7vATiBF2cZ9sMl17o668xmq
	 Sr9YKVBc1QlNg==
From: Kalle Valo <kvalo@kernel.org>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: jjohnson@kernel.org,  linux-wireless@vger.kernel.org,
  ath12k@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: Fix for out-of bound access error
References: <20241015192155.3643363-1-karprzy7@gmail.com>
Date: Mon, 21 Oct 2024 12:07:51 +0300
In-Reply-To: <20241015192155.3643363-1-karprzy7@gmail.com> (Karol Przybylski's
	message of "Tue, 15 Oct 2024 21:21:55 +0200")
Message-ID: <8734kpq0wo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karol Przybylski <karprzy7@gmail.com> writes:

> Size of array passed to print_array_to_buf_index is decremented by 1
>
> Discovered in coverity scan, CID 1600742
>
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index b2be7dade79f..74767ba9ec2b 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -1550,7 +1550,7 @@ ath12k_htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf, u16 tag_len,
>  			 le32_to_cpu(htt_stats_buf->ax_mu_mimo_ndp));
>  	len += print_array_to_buf_index(buf, len, "ax_mu_mimo_brpollX_tried = ", 1,
>  					htt_stats_buf->ax_mu_mimo_brpoll,
> -					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS, "\n");
> +					ATH12K_HTT_TX_NUM_AX_MUMIMO_USER_STATS-1, "\n");

A space before and after '-', please.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

