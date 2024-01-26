Return-Path: <linux-wireless+bounces-2547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEBB83D80B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11421C28C76
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316013FFB;
	Fri, 26 Jan 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGiHmGxe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12312B87;
	Fri, 26 Jan 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263521; cv=none; b=P0u7cpSyHXXtCOFAoWW1zQ5aOhtOCVoJfBu6QnyRZdM2IeHv2jjvVtfeKwSqIYE8V/hsQNJPfldbd+JISv4RBnDgkKLttomFqy9CIGfvBN0W4W3wbp+XGlXNMcEwBQhql98zc2xGoFFVARX7iJamRvtm2F5dNuulYsuiew/6S2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263521; c=relaxed/simple;
	bh=uyP5ZbF0hrbr8WdAOISa8u9+m+tzWtPAP+RP3OpzU+s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mqJOkIEcc76VV47YQBEXAgfmoBYFAHrIxFgGpLjdcaMD1yckzayvZTTx2leYGnuvHEqh4f/X1xJMrvt9J+FJBm9O5xWvICUnIzn67oVDgbLgsD8UfKMupJPjAD+XzZrTL271PxhnkDnAEh2QrJbUDklIaYtw0ZQ5TV+1QhvrWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGiHmGxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6643C433C7;
	Fri, 26 Jan 2024 10:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706263520;
	bh=uyP5ZbF0hrbr8WdAOISa8u9+m+tzWtPAP+RP3OpzU+s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jGiHmGxeK34DIok8m3O6VgzgY393BaePdESRKjqrLRYDN0BWEUJnnHRUnJTP/u9Km
	 jkfmT0HWR0BWUbisnDmDKSyp3llIkKNh/CWob7/+TcC8LRDpY+2wMFsMH5TFSgbaJG
	 2lk5Dwh7ef1VfJxOwZ2uehBOA82J+R5KL9lqb+s2jtQX/n1aF5Yv/Gyap907uhzv7e
	 j/0A2OyXNvUb6Js6tJtWDGbIxiKWDhLdDzgj/5V00GH+mvnZJcLVUOGHuKikqydbS7
	 X8aOYDKUckj77etc8KnUuBN9ROL7oDHrMJmPYMpMutPnKTo3+/j0EHtJDQcu/Hc7Ak
	 B1jSmrTV1pwlA==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  <netdev@vger.kernel.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-01-25
References: <20240125104030.B6CA6C433C7@smtp.kernel.org>
	<20240125165128.7e43a1f3@kernel.org> <87r0i4zl92.fsf@kernel.org>
	<18d447cc0b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date: Fri, 26 Jan 2024 12:05:17 +0200
In-Reply-To: <18d447cc0b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	(Arend Van Spriel's message of "Fri, 26 Jan 2024 07:37:23 +0100")
Message-ID: <877cjwz9ya.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On January 26, 2024 7:01:18 AM Kalle Valo <kvalo@kernel.org> wrote:
>
>> Jakub Kicinski <kuba@kernel.org> writes:
>>
>>> On Thu, 25 Jan 2024 10:40:30 +0000 (UTC) Kalle Valo wrote:
>>>> The first "new features" pull request for v6.9. We have only driver
>>>> changes this time and most of them are for Realtek drivers. Really
>>>> nice to see activity in Broadcom drivers again.
>>>
>>> minor thing for a follow up:
>>>
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c:432:49:
>>> warning: no newline at end of file
>>
>> Oh, sorry about that. Any tips how to detect this?
>
> I thought checkpatch would signal that or is it a sparse warning.

I don't run checkpatch except for ath10k/ath11k/ath12k, too much noise.
I ended up adding this to my script:

for file in $(git ls-tree -r --name-only HEAD drivers/net/wireless/ net/wireless/ net/mac80211/); do if [ "$(tail -c 1 $file | cat -E)" != "$" ]; then echo $file: no newline at end of file; fi; done

> Anyway, I can fix it.

Thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

