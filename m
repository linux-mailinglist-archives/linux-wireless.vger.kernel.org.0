Return-Path: <linux-wireless+bounces-1201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CBB81C4AD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 06:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926191F2509A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 05:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D828F5A;
	Fri, 22 Dec 2023 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="awnlBXh+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7BF8F49
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 3AE714258C;
	Fri, 22 Dec 2023 05:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1703223335; bh=YiN02VUZkKD02WXR9CYX/laiBMr7epF1tkBDx0pHJKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=awnlBXh+aXhf1Y/FzwGyYF9TcW23FuWmfFFEJa5V4fi7SSjXjm+lRo9uE0Av6hTqi
	 UOXG2MwzTaXkN9ozIvNTL3x7vsAQYVYzVqc6R006Et7FKdchH3AGkugQWXkV5nT47D
	 DOcPKnjt7XNrPTIMB95LJnsL/B4vAstfbsFamNsnfXugZjTJeJM0RqGy1Zz4OrMWVf
	 hbq+4tIGN/ct5BnZgLk4oBo2llbWCKr8c7Q2QBGbcsjlWW0QLhD2fxEuUYHFGMdHJt
	 6FhV5E2cCWg8my8Q4Dj0lVacJcaE6Rtl+mMFcFSNCeCwc/VP0VAB1rOayo1kmhbOcH
	 zX/tetvR6hqtQ==
Message-ID: <d7ee032e-19ec-4c18-bb22-0ef90d6e89f2@marcan.st>
Date: Fri, 22 Dec 2023 14:35:31 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Content-Language: en-US
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
 =?UTF-8?Q?Pawe=C5=82_Drewniak?= <czajernia@gmail.com>,
 Kalle Valo <kvalo@codeaurora.org>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <20231221140416.223639-1-arend.vanspriel@broadcom.com>
 <bf35467c-bfea-43b6-87d0-c22b99bca1f5@broadcom.com>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <bf35467c-bfea-43b6-87d0-c22b99bca1f5@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/12/21 23:11, Arend van Spriel wrote:
> On 12/21/2023 3:04 PM, Arend van Spriel wrote:
>> From: Hector Martin <marcan@marcan.st>
>>
>> Using the WSEC command instead of sae_password seems to be the supported
>> mechanism on newer firmware, and also how the brcmdhd driver does it.
>>
>> According to user reports [1], the sae_password codepath doesn't actually
>> work on machines with Cypress chips anyway, so no harm in removing it.
>>
>> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
>> patchset [2].
>>
>> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
>> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> 
> Not sure where these signed-off-by entries are coming from. I downloaded 
> the patch from patchwork. Just did not want to tinker on it.

I have no idea either. If they're an unintended artifact then you
probably want to remove them. As far as I can tell only my S-o-b and
Neal's R-b were part of the conversation.

FWIW I always use `b4 am` to download patches, I've never seen it stick
in weird tags.

- Hector

