Return-Path: <linux-wireless+bounces-9893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82747925473
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD471C21454
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC94DA14;
	Wed,  3 Jul 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekvw+WdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729425760
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990875; cv=none; b=kVtXTs1r63aeJTjYuhC8nPPMU0P9aU889BzDoYyKSZ5bSmtu6ruBVQFFcEaxKjqADDS0HsbcNRCu3F4F/JgLVOV0WeFJgAfoYPRhkqH2quLNKd7hAMOZ9mUhP2FyP05sxHnsm4JlTJzNGvRuT+Vsu4Cqdij+OZxrXrWrTSZy4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990875; c=relaxed/simple;
	bh=x+1Z0OH2iTgkOWjPo7qguUcayPfUY6MxGUvlYB4Er9U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fwRlayb0CxhmRLc48MxNm7XIEIeG5n7F4ohJmunvBfwqUhE5Bw/NPT+FtdUya47mhZ9k/i7vGd+zjJWWxrlv6M/K1+rjRnWbGqGZmZzW9tFYiAsr6iUF9Le34NKxfxNa7Ab0G2hEejJLpzD4UP3zWhG/SVRFXpnONqfWhlGiXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekvw+WdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF794C2BD10;
	Wed,  3 Jul 2024 07:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719990875;
	bh=x+1Z0OH2iTgkOWjPo7qguUcayPfUY6MxGUvlYB4Er9U=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Ekvw+WdQ2FH0lUhpQUPwlryZvnC0zVEx3AVCDmPFolSc0F6dnzOq5U1MvgtGXpsSY
	 NFRAdF24djUA2rpP8DlBk/4H/lJWEGtQfCxuRDuDpcKZlhDT27chfOvhYy2VsJ7s6P
	 4qhTirqvwSNnyeC1liCyanoUmx7ls76ySdL7DcsElc69Hxw4UlsNndkYHGXExA6yLY
	 il5YAIPK+85e+g20b5/cPoyDAgH0McKmfcNjxQ/j6PqS/aa93rOxH1auwrjRhXtfic
	 CefBDu8i9Rl53pYHjisFxmOHqtC1Hzq2yYnQnVeeniLLOWBm3stV2Y0CRnB4jzCkht
	 304GsGKjOkWdA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <linux-wireless@vger.kernel.org>,  <ath10k@lists.infradead.org>,
  <ath11k@lists.infradead.org>,  <ath12k@lists.infradead.org>,
  <quic_kvalo@quicinc.com>,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: pull-request: ath-next-20240702
References: <812acd8a-fc26-4611-8a7a-c3a1d6197d00@quicinc.com>
	<87zfqzdkgh.fsf@kernel.org>
Date: Wed, 03 Jul 2024 10:14:32 +0300
In-Reply-To: <87zfqzdkgh.fsf@kernel.org> (Kalle Valo's message of "Wed, 03 Jul
	2024 10:05:18 +0300")
Message-ID: <87v81ndk13.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
>> The following changes since commit bb678f01804ccaa861b012b2b9426d69673d8a84:
>>
>>   Merge branch 'intel-wired-lan-driver-updates-2024-06-03'
>> (2024-06-10 19:52:50 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20240702
>>
>> for you to fetch changes up to 5344fc76f8944249026884157f846f88489edfc0:
>>
>>   wifi: ath12k: Support TQM stats (2024-07-01 21:57:28 +0300)
>>
>> ----------------------------------------------------------------
>> ath.git patches for v6.11
>>
>> We have moved to a new group-managed repo, and this is the first pull
>> request from that repo, and from me. Fingers crossed...
>>
>> We have some new features in ath12k along with some cleanups in ath11k
>> and ath12k. Also notable are some device-tree changes to allow certain
>> ath11k and ath12k devices to work with a new power sequencing
>> subsystem.
>>
>> Major changes:
>>
>> ath12k
>>
>> * DebugFS support for datapath statistics
>> * WCN7850: support for WoW (Wake on WLAN)
>> * WCN7850: device-tree bindings
>>
>> ath11k
>>
>> * QCA6390: device-tree bindings
>>
>> ----------------------------------------------------------------
>
> I see a weird warning from gpg which I have never seen before:
>
> merged tag 'ath-next-20240702'
> gpg: Signature made Tue 02 Jul 2024 05:55:42 PM EEST
> gpg:                using EDDSA key 3F9AD487CCF522D7A21F0C492C15BBA0898CCB7B
> gpg:                issuer "jjohnson@kernel.org"
> gpg: Good signature from "Jeff Johnson <quic_jjohnson@quicinc.com>" [full]
> gpg: WARNING: We do NOT trust this key!
> gpg:          The signature is probably a FORGERY.
>
> It first says that the signature is good and then claims it's a forgery,
> odd. Is this a problem between using different email addresses or what?

I did 'gpg --refresh-keys', now your key contains your kernel.org
address and I don't see the warning anymore.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

