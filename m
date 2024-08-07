Return-Path: <linux-wireless+bounces-11089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2294A9E9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AFF1C20A60
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9D526AFC;
	Wed,  7 Aug 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptXYk+kW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B642209B;
	Wed,  7 Aug 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040322; cv=none; b=eiN4O4xG7f7GmI7xt9m3Jrw/1wbiaP6fsClOnsyYtmwJYqKsMAwIfPDlBZRP7QSHGnxWYTS+hnJukCV7GR1NVb8dM0zxw/dCsfGDmBj5ZLLkfSEhyjJ7HCqsFno8Br9BLnbYpJJeKOX1REPm0XfEIdoxtDJTC9VwJVEWjfO3XXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040322; c=relaxed/simple;
	bh=dX8PvjgkvfmTNxZeRdGme1gmF+xBGiIzA+UfTZglBNc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MBIhR9m7nSWik+EWjTM0quOvmm7P1hkz2kqxOTjOQmBlY6SjLKPVKnJoANsjC1/euaJw2I1blLUy1gzpGw342KZT5KVwdylsw2ej5owp5EO0oMOrqFJWDHPd3o9I81Tc5PA1Go3QiV/bQpd0q2iXnZhS1w79zNaAqMMnHGKFdN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptXYk+kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C583C32781;
	Wed,  7 Aug 2024 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723040321;
	bh=dX8PvjgkvfmTNxZeRdGme1gmF+xBGiIzA+UfTZglBNc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ptXYk+kWf+KX6S33ihwEeaYo2qOC3lJVt0L2a8FNswfeiA8NT9A6KvkodFmL0PN9V
	 LSl1EltIIlJbxizC9bxs8Y6HofOfv2p3I+hnmf+xFrqSMhNRXodgurRF4TFTCnATnn
	 fr0y1wN7KHG47q5bLYs0lsxtYB7Ku57J1vr4rihg6GEUGOPDxlb9qGgKacNN65E1Nc
	 NN5w6RUe4ol47GmkMPhgAsQg7PQ7MMH9pwWcCIzSz/vnLpzvLRb3WLWiE+LTByYulS
	 0fj3cqnySxBL2zIqWNtxWr+zi2vPX3D7230Y/Qgdjb/XVUOrexq1BoMRZ2t/qROsRW
	 wXyEjAqO+7rPA==
From: Kalle Valo <kvalo@kernel.org>
To: "Berg, Benjamin" <benjamin.berg@intel.com>
Cc: "chris.bainbridge@gmail.com" <chris.bainbridge@gmail.com>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
  "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
  "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] bisected: iwlwifi: use already mapped data when
 TXing an AMSDU
References: <ZrNRoEbdkxkKFMBi@debian.local> <87le18ile6.fsf@kernel.org>
	<CAP-bSRboZLWg4pzHHrD66NFeKKbsX0z-wUcxJS4OYmzcHXdG1w@mail.gmail.com>
	<87o7644f4j.fsf@kernel.org>
	<a98208c8123695c225ecf09915377fa19cb0fa0a.camel@intel.com>
Date: Wed, 07 Aug 2024 17:18:38 +0300
In-Reply-To: <a98208c8123695c225ecf09915377fa19cb0fa0a.camel@intel.com>
	(Benjamin Berg's message of "Wed, 7 Aug 2024 13:59:55 +0000")
Message-ID: <87h6bwifgh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Berg, Benjamin" <benjamin.berg@intel.com> writes:

> Hi,
>
> On Wed, 2024-08-07 at 16:49 +0300, Kalle Valo wrote:
>> Chris Bainbridge <chris.bainbridge@gmail.com> writes:
>> 
>> > On Wed, 7 Aug 2024 at 13:10, Kalle Valo <kvalo@kernel.org> wrote:
>> > > [SNIP]
>> > Not really. It is functional but tx throughput is severely
>> > degraded,
>> > iperf shows ~1mbit/sec instead of the usual ~600mbit. Rx throughput
>> > (measured with `iperf -c ... -R`) doesn't seem to be affected.
>> 
>> Ok, so a quite severe issue. Hopefully Intel can find a fix,
>> otherwise
>> we need to consider should we revert commit 90db50755228 ("wifi:
>> iwlwifi: use already mapped data when TXing an AMSDU") for v6.11.
>
> Yes, if we do not have a fix soon we'll need to revert. If so, then we
> should also revert:
>
> wifi: iwlwifi: keep the TSO and workaround pages mapped
> wifi: iwlwifi: map entire SKB when sending AMSDUs
>
> as well as the related bugfix:
> wifi: iwlwifi: correctly reference TSO page information
>
> Otherwise there is a performance impact as DMA mapping is effectively
> done twice.

That's good to know, thanks. But let's hope you find a fix.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

