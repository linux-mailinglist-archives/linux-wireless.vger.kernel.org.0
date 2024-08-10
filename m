Return-Path: <linux-wireless+bounces-11258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D094DCA6
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 14:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F0F1F21CA3
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82D2941B;
	Sat, 10 Aug 2024 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="p7efLG/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWa69teX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8A14659F
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723291366; cv=none; b=ArQ4E1kuWX1O+GCw91BTRlNG/nNCQ7wO1WGfUaSvCD+4NzREbbOQuB1ZTUQhFJdRBSH1UCamedojyhHAeanQav8NB3ICne3tz94Ce4KJBQEeixWbnTxDgl28Llaovas8eRGG1W6HJJiQdO2q374OfRfM5rRiv1DiHFPQyYOpBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723291366; c=relaxed/simple;
	bh=ewcFOaaA7eOkyb1o2+JVlxh4vny29JDD0okwGcBbjqk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WPkfRp5n5sy2Z6IylPOdz6WRQV5MlDYYTAV41GpJ5Atdxx5uhQkqGOjVWtNwJld0n1GYq8GfsVv53kGEWNoenJHfPgr+T0E33ofHNTkzcbk5NGrVGiBfthXio4bqlIMKZO/nOkHRRagHpnlkOvGSn932sHF+ohYl49bgeoLqmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=p7efLG/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LWa69teX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1E634138FF07;
	Sat, 10 Aug 2024 08:02:43 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Sat, 10 Aug 2024 08:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723291363;
	 x=1723377763; bh=8h9ieN9cxIVLH+pdX49IxmJjIZbHXx6tqiliC8qLifc=; b=
	p7efLG/H4sYSWNnShiTKcTWv0aysOt0gcYxD1Gweup/zZKtqzSz74ee86LaCwtDP
	y+ZHa4mBD5kSYydTMVyhUcxy+qSHtApkOzJa5G/6+ejiEQe+zx8+Gykdqw/2Cm5O
	qcxuLE725C4bvUqK8955N3PT5tt1oQ4zdYJiypPQNx6nXhzrnaGqyKZmaWTBCs28
	XOxXD6oDr42+gQwichlgcZxmUGdrWl5QPF142M1WDIzgmwori++TwbDU3W59UmSJ
	K/RPuixu3yYJrlF0Te+drn3YESABuKStcaxA00y1WhC3HlltMMfBv1R0e6x+zeAG
	wxIbXCm4lyREph8UGd8iow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723291363; x=
	1723377763; bh=8h9ieN9cxIVLH+pdX49IxmJjIZbHXx6tqiliC8qLifc=; b=L
	Wa69teXn1rzc94k9tW+ofhPKUmMmxa07iN5IF6XuxvMs+wqMKt5K88zWBKCxpkLI
	TLM3voCfeQRdUZDCtTe02z9kNE8DrDn2pA8+uijjoW7t6KyF7iyRE4jwoktWr7E8
	sxO44A6i/peR6bHAAKdxjeGZXUx6O+q32wbtkO4boavP8ArwmPpJADcGkN1Plkuv
	wKX1B/yHzMsNqYu6JffAhZ2wuxOHReQXDXu2YPzvHny5faE1KVXNERVj9Nt3L5+X
	815BwKO8wUwO/ag5EMulfn8ejQAwwqgJBXEp7103Nzc8ohVCJYZB8Gl7A3e9fmtI
	en8wuqzTSrOgZqL+EXqgQ==
X-ME-Sender: <xms:4la3ZkJmVnyy_DrlNrnr00ek0SsxB0xb0yzY9oHG06kKRn_XLqIcvA>
    <xme:4la3ZkLydlkzcnaZKzLnJaxBR12lu_iYrkRwo3isPbvp7vligUjYLCBxdkJzKgmNl
    cGefA1wAj6mzA-ial4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeigdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdflrghnnhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqe
    enucggtffrrghtthgvrhhnpeevheetkeehjeffveekjeegtdegffeuvdeileffkeeiteeu
    heffveeftddvveffudenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhfvgguohhrrg
    hprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrrhgvnhgurdhvrghnshhprhhivghlsegs
    rhhorggutghomhdrtghomhdprhgtphhtthhopehvihhnrgihrghkrdihrggurgifrgguse
    gsrhhorggutghomhdrtghomhdprhgtphhtthhopehhohhsthgrpheslhhishhtshdrihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdp
    rhgtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsthdprhgtphhtthhopehlihhnuh
    igqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    seifuddrfhhi
