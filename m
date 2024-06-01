Return-Path: <linux-wireless+bounces-8372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965B98D6F46
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 12:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC661C2109F
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B578C75;
	Sat,  1 Jun 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYo6EkAv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2F14EC40;
	Sat,  1 Jun 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717236552; cv=none; b=DIxDFDSnU99jijlM4o294DIBIzT9V6qA+xoiLv4gQytixpOVKDdNP8d96ixvPdVk96JHN9wtuQ3j+UnHFh2a+Kyxw5cWPblcCBXAFSSpBUoIC4Jbla4G1vBKToG+SW3KB8ppFdeLXaK3Nu128TprvNfbGpU9OMrJuzJUevicyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717236552; c=relaxed/simple;
	bh=eg7kSV+oZNUijIr+n8b0PdQe/EUyo6Zlq8g8R/fM6rk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=mfRWN2vc0FAupYmj8tlya30PCowC3JSDbwTgSE7iJmkPYuDWzx5zp/4yZQpo/CQAQ4bSLnQF4razuoEweMbyO+DHIhv+zOedQRHr3cte3DExqzusx9OCSY1FRYW+oPXIBQ4RzWW8/eO6htBvDMSxvyEak3DE917HW4HdR+fxcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYo6EkAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8D1C116B1;
	Sat,  1 Jun 2024 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717236551;
	bh=eg7kSV+oZNUijIr+n8b0PdQe/EUyo6Zlq8g8R/fM6rk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NYo6EkAvZo0JzdwSsvsSMHY2GLZLqVDnuQ6e7WxF6HW0DjhhCYNBtlZr1AJYhfZRV
	 wlII111ot1aUIcc04aO6cUqarzHFyLnxzYAJUIIW2EHngyaC+PJ96Mro7WG/tA7kQt
	 Rt4RyTkOcwBKV8UGugO5ionsNb/pc7OY7wIpABtdxTHm0idw520vQfjJbZWfrOOKu6
	 LOri+nJsX2VAaaSYbbCoQycCCDWT2/zwW2ugQnsraHaGyl1L83vpwfqIQCXAuEuRfX
	 yD3v6zrjJ1BpLMH9aRqWnvHkUKAnu7B8SKyPm+jJuCH4MA6YbKC6UF33cestpSK4ax
	 XTpnELiEv7k/w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: brcm80211: use sizeof(*pointer) instead of
 sizeof(type)
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <AS8PR02MB7237FF1C2E880D1231684D708BF02@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: 
 <AS8PR02MB7237FF1C2E880D1231684D708BF02@AS8PR02MB7237.eurprd02.prod.outlook.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Yajun Deng <yajun.deng@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>, Dmitry Antipov <dmantipov@yandex.ru>,
 Johannes Berg <johannes.berg@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Jonas Gorski <jonas.gorski@gmail.com>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Justin Stitt <justinstitt@google.com>,
 Erick Archer <erick.archer@outlook.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171723654505.1034023.720377583197621246.kvalo@kernel.org>
Date: Sat,  1 Jun 2024 10:09:06 +0000 (UTC)

Erick Archer <erick.archer@outlook.com> wrote:

> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter). This patch has no effect
> on runtime behavior.
> 
> At the same time remove some redundant NULL initializations.
> 
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Patch applied to wireless-next.git, thanks.

dcb77f854ae0 wifi: brcm80211: use sizeof(*pointer) instead of sizeof(type)

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/AS8PR02MB7237FF1C2E880D1231684D708BF02@AS8PR02MB7237.eurprd02.prod.outlook.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


