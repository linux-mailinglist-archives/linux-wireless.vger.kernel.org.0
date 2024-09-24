Return-Path: <linux-wireless+bounces-13120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C09846D3
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F551C2165A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119D1A76CA;
	Tue, 24 Sep 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtAIDI5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2661A76B7;
	Tue, 24 Sep 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184960; cv=none; b=lT7zVqTj3w75y65sEf8eMUg/xznBQBiqmEV68TjJPcfjrC5cYpaOpPoTNcrHXs35VpAe8ntt4c4+nfYfdo5QTgcwAwD77+ZzsHZUObLtUEtofUmPbVSYZ/nncB+Oeh4zJoJquxnzfxTtBH4AVs6FEtlWNTCHIDWslOKpVG5WTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184960; c=relaxed/simple;
	bh=dinX/iT1Opr1P6MZr6BPvNGWFitPhxJMZayjC+e8NhY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tENvkQOTw9OElXSQ63YumqjxN77rkpA9lqU4NOQzQ3PRxehRMOpycv5IpZEnM//7Ff0OO99mxqMUp+fgnWVSfzngeWVQVDSiW/d0/S6T3j6zGcCjnm0XLxCpBPVK7BZSqASzm/wNwdu6aXFUyf9lsU4WxBYagyDO1cG1CJjFxI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtAIDI5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F059C4CEC4;
	Tue, 24 Sep 2024 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727184959;
	bh=dinX/iT1Opr1P6MZr6BPvNGWFitPhxJMZayjC+e8NhY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gtAIDI5DkHemYKbW7TQQomCeE1xAh2Bc6uuhKV77mmvnItaeSPzgBz9gUVgHgLjBb
	 d6qFUtmJDGwe9upvbSkdz0ci7lpdVnUjDDW75jXc+O91ypsF9nAM7bODEj8nn1T+Md
	 ZVpEhRU6ueiGvQxUSxv84PmfhEveCr08CcVCqUaz2C/Cd43RdPGKn5zaKC2BQedyDY
	 9FR1B0MiSuWpyrZmSDmw8lB2PXK0HSTftqU/oHMf8ciYQxbLk7ODtE7ARKqYEmu3PY
	 Um81wmXiNLoH3nuS4f2nJhDTN7FGHDNT6EQbm1yIRh+FG3Mja27/O/c1Rbepirtv+/
	 luYABbMy2AtqA==
From: Kalle Valo <kvalo@kernel.org>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  "John W . Linville"
 <linville@tuxdriver.com>,  Seth Forshee <sforshee@kernel.org>,
  "Pieter-Paul Giesberts" <pieterpg@broadcom.com>,
  <linux-wireless@vger.kernel.org>,  <brcm80211@lists.linux.dev>,
  <brcm80211-dev-list.pdl@broadcom.com>,
  <linux-trace-kernel@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] brcm80211: BRCM_TRACING should depend on TRACING
References: <81a29b15eaacc1ac1fb421bdace9ac0c3385f40f.1727179742.git.geert@linux-m68k.org>
	<19224165b90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date: Tue, 24 Sep 2024 16:35:55 +0300
In-Reply-To: <19224165b90.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	(Arend Van Spriel's message of "Tue, 24 Sep 2024 14:51:38 +0200")
Message-ID: <874j659nt0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On September 24, 2024 2:09:35 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>
>> When tracing is disabled, there is no point in asking the user about
>> enabling Broadcom wireless device tracing.
>>
>> Fixes: f5c4f10852d42012 ("brcm80211: Allow trace support to be
>> enabled separately from debug")
>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

I'm planning to take this to wireless and I'll add 'wifi:' to the title.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

