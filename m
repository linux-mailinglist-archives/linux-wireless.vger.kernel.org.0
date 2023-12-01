Return-Path: <linux-wireless+bounces-301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E384800EF0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C76281A8C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05A94BA84;
	Fri,  1 Dec 2023 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFkgkuUh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A04AF81
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 16:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AF5C433C9;
	Fri,  1 Dec 2023 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701446655;
	bh=WDwXHLzsxJNvZ1n+6tjB8Oz2qvJBOEOwe6+fzg7nsD8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=MFkgkuUhOmqOnVGH04okkKwpDpQQevjvOJDaqrNPMktBiKJGeLypo6dQaZ7kdMizt
	 9lgF3GfFhNBgGl75sflKJi8yEIHz0zlEQhA5/KIOX8POfMyyQImPSHAZhumCw9EXDv
	 ha0qTkhHtmqqU3xw8YYfYlc8kTl87gAq5P4X2Ly2ObV9Yu+apmBU0zxcwuxM3jprqT
	 LMBTqpV0RgE9SeaFlg7HTPey5PQv85Vg6ZbA5U1SuGR0mLMv2YjhlqAPO8ooh76pGY
	 MpZdThCSOSWEOokHCbQpN5PvIjHSc3JczChgvbIF4kU+NJVYieyn5/P73pXw1BzMTl
	 gXr43t6N6WEWg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: add 320 MHz bandwidth enums
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231116221839.1303170-1-quic_msinada@quicinc.com>
References: <20231116221839.1303170-1-quic_msinada@quicinc.com>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Muna Sinada <quic_msinada@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170144665259.2201420.686860353883258402.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 16:04:14 +0000 (UTC)

Muna Sinada <quic_msinada@quicinc.com> wrote:

> Add 320 MHz bandwidth as a new bandwidth enum for ATH12k driver. This
> is extending existing bandwidth related enums to include 320 MHz. This
> is a precursor to supporting 320 MHz in the future.
> 
> Sanity test performed to confirm that there was no impact in existing
> bandwidths.
> 
> Additionally update QuIC copyright to include 2023 in hal_rx.h.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00125-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

37a0dd6137ec wifi: ath12k: add 320 MHz bandwidth enums

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231116221839.1303170-1-quic_msinada@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


