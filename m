Return-Path: <linux-wireless+bounces-24574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47700AEA7A8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 22:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0C51C452F2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 20:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774912EF653;
	Thu, 26 Jun 2025 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVvD0fA6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067712ED875;
	Thu, 26 Jun 2025 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968189; cv=none; b=BysDtPgohDzjor9Nrim0dgLGgT/hjME79R2OUWgJbi54F5sf1im+mv/ogPMpkdVPpfYrXVr1Ed1JqN/PtWVbYVFEFzimfx/ydb3UPmSfEQZ91C9NVv2E0aC8zxsXdKHOLqOPL+xhhMD4t7Lo/OWjWFqJNe2fs8VauSBl/nFpD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968189; c=relaxed/simple;
	bh=VjWDw4t3h4cNum7xsPfsK70215WkC5vDDIC0yeyeJOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3X/p+KoeCEEzCe9LBTg5tTmjiWkl9K3bs5ncV1DxJuPzzco5nLtPBNwrQQqDatEZb5lHudBms+NxhMQpfnwGIevMlJuGvB239uUaGqOKlgn+JE3ALd8CC6dVo39Yr1eiYfAgnP/4ABpjDjdTB8n43JIihqGgr+ErWbgIARw8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVvD0fA6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31befde0a0so966399a12.0;
        Thu, 26 Jun 2025 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750968187; x=1751572987; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrm8L66LLcQsHrXXA3l65aniUqeLYIRXTzmknhRNJo0=;
        b=mVvD0fA6GPKXvmr5qnz6pfDDJkDr5eWlH6TmLiW4nnZo70lFwKXcyrEHff9N8oo1GE
         zANxQxwE2x8bYMiuUEeb+7pBXx8VksW5TaYwfFfjDYqKuGF0aHlTFBcunZV7Uo/aNdjy
         jkEQSXPMPK7UTHBkgPNGPdkBX9fF1onadr4qHA724REOJlx7J8A/8rSuoYao0G+aQ/bi
         rRdWddMmAGiaqdKuzpW6ootyCQ8wHfagps5l6t0UIGhcuNAMuDBiOdbgqxQMFFrHrtBb
         7ziZvSqAL0VSMM/UMUmB+tyoW4gyg6fBNbfhpmxsXm6SUZvKhVn1/pPAEp5xuHIakHmS
         35Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968187; x=1751572987;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrm8L66LLcQsHrXXA3l65aniUqeLYIRXTzmknhRNJo0=;
        b=CQfAM3f58Xy2JvyJZcpGOBUZHQg7DFRhRBulOgd8LHLVB5+8UgZa3Bas4diswyIdx4
         PKHJq6TfYLdycDPyugV5iniAe9X0Hy8bjDrEdfwds4XBZlOxNzMKRKPJnXQCyAz9x1Qf
         sqeCflAHO/Tz1RWmhwV52/YQkJI/a/kqiV+ounvctoXzzWpGpLZcUlzlxpDL379AYJ7Z
         9fN/jynIrUc5TBCdxCJZyxS3keixUWUQOchp0QmQ8QTJRCOPD7srKQ5j9G5mKfMIlCgo
         BKWJtZaPF1WrXtkt1o/sISE1SxdKzPWqokwyZgEkGj4A5sP/ZhB3Ix2YC32SNHnO8AFc
         5GdA==
X-Forwarded-Encrypted: i=1; AJvYcCXZDfuQGExDHW/I9oPlXNSj8GFiEZHXx7n6llpiaYEZLF2g4SbW9zInznadd0VTno4dh9DMWorjCV4pNf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3IvL0EcbrSpMFXVxyHMp0ZjNQOrSCovFWb+iTSX34tx+NldI
	0+sGWAbqpBKgSppxJdbuF9YtF10si0Dpe329MbC9eo8MkZU7KlpHcnYw7NaKdQ==
X-Gm-Gg: ASbGnctDQuqPNfmtsHTEwt4lJrD6fLZENLHEYVIxpXG5rwIaha2QAWTq8wRxCXAf/oJ
	S96UbKTtkbxKa3XZizEP9TtLXslL4xeKxvmtpIh6ygdpOxXEjbd6ib9sIc8YXuDijHNCz/TTyW2
	P52PmjOJIHBKfcu9xJKQXDBlYXVkQfFl7PR5hT0HlrC1W3NKjmeGwJ2zMtP30U983FiiMZPQGUe
	VgwAG3MFqU82wDAljoIwkWKJv/j1VynBVZqWp5I2z33P98udAAjwkNRDliomWs/yNEtSmwh/JC2
	WG8IHMkNJe63nnHAQ0GVRZdsNjNflaC7rTHCezNqYo8sOgwCEzuCFe7MjiLvdvmFicEw4vi+G26
	MGb6DXdr+b48=
