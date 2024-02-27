Return-Path: <linux-wireless+bounces-4100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B2869992
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565A51F2C3C7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB09C146E78;
	Tue, 27 Feb 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfdIbFiA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733F1420DA
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045799; cv=none; b=U4SYGQOQlCOldkYcrX3VUCjTbnnYuYHygpRfevqbZdzbD0UZUa6oKoTTl3/2UzXrk+xV4C5eY/A2NNxsyov8ZLH8YBFAeGOFNU2Opx8vx61PYTwRXr38DDppYkz/F6XIIktiF5QIAkzxQgndGgTVOyBxvPqqyVTZu5Qac0GjUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045799; c=relaxed/simple;
	bh=Y3WrbVf+zXjlHmiuaEIPfq4mrsRuxpYZC6+H/cNO4Ag=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=JEcMdY4DS+OuvWkBecqkrlGDtT/rx8FQBJWyHMn6n9coH0DSTOhV1u8K+h7nt6d+IhCd2ITuhTpLQ/gf3u+/ld9VEUgywQhMmB63pLqO6o/hArIEjyk6rPUZSihTc5WL28rl1QN8PylBptqXJiIj9E6J1kUnJZ3y5d9wnIC7KPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfdIbFiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101CAC433C7;
	Tue, 27 Feb 2024 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045799;
	bh=Y3WrbVf+zXjlHmiuaEIPfq4mrsRuxpYZC6+H/cNO4Ag=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=VfdIbFiAbBWTzpYIc+h24iC3LbYDehrrsdAaWewgAx9g2E4Sd2nyARRmDsLEXZW2X
	 Q7FjBx0nwqNE0UchYfoO2KOhgcIUfo6lpguJmiUyIhxWH4bI8PX3HAXsq42jwzz74I
	 Erz0pDPzlvQjBPc7XPvswKXzN2xPKxRYBXaPrSZ2vo/Hp4NNs62l9CWCZZbpgbeeSu
	 qVHAcu2QK3Gsrh3U4PJFKW9c3m819xtHNT7ILtq0tR9TIGu4PbCWK6tuu3IX/5yMhE
	 4JNtIW2At6oaKhJT9s+vIckCtnA4oz2KL3x7Aj5KTvvMEVu3zGtgSyrGgAWObsK9Jg
	 ebjVvy9R4apng==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: brcmfmac: do not pass hidden SSID attribute as value
 directly
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240222122923.46691-1-a@bayrepo.ru>
References: <20240222122923.46691-1-a@bayrepo.ru>
To: Alexey Berezhok <a@bayrepo.ru>
Cc: Arend van Spriel <aspriel@gmail.com>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Alexey Berezhok <a@bayrepo.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170904579603.3524945.4084111690465874956.kvalo@kernel.org>
Date: Tue, 27 Feb 2024 14:56:37 +0000 (UTC)

Alexey Berezhok <a@bayrepo.ru> wrote:

> In brcmf_cfg80211_start_ap() do not assume that NL80211_HIDDEN_SSID_NOT_IN_USE
> is zero but prefer an explicit check instead. Use local variable 'closednet'
> to pass in function call and use for error message.
> 
> Compile tested only. Addition for the commit f20073f50dfd1 ("wifi: brcmfmac: do
> not cast hidden SSID attribute value to boolean").
> 
> Signed-off-by: Alexey Berezhok <a@bayrepo.ru>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

379e5e83f9f9 wifi: brcmfmac: do not pass hidden SSID attribute as value directly

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240222122923.46691-1-a@bayrepo.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


