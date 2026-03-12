Return-Path: <linux-wireless+bounces-33154-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCvdGYMEs2l8RgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33154-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 19:22:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE926277200
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D95300EF9F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E733E34E;
	Thu, 12 Mar 2026 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzpV+lYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DE2DF137
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 18:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339776; cv=pass; b=RJ9FiKVFczbKR9DOcPy96G+dRrJXzY+AC+fbmde+JPcbCJuPXrHPBgCmMU9H8U9UDF4MT/GN3akZvEyy0RGxEbqTHX9Fgwx6P4NMU5+x0p4gIz0BH6Bu11Uj/IAwK0Z1LMXiQRyLqePSuAL2nR3aC5Rzit1GUlDyXTIc0yWe0ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339776; c=relaxed/simple;
	bh=jkxZ1U7oCx5yU4ujmTMjkOIzXxNkVcspL67OtYeMDvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlHRkQisv4H10LAURTIqN0cGzIaHB2TRV4Or3OWL2brOlMtqkruP/J26eh8wMOqP9KpmAJXv2odflBqQK0RPy2aEjkT8C8SY8l2wY1hnmFYUu98D1osBBpVakE9XpihrTlJHNAMeB8GpoJVbBAOlrR0Co3rQ76i6tZR+LP7s620=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzpV+lYE; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-663a60768f2so990999a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 11:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773339773; cv=none;
        d=google.com; s=arc-20240605;
        b=NZTfLwl9bgJMajropQdUNREx8VhWoNGaxEmDrPIhEIWuz6vy4L1zEgXiRxqqvpy5iY
         GlvzF4u64kALF9SqPRCO3AnDOLxY57iH9h3DhtFoaQ9yPUkJeWK5bAJYAwwbI38Hwofc
         vqdht7c6VgHhdOW1+41kgAu09LTOF0gcp829Mlat/IFpXucEGFpOxKT5qOOWHCu1RTDK
         zUrwwgyUdPvRVuaZ3dYZwp9gptpwFZM/GOen7OMbILdY5HAw1b8oVewLFFkkhCl6+8cN
         BeFuPgLr7K03eD9IFQTSjtQruZ2hcQXFCUh/BH6dFVIrPhNuUgyxgLKpXRCI0W0m/kYh
         c11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fMV5vC3gcbuXOcw2NM4uNxcXhHiDoqMd8caf3UgdZJc=;
        fh=MXkW9Xo5Ym/gIF9EG8Fk1lbc8jJJ90IIrm4Se6meZo4=;
        b=kBhGbnK78gulbw2H6O2f8l9qX6TJP1+9Be+HJUdTa6wlm6ExiolNBKKm0Uz51U9SO8
         hA/DiIuxoDSjOQ14h9QHc5U2wDMa7bzIriMFXLxlWJrQOnngTHSdNq3zmjsm0eVUjoFI
         w++WMz72BaTjVS9aEEeAf3XuahE98+obzR2E0fcy/xI4kzFdyvt1KgjL7ek3IWB4oWFW
         i+V1BnAaaWV0VE9a4bNB5G/zP8VG9dbSESSkuqfMWDmC10xCARH3XeTrpQJdt28BcfOH
         aBv+s6uXJlMvXYIleUZMbi6Q6KIxtZXWF8nYHbF0mt+ek12mYWkBLebknunvIikdJq4g
         kVZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773339773; x=1773944573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMV5vC3gcbuXOcw2NM4uNxcXhHiDoqMd8caf3UgdZJc=;
        b=fzpV+lYERghtiLLKocj+BDD71Iviw+UX5Q/KCnF3HDUWl66rsazKuioGCctuxQdPdX
         Iqv0pYr5xviIx6h+J8pvW6wQj06nnaxnZRiBG3W2maGAp7X+zaxhpENWOAySaaZ8vA5u
         VpFr+nL8VUffu1fo2nDy6dJh7MyebqEOui5fFPW1qe/aw93VdTggcTEHl/hbyMO2D9CB
         9QwtT/PLn16j6Zum/oaIOXk6NZdHGxa6SdTR2zhC9k3p1CR3nbjWdojQ8dSX2xTzOBe+
         U3ODn5rKDKCIp4SNWamEl73aIU056w69DabPJRTRcLsTu5SpBAV9FAL38JXNRQxqPASu
         q4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773339773; x=1773944573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fMV5vC3gcbuXOcw2NM4uNxcXhHiDoqMd8caf3UgdZJc=;
        b=uT/ylv53h1RLtdfBKnLvg66TWzgIbkGoLGhWLFmBBQ3AXaBL1o9qjnseQFDChENUyk
         4EVptGf+cTtl+XFDli1YCwD5yp1jxpUrjrA4W3A3VqqU1AJZvQL3XUdMNXsnlQ6WG2FK
         hB90uyYSH/3UzYdwrVuI+S9LMTGgH3MiJJ54hrThvTo1dnY2bmJ+QQWv2D0ivrIXsWsb
         KqrrND6Kvkjvrc3kL0bAfcU3zlbMtBOzjPd8PNszfjD3RJ663WAxp8tgy+TOkZKCMhfc
         APkjLVhhfm16CsN7wgOF7sNoB2Z5gjjepQteZJsIaaNs91j0s6rGzJiZMxpBKgydjStv
         rdVg==
