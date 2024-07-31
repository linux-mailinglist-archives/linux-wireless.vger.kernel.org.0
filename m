Return-Path: <linux-wireless+bounces-10765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861FC943576
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007801F21B36
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4605F481DD;
	Wed, 31 Jul 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUBeAoJs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB5481B1
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449607; cv=none; b=UnTFLY7aA8hNDpu2Qz6/cDKJorx7b/0AKsZasYeJN6+DD+RxXFzn8ZxL3k9GAxFUvWsQngal/dOc9mdi25H2wj1z9wLCoBfFM4ZpfzYZjs/qUBIkvkmcS3dtfjB2N4KB5eSxFoV/415/IXT/6ISjzDzjrpW24fDxJ0fmPpYnTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449607; c=relaxed/simple;
	bh=/mWtXWuhFymOY0cwkGyAdgtXGxbMeCBxXQjOP6ErTbw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tSmQ8I+CQA8NEnE4SVDQll0uMEu+NRNNQ4eEi56SW24k6RpYn+wPLs9cFOKqV+oC8tYWI348Ied1LfEzcWVNetq/2btYsKYbmrWNGOrzdE3rzuxV2bIJEW09klSZKknWE1xROgFyEUU16wUgDYuTNFnCRwRSvOt3mWGjnukiUXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUBeAoJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD1AC116B1;
	Wed, 31 Jul 2024 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722449606;
	bh=/mWtXWuhFymOY0cwkGyAdgtXGxbMeCBxXQjOP6ErTbw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=EUBeAoJs3VI+ln9p7cspWwUEnZrumGooIoqDJ7rFwmrW7HBctaSpirQ2RRowt1DVy
	 SOi+ZyRUr/w02MF03t12H5gSS9hVKnCTbCilhBwLjXBZRkkWqH1na4ahenbe9Xr/Qa
	 D/Vo9QrFXEl9HvYLxUlXpq1E3G1XpiXnD4u5kE8gMpfOinqai2bNZjnX08xMPbhh0d
	 yobVRIZdv0fD/n1ErAU1caskQM3X9CVL7DRyPF5QPSFBJieOEjVrPWi/yHkUbOnhSF
	 Tm24MIXNJjfXnW4+cXw2xBM1ojOTsoqYDMJHZD9wH+S898eWnf9HI92jDRmdpkBeDq
	 zogY+YfHwBAaQ==
From: Kalle Valo <kvalo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: Cedric Veilleux <veilleux.cedric@gmail.com>,
  linux-wireless@vger.kernel.org,
    ath10k@lists.infradead.org
Subject: Re: [REGRESSION] ath10k: failed to flush transmit queue
References: <CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com>
	<1df0c5cc-ce58-450e-9f91-7f8f599cb11d@nbd.name>
Date: Wed, 31 Jul 2024 21:13:23 +0300
In-Reply-To: <1df0c5cc-ce58-450e-9f91-7f8f599cb11d@nbd.name> (Felix Fietkau's
	message of "Fri, 12 Jul 2024 10:08:10 +0200")
Message-ID: <87le1hjupo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Felix Fietkau <nbd@nbd.name> writes:

> On 12.07.24 04:23, Cedric Veilleux wrote:
>
>> AP mode.
>> Both 2.4 and 5ghz channels.
>> Using WLE600VX (QCA986x/988x), we are seeing the following errors in
>> kernel logs:
>> [12978.022077] ath10k_pci 0000:04:00.0: failed to flush transmit
>> queue
>> (skip 0 ar-state 1): 0
>> [13343.069189] ath10k_pci 0000:04:00.0: failed to flush transmit queue
>> (skip 0 ar-state 1): 0
>> They are somewhat random but frequent. Can happen once a day or many
>> times per hour.
>> They are associated with 3-4 seconds of radio silence. Full packet
>> loss. Then everything resumes normally, STA are still associated and
>> traffic resumes.
>> I have tested with major kernel versions:
>> 6.1.97: stable (tested for many days on 10+ access points)
>> 6.2.16: stable (tested for few hours single machine)
>> 6.3.13: stable (tested for few hours single machine)
>> 6.4.16: unstable  (we have errors within an hour)
>> 6.5.13: unstable  (we have errors within an hour)
>> 6.6.39: unstable  (we have errors within an hour)
>> 6.7.12: unstable  (we have errors within an hour)
>> 6.8.10: unstable  (we have errors within an hour)
>> 6.9.7: unstable  (we have errors within an hour)
>>  From these tests I believe something changed in 6.4 series causing
>> instabilities and the dreaded "failed to flush transmit queue" error.
>> This is a custom linux distribution. Only change is the kernel. All
>> other packages are same versions. Everything rebuilt from source using
>> bitbake/yocto. Same linux-firmware files.
>
> I'm pretty sure it's caused by this commit:
>
> commit 0b75a1b1e42e07ae84e3a11d2368b418546e2bec
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Fri Mar 31 16:59:16 2023 +0200
>
>     wifi: mac80211: flush queues on STA removal
>
> I guess somebody needs to look into making the queue flush on ath10k
> more reliable (or even better, implement a more lightweight .flush_sta
> op).
>
> I don't have time to do the work myself, but hopefully this
> information could help somebody else take care of it.

Adding ath10k list so that everyone see this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

