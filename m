Return-Path: <linux-wireless+bounces-21743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2172A93F51
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 23:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FF1B648F5
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237291DE885;
	Fri, 18 Apr 2025 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQc6iZbN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79A2868B
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745010494; cv=none; b=L8dfkB3LpSD81BjLq5kS8pHqM6YZhxIZVlQWyt9iJoZgt9qc1JXOYD5nCOvz5Jr+NYarE7/cyWRrez7IEkar7wHsll5jCzpGGUnC8r0FmmS8T/8PMDQw+2Hsmy5wr2Ruo2ikEAoNoA7JcHLARP1lyYo4f1pf1QkKbMHb2mdamaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745010494; c=relaxed/simple;
	bh=h1ZvDvbLh1/zB5M0xBq2gUsoJtN+4LXnFBa0XM51dVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz/4NJNW5xFcaAyU+SGZtNLN28lIr/mhKTK7KluhFiCZXGkn7Y2koPhy0Idd7MI02EvdSxj6cQbeLEyutYUUZCr0xoauN0j7a3NWEeEvvU3zXKS3jb8r+ZIbPYeSHnFStOFld/fIRNXSbj+nUd54T8xdIBljLoFzSG8Tz+psvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQc6iZbN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54d6f933152so1032872e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745010490; x=1745615290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqMrpwlT9xTbWlCH/AJ97dvTLlSeaEHZ4Ra1VNGrdWY=;
        b=UQc6iZbNAy+yt9EwSYs5y7FMhmJBrk73f6l11ckYOp3VXyahdEfG1Z6xZXp7xf1ZOw
         9q48pSigUvRhziGdXBhCEcfRLE1rvh6sxtQRHnOJEIRS3HRIT738UrxEFKzwaO/qvVZi
         VzJvANrGZXxBbczPevP8KRwNnCzPrFM8WbOCY07WynB33TAp/irGqYmtc+GHndVWPr1O
         X//eBsejS4L+8UkGmnKyK8gXHdNsenhznHJddAhO/2AU+t0fhDqjnqZcWQxa+jTXl2eN
         wEYmUzD6TXpBhLv35j1yeXFBRFxitSQkdSWO0TI7dGEbeCGgzk3ekhgF3JKHuLdpI5e4
         xiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745010490; x=1745615290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqMrpwlT9xTbWlCH/AJ97dvTLlSeaEHZ4Ra1VNGrdWY=;
        b=Ktb3Kf8T3t50l3Ml4YdQ5FTrR8uxU3VPitkoXB3f1A2VKYaUBXH56512gzzJHkyKDe
         n2bToHaMd2KkDYINlvXxQS+dOasbjkrRufTeswmAVhFlKdp14exiBXuzL7jngSfzn+NP
         qqOySjBNa8OkAMrPe5uqxfQk5GKEE6d7p3QNbaocLrALLNAlXs1gAqede9Nw5aKQoYQW
         dIDiAaraxHs/BF7gKAp/PqHyPgnQr9PlTbbTJ3lhdFQXgZFYxuWss5KbTJSVJBXEQbte
         92gEitPvapZaOh/rmIauQUYvkXN9FrqGt6aJdOBQJpxL88C5gV8BCUWVcDWA2uADWK0j
         LCsw==
X-Gm-Message-State: AOJu0YyFFQifmPn76DxCeBpswXTG2/nvyy5KZ9E4hhaplOta9Cd4ZiLD
	/N5KbQ9skT/5YjDYRQGKtOuVyTGm4E7LGGMhAmGKYBoXWPLShhfWJwPC1AS1CZI8rfelELISRTR
	WktV97hTWYplassgRAEqgrV1/9xlTB1GQvkU=
X-Gm-Gg: ASbGncvHmWGn3t1ADypgA0xpLq4kGB8TZ//9x1qsO4HQcTJAqq8gDLAC8Tfyjc7iU9Y
	BxeSsdHj/nBiA0Xs+ED5ohn717kzJaKi9GmnCdFd9kkyUtZUHm2f1XtSx+q7GfXqC4cenwGjndu
	JF6wOOywXnZK56T6Kjlictvg==
X-Google-Smtp-Source: AGHT+IE0bzICO4ZvyXsAczpNRZSXmhJAATOo3s5AAmZIse6aMG6IiAifNUE/8GBC1WHkOmRIqv7t+fK/QVLNcxmGgJU=
X-Received: by 2002:a05:6512:3d9f:b0:54a:ca65:7dbe with SMTP id
 2adb3069b0e04-54d6e61d68dmr1207759e87.11.1745010489821; Fri, 18 Apr 2025
 14:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM1C61G96L+5jYxJ+-JzV0sF0fHd_pLdg7yP9VdTwKCLBG8FHA@mail.gmail.com>
 <8ac287c1-ee37-452f-8247-8e30eff4b1cf@candelatech.com>
