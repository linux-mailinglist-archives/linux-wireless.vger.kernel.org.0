Return-Path: <linux-wireless+bounces-8374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868688D6F4F
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAD0282C6C
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5033AD59;
	Sat,  1 Jun 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGcUA2bY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1323846C
	for <linux-wireless@vger.kernel.org>; Sat,  1 Jun 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717236935; cv=none; b=fxa7B6ZCSEoLzRAsvZz6S4E5fzRGyBIf5Z2L+aVK6G3BGEMM6Ywgj/5iY7yfMzFqhG6ktga0XMNOZGlBIJqt+qkfglbu82LfHAjLmkKIBH4a6GSp/xHE+A6s2oJKs4u6Q2Vc7mZ4RBjjeKQ0Vmfrm2UDpFQwua+zRjKG3tpeQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717236935; c=relaxed/simple;
	bh=I+urqZeqP/RJ589i7U6evxXFo+gBeJpw521+t1ZTQew=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TJmnnUhwLMe3TNIrxLlzQGLJKJnlzV7GWKrI7WEZPz6WndEFKAqK8qw8ygDKmQP9vlGZpOBVyYhHOIAzLYm3E3Ffl3YM9QY113VmbjojppC4xQoL+sFeVB1p2hbCXgySfFTJkRc0dmB+12gLEFGlQUlVV1WYQAQmGhI7rJAJArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGcUA2bY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E8BC116B1;
	Sat,  1 Jun 2024 10:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717236935;
	bh=I+urqZeqP/RJ589i7U6evxXFo+gBeJpw521+t1ZTQew=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=kGcUA2bYJkvqrZHmt3Jlntzeon9lvBggQJ0WvVKRqdPD3xqXg1Rsr0iDQJzk/MQwK
	 sxUqJpOJKYQY82hlLfLIjBInOyStMAcIQVMVCmCiasyWO3nqpJ4TKr3J3eKcd0X9Zv
	 4uhnfoOisbuQTlPu/UXcVZJs3om4Fz6lcg0ljNsj1BmdXoAY9U8SJhZxVfY7ZJ0cub
	 gL3EvesW7hVPucik1I4n0ekEvQ3zDHdFKPiM15MOrE7Yq2NvFIVJGNj0Q3wE0PX5fQ
	 J47YcEVX6fYCWpwxjqu2kpTNCWkj3aKwYRtHOSy+pk5h7+fovcgX2vygv7xVjxVcPh
	 nmNlnG1bYv7TQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1fabb8e4-adf3-47ae-8462-8aea963bc2a5@gmail.com>
References: <1fabb8e4-adf3-47ae-8462-8aea963bc2a5@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171723693285.1122510.13353583356130532921.kvalo@kernel.org>
Date: Sat,  1 Jun 2024 10:15:34 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Since commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx
> drivers") ieee80211_hw_config() is no longer called with changed = ~0.
> rtlwifi relied on ~0 in order to ignore the default retry limits of
> 4/7, preferring 48/48 in station mode and 7/7 in AP/IBSS.
> 
> RTL8192DU has a lot of packet loss with the default limits from
> mac80211. Fix it by ignoring IEEE80211_CONF_CHANGE_RETRY_LIMITS
> completely, because it's the simplest solution.
> 
> Link: https://lore.kernel.org/linux-wireless/cedd13d7691f4692b2a2fa5a24d44a22@realtek.com/
> Cc: stable@vger.kernel.org # 6.9.x
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

819bda58e77b wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1fabb8e4-adf3-47ae-8462-8aea963bc2a5@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


