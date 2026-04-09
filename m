Return-Path: <linux-wireless+bounces-34533-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mATXMdsD12mPKggAu9opvQ
	(envelope-from <linux-wireless+bounces-34533-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 03:41:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438603C54BD
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 03:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD8F330193A9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85708258EE1;
	Thu,  9 Apr 2026 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfhY/ul6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A622255F2D
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 01:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698904; cv=none; b=QXHW43PEv7n+TFFjJnC/ozyvg3virZgSkkB8mvmYYTkNIuNYjTjkAttC9wFXuwVBYUpBhsR1Djkv9YiTrvX2FlbfUA50MlxHICx5iPBjlDhlnYlvclROhNblrc18z5oC9lE3j1MmxT9GYN3VtEJKGMbP8eQ/aW8ED/yWz4aFcpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698904; c=relaxed/simple;
	bh=Sw/Cn7aFoWBhTKyVrxVQGUQid9kR1Ft+p/PTSEweZh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XbX4BW1JMHxNqt0bv8R7uLGNUpzvZ8oAS5boWKnxwXjUnPgTRUn7bA6W2e40uZLoTTnPIDV/sN38n8WiYrur5QaNRT1eQCsm1J2AJA7t3YYtILNsDVmnHrDkNku1fLEFGKs8BXtNFTa9fDZgiqQHlDUET1Ese5xE4yJY7hSjJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfhY/ul6; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2cf1646bd11so371182eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 18:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698902; x=1776303702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MadnNngCxJC8yYjvjyaGGRQRw+73E0DoH8OrsCxju0I=;
        b=gfhY/ul6FMn3wWXL2nrzANpITzEDCEtaj276gp1O4dk981tKjl5Xgj5plIcd26OuNc
         MpRpe2YGiXFtVhbUy0TSouVFYJ4wZ8I2XX4QqfDXshMi1OTDJgqvX5r/9XIzt8mVcGC2
         kTR1TC+ZgVWj9ZHzGvbLk7UZ3uY8DqteeaTKLGUTbfee894Q0/OeIVu0eyMme8lBdO/2
         e8/wcHMsOdvvhJ+E8RH85+2gqY+brjQAUQGSSSQ/J19tF0halhiJKd/92+7JI+B3b5DQ
         EoiKNwAe89BKtCd37fnwQOmmeExrTo+lX09l2VVTZ3wgljsdXskWbY+hOnf3WKUFaNCb
         d9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698902; x=1776303702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MadnNngCxJC8yYjvjyaGGRQRw+73E0DoH8OrsCxju0I=;
        b=gHWPDmABiyNpnjXda2kfMqZoi6Um2FYVbZwLt2dUHfQyQcVze7grEcmbAUDC7pjBBr
         ZtY+pyItkcZ2iI/DGyHuXn3Vu5JRZBHK8dxAQFGeqR5sskIwPy2x3NM5bkJTdo3Arz1n
         c5M9nx1D8bBzTwXbPCzuY/Gdcxe8mV4zoW3RWXwyv8J/m+GXMvIYRPRoMetN1sqG3GR8
         qWITr1dI0SPC0XMuwVvZAI2FJRHKX8lAXkUEejyw0IznVxB2qj5vKbt6t39t3GwSdJvM
         x94ccEbgb7Il4+THgD4e/VtW/7kBYx6DhY0rMULuyi4GbjHsnsV0OOsHNpIib4MXysdC
         5xyQ==
X-Gm-Message-State: AOJu0YyUH2R+3dXeXZQFeuLmyjxuS1KZo9AusIbB2HijwSzAhySdu0H0
	BGXwNUTrxNV0JJAdn0Y8XR/t1UkF1mleAMGaBmmTA9YgIaatfRRelM+Ne8Ulx7nWMlZWRw==
X-Gm-Gg: AeBDieud7SnzWFjXVCVPndPGwguxARPPeDr6IjhaS4bQublK7VggefHfBjQxKTCW4G/
	O6OPCTZwgzqT9t0xZAzG9H8VMmlpnjniBYDq7Ig5ercKQSQE7uZA7gxf173d8zsZcAunRn8ruRC
	w/FOHaAokpeJMSAfRMf5bazCcGTvp+uWbnvfaxfp6e+gt1pStIsO9/6TEDTZJ9zgI9aQ1FE282+
	Bhfw9Cnc4C4KZArfva8qqA77CEy0Sabt77Y2lAScjrQmtLj9QGEkjzttiBqzcB8xDkudGjS0Tsr
	IRplG49U+3/jkRQx6RjTpM33YlwrtMcZLTp/iheGd9EMfFfhwPo2qOyJiMLlKmcVPIDmm0nIFUL
	9e8DbTf1y96eUvgGB0AY4eSgxVwGctGk34eYPrwwVoKiTiVVhFdzl4Sb1OheTCgB4JlgeR9zJXX
	rzq6HYMPWMSrPnmY90dEqNRPKdO2XsMOT/xy+ECA5tpS1Fbu85gSXVod+szFwVsnczxnY4mLmeC
	RswZ7Mu8Qcd86RGp0upWxKljf6FugIP/6DG
X-Received: by 2002:a05:7300:2310:b0:2d4:2cc8:68d with SMTP id 5a478bee46e88-2d42cc80a4bmr710272eec.25.1775698901971;
        Wed, 08 Apr 2026 18:41:41 -0700 (PDT)
Received: from ?IPv6:2804:1b1:fa41:f3c2:efa2:f2d9:c540:bfc4? ([2804:1b1:fa41:f3c2:efa2:f2d9:c540:bfc4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf1271asm27331763eec.26.2026.04.08.18.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:41:41 -0700 (PDT)
Message-ID: <7e1ebd83b843b6e74673117018fc5ff97f26f35e.camel@gmail.com>
Subject: Re: mt7921e: repeated driver own failures cause hanging
From: Vinicius <viniciuspython@gmail.com>
To: Sean Wang <sean.wang@kernel.org>, moosager90 <moosager90@gmail.com>
Cc: linux-wireless@vger.kernel.org, "moderated list:ARM/Mediatek SoC
 support"	 <linux-mediatek@lists.infradead.org>
Date: Wed, 08 Apr 2026 22:41:38 -0300
In-Reply-To: <CAGp9Lzp8NjVwkn2atNqT9x9-QTkWMLxK+Ntkb=3Z1fWcM6N=7A@mail.gmail.com>
References: <4870974.vXUDI8C0e8@fedora.fritz.box>
	 <CAGp9Lzp8NjVwkn2atNqT9x9-QTkWMLxK+Ntkb=3Z1fWcM6N=7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34533-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viniciuspython@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 438603C54BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sean,

moosager90 recommended me to reply to this thread when we were talking
about a bug reported at
https://bugzilla.kernel.org/show_bug.cgi?id=3D220353

This bug reported in bugzilla is related to mt7921e raising several
"driver own failed" messages in dmesg. But it seems this same bug is
also affecting me through **mt7925e** driver.

Before posting below a log from my dmesg, which also shows several
"driver own failed" messages, I would like to say in advance that yes,
the bug was occurring every time my computer suspended. I first tried
to disable the auto-suspend feature of my linux distro and the bug
stopped happening too often, but was still happening sometimes. In
~March 28th the bug was being triggered too much (even without the
computer being suspended), freezing my computer and requiring a reboot.
So I tried adding `options mt7925e disable_aspm=3D1` to
`/etc/modprobe.d/mt7925e.conf`. I think this is what you suggested when
you said "could you also try disabling PCIe ASPM...".

**Since I added this line to disable ASPM, I have not experienced more
freezes. It seems this line really fixed the issue.**

Below you can find all the information about the kernel version I'm
using, as well as the driver version, firmware version and logs from
dmesg (a copy-paste from my message at bugzilla on March 25th):

```
# uname -a
Linux arch 6.19.9-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 19 Mar 2026
16:33:17 +0000 x86_64 GNU/Linux

---

# journalctl -k -g mt7925e -b -1
mar 25 09:00:09 arch kernel: mt7925e 0000:01:00.0: enabling device
(0000 -> 0002)
mar 25 09:00:09 arch kernel: mt7925e 0000:01:00.0: ASIC revision:
79250000
mar 25 09:00:09 arch kernel: mt7925e 0000:01:00.0: HW/SW Version:
0x8a108a10, Build Time: 20260106153007a
mar 25 09:00:09 arch kernel: mt7925e 0000:01:00.0: WM Firmware Version:
____000000, Build Time: 20260106153120
mar 25 09:00:10 arch kernel: mt7925e 0000:01:00.0 wlp1s0: renamed from
wlan0
mar 25 10:25:16 arch kernel: mt7925e 0000:01:00.0: driver own failed
mar 25 10:25:17 arch kernel: mt7925e 0000:01:00.0: driver own failed
...
mar 25 10:25:42 arch kernel: mt7925e 0000:01:00.0: chip reset failed
mar 25 10:25:45 arch kernel: mt7925e 0000:01:00.0: Message 00020001
(seq 9) timeout
mar 25 10:25:48 arch kernel: mt7925e 0000:01:00.0: Message 00020004
(seq 10) timeout
mar 25 10:25:51 arch kernel: mt7925e 0000:01:00.0: Message 00020002
(seq 11) timeout
mar 25 10:25:54 arch kernel: mt7925e 0000:01:00.0: Message 00020001
(seq 12) timeout
mar 25 10:25:57 arch kernel: mt7925e 0000:01:00.0: Message 00020004
(seq 13) timeout
mar 25 10:25:58 arch kernel: mt7925e 0000:01:00.0: driver own failed
mar 25 10:26:00 arch kernel: mt7925e 0000:01:00.0: Message 00020027
(seq 14) timeout
mar 25 10:26:04 arch kernel: mt7925e 0000:01:00.0: driver own failed
mar 25 10:26:06 arch kernel: mt7925e 0000:01:00.0: driver own failed
mar 25 10:26:07 arch kernel: mt7925e 0000:01:00.0: driver own failed
mar 25 10:26:08 arch kernel: mt7925e 0000:01:00.0: driver own failed
mar 25 10:26:14 arch kernel: mt7925e 0000:01:00.0: Message 00020003
(seq 15) timeout

---

# modinfo mt7925e
filename:       /lib/modules/6.19.9-arch1-
1/kernel/drivers/net/wireless/mediatek/mt76/mt7925/mt7925e.ko.zst
license:        Dual BSD/GPL
description:    MediaTek MT7925E (PCIe) wireless driver
author:         Lorenzo Bianconi <lorenzo@kernel.org>
author:         Deren Wu <deren.wu@mediatek.com>
firmware:       mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
firmware:       mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
srcversion:     CB386A1D0C64CC7F4C723D9
alias:          pci:v000014C3d00000717sv*sd*bc*sc*i*
alias:          pci:v000014C3d00007925sv*sd*bc*sc*i*
depends:        mt792x-lib,mt76-connac-lib,mt76,mt7925-common,rfkill
intree:         Y
name:           mt7925e
retpoline:      Y
vermagic:       6.19.9-arch1-1 SMP preempt mod_unload=20
sig_id:         PKCS#7
signer:         Build time autogenerated kernel key
sig_key:      =20
6F:56:40:C8:60:B3:9B:AD:DF:E1:84:24:BC:D4:A9:07:90:4E:7B:C6
sig_hashalgo:   sha512
signature:    =20
30:64:02:30:54:34:C4:0C:8E:A8:D6:EB:38:02:71:55:A3:09:CA:39:
		28:2E:F3:8C:2C:38:AB:26:89:8A:B7:3E:66:77:40:26:C7:D5:

13:12:
		CA:39:F4:99:1A:EC:3B:0C:D4:8D:D7:C0:02:30:62:78:5D:DC:

90:B7:
		57:5E:CE:F5:64:99:EF:AC:B9:3B:B7:00:3E:EE:BA:B7:81:C2:

8F:2C:
		DF:B2:F4:64:3C:76:54:24:0B:70:72:56:80:7E:28:5A:56:71:

45:D6:
		A7:57
parm:           disable_aspm:disable PCI ASPM support (bool)

```

Best regards.


On Sat, 2026-01-03 at 01:10 -0600, Sean Wang wrote:
> Hi moosager90,
>=20
> Could you please share more details on how this issue can be
> reproduced? For example, does it occur after suspend/resume, under
> heavy traffic, or during normal runtime? Also, please confirm which
> firmware version you are using.
>=20
> It would be helpful to test with the latest linux-firmware version:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it/commit/mediatek?id=3D5cf85776762a544ad27c4447b61eaabb0d4716e7
>=20
> As a debugging step, could you also try disabling PCIe ASPM and check
> whether the issue still occurs?
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Sean
>=20
> On Fri, Jan 2, 2026 at 4:35=E2=80=AFAM moosager90 <moosager90@gmail.com>
> wrote:
> >=20
> > Hello,
> >=20
> > There is an issue with mt7921e which causes repeated failures in
> > chip resets,
> > bringing the network down and causing hanging on every command or
> > action on the
> > system; the only workaround is to reboot. This is what the kernel
> > output looks
> > like at those times:
> >=20
> > mt7921e 0000:62:00.0: driver own failed
> > kernel: mt7921e 0000:62:00.0: Timeout for driver own
> > kernel: mt7921e 0000:62:00.0: driver own failed
> > kernel: mt7921e 0000:62:00.0: Timeout for driver own
> > kernel: mt7921e 0000:62:00.0: driver own failed
> > kernel: mt7921e 0000:62:00.0: Timeout for driver own
> > kernel: mt7921e 0000:62:00.0: driver own failed
> > kernel: mt7921e 0000:62:00.0: chip reset failed
> > kernel: mt7921e 0000:62:00.0: Timeout for driver own
> > kernel: Console: switching to colour frame buffer device 360x112
> > kernel: fbcon: Taking over console
> > kernel: mt7921e 0000:62:00.0: Message 00020001 (seq 1) timeout
> >=20
> > I have observed the issue on many untainted kernels, and I have had
> > it happen on
> > vanilla kernels not provided by my distro as well.
> >=20
> > Mine and some other people's reports are available at [1]. More
> > logs of the
> > issue on my system are in the attachments of my original report on
> > the Red Hat
> > Bugzilla [2].
> >=20
> > In the past, the issue was reported at [3], which resulted in a
> > patch [4] that
> > only keeps the system running instead of panicking. This means the
> > driver still
> > causes system hangs.
> >=20
> > I still don't know the root cause of the issue and I would like to
> > get to the
> > bottom of this; any help or guidance is appreciated. Crucially, I
> > have not found
> > a way to reproduce the issue at will.
> >=20
> > Best regards.
> >=20
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220353
> > [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2411854
> > [3]
> > https://lore.kernel.org/linux-wireless/VE1PR04MB64945C660A81D38F290E4A4=
BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com/T/#u
> > [4]
> > https://patchwork.kernel.org/project/linux-wireless/patch/727eb5ffd3c7c=
805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com/
> >=20
> >=20
> >=20
> >=20
>=20

