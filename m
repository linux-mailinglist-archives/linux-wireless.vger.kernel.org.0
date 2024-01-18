Return-Path: <linux-wireless+bounces-2168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7ED83186B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD31D1F2362F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D55423776;
	Thu, 18 Jan 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1XKyw2J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EC2376E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577037; cv=none; b=p0jU8EvbjpGJfG80qUybsEOndwXJr1irTZFYrzeaPiuOBPeM5OORzc0Yi7rsMDAaJoc8biZK2xXRXupqlHb/58Wq8HYFGp/uxHiOb4WzdIUsm0E4nlKJ+2Km+7+g6eRHR8xgF832+F2eevV0PsddBIfLlqIlVaoM5b7ALnZOWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577037; c=relaxed/simple;
	bh=UjkNrVJWwBW5NyHcsXEDtSNW94QNd4Z7Dcs++qehSD0=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=k6i0oblrMv/7BuG9kdlnCdJMsNZHk90/AFuxaWroHEx2pRCGm4htP7/BcDJS16xTaVcYB+MvQsVa5QvrtL0JViitjeFBwALv/lNQI4aN9Okr4//L9a//usvI+Ji5XUPHohyAI0423bxdepaQgra1pO9cIFWaZ7rowJhv1BaALuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1XKyw2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A400C433F1;
	Thu, 18 Jan 2024 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705577036;
	bh=UjkNrVJWwBW5NyHcsXEDtSNW94QNd4Z7Dcs++qehSD0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=n1XKyw2JOFzaCC5+tVb0Ge+AfVokgWbq8pqXO9EdtcaIuNeEdEmx+L2raXqucRyTC
	 n8T5AgepO6q+GI8nyoKG1NRkLXyl2kP7F0WioGeJelAt8deyBR/uH79MCnWouXWY9G
	 Jes2uWUh7vGCaAhdzQpcAVv6wJMdq+ke/i0maMhJLUCjIHTOmNzNLLKQ5JSbhSP8Q/
	 bWpUeThfBFJRkT+lJOFXty/y7Iy5LZqSHIf8Iu2sGdfaEB37Bn/H/0XlsEqRXQWIri
	 Qkn/eoc3n/f0ziMPryNRHicsRk/hpzF27Xt/U9i6eK2ZT8Q74k6bDWJOlJU1E1NKkf
	 l8IL3BZCcbqYQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: brcmsmac: use generic lists to manage timers
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230703162128.154451-1-dmantipov@yandex.ru>
References: <20230703162128.154451-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557703354.2924528.3371510158494003054.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 11:23:55 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Prefer generic lists over ad-hoc quirks to manage
> timers, adjust related code.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This should be tested on a real device.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230703162128.154451-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


