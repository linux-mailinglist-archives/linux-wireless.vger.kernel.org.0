Return-Path: <linux-wireless+bounces-36317-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGSeKOD1AmqvzAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36317-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 11:41:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4AA51DF2A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 231DF300B9DB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF464A13AE;
	Tue, 12 May 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHKCncOJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93ED3B8BCB
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578888; cv=pass; b=kEGseCkJIHtgZJmQDkcAbMpgyLMwuzFexhZ0Vr0ty4ww+3rsxSiBvtTtul681ZCCzIvVYHmk7vXJjoIqyfcMPAD58ZAiI73fcDzOcTq9LSSy8CG8yt2rmFbut3Dlta4GCyQpZT45biROMRc3vxw0mnD0SvTlWgGXvEqe/Z3jK5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578888; c=relaxed/simple;
	bh=CxgWcjDmdj2Hu0n71rBBU23N9TUkA+jM8Iyk4mcFdDk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dvtOEjdvKFn2/fMiPAT9T03SQBcN2J5dSC7V6Db0aZ1hc4B14bPvIQO4D5HTJK7FtegZTh8Q3PkgfF8Q7N+77xlNnRd0yJTX7D5QPGhdS1i2hlNWlWYAYeASyDbSINLElxMAGCz2vMvJGXLb8+MdJd80MeFSVTa2jbySnFjS+WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHKCncOJ; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59dea72099eso5419414e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778578880; cv=none;
        d=google.com; s=arc-20240605;
        b=NnFaT0rVneTKlkXeDIHHzMHXF19Q6Y6KiU8RoZEHlkk9sfOgCe+JU8a6K8iRCT63Ui
         0BBlXgDp0TYm6nejAyoPAnNP4O34DS3lG3JKI2Q7F2Wsrm+sFMm0MbVhRMXrIoA3jwvD
         ju5H1JR+T41+7YCycyckbWdpah7eBK7EjkWpwQdYCmraQhq2BqdHq6v5FOTc5uoiZEOL
         YzEEb2qVAvm9n1qhf/X3LY9yASy99iq4bvyF+uspmx4GUHE15l/y574OZ2dXi1TGG5lh
         XmB96BtsxPES4gBjxR0vMxiE4Tt5V2t1pgerqCbUhd/6vY8NJyXxVtXJROItS00c1ON0
         krsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=X1DjcPB+x5548cy33WrtAXvXzmpcqjg9oduXqqi7c8k=;
        fh=zd6cR+mE9qbf6hp8M2x2eE+0UV/YEqDb7ogrFDk6VIY=;
        b=bxrNKCNsv4iI/JXBnpYVNh0E8+l/rYCcVx6IL3keWw9T7FuK0abyrZa43fPPhItE8b
         gw6iBAoHIVwqh98pcuTMB7zNf70apBPXEsHnBvDXtTl+cLCK01EYprWArA/8SuDGAbRK
         z9qj+TutmrSuo6dHahNUpLhMnOyKLzCGUE9HvS7eWtUu6+xHHQBc8il4VTBhY3lwOaqw
         Frxd2iVXrxZqQ1Auh2WDL/NaQDHPcPm2q9DZ5R8nW8Vr6ihAcZ2m+LdG2qP4ZIPYN5tV
         /BvAjr+awEPfl4FtXiIqJZZ4jNzDHCGpVJBmOcJ4yLCutDOg3YwioN3lcx0vaRo6V6sw
         U/vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578880; x=1779183680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X1DjcPB+x5548cy33WrtAXvXzmpcqjg9oduXqqi7c8k=;
        b=BHKCncOJXh+G4T9LvOE7yRHRpAs769ok5HiaUxZYJlWBj5ffQYYy5L+keD8AIt5dG5
         rfjPWtSbrB0d9DZR9CVDnf5aIr45ZNtF9FYKRpHGQXyLi2pNU0U4es1CmMU68P/1kYIn
         BJhOXn1RzDlkgXtP0nEL1zhr7BtAEa+amje8DEvPEtDayXsW7lCsFtjqlQqgHS5AkMog
         HR2HV25tMpwtAkWyBfx72Y/1tyQ20fHp2AxsD9q4hyRMAkkBuYb0mNoKMfxDoEUWG15p
         kt08l1M1OgdrNpsp/Shcnbjaipc+g3ed9nRtJNjLgx7rptvNMHHinoNPV4dAk7fXS2k6
         2DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578880; x=1779183680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1DjcPB+x5548cy33WrtAXvXzmpcqjg9oduXqqi7c8k=;
        b=ibxmn8Ovj1kFGdV3qSq0kTUzL98TZJ1rqdulI/80AYpqjpwavGZTWdEnpj2/wy3u98
         2TIJBywfgLFzAgfp3AiY+ixw7d8PJ5W7qmMV7m36j/7sx4Tdkd7edtKpUIQA3GPsCyms
         yx5+8Insm5etFjWoEV4xxAsTG3joa9l9pHDZVY3HQIaYMV+rj9135DuR2sKcvn+XZf64
         SIGA6tl5c1Eg/jY3zxkZ7lS3jaKsIZpQCtqW/enUtIiei5X6vx8XT4mrMmyrjpVV5I3C
         n0Z1vCuJNX00/t0GaIRRCkpSJIdstqcLsmcduUlB+RhazLb3Ops7Abwrm2YTxQfWCecx
         aopg==
