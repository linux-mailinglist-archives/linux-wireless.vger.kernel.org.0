Return-Path: <linux-wireless+bounces-38666-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jVTYB3CaS2pjWQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38666-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:07:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C77103F3
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:07:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OlYlzU9t;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38666-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38666-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C9F3508C8A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C6A41DEC4;
	Mon,  6 Jul 2026 09:57:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D841D4FB
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 09:57:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331833; cv=none; b=f/2QKRq9/Ij8RiYhhZwqZJaE31vWJnZw9QZrzvEaoc4MzXXV9yzf5xd1ryAkNK2TinKI/Nxkk/NLjYUWTwzLFFqm33HBMTbYLcrD2iR6WXcYnSeSIaaaQOQdj5urAEKb9l2c0KujVp1Cl8H5zFTI2GRinUFd+7M/YhIqd1cEBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331833; c=relaxed/simple;
	bh=58dWWAj8u1LIJ3lB1ZQTE5D7qZuasH22UdWojF0RmWY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBc9Qxmy/eEBSXZTZibCWDcFsYWBVcu3K7gl7W+6gno8ERBlqJDqMzLrPGjm6+FxjYIlBK2chpLaSZ0D2Rx4f1J/fYWGeQmcLip796itJmru+R68IunjOSigIzoacXfVYVW1zWqVdU5CI7/fH1q1Sf2dF8IzjVzfkAn7OdqKBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlYlzU9t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3E81F00A3F
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 09:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331829;
	bh=58dWWAj8u1LIJ3lB1ZQTE5D7qZuasH22UdWojF0RmWY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OlYlzU9tGeK98kl2f7sYAYYb0clVQdTxq6OZ3VI5FEEJRpj4ru6WCFrrmUMSw5dkU
	 /rr46zlEvx/gnbfNI3zRhRb0By4JVIrz5LBfKa67usYCi8maYdPv/ATJKLPlkOq8k+
	 uVpIU1CDy6wJGpYaq7C6THXznKO6o5MzN4twYSJc/U/uPzB0IE7alH7s3eTqP8YTHy
	 3Q9+Lr5Cz6pOzVC28sBpdGOWlEz6b4VAgCUVZIuLdgm8a6J0U8xwFIv8z1B0yn+Fkd
	 UTjRUybNdx/PhQlHGzBIlt3cgfQmqJWE2K1WCvjDmnkdrupR6kOlujmvjwcCyqUsCh
	 xDTV6qVxq5CtQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39b2acd2414so14830451fa.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 02:57:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqLj5d5621S1ZGg5unifdpg9VkAlvldKwBFaDCdaWg8Pgxju3IfW/X2Gv+GT9zMd6XhKI5Z0AWOUudRDo2Dgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnoe/Zhx2dXHJ2PDS3uMKuK8y5jRurfGGIA7Qo4YtlRedjbbG6
	jah6CVif3d3LGiQ1Y1WAQDiLx2aVo76h3sgufXQ/n8+qJ7NJwm8w/0zpc8S+aYlk3eTW51weN3d
	oh+uPOrq33tIg2QDGd8WTSuLT3aBezDpxcv94oZp7Ww==
X-Received: by 2002:a05:651c:2124:b0:396:2a9e:d795 with SMTP id
 38308e7fff4ca-39b53b6c9d8mr18573241fa.2.1783331827992; Mon, 06 Jul 2026
 02:57:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 02:57:05 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 02:57:05 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260704-b4-bcm47xx-swnode-v1-3-730d59340237@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704-b4-bcm47xx-swnode-v1-0-730d59340237@gmail.com> <20260704-b4-bcm47xx-swnode-v1-3-730d59340237@gmail.com>
Date: Mon, 6 Jul 2026 02:57:05 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdHyrYvZh0gosXqpWGZsf1nfHL_9e28PT0A9vx=KAqbyA@mail.gmail.com>
X-Gm-Features: AVVi8CcIK_zf7nzweFAMWMMuw9MaoQEBuAM0z7qB142GjvYEHx8vHLhElT5O5ng
Message-ID: <CAMRc=MdHyrYvZh0gosXqpWGZsf1nfHL_9e28PT0A9vx=KAqbyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: BCM47XX: Convert buttons to software nodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Michael Buesch <m@bues.ch>, Hauke Mehrtens <hauke@hauke-m.de>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38666-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,vger.kernel.org,gmail.com,bues.ch,hauke-m.de,alpha.franken.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dmitry.torokhov@gmail.com,m:brgl@kernel.org,m:arnd@arndb.de,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mips@vger.kernel.org,m:zajec5@gmail.com,m:m@bues.ch,m:hauke@hauke-m.de,m:tsbogend@alpha.franken.de,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F7C77103F3

On Sun, 5 Jul 2026 07:25:10 +0200, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> Convert the legacy gpio-keys platform device on BCM47XX boards to
> use software nodes/properties. This allows us to describe the GPIO
> keys and their GPIO bindings using software nodes, so that support
> for platform data can eventually be removed from the gpio-keys
> driver.
>
> Detect the active bus type (BCMA or SSB) and reference the
> corresponding GPIO controller's software node (bcma_gpio_swnode or
> ssb_gpio_swnode) in the button properties.
>
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

