Return-Path: <linux-wireless+bounces-22171-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62222AA014A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C43C3B6A30
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E737126FD8D;
	Tue, 29 Apr 2025 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nw5qGZs3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17481E32D3
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899890; cv=none; b=L//kot+w00xAGzeYTM9d87r1MvrdNN1zjsgOtybHR93z4A5fpbguzverhD9BvSImJNq1wIqrOHi5x1dZDX/eUP4W66MVD/0jksAHGfDyLPIrq/xv0Wrt98L7MSpIE/rPIf+hZGAqukuy6I7ATOWma6q6UdYsQyypkdV1g0IeY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899890; c=relaxed/simple;
	bh=RSSynyWWMiNmVmAxe+aYQd6sf6S8adtU+PQHobclZBI=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=O6Zmbte7fBKVQXBXXIz4+LndmQbwv3uLmkTEAsrakeYFd6GiBEbZfbiLV5MTsYZQhgfUJcWynH3bl+9QQQHqOPIJPq+oVxJA4hCS7WCVJ+vgKBo0kvZjUHhFKkzmAi/wcJAbirZr4ciIRGocpb4YYlMB6GIK20chiQPVLiUrifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nw5qGZs3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227914acd20so55540535ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 21:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745899887; x=1746504687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ynm6W9cGIXy5C+YgiimjZOzxKsvvcgCSl195aNNDZeU=;
        b=Nw5qGZs3KsnGvsDCGKNQrTvRhr9HoRbTQpB0YgeNQoI+otD9hy0rVVVyUAwPepwPEg
         6R1WKEI7mQLiQ8S3gAjdBvQYLUR4gimvWYcuyTv1jFIMxiJXYvNC82eZMpNZf5MgrSH6
         kHqPtQMg1ehyTmal4i/fb1bHgN2Vq8NXpBSvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745899887; x=1746504687;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ynm6W9cGIXy5C+YgiimjZOzxKsvvcgCSl195aNNDZeU=;
        b=YxXc8vlHA99i+nrYpeDL40ZqgShzT9hnTuIHq1E2sPrylaKeloxa03qb+sJgZj+OS0
         D6+yLZoJZoZlnLzEL+PtcRp18rIigChiuCrYHstL4R70oycaV3dVy2R8ZS1OhSOuXjQd
         K/MP3WYbaMgpPTDsx9cHKnanA3gXjs+/MJCzOPXgszr9cGkFJebcMYNBxhIFIflcntvr
         BH0hmjn1tdIOPc2B5fq/LhA4OHUfftEKrNrjCP8qhn+FsKG9ogF1rC0czb0pfm0uX12i
         B3ZQR+Fgv/pO0WWrBeRu3/aNzCexDr8hizOf3QuF9Zn6efUS1MOEOtKpIjQwsUmR5nfR
         p1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8wYSMvdH9QRj7ndtoBJGYgzfcX4suosM/2KS96SbLLo4CoUoYyAWbA6JSDZgAnv4C2WRnyUSnbmMvH21/Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGKXIzBuoUK3XXqd8kcD0jTLEAYFTe9JdMvN01MtUjptw5sPn
	2Q6Pc17IFm8rr3JvphiRJPaIcVDlXJ6v2XlSOxEBwuqgfrwqzMe0mXP2DlUZNoM4Wfm26HqyIWy
	kUw==
X-Gm-Gg: ASbGncssAe9k/wyrw9bwQuO40qJN1d8G2PUuk0GGRTzSgGUj2EKbMjlju8r4bDvGA4n
	vu3gZQC8U0dBUDXp0K2Dj7nAV0mlw170A61nDA9jfDklOqm3IAt/xW522rxqiaMT8mnbDLko9ad
	pLQNh/wxFYo97pTfUSL6uJzj3Xwu+Ev5kRCNZy18vnFYDAU8f+MbAjQUlNSYDPunDo4Dh5qapkG
	r3ohbZIjFiwh61xqR2KP0jRNeDvdj1m0rwoBHpGJDvdfhlNxCgUy6/RwGdWwYzzKTQtQ8cpwhwo
	3dovxrrD0dHiIUPGRHeyKC+z+kpLCmJ+ps4LWP0PsEGc+i9cNsGXlSHTYOkPkyQ1RetMO9vdbpF
	whLo=