X-Gm-Message-State: AOJu0Yxo0gW6V+yZVFJxT5A7chHcYmBsfAp1rRlriUKaKxTXsMKz3x+P
	WaJfzgjBJ9uZdPf/o4w0RQVtrv0ReE5bh/5VAd9am+HQX8lYPQeKPfn8idhSFirdt9C3An7F6G/
	tXEOpGvgeKQQ0Ic80886wPHvdJOHnQe8=
X-Gm-Gg: ATEYQzxrGxzWuC1VhLZ7L5Y3JX9ubvdJsvdluKoL9qbEVcuATIwIuBLZX0TW7dWspPK
	U3aa9KUKThZA0D6a8mdeLqOu5AVPHkCPjNsAJB98pdY2oAx/n0f6v90IT7e1dYQVWB0+YRLbgw4
	XnvZbCoL//AFTn8R/ZONXI7ivIXu6BYqAp8gNa1Uhy6J6J1GRSrY56vUFRjUNAjuwfNmPKDzjPw
	rd8KwUKdCK23dlfG6O37DBPjGP++piMW8AtdfV3ufUwLLZ8kkdo08LcsH1LQRrp3pPit+w6Cb2e
	waBPYg==
X-Received: by 2002:a17:906:84c:b0:b97:1db4:e59d with SMTP id
 a640c23a62f3a-b976507b8fbmr22485866b.1.1773339772397; Thu, 12 Mar 2026
 11:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CAGp9LzoidBL1iYYC371+Fw+drbArLRTneJKxCoFiitx=dweKCg@mail.gmail.com>
 <CANAPQzjiBf8Rqphn2SypYN2O6bddj6vB=63Mp=T5YVEt2oGvyw@mail.gmail.com>
 <CANAPQzgiE1rMP3F=5NJg3hp2uBXtq44+vTRBdkHwdfHyXJ8MQQ@mail.gmail.com>
 <CANAPQzgD312EPSbvaQTE6U+wn85L65+xZHms7DP509ApxWvSZA@mail.gmail.com>
 <CANAPQzgXN2UOjuwV1fRofN2syxG933kSaB9S7DyFAykHHMRzew@mail.gmail.com>
 <CAGp9Lzr4KsXEXbj+4h+Lk2fKU7z6BqtL5krzZmu-_So2-bN4_Q@mail.gmail.com> <CANAPQzj24sTgnuXMo3wqVDhA==UQ6JQLESk0AernQUUmZvTi2w@mail.gmail.com>
In-Reply-To: <CANAPQzj24sTgnuXMo3wqVDhA==UQ6JQLESk0AernQUUmZvTi2w@mail.gmail.com>
From: bryam vargas <bryamestebanvargas@gmail.com>
Date: Thu, 12 Mar 2026 13:22:41 -0500
X-Gm-Features: AaiRm53sk3Du3eBUb_EUpLygsbeXq9bvqY4JK38zl7w4HgAXVxAkxj9ZZwg0wN8
Message-ID: <CANAPQziOh3sB7B8G+U3AZsFfeFN1uAg4munhwA_feZi56D7W+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: Sean Wang <sean.wang@kernel.org>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33154-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryamestebanvargas@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: BE926277200
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: Bug: mt7921u unrecoverable chip hang requiring system reboot
(USB device disappears from bus)

Hi,

I'm filing a bug report for a recurring failure mode on the MT7921U USB
WiFi adapter where the chip becomes completely unresponsive and
eventually disappears from the USB bus, requiring a full system reboot
to recover.

This follows up on Sean Wang's suggestion to document the failure before
proposing driver-level recovery mechanisms.


=3D=3D Hardware =3D=3D

  System:    Minisforum NAB9 (Intel i9-12900H)
  Adapter:   MediaTek MT7921AU USB (VID 35bc, PID 0107)
  Kernel:    6.18.x (Ubuntu 24.04)
  Location:  Bogot=C3=A1, Colombia (2400m altitude)
  Uptime:    Continuous operation as home server (6-12 daily users)


=3D=3D Symptoms =3D=3D

The MT7921U periodically enters a state where:

1. nmcli device show / iw dev wlan0 info time out
2. WiFi scan requests hang indefinitely
3. The interface exists in ip link but is non-functional
4. All software recovery attempts fail (driver reload, USB
   unbind/rebind, USB controller reset, uhubctl power cycle)
