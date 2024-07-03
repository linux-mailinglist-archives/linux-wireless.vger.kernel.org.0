Return-Path: <linux-wireless+bounces-9889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6D92545C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74611F212DE
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D679130A4D;
	Wed,  3 Jul 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ8MtdbL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E0482C1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990322; cv=none; b=l6f6Mn9A+J2FPOAqFg/pBfmsa1n3PgQLmpoGwlxUKyo1XOdonE1yVNzKnvLiGNjfFy3ARhRmDtfOPlyfTb7EPV4ICwisVIvIljX0MhLjygTz2kDy67mdA7C2Hpk2o+auH9ELktRSr+yP7SLeP/h4EeFpqbQ0RLDtHx0pAV3ekSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990322; c=relaxed/simple;
	bh=ttPIAI/HeeNok4sKnKuFGFXX3xPe6Pu0oAmIpSTF4L4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IqsWR3sQNTRzZmvMgZeSnRdw6h0I0HDgCYh/pAzpdHjCBUahpu119L34CqurCMgyEIvF1RpJztB34HJqaNJVnOF4zRigZzpZMWkVMW8BnpzmtpVjaBiRU7hFRyMyWrhrxvt0HpB9E+0l6D+1JDruGbqDe3vf+SG7zB0i0fzkHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ8MtdbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660BDC2BD10;
	Wed,  3 Jul 2024 07:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719990322;
	bh=ttPIAI/HeeNok4sKnKuFGFXX3xPe6Pu0oAmIpSTF4L4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CJ8MtdbL6/+1VSpLnr4PE1his6MGogfBNWxPbeWu+Kh+G5oQKlQqBqiu7CkA4swNs
	 QQ2byqpRN0M9VRi2yNnd+vgrj56SQaZIHfq4MHhV5bA5bTTilHXnLJej40qFe5CeRv
	 rGVUkMV/bJNP2hV2lfU/T8jBp67HQ2H8IY6AyiBLPpFrT7DouQhuyuScxV8x/umO0t
	 i/sGx5MLFJcCiC42Xc81sGCs3nYZ6myeONAXexpqzPRsLNWZEDVv0Y3mm6Y7UHK6ho
	 +1HDfmQwTCqW3nkg/A0+Lt1m+Ivk44ghhcVajPrqUF0/aRGsdCsGm0QVrhRy6nNutZ
	 QovB3G5s/FmOQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>,  <ath10k@lists.infradead.org>,
  <ath11k@lists.infradead.org>,  <ath12k@lists.infradead.org>,
  <quic_kvalo@quicinc.com>,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: pull-request: ath-next-20240702
References: <812acd8a-fc26-4611-8a7a-c3a1d6197d00@quicinc.com>
Date: Wed, 03 Jul 2024 10:05:18 +0300
In-Reply-To: <812acd8a-fc26-4611-8a7a-c3a1d6197d00@quicinc.com> (Jeff
	Johnson's message of "Tue, 2 Jul 2024 13:44:56 -0700")
Message-ID: <87zfqzdkgh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> The following changes since commit bb678f01804ccaa861b012b2b9426d69673d8a84:
>
>   Merge branch 'intel-wired-lan-driver-updates-2024-06-03' (2024-06-10 19:52:50 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20240702
>
> for you to fetch changes up to 5344fc76f8944249026884157f846f88489edfc0:
>
>   wifi: ath12k: Support TQM stats (2024-07-01 21:57:28 +0300)
>
> ----------------------------------------------------------------
> ath.git patches for v6.11
>
> We have moved to a new group-managed repo, and this is the first pull
> request from that repo, and from me. Fingers crossed...
>
> We have some new features in ath12k along with some cleanups in ath11k
> and ath12k. Also notable are some device-tree changes to allow certain
> ath11k and ath12k devices to work with a new power sequencing
> subsystem.
>
> Major changes:
>
> ath12k
>
> * DebugFS support for datapath statistics
> * WCN7850: support for WoW (Wake on WLAN)
> * WCN7850: device-tree bindings
>
> ath11k
>
> * QCA6390: device-tree bindings
>
> ----------------------------------------------------------------

I see a weird warning from gpg which I have never seen before:

merged tag 'ath-next-20240702'
gpg: Signature made Tue 02 Jul 2024 05:55:42 PM EEST
gpg:                using EDDSA key 3F9AD487CCF522D7A21F0C492C15BBA0898CCB7B
gpg:                issuer "jjohnson@kernel.org"
gpg: Good signature from "Jeff Johnson <quic_jjohnson@quicinc.com>" [full]
gpg: WARNING: We do NOT trust this key!
gpg:          The signature is probably a FORGERY.

It first says that the signature is good and then claims it's a forgery,
odd. Is this a problem between using different email addresses or what?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

