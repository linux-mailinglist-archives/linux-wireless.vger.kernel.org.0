Return-Path: <linux-wireless+bounces-17597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF66DA138C8
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 12:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94E316017E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F319AD48;
	Thu, 16 Jan 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNGO9xGc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A924A7C2
	for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026410; cv=none; b=t4zzrcrbvTQRnkP/a2Vm/gVArLsBgQLWSMFoEPRmDYzXmJcFD+RKXbXuKh6I37E5Jft13n4nTEjQ7nPtpR7Fq8/yy1vgO/n0mw53rJ7/3EeVWU1miLY9irGEm1CsbbQ4eLOb+IpIvL8CwQfnc7ZZnTRXoocknfOvFZ+tV7tX860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026410; c=relaxed/simple;
	bh=IEj348cec9mrFd8D8WOywh2sB05s+NOpFd9KoiSKj98=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=C/vS2coNSmIND2UerickOYOaVqFk63GYtCmjdtf+ahP3zpfP3eUvMj+MWQlOZWVsfw6tpXz8+BZKS//xHLgwPf9QeFVzjPV6ME09USXML2VLhzCsQ6bfzwqjAZpoftgvvUaYUDH59uDR51U+m7dryva2/kz1d9oAe4lybqj7ZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNGO9xGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8844C4CED6;
	Thu, 16 Jan 2025 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737026410;
	bh=IEj348cec9mrFd8D8WOywh2sB05s+NOpFd9KoiSKj98=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MNGO9xGcM8uPJBXXkrQ28uo2Il0NpV/85Z/Ma4ed8oCgZb4ndX46gr33oHQxf9oKc
	 vH3XD/E9bQwE+YW280OtMqSHS5/9BxObeZdOnElrsUS5sn2MBD+9V+Dd79qmHe63b2
	 zTbvBUYaF7YGBUGZQPdkm8BRyQwnHYPTLKPHXnUXEySiWejeGpbiPWeMhL95OXYdX5
	 6Ay0rdxpW8XcANJtups8EmK2j5OtpSNXXkXTkEbzyHvhZ3jx+rJhs+Y5NFHdZM8B+S
	 Etdklrlnfi29+LiFFvwDvaHX9l15oaG8DCvhmkTdtLJtP+wP/O0O6Dhjem7T1oAuT+
	 uBVmTpSscUSPA==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: ath9k: use unsigned long for activity check
 timestamp
References: <20250115171750.259917-1-dmantipov@yandex.ru>
	<20250115171750.259917-2-dmantipov@yandex.ru>
Date: Thu, 16 Jan 2025 13:20:07 +0200
In-Reply-To: <20250115171750.259917-2-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Wed, 15 Jan 2025 20:17:50 +0300")
Message-ID: <87tt9zm2e0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Since 'rx_active_check_time' of 'struct ath_softc' is in jiffies,
> prefer 'unsigned long' over 'u32' to avoid possible truncation in
> 'ath_hw_rx_inactive_check()'. Found with clang's -Wshorten-64-to-32,
> compile tested only.
>
> Fixes: b5f871ab4913 ("wifi: ath9k: Add RX inactivity detection and reset chip when it occurs")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I don't think this should have a Fixes either. Jeff, can you remove
these during commit?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

