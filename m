Return-Path: <linux-wireless+bounces-28038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF1BEB234
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 20:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEAA14EAF21
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DD2F25E6;
	Fri, 17 Oct 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2dKfumm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C481C84BC
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760724064; cv=none; b=h5BCpKY0nsVhD7rMC/Irs7v5q+J00EWEXyYRt/cZjKa/Pf7NaeWOsDnOdvtaNyYTQru48N70e9bszZRh5ze2aO8DSj40PspTabPk2G2c8Jbg5PjrfSZgxRj9jLDx9/8qO/9VvWkXcVuekypBvWp1hJ0JtSaIFhjOSfh4PDLA7BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760724064; c=relaxed/simple;
	bh=l7aLsr3lGwl503/0vFKteyC9mgKn1yeC8RV1DXvNdko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJsmkZfaM+e9/hmlqt6Frwgz3UUizDs0jHJV2rrr1Qdgc6RLZo/SshFcwn8aAnozab8S1B3PGq0S+NBIrhX/c/uSLFkvAFyR4LlJ8wgK4QTjnBzlrpISmfOxNXeKg8Ve3cITXmhsaNHFmArDddXCrtrLgGO/pHF1V/YjOQSU2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2dKfumm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so4221604a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760724061; x=1761328861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlVS/YQvuUI66d8E0zD5tvcwrlr3PI6dGId22I7Pyhg=;
        b=l2dKfummH06pCxaiTL0TTmkA+ujxgaRy6XQ5fWvLRxaYWwBKv/0z7tOBiP07sIqyk+
         5Vh7Fsn39OVyVEmV9sXaIyN5/wvpsDqOQRHNfNyJmosXU/MYEcmboE/5Rp4lxGex443Q
         gkTOSepCIARfSR5EjiqVVT15H6+3+z6gH6FTPpmpaRwGm5lGYoBZffb9WzdfyMb+18Dz
         uVauXa6V1zFM25TmMDf0e4sJZkXZun4NeDHEgFccaz1m0zyqU10W4wMu7EB+sdIbDPIg
         VtGJ+7Y7l+T+gp8qsTALWlFlLdxWs7z7YTElHEadMeA0s2X6/9rOmXrd4kFk6WqjOKwp
         8AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760724061; x=1761328861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlVS/YQvuUI66d8E0zD5tvcwrlr3PI6dGId22I7Pyhg=;
        b=u03uU8KJHu/SxLsArhkS86Dj/1Z3eyQSNDEHd+7mzz94I/D0tHEUcMuq9rvSMwQwr0
         RrwLW9j1W/ej5G78RswUXnXJ5jJyXjQXePulsSZECN1jgi4XFjhtBPPt0ImOdCuPb2FU
         leKXQQWkQT5rbpLCtAcCZDabQptYOvY41w+uN2P4mQGFH8kIhKjXzwjSKi1tvX/UVVMk
         n3t//Wzw6C17eqByn18tC1/OK6hcJ7VXMwSYE3n73Kfl1MsRC2slHYXCAgsT8NWpjnoz
         4S5QVPuMvgDxzSo9SdnNbDkueaCvOuQezcpU70Oasq1XubOVWg5ivVfbCE0VKbKHldZl
         CKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwSPiZ8BH9HUQxABUaKUIUKXudR4Wssu9fGxYkYx8ZGzK5xag/kwqYsnQtmJENSoNwCyDP+NRvKTIoPemhrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVyUTSgkM7tVJjnv9bfAXqa6Od/3Doj+aw7mhfb7zFBkv3s94V
	7qEWXAcX+ab6ZE/mp3c3jcJt6Si6XrUb2o9CdhlsGpXQmLPSsiPeTWrd
