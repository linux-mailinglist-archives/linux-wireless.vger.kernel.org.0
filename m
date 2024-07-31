Return-Path: <linux-wireless+bounces-10723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49301942959
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788451C21CB7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 08:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0081AAE07;
	Wed, 31 Jul 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDEiaVIy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7718B480
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415156; cv=none; b=pfTZwkj4NFXj6ln8ED55BzJkzLIr5ULMw5BbfsJY5xBNZjsS9uYpoFkLq1N/DgGQ+SgjFRE/FGnAfXz/WpF84Ch3azgawwnkO8bjjp+HQqZJpO68SqqPAYk7hUmM+vDOvKRb+6Z6IPTi3hHzTqDEVx1EMHXxx4FBJvGaRDcesMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415156; c=relaxed/simple;
	bh=jrwQsEAjcjkE/X/RjuSLuXXQWRQkIXg8bt8p9d6WVZ4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lmjsSXhuVDAQmvAI2KaqeoVl5G2LLdkIC8xu2evGdXq9F7lYqscJpoxdM6/knGyQ68RVBNLfiGdL/qqw0UeD0JUa2o+Rk+rPGSAN3rPJ9M8nst6ak1D3wxxg3bymfnq4kCq9PDIW5kXf5Z8FSnWqeO6ToP+MBmr5hmX7fofYpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDEiaVIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1F4C116B1;
	Wed, 31 Jul 2024 08:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722415156;
	bh=jrwQsEAjcjkE/X/RjuSLuXXQWRQkIXg8bt8p9d6WVZ4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FDEiaVIyra0i5uTYdWR3g2LdtMdLk12FCZSlWBDhJ2N5zvHFvbmb4eSCnHyUgB6jX
	 NtbQf6ziAwGnS+5h9AG7jIlO8AmWXrqO5XVHdH3KL6coTWIUfGWfPFtAW1FFFP6Q5s
	 /wi327Q+OZrMoo57NZhd80tqCibma8+t7ZhndoxalaWvXXdpyBbZjUap5sFoMKUbSu
	 /v+ffXqLpKJTRJyyW4juDb1pFMFZ/gT5sLwo4Ma2SkvVwwI622WEC6UGxMZQtzrznm
	 d/r899KeLPSN1hkmR613+CFLX4qfYedY5pWOWrf+iKeY2ghpg8E7lmbzj+jJHZhmMZ
	 a6LYbswmxBdWA==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Zong-Zhe Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH 1/2] wifi: rtw88: select WANT_DEV_COREDUMP
References: <20240718070616.42217-1-pkshih@realtek.com>
	<87sevrkoxb.fsf@kernel.org>
	<5db66445dbd1454ea6c2a6f8fc664725@realtek.com>
Date: Wed, 31 Jul 2024 11:39:13 +0300
In-Reply-To: <5db66445dbd1454ea6c2a6f8fc664725@realtek.com> (Ping-Ke Shih's
	message of "Wed, 31 Jul 2024 00:38:09 +0000")
Message-ID: <87jzh2klam.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Kalle Valo <kvalo@kernel.org> wrote:
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
>> >
>> > We have invoked device coredump when fw crash.
>> > Should select WANT_DEV_COREDUMP by ourselves.
>> >
>> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> Should these two go to wireless tree? If yes, please assign the patches
>> to me on patchwork. But rtw tree is fine for me as well, your call.
>
> For most distro, other drivers select this flag, so not urgent to have these
> two patches. Then they will go via rtw tree. Thanks. 

Makes sense, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

