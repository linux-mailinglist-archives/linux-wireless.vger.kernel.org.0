Return-Path: <linux-wireless+bounces-941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07418179E6
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 19:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D516B1C22BD7
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 18:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FF11EB48;
	Mon, 18 Dec 2023 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POYUIj/v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE272904
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 18:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B93C433C7;
	Mon, 18 Dec 2023 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702925083;
	bh=NGuNSjG3GpRDsmzB697NZvdaUjGYKur8lWQ0lXASCKk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=POYUIj/vVR+NUvHxWncubKcu3u8Z4ph5xqp2ZieOkiLxVqwXWkCGF+SrjBXO6GBuA
	 iZWU5uVrTbFuP8jwC6FpX6hNOeaPMdZqaOnPZqtY2FD6RLrJwh35mkW81RckPk/eDF
	 K0+dEM4LOa/XK9VilX+kzOJWhOxlW5MIjvKCCgAKIa64WRk5022uZ3c5MSXNxSaoHQ
	 /neB3cXEifgYGNcz9CZcj545k0ub5kTdpFdgaNncT3nGwBZp0f0FphwX5/CYTTa1en
	 P32/ZYFGZp6upBg1lgFIwvgOeuxD2jmkYSNXLkGxoxfSQ1tkabRVwGqXejRhaGojgx
	 hN5hHfto7rIJQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231214161117.75145-1-dmantipov@yandex.ru>
References: <20231214161117.75145-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170292508051.424292.9967717301643668633.kvalo@kernel.org>
Date: Mon, 18 Dec 2023 18:44:42 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'ath11k_wmi_tlv_parse_alloc()' always operates on
> 'skb->data, skb->len' tuple, it may be simplified to pass
> the only 'skb' argument instead (which also implies
> refactoring of 'ath11k_pull_bcn_tx_status_ev()' and
> 'ath11k_pull_chan_info_ev()' in the same way). Compile
> tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f5e6c0c4b087 wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231214161117.75145-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