X-Gm-Gg: ASbGncvxS24R0XyNDNgqFEOwQnEZbImmb9fcJ5xXO1/DjTpQChF24zE3t0/Tsmzufya
	ucCpWxWYX9Yy/yd7eznQKcwbXTCKuCdbGHHSqGqbQs62EJlhr/4Yhz5nN2LIUMhTn6SNuU0tI4V
	rmYBOL3sv3mRFyiLq2+t98RWT08Y6wz4uQS0xot6glk367OKFbix2xkwPthIl8K86Jf0+LKXP7R
	7hCBPsRUwMJbEukSuixy9q78dSQE1LIrBg+7YePX7SjQT86/y4096xPkvo+lKYqTymdtNgf5CtK
	fVWMcACZGuILaoJYFgrfyGQf+KDD6DFN2qeIt6wxnxxu0Pp2UEFY9Ywhk8Ix3IP8oKAZxecQ6aW
	LP5IqjyO6oqu9RQoG4LmBA6J077ZAMgWxyodbj/WlmtQOTjADhjbYmUjiKjs6UNxY+ayhnHvBIa
	ipEik0qlFAU7bq674+ItAwkkoSLo2ucamynUP7sQ==
X-Google-Smtp-Source: AGHT+IH1KVJ+ui/ZFAQLBIIcPCJ0zajE4Hz1riJD2bNBYJiDVQwg0SYyy8DeHRjdB5rZgfmpvEK4Iw==
X-Received: by 2002:a17:907:7f2a:b0:b3d:c3ee:406b with SMTP id a640c23a62f3a-b6475706d92mr409758166b.61.1760724061223;
        Fri, 17 Oct 2025 11:01:01 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83914d0sm34210466b.21.2025.10.17.11.00.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Oct 2025 11:01:00 -0700 (PDT)
Date: Fri, 17 Oct 2025 20:00:48 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Samuil <samuilsgames@protonmail.com>
Cc: "pkshih@realtek.com" <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: RTW88 USB Wi-Fi Adapter (8822BU) Disconnects and Fails with USB
 Write Errors - Status -71 & -110
Message-ID: <20251017200048.6e748dae.michal.pecio@gmail.com>
In-Reply-To: <7qi-6tBb1frj_rYuHZflT1akP5I6yA2yxTA7Gg8IQBlDIwSqiWx76AFmcirkfHv5VmqQ7CZ4SesZSswoDKzOt3kbgh3MI-4CqEq-RrxHnns=@protonmail.com>
References: <zjR8G0R1ZUFe9h8_ibO-LWc9OOJyMThA9jp9ftYbETLG3IN0cHPvhCAaC9ypGKPbapsbzTH5VqnDhFcX93GkwnG1BEyETplFQmRiGGshBz8=@protonmail.com>
	<20251017005947.54e1944b.michal.pecio@gmail.com>
	<7qi-6tBb1frj_rYuHZflT1akP5I6yA2yxTA7Gg8IQBlDIwSqiWx76AFmcirkfHv5VmqQ7CZ4SesZSswoDKzOt3kbgh3MI-4CqEq-RrxHnns=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 17:25:03 +0000, Samuil wrote:
> > Does it happen every time on every boot?  
> The disconnect happens on every boot although rarely the device is
> able to reconnect again. Usually, however, the adapter just stops
> working until I reboot again.

Well, I had no luck reproducing this on v6.18-rc1.
I left it running overnight with ping traffic ~700KB/s each way.

> > May we know what 'lspci -nn' says about this 0000:02:00.0 controller?  
> 02:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] 400 Series Chipset USB 3.1 xHCI Compliant Host Controller [1022:43d5] (rev 01)

Similar to my B350 chipset.

In some stress tests it showed a HW bug which currently isn't being
worked around by xhci_hcd and I think this bug may be responsible for
at least some of the noise you get, namely this sequence with constant
"event dma" but increasing "TD at":

Event dma 0x0000000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2bd30 - 000000011fd2bd50
Event dma 0x0000000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2bd90 - 000000011fd2bdb0  

It's a broken state which rtw88 can't do anything about. The dynamic
debug I asked for may shed some light on how you got into this state.

Whether fixing this would enable rtw88 to continue is unclear, because
everything likely starts with a "Transaction Error" on endpoint 0. That
could either be a one-off error (harmless if xHCI recoveres from it and
rtw88 retries whatever it wanted to do), or the USB device crashes due
to some traffic pattern unique to your network or whatever.

> Are you using a USB 2 port for the adapter to be working properly
> without configuration?

Nope, I made sure to run it SuperSpeed on my buggy AMD chipset.
This is probably unique to your network traffic or hardware (poor
USB link quality? maybe try other ports.)

Still, I would be curious to see this dynamic debug if possible.

Are you able to compile and run a patched kernel?

Regards,
Michal

