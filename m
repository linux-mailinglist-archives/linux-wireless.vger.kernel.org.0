Return-Path: <linux-wireless+bounces-27997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A027BE5BDF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 01:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC8F44E126D
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 23:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248E2E1F0D;
	Thu, 16 Oct 2025 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLXwDKje"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F268834
	for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655597; cv=none; b=EXgsmHn3Aw8NuGDBrOS9XlCkMuBykgowXuDSO1T5IGDKN97NrE4XfpLMawetMGbilEryl/ON0zpNRWXTuPuQBJzfBy3oGFmUvjvEqDMzw3DQpiXvNSREWAVkCE4s6kc2Lp1osG7A1gPaj2WWV20SuB3l4v27zOrq/dpNjsLHK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655597; c=relaxed/simple;
	bh=9B/RSOJrUeqz+fVCixddece2iAFM+eTqOwGDsUX2TbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gso+SQ44boLMc5x6L7tg7cEPNFxL2X/D21jwA4SDYZ2rphNLjngiKnUEVdwfe8C9sCoABFTMlJfhWp8DcV5uzujhA7pTi92URlSq1FlgqXbNdSTC2g/vW0weR96xHjHrho6O9oJ6d0jCvb2DpHcmo3bpWO0FvQE2DPHCzOK6mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLXwDKje; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3d5088259eso181016466b.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 15:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760655594; x=1761260394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TspyN/fHUM6fwBDOEl68QPaLamhit0nUleG8qg7B+Y=;
        b=YLXwDKjeGkIxywKgZBReAcURCjTkp7H6hffZJYAEUSAGIBUUdko82mOL/mvB1YyhLR
         /TTZKKEJ2U7wilIAWvbzuM37XhT0J9pdVr8jJfftVQaxBsPK8tda4X1mN1GKrA/b10JV
         n1UDWS1KRtqAVA9UGKn3GrdPmRDJWFyPQZhZVcMCOQ1QoJ4vVONjkUpqpLKd5eGBPmCI
         HqOiQQ7meCajcy1A+akHHbbjwKiTeTf+sC9Gqa/oSDqnI2kZdbDKqlS1c5I1bO8AbT1o
         1oJlCu5ZsiuV91kq3N80cHvCrwsfOCBIb1VIGHUIpKhSxLNW1ourB+JgVxRhaHMRnn/i
         Wi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760655594; x=1761260394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TspyN/fHUM6fwBDOEl68QPaLamhit0nUleG8qg7B+Y=;
        b=tNmg4JtYmvNw9duiRScNEI/APEmlKp/dS7pFT1Gct9v4RrffEZeIk6R40MrWT3PcYl
         37FWWDBTkHiL/IfxZZPEdUQ9sUjlVDV3haTMS+IgtCA1lWnMYcuRWiY7vPRnWVbnI8tX
         4gWxACU9beIbrgrnosqZjP2iAHJPZII2OHHl2BzWrsiY8vSPOTyCi7+GKUAMEMjo9Oql
         QSwt067510TVvqIBkimcc3K8CBb3e5Mk6BUDnACHY1/Yi0yWJlYtCwKwGFkF3itY5wSY
         8MbYS92i1vv/Vc5JIZI7+vOrXXstDr4usae8tj4lfCmo+qpS+ZZ9Et5wIw3x212Iqcce
         yOGw==
X-Forwarded-Encrypted: i=1; AJvYcCU0OI04I6MKiEP7+A8MOJK+eksL+m4vtcA21c3KHVgihkU+JlEfNO1xLxmtv/bvBeoTnGUEtdA9cEb9WaggHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCeqbEYGjWoXZqxmPjKYTvuuH499oCG7O83gaEnlOVbcYC8OxC
	pwE/I/VIyx4my7MPog4uQvlsMPig8Bd0eoxFTl8SptZHAV6kRccT937VGTh9TA==
X-Gm-Gg: ASbGnctKr8NSwDZO587QCWtliA6JmGy/S6R+2FO9QTvm7wD3cDkTn4f0m+7E0cqcPa0
	E5GMj2MjTrYR1SupD1je9lr4MDa8WyZbQWpckzDCgMPSfj+fazqPsLzqWo7U42GirxkuOnG/7D7
	1JYBesgEaF0c3s92stq3y6g26fuam+el8HUiaQcJZK+1976Xvtoqx98f05jT1ta3jr/bepWjdyo
	zuwbfKzcXhGkORdEPCHB+rQwG13ZX9HIrtmwndrHrhil0Nfj0XZ+xSafWNvwF1iczqfTHEdsG1t
	eMth1I8x4qo0XI3i2PkfbxUcqo7sPAm3p5oOGErZOoL6vdfVUAvZA+muGX1rBBYe3D0jtkFu5ns
	sWQuZ+26RuJW1IhWnBZnyXG9UgAsvy1dQgPL3hWLmFAj0gg5U1ezB+t99KTgiHn225pNsmHjhux
	8yeR0c69FCEqx8AU0LleZ169Xg7WE=
