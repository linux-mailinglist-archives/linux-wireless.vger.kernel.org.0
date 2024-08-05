Return-Path: <linux-wireless+bounces-10953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C763094787D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D90A28297C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EF9153800;
	Mon,  5 Aug 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVj8qL3i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982414C5AF;
	Mon,  5 Aug 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850566; cv=none; b=qGkwGDgI0NwXUThz0UELWK66HS1xkJpXzJicixbYtYJm2ADwqWFL1nYSjCRglRRT4LSg8hHuXiF3OKuowIxNJ1GbkKviaeMjTAStOJjFr0x/xZ7xEDvSgO+eXxy9rwR6VayayVy7x9YyeMVCwg9yEu6xjvcdQrYDwKBkahZAMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850566; c=relaxed/simple;
	bh=2bhgdALTqEX3RTZsyFzr/KHTebMxOVLhVwovoaQlv38=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jfFi29CGG0Iq2YvTzAKBTDkEPpDwYTT7ddFaBWwE6aRe8sP7fctavOP41OJwAoe/tB1CSXiNwqiXfeZzGzlk9/WKaeqyQYfrOoEXDYxhOsKJizAwVWY87WYMPhc6N1a2HOS0KpBDy4kmaFYgG5zZdYw0ewVLEqsT5DdDRUeiBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVj8qL3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8D3C4AF0E;
	Mon,  5 Aug 2024 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722850565;
	bh=2bhgdALTqEX3RTZsyFzr/KHTebMxOVLhVwovoaQlv38=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MVj8qL3iInDFRXnFmKrd2vCR61SNYQ0jVxSvwkLFVP/CiDdb9OaO+1JeVe0HfKwvO
	 xLKSzHeLEbH296/blWQlgKsMqZjUtPwCgHYtve/0qyOkg6wEKGHtKirCFLnRkCsudG
	 S/E/BvO23UFMb0icp1Av+2ceCt59LnjP2loseZyPZT1/riGt6X1a/H31UVmPW0gA7z
	 QGup3AQGe4zkY7AXYal+1P1lC08yngbm4EcY2dkWKvY7HChsjntQOo4hWzlSiwa5hp
	 1YAr2tPUHpFHyIQCqGUuF7pM8IfKk4T5f8FxGUXVfPasHnboQzFSdiGmF3wFRVI3M8
	 TtivFF5mxZu/g==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>,  <kernel@quicinc.com>,
  <netdev@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit
 path for WCN7850
References: <20240715023814.20242-1-quic_bqiang@quicinc.com>
	<87ed788enl.fsf@kernel.org>
	<90077fb2-42e0-42ab-b5a1-b4b73ff201d5@quicinc.com>
Date: Mon, 05 Aug 2024 12:36:02 +0300
In-Reply-To: <90077fb2-42e0-42ab-b5a1-b4b73ff201d5@quicinc.com> (Jeff
	Johnson's message of "Thu, 1 Aug 2024 11:04:18 -0700")
Message-ID: <87jzgv71ml.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

>>> @@ -279,6 +334,23 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
>>>  		goto fail_remove_tx_buf;
>>>  	}
>>>  
>>> +	if (iova_mask &&
>>> +	    (unsigned long)skb->data & iova_mask) {
>>> +		ret = ath12k_dp_tx_align_payload(ab, &skb);
>>> +		if (ret) {
>>> +			dev_warn_once(ab->dev, "failed to align TX buffer %d\n", ret);
>> 
>> Why dev_warn_once()? I changed it to ath12k_warn() in the pending
>> branch.
>
> My concern was that if this is an ongoing issue that you'd end up spamming the
> kernel log. But I guess the rate limiting will reduce the spam to no more than
> 10 logs in a 5 second interval

Yeah, ratelimiting used by ath12k_warn() should be safe. It would be
consistent to have ath12k_warn_once() instead of using dev_warn_once()
but in this it's better to print the warning more than once so that
users don't miss it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

