Return-Path: <linux-wireless+bounces-7832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A48C98AB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 06:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B460B219B6
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 04:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D46D52F;
	Mon, 20 May 2024 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqgx06eg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174372F56
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716181029; cv=none; b=d+urkVbrU2rDGsoGePPcs1y8AWrlWkktPEbWcDzyjgXLC5/8A9jMAdB+KqjVOjH9rJVHN2zi80tbxopBampYKx/IA9guXu4cUqaKUQeulhvF8b6X9Z9uv0l3AkNJYoU5HPXsYRQewL3MKKV5aSmopzgYYWcxMNtcTktGVXDB6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716181029; c=relaxed/simple;
	bh=QMkoV1HCgGjWuiwba/dY7eyC1+I7pq8rO6I224Vc+2Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=a0U9/xz9NDkF8z1oq+wX+IvqSqahjSsi/yyEgBsQaIUoWTOVv4C0b+8VugU3h7vVTkRrWebrXW0wzSFiQ+ukBStzkr0aL4AcPMR2I6UrfJCyAaBTEd5SnYgq34w2/4PM9kJt1g2VSpOTZ7/zre035xp/vxeDEF47dN0mA3bV8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqgx06eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE470C2BD10;
	Mon, 20 May 2024 04:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716181028;
	bh=QMkoV1HCgGjWuiwba/dY7eyC1+I7pq8rO6I224Vc+2Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kqgx06eg8ovepo5EOJmZNq13iLlGxTNawK1yCgXOJUPXOY6xfZoZ8OPawlMB/xV3Q
	 p0pLIzi0qwB5HGUAjaDusfCdQo1OA2aIkR0P5Hcf4LJwHBphBdMmfq1C+cA6FDQbD8
	 WD1QT5ujPLIlk8QgZ0AFr71dQiB4PjJes4Mn8znsSUan6Vqrjc2t0VT2kHSLoBhpTq
	 nDyLsbUAXYK+3UUX1Al7iPBeEJ1UOlpQD+ArX5zH/fXvRi5lOHYyeWPAckunQhANyc
	 a8IeWwKmPeiEAYREQnkSb2wTzUqt1SvHMvA2YuxvlP4/qSNqfPUG8wlD3b2KGtWJ2+
	 C0pBxRB/VrUaw==
From: Kalle Valo <kvalo@kernel.org>
To: Carl Huang <quic_cjhuang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix WCN6750 firmware crash caused by 17
 num_vdevs
References: <20240520030757.2209395-1-quic_cjhuang@quicinc.com>
Date: Mon, 20 May 2024 07:57:05 +0300
In-Reply-To: <20240520030757.2209395-1-quic_cjhuang@quicinc.com> (Carl Huang's
	message of "Mon, 20 May 2024 11:07:57 +0800")
Message-ID: <87wmnpdqse.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carl Huang <quic_cjhuang@quicinc.com> writes:

> WCN6750 firmware crashes because of num_vdevs changed from 4 to 17
> in ath11k_init_wmi_config_qca6390() as the ab->hw_params.num_vdevs
> is 17. This is caused by commit f019f4dff2e4("wifi: ath11k: support
> 2 station interfaces") which assigns ab->hw_params.num_vdevs directly
> to config->num_vdevs in ath11k_init_wmi_config_qca6390(), therefore
> WCN6750 firmware crashes as it can't support such a big num_vdevs.
>
> Fix it by assign 3 to num_vdevs in hw_params for WCN6750 as 3 is
> sufficient too.
>
> Fixes: f019f4dff2e4 ("wifi: ath11k: support 2 station interfaces")
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Closes: https://lore.kernel.org/r/D15TIIDIIESY.D1EKKJLZINMA@fairphone.com/
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
>
> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>

Luca, can you test this as well just to be sure? The patch is here:

https://patchwork.kernel.org/project/linux-wireless/patch/20240520030757.2209395-1-quic_cjhuang@quicinc.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

