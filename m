Return-Path: <linux-wireless+bounces-14244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22839A5D15
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 09:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ED51C2199F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5BF1DF964;
	Mon, 21 Oct 2024 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkJEuzXx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD31DF73F;
	Mon, 21 Oct 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495813; cv=none; b=rEVQLPzj6DjYEGnHa71xqSf7SFy6EgQcQB/M0TP92TVjSVSklBr1mWW7enOWBHE2T7+ZULJsjcr4c6dPoRMJznfc6uS23JfJlpPuZWdC4SdzDq6MB6KjBs3LrQxCxkT5peZKszO3j/+rOEIdtVhVrn1KLEf8A0QFrNSs2QFUDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495813; c=relaxed/simple;
	bh=eWSvhEi1l9Z4idDUywQ6rxNtO8VvUQXU9ozHH6sVuWk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=seBcl4X/Fkgx9Gj1S+ZzUlX6B4Nnp4MpqI0if2NRN/4GVOsykV7Lx6TRAu9Eks4TDj/AMRfnQpgU/XsSGaMph42EZ7NpQAOB9jhgyng2Hc8MISTLE+8OjHNSRr2II1bYmHG/FmlBAjx604nmoTWG5YI2tbdwFW5YqjNneInNN1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkJEuzXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1663C4CEC3;
	Mon, 21 Oct 2024 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729495812;
	bh=eWSvhEi1l9Z4idDUywQ6rxNtO8VvUQXU9ozHH6sVuWk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=rkJEuzXxrwdYaX6mt0Cw5yEdsCSkPy2a9ESgfrk75p6udiP8YhuS09dchhH3yEgVN
	 xt4eIYvbTmAQL5nPLy+A68dQwxcCeSPGDGxy5QPy1tFZf+SBU8U2ng+bKR7r3lb2aX
	 p5wNEkzuQNMnf1KOAn2tEESPxgcu7p8IXQKuu2zm4JMQsbQwvgMEH8AcIUfNT8vQ50
	 kIadfDl1Ltas8XbAlzukVH/WoZmidrVFcaVLPXNOfOZIW1SW6nUny1IP22ZaZ7dLRE
	 rf0E1QxiZGNtnO7Wu/1c+HuNnYtpyVo/nynRZrUKgJ44laRaFS46sJFrRM8cJsxX1t
	 9SQeD4TLC0oSQ==
From: Kalle Valo <kvalo@kernel.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>,  "Miri Korenblit"
 <miriam.rachel.korenblit@intel.com>,  "Johannes Berg"
 <johannes.berg@intel.com>,  "Emmanuel Grumbach"
 <emmanuel.grumbach@intel.com>,  "Gregory Greenman"
 <gregory.greenman@intel.com>,  "Daniel Gabay" <daniel.gabay@intel.com>,
  "Benjamin Berg" <benjamin.berg@intel.com>,  "Ilan Peer"
 <ilan.peer@intel.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: work around -Wenum-compare-conditional warning
References: <20241018151841.3821671-1-arnd@kernel.org>
	<87a5f1qtts.fsf@kernel.org>
	<d78b5354-b265-4e45-9a6a-996273026402@app.fastmail.com>
Date: Mon, 21 Oct 2024 10:30:08 +0300
In-Reply-To: <d78b5354-b265-4e45-9a6a-996273026402@app.fastmail.com> (Arnd
	Bergmann's message of "Fri, 18 Oct 2024 19:07:05 +0000")
Message-ID: <87zfmx3ocf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Fri, Oct 18, 2024, at 16:06, Kalle Valo wrote:
>> Arnd Bergmann <arnd@kernel.org> writes:
>>
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> This is one of only three -Wenum-compare-conditional warnings we get
>>> in randconfig builds:
>>>
>>> drivers/net/wireless/intel/iwlwifi/mvm/sta.c:4331:17: error: conditional expression between different enumeration types ('enum iwl_fw_sta_type' and 'enum iwl_sta_type') [-Werror,-Wenum-compare-conditional]
>>>  4331 |         u32 type = mld ? STATION_TYPE_PEER : IWL_STA_LINK;
>>>       |                        ^ ~~~~~~~~~~~~~~~~~   ~~~~~~~~~~~~
>>>
>>> This is a false positive since the code works as intended, but the
>>> warning is otherwise sensible, so slightly rewrite it in order to
>>> not trigger the warning.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Is this and the other rtw89 patch for current release or -next?
>
> Up to you, the warning has existed for a long time at W=1
> level, so the patch applies to current and stable kernels
> as well, but it's not a regression or particularly important.

Ok, I guess -next is more approriate then.

> It would be nice to turn on the warning by default in 6.13
> once the three patches I sent get applied.

It's not certain if driver specific trees make it to v6.13 so should the
patches applied directly to wireless-next?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

