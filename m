Return-Path: <linux-wireless+bounces-5906-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC589899DC0
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 14:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89D4284BD1
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CDB16D9BE;
	Fri,  5 Apr 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/tkFW6/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541016D322
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321839; cv=none; b=TnGc5NwyFqw4aLhKtLl/atmoWypLI+aLPp76qw0kKwErq2CcsitSWgOTSvEcRWc604D6u1Nvg1XZu4VsH5czOLec716dcr3UmtADCX6NcJL/hIbeR5d3pMIZZyvJEEIpUBmv04+GKJ9QEk2zzE0wVb0hOs5tOpltJO1JkBBYheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321839; c=relaxed/simple;
	bh=wUCIFs3hVW+MtJ+Dbhk7eN7aU5AeyqZdLHy+SF21Bdc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HQzv32lW32X9ruAehyJ1tLXuVz236WDLk/PYKtZShcXcxW81M8Vv4Tex5G7EyZnbcJt24iCplt5zHQwE0DmwMcPSD4v/G+q1K65HNYY44mZkNeWbCKup+NmhyMqOep10p6CWSlLSW2iWz83AH7wGX0xZbExu1PBNs1wcRUGav3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/tkFW6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F109C433C7;
	Fri,  5 Apr 2024 12:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712321839;
	bh=wUCIFs3hVW+MtJ+Dbhk7eN7aU5AeyqZdLHy+SF21Bdc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=P/tkFW6/72WuwK6CgXslwnlAUnyxvreLi6L+XASUS8BBYDyYio2TDc2CQ/rSAJnX3
	 AjXbx4pqKXL7+781n8uwHyxlrn5w+rwSu3HiZqCdCtXgJuxzh3/qv2IUOOsTFbslOZ
	 3wvJBgXKZZO02Q91qm76NHWIqNgzse0CxE5yVqRRluyH2UNl6pAsxabMQArMF8W7p0
	 Xn0PmabNQP9yuatEtXYxsRGUwlOuD/dSD/0AAHnTjkZG3vbyBoV3MT2SSAutZ57VD2
	 5v0Cmu1/94LXD6UQjnTV4KJh+SbiAyOLKTGIga6ea6P23gE7xK1fZVRsmRvW+sZKaO
	 e3lDXaZXC7tBg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] [RESEND] wifi: ath12k: extend the link capable flag
References: <20240403042056.1504209-1-quic_periyasa@quicinc.com>
	<20240403042056.1504209-2-quic_periyasa@quicinc.com>
Date: Fri, 05 Apr 2024 15:57:16 +0300
In-Reply-To: <20240403042056.1504209-2-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Wed, 3 Apr 2024 09:50:55 +0530")
Message-ID: <87il0w2cib.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Link capability categorized as Single Link Operation (SLO) and Multi Link
> Operation (MLO).
>
>  - Intra-device SLO/MLO refers to links present within a device
>  - Inter-device SLO/MLO refers to links present across multiple devices
>
> Currently, driver uses a boolean variable to represent intra-device SLO/MLO
> capability. To accommodate inter-device SLO/MLO capabilities within the
> same variable, modify the existing variable name and type. Define a new
> enumeration for the link capabilities to accommodate both intra-device
> and inter-device scenarios. Populate the enum based on the supported
> capabilities.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

[...]

> +enum ath12k_link_capable_flags {
> +	ATH12k_INTRA_DEVICE_MLO_SUPPORT	= BIT(0),
> +	ATH12k_INTER_DEVICE_MLO_SUPPORT	= BIT(1),
> +};

I did s/ATH12k/ATH12K/ on this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=c15ec7e3397e7a400b2a6a3cb232f95a94c95989

We have also another similar typo in ath12k:

dp.c:1350:	spt_idx = u32_get_bits(cookie, ATH12k_DP_CC_COOKIE_SPT);
dp.c:1368:	spt_idx = u32_get_bits(cookie, ATH12k_DP_CC_COOKIE_SPT);
dp.h:248:#define ATH12k_DP_CC_COOKIE_SPT	GENMASK(8, 0)

Patches welcome.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

