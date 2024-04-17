Return-Path: <linux-wireless+bounces-6457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C898A85E0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91844B213D3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E9612FF9E;
	Wed, 17 Apr 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBh2soYK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9652F86
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363767; cv=none; b=BLhChKgy3DHLWVBMV46wvLxthBsb32YBkSIzImuL1rmELS2K8BMzY5Vr/IXfQmpAmjQK+hEo+EXHf7mnzQB/xFNQb5C2gf6qiQZWyz930QIEqXyHsuFCO3yc1EJuR+wvYEvS6hxm//GDctac4UtzjR0Q7tkEOcvH6lGZaWGZeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363767; c=relaxed/simple;
	bh=h1ZKhUHRAA/7rGO40L17WijIMpSW0//PNJPxU+MELtI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=F5cyKJEgdK/gjDAdRLpEuLBeGzPlI1h7qyfBemG6bWlaUeRyrSsedNQJucrR8PQ+t/mUShXzpDkhnTmChNO2VpaDdymeTKELf2jfYmp4sNFvffA//2zpZHzOgbGPt25blAuQjztU+dOHUyXeM6auYKtX3GyZIOQkdnhF/gZCgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBh2soYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79C5C072AA;
	Wed, 17 Apr 2024 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713363766;
	bh=h1ZKhUHRAA/7rGO40L17WijIMpSW0//PNJPxU+MELtI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YBh2soYKFd6gFBPbsEczZTamnMWHUvjGMfxHklgeGzfOQJwVnjDy1SVnH0Yk/4T//
	 mx7JariBsi/IPzmNRGKiMDIWTLAt2Trw3RJIFK9vL44k7T9guFCXs1YONA+B+XDBc/
	 sfz9gfesFmjJPBxpToUwuuRFnIagmw3Cs3zy9mN0W0/0t/7ARddnjQsl5pIUlsU4KD
	 e+9e5WXhrbLPhSY3BfCjY+PMxaKxYEfIpPWZyinpIbBpDCWZcMNsC84qEmePtXcHRB
	 8s7k+J1yqRfAG+xW8SG85tGeMSkas/bP4TBBs6dI957sLjSOaTxY/dLyRZUelsJHCH
	 j7AFyJkeu6/gg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/10] wifi: ath12k: support suspend/resume
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
	<aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
Date: Wed, 17 Apr 2024 17:22:43 +0300
In-Reply-To: <aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com> (Jeff
	Johnson's message of "Fri, 12 Apr 2024 11:05:00 -0700")
Message-ID: <87r0f4vzkc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 4/11/2024 11:06 PM, Baochen Qiang wrote:
>
>> Now that the MHI&QRTR patches [1] are merged, we can add
>> suspend/resume support for ath12k.
>> 
>> The whole design is quite similar to that in ath11k: firmware
>> is powered down when going to suspend and powered up when
>> resume, this makes hibernation work as well in addition to
>> suspend.
>> 
>> To summary, this series first does some preparations in the
>> first 8 patches. Then in patch [9/10] suspend/resume callbacks
>> are implemented. And at last in [10/10] we enable suspend/resume
>> functionality for WCN7850 because it's the only chip supporting
>> it for now.
>> 
>> [1] https://lore.kernel.org/linux-wireless/20240305021320.3367-1-quic_bqiang@quicinc.com/
>> 
>> Baochen Qiang (10):
>>   wifi: ath12k: rearrange IRQ enable/disable in reset path
>>   wifi: ath12k: remove MHI LOOPBACK channels
>>   wifi: ath12k: do not dump SRNG statistics during resume
>>   wifi: ath12k: fix warning on DMA ring capabilities event
>>   wifi: ath12k: decrease MHI channel buffer length to 8KB
>>   wifi: ath12k: flush all packets before suspend
>>   wifi: ath12k: no need to handle pktlog during suspend/resume
>>   wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()
>>   wifi: ath12k: support suspend/resume
>>   wifi: ath12k: change supports_suspend to true for WCN7850
>> 
>>  drivers/net/wireless/ath/ath12k/core.c  | 108 ++++++++++++++----------
>>  drivers/net/wireless/ath/ath12k/core.h  |   4 +
>>  drivers/net/wireless/ath/ath12k/dp_rx.c |  48 -----------
>>  drivers/net/wireless/ath/ath12k/dp_rx.h |   2 -
>
> My Qualcomm Innovation Center copyright checker reports:
> drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2024

I fixed this in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6b928df55a671d2c9a15edc746f6b42ef544928e

Jeff, what do you think of the patchset? Is it ready to take?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

