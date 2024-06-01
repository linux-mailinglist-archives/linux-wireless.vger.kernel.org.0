Return-Path: <linux-wireless+bounces-8377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C16628D725D
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 00:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C031F21429
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 22:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B60AD2D;
	Sat,  1 Jun 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgrxfp8k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83881BC49
	for <linux-wireless@vger.kernel.org>; Sat,  1 Jun 2024 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717279329; cv=none; b=GJ+NbpXeYcfcLWK1jtYr0/+EC11MoYXLxPUx6fnOs7o1wrtaNxnZw+M3pd6Sp9ZJ1m9/mW87SZw7aJ94U/Ke9FnGgBuLPjEfTN+7pXT6emvAw5db8FgK6gS80V5HDqFYv4p2xYdtdyDMssN0RK9CLI8FEg0M8BR+yqG7Ijom49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717279329; c=relaxed/simple;
	bh=881Gl67gYGPSZRdsWsMnd8CO1Kr/juX5trdTpIVP9Dc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lRiZLZJSczUpnOcI220Ur5cXVhX0Favx2C6Mf0wmlWgYOIvMXestfFNGhnhpDAb4NIJ6NvgjJ1xfd2b+iD3/YSTm0aWni6rThNlfSs+Dp2XbAHOn0CJC6Q8bM2299YA15wfCV36qExLcDDjtPk0nZw+jHm+go21KPxab8Gappf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgrxfp8k; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-dfa7ab78ef2so1630743276.0
        for <linux-wireless@vger.kernel.org>; Sat, 01 Jun 2024 15:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717279327; x=1717884127; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NKCg4HU0AdmRldiStzq/Zu6HZrlnp0ugTToP8sgSHqY=;
        b=Tgrxfp8k0jFVGIIASPilJva0MRQes3uj96UScpbwfTvnPFvdjg+l14/MXtg1JQzH/9
         HGtjgtnJ47WOnjVB8ASqKVXjF0dFDRldYKeixe/IRR2tp5JQS4iHupgC+kR3KItOiJdC
         Xt7SpfV5/zlcUHoeJyg60lTIkvSgtWBejnFWkGrSAjakR/f3yMWnzdeM/fcXJvi/gWhs
         w8C6ey2opb1zfExy8fL5qk8FBHIH9BDP36UxmgUwRUE/4LgT1M3s4OWfPoWHM6E+n0Y4
         J36crceaYzeV+lNsKhw8fcmhdpe6p4epMcQw7vFEgw+uT6q0fDhYxHM3Gtb6TV4WOunQ
         o6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717279327; x=1717884127;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKCg4HU0AdmRldiStzq/Zu6HZrlnp0ugTToP8sgSHqY=;
        b=pDw9CmW5AaJgKufffSPGmpauG5i16uHvmHK9qC8yMIGaY17gJ8okP2r93BAjJSG3jP
         cGprWq7Ig5U2c0ONa2q2hIPwWyOLLrSS3x119TGjoru9+pFpBbmBPXyuYuuESi7svHAW
         6thyeA1BmVU0+brGLngQioMpboEHkrNwiw4avyZXR/DQDgEauYo1YvZLN0m+vUJiR/PU
         YyoFogTbEMNOKXv+7xkdjqhthtJfM2hWVZAQraXlr/e/4FAGtUnSRfF+WNxfKXtb4Xkr
         HR2HSgfsYRQayXE/z/+QXGvp4D0MC8qEPXF8k/zvrMSReFLYcbXBBszRkbSYI/avIJD2
         DrTg==
X-Gm-Message-State: AOJu0Yz9snlSQI6UXtTK3214WdRKdkkwrEIm0waSH55nhnX+wWPQJ0wM
	VOkGUbFY2icteUrv/dq/3ctNJNZ+XZerrZTBwGVVAaHuefcdYaCb5zh7ADEYPglb4bJl2ANKkGj
	9COtiRXGgM4ZG+S+bLb29ZZqsGEp3WOlZ3kX3nA==
X-Google-Smtp-Source: AGHT+IF/YoLQbHhK46QnE85a0LnslGZoab7h85uBHKmFS6iSTkhl0pi3lgkk16ZC5oEQJsZX7vogojx4SJ9naHJ41JI=
X-Received: by 2002:a25:9ac9:0:b0:df7:8dca:1ef2 with SMTP id
 3f1490d57ef6-dfa73c4c557mr5120361276.34.1717279326526; Sat, 01 Jun 2024
 15:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: devin <maildevinplease@gmail.com>
Date: Sat, 1 Jun 2024 18:01:55 -0400
Message-ID: <CAMY0kPLv-W=cXOzT6MAwu7vWr7GcOLWA0aiygbsuUkOAtMeJzg@mail.gmail.com>
Subject: Realtek RTL8822CE PCIe Frequent Disconnection Issues on Linux
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

