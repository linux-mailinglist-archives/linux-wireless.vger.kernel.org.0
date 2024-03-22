Return-Path: <linux-wireless+bounces-5155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E213D886FDA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 16:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826141F222A7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962604F8B1;
	Fri, 22 Mar 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOKMhczC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157A4CE13
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121804; cv=none; b=PA2WGDItZUQVWtJxEvthxtD9cT9QWCdEI40Ers5IkF5u9nMrXEChPXqMgF5e8L4P0dpSV9jWmRsQkDxqbzOWq6CpgpHhfFKmHjAH3h/c7hZn+jNGD9vEMJwLPgtrLhn0wU7HnZyOT60OpTynNZNbPmISkc93jS9TZvWd3RBzAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121804; c=relaxed/simple;
	bh=J/aSPpmjbPQnLCOoOyTK/zYXnklQXxgNdmX2RuWiDmw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JlFNp4ifMkgV3r+FLVMJwzptb8dbn2J/PZ+Ai4RgvmBXq6klKSYdDy7V249dPAnouIUu+CApBqdxARKOf4EQDxcvYs57QU2rE2gly8bkQojIDWvK77Wt2f1iPufUf8ro8K/4/WX8qO2E5Ewti4ylScfLTClYL2dEKzUXe0Sx9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOKMhczC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7A7C433F1;
	Fri, 22 Mar 2024 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711121804;
	bh=J/aSPpmjbPQnLCOoOyTK/zYXnklQXxgNdmX2RuWiDmw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YOKMhczCekgncm6zJwp8C9VoNWhOtPuGAQkwFcaARPfMMtqU5eG/Ux0DH5E+Jh3Yj
	 uvGKCb1RWr1FrAyt5aVFyaF0ecQzFj3bLycAvZPzA4+1drcny/yZI1fvL3IqxFl62d
	 JUmzV2z4J1dQPl3LNdJZ4XxN2zYIcwRizV6TFmiJdt0+0Mog6eW/vUpp/3m3uAE5/a
	 ZfibUQCn96JoOIrrJp4dhdn0mH4/32fv6+Y2Ldqv5DTmQUNRYIkdLdqWkMTt025xWO
	 u/dyld1AznDUkTaghX5HmIwzwxRFlFz/6Un2WRJz9o/3K2bLxO0amevUzpOk4ZutaL
	 NoX7f9M9CMiHw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Konstantin Kletschke <konstantin.kletschke@inside-m2m.de>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: AP mode on RTW88 8821cs
References: <ZfwSM0paZg23iEPS@hephaistos.inside-m2m.de>
	<be67119238e14fa09b3d9dc848d8edd9@realtek.com>
Date: Fri, 22 Mar 2024 17:36:41 +0200
In-Reply-To: <be67119238e14fa09b3d9dc848d8edd9@realtek.com> (Ping-Ke Shih's
	message of "Fri, 22 Mar 2024 00:16:14 +0000")
Message-ID: <87wmpu1do6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> We had similar discussion before [1]. I think Martin will take his time to
> investigate how to enable AP mode on SDIO WiFi cards.
>
> [1] https://lore.kernel.org/linux-wireless/36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in/

If AP mode is broken on SDIO devices it would be user friendly to
disable AP mode support (NL80211_IFTYPE_AP in wiphy->interface_modes) on
SDIO until the issues are fixed. In other words, the driver should only
enable features which work reliably.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