In-Reply-To: <8ac287c1-ee37-452f-8247-8e30eff4b1cf@candelatech.com>
From: Nicholas Popovic <nickpop.development@gmail.com>
Date: Fri, 18 Apr 2025 17:07:58 -0400
X-Gm-Features: ATxdqUEXgh2uI4XyDuSkpXIMrOd-0_MyYvYihCJtMmsT0Qs8qZ612cT7sXT4pLY
Message-ID: <CAM1C61HBXNAAgWSCMfg9KaSVZTQDB4v2zw-Qxp4KzWn00yE1vw@mail.gmail.com>
Subject: Re: [BUG] mt7921e: Missing PCI ID 14c3:7902 for AzureWave device [1a3b:6040]
To: Alex Gavin <alex.gavin@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for the quick reply, and for checking the driver source code ..
I'm not an expert here either so I'll keep this posted in case
something was overlooked.

So based on the specific device tables in pci.c and usb.c, to me it
looks like there is missing entry for the `14c3:7902` device ID in the
`mt7921_pci_device_table` array within pci.c.
Based on the existing entries in that table, would the correct fix
likely involve adding a line similar to this?

```
{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7902), .driver_data =3D
(kernel_ulong_t)MT7921_FIRMWARE_WM },
```

(Assuming the MT7921 firmware/driver data is appropriate for the 7902
device ID, similar to the 7961 ID also listed).
Let me know if there's any further information I can provide or if
there might be a patch to test in the future.

Regards,
Nick Popovic

On Fri, Apr 18, 2025 at 4:37=E2=80=AFPM Alex Gavin <alex.gavin@candelatech.=
com> wrote:
>
> On 2025-04-18 1:18 p.m., Nicholas Popovic wrote:
> > Hello Linux Wireless developers,
> >
> > This is my first time sending a bug and I did my best to follow best
> > practices - please advise in the event that I haven't.
> >
> > -----------------------
> > Issue Description
> > -----------------------
> > I have a WiFi card based on the MediaTek MT7921 (Device ID 7902)
> > chipset which is not being recognized by the `mt7921e` driver on
> > recent Arch Linux kernels.
> >
> > **Hardware Information:**
> >
> > Output of `lspci -nnk -d 14c3:7902`:
> >
> > 08:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7902]
> >          Subsystem: AzureWave Device [1a3b:6040]
> >          Kernel modules: mt7921e
>
> Reaching out to point you towards a couple areas of the mt7921e driver
> which show supported devices, in case you were not already aware.
>
> PCIe devices are located here [1] and USB devices here [2].
> In neither case do I see the AzureWave vendor ID matching your
> radio.
>
> I'm not an expert here, though, so I may be mistaken.
>
> > (Note: `lspci -k` shows no "Kernel driver in use" for this device).
> >
> > **System Information:**
> >
> > * Distribution: Arch Linux (kept up-to-date with `pacman -Syu`)
> > * Kernels Tested (where issue occurs):
> >      * `6.14.2-arch1-1` (Standard Arch kernel)
> >      * `6.12.23-1-lts` (Arch LTS kernel)
> >
> > **Problem Description:**
> >
> > The WiFi card is detected by `lspci`, but no driver is automatically
> > loaded. The `mt7921e` module exists on the system, but does not appear
> > to claim the device, likely due to a missing PCI ID alias.
> >
> > **Diagnostics:**
> >
> > 1.  `lspci -k` output for the device shows no "Kernel driver in use".
> > 2.  Checking the module information on both tested kernels confirms
> > the specific PCI ID is missing from the aliases:
> >      ```bash
> >      # modinfo mt7921e | grep 7902
> >      (This command returns no output)
> >      ```
> > 3.  `ip link` does not show any `wlanX` interface.
> > 4.  Manually loading the module (`sudo modprobe mt7921e`) does not
> > result in the interface appearing, and `dmesg` shows no specific
> > errors or probing messages from `mt7921e` related to this device
> > (08:00.0).
> > 5.  A search of a local kernel git repository log (using `git log
> > -S'7902' -- drivers/net/wireless/mediatek/mt76/mt7921/` and `--grep`)
> > did not reveal any obvious commits adding support for this specific
> > PCI ID (`14c3:7902`).
> >
> > **Expected Behavior:**
> >
> > The `mt7921e` driver should recognize the `14c3:7902` PCI ID (with
> > subsystem `1a3b:6040`), bind to the device, and create a functional
> > `wlanX` network interface.
> >
> > Could support for this specific PCI ID (`14c3:7902`, Subsystem
> > `1a3b:6040`) be added to the `mt7921e` driver? Please let me know if
> > any further information or testing is required.
> >
> > Thank you for your time and work on the Linux kernel.
> >
> > Best regards,
> > Nick Popovic
> >
> [1] https://github.com/torvalds/linux/blob/84aca3ca6a42dade09d05a541c8aaa=
b5ea228087/drivers/net/wireless/mediatek/mt76/mt7921/pci.c#L16
> [2] https://github.com/torvalds/linux/blob/84aca3ca6a42dade09d05a541c8aaa=
b5ea228087/drivers/net/wireless/mediatek/mt76/mt7921/usb.c#L15