X-ME-Proxy: <xmx:4la3ZkvKhH23NvtvHEnxTyssOzAVf8mWK53Gcw0QLycARl40BXEhDg>
    <xmx:4la3ZhbwUIu7oFUWRjyZjfc9e7MaKJuz0qQ-tGnNU1kC3HvCwYZaxQ>
    <xmx:4la3ZrbBta1idVXeZs0ULcForDR3m9Th7MSDxE1ltT_yrFNafejrfA>
    <xmx:4la3ZtCaGysVVONqc6944YksLbpcHy8QHkSTca0DOz_t7wHnI2JTeA>
    <xmx:41a3Zv6QaR3dLVl9dBSnyxCvzKHtLJntCVuL-U0Bze-QEuZzOA2qf8vR>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4A68C19C0089; Sat, 10 Aug 2024 08:02:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 10 Aug 2024 14:02:20 +0200
From: "Janne Grunau" <j@jannau.net>
To: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
 "Jouni Malinen" <j@w1.fi>
Cc: hostap@lists.infradead.org,
 "Vinayak Yadawad" <vinayak.yadawad@broadcom.com>,
 "Aditya Garg" <gargaditya08@live.com>, "Hector Martin" <marcan@marcan.st>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 asahi@lists.linux.dev
Message-Id: <81485c0a-dbf0-4e07-abb9-22fb8d671839@app.fastmail.com>
In-Reply-To: <1913be30f30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <92fe4dd4-21a4-4559-8441-32ef86672de6@app.fastmail.com>
 <ZrclLHJ63RxnG/B3@w1.fi>
 <d82c88a2-77f7-4308-97fa-c5b4446e2cf5@app.fastmail.com>
 <1913be30f30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Subject: Re: wpa_supplicant 2.11 breaks WPA2-PSK / WPA3-SAE authentication on Linux'
 brcmfmac
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

On Sat, Aug 10, 2024, at 12:43, Arend Van Spriel wrote:
> On August 10, 2024 11:17:56 AM "Janne Grunau" <j@jannau.net> wrote:
>> On Sat, Aug 10, 2024, at 10:30, Jouni Malinen wrote:
>>> On Sun, Aug 04, 2024 at 02:23:56PM +0200, Janne Grunau wrote:
>>
>>>> A revert looks to me like a possible/proper fix. I can send that
>>>> later if no alternative materializes.
>>>
>>> I'm inclined to revert this if it is indeed the case that
>>> NL80211_CMD_PORT_AUTHORIZED is not delivered reliably by the
>>> upstream driver and this commit was tested only with some non-
>>> upstream versions.
>>
>> I intend extend the upstream kernel driver to post
>> NL80211_CMD_PORT_AUTHORIZED after successful connection with
>> authentication offload. I expect that the change will be accepted for
>> the stable kernel. Infineon/Cypress have non-upstream patches for the
>> brcmfmac driver which implement it already.
>
> Do you have a reference to see what they have done?

I was misremembering their implementation. They removed
NL80211_CMD_PORT_AUTHORIZED and instead added "authorized" fields to
struct cfg80211_connect_resp_params and struct cfg80211_roam_info. Those
fields are then used to set NL80211_ATTR_PORT_AUTHORIZED. This is
annotated as reserved and as far as I can see unused in upstream Linux
and hostap. That means the patched Infineon/Cypress driver is broken as
well. Probably not relevant since they patch hostap as well.

Looking at the RTM/v6.1.19-hedorah branch of
https://github.com/Infineon/ifx-wireless-drivers (214 mostly brcmfmac
commits on top of Linux v6.1.19).
1. "nl80211: add authorized flag to CONNECT event"
   https://github.com/Infineon/ifx-wireless-drivers/commit/f7fb21f980b743e319cee406719e18ca0fd6784e
2. "brcmfmac: set authorized flag in CONNECT event for PMK caching"
   https://github.com/Infineon/ifx-wireless-drivers/commit/a665defa7e67b1d5f5735a55643014374e5f53d0

For roaming they do same and revert the NL80211_CMD_PORT_AUTHORIZED
1. "nl80211: add authorized flag back to ROAM event"
   https://github.com/Infineon/ifx-wireless-drivers/commit/d2262fb0a08124153c9549d2cd0e6f9c04d946e9
2. "brcmfmac: set authorized flag in ROAM event for offload FT roaming"
   https://github.com/Infineon/ifx-wireless-drivers/commit/3099d355af9914753927f913b14f62318a33ab55

>> A revert in wpa_supplicant might be still appropriate until exteded
>> kernel drivers are deployed. The wpa_supplicant Fedora package
>> carries the revert as patch:
>> https://src.fedoraproject.org/rpms/wpa_supplicant/c/c2eac195adadd2c48b04f8752cc46b12a351e69
>
> Agree that revert makes most sense here. So what upstream drivers use
> WPA offload. Only brcmsmac and QCA drivers?

It might be only brcmfmac, at least that's the only driver match for
NL80211_EXT_FEATURE_SAE_OFFLOAD / NL80211_EXT_FEATURE_SAE_OFFLOAD_AP

regards,
Janne