X-Google-Smtp-Source: AGHT+IHc5rHsF38HSxT6Smu8wkgsJl8VXDgV/uf64g0b0w4qk83tfyuuUvNEVb3dZTnt8SJhaVmpPw==
X-Received: by 2002:a17:90b:2e87:b0:313:287c:74bd with SMTP id 98e67ed59e1d1-318c927f3c9mr435130a91.33.1750968186872;
        Thu, 26 Jun 2025 13:03:06 -0700 (PDT)
Received: from tx3000mach.io (static.220.227.itcsa.net. [190.15.220.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe415416sm4637645ad.187.2025.06.26.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:03:06 -0700 (PDT)
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Date: Thu, 26 Jun 2025 17:02:44 -0300
Message-ID: <22784267.EfDdHjke4D@tx3000mach.io>
In-Reply-To: <0083530d59084b82bebde68a73877568@realtek.com>
References:
 <20250625142541.44795-1-yakoyoku@gmail.com>
 <0083530d59084b82bebde68a73877568@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7861243.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart7861243.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH] wifi: rtl8xxxu: toggle P2P for supported devices
Date: Thu, 26 Jun 2025 17:02:44 -0300
Message-ID: <22784267.EfDdHjke4D@tx3000mach.io>
In-Reply-To: <0083530d59084b82bebde68a73877568@realtek.com>
MIME-Version: 1.0

On Wednesday 25 June 2025 22:27:40 Argentina Standard Time Ping-Ke Shih wrote:
> Martin Rodriguez Reboredo <yakoyoku@gmail.com> wrote:
>> This is a MR to see if rtl8xxxu can be made to support P2P.
> 
> Sorry. What is MR?

Merge request in GitLab's jargon, like PR.

>> Theoretically this should be handled by mac80211 but it seems that
>> drivers may have to take some extra steps depending on which device we
>> are talking about. I know that this patch is so basic that it might be
>> missing some H2C commands or similar for this to work on Realtek chips
>> but I don't have the required knowledge for me to implement it, so if
>> you know a place to read about I'll be glad to hear.
> 
> The commit message looks informal. Just describe why/what patch does.
> If you want to share more information to readers, add information after
> s-o-b with "---".

I admit that it doesn't look as a proper commit message, I'll take it into 
account in the next version of the patch.

> Basically if a WiFi device can support station and AP modes, it can
> also support P2P mode. To work well, it needs to support additional
> P2P PS, such as NoA, which needs some H2C commands or registers to
> achieve. I'm not sure if chips supported by rtl8xxxu have these.

Many of these chips do have them, per some of the alternative drivers for them 
show in their sources. Perhaps in another patch some methods could be added to 
`rtl8xxxu_fileops`.

> [...]
--nextPart7861243.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEoKWxm2R3rrCyIqCZhYg+G2pbUccFAmhdp2QACgkQhYg+G2pb
UcfQRhAAkAE3BWNgSecupi25lZVP+cGJMy6EKx755X1ssV82pRIVgZ1kDRKjBZo+
8Z1/9RnKV4D0Jp2z8caOziQPq7eCb/qkJ45CydWSVnR2tQujO1FIR3h5tHqDS0V+
h++5IZ1mq3E8Df0IoSeEs/7NQHeiJ3DlVkPO7Q+f08ahrnNhQOvfjqfOR0+CEUvU
qbCBYzhejI5Z86e5S7nMNJcLERfnXcA9uqXLGgSoQpLjpaq4/xTFHL6eYUd02kp9
drr/Tiz/9XIKsIZlqdX5RB0p0kCiX3asv0NlPGMrDMPhz3LkYw3gBpCPMj7e0uGS
nqf7qdRNluc9aPQUJMJ/CLmN+g3+302cWOIiC6/r1HZ5M/fRAMTrmMr4fhJocU2U
aNlDXTDQ+J+3EuJnvzbKb3E5ioqJ4w4wBfq3KeCGob/XBYpcvAmdAhui1jmAZ4JM
Q1VsNekBMUtkcKnsHtkA+yoJL+6dxkPTpxVPrDlljdzMuvsJr7qGJzvV+u4cFAl+
fqdN7mXTpkg55XuRc1ooJ9AqeI9Y4BNBVog6Fr6jyGOkVFTKv/ChZBaRWxfDExWC
08ILp+DhCwryiWr24IXW1JtJ1CveUyzDefhmqrzxKEzWj8mfpG1L6STWEtUWLTrL
4qyQiqiK4ipnVxg+mUoUInGsT3JuZ28cbtGkiYSXUth7FnxeeP4=
=G8pN
-----END PGP SIGNATURE-----

--nextPart7861243.EvYhyI6sBW--




