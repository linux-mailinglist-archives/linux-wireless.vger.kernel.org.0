Return-Path: <linux-wireless+bounces-26429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38435B29B83
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 10:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E033AC1CA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31429B8E1;
	Mon, 18 Aug 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="StsNn0KL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758F27E1AC;
	Mon, 18 Aug 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503956; cv=none; b=MHmZyjjAnX0/vQVUFWKOv8/1F99pPLWgdXSdcO5XUuJFwOJEGQoNn0OHZYM/4Nknbe+Yg05ldMQtb6e/9015SQ7ifj/gzXKqs8EEfporKE/mo0qjZ9qA2mG92kW/jbfu9y2bWA+gY5bR7XTmmqNP6tyMcSXOxndk/P7y5UYOBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503956; c=relaxed/simple;
	bh=G7GLPYAXXPewyEJpqxLZMH5HGAbeR4qKvs0DMD9s6RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jSjEHdTY8caGdfEGrMqEWaBC5O/+8FdmbDYCL2/sd9fRdTBbVp44u87Q9qhCoPW5WzfX0BU9asy/AcjqQTX1Blnq/8FktYZupfh2HJVSzLo2y03ElIGshXPm8MXV32ANXuwqM8y2YMKGvNZfCs837dh11NkwRQrRVVYjFQZLTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=StsNn0KL; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E876443EC;
	Mon, 18 Aug 2025 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755503949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4855sdN2+KJrlv8PL5bGVQa7dNeAQCI6ILg91iVvwQ=;
	b=StsNn0KL+BgMcijXT0d4SLglmaB3Y8znrrmn4xeGLOBgMT/h4wqn6hJTIDjjlMtKQW8ptK
	WIZaosNwu3VAxlCauSBwFQtxsNTTCUrZPkA+GfDEkQhte8p0Ti6eM8wXtE9p5XWcoLwoU0
	rZJp6tRuG+zmuVYFQLMY8bJCp/jeIy7Macal0v5oBtv48Eu34gRvnT1aRdsqrZcBzMzZIL
	1ypv5cIiHGwMqTYH4CdjiaAYtVYGnf8kSojj7oFbVYu6YBVTZ9A7Lr2GhkO+ttiJr/eR0G
	7Ed0IV/5u1e2i1KOm8Wxsik1KRNfrwIrlEBhWIGU0afpJTyjRPE32y7V8O+laQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,  Jeff Johnson <jjohnson@kernel.org>,
  ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS
 DRIVER),  linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCHv2 ath-next] wifi: ath10k: add nvmem support for mac address
In-Reply-To: <20250811203451.3763-1-rosenp@gmail.com> (Rosen Penev's message
	of "Mon, 11 Aug 2025 13:34:51 -0700")
References: <20250811203451.3763-1-rosenp@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 18 Aug 2025 09:59:08 +0200
Message-ID: <87tt2512nn.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheprhhoshgvnhhpsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhjohhhnhhsohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrthhhuddtkheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rosen,

On 11/08/2025 at 13:34:51 -07, Rosen Penev <rosenp@gmail.com> wrote:

> device_get_mac_address is a generic way to get the MAC address which
> lacks NVMEM support, which tends to be used on embedded platforms.
>
> In case device_get_mac_address fails, try of_get_mac_address_nvmem and
> handle EPROBE_DEFER to wait for the nvmem driver to initialize.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: keep device_get_mac_address and use of_get_mac_address_nvmem
>  added Miquel to CC. Maybe he has insight.

LGTM. I guess it is not possible to make this fallback "the default" in
device_get_mac_address()? In this case doing it in your driver seems
fine if it's used on embedded systems with NVMEM cells described to
store MAC addresses.

Cheers,
Miqu=C3=A8l

