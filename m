Return-Path: <linux-wireless+bounces-10821-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852FA944F03
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 17:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4073128381F
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E41B011B;
	Thu,  1 Aug 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW1KIJq/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07D1B0111;
	Thu,  1 Aug 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525624; cv=none; b=qTVVvGE4HLF8bZJpU7hWLEnNu6DXrYiNOZHShLlNAhi/ucpm6gdnkHGMy0URdjmpraxPiOpuifIvUNGDCav1QGmGsm7JSCNjq1giaj5e/tqT5XJh1mRtcOpKeVw+Y15+jrpMouY88iGpMv6a3hvBdZnEYKWqIYenEwe2fUiRRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525624; c=relaxed/simple;
	bh=Z5w3It2q9WeUub/jU2zGmZpsP0nu9rBLj/RN5LKP+ek=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=B+rw1SxSFPu2qDaQr+UKFSDaKsDdHsSYVDJvC/vzaFLAAWA4H0EEUZiDc5ida9lK7hmCg4SRmJlSLnlzzEf07FuViQ6TSV2Tfv3Bd2fNNJQSvDT0d1VbtW/yBs2sSebPL53YFG9axh9v0wZq5NzgeZM/caZ3R1c3tItsqQuF0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW1KIJq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58546C32786;
	Thu,  1 Aug 2024 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722525623;
	bh=Z5w3It2q9WeUub/jU2zGmZpsP0nu9rBLj/RN5LKP+ek=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pW1KIJq/ssHR9+E//i/alrP7hypHlFM1xh3tXi3scjzuocg7GZL6UqO3PT+8F1GYD
	 jDVRJ85pV6p/+RMqNw6+hbbcASpBy6jNL0lzQrENftQEojdK+BQJ8888c0U51Jq5nP
	 P4dzV34Y/ctu3NmoRbQpDsXS1S/t/ygWQK6xLYJ6C/hMiJbm/RYuRXY9abmeMNsPBh
	 6mK95XPDHK4p0apfc1gu99hWNkLKZcZKt5GAJvxZVn+ibsNcRwsT2CzRmH3nc0Rn3E
	 0unSssxb04nCfXPe8FW/ZouB8HZ1IAWgc3Iqst6xpsmZjMx2NR7rcg8beQlJ8k3TGP
	 +1bzxVzLOzlbA==
From: Kalle Valo <kvalo@kernel.org>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>
Cc: "Baochen Qiang" <quic_bqiang@quicinc.com>,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  kernel@quicinc.com,
  netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit
 path for WCN7850
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
	<2cdac1e1-dff4-451c-a214-510c4736160a@app.fastmail.com>
Date: Thu, 01 Aug 2024 18:20:20 +0300
In-Reply-To: <2cdac1e1-dff4-451c-a214-510c4736160a@app.fastmail.com> (Mark
	Pearson's message of "Fri, 19 Jul 2024 09:07:18 -0400")
Message-ID: <875xsk8e2z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark Pearson" <mpearson-lenovo@squebb.ca> writes:

> On Sun, Jul 14, 2024, at 10:38 PM, Baochen Qiang wrote:
>
>> In transmit path, it is likely that the iova is not aligned to PCIe TLP
>> max payload size, which is 128 for WCN7850. Normally in such cases hardware
>> is expected to split the packet into several parts in a manner such that
>> they, other than the first one, have aligned iova. However due to hardware
>> limitations, WCN7850 does not behave like that properly with some specific
>> unaligned iova in transmit path. This easily results in target hang in a
>> KPI transmit test: packet send/receive failure, WMI command send timeout
>> etc. Also fatal error seen in PCIe level:
>>
>> 	...
>> 	Capabilities: ...
>> 		...
>> 		DevSta: ... FatalErr+ ...
>> 		...
>> 	...
>>
>> Work around this by manually moving/reallocating payload buffer such that
>> we can map it to a 128 bytes aligned iova. The moving requires sufficient
>> head room or tail room in skb: for the former we can do ourselves a favor
>> by asking some extra bytes when registering with mac80211, while for the
>> latter we can do nothing.
>>
>> Moving/reallocating buffer consumes additional CPU cycles, but the good news
>> is that an aligned iova increases PCIe efficiency. In my tests on some X86
>> platforms the KPI results are almost consistent.
>>
>> Since this is seen only with WCN7850, add a new hardware parameter to
>> differentiate from others.
>>
>> Tested-on: WCN7850 hw2.0 PCI 
>> WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>
> We've tested this in the Lenovo lab using the T14 G5 AMD with a
> 6.10.0-rc7+ kernel from wireless-next and this patch applied.
> Previously we had stability issues under traffic load. With the patch
> applied we can no longer reproduce the issue.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Can this be tagged for stable backporting? It's an important fix.

I added cc stable to the commit message. I forgot to do it before I
pushed my changes out, but it's in my local branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

