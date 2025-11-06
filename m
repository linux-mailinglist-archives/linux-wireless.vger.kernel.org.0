Return-Path: <linux-wireless+bounces-28665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3213C3AEA6
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 13:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C03A9C07
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8D322774;
	Thu,  6 Nov 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki9kjKhd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B313148C8;
	Thu,  6 Nov 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432663; cv=none; b=eB4u8BjckuAZvieVAQ+c7o/9xFXvtF6Utuav+hDWtF4B6tqKvKd5FNiq5YTy6XmwLMP/uvENlrp39SGf9sdDCl2VrjEDn/DkQyh7BHhhS61mhB6T857jtHU8YFiDxxfxUK8//T8Dt139XInfq/aUbzXVi2Th492zyBByCKMVT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432663; c=relaxed/simple;
	bh=L9wkL960v+AwaaB+ehECTUsByEhNDasiOLsJoxQ/wvI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=LveJwz4Ryn8gzR9Vz07buqwtoXEZGu11LcQzHul8vouEWBgmTYo7CXbpeR6/OyasuOr3XcX7V9znw+rllZolD2tFHugy3TaY2Q4AiGEobbiQh35rf9kWGUKaNUl6H3xK5uA0+VMYu2z91nCuiFFK/DRiflg07HbzfV6k2YHii8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki9kjKhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5AAC4CEFB;
	Thu,  6 Nov 2025 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762432662;
	bh=L9wkL960v+AwaaB+ehECTUsByEhNDasiOLsJoxQ/wvI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ki9kjKhd9kW1BReQrl+U+G6IPL4b1LutnbgG6PznFdObW3A6PbCIKHdY82iWleLCB
	 fCkNn5nUFJzFx3kcY724ftenyssJkwjjKvACwHzt6Wkmg85p43Ra9NKutw4WUKJ9nC
	 6GQXjTaLkO8zTq7MuhErwuHeP006zkvuQQmbRs/702HxjF365yfeTQIfyW03vOmCq6
	 h0zVysW45wH3/Xv+OUbvTRpyK2EbxfeSRbueuOTg9UZTA+aes+zL+/Gwbx8yjV79nm
	 SIhGnHtgyalxz7B1CIZjPoyYCY7ZtHinv7S8ohTEwiYzSPdJG6R2QlExM7QxozQ2BD
	 esEiVnKkxz5sA==
Content-Type: multipart/mixed; boundary="------------yfFh2eqZi5fJa4Nw11aogLnf"
Message-ID: <fe1a6f17-e26e-4414-8880-3f3137470849@kernel.org>
Date: Thu, 6 Nov 2025 13:37:38 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [GIT PULL] wireless-2025-11-05: manual merge
Content-Language: en-GB, fr-BE
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20251105152827.53254-3-johannes@sipsolutions.net>
 <20251105180852.420d2691@kernel.org>
 <11cece9f7e36c12efd732baa5718239b1bf8c950.camel@sipsolutions.net>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <11cece9f7e36c12efd732baa5718239b1bf8c950.camel@sipsolutions.net>

This is a multi-part message in MIME format.
--------------yfFh2eqZi5fJa4Nw11aogLnf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 06/11/2025 10:03, Johannes Berg wrote:
> Unrelated to that: I forgot to mention that there's a conflict now
> between net and net-next, which had been reported before between ath and
> ath-next and then wireless and wireless-next, but it's just a simple
> variable addition overlap:
> 
> https://lore.kernel.org/all/20251030113037.1932c6d2@canb.auug.org.au/

Thank you for the pointer!

Just in case someone else has this conflict, you can use the rr-cache
files from:

 https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/56cf8ff

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------yfFh2eqZi5fJa4Nw11aogLnf
Content-Type: text/x-patch; charset=UTF-8;
 name="cb34617c2d3ea4f78cfc0768bc4c8d1f00754f00.patch"
Content-Disposition: attachment;
 filename="cb34617c2d3ea4f78cfc0768bc4c8d1f00754f00.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsvbWFjLmMKaW5kZXgg
MDM0ODYwMWVjYzUwLGRiMzUxYzkyMjAxOC4uOTMzMzIyNWNlZWYzCi0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsvbWFjLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvYXRoL2F0aDEyay9tYWMuYwpAQEAgLTQ0MjMsNyAtNDIwOSw3ICs0NDA0LDggQEBAIHN0
YXRpYyB2b2lkIGF0aDEya19tYWNfYnNzX2luZm9fY2hhbmdlZAogIHsKICAJc3RydWN0IGF0
aDEya192aWYgKmFodmlmID0gYXJ2aWYtPmFodmlmOwogIAlzdHJ1Y3QgaWVlZTgwMjExX3Zp
ZiAqdmlmID0gYXRoMTJrX2FodmlmX3RvX3ZpZihhaHZpZik7CisgCXN0cnVjdCBpZWVlODAy
MTFfdmlmX2NmZyAqdmlmX2NmZyA9ICZ2aWYtPmNmZzsKICsJc3RydWN0IGF0aDEya19saW5r
X3ZpZiAqdHhfYXJ2aWY7CiAgCXN0cnVjdCBjZmc4MDIxMV9jaGFuX2RlZiBkZWY7CiAgCXUz
MiBwYXJhbV9pZCwgcGFyYW1fdmFsdWU7CiAgCWVudW0gbmw4MDIxMV9iYW5kIGJhbmQ7Cg==


--------------yfFh2eqZi5fJa4Nw11aogLnf--

