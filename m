Return-Path: <linux-wireless+bounces-1711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A7982AD38
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 12:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F2E2843EE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6573156C3;
	Thu, 11 Jan 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZr061gA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE0156C1
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 11:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69410C433C7;
	Thu, 11 Jan 2024 11:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704971979;
	bh=Q9/z0JTCs5oAXPg2oz0DSid0D9U8xfCZj5Fj8lNgZhw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=oZr061gAEfGm9VIgIl6pViy+elfHvPvzJVMWcEkkC8QahThUmWL2xUaXBMEV0tR55
	 o9CfW4SyAgZSjHD/kAHgZQb+VcuBXlx5PT/sfenWfxngYu8BEvtyK8CtItVjFKRuGA
	 3XEOwg9O6gHTBEoHysXhd9m4rkvCpH21dIhwpxLQFC6da0bJwRdvfEtE8KcrdZqYTL
	 yO2f4on0yzwymFtCGtXUWJ3rfp22X7fWPOb7D95KW4PU6gHKImQQG/H+TS6Cp/Lzn5
	 nEp3/fRidpDTLh3eSgQO6B/KiHgapSL7dwcov7X/pD3Uxt913eEMZE3+fh3Tkj2sqH
	 /M5lInkddlRSg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231219091022.70861-1-dmantipov@yandex.ru>
References: <20231219091022.70861-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170497197672.659902.926273640514593696.kvalo@kernel.org>
Date: Thu, 11 Jan 2024 11:19:38 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'ath12k_wmi_tlv_parse_alloc()' always operates on 'skb->data,
> skb->len' tuple, it may be simplified to pass the only 'skb' argument
> instead (which implies refactoring of 'ath12k_pull_bcn_tx_status_ev()',
> 'ath12k_pull_chan_info_ev()' and 'ath12k_pull_pdev_temp_ev()' in the
> same way). This is an ath12k counterpart of the recently submitted
> ath11k patch and compile tested only as well.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

fba97a777dcb wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231219091022.70861-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


