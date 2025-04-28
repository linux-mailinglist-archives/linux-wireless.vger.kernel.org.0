Return-Path: <linux-wireless+bounces-22142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F61A9F3D5
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72703B3046
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F3126F469;
	Mon, 28 Apr 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI8RWQVU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7826A1AA
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851971; cv=none; b=rDlFfxrwCkadIpY2s9zMrmMFYoO1r20sUfnWxlawk5F7ohTbl8kcPxX/9OcQkmn+XbokdPDIrLIwIYc89k1c80EZpzE4ipU51ZqMJPilD3u0i1ziC2IPiwYxSoalog8qldt3aVhNfSDanmphjvmQYwmTtnId6lhwpV2NOYYScXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851971; c=relaxed/simple;
	bh=SSxhuHltF1pU7A3iqAs3fGaU/D/oeSWAOQoAO7lB1wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjEjrqGlLY5gJE3Fc6Cvciz0plvaUyuh/mznq6Yu9NQuUHG0SjIKDXSwa3pL1B5usidun6Weu43Fd9DFC0U3inHP6SHnQgcBi+eONHBScS9DqKfYdw90HNSVtvZLp2gcoFYhff8mM1z7sSpuOmp8zWNW1p9pLorIB+lHoG7AXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI8RWQVU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso6149725a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745851968; x=1746456768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkHHzpz+JAc4YPElLbHC8bnOpH0t0OW33hqQ3rGDKGQ=;
        b=LI8RWQVUyU24wB4qkpp+mIPrWgrbDy6QAWt88aSAqJunOOsfoChUlAich7U+YFgQrh
         /Gb62rK6l3vxZlfdpZlrIVWwh7U+K3rm/cipnoqZUl1xS5qJvKqlkD17zdvbfZnFmcXw
         QQ/3s47Vv+Nrv3VdGK+7Av4Gl8YL/L2IWmp8SU7Lj2sv29ugkb38ePV4Qo8Hb42mSOS5
         69vMBMXkADLzP+HV9+bR/yqFx5dWdfIz/jX4pYYQepJdVSsqmNk/7qcSIaGt9Hby0i68
         2G8yVeMkRuzsOfi3YR+UFAUPsGiqvoKGVuXWX/8hiJyr1s4fPZktGnoCpVsioUVXaQIy
         lhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851968; x=1746456768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkHHzpz+JAc4YPElLbHC8bnOpH0t0OW33hqQ3rGDKGQ=;
        b=EW8G1FyNlWMFPJ0T3V76ueoRHc5qAn4PWyNcLovSOTi/7AgzfHkHOzJMcdpAuhhGyp
         KyhclVux6Y/g8DKHw2zTj9nNOH97dGcXgJDVZi9M/XwiLsXmxKpaV8Deg/3QCfofzyTp
         TVtWAcpmkuXE2CUve5u5LoeK8W1agpFQAUM/pxtw19V6oPiUA9ig9Wcfj+/EZ7H+6Vhw
         tbt30630wWQB6gAGBSAzk4LaPvuuV+lZzS3LV94R5JehShqGE4I6k8Bfu8/9+mT8Swyt
         G/SkpdgaHEHjOD5tVFDc662oifHjvY0iJuCNd8DmMIH4ePiezlX2l7h2AK+ENh2c2m0G
         ImWw==
X-Forwarded-Encrypted: i=1; AJvYcCXuITnrhq0wSE461Kjmew9VbkoGa1WTTnkLE3KqQXM02ciFsH/N7A6/2lCfwnEzzWVOnSZA2yoVj21qod+DmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPWSqNpBUsy3bCAyjGXiTp4vep+N5s2avvbhOWYrO+9Z69J1/
	uhE1uvgSoOLcGZEetEp4lGqJ2Tjzxwz3C4QbkRCFQlxWfNo1IGsGEcMz3//+u6tABeUO36SiA5p
	pKRpq610rFumGnSqEQ4eZVCNxdYI=
