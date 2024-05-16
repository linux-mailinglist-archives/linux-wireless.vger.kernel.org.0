Return-Path: <linux-wireless+bounces-7731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FABA8C71A9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 08:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4261F2158D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 06:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E520E171AF;
	Thu, 16 May 2024 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnVHoX5I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D92F3B
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715841249; cv=none; b=RdO6Fnnkxc8QBwZ8fsO2TSrqCF6ftQRKkjoWzy+4w9fUpm45ToLgfnbV1lmSZUv9e/tXuECSDVMG0hvnaDV+H+iEzVZDXnlSDPKAeq6gaoJoCaJ5tJqgniN/FzUE8HTy50cTQz2aJJTpLxomU8PcrmcILBd/Daxf6IENe4SznHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715841249; c=relaxed/simple;
	bh=PyEXMCM3kNnzkPpDE49M7RWi2C8lgsKApAg0eQOMHfo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=E56n9dM1L+TUgNbpQBnLi5Xl+iLKgDrQ6etVOPPAWQAgSht+4XYlCCy5o0q2u6uRwjMJJNGJnKuqSF39Kbf0/jfDkHH360vsUIgdZpsltyY+PeGlUjqIjVzuRljf0mPnvsQTUOgDk2Ukm6Axf72NTgvP3K2zL/UbKhaxTVXK7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnVHoX5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FEEC113CC;
	Thu, 16 May 2024 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715841249;
	bh=PyEXMCM3kNnzkPpDE49M7RWi2C8lgsKApAg0eQOMHfo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KnVHoX5I0qELPgqXF1ablAotWoPtarExqniZv4J53kK+wT0myUD9vDuzQlWARZtWz
	 CljCYRfc1rMOot6ffafWgxVF08qTqcGQc2YyLs4v8RdjzENkesP1HjHpmG7eK2DKFE
	 xyzpLMcn9uk6hkh+oKUobMfonqW7ERXe/7bdLZTZ9B7KuNF+Z4ad/wPm5mIb/q16Dc
	 6EkiEHLSAE4Ou4Yf2rNiz5TvnwrSUDNS92PF6+y2NUBGQ6ZuDuR8cuO4fhyK/P/W/F
	 7U9CPHpVRQPOzX6cfa4UF586kNnnf0gD02/8FyvnUw7BVfxClUQF/uigUB9UULL0bL
	 DncwNlUeb80vw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Muna Sinada <quic_msinada@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Add Dynamic VLAN support
References: <20240506231752.942567-1-quic_msinada@quicinc.com>
	<b69c3612-3d9c-491a-b98c-03b9997654d7@quicinc.com>
Date: Thu, 16 May 2024 09:34:06 +0300
In-Reply-To: <b69c3612-3d9c-491a-b98c-03b9997654d7@quicinc.com> (Jeff
	Johnson's message of "Mon, 13 May 2024 10:17:18 -0700")
Message-ID: <874jayi7tt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/6/2024 4:17 PM, Muna Sinada wrote:
>> Add support for dynamic VLAN. VLAN group traffic is encapsulated and
>> encrypted in mac80211 and driver needs to set flags for the VLAN group
>> traffic to skip hardware encapsulation and encryption.
>> 
>> VLAN group traffic utilizes ext MSDU and HTT Metadata to set
>> encapsulation type to RAW and encryption type to OPEN in order to
>> inform firmware to skip hardware encapsulation and encryption.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>
> My first test of this patch gave intermittent connectivity, but a second test
> didn't show that, so I think my issues were actually with my home router.
> So giving this:
>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> However I do have one question:
>
>> +struct hal_tx_msdu_metadata {
>> +	__le32 info0;
>> +	__le32 rsvd3[6];
>
> why not rsvd0?
>
> If that is OK, Kalle can change this in 'pending'

Muna, please always reply to review comments. Not replying to them gives
an impression that you have ignored them and makes it harder for
maintainers to trust your patches. I noticed you addressed the review
comment in v2 but you still need to answer to review comments.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

