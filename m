Return-Path: <linux-wireless+bounces-10885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60A946CAA
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 08:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6024280FA5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54DDDBB;
	Sun,  4 Aug 2024 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="bQkuVREs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d/aas5DN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FAB67F;
	Sun,  4 Aug 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722752406; cv=none; b=QMCe5Bh1iOXG9QJt29XniZ+AwHlj/cbeSzvbDCA+B7CgrG5e1OLrCImoOCFGIwq+Gm4ScjyvE1qqW2XqpfuTWeV98hdLqqXHDC8ENBYpDA8rLsrdrn/+OLxohFxyE0e7AWz9qkLDjAgGfyzgv7gtnQhBEaYXi38lfXBTAbyqcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722752406; c=relaxed/simple;
	bh=IphUcle/YlNZLckVN6EQiXF5A9lLgcQR62DUj0gDKwQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rdmR9IPMWoKZ2Z9g5GSJxmT4SnSec1hhvBS+nhkZnPW0odzkZcsQlMydQJM0zZs0hpGm8x2Q5+B9237t1DNUjVwm0C6Xbm8uTKJI8BVYrl0/ymZzX2js8G9M1Out0km9xkx3KnaPmE1lfu2kklX+9V7F2+PRMOPtsR0IgikdmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=bQkuVREs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d/aas5DN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5AC2B1148189;
	Sun,  4 Aug 2024 02:20:03 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Sun, 04 Aug 2024 02:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722752403;
	 x=1722838803; bh=GYf0ZRVTpBy4ufVAa9+cD5JKJQ1v0Y4QcglHlI7azKU=; b=
	bQkuVREsBaCpznOUsWXhEE0f7Y7nJPkctMjosUGyPyBHLVFXT1KTUEetmeKdAL4B
	yYWgfQ5KJloVHl/zC61iJenSKKtCuWVJJO7tGN60YiCvPOHV0Vka0mlK5VXuKHtp
	lrKnFLPUIW8hF4m8sWjgIbo9VapeNklsnqVeBxiGKnr6icw8hLEj6Nz9a+uhGI6o
	k9AcpPUYe1oN7m/bTo4Wc17iG1gNDpB884TOJh8LBPbYOkPZT66ls0OJwnzXAdS9
	eNP4igPeVsB7vLzY3gOFuQoSr6Dc087X3maAb9pwk50tR+XnO2X0RpudOD7XJQwY
	V9m/ypihrB9dn1XGNXac9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722752403; x=
	1722838803; bh=GYf0ZRVTpBy4ufVAa9+cD5JKJQ1v0Y4QcglHlI7azKU=; b=d
	/aas5DN+2uiWe7yb8XamI7+Xr1afeqYvutiuMWcWgvPYiL+UJqv3waxg1zeNf85v
	Ih8XsOh7m8KogG4MIIwmMXmwsLGyHCLZd1cuM1oqp+rKzA2TnUE5WgQyGg8z+eV+
	KG/57k7j6xoYl/+jNgoZHx9YtRdNd5AeIZoTU4JVvDU5kXoLdn0/7rME7BGQC/fh
	nFMcz3+IG4bNv9CedT6U8cs4Rh58lTw9erFKShgMFvCpA3A7aIMv92OaYLkoeTyE
	/zvus6UPkt4bJNy0Uf/3gZUX1B9iDt5du6XkC5h93divoQVraPO11cTOFLrBK3SL
	OB4rlsTescIwVOZ6A0wLA==
X-ME-Sender: <xms:kh2vZvbANGTozGrOrLUWKZhKfcwxrILbU2wjJ9zmkzrzsQ4adRtvRg>
    <xme:kh2vZuZIkY6k5m9sRMIpIeM8iSRJBS_z4MmM7BtuTw_Ibu9vVsV_xAHotEvypy3C0
    0qIZJAoH4snTD748yk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfgr
    nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepheejtdeffeethfetgefhffejudegheefueejtedvhfeuheevfeekheetfeduffev
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjh
    grnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:kh2vZh8Gw9rKwO1IvFtbEc-C_bLu4ACNdInGVp7KbpWnNHLv17BNqw>
    <xmx:kh2vZlrhACg7iryYSuuBa9OIKmZ76-E1uKClYXk4wwrN-__3TJsFjg>
    <xmx:kh2vZqqTEtqNAFjPwFBZLxM_E_uXXYtluDGGFn-3nWQ0_OE16Oq0sw>
    <xmx:kh2vZrQ3MphM95hj0I2Z6fwdUdbcOGNecq03bhzwUcnGzu_wT0IWrA>
    <xmx:kx2vZnSfVQXLeJglEDJic6jiezUcT-JlIE70Ii-8_NnfUxUnoeIV6CXR>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 97B5219C0069; Sun,  4 Aug 2024 02:20:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 04 Aug 2024 08:19:42 +0200
From: "Janne Grunau" <j@jannau.net>
To: "Aditya Garg" <gargaditya08@live.com>,
 "devnull+j.jannau.net@kernel.org" <devnull+j.jannau.net@kernel.org>
Cc: "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Hector Martin" <marcan@marcan.st>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-Id: <306c3010-a6ac-4f8a-a986-88c1a137ed84@app.fastmail.com>
In-Reply-To: 
 <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: 
 <MA0P287MB021718EE92FC809CB2BB0F82B8BD2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hej,

On Sun, Aug 4, 2024, at 05:10, Aditya Garg wrote:
> Hi
>
> wpa_supplicant 2.11 broke Wi-Fi on T2 Macs as well, but this patch 
> doesn't seem to be fixing Wi-Fi. Instead, it's breaking it even on 
> older 2.10 wpa_supplicant. Tested by a user on bcm4364b2 wifi chip with 
> a WPA2-PSK [AES] network. dmesg output:

On bcm4377, bcm4378 and bcm4388 (chipsets used in M1/M2 macs)
WPA3-SAE and WPA2-PSK still works with Fedora's wpa_supplicant 2.10.
Fedora's package carried SAE offload patches in 2.10.
wpa_supplicant 2.11 still doesn't work with this patch but it prevents a
kernel oops after a disconnect (due to an authentication timeout in the
current broken state) in wpa_supplicant.

I'll continue to debug the wpa_supplicant 2.11

best regards,
Janne