X-Google-Smtp-Source: AGHT+IEhiM2LTo1wcmZzZYv8f76rmtElenS+YxHeo46CODkVCzRbU8lsZgFJFsaWmUoqJ0AAclRY8A==
X-Received: by 2002:a17:907:86a6:b0:b40:2873:a61a with SMTP id a640c23a62f3a-b6472d5bb62mr156304766b.6.1760655594354;
        Thu, 16 Oct 2025 15:59:54 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965d24asm640515466b.10.2025.10.16.15.59.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Oct 2025 15:59:53 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:59:47 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Samuil <samuilsgames@protonmail.com>
Cc: "pkshih@realtek.com" <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: RTW88 USB Wi-Fi Adapter (8822BU) Disconnects and Fails with USB
 Write Errors - Status -71 & -110
Message-ID: <20251017005947.54e1944b.michal.pecio@gmail.com>
In-Reply-To: <zjR8G0R1ZUFe9h8_ibO-LWc9OOJyMThA9jp9ftYbETLG3IN0cHPvhCAaC9ypGKPbapsbzTH5VqnDhFcX93GkwnG1BEyETplFQmRiGGshBz8=@protonmail.com>
References: <zjR8G0R1ZUFe9h8_ibO-LWc9OOJyMThA9jp9ftYbETLG3IN0cHPvhCAaC9ypGKPbapsbzTH5VqnDhFcX93GkwnG1BEyETplFQmRiGGshBz8=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Adding linux-usb.

On Thu, 16 Oct 2025 21:32:42 +0000, Samuil wrote:
> My TP-Link Archer T4U (AC1300) Wi-FI adapter has not been working
> properly. When I first boot the system, the device is perfectly
> operational. However, after a few minutes it disconnects. In GNOME
> the whole WiFi GUI is bugged after that: It shows that I am still
> connected but I can't turn off the connection or do anything. `iwctl
> station list` also runs indefinitely without ever showing info. It
> seems like iwd and NetworkManager are blocked by the RTW88 driver.
> When I try to turn off my PC in this state, the driver error blocks
> my OS from entirely shutting down until I unplug the WiFi adapter.

Hi,

So you just join a network (or is this step not necessary?), wait a
moment and it fails? Does it happen every time on every boot?

I have one RTL8822BU (0bda:b812) and it seems to be working fine for
over 10 minutes now. I will leave it running 'ping' overnight.

> Kernel version: 6.17.3 (latest stable)
> 
> Most recent kernel version which did not have the bug: 6.11.*

Any chance you could narrow this more? Perhaps your distribution
has old kernel packages for 6.14 or others versions in the middle?

> The Journal shows following error message during boot:
> ```
> Okt 16 22:10:05 batcomputer kernel: rtw88_8822bu 1-4:1.0: write register 0xc4 failed with -71
> Okt 16 22:10:05 batcomputer kernel: usbcore: registered new interface driver rtw88_8822bu
> Okt 16 22:10:06 batcomputer kernel: usb 2-4: new SuperSpeed USB device number 2 using xhci_hcd

I see it too, but maybe it's just the switch to USB 3 mode?

> When my Internet cuts off, these messages pop up:
> ```
> Okt 16 22:11:55 batcomputer kernel: rtw88_8822bu 2-4:1.0: firmware failed to leave lps state
> Okt 16 22:12:04 batcomputer kernel: xhci_hcd 0000:02:00.0: WARN Set TR Deq Ptr cmd failed due to incorrect slot or ep state.

This shouldn't be here, never a good sign.
May we know what 'lspci -nn' says about this 0000:02:00.0 controller?

Could you boot again, run (the first line needs root)

echo 'module xhci_hcd +p' >/proc/dynamic_debug/control
dmesg -W >somefile

wait until it fails again and attach the resulting 'somefile'?

> Okt 16 22:19:04 batcomputer kernel: xhci_hcd 0000:02:00.0: Event dma 0x0000000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2bd30 - 000000011fd2bd50
> Okt 16 22:19:04 batcomputer kernel: xhci_hcd 0000:02:00.0: Event dma 0x0000000105a9e110 for ep 0 status 4 not part of TD at 000000011fd2bd90 - 000000011fd2bdb0

Yep, definitely xHCI screwup.
Starting to suspect that an AMD chipset may be involved?

Regards,
Michal