over my past 3 linux installations i've used both:
- rtw_8822ce (https://github.com/lwfinger/rtw88/, built locally)
- rtw88_8822ce (built in, still unsure what the difference is)
and experienced frequent to very occasional disconnections and general
instability

ive switched between wpa_supplicant and iwd, changed rtw88's options, etc.

through some messing around with options the only difference i've
noticed is that when disable_msi is used, the interface is online yet
never detects any wifi networks, my options are as follows

- no networks being detected:
  - rtw_pci: `support_bf=Y disable_aspm=Y, disable_msi=Y`
  - rtw_core: `support_bf=Y, disable_lps_deep=Y, debug_mask=0`

- networks working (but being disconnected frequently):
  - rtw_pci: `support_bf=Y disable_aspm=Y, disable_msi=N`
  - rtw_core: `support_bf=Y, disable_lps_deep=Y, debug_mask=0`

at different points i switched kernel versions between
- `6.8.5-301.fc40`
- `6.8.10-300.fc40`
- `6.8.11-300.fc40`
- whatever linux mint was using at the time (iirc 5.x)

using fedora40 workstation kde, linux mint, etc

here's some logs that might give more insight into what the issue is:

[  456.737481] wlp2s0: Connection to AP 10:da:43:96:cd:1d lost
[  458.102204] wlp2s0: 80 MHz not supported, disabling VHT
[  458.304693] wlp2s0: authenticate with 10:da:43:96:cd:1d (local
address=c8:94:02:05:c4:a9)
[  458.367851] wlp2s0: send auth to 10:da:43:96:cd:1d (try 1/3)
[  458.375293] wlp2s0: authenticated
[  458.375666] wlp2s0: associate with 10:da:43:96:cd:1d (try 1/3)
[  458.381633] wlp2s0: RX AssocResp from 10:da:43:96:cd:1d
(capab=0x1411 status=0 aid=12)
[  458.382018] wlp2s0: associated
[  458.458488] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by 10:da:43:96:cd:1d
[  475.619923] wlp2s0: Connection to AP 10:da:43:96:cd:1d lost
[  477.020238] wlp2s0: 80 MHz not supported, disabling VHT
[  477.221723] wlp2s0: authenticate with 10:da:43:96:cd:1d (local
address=c8:94:02:05:c4:a9)
[  477.284976] wlp2s0: send auth to 10:da:43:96:cd:1d (try 1/3)
[  477.292366] wlp2s0: authenticated
[  477.292871] wlp2s0: associate with 10:da:43:96:cd:1d (try 1/3)
[  477.299281] wlp2s0: RX AssocResp from 10:da:43:96:cd:1d
(capab=0x1411 status=0 aid=12)
[  477.299665] wlp2s0: associated
[  477.302567] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by 10:da:43:96:cd:1d

[    4.490323] NET: Registered PF_QIPCRTR protocol family
[    4.728234] alg: No test for hmac(md4) (hmac(md4-generic))
[    4.756452] Generic FE-GE Realtek PHY r8169-0-100:00: attached PHY
driver (mii_bus:phy_addr=r8169-0-100:00, irq=MAC)
[    4.931686] r8169 0000:01:00.0 enp1s0: Link is Down
[    5.306429] usb 1-9: set resolution quirk: cval->res = 384
[    5.306699] usbcore: registered new interface driver snd-usb-audio
[    6.208052] wlp2s0: 80 MHz not supported, disabling VHT
[    6.411522] wlp2s0: authenticate with 10:da:43:96:cd:1d (local
address=c8:94:02:05:c4:a9)
[    6.584173] wlp2s0: send auth to 10:da:43:96:cd:1d (try 1/3)
[    6.587522] wlp2s0: authenticated
[    6.589564] wlp2s0: associate with 10:da:43:96:cd:1d (try 1/3)
[    6.594139] wlp2s0: RX AssocResp from 10:da:43:96:cd:1d
(capab=0x1411 status=0 aid=12)
[    6.594528] wlp2s0: associated
[    6.669503] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by 10:da:43:96:cd:1d
[   12.051662] rfkill: input handler disabled

if it's at all important, my kernel params are here:
`ro rootflags=subvol=root noapic rhgb quiet`
(note: for some odd reason i have to use noapic otherwise my boot
screen will just be stuck on the HP logo)

ps: originally this was a windows desktop that i wiped to install
linux, ive heard its an issue with fastboot which i probably
originally had on before wiping my ssd

if you need any extra info i'm readily available in order to try and solve this,
thanks so much for your help.