X-Google-Smtp-Source: AGHT+IG5u3vXBuCkg8GMcC9HLoKtgr2C4q32Czlilr9TM9eBzvO7g51fTxjxXyTALleWEBLEsjtU6Q==
X-Received: by 2002:a17:902:f551:b0:223:517a:d4ed with SMTP id d9443c01a7336-22de6c1c4e4mr23174255ad.15.1745899887053;
        Mon, 28 Apr 2025 21:11:27 -0700 (PDT)
Received: from [10.229.22.119] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22dc60bd15fsm59826065ad.15.2025.04.28.21.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 21:11:26 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>
Date: Tue, 29 Apr 2025 06:11:16 +0200
Message-ID: <1967fbdeea0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CALeDE9MGXiSN=8E+T_ZGOLHsk8DB4iL=hV7ircqqb9=q1xTUYw@mail.gmail.com>
References: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
 <CALeDE9MGXiSN=8E+T_ZGOLHsk8DB4iL=hV7ircqqb9=q1xTUYw@mail.gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth support for Infineon devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 28, 2025 4:52:48 PM Peter Robinson <pbrobinson@gmail.com> wrote:

> Hi Arend,
>
>> The Infineon chips support external authentication in station mode when
>> firmware advertises it. The feature that must be present in firmware is
>> sae_ext. This has been ported from Infineon repository and makes use of
>> the per-vendor framework. It showcases how things can be organized per
>> vendor to provide the functionality.
>>
>> Unfortunately, I have no Infineon device and firmware that makes use of
>> external auth. This series was submitted earlier as RFT and it was tested
>> successfully by James Prestwood with iwd after adding a fourth patch to
>> the series. I would not mind if more testing is done with this series
>> like using wpa_supplicant instead of iwd.
>
> So I tried testing this on a RPi4 with the upstream linux-firmware
> repo, both on Fedora 42 using NetworkManager on top of iwd or
> wpa_supplicant.
>
> Now I think this has  the right firmware but TBH I am not 100% sure
> but I get the following listed in the "Supported extended features"
> section when I run 'iw phy phy0 info':
> * [ SAE_OFFLOAD ]: SAE offload support
> * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> For reference the firmware version is:
> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Apr 15 2021
> 03:03:20 version 7.45.234 (4ca95bb CY) FWID 01-996384e2
>
> When I was testing with iwd 3.6 it was actually not repporting WPA3 as
> an option against my SSIDs, just WPA2 where with wpa_supplicant 2.11
> it reports both.
>
> With NM+iwd in use I get an error and nothing happens, if I set sae
> for NM+wpa_supplicant I get a lot of the following in the kernel log
> and the connection fails:
> [ 1141.846900] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail, 
> reason -52
> [ 1141.962815] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail, 
> reason -52
> [ 1142.074828] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail, 
> reason -52
>
> I will try and find a couple of other devices with an appropriate
> cypress/infineon.

Thanks for giving the patches a spin. The firmware should have a feature 
named sae_ext. I think the one you with iw are indicating same support in 
general.

You can check the firmware features in debugfs under 
<mount>/ieee80211/phyX/fwcap.

Regards,
Arend
>
>
>> Arend van Spriel (3):
>> wifi: brcmfmac: support per-vendor cfg80211 callbacks and firmware
>> events
>> wifi: brcmfmac: make per-vendor event map const
>> wifi: brcmfmac: cyw: support external SAE authentication in station
>> de
>>
>> Ting-Ying Li (1):
>> wifi: brcmfmac: Fix structure size for WPA3 external SAE
>>
>> .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  44 ++-
>> .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  25 ++
>> .../broadcom/brcm80211/brcmfmac/common.c      |   1 +
>> .../broadcom/brcm80211/brcmfmac/core.c        |   2 +
>> .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 308 ++++++++++++++++++
>> .../brcm80211/brcmfmac/cyw/fwil_types.h       |  87 +++++
>> .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
>> .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
>> .../broadcom/brcm80211/brcmfmac/fweh.c        |   7 +-
>> .../broadcom/brcm80211/brcmfmac/fweh.h        |   8 +-
>> .../broadcom/brcm80211/brcmfmac/fwvid.h       |  29 ++
>> 11 files changed, 495 insertions(+), 23 deletions(-)
>> create mode 100644 
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>
>>
>> base-commit: f600832794c91d7021d7337104734246b02a2b86
>> --
>> 2.43.5