5. The device eventually disappears from lsusb entirely
6. Only a full system reboot restores the adapter


=3D=3D Structured Event Log =3D=3D

I run an automated monitoring script (net-rescue.sh) that checks chip
responsiveness every 10 minutes and logs events with timestamps and
system uptime. Here is the complete chip-events.log from January
through March 2026:

Recoverable events (soft USB reset succeeds):
  2026-01-11 20:29 HANG -> RECOVERED (soft_usb_reset) [8s]
  2026-01-11 20:34 HANG -> RECOVERED (soft_usb_reset) [7s]
  2026-01-11 20:45 HANG -> RECOVERED (soft_usb_reset) [8s]
  2026-01-11 20:55 HANG -> RECOVERED (soft_usb_reset) [7s]
  2026-01-14 09:34 HANG -> RECOVERED (soft_usb_reset) [373s]
  2026-01-16 13:37 HANG -> RECOVERED (soft_usb_reset) [313s]
  2026-01-17 15:21 HANG -> RECOVERED (soft_usb_reset) [129s]
  2026-02-28 13:49 HANG -> RECOVERED (soft_usb_reset) [99s]

Unrecoverable events (all escalation levels fail):
  2026-01-13 17:16 HANG -> FAILED (all_recovery_attempts_failed)
  2026-01-26 14:10 HANG -> FAILED (all_recovery_attempts_failed)
  2026-02-09 14:33 HANG -> FAILED (all_recovery_attempts_failed)
  2026-02-11 11:07 HANG -> FAILED -> 14x DISAPPEARED over 3+ hours
  2026-02-22 09:45 HANG -> FAILED -> 35x DISAPPEARED over 6+ hours

The DISAPPEARED entries mean the device is no longer visible on the
USB bus at all. The monitoring script runs every ~10 minutes, so each
DISAPPEARED entry is a separate detection cycle confirming the device
remains absent.

The Feb 11 and Feb 22 incidents are the most telling: after the initial
hang and failed recovery, the chip vanished from the bus entirely and
stayed gone for hours until the daily 2:00 AM scheduled reboot
restored it.


=3D=3D Recovery Escalation (all fail in unrecoverable case) =3D=3D

  Level 1: USB deauthorize/reauthorize via sysfs
  Level 2: modprobe -r mt7921u / modprobe mt7921u
  Level 3: USB unbind/rebind via /sys/bus/usb/drivers/usb/
  Level 4: uhubctl power cycle (physical power cut to USB port)
  Level 5: xhci_pci / ehci_pci module reload

When the chip enters the unrecoverable state, mt792xu_wfsys_reset()
cannot succeed because the chip does not respond to USB vendor
requests. Even cutting physical power to the USB port via uhubctl
and restoring it does not bring the device back. Only a full system
reboot (which resets the xHCI controller at BIOS level) recovers it.


=3D=3D Pattern Analysis =3D=3D

From the event log:
  - 10 HANG events over ~2 months of continuous operation
  - 8 recovered via soft USB reset (80% success rate)
  - 5 required system reboot (escalation completely failed)
  - 2 incidents with extended DISAPPEARED state (3-6 hours)

The Jan 11 cluster (4 HANGs in 30 minutes) suggests a transient
condition that resolves with soft resets. The Feb 11 and Feb 22
incidents represent a different, more severe failure where the
chip enters a state that no software recovery can address.


=3D=3D Pending Data =3D=3D

I can provide the following on request or when the next event occurs:
  - Full dmesg around HANG/DISAPPEARED transitions
  - lsusb -t (USB topology) and lsusb -v -d 0e8d:7961
  - usbmon traces during the failure
  - journalctl entries from net-rescue.service

The static USB data (topology, device descriptor) I can provide
immediately. The dynamic data (dmesg during failure) requires waiting
for the next natural occurrence, as the system has been stable since
the last incident.


=3D=3D Related Reports =3D=3D

  https://github.com/openwrt/mt76/issues/838
  https://github.com/morrownr/USB-WiFi/issues/410
  https://github.com/raspberrypi/linux/issues/5193

All describe the same symptom: mt7921u interface becomes a zombie
(UP but unable to TX/RX), requiring physical USB unplug or system
reboot.


=3D=3D Note on Environment =3D=3D

This system operates at 2400m altitude where atmospheric neutron
flux is elevated compared to sea level. I initially attributed these
events to cosmic radiation-induced SEFI (Single Event Functional
Interrupt), but as Sean correctly pointed out, the failure mode needs
to be understood before attributing a cause. The structured event log
is provided as evidence of the failure pattern regardless of root
cause.

This is a home server under active development running multiple
services (ERP, Minecraft, Tailscale, DNS/DHCP, containers). When the
chip enters the unrecoverable state and I'm not physically near the
hardware, the system can remain without WiFi connectivity for days
until I can manually reboot it.

Best regards,
Bryam Vargas

