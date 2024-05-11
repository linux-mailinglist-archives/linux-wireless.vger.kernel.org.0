Return-Path: <linux-wireless+bounces-7510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC148C33E1
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 23:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113F7B20D6C
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 21:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351C224FA;
	Sat, 11 May 2024 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QAsXepkg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A73A8D8;
	Sat, 11 May 2024 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715464044; cv=none; b=A5D3aTg+bhEWu5jyCnoTKnrvUs08njjuLfbfuP04PIiNnO/WuyYwGaJwDnJvfrx7mEJsq3mzx4393XPdyJ1h+irS8rXWEQKBkjmhtE9Z9UEiXc/31RUrDwo+3rl7Rho/BdIY+JHS+4J+g0IbBsv01wGNGrXIG+jaNOsBc94tH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715464044; c=relaxed/simple;
	bh=XrIw190D2Ru6GLS6Uv81QKXbs3DvnUd1ALwBneTiACw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzsqCzgJEam9xmpTbGipjAzrWmWy+eA2j/D9CEj8rve57D41zKTu8cp5pfMpc+LJime2nhkTcbjH9Tcd7e9WbZj/Bv1YLnmCSIxtU6bkWozZDLVTIFk/JlhIyz9nQE1n86klri8a2qXc8Zgx2OP4Zk3l/tNxTxAX1M2VY159Z/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QAsXepkg; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 5uYesvZngeVUY5uYesPRMx; Sat, 11 May 2024 23:47:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715464033;
	bh=ZhbcaDdA7Fy7VE1PV5H3DrbN6+rvJ8gDiUpw7Uijlp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QAsXepkg/x2QADx7ZZWiLyt/bNOl85WNj+qBeEb/5KgPZj68YGbCAZA6/NzW3d6tZ
	 RZkKaIQ0eNAJTcq30MZXPrOJVr/8hgotpXWB4COZ6xK8VKtUlogTE6DkUi0QJL0w5f
	 vE6gmSMErjIvQitt7Y9cZvy9TFz69xei9PkVTcJRUpBbwL/awlLSAi5c0yM+lqKdK1
	 rozMHGh+q+ch5L6FVE7HDElK2UVKNgv1tqDoXkDF0ERMI6u6rfV8LsPTsEULV0jVWa
	 pFg7JGviM70axuV7EhXLjwguhttqWN0cvTZyydKzBOJjnq7GiWikZ+yZyNR2okvJce
	 jPklDxE6KitSw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 May 2024 23:47:13 +0200
X-ME-IP: 86.243.17.157
Message-ID: <b6042eae-88cd-4f95-88d8-d1812c2930de@wanadoo.fr>
Date: Sat, 11 May 2024 23:47:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib80211: Handle const struct lib80211_crypto_ops in
 lib80211
To: Simon Horman <horms@kernel.org>
Cc: gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, johannes@sipsolutions.net,
 philipp.g.hortmann@gmail.com, tdavies@darkphysics.net,
 garyrookard@fastmail.org, straube.linux@gmail.com,
 linux-staging@lists.linux.dev, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1715443223.git.christophe.jaillet@wanadoo.fr>
 <d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet@wanadoo.fr>
 <20240511203104.GW2347895@kernel.org>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240511203104.GW2347895@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/05/2024 à 22:31, Simon Horman a écrit :
> On Sat, May 11, 2024 at 06:32:38PM +0200, Christophe JAILLET wrote:
>> lib80211_register_crypto_ops() and lib80211_unregister_crypto_ops() don't
>> modify their "struct lib80211_crypto_ops *ops" argument. So, it can be
>> declared as const.
>>
>> Doing so, some adjustments are needed to also constify some date in
>> "struct lib80211_crypt_data", "struct lib80211_crypto_alg" and the
>> return value of lib80211_get_crypto_ops().
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
> 
> Hi Christophe,
> 
> Unfortunately allmodconfig W=1 build on x86_64 with Clang says:
> 
> .../libipw_wx.c:587:6: error: assigning to 'struct lib80211_crypto_ops *' from 'const struct lib80211_crypto_ops *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>   587 |         ops = lib80211_get_crypto_ops(alg);
>       |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> .../libipw_wx.c:590:7: error: assigning to 'struct lib80211_crypto_ops *' from 'const struct lib80211_crypto_ops *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>   590 |                 ops = lib80211_get_crypto_ops(alg);
>       |                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

Hi,

I'll dig more tomorrow, but I don't see this error (with gcc), even with 
W=1.

The following part of the patch is here to avoid the exact compilation 
error that you see.

Strange.

CJ


diff --git a/drivers/staging/rtl8192e/rtllib_wx.c 
b/drivers/staging/rtl8192e/rtllib_wx.c
index fbd4ec824084..c730d921463d 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -474,7 +474,7 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
  	int i, idx;
  	int group_key = 0;
  	const char *alg, *module;
-	struct lib80211_crypto_ops *ops;
+	const struct lib80211_crypto_ops *ops;
  	struct lib80211_crypt_data **crypt;

  	struct rtllib_security sec = {

