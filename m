Return-Path: <linux-wireless+bounces-6374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B812D8A6618
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E734C1C21063
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 08:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E613A87E;
	Tue, 16 Apr 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSohxlRY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE1139CFF
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713256137; cv=none; b=VNN0ydlsAr+LexWhOSHyrp+428xIhrmH+GM7AZEPBq/j2gEkoDlpFOm2IwYfExEI1LuiNrMmev8lWMdFKxZUYhX6FMEHA0lPB0V30LjDva0zk61UemNFaPFhx6MKTIbrz9PSFeWj8RMKV+vqVru824RsqnQ1nzFOg+VLbo9k4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713256137; c=relaxed/simple;
	bh=2ERkywRAqUnwLvSCSO91utOXtH6ChiSIXYc6NfsfdMs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=h7nOydsGX1O5iusAlCmHNLUuMIesgmg1rtCrzGxCNhb4m5ECWr9Wh+X0Ta0W/RfhxEFdch6fJsdJ+8kTespFEyIVFahcowLv6EoKGwKXh8Y7M8FTuLLD1qLaeBbZu4zLBuVJ+JyWGIkBAag27iNDgJs0vOriVUarvNNtc+jjV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSohxlRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0FDC113CE;
	Tue, 16 Apr 2024 08:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713256137;
	bh=2ERkywRAqUnwLvSCSO91utOXtH6ChiSIXYc6NfsfdMs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GSohxlRY1LRMjSKxery5JDfnxebEY2FDZROtnDYFPNWpYuiGt2NbnK1Qwgs4h2Wld
	 +0SPNoIXzTziT1ntFgJoLdd03Uz10j+7EEXB0iiKTSF1W7+UZf8J4tj4yJiq/KUcR1
	 81t1MgzMr+c6cUxi/6N6SyrZiqsKKt7UsvTWROMDSe5tt1CpsyGvfYiUUanYGwJJtQ
	 INYrl+dpAaJKnEeVZ3Xpb81VASTyufWFgeM7ieDVQYoBBaZXGaPnFHw/IbFWTIq9B9
	 ul+KYrYE0+DHZ/YLc5ZSIjq1ZklGas1GWR06GIvBSBmocpmBLRt0LM1bGo698HLcG7
	 K4Izc4eWwI9Pg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/10] wifi: ath12k: support suspend/resume
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
	<aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
	<76ef11b2-c477-ff11-df72-e8d934c00831@quicinc.com>
Date: Tue, 16 Apr 2024 11:28:54 +0300
In-Reply-To: <76ef11b2-c477-ff11-df72-e8d934c00831@quicinc.com> (Baochen
	Qiang's message of "Mon, 15 Apr 2024 13:51:25 +0800")
Message-ID: <874jc1yam1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>> patch 6 of this series conflicts with:
>> wifi: ath12k: add support to handle beacon miss for WCN7850
>>
>> So I was not able to take this series into my local verification tree
>>
>> patch 7 of this series conflicts with:
>> wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path
>>
>> So this conflicts with a patch already in the pending branch
>>
>> So FYI at some point you'll need to rebase.
>
> So I should rebase after these two patches got merged in master branch?

No need to rebase at this time. In the pending branch I was able to fix
the conflict in patch 7. Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=b92086862c7be6e6810eca204052cada50fc0f5f

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

