Return-Path: <linux-wireless+bounces-11125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0094BBCB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BE71C20F7B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 10:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670E18B495;
	Thu,  8 Aug 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur1mPurb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3F18B493
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114683; cv=none; b=GpRpjaFGblpKHNF7opuDsPNzOwFnGulzf/Eozk4e+P/UtOMusGsepQh3i9K2qaFtEaqQ5LHDusgtE8RWcNi2fJ03OnihN5ryjcXf8QY+GIjibGdhWmlfworpewPQub4z6ou69mMi5Re2Y8KmzyMoGJXM+5BsRT9gJVWnTNh+LdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114683; c=relaxed/simple;
	bh=fLkrAQXFudXsq+HdbktGHKS6ZexNfbPFMzzphgVco+g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Xt3fK4tZzKHi22zkAaYtXH01QbEZQJKG4rc7z6ZPPGA7kr/wEofeY3ShnEWvyapFXMMMbLEdzsborjd6UROkF5MSzsTt9cPC6a/LWxJkqMrukwSCnooJsId6qfk/YpHSqYOYGTa6bMUoPOuzVZu12CSgPhVrExOT2WGI9h9oVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur1mPurb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B135BC4AF0D;
	Thu,  8 Aug 2024 10:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723114682;
	bh=fLkrAQXFudXsq+HdbktGHKS6ZexNfbPFMzzphgVco+g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Ur1mPurbXbpt/nIzHqsBAmxXV/uI6QiU5V2KKlnyK3pKou/c/atj4Aak664jkbR0i
	 SGx9lXVRCMOczlDaSCJ4iSzthOY7MjyYwBhvfUtFvAzChpWgefWjG7+wmwPZeOMPFv
	 Km4+CM3Qb5PrR2QLf3mZw51WgykoBAs+dNqlJDuOAmAcHcfa9Bs0L7noCPKv+EVnHJ
	 K7ounT8pT+Gi98PQGRakk2toAIlI+hQtb/y0BPXME9Lk+70ZXvwR2koZEEo26pLj83
	 T08cOfYyY3KyLW0fhUzguPDdEIRFcpw8mjE6ccLOz5TsuLPVkCBW5W4zqR2iCy3mmE
	 1L6vIGnqN2oKw==
From: Kalle Valo <kvalo@kernel.org>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Sriram
 R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v6 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
References: <20240711165511.3100433-1-quic_ramess@quicinc.com>
	<20240711165511.3100433-2-quic_ramess@quicinc.com>
	<87frrj70nz.fsf@kernel.org>
Date: Thu, 08 Aug 2024 13:57:59 +0300
In-Reply-To: <87frrj70nz.fsf@kernel.org> (Kalle Valo's message of "Mon, 05 Aug
	2024 12:56:48 +0300")
Message-ID: <87sevf2seg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Rameshkumar Sundaram <quic_ramess@quicinc.com> writes:
>
>> Locking:
>>  Currently modifications to members of arvif and arsta are protected by ar->conf_mutex
>>  and it stays as such.
>>  Now with these hw level structure (ahvif) being introduced, any modifications
>>  to its members and link objects (i.e., arvifs[] which are dynamically allocated)
>>  needs to be protected for writing and ah->conf_mutex is used for the same.
>>  Also, atomic contexts(say WMI events and certain mac_ops) that we currently have in driver
>>  will not(shouldn't be allowed) do any modifications but can read them and
>>  rcu_read_lock() is used for the same.
>
> Please elaborate more about your locking design. Because of past bad
> contributions from Qualcomm the bar is really high for adding any new
> locks. I'm doing the locking analysis right now but it would help a lot
> if you could provide your own analysis.
>
> My first impressions:
>
> It's really confusing to have two locks with the same name (conf_mutex
> in struct ath12k_hw and struct ath12k).
>
> struct ath12k_hw already has hw_mutex so I'm even more suspicious about
> this locking design. That's not explained at all in commit messages.

I didn't get any replies, and my own analysis is still ongoing, but the
more I look at this, the more I feel using two overlapping mutexes is
overkill. I'm starting to wonder if we would convert to using
wiphy_lock()? That might simplify things significantly. I should have an
old patchset doing that stored somewhere.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

