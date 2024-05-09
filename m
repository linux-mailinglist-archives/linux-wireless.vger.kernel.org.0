Return-Path: <linux-wireless+bounces-7388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8678C0E87
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 12:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652BE1F216B8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403C12F5B3;
	Thu,  9 May 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW8QDMQz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9E12F5B6;
	Thu,  9 May 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251801; cv=none; b=UUMlGD7Mo5AO/4SVPa+8XTtU0e9NjMUpq7tVPdEFzAvpws94aoAae7cmL574rDKrpAxiQ6TzPEkhe5xwqhV48aNLXcbMob0dfARrsh8od+hiGk37cNREN+sLvHV/GmY5ulSCbpkgOKEeKbNpCBgy0KYsHz5JBuawk3Zkw5G+fxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251801; c=relaxed/simple;
	bh=7CvRnCBPNAANZ/EAQgwdIUpC7gkAEaZ0Jw1Hc4eMkF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqIbaeE+uCqnsNUmRT62JuJZhkEM1vhN+el3mlIPbgg+YvrvSbAvypwZ4/i3IT+1BkOTKTcgTinr05zxiW0k+zg9uAPLnEBicLCPnbi79AOdmhaYawsiyuGSNauRh2ofRJwIMu6Htk6VI7K6oXWhHCQdtryMIJhHI8VtXC84msE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW8QDMQz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43ca9047bd2so12770681cf.1;
        Thu, 09 May 2024 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715251798; x=1715856598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oARPexNDmj1khoHU5UUJ+/e8hAcIPtcM6/1dV607u8o=;
        b=YW8QDMQzjS5xX/H0HkdCAYIMcejoGuFdaACtym8sr7Ox6o6qRx4Gyzl4rAlOfRtxS7
         QLaTOfPm7It+OV1H4PpglHuMihrEU21Hp1olJqMtlEmDXClf6g39mFWmTltb4BmW8p2r
         K79IrSI3cj3C07eJ0wFXIyagjyEBmvhQ7naRTHLAcnsOJipq67yzMYjWkzp+BCgb+Sak
         IlElykOGdLJKocepoE90HaZEyhnroDpvpnlOOJEhi9IELqjV1kDix3XpDG0Tqtjya7i6
         j7pyRkI+ZOhAygvZFb7HzBAkmtKnopVRfbnoRaTK294QUiIRX1Yi3Bt/VS6DYX2aTRW9
         euaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251798; x=1715856598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oARPexNDmj1khoHU5UUJ+/e8hAcIPtcM6/1dV607u8o=;
        b=W+BqaQt+BbN0w5KYjUScMLjgXw1/XuMCqTvxT0jTeIDiuv7M31lJgCBVacGQC4lW6n
         3d1v+KdSkRefgngVQn/pkHUKB4Oy0thU8j3T2ysxRpM0JqlMk7oabGGm/cGCAmjXmHKQ
         T2ukZFa5RNmhyvrDz+1pwF+mffDZ/Gbrx/UlyAFJZYNeOmdsxYdsHPThD+baK4dkK+nO
         iUB59ojoe58Q3uybnWJjRC6gOE5Dh273zj52B8oOdCb0cezb4dNkB4P08DlBvzaefNPV
         WqGOISiICtHU39+sy9PeYW4YjR2UtfwBBmMV/sKlnP/pxLKZW3A9vKqVP5nFZJ/pVyfo
         d1NA==
X-Forwarded-Encrypted: i=1; AJvYcCV4lUNNXwCG+56kG3Q9EaxUqmWAUFojL0D0S84xp/0NjfEsia6hEF4XMHAJClsvyYgCgYRXE8ApfE8uQGOJbdI1EQxcV6CUCjNErV1YuF11I0mumr2XHEMIvSOZo4/Hf9bk2VC/qcDm16he1nOfyfi4uS1Zhn+2CZCTmU9/VOg4oKS49tM=
X-Gm-Message-State: AOJu0YxkBFoMqvzpgNmheElrKecufaMIBcN+ipv4YNFXyEi6ps9SiGfg
	j7FVLxRt2OPDbAeBbW/TgE/A88fCANrShI2gKA5puz7CA+Q0VD6xYKYN73OnXD5dnPEkz4x0/xk
	G+Z1zPZ/hpfmdvzqgZqUtoHJvrVo=
X-Google-Smtp-Source: AGHT+IHEY8N13sT4ilOEHsobZzhBvC+nsXAHH48Fiff0u0Q/MGHL0E2GXoMRQbN1GJhCWklJviVE/4YdB5P8xzr9tUA=
X-Received: by 2002:ac8:7dc2:0:b0:439:b523:46e4 with SMTP id
 d75a77b69052e-43dec298527mr28906711cf.32.1715251798283; Thu, 09 May 2024
 03:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjwTyGqcey0HXxTT@archie.me> <12b6ac611c1a44b4eadbb1316636b7268ab66a50.camel@sipsolutions.net>
In-Reply-To: <12b6ac611c1a44b4eadbb1316636b7268ab66a50.camel@sipsolutions.net>
From: =?UTF-8?Q?Jannik_Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
Date: Thu, 9 May 2024 12:49:47 +0200
Message-ID: <CAFqe=z+bnNayKaxEnEFar28Q__yZ9Byaxe3YwtMaBEsASG2VwA@mail.gmail.com>
Subject: Re: Fwd: UBSAN: array-index-out-of-bounds in net/wireless/nl80211.c
 and net/mac80211/scan.c
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Networking <netdev@vger.kernel.org>, 
	Linux Wireless <linux-wireless@vger.kernel.org>, Jouni Malinen <jouni.malinen@atheros.com>, 
	"John W. Linville" <linville@tuxdriver.com>, Kalle Valo <kvalo@kernel.org>, 
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Am Do., 9. Mai 2024 um 10:48 Uhr schrieb Johannes Berg
<johannes@sipsolutions.net>:
> > > [  106.194465] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.8.9/work/linux-6.8/net/wireless/nl80211.c:9203:29
> > > [  106.195063] index 42 is out of range for type 'struct ieee80211_channel *[]'
>
> > > [  106.200924] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.8.9/work/linux-6.8/net/wireless/nl80211.c:9252:5
> > > [  106.200926] index 0 is out of range for type 'struct ieee80211_channel *[]'
>
> At least one of these should be fixed by
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=838c7b8f1f278404d9d684c34a8cb26dc41aaaa1

I can confirm that this fixes both, thanks.
I only looked through torvalds/linux.git, hence I missed this patch. Sorry.

> > > [  106.201036] UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.8.9/work/linux-6.8/net/mac80211/scan.c:364:4
> > > [  106.201037] index 0 is out of range for type 'struct ieee80211_channel *[]'
>
> No idea about that one. Send patches.

Sadly unaffected.

> (Seriously. If you're running with bleeding edge toolchains that pretty
> much nobody has yet, send patches.)

I'm not sure what to make of this - this bug has been around ever
since the code was added, modern toolchains just happen to be one way
to expose it.
Alas, distro people are not kernel devs, so best I can do is report this :(

Cheers
Jannik

