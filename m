Return-Path: <linux-wireless+bounces-12542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9CD96E0D1
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 19:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18661C25438
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252C21A0AFB;
	Thu,  5 Sep 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ku8D5v2h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7419FA8E
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556146; cv=none; b=ZA/LFDQqjWSqVxkKej/gdXkpPZwxpm+zf+f4+J0cd0hfjoF5FMY3KG8WZIPEHYQC2K/e+a25hCP/9bvHwsPa9UgysQV27CPuOLOrM2+BcpYjwLXTy8ILUY3/vOXd6t6wBHt9gomXRW40osJ5ht2oPbZ1wkcBfmM98Lpw/V1bSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556146; c=relaxed/simple;
	bh=pl/XcPdW5xGCe4Xaf6IHJrZowKmeZWKJqDZdnAgDuSA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ikhw7auxfCd8FS3VM8PwO7Nl0z+4vphdLzCV2YVcjNr0bE19XONolx6D17rVT91t2SZitWy9GGMmu8UGWff8wk5OLyBWwjeBGZTgRvNgNmNayhCckqMZL89HqkSCGXt1fj8E7hZE6jxEzq1ayex/IjE03LLujHQvumn1CQ11YNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ku8D5v2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8E6C4CEC3;
	Thu,  5 Sep 2024 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725556145;
	bh=pl/XcPdW5xGCe4Xaf6IHJrZowKmeZWKJqDZdnAgDuSA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Ku8D5v2hKxf0HMwFdftuVA4yhOjewDGtqnPoGsHFcmcV9VXUI32CvnYUEpXdf9JB6
	 XrUUV1J40SDumoTvhmVusbHUhAPWRkaiIvAp/CRZnLP63O3A0hw1oeRtH2AmXNx6Ky
	 Mid5tGoLFgcw01qG7dRA9rJDIpbHT9ACeSRkCFV0r4+NIM6aW2NA+uZPikc0Oz8Xul
	 hkxmhz7oAGWQsmJwej7sgtinBmqz5FJUYFLcITUerrChsZEaSvXqIShOObZ9B8VHuh
	 ePOXY9J7KEBkHX/UUrv3/Hi3kagAjQIJSPdJyPi7ScWVQZ0d7Hyzw4BXEdPAEdSNQZ
	 oX1oaKQHjN5og==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] wifi: ath12k: cleanup unneeded labels
References: <20240821153728.2121600-1-kvalo@kernel.org>
	<20240821153728.2121600-3-kvalo@kernel.org>
	<1605f1b7d2267444370af84c37a3856f6b158c71.camel@sipsolutions.net>
Date: Thu, 05 Sep 2024 20:09:02 +0300
In-Reply-To: <1605f1b7d2267444370af84c37a3856f6b158c71.camel@sipsolutions.net>
	(Johannes Berg's message of "Wed, 21 Aug 2024 19:20:05 +0200")
Message-ID: <87cylihvtd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2024-08-21 at 18:37 +0300, Kalle Valo wrote:
>> 
>>  	/* TODO: Recalc radar detection */
>> -
>> -unlock:
>>  }
>
> I guess this is the sparse warning, but I think this is an error at
> least in clang without removing the label or putting a ; after the
> label, so you might want to fix it in the same patch.

Good point, clang gives two warnings on patch 1:

drivers/net/wireless/ath/ath12k/mac.c:7560:1: warning: label at end of compound statement is a C23 extension [-Wc23-drivers/net/wireless/ath/ath12k/mac.c:8376:1: warning: unused label 'exit' [-Wunused-label]

I'll fix these in v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