X-Gm-Gg: ASbGncss1nSLSdh3P+gbhHBskpLdv3tlBKOvXNnoEXArmMLZQsqwyZX73Lvil35y+hM
	lnsGZ9U5JB/1w8KJrtbgtBS09XsF6W4FZYHvgUJpBVgDPzLyCy5nYebKLZ3sRjHx0+H5HS67+FO
	vw0IFcT91/skyQ0afRRSbiwFL3Nt6rZvmzFkdVPg93q50+twUagD2oXHo=
X-Google-Smtp-Source: AGHT+IGZYr6SLrDNZTnVkaKiHVg1djGU6UdZB0HvXscQWZncCyseLSvIQ5XSgQlJmYpRAlxi2qyCXkTFjHFKldSaM2Q=
X-Received: by 2002:a05:6402:4405:b0:5f6:59e5:5c8b with SMTP id
 4fb4d7f45d1cf-5f72257a516mr10495084a12.5.1745851967494; Mon, 28 Apr 2025
 07:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
In-Reply-To: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 28 Apr 2025 15:52:36 +0100
X-Gm-Features: ATxdqUHI3MOlw_BJrxxnx-Uytq9oMoMg32RWU3eW0KBBY4Lf4w_NpTCU-1BpNPo
Message-ID: <CALeDE9MGXiSN=8E+T_ZGOLHsk8DB4iL=hV7ircqqb9=q1xTUYw@mail.gmail.com>
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth
 support for Infineon devices
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Arend,

> The Infineon chips support external authentication in station mode when
> firmware advertises it. The feature that must be present in firmware is
> sae_ext. This has been ported from Infineon repository and makes use of
> the per-vendor framework. It showcases how things can be organized per
> vendor to provide the functionality.
>
> Unfortunately, I have no Infineon device and firmware that makes use of
> external auth. This series was submitted earlier as RFT and it was tested
> successfully by James Prestwood with iwd after adding a fourth patch to
> the series. I would not mind if more testing is done with this series
> like using wpa_supplicant instead of iwd.

So I tried testing this on a RPi4 with the upstream linux-firmware
repo, both on Fedora 42 using NetworkManager on top of iwd or
wpa_supplicant.

Now I think this has  the right firmware but TBH I am not 100% sure
but I get the following listed in the "Supported extended features"
section when I run 'iw phy phy0 info':
* [ SAE_OFFLOAD ]: SAE offload support
* [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support

For reference the firmware version is:
brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Apr 15 2021
03:03:20 version 7.45.234 (4ca95bb CY) FWID 01-996384e2

When I was testing with iwd 3.6 it was actually not repporting WPA3 as
an option against my SSIDs, just WPA2 where with wpa_supplicant 2.11
it reports both.

With NM+iwd in use I get an error and nothing happens, if I set sae
for NM+wpa_supplicant I get a lot of the following in the kernel log
and the connection fails:
[ 1141.846900] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail, reason -52
[ 1141.962815] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail, reason -52
[ 1142.074828] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail, reason -52

I will try and find a couple of other devices with an appropriate
cypress/infineon.

Peter

> Arend van Spriel (3):
>   wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware
>     events
>   wifi: brcmfmac: make per-vendor event map const
>   wifi: brcmfmac: cyw: support external SAE authentication in station
>    de
>
> Ting-Ying Li (1):
>   wifi: brcmfmac: Fix structure size for WPA3 external SAE
>
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  44 ++-
>  .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  25 ++
>  .../broadcom/brcm80211/brcmfmac/common.c      |   1 +
>  .../broadcom/brcm80211/brcmfmac/core.c        |   2 +
>  .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 308 ++++++++++++++++++
>  .../brcm80211/brcmfmac/cyw/fwil_types.h       |  87 +++++
>  .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
>  .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
>  .../broadcom/brcm80211/brcmfmac/fweh.c        |   7 +-
>  .../broadcom/brcm80211/brcmfmac/fweh.h        |   8 +-
>  .../broadcom/brcm80211/brcmfmac/fwvid.h       |  29 ++
>  11 files changed, 495 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>
>
> base-commit: f600832794c91d7021d7337104734246b02a2b86
> --
> 2.43.5
>
>

