Return-Path: <linux-wireless+bounces-24348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BDAAE3D9E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 13:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA6C168AB2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB2A2367CC;
	Mon, 23 Jun 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="JdN9xc7T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5238230BF8
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676726; cv=none; b=VVWova2w/N4fvoCIrhyWZjyGHMz1Ueca4omBGic0tPS/f00qgqsM9SEXd37ISUICXuo33N3eQGcQPB8ANkgEL2HHSb0UVaDc2AOqqaXXbihJO36EIBQDeD9CpC+drDCWw6ULCbK71XAt1ScfTJBpDqiJyCm5g/Wc+AL58ks+1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676726; c=relaxed/simple;
	bh=QImPzGlcmZcQre2zha8QJT6YpFNy74m2Gm1IddutGuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApgNLa3vWSSZzw/v/hw5Ue3xugobB0ue/DFONxGzVApCzkZi+2NTT/SwG3FT3nnodOs5cpebDQ0XP7t0kGzoWemyalkZSB8eOxqo461mR8NO1wrXWpVanWTCSu1byg0e4T4kqB1luZonSAHbmPGRsjeTCi1PBkwJ0jQRuc3X2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=JdN9xc7T; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41A0828399E;
	Mon, 23 Jun 2025 13:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1750676722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=r87tb0TbKqg0Xu1Or8rhZ4c8gOQkQkDQ4/ufNe9yZJo=;
	b=JdN9xc7T+fNzuvwXstr/HjHzrmBddKYAWYYpxgNZHqMN9D/HNRaZXIoaqWrWvBKjpmWikF
	nac9sTYDSN8twOArDL0dPVmRCyJYy9q0Oi2HEAZphicR5r6Tl/sDT58BYKmi+OHJHJ0HhF
	T359JTW/dYtFtIF1ozx9WNzQhnbTQcvOY8iR5MhQ7/CWUjt3GorIlSKlvBmik3peLSsXHI
	vgQBr37q3mWirEnxh/e5m1rRC4KE5RXKKKpcOxA2foQBLN1NhkRxp+6vAyxy/vDfaUm4gE
	yCYCTKu0yMQCPNu9A1boNun+jPwIzTYqGwqvX/sgb9QUvjxhB+7VNUGLJHt+Ig==
Message-ID: <eb25ad40-dc61-44b6-9649-5e743d4e8974@cachyos.org>
Date: Mon, 23 Jun 2025 18:05:10 +0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION v6.16-rc3] Commit 83f3ac2848b4 breaks WiFi on Intel
 AX200
To: Johannes Berg <johannes@sipsolutions.net>,
 "Colin King (gmail)" <colin.i.king@gmail.com>,
 miriam.rachel.korenblit@intel.com, regressions@lists.linux.dev
Cc: linux-wireless@vger.kernel.org,
 Yedidya Benshimol <yedidya.ben.shimol@intel.com>
References: <1b3f2387-e27f-4b74-99b7-0596a9331a1e@cachyos.org>
 <61cae2d3-d4a1-4715-8b63-0738e9ad5353@gmail.com>
 <aa5977435ed7de7183ed68e5767bfcc430379df3.camel@sipsolutions.net>
Content-Language: en-US
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <aa5977435ed7de7183ed68e5767bfcc430379df3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 6/23/25 17:05, Johannes Berg wrote:
> This should already be fixed by
> https://lore.kernel.org/r/20250622235542.66160fc997da.Iba487b3addfad95e51c7d5ad79c962be3eab046f@changeid/
> 
> johannes

Indeed this fixes rc3 for me without any reverts. Thanks!

-- 
Regards,
  Eric

