Return-Path: <linux-wireless+bounces-37586-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vzy4KcwXKGpb9wIAu9opvQ
	(envelope-from <linux-wireless+bounces-37586-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 15:40:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20462660AAA
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 15:40:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="K/bP3aIF";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37586-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37586-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FB3830448A4
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CB419310;
	Tue,  9 Jun 2026 13:36:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB4416CE8
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 13:36:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012203; cv=pass; b=lOoFNZClHOUc0lp1ziQIKSaWhRh/cML1LdG48ZhaO5lezsgmlYyXEUK7It1FgiTAs5LaySYp4zxm6iUt6cwar6VmgSQp/X1QYxxSgZS9ye7yWAeOi7HpK/Acbw4TcRGNgtOteHO8W7R/5pJjGfaQQ8OGFjd62RHtFG5EidovPqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012203; c=relaxed/simple;
	bh=nhzPVHz6XMP+JcENiwIDJwvObOIwhfrBJt10B7quYQM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXKaN4i4NjUbgaxpo6Dtm9jnbK/KrcZXq0RXrrVt+j/hea4NYXTrHEfZ8yKd8Niw/Yd7nKK+NFFWlqcs9OqDAVzxqh5UnLPIkAjDGXjRqYg0xcFKvDm9CMTYB6QGqPp7DmWKx9oS6Htkxy3TbRiPP24dzwIZNWBLk1gSYTU3KJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/bP3aIF; arc=pass smtp.client-ip=209.85.217.47
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6c4db0bf752so3520806137.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 06:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781012200; cv=none;
        d=google.com; s=arc-20240605;
        b=DEuXZp66xDQ8sZixs2nySwGwxDh5K9zjWM93LBcI8Bo9X37+KFJz8LrrP/Krc6AwuT
         GfsgO6GL4OxgIIuLzk8cUF+sHwIXbeUEHy+MezkEPtA9Rr2OQvOmaY0SQoVUvVtBVAI0
         uQTaaNzvLvhq7SrG5i1IN3xjIilQAQ4KskL0IuMawWL2pbcUVWrILB6r+QlzIJ9h0Mas
         6LxWXstR14+MsLQnKBU8T6cBZ3beQoyGa6bIMhR3ttVm7Rgo3nZj6SXLaJxfwOhx6hS3
         ZvSwGo6s8iQ9WoUnzlmakBg0wGJZAKiyiHDANUFLbtNRrIn7o7XZUHMsbj994Qqu9x+/
         xUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:dkim-signature;
        bh=jfMvfDEA3SmU4K/PGLB/W0+/Jeh4SL7ZfMFVFyHgEHk=;
        fh=YaiDvs9tX+CnW8dPH1EiYBB5Pgck3UPmnKAhAlKGa2E=;
        b=ZRnXh8HvLFvPb+bEiw95jpG82ZJklxr0peu4yd459NUeWbXMQPLaFaHkKTkAvXvLPw
         Qdby/niuuphAY+zNJ/t7XgOFhMiA2ah88ZvgxTWF4lt4mLYChdyzpLbXqwX/w48nfWHX
         ncM1QsCig71YVrtZk9AG3ypXrAZFDxZUEmu/MfqpcmzpUUceCwO+cEY6sMw8oHCpF8L4
         oSd9blGFDqaT5mgVIZyyYoWyoEbiuW/iudLRJLv0uXxinoFi+NnPRrvHj5Z85bj0S4yV
         NlGJsCIvu05C5dDKIcPjtVO5Un71VmoWDq9jBr1w9p1d23/MPXNmlbnpD0V4aQNRAN//
         UoaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781012200; x=1781617000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfMvfDEA3SmU4K/PGLB/W0+/Jeh4SL7ZfMFVFyHgEHk=;
        b=K/bP3aIFi9EXoU6/WPM3aFsNqEf8ZNhxb4eQ/nAPgahWDlkGOw/nMpmj+f2SkNPCf7
         1rkWoRZoVP5dXGxuMztUGlsHej9MQrBwtp0P4DzVrSkefjQsxLInEzCz0sQ10O1pwIaS
         tImqErGIdV9dzzIo0TO28h5dSYvS9/2h8zxJZw/1kwl7JSGWchSlEHwACeI5b3vgRxRt
         uhphHkgBMNMSGYS00fj3PM15IDxUU4M0hb737U6RuBBOx34ozJzNtodVh/R06oVf7D65
         69iAACgRPI7xWkvxZOVzn5j2fnk5n+VW7jL0tJWOr7x0tO0yOlQI+gIrEEqofS7IXNX7
         7e/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012200; x=1781617000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfMvfDEA3SmU4K/PGLB/W0+/Jeh4SL7ZfMFVFyHgEHk=;
        b=dkHTYjHwW1YdBsvLjv/5HeHttHP1gkrZKxIUaOmBq1/PYAPzC3QO5luhTZYmfFPUp0
         OsfeZQMovLDbwElL3TujvhUpEG7ACvcb0+4ugUoeFY1xqFqKNcCWC5S8BERMaT44vZQ5
         /8blNPVNScd/+//WlF9QC+LR7tIQT1Qh6WxNWaMOoIPCAHFGdlPZU7FUDxtd7DJ85y1Q
         rp7umoIPz0SeOGzoOAI+hIJGK1vzAt58BMnijcwF5UAYdX4pkN49er1ZcumzsFR7G1GY
         pbh/I2rV4foH6nvhLpllHjLQD1tKhsmFVowUIYJjJzLoLVHtsIwp2XmZSEqnDSIqex1B
         2EEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Aqdw7Ox2sfpkATzZPeTNsIfW2r5VjVtY51GhpwoTBv6+MennMR5CNooCb2mEG78DMBtcmRQsb3JZXvCQ3dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxke5/ruwvRgY3KNlJ+HIkqQUXgFMZ2cX0QwUc+ZxbCoT8VPyn2
	1nMlr5y+Gw9KFex+mETpZW+FA75igmbL2Z7zHxZQs8Yp2YltJBrhfTR5C1bWR3Dx3j9/SjJUSkR
	P/s+vNo9kMEXj3nMwWULBx00rF+QQEryp2/cX
X-Gm-Gg: Acq92OHESNKxaW/hwcpaGM+sSgqgNC1Du9njmDS/25+dTh/BNDE7TdKELw620d8xF8q
	xgH/RVbkdjTarQU29u/760mFa9gkLIFWSPcH244iLMDK7Cr/aobrniVm+J5mwC1tIoV0UKmxXVv
	tXKr08wyc0Jb4tfbI0K7Z4zEtWQPo9E2yxw5l3pKQC+vBYeFgEaTuopCcoe1KYRQ+DUpYqv2aoV
	3cc9kSPx0BTb+XBPLfua1JaAsyAqNwmoyGyzUwBnyqt8GNo5h1sydJ1HAK8SU2DUVu2n/yy/HSi
	APolA/TWM+9utmAl7TEmZBjehrE=
X-Received: by 2002:a05:6102:548c:b0:639:1e8b:ecd9 with SMTP id
 ada2fe7eead31-6fefa23308cmr10377940137.20.1781012199589; Tue, 09 Jun 2026
 06:36:39 -0700 (PDT)
Received: from 922524751902 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 06:36:38 -0700
Received: from 922524751902 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 06:36:38 -0700
From: manisadhasivam.linux@gmail.com
In-Reply-To: <20260522070646.203115-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522070646.203115-1-jtornosm@redhat.com>
Date: Tue, 9 Jun 2026 06:36:38 -0700
X-Gm-Features: AVVi8Ce_P2VLojOc9kycU6EoL1PlQq47Nd5prQV2Yp4Bcj0p3ZHpvVx3-YePVQM
Message-ID: <CAGyK6cpa89aHZELLBnc9nBwQdivir7-P9_e+CLQKzbzQzXWjsg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Disable broken FLR on MediaTek MT7925
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, shayne.chen@mediatek.com, 
	sean.wang@mediatek.com, linux-pci@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bhelgaas@google.com, alex@shazbot.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37586-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manisadhasivamlinux@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER(0.00)[manisadhasivamlinux@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:nbd@nbd.name,m:lorenzo@kernel.org,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bhelgaas@google.com,m:alex@shazbot.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20462660AAA

On Fri, 22 May 2026 09:06:46 +0200, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> said:
> The MediaTek MT7925 WiFi device advertises FLR capability, but it does
> not work correctly. This manifests in VFIO passthrough scenarios: normal
> VM operation works fine, including clean shutdown/reboot. However, when
> the VM terminates uncleanly (crash, force-off), VFIO attempts to reset
> the device before it can be assigned to another VM. Because FLR is broken=
,
> the reset fails preventing reuse.
>
> This is similar to its predecessor MT7922 (see commit 81f64e925c29 ("PCI:
> Avoid FLR for Mediatek MT7922 WiFi")), but with different symptoms.
> The MT7922 issue manifests as config read failures (returning ~0) after
> FLR. The MT7925 shows different behavior: config reads work correctly
> after FLR, but firmware communication fails.
>
> First VM start with MT7925 works fine:
>   mt7925e 0000:08:00.0: ASIC revision: 79250000
>   mt7925e 0000:08:00.0: WM Firmware Version: ____000000, Build Time:
>     20260106153120
>
> After force reset or VM crash, when VFIO attempts FLR to reset the device
> for reassignment, firmware initialization fails:
>   mt7925e 0000:08:00.0: ASIC revision: 79250000
>   mt7925e 0000:08:00.0: Message 00000010 (seq 1) timeout
>   mt7925e 0000:08:00.0: Failed to get patch semaphore
>   [Repeats with increasing sequence numbers 2-10]
>   mt7925e 0000:08:00.0: hardware init failed
>
> The driver cannot acquire the patch semaphore needed for firmware
> initialization, indicating that FLR does not properly reset the firmware
> state. The device remains in this broken state until physical power cycle=
.
>
> Disable FLR for MT7925 so the PCI core falls back to Secondary Bus Reset,
> which successfully resets the device and allows reinitialization for VFIO
> passthrough reuse.
>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> v4: Improved commit message with specific dmesg evidence showing firmware
>   initialization failure after FLR (Bjorn Helgaas feedback)
> v2: https://lore.kernel.org/all/20260521061205.12727-1-jtornosm@redhat.co=
m/
>
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 000000000000..111111111111 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5607,6 +5607,7 @@
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
>   * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
> + * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
>   */
>  static void quirk_no_flr(struct pci_dev *dev)
>  {
> @@ -5617,6 +5618,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, =
quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);
>
>  /* FLR may cause the SolidRun SNET DPU (rev 0x1) to hang */
>  static void quirk_no_flr_snet(struct pci_dev *dev)
> --
> 2.53.0
>
>
>

--
=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=
=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=
=AF=8D

