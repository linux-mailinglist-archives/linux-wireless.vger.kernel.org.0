Return-Path: <linux-wireless+bounces-5285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BBA88C814
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EBA1C63770
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C257113C918;
	Tue, 26 Mar 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLYNXiVO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27613C3C4
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468031; cv=none; b=obgcoREd8jh1fuKWWxn/4Zwbjj2RsnwH2hRqitqJq69uiqiUpdgpw8JWK7RxNP61L920Lczxakv5MDy9rjYugTzsVIWLw8h5eOu31AdmyqqoWifUuaFXQPKTH5cQcjorvlM9Y9x6cR7Sl4cJd4DijLg8kAl78avAN/H/UwDRIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468031; c=relaxed/simple;
	bh=OyZlPKOj3qahfAnWOsU+wGY0ohUZKxGwzc5FkzggPy4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=kk2uu0pViIkBbvh8hZD5c+r7pN+kFugo9uambpUoGRUAx/8fGVrK2qQqo4keIGBekgXgA/hkWvFgcNtBLJ+aoubrw73dWWW3Ue1qMm01dzu2ZITmXpe1B64zGKX5zw+pI/nFM5fQtEkPI5Pj4+uXwckvuVsOYN5gmsAhoGXNsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLYNXiVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB44C43390;
	Tue, 26 Mar 2024 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711468030;
	bh=OyZlPKOj3qahfAnWOsU+wGY0ohUZKxGwzc5FkzggPy4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FLYNXiVOxI/WwixPx+qp+JDCefD9Ahdq/pfywPFfwElL3NSv0ZuZ0YzZSSjhwvLKV
	 88kNEe5UKnp+82tP4NLp6mAPeH/hC3fjY3qFUj75nvAX1sLKifaUCTKvY6O1k9c/Hm
	 /M+z/lRCVJPFO0UFlUo0qMQIwDgasEW/f+GZSDk14U1TVruJSl1PCEELr1IYqIEImV
	 25QSPEZHl8Op4R0a4QqFyZsp7M+FagOMcPH7GKpLXOCLGWT0hpbKZNrcZ5K8V+LS8f
	 oAlIuI26kPmbmI8kZ9DoufHryJoAeYMRDZGxQpMCj8ixilj/4kfWrQGI+iFmsP080A
	 CeMZ/j/lWVXSA==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "konstantin.kletschke@inside-m2m.de" <konstantin.kletschke@inside-m2m.de>
Subject: Re: AP mode on RTW88 8821cs
References: <ZfwSM0paZg23iEPS@hephaistos.inside-m2m.de>
	<be67119238e14fa09b3d9dc848d8edd9@realtek.com>
	<87wmpu1do6.fsf@kernel.org>
	<2fcab17428576577cbf47bc9551c44f5bac0ea95.camel@realtek.com>
Date: Tue, 26 Mar 2024 17:47:07 +0200
In-Reply-To: <2fcab17428576577cbf47bc9551c44f5bac0ea95.camel@realtek.com>
	(Ping-Ke Shih's message of "Tue, 26 Mar 2024 01:57:05 +0000")
Message-ID: <87y1a56lms.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Fri, 2024-03-22 at 17:36 +0200, Kalle Valo wrote:
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > We had similar discussion before [1]. I think Martin will take his time to
>> > investigate how to enable AP mode on SDIO WiFi cards.
>> > 
>> > [1]
>> > https://lore.kernel.org/linux-wireless/36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in/
>> 
>> If AP mode is broken on SDIO devices it would be user friendly to
>> disable AP mode support (NL80211_IFTYPE_AP in wiphy->interface_modes) on
>> SDIO until the issues are fixed. In other words, the driver should only
>> enable features which work reliably.
>> 
>
> I made a patch [1] to set station mode only for SDIO devices.

Very nice, thanks Ping.

> Meanwhile, I would like to remove mesh point support from rtw88
> because I don't have impression that it can work and someone uses
> that.

Yeah, if you are not 100% sure that mesh works then it's better to
remove it from rtw88. If out of some miracle the mesh mode would
actually work, I'm sure someone will then report that to us and we can
add it back to rtw88.