X-Gm-Message-State: AOJu0Yz4Klwzq4l0VxE3O0dB1ItkR+LmWho+1a+PAxICYjr+nMaJxPT4
	QzUXHHJ+hntw66nukWzJH7ldE1THMo9Oi636FLlyU8zYhh5EfpzEcpIJBmRaKRzLsNIczTBTmNf
	tuSGFwyp5n3f1Zvcnt5RAh9PZseYKs+ZUc8YtIg==
X-Gm-Gg: Acq92OHP5Xwat5pOf0WDbSnP0LcSfW6Fgs/yjakmOXvFA166whngXmBXF8PJ0MSwylS
	Qeacxxk5Lislw9VDzFL8CTAHnlwetMzFVGHgv9+1mQN4FDnuWTkIMpkp7o953DJzwwzSkB+CFVE
	9RpZ7/68/Xt06TT6rApyKNpY248s7atmxADmPmwZjP1DVWnuZtXBAfuwxQBocG+njFP7d8IKLO/
	faFJDuDHPis6OhVfCnYcr92bSJIKkwkxuHXAJ+XMggBvgCEXmXNKZad9vL+9e6YH4H6mSbLcr/g
	yPVohGC1A0tdSQ==
X-Received: by 2002:a05:6512:6892:b0:5a8:e336:b55a with SMTP id
 2adb3069b0e04-5a8e336b578mr524122e87.7.1778578879993; Tue, 12 May 2026
 02:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alessio Ferri <alessio.ferri.3012@gmail.com>
Date: Tue, 12 May 2026 11:41:08 +0200
X-Gm-Features: AVHnY4J9BtuNrlXrKJHpLo2TWKcy7O4i3-dSbIPoGPt0FBdFML5e0k-WaTjkZrI
Message-ID: <CAHDv23WJLBEp3ETscVT4Z6E5PQfzTDcofxbZ6jAezZNYde7C0w@mail.gmail.com>
Subject: bcma: endianness problem chipcommon access soc bcm6362
To: "zajec5@gmail.com" <zajec5@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7A4AA51DF2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36317-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessioferri3012@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Rafa=C5=82,
Sorry for the multiple emails, having trouble sending plain text with gmail=
.

I am working on an OpenWrt port for the D-Link DSL-3580L (BCM6362 SoC,
big-endian MIPS host, 4352 variant mini pcie for ac).
project here https://github.com/aleferri/openwrt-dsl3580l
While testing I ran into an endianness assumption inside bcma.
It uses readl()/writel() everywhere, which uses "device little-endian"
convention
they go through le32_to_cpu(), so on a BE host they swap bytes.
But on this SoC the AXI bus is big-endian, so readl() swaps them and
bus scanning sees garbage.

Evidence from a small diagnostic ko module that i asked claude to
create, dumps the SHIM at 0x10007000 and the AXI chipcommon at
0x10004000 side by side:

  axi  @0x10004000 +0x00 CC_ID      readl=3D0x62630122  ioread32be=3D0x2201=
6362
  shim @0x10007000 +0x18 (CIA)     readl=3D0x0100f84b  ioread32be=3D0x4bf80=
001
  shim @0x10007000 +0x20 (ADDR)    readl=3D0x05400010  ioread32be=3D0x10004=
005
  shim @0x10007000 +0x2c (ADDR)    readl=3D0x05500010  ioread32be=3D0x10005=
005
  shim @0x10007000 +0x38 (ADDR)    readl=3D0x05700010  ioread32be=3D0x10007=
005
  shim @0x10007000 +0x3c (EOT)     readl=3D0x0f000000  ioread32be=3D0x00000=
00f

The BE column seems correct:
  - chip id 0x6362 in CC_ID
  - CIA entries with Broadcom vendor 0x4bf
  - ADDR descriptors pointing back at the expected core bases

The readl() column is just the same words byte-swapped, which matches
what I observe at runtime: bcma_bus_scan() fail to scan with -88

The relevant call sites are:
  - drivers/bcma/scan.c
      bcma_erom_get_ent()  -- readl() directly; this is the function
where bus scanning breaks immediately
      bcma_scan_read32()   -- readl() directly

  - drivers/bcma/host_soc.c
      all read*/write* ops use readb/readw/readl / writeb/writew/writel

I don't know how to disambinguate at runtime as scan.c reads the data
before the chip id is known, so a runtime quirk based on the chip id
is not workable.
Maybe if the endianness is known at bind time with a standard property
in the DT the bug can be fixed while leaving the default as is

Happy to test patches on the device, or i'll send an RFC myself if
you'd rather review some code.

Thanks,
Alessio Ferri

