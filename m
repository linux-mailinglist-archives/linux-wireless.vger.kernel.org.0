Return-Path: <linux-wireless+bounces-38197-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZFe3J8WEP2p2UAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38197-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 10:07:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A216D173D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 10:07:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cSxwNTAh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38197-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38197-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E0D3021732
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CC1F1513;
	Sat, 27 Jun 2026 08:07:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3F1A9FBD
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 08:07:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782547650; cv=pass; b=D8NWkuKZX2SOpEDaMyi6q8L9G5pJrg6Y19XzalPy6jiYTn7ZOywHJQnSCAcmClw1la7R5B1+XNvJ/InEyCRiATvWOTjIT3ebZJV5WQMhwb2Kx05Cj79EhCxu/zuTPmyvD/VfKaLq4iozdds8e0Azhe3giFp4dSNeYUTJ4QSYQdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782547650; c=relaxed/simple;
	bh=qL3NTdaEDSWJGA7IpVlPDX8L+uqwscNTizw4xXJvqsc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IvHDKL1F91oPLEod5nHk/Jq73L0qczN7mS0FxO3J0ZYjkz3FH2hMcahcVkqkep01DnePxRWyBYxrP+EWlMNJ5esJOLz1LGammPqvoffnQEFttz2ZHiIFrfWcQJ+ty8iArFpZTZQxL/ao5VZ+i1slz6Vxuv5c+pZQwINh9D/mVG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSxwNTAh; arc=pass smtp.client-ip=209.85.160.45
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-44865cf3010so199025fac.2
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 01:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782547646; cv=none;
        d=google.com; s=arc-20260327;
        b=TdspOag31icoBWcIcDJ4hGN3CS6yBYH+JlrukhB7U3JG4HvTZH8LfM0dWQD2E3mIdV
         /wiZTfTlWdcP5FPUm5xpOUDGIfqgPme43+WbRSA+2WCrDaOQHA/+olOE91BMoKd1WPte
         3ouCA3xwmXnfTUTyci/+N0k4DKoAcJO53OFOdC30xLnONYzmR4xd2XiwOwoFT6m1EkH+
         bHGxsM7utyDW8hk63bnVnJGjmdo6CXyloJ9FMLqR+t0YYzIWL7P5SMlvix7GIF01ZhvO
         wGLl9WrFXHfsi40BLvSXknvqRnhhp+Hi9D92V0Gi4Cf/dEzhJL8yz1+e1WCsRWKav8n6
         5y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FrxhA+cUKDtlC7Gvu9lB/HFZf8ItQzBnstKtPY5lQKQ=;
        fh=mnqzZnDg9OhXS1ZDNalXXVipNsDc+RnZ4zujFuPxsSA=;
        b=npOZKS4TbTU6SYskTvm+tSCtIMYWqj9PHf7R2Ozr1qU2Is6c7ZGyOJOow706JSGyrp
         Unj55CEd2aGCpiW2oRfpItExgHCFSEiNVsvJJIkyM793h3fRSWIhFSyHkJ/7+bQrybnd
         AYl+plc33znC0dWt5jU651gOy2dMbchYU+1a8SNjcLEhim6TysgkwMUrLvfDBf3gwjld
         4ZPU43XRNrzcMeo8fZ3Nhu6lFizG4AZg3hACk5oYXPBLocTR8OJJYFQ+pgsmYMTooWRk
         yGN972zXNn/aimLQMbc17VCp49kmUNvHVbvyZnbxRD2DJQ6fFjBNtCxb+qnB+V2+D5kI
         3+6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782547646; x=1783152446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FrxhA+cUKDtlC7Gvu9lB/HFZf8ItQzBnstKtPY5lQKQ=;
        b=cSxwNTAhZjTfCRagAQBW61U0etOtvCNw4HSchvL6HrMRvV91f1kyIM7JyhMksxszn5
         eF6C0vhvvQ4U1rUz7Nwmn31iHQ+qmPTEVh7nVTDZfzMvWLdhe3FgXjks8F1EHaU4TP/y
         VRLpxzkg7JjL1WqdClwU0LRHBGURKFXzjUTJLfyigccEgolh9IvJSRjYUhFD02cmo47h
         +z7dmS3Tjrl/dPjstFQxs8hV/k8vLVQ6uVOfg+Z40qRB43EZskH3hgY7jUA7TkPb3N+V
         ifnMt1sGO1//BvzQqFb/X9Nh+YI1KItJYF00ZpL4yeZoIGbGBh1YkONBl1AvyD8mLUz9
         kLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782547646; x=1783152446;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrxhA+cUKDtlC7Gvu9lB/HFZf8ItQzBnstKtPY5lQKQ=;
        b=oHCBSvJNzGO0tFIm0XYopkakEa/QQZ1y15O2DRjh/Idr/bNL1qSe7AHtMrgJdgDD/c
         4rt8sE2wqnSAhWJAvjNSqt+FHibfhQLK1qlsYMwagQaGw+HxszdD5MXMqDYJf/diMivE
         o7e5pCY1DNpx0vQ4tWAN5gVXpnHCaK9HHKh1iF4KoMcDisDuagRJ6fa3mIaSwkGYcEe1
         4wpgNRs30P+GfTKrmwSeF9YdYpfAFXeD77opV2VjtOCaeY9C7X608+GVDQjRQm4eiDEj
         aMQlGeZM8Taan1xv4AzwzXIzOrqn6Bf2p1ALA8URL0ETEtv68wholbTeqh+VnLyEEorx
         kzyQ==
X-Gm-Message-State: AOJu0YxAAVwMOC9mxSxC172D4SC8WaIHFiwFyktIocro2bXX/IP/hUy3
	CAbHf/5TbZzTLFdKtkL7buk3Kdj2Big8XpzgKPkXccseZX3GnxuLSzmjYnbmLFKjiW3AW0FO+CA
	YULXyLLH2V3aEpPGEtazB7uAYyOky3cgThHby
X-Gm-Gg: AfdE7ckVf04P4HzQo8+4mqilCIN+nWQiZGri5+A1dnVZvigPZrHhES52W959ISmuMQc
	769PnVJMybJR4Hl22f8dELgtg9npcZpv5QFWPGQIU4GEoUsBcpBJeDbByieF/LOSjh3YiC4dHxk
	m3DDu7FLefAZ9Dd5LHGtO6QrbrkmQJPILsYURJw8OKD3bPKIFkq65jIkO/wG/ksYOoepUIa1yUJ
	yeK8JJ7VNUefVGeNKpkmYRWwR3U+GhoJXYeiBUBYEeTwhAJ/33m+X8+lt9mDi539dEFO1ZuidyJ
	Ki44KPhUOHwUxPcx92wXr5wWWJkGTbDxYyu3EaeB6vt0FX4TwW7L4pIF9e2l4537p5I4f7p8fgw
	c8/SqCC9xi5YhiXLv
X-Received: by 2002:a05:6870:bb14:b0:446:e309:b1b0 with SMTP id
 586e51a60fabf-448117da0famr8194681fac.2.1782547646086; Sat, 27 Jun 2026
 01:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Rados=C5=82aw_Poprawski?= <rj.poprawski@gmail.com>
Date: Sat, 27 Jun 2026 10:07:14 +0200
X-Gm-Features: AVVi8Cf6t5RmfL04h2RjAUoi2ZHM0eG2Z2-8bzPZ1S_1js2FRypxfJqCllCZFGE
Message-ID: <CAMe9DRPx8KTmSVPmb44VVE+Ebu_8isVncWFfwEHvSk=DLh8i9A@mail.gmail.com>
Subject: =?UTF-8?Q?=5Bmt76=5D_MT6639_=28device_0x7927=29_lacks_mainline_support?=
	=?UTF-8?Q?_in_kernel_7=2E0_=E2=80=94_out=2Dof=2Dtree_patches_required?=
To: linux-wireless@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: multipart/mixed; boundary="0000000000003da882065537b7d4"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain,text/x-patch,text/x-python];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-38197-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:lorenzo@kernel.org,m:nbd@nbd.name,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rjpoprawski@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+,6:+,7:+,8:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjpoprawski@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,extract_firmware.py:url,mediatek.com:email,rate.bw:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3A216D173D

--0000000000003da882065537b7d4
Content-Type: multipart/alternative; boundary="0000000000003da881065537b7d2"

--0000000000003da881065537b7d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm reporting a missing mainline kernel support issue for the MediaTek
MT6639 chip (marketed as MT7927/Wi-Fi 7), which requires out-of-tree DKMS
patches to function on Linux kernel 7.0.

=3D=3D Hardware =3D=3D

Chip:      MediaTek MT6639 (PCI device 14c3:7927)
Interface: PCIe
Bluetooth: Foxconn/Hon Hai (USB, device 0489:e13a / 13d3:3588)
System:    Linux Mint 22.3, kernel 7.0.0-14-generic (x86_64)
Board:     Gigabyte Z790 AORUS PRO X

On boot, the kernel correctly identifies and forces chip recognition:
  mt7925e 0000:03:00.0: MT6639 raw CHIPID=3D0x0000, forcing chip=3D0x7927
  mt7925e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build Time:
20250926200913a

However, the mt7925e module (OE) is loaded only via DKMS =E2=80=94 it is no=
t part
of the mainline kernel 7.0 build. All mt76-related modules show (OE) flag
in dmesg, confirming out-of-tree status.

=3D=3D Problem =3D=3D

The mainline mt7925e driver in kernel 7.0 does not include support for
MT6639 (0x7927). Getting the chip to work requires:

1. Manually downloading firmware from linux-firmware (mt7927/ directory)
2. Applying out-of-tree patches from
https://github.com/jetm/mediatek-mt7927-dkms
3. Building and installing via DKMS

The firmware was extracted from the Windows driver (mt7927_win_driver.zip,
Windows driver build date: 20250926).

=3D=3D Patches required =3D=3D

The following patches were necessary to make the chip functional. I'm
attaching their content inline.

--- 1. mt6639-bt-6.19.patch (Bluetooth support) ---

Adds MT6639 (0x6639) device ID support to btmtk.c and btusb.c:
- New firmware filename path: mediatek/mt6639/BT_RAM_CODE_MT6639_2_1_hdr.bi=
n
- Section download filter: only sections with dlmode byte0 =3D=3D 0x01 are
downloaded
  (matches Windows driver behavior, avoids chip hang)
- Firmware persistence optimization: skip re-download on subsequent BT
power cycles
  (saves ~2.6s delay on reconnect)
- New USB device IDs added to btusb.c:
    0489:e13a, 0489:e0fa, 0489:e116, 13d3:3588

--- 2. mt6639-wifi-dma.patch (WiFi / DMA / EHT caps) ---

Key changes:
- init.c: explicit DBDC (dual-band) enable for MT6639 =E2=80=94 without thi=
s,
firmware
  defaults to 2.4GHz only and ignores 5GHz scan requests
- main.c: proper 6GHz / 320MHz EHT capabilities advertisement
- mac.c: 320MHz RX bandwidth reporting (IEEE80211_STA_RX_BW_320)
- mt792x_dma.c: MT6639-specific WFDMA DMA prefetch layout
- mt792x_core.c: wfsys reset and mac_enable use is_connac2() instead of
  is_mt7921() =E2=80=94 MT6639 is connac3 but shares the reset path
- mt792x_core.c: MCU restart + readiness poll before firmware download

--- 3. mt6639-wifi-init.patch (PCI probe / ring allocation) ---

Key changes:
- Dynamic MCU RX ring size from layout struct (mcu_rxdone_ring_size)
- Conditional MCU WA ring allocation (has_mcu_wa flag)
- MT7902 IRQ map fix (wm2_complete_mask =3D 0), also applies to MT6639 prob=
e
path
- mt76_for_each_q_rx() loop replaces hardcoded napi_disable() calls

--- 4. mt7902-wifi-6.19.patch (MT7902 support, related chip) ---

Adds MT7902 device IDs and firmware paths as a companion fix.

=3D=3D Current status =3D=3D

With all patches applied via DKMS, the chip is functional:
- WiFi works on 2.4GHz, 5GHz, and 6GHz bands
- Bluetooth works (btmtk, btusb modules)about:blank#blocked
- No kernel panics or firmware errors in dmesg

=3D=3D Request =3D=3D

Please consider upstreaming support for MT6639 (0x7927) into the mainline
mt76 driver.
The patches above (from github.com/jetm/mediatek-mt7927-dkms) could serve
as a starting point.

I'm happy to test patches or provide additional dmesg/firmware dumps if
helpful.

=3D=3D Regression:works on 6.x, broken on 7.0 =3D=3D

The firmware extraction from the Windows driver (mt7927_win_driver.zip) was
performed on kernel 6.x,
where the chip worked correctly after loading the extracted firmware =E2=80=
=94 no
additional patching was required.
The issue appeared when upgrading to kernel 7.0.0-14-generic, where the
mt7925e module failed to load / initialize the chip correctly.
The DKMS patches listed below were necessary to restore functionality.
This suggests a kernel API change between 6.x and 7.0 broke compatibility
with the existing mt76/mt7925e driver.

=3D=3D Core issue =3D=3D

Kernel 7.0 ships with the mt7925e driver in mainline, which gives users a
false impression that MT6639 (0x7927) is supported.
In reality, the mainline 7.0 driver lacks: - MT6639 device ID recognition -
Correct firmware paths for mt7927/mt6639 - Required DMA prefetch layout for
MT6639 - DBDC initialization
(chip defaults to 2.4GHz only without it) - Bluetooth USB device IDs for
the companion BT chip As a result, users are forced to:
1. Extract firmware from the Windows driver themselves
2. Rebuild the driver from kernel 6.x sources
3. Apply multiple out-of-tree patches via DKMS A correct mainline
implementation for 7.0 would eliminate all of this.
The chip works =E2=80=94 the patches prove it =E2=80=94 it just needs to be=
 properly
integrated.

System info:
  uname -r: 7.0.0-14-generic
  modinfo mt7925e filename:
/lib/modules/7.0.0-14-generic/updates/dkms/mt7925e.ko.zst
  Firmware build: 20250926200913

Thank you.

Radoslaw Poprawski

--0000000000003da881065537b7d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Hello,<br><br>I&#39;m reporting a missing mainline ker=
nel support issue for the MediaTek MT6639 chip (marketed as MT7927/Wi-Fi 7)=
, which requires out-of-tree DKMS patches to function on Linux kernel 7.0.<=
br><br>=3D=3D Hardware =3D=3D<br><br>Chip: =C2=A0 =C2=A0 =C2=A0MediaTek MT6=
639 (PCI device 14c3:7927)<br>Interface: PCIe<br>Bluetooth: Foxconn/Hon Hai=
 (USB, device 0489:e13a / 13d3:3588)<br>System: =C2=A0 =C2=A0Linux Mint 22.=
3, kernel 7.0.0-14-generic (x86_64)<br>Board: =C2=A0 =C2=A0 Gigabyte Z790 A=
ORUS PRO X<br><br>On boot, the kernel correctly identifies and forces chip =
recognition:<br>=C2=A0 mt7925e 0000:03:00.0: MT6639 raw CHIPID=3D0x0000, fo=
rcing chip=3D0x7927<br>=C2=A0 mt7925e 0000:03:00.0: HW/SW Version: 0x8a108a=
10, Build Time: 20250926200913a<br><br>However, the mt7925e module (OE) is =
loaded only via DKMS =E2=80=94 it is not part of the mainline kernel 7.0 bu=
ild. All mt76-related modules show (OE) flag in dmesg, confirming out-of-tr=
ee status.<br><br>=3D=3D Problem =3D=3D<br><br>The mainline mt7925e driver =
in kernel 7.0 does not include support for MT6639 (0x7927). Getting the chi=
p to work requires:<br><br>1. Manually downloading firmware from linux-firm=
ware (mt7927/ directory)<br>2. Applying out-of-tree patches from <a href=3D=
"https://github.com/jetm/mediatek-mt7927-dkms">https://github.com/jetm/medi=
atek-mt7927-dkms</a><br>3. Building and installing via DKMS<br><br>The firm=
ware was extracted from the Windows driver (mt7927_win_driver.zip, Windows =
driver build date: 20250926).<br><br>=3D=3D Patches required =3D=3D<br><br>=
The following patches were necessary to make the chip functional. I&#39;m a=
ttaching their content inline.<br><br>--- 1. mt6639-bt-6.19.patch (Bluetoot=
h support) ---<br><br>Adds MT6639 (0x6639) device ID support to btmtk.c and=
 btusb.c:<br>- New firmware filename path: mediatek/mt6639/BT_RAM_CODE_MT66=
39_2_1_hdr.bin<br>- Section download filter: only sections with dlmode byte=
0 =3D=3D 0x01 are downloaded<br>=C2=A0 (matches Windows driver behavior, av=
oids chip hang)<br>- Firmware persistence optimization: skip re-download on=
 subsequent BT power cycles<br>=C2=A0 (saves ~2.6s delay on reconnect)<br>-=
 New USB device IDs added to btusb.c:<br>=C2=A0 =C2=A0 0489:e13a, 0489:e0fa=
, 0489:e116, 13d3:3588<br><br>--- 2. mt6639-wifi-dma.patch (WiFi / DMA / EH=
T caps) ---<br><br>Key changes:<br>- init.c: explicit DBDC (dual-band) enab=
le for MT6639 =E2=80=94 without this, firmware<br>=C2=A0 defaults to 2.4GHz=
 only and ignores 5GHz scan requests<br>- main.c: proper 6GHz / 320MHz EHT =
capabilities advertisement<br>- mac.c: 320MHz RX bandwidth reporting (IEEE8=
0211_STA_RX_BW_320)<br>- mt792x_dma.c: MT6639-specific WFDMA DMA prefetch l=
ayout<br>- mt792x_core.c: wfsys reset and mac_enable use is_connac2() inste=
ad of<br>=C2=A0 is_mt7921() =E2=80=94 MT6639 is connac3 but shares the rese=
t path<br>- mt792x_core.c: MCU restart + readiness poll before firmware dow=
nload<br><br>--- 3. mt6639-wifi-init.patch (PCI probe / ring allocation) --=
-<br><br>Key changes:<br>- Dynamic MCU RX ring size from layout struct (mcu=
_rxdone_ring_size)<br>- Conditional MCU WA ring allocation (has_mcu_wa flag=
)<br>- MT7902 IRQ map fix (wm2_complete_mask =3D 0), also applies to MT6639=
 probe path<br>- mt76_for_each_q_rx() loop replaces hardcoded napi_disable(=
) calls<br><br>--- 4. mt7902-wifi-6.19.patch (MT7902 support, related chip)=
 ---<br><br>Adds MT7902 device IDs and firmware paths as a companion fix.<b=
r><br>=3D=3D Current status =3D=3D<br><br>With all patches applied via DKMS=
, the chip is functional:<br>- WiFi works on 2.4GHz, 5GHz, and 6GHz bands<b=
r>- Bluetooth works (btmtk, btusb modules)<a href=3D"about:blank#blocked">a=
bout:blank#blocked</a><br>- No kernel panics or firmware errors in dmesg<br=
><br>=3D=3D Request =3D=3D<br><br>Please consider upstreaming support for M=
T6639 (0x7927) into the mainline mt76 driver.<br>The patches above (from <a=
 href=3D"http://github.com/jetm/mediatek-mt7927-dkms">github.com/jetm/media=
tek-mt7927-dkms</a>) could serve as a starting point.<br><br>I&#39;m happy =
to test patches or provide additional dmesg/firmware dumps if helpful.<div>=
<br></div><div>=3D=3D Regression:works on 6.x, broken on 7.0 =3D=3D
<br><br>The firmware extraction from the Windows driver (mt7927_win_driver.=
zip)
was performed on kernel 6.x, <br>where the chip worked correctly after
loading the extracted firmware =E2=80=94 no additional patching was require=
d.
<br>The issue appeared when upgrading to kernel 7.0.0-14-generic, where
the mt7925e module failed to load / initialize the chip correctly.
<br>The DKMS patches listed below were necessary to restore functionality.
<br>This suggests a kernel API change between 6.x and 7.0 broke
compatibility with the existing mt76/mt7925e driver.<br><br>=3D=3D Core iss=
ue =3D=3D
<br><br>Kernel 7.0 ships with the mt7925e driver in mainline, which gives u=
sers
a false impression that MT6639 (0x7927) is supported. <br>In reality, the
mainline 7.0 driver lacks:

- MT6639 device ID recognition
- Correct firmware paths for mt7927/mt6639
- Required DMA prefetch layout for MT6639
- DBDC initialization <br>(chip defaults to 2.4GHz only without it)
- Bluetooth USB device IDs for the companion BT chip

As a result, users are forced to:
<br>1. Extract firmware from the Windows driver themselves
<br>2. Rebuild the driver from kernel 6.x sources
<br>3. Apply multiple out-of-tree patches via DKMS

A correct mainline implementation for 7.0 would eliminate all of this.
<br>The=C2=A0chip works =E2=80=94 the patches prove it =E2=80=94 it just ne=
eds to be properly
integrated.<br><br>System info:<br>=C2=A0 uname -r: 7.0.0-14-generic<br>=C2=
=A0 modinfo mt7925e filename: /lib/modules/7.0.0-14-generic/updates/dkms/mt=
7925e.ko.zst<br>=C2=A0 Firmware build: 20250926200913<br><br>Thank you.<br>=
<br>Radoslaw Poprawski</div></div>

--0000000000003da881065537b7d2--
--0000000000003da882065537b7d4
Content-Type: text/x-patch; charset="US-ASCII"; name="mt6639-wifi-dma.patch"
Content-Disposition: attachment; filename="mt6639-wifi-dma.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mqw2l42k1>
X-Attachment-Id: f_mqw2l42k1

ZGlmZiAtLWdpdCBhL210NzkyNS9pbml0LmMgYi9tdDc5MjUvaW5pdC5jCmluZGV4IDNjZTVkNmYu
LmQ1MDFhODIgMTAwNjQ0Ci0tLSBhL210NzkyNS9pbml0LmMKKysrIGIvbXQ3OTI1L2luaXQuYwpA
QCAtMTE1LDYgKzExNSwxOCBAQCBzdGF0aWMgaW50IF9fbXQ3OTI1X2luaXRfaGFyZHdhcmUoc3Ry
dWN0IG10NzkyeF9kZXYgKmRldikKIAlpZiAocmV0KQogCQlnb3RvIG91dDsKIAorCS8qIE1UNjYz
OTogRW5hYmxlIERCREMgKGR1YWwtYmFuZCkgbW9kZS4gV2l0aG91dCB0aGlzLCBmaXJtd2FyZQor
CSAqIGRlZmF1bHRzIHRvIDIuNEdIeiBvbmx5IGFuZCBpZ25vcmVzIDVHSHogc2NhbiByZXF1ZXN0
cy4KKwkgKiBNVDc5MjUgZmlybXdhcmUgaGFuZGxlcyBEQkRDIGF1dG9tYXRpY2FsbHkuICovCisJ
aWYgKGlzX210NjYzOSgmZGV2LT5tdDc2KSkgeworCQlyZXQgPSBtdDc5MjVfbWN1X3NldF9kYmRj
KCZkZXYtPm1waHksIHRydWUpOworCQlpZiAocmV0KSB7CisJCQlkZXZfd2FybihkZXYtPm10NzYu
ZGV2LAorCQkJCSAiTVQ2NjM5IERCREMgZW5hYmxlIGZhaWxlZDogJWRcbiIsIHJldCk7CisJCQly
ZXQgPSAwOworCQl9CisJfQorCiBvdXQ6CiAJcmV0dXJuIHJldDsKIH0KZGlmZiAtLWdpdCBhL210
NzkyNS9tYWluLmMgYi9tdDc5MjUvbWFpbi5jCmluZGV4IDJkMzU4YTkuLjRhOTMwYzEgMTAwNjQ0
Ci0tLSBhL210NzkyNS9tYWluLmMKKysrIGIvbXQ3OTI1L21haW4uYwpAQCAtMTgzLDYgKzE4Mywx
MCBAQCBtdDc5MjVfaW5pdF9laHRfY2FwcyhzdHJ1Y3QgbXQ3OTJ4X3BoeSAqcGh5LCBlbnVtIG5s
ODAyMTFfYmFuZCBiYW5kLAogCQlJRUVFODAyMTFfRUhUX1BIWV9DQVAwX1NVX0JFQU1GT1JNRVIg
fAogCQlJRUVFODAyMTFfRUhUX1BIWV9DQVAwX1NVX0JFQU1GT1JNRUU7CiAKKwlpZiAoYmFuZCA9
PSBOTDgwMjExX0JBTkRfNkdIWikKKwkJZWh0X2NhcF9lbGVtLT5waHlfY2FwX2luZm9bMF0gfD0K
KwkJCUlFRUU4MDIxMV9FSFRfUEhZX0NBUDBfMzIwTUhaX0lOXzZHSFo7CisKIAllaHRfY2FwX2Vs
ZW0tPnBoeV9jYXBfaW5mb1swXSB8PQogCQl1OF9lbmNvZGVfYml0cyh1OF9nZXRfYml0cyhzdHMg
LSAxLCBCSVQoMCkpLAogCQkJICAgICAgIElFRUU4MDIxMV9FSFRfUEhZX0NBUDBfQkVBTUZPUk1F
RV9TU184ME1IWl9NQVNLKTsKQEAgLTE5MywxMCArMTk3LDIwIEBAIG10NzkyNV9pbml0X2VodF9j
YXBzKHN0cnVjdCBtdDc5MnhfcGh5ICpwaHksIGVudW0gbmw4MDIxMV9iYW5kIGJhbmQsCiAJCXU4
X2VuY29kZV9iaXRzKHN0cyAtIDEsCiAJCQkgICAgICAgSUVFRTgwMjExX0VIVF9QSFlfQ0FQMV9C
RUFNRk9STUVFX1NTXzE2ME1IWl9NQVNLKTsKIAorCWlmIChiYW5kID09IE5MODAyMTFfQkFORF82
R0haKQorCQllaHRfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1sxXSB8PQorCQkJdThfZW5jb2RlX2Jp
dHMoc3RzIC0gMSwKKwkJCQkgICAgICAgSUVFRTgwMjExX0VIVF9QSFlfQ0FQMV9CRUFNRk9STUVF
X1NTXzMyME1IWl9NQVNLKTsKKwogCWVodF9jYXBfZWxlbS0+cGh5X2NhcF9pbmZvWzJdID0KIAkJ
dThfZW5jb2RlX2JpdHMoc3RzIC0gMSwgSUVFRTgwMjExX0VIVF9QSFlfQ0FQMl9TT1VORElOR19E
SU1fODBNSFpfTUFTSykgfAogCQl1OF9lbmNvZGVfYml0cyhzdHMgLSAxLCBJRUVFODAyMTFfRUhU
X1BIWV9DQVAyX1NPVU5ESU5HX0RJTV8xNjBNSFpfTUFTSyk7CiAKKwlpZiAoYmFuZCA9PSBOTDgw
MjExX0JBTkRfNkdIWikKKwkJZWh0X2NhcF9lbGVtLT5waHlfY2FwX2luZm9bMl0gfD0KKwkJCXU4
X2VuY29kZV9iaXRzKHN0cyAtIDEsCisJCQkJICAgICAgIElFRUU4MDIxMV9FSFRfUEhZX0NBUDJf
U09VTkRJTkdfRElNXzMyME1IWl9NQVNLKTsKKwogCWVodF9jYXBfZWxlbS0+cGh5X2NhcF9pbmZv
WzNdID0KIAkJSUVFRTgwMjExX0VIVF9QSFlfQ0FQM19OR18xNl9TVV9GRUVEQkFDSyB8CiAJCUlF
RUU4MDIxMV9FSFRfUEhZX0NBUDNfTkdfMTZfTVVfRkVFREJBQ0sgfApAQCAtMjE3LDcgKzIzMSw4
IEBAIG10NzkyNV9pbml0X2VodF9jYXBzKHN0cnVjdCBtdDc5MnhfcGh5ICpwaHksIGVudW0gbmw4
MDIxMV9iYW5kIGJhbmQsCiAJCXU4X2VuY29kZV9iaXRzKHU4X2dldF9iaXRzKDB4MTEsIEdFTk1B
U0soMSwgMCkpLAogCQkJICAgICAgIElFRUU4MDIxMV9FSFRfUEhZX0NBUDVfTUFYX05VTV9TVVBQ
X0VIVF9MVEZfTUFTSyk7CiAKLQl2YWwgPSB3aWR0aCA9PSBOTDgwMjExX0NIQU5fV0lEVEhfMTYw
ID8gMHg3IDoKKwl2YWwgPSB3aWR0aCA9PSBOTDgwMjExX0NIQU5fV0lEVEhfMzIwID8gMHhmIDoK
KwkgICAgICB3aWR0aCA9PSBOTDgwMjExX0NIQU5fV0lEVEhfMTYwID8gMHg3IDoKIAkgICAgICB3
aWR0aCA9PSBOTDgwMjExX0NIQU5fV0lEVEhfODAgPyAweDMgOiAweDE7CiAJZWh0X2NhcF9lbGVt
LT5waHlfY2FwX2luZm9bNl0gPQogCQl1OF9lbmNvZGVfYml0cyh1OF9nZXRfYml0cygweDExLCBH
RU5NQVNLKDQsIDIpKSwKQEAgLTIzMCw2ICsyNDUsMTEgQEAgbXQ3OTI1X2luaXRfZWh0X2NhcHMo
c3RydWN0IG10NzkyeF9waHkgKnBoeSwgZW51bSBubDgwMjExX2JhbmQgYmFuZCwKIAkJSUVFRTgw
MjExX0VIVF9QSFlfQ0FQN19NVV9CRUFNRk9STUVSXzgwTUhaIHwKIAkJSUVFRTgwMjExX0VIVF9Q
SFlfQ0FQN19NVV9CRUFNRk9STUVSXzE2ME1IWjsKIAorCWlmIChiYW5kID09IE5MODAyMTFfQkFO
RF82R0haKQorCQllaHRfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1s3XSB8PQorCQkJSUVFRTgwMjEx
X0VIVF9QSFlfQ0FQN19OT05fT0ZETUFfVUxfTVVfTUlNT18zMjBNSFogfAorCQkJSUVFRTgwMjEx
X0VIVF9QSFlfQ0FQN19NVV9CRUFNRk9STUVSXzMyME1IWjsKKwogCXZhbCA9IHU4X2VuY29kZV9i
aXRzKG5zcywgSUVFRTgwMjExX0VIVF9NQ1NfTlNTX1JYKSB8CiAJICAgICAgdThfZW5jb2RlX2Jp
dHMobnNzLCBJRUVFODAyMTFfRUhUX01DU19OU1NfVFgpOwogCkBAIC0yMzksNiArMjU5LDEyIEBA
IG10NzkyNV9pbml0X2VodF9jYXBzKHN0cnVjdCBtdDc5MnhfcGh5ICpwaHksIGVudW0gbmw4MDIx
MV9iYW5kIGJhbmQsCiAJZWh0X25zcy0+YncuXzE2MC5yeF90eF9tY3M5X21heF9uc3MgPSB2YWw7
CiAJZWh0X25zcy0+YncuXzE2MC5yeF90eF9tY3MxMV9tYXhfbnNzID0gdmFsOwogCWVodF9uc3Mt
PmJ3Ll8xNjAucnhfdHhfbWNzMTNfbWF4X25zcyA9IHZhbDsKKworCWlmIChiYW5kID09IE5MODAy
MTFfQkFORF82R0haKSB7CisJCWVodF9uc3MtPmJ3Ll8zMjAucnhfdHhfbWNzOV9tYXhfbnNzID0g
dmFsOworCQllaHRfbnNzLT5idy5fMzIwLnJ4X3R4X21jczExX21heF9uc3MgPSB2YWw7CisJCWVo
dF9uc3MtPmJ3Ll8zMjAucnhfdHhfbWNzMTNfbWF4X25zcyA9IHZhbDsKKwl9CiB9CiAKIGludCBt
dDc5MjVfaW5pdF9tbG9fY2FwcyhzdHJ1Y3QgbXQ3OTJ4X3BoeSAqcGh5KQpkaWZmIC0tZ2l0IGEv
bXQ3OTI1L21hYy5jIGIvbXQ3OTI1L21hYy5jCmluZGV4IDg3MWI2NzEuLmEyMDcwZWYgMTAwNjQ0
Ci0tLSBhL210NzkyNS9tYWMuYworKysgYi9tdDc5MjUvbWFjLmMKQEAgLTMzNiwxMCArMzM2LDE1
IEBAIG10NzkyNV9tYWNfZmlsbF9yeF9yYXRlKHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYsCiAJY2Fz
ZSBJRUVFODAyMTFfU1RBX1JYX0JXXzgwOgogCQlzdGF0dXMtPmJ3ID0gUkFURV9JTkZPX0JXXzgw
OwogCQlicmVhazsKIAljYXNlIElFRUU4MDIxMV9TVEFfUlhfQldfMTYwOgogCQlzdGF0dXMtPmJ3
ID0gUkFURV9JTkZPX0JXXzE2MDsKIAkJYnJlYWs7CisJLyogUlhWIGNhbiByZXBvcnQgMzIwIGlu
IHR3byBwb3NpdGlvbnMgKi8KKwljYXNlIElFRUU4MDIxMV9TVEFfUlhfQldfMzIwOgorCWNhc2Ug
SUVFRTgwMjExX1NUQV9SWF9CV18zMjAgKyAxOgorCQlzdGF0dXMtPmJ3ID0gUkFURV9JTkZPX0JX
XzMyMDsKKwkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCkBAIC05
OTMsNiArOTk4LDEwIEBAIG10NzkyNV9tYWNfYWRkX3R4c19za2Ioc3RydWN0IG10NzkyeF9kZXYg
KmRldiwgc3RydWN0IG10NzZfd2NpZCAqd2NpZCwKIAlzd2l0Y2ggKEZJRUxEX0dFVChNVF9UWFMw
X0JXLCB0eHMpKSB7CisJY2FzZSBJRUVFODAyMTFfU1RBX1JYX0JXXzMyMDoKKwkJcmF0ZS5idyA9
IFJBVEVfSU5GT19CV18zMjA7CisJCXN0YXRzLT50eF9id1s0XSsrOworCQlicmVhazsKIAljYXNl
IElFRUU4MDIxMV9TVEFfUlhfQldfMTYwOgogCQlyYXRlLmJ3ID0gUkFURV9JTkZPX0JXXzE2MDsK
IAkJc3RhdHMtPnR4X2J3WzNdKys7CiAJCWJyZWFrOwogCWNhc2UgSUVFRTgwMjExX1NUQV9SWF9C
V184MDoKZGlmZiAtLWdpdCBhL210NzkyNS9tY3UuYyBiL210NzkyNS9tY3UuYwppbmRleCBjZjBm
ZGVhLi5kMDAwMWUwIDEwMDY0NAotLS0gYS9tdDc5MjUvbWN1LmMKKysrIGIvbXQ3OTI1L21jdS5j
CkBAIC0xNjgzLDYgKzE2ODMsNyBAQCBtdDc5MjVfbWN1X3N0YV9laHRfdGx2KHN0cnVjdCBza19i
dWZmICpza2IsIHN0cnVjdCBpZWVlODAyMTFfbGlua19zdGEgKmxpbmtfc3RhKQogCQltZW1jcHko
ZWh0LT5tY3NfbWFwX2J3MjAsICZtY3NfbWFwLT5vbmx5XzIwbWh6LCBzaXplb2YoZWh0LT5tY3Nf
bWFwX2J3MjApKTsKIAltZW1jcHkoZWh0LT5tY3NfbWFwX2J3ODAsICZtY3NfbWFwLT5idy5fODAs
IHNpemVvZihlaHQtPm1jc19tYXBfYnc4MCkpOwogCW1lbWNweShlaHQtPm1jc19tYXBfYncxNjAs
ICZtY3NfbWFwLT5idy5fMTYwLCBzaXplb2YoZWh0LT5tY3NfbWFwX2J3MTYwKSk7CisJbWVtY3B5
KGVodC0+bWNzX21hcF9idzMyMCwgJm1jc19tYXAtPmJ3Ll8zMjAsIHNpemVvZihlaHQtPm1jc19t
YXBfYnczMjApKTsKIH0KIAogc3RhdGljIHZvaWQKQEAgLTIzMzEsNiArMjMzMiw5IEBAIHZvaWQg
bXQ3OTI1X21jdV9ic3NfcmxtX3RsdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbXQ3Nl9w
aHkgKnBoeSwKIAljYXNlIE5MODAyMTFfQ0hBTl9XSURUSF8xNjA6CiAJCXJlcS0+YncgPSBDTURf
Q0JXXzE2ME1IWjsKIAkJYnJlYWs7CisJY2FzZSBOTDgwMjExX0NIQU5fV0lEVEhfMzIwOgorCQly
ZXEtPmJ3ID0gQ01EX0NCV18zMjBNSFo7CisJCWJyZWFrOwogCWNhc2UgTkw4MDIxMV9DSEFOX1dJ
RFRIXzU6CiAJCXJlcS0+YncgPSBDTURfQ0JXXzVNSFo7CiAJCWJyZWFrOwpkaWZmIC0tZ2l0IGEv
bXQ3OTI1L210NzkyNS5oIGIvbXQ3OTI1L210NzkyNS5oCmluZGV4IDZiOWJmMWIuLmQ0NzZiMTMg
MTAwNjQ0Ci0tLSBhL210NzkyNS9tdDc5MjUuaAorKysgYi9tdDc5MjUvbXQ3OTI1LmgKQEAgLTEy
Niw2ICsxMjYsMTMgQEAgZW51bSBtdDc5MjVfcnhxX2lkIHsKIAlNVDc5MjVfUlhRX01DVV9XTTIs
IC8qIGZvciB0eCBkb25lICovCiB9OwogCisvKiBNVDY2MzkgdXNlcyBkaWZmZXJlbnQgUlggcmlu
ZyBpbmRpY2VzIHRoYW4gTVQ3OTI1ICovCitlbnVtIG10NjYzOV9yeHFfaWQgeworCU1UNjYzOV9S
WFFfQkFORDAgPSA0LAorCU1UNjYzOV9SWFFfTUNVX1dNID0gNiwKKwlNVDY2MzlfUlhRX0RBVEEy
ID0gNywKK307CisKIGVudW0gewogCU1PREVfT1BFTiA9IDAsCiAJTU9ERV9TSEFSRUQgPSAxLApk
aWZmIC0tZ2l0IGEvbXQ3OTI1L3BjaS5jIGIvbXQ3OTI1L3BjaS5jCmluZGV4IGRiMDUzYmQuLjY4
MzgzYWMgMTAwNjQ0Ci0tLSBhL210NzkyNS9wY2kuYworKysgYi9tdDc5MjUvcGNpLmMKQEAgLTMy
NCw2ICszMjQsMTI2IEBAIHN0YXRpYyB2b2lkIG10NjYzOV9jYnRvcF9yZW1hcChzdHJ1Y3QgbXQ3
OTJ4X2RldiAqZGV2KQogCW10NzZfcnIoZGV2LCBNVF9DQklORlJBX01JU0MwX1JFTUFQX1dGKTsK
IH0KIAorc3RhdGljIGludCBtdDY2MzlfZG1hX2luaXQoc3RydWN0IG10NzkyeF9kZXYgKmRldikK
K3sKKwlpbnQgcmV0OworCisJbXQ3Nl9kbWFfYXR0YWNoKCZkZXYtPm10NzYpOworCisJLyogRG8g
U0VUX09XTiAtPiBDTFJfT1dOIG5vdyB0aGF0IENCVE9QIGFuZCBDQkluZnJhIGFyZSByZWFkeS4K
KwkgKiBDTFJfT1dOIHRyaWdnZXJzIHRoZSBST00gdG8gaW5pdGlhbGl6ZSBXRkRNQSBwcm9wZXJs
eS4gKi8KKwlyZXQgPSBtdDc5MnhlX21jdV9md19wbWN0cmwoZGV2KTsKKwlpZiAocmV0KQorCQly
ZXR1cm4gcmV0OworCisJcmV0ID0gX19tdDc5MnhlX21jdV9kcnZfcG1jdHJsKGRldik7CisJaWYg
KHJldCkKKwkJcmV0dXJuIHJldDsKKworCS8qIENsZWFyIHBlbmRpbmcgaW50ZXJydXB0cyBmcm9t
IHByZXZpb3VzIHN0YXRlICovCisJbXQ3Nl93cihkZXYsIE1UX1dGRE1BMF9IT1NUX0lOVF9TVEEs
IH4wKTsKKworCS8qIERpc2FibGUgRE1BICovCisJbXQ3Nl9jbGVhcihkZXYsIE1UX1dGRE1BMF9H
TE9fQ0ZHLAorCQkgICBNVF9XRkRNQTBfR0xPX0NGR19UWF9ETUFfRU4gfAorCQkgICBNVF9XRkRN
QTBfR0xPX0NGR19SWF9ETUFfRU4gfAorCQkgICBNVF9XRkRNQTBfR0xPX0NGR19DU1JfRElTUF9C
QVNFX1BUUl9DSEFJTl9FTiB8CisJCSAgIE1UX1dGRE1BMF9HTE9fQ0ZHX09NSVRfVFhfSU5GTyB8
CisJCSAgIE1UX1dGRE1BMF9HTE9fQ0ZHX09NSVRfUlhfSU5GT19QRkVUMik7CisJd21iKCk7CisK
KwlpZiAoIW10NzZfcG9sbF9tc2VjX3RpY2soZGV2LCBNVF9XRkRNQTBfR0xPX0NGRywKKwkJCQkg
TVRfV0ZETUEwX0dMT19DRkdfVFhfRE1BX0JVU1kgfAorCQkJCSBNVF9XRkRNQTBfR0xPX0NGR19S
WF9ETUFfQlVTWSwgMCwgMTAwLCAxKSkKKwkJcmV0dXJuIC1FVElNRURPVVQ7CisKKwkvKiBSZXNl
dCBETUEgZGVzY3JpcHRvciBwb2ludGVycyAqLworCW10NzZfd3IoZGV2LCBNVF9XRkRNQTBfUlNU
X0RUWF9QVFIsIH4wKTsKKwltdDc2X3dyKGRldiwgTVRfV0ZETUEwX1JTVF9EUlhfUFRSLCB+MCk7
CisJd21iKCk7CisJbXNsZWVwKDEwKTsKKworCS8qIGluaXQgdHggcXVldWUgLSByaW5nIDAgKi8K
KwlyZXQgPSBtdDc2X2Nvbm5hY19pbml0X3R4X3F1ZXVlcyhkZXYtPnBoeS5tdDc2LCBNVDc5MjVf
VFhRX0JBTkQwLAorCQkJCQkgTVQ3OTI1X1RYX1JJTkdfU0laRSwKKwkJCQkJIE1UX1RYX1JJTkdf
QkFTRSwgTlVMTCwgMCk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCW10NzZfd3IoZGV2
LCBNVF9XRkRNQTBfVFhfUklORzBfRVhUX0NUUkwsIDB4NCk7CisKKwkvKiBjb21tYW5kIHRvIFdN
IC0gcmluZyAxNSAqLworCXJldCA9IG10NzZfaW5pdF9tY3VfcXVldWUoJmRldi0+bXQ3NiwgTVRf
TUNVUV9XTSwKKwkJCQkgIE1UNzkyNV9UWFFfTUNVX1dNLAorCQkJCSAgTVQ3OTI1X1RYX01DVV9S
SU5HX1NJWkUsIE1UX1RYX1JJTkdfQkFTRSk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKwor
CS8qIGZpcm13YXJlIGRvd25sb2FkIC0gcmluZyAxNiAqLworCXJldCA9IG10NzZfaW5pdF9tY3Vf
cXVldWUoJmRldi0+bXQ3NiwgTVRfTUNVUV9GV0RMLAorCQkJCSAgTVQ3OTI1X1RYUV9GV0RMLAor
CQkJCSAgTVQ3OTI1X1RYX0ZXRExfUklOR19TSVpFLCBNVF9UWF9SSU5HX0JBU0UpOworCWlmIChy
ZXQpCisJCXJldHVybiByZXQ7CisKKwkvKiByeCBNQ1UgZXZlbnRzIC0gcmluZyA2IChNVDc5MjUg
dXNlcyByaW5nIDApICovCisJcmV0ID0gbXQ3Nl9xdWV1ZV9hbGxvYyhkZXYsICZkZXYtPm10NzYu
cV9yeFtNVF9SWFFfTUNVXSwKKwkJCSAgICAgICBNVDY2MzlfUlhRX01DVV9XTSwgTVQ3OTI1X1JY
X01DVV9SSU5HX1NJWkUsCisJCQkgICAgICAgTVRfUlhfQlVGX1NJWkUsIE1UX1JYX0VWRU5UX1JJ
TkdfQkFTRSk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCS8qIHJ4IGRhdGEgLSByaW5n
IDQgKE1UNzkyNSB1c2VzIHJpbmcgMikgKi8KKwlyZXQgPSBtdDc2X3F1ZXVlX2FsbG9jKGRldiwg
JmRldi0+bXQ3Ni5xX3J4W01UX1JYUV9NQUlOXSwKKwkJCSAgICAgICBNVDY2MzlfUlhRX0JBTkQw
LCBNVDc5MjVfUlhfUklOR19TSVpFLAorCQkJICAgICAgIE1UX1JYX0JVRl9TSVpFLCBNVF9SWF9E
QVRBX1JJTkdfQkFTRSk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsKKworCS8qIHJ4IGF1eGls
aWFyeSAtIHJpbmcgNzogbWFuYWdlbWVudCBmcmFtZXMgKi8KKwlyZXQgPSBtdDc2X3F1ZXVlX2Fs
bG9jKGRldiwgJmRldi0+bXQ3Ni5xX3J4W01UX1JYUV9NQ1VfV0FdLAorCQkJICAgICAgIE1UNjYz
OV9SWFFfREFUQTIsIE1UNzkyNV9SWF9NQ1VfUklOR19TSVpFLAorCQkJICAgICAgIE1UX1JYX0JV
Rl9TSVpFLCBNVF9SWF9EQVRBX1JJTkdfQkFTRSk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsK
KworCXJldCA9IG10NzZfaW5pdF9xdWV1ZXMoZGV2LCBtdDc5MnhfcG9sbF9yeCk7CisJaWYgKHJl
dCA8IDApCisJCXJldHVybiByZXQ7CisKKwluZXRpZl9uYXBpX2FkZF90eChkZXYtPm10NzYudHhf
bmFwaV9kZXYsICZkZXYtPm10NzYudHhfbmFwaSwKKwkJCSAgbXQ3OTJ4X3BvbGxfdHgpOworCW5h
cGlfZW5hYmxlKCZkZXYtPm10NzYudHhfbmFwaSk7CisKKwkvKiBNVDY2Mzktc3BlY2lmaWMgR0xP
X0NGRyBiaXRzIGJlZm9yZSBETUEgZW5hYmxlICovCisJbXQ3Nl9zZXQoZGV2LCBNVF9XRkRNQTBf
R0xPX0NGRywgTVRfV0ZETUEwX0dMT19DRkdfQUREUl9FWFRfRU4pOworCW10NzZfY2xlYXIoZGV2
LCBNVF9XRkRNQTBfR0xPX0NGRywgTVRfV0ZETUEwX0dMT19DRkdfQ1NSX0xCS19SWF9RX1NFTF9F
Tik7CisJbXQ3Nl9zZXQoZGV2LCBNVF9XRkRNQTBfR0xPX0NGRywKKwkJIE1UX1dGRE1BMF9HTE9f
Q0ZHX0ZXX0RXTERfQllQQVNTX0RNQVNIREwpOworCisJcmV0ID0gbXQ3OTJ4X2RtYV9lbmFibGUo
ZGV2KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJLyogRW5hYmxlIGludGVycnVwdHMg
c3luY2hyb25vdXNseSAqLworCW10NzZfd3IoZGV2LCBNVF9XRkRNQTBfSE9TVF9JTlRfRU5BLCBk
ZXYtPm10NzYubW1pby5pcnFtYXNrKTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgY29uc3Qg
c3RydWN0IG10NzkyeF9pcnFfbWFwIG10NjYzOV9pcnFfbWFwID0geworCS5ob3N0X2lycV9lbmFi
bGUgPSBNVF9XRkRNQTBfSE9TVF9JTlRfRU5BLAorCS50eCA9IHsKKwkJLmFsbF9jb21wbGV0ZV9t
YXNrID0gTVRfSU5UX1RYX0RPTkVfQUxMLAorCQkubWN1X2NvbXBsZXRlX21hc2sgPSBNVF9JTlRf
VFhfRE9ORV9NQ1UsCisJfSwKKwkucnggPSB7CisJCS5kYXRhX2NvbXBsZXRlX21hc2sgPSBIT1NU
X1JYX0RPTkVfSU5UX0VOQTQsCisJCS53bV9jb21wbGV0ZV9tYXNrID0gSE9TVF9SWF9ET05FX0lO
VF9FTkE2LAorCQkud20yX2NvbXBsZXRlX21hc2sgPSBIT1NUX1JYX0RPTkVfSU5UX0VOQTcsCisJ
fSwKK307CisKIHN0YXRpYyBpbnQgbXQ3OTI1X3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRl
diwKIAkJCSAgICBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCiB7CkBAIC0zOTYsNyAr
NTE2LDE0IEBAIHN0YXRpYyBpbnQgbXQ3OTI1X3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRl
diwKIAlpZiAocmV0KQogCQlnb3RvIGVycl9mcmVlX3BjaV92ZWM7CiAKLQlpZiAobXQ3OTI1X2Rp
c2FibGVfYXNwbSkKKwkvKiBNVDY2MzkgQ09OTklORlJBIHBvd2VyIGRvbWFpbiBhbmQgV0ZETUEg
cmVnaXN0ZXIgYWNjZXNzIGFyZQorCSAqIHVucmVsaWFibGUgd2l0aCBQQ0llIEwxIGFjdGl2ZSwg
Y2F1c2luZyB0aHJvdWdocHV0IHRvIGRyb3AKKwkgKiBmcm9tIDErIEdicHMgdG8gfjIwMCBNYnBz
LiAgRGlzYWJsZSBBU1BNIHVuY29uZGl0aW9uYWxseQorCSAqIHJhdGhlciB0aGFuIG9ubHkgTDEs
IHNpbmNlIEwwcyBzYXZpbmdzIGFyZSBuZWdsaWdpYmxlIGZvcgorCSAqIGEgUENJZSBXTEFOIGNh
cmQgYW5kIG10NzZfcGNpX2Rpc2FibGVfYXNwbSgpIGFscmVhZHkKKwkgKiBoYW5kbGVzIGJvdGgg
ZGV2aWNlIGFuZCBwYXJlbnQgYnJpZGdlIGluIG9uZSBjYWxsLgorCSAqLworCWlmIChtdDc5MjVf
ZGlzYWJsZV9hc3BtIHx8IGlzX210NjYzOV9odykKIAkJbXQ3Nl9wY2lfZGlzYWJsZV9hc3BtKHBk
ZXYpOwogCiAJb3BzID0gbXQ3OTJ4X2dldF9tYWM4MDIxMV9vcHMoJnBkZXYtPmRldiwgJm10Nzky
NV9vcHMsCkBAIC00MDYsNiArNTMzLDE2IEBAIHN0YXRpYyBpbnQgbXQ3OTI1X3BjaV9wcm9iZShz
dHJ1Y3QgcGNpX2RldiAqcGRldiwKIAkJZ290byBlcnJfZnJlZV9wY2lfdmVjOwogCX0KIAorCS8q
IE1UNjYzOSBmaXJtd2FyZSBsYWNrcyB0aGUgY29ubmFjMiBmZWF0dXJlIHRyYWlsZXIsIHNvCisJ
ICogbXQ3OTJ4X2dldF9tYWM4MDIxMV9vcHMoKSBjYW4ndCBkZXRlY3QgQ05NIHN1cHBvcnQgYW5k
CisJICogcmVwbGFjZXMgY2hhbmN0eC9ST0MvbWdkX3ByZXBhcmVfdHggb3BzIHdpdGggc3R1YnMu
CisJICogRm9yY2UgQ05NIGFuZCByZXN0b3JlIHRoZSBvcmlnaW5hbCBtdDc5MjUgb3BzLiAqLwor
CWlmICgocGRldi0+ZGV2aWNlID09IDB4NjYzOSB8fCBwZGV2LT5kZXZpY2UgPT0gMHg3OTI3KSAm
JgorCSAgICAhKGZlYXR1cmVzICYgTVQ3OTJ4X0ZXX0NBUF9DTk0pKSB7CisJCWZlYXR1cmVzIHw9
IE1UNzkyeF9GV19DQVBfQ05NOworCQltZW1jcHkob3BzLCAmbXQ3OTI1X29wcywgc2l6ZW9mKCpv
cHMpKTsKKwl9CisKIAltZGV2ID0gbXQ3Nl9hbGxvY19kZXZpY2UoJnBkZXYtPmRldiwgc2l6ZW9m
KCpkZXYpLCBvcHMsICZkcnZfb3BzKTsKIAlpZiAoIW1kZXYpIHsKIAkJcmV0ID0gLUVOT01FTTsK
QEAgLTQxNyw3ICs1NTQsMTAgQEAgc3RhdGljIGludCBtdDc5MjVfcGNpX3Byb2JlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LAogCWRldiA9IGNvbnRhaW5lcl9vZihtZGV2LCBzdHJ1Y3QgbXQ3OTJ4X2Rl
diwgbXQ3Nik7CiAJZGV2LT5md19mZWF0dXJlcyA9IGZlYXR1cmVzOwogCWRldi0+aGlmX29wcyA9
ICZtdDc5MjVfcGNpZV9vcHM7Ci0JZGV2LT5pcnFfbWFwID0gJmlycV9tYXA7CisJaWYgKGlzX210
NjYzOV9odykKKwkJZGV2LT5pcnFfbWFwID0gJm10NjYzOV9pcnFfbWFwOworCWVsc2UKKwkJZGV2
LT5pcnFfbWFwID0gJmlycV9tYXA7CiAJbXQ3Nl9tbWlvX2luaXQoJmRldi0+bXQ3NiwgcGNpbV9p
b21hcF90YWJsZShwZGV2KVswXSk7CiAJdGFza2xldF9pbml0KCZtZGV2LT5pcnFfdGFza2xldCwg
bXQ3OTJ4X2lycV90YXNrbGV0LCAodW5zaWduZWQgbG9uZylkZXYpOwogCkBAIC00ODcsNyArNjI3
LDEwIEBAIHN0YXRpYyBpbnQgbXQ3OTI1X3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwK
IAlpZiAocmV0KQogCQlnb3RvIGVycl9mcmVlX2RldjsKIAotCXJldCA9IG10NzkyNV9kbWFfaW5p
dChkZXYpOworCWlmIChpc19tdDY2MzlfaHcpCisJCXJldCA9IG10NjYzOV9kbWFfaW5pdChkZXYp
OworCWVsc2UKKwkJcmV0ID0gbXQ3OTI1X2RtYV9pbml0KGRldik7CiAJaWYgKHJldCkKIAkJZ290
byBlcnJfZnJlZV9pcnE7CiAKQEAgLTYyNyw3ICs3NzAsMTAgQEAgc3RhdGljIGludCBfbXQ3OTI1
X3BjaV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2aWNlLCBib29sIHJlc3RvcmUpCiAJbXQ3Nl93
cihkZXYsIE1UX1BDSUVfTUFDX0lOVF9FTkFCTEUsIDB4ZmYpOwogCW10NzZfY29ubmFjX2lycV9l
bmFibGUoJmRldi0+bXQ3NiwKIAkJCSAgICAgICBkZXYtPmlycV9tYXAtPnR4LmFsbF9jb21wbGV0
ZV9tYXNrIHwKLQkJCSAgICAgICBNVF9JTlRfUlhfRE9ORV9BTEwgfCBNVF9JTlRfTUNVX0NNRCk7
CisJCQkgICAgICAgZGV2LT5pcnFfbWFwLT5yeC5kYXRhX2NvbXBsZXRlX21hc2sgfAorCQkJICAg
ICAgIGRldi0+aXJxX21hcC0+cngud21fY29tcGxldGVfbWFzayB8CisJCQkgICAgICAgZGV2LT5p
cnFfbWFwLT5yeC53bTJfY29tcGxldGVfbWFzayB8CisJCQkgICAgICAgTVRfSU5UX01DVV9DTUQp
OwogCW10NzZfc2V0KGRldiwgTVRfTUNVMkhPU1RfU1dfSU5UX0VOQSwgTVRfTUNVX0NNRF9XQUtF
X1JYX1BDSUUpOwogCiAJLyogcHV0IGRtYSBlbmFibGVkICovCmRpZmYgLS1naXQgYS9tdDc5MjUv
cGNpX21hYy5jIGIvbXQ3OTI1L3BjaV9tYWMuYwppbmRleCAzMDcyODUwLi45YzY2ZTQ4IDEwMDY0
NAotLS0gYS9tdDc5MjUvcGNpX21hYy5jCisrKyBiL210NzkyNS9wY2lfbWFjLmMKQEAgLTcyLDYg
KzcyLDE0IEBAIGludCBtdDc5MjVlX21hY19yZXNldChzdHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2KQog
CWNvbnN0IHN0cnVjdCBtdDc5MnhfaXJxX21hcCAqaXJxX21hcCA9IGRldi0+aXJxX21hcDsKIAlp
bnQgaSwgZXJyOwogCisJLyogTVQ2NjM5OiBDTFJfT1dOIGFuZCBXUERNQSByZXNldCBkZXN0cm95
IERNQSByaW5nIGNvbmZpZ3VyYXRpb24uCisJICogQSBmdWxsIHJlc2V0IHJlcXVpcmVzIHJlLXJ1
bm5pbmcgbXQ2NjM5X2RtYV9pbml0KCkgd2hpY2ggaXMgbm90CisJICogeWV0IGltcGxlbWVudGVk
IGluIHRoZSByZWNvdmVyeSBwYXRoLiAqLworCWlmIChpc19tdDY2MzkoJmRldi0+bXQ3NikpIHsK
KwkJZGV2X3dhcm4oZGV2LT5tdDc2LmRldiwgIk1UNjYzOSBtYWNfcmVzZXQgbm90IHN1cHBvcnRl
ZCwgcmVsb2FkIG1vZHVsZSB0byByZWNvdmVyXG4iKTsKKwkJcmV0dXJuIC1FT1BOT1RTVVBQOwor
CX0KKwogCW10NzkyeGVfbWN1X2Rydl9wbWN0cmwoZGV2KTsKIAogCW10NzZfY29ubmFjX2ZyZWVf
cGVuZGluZ190eF9za2JzKCZkZXYtPnBtLCBOVUxMKTsKQEAgLTExOCw3ICsxMjYsMTAgQEAgaW50
IG10NzkyNWVfbWFjX3Jlc2V0KHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYpCiAKIAltdDc2X3dyKGRl
diwgZGV2LT5pcnFfbWFwLT5ob3N0X2lycV9lbmFibGUsCiAJCWRldi0+aXJxX21hcC0+dHguYWxs
X2NvbXBsZXRlX21hc2sgfAotCQlNVF9JTlRfUlhfRE9ORV9BTEwgfCBNVF9JTlRfTUNVX0NNRCk7
CisJCWRldi0+aXJxX21hcC0+cnguZGF0YV9jb21wbGV0ZV9tYXNrIHwKKwkJZGV2LT5pcnFfbWFw
LT5yeC53bV9jb21wbGV0ZV9tYXNrIHwKKwkJZGV2LT5pcnFfbWFwLT5yeC53bTJfY29tcGxldGVf
bWFzayB8CisJCU1UX0lOVF9NQ1VfQ01EKTsKIAltdDc2X3dyKGRldiwgTVRfUENJRV9NQUNfSU5U
X0VOQUJMRSwgMHhmZik7CiAKIAllcnIgPSBtdDc5MnhlX21jdV9md19wbWN0cmwoZGV2KTsKZGlm
ZiAtLWdpdCBhL210NzkyNS9wY2lfbWN1LmMgYi9tdDc5MjUvcGNpX21jdS5jCmluZGV4IDZjY2Vm
ZjguLjgzZjE3MjMgMTAwNjQ0Ci0tLSBhL210NzkyNS9wY2lfbWN1LmMKKysrIGIvbXQ3OTI1L3Bj
aV9tY3UuYwpAQCAtMzUsMTMgKzM1LDIwIEBAIGludCBtdDc5MjVlX21jdV9pbml0KHN0cnVjdCBt
dDc5MnhfZGV2ICpkZXYpCiAKIAlkZXYtPm10NzYubWN1X29wcyA9ICZtdDc5MjVfbWN1X29wczsK
IAotCWVyciA9IG10NzkyeGVfbWN1X2Z3X3BtY3RybChkZXYpOwotCWlmIChlcnIpCi0JCXJldHVy
biBlcnI7CisJaWYgKGlzX210NjYzOSgmZGV2LT5tdDc2KSkgeworCQkvKiBNVDY2Mzk6IENMUl9P
V04gd2FzIGFscmVhZHkgZG9uZSBpbiBtdDY2MzlfZG1hX2luaXQoKS4KKwkJICogVGhlIFJPTSBy
ZS1pbml0aWFsaXplcyBXRkRNQSBvbiBldmVyeSBDTFJfT1dOLCB3aXBpbmcKKwkJICogcmluZyBh
bmQgcHJlZmV0Y2ggY29uZmlnLiBTa2lwIFNFVF9PV04vQ0xSX09XTiBoZXJlCisJCSAqIHRvIHBy
ZXNlcnZlIERNQSBzdGF0ZS4gKi8KKwl9IGVsc2UgeworCQllcnIgPSBtdDc5MnhlX21jdV9md19w
bWN0cmwoZGV2KTsKKwkJaWYgKGVycikKKwkJCXJldHVybiBlcnI7CiAKLQllcnIgPSBfX210Nzky
eGVfbWN1X2Rydl9wbWN0cmwoZGV2KTsKLQlpZiAoZXJyKQotCQlyZXR1cm4gZXJyOworCQllcnIg
PSBfX210NzkyeGVfbWN1X2Rydl9wbWN0cmwoZGV2KTsKKwkJaWYgKGVycikKKwkJCXJldHVybiBl
cnI7CisJfQogCiAJbXQ3Nl9ybXdfZmllbGQoZGV2LCBNVF9QQ0lFX01BQ19QTSwgTVRfUENJRV9N
QUNfUE1fTDBTX0RJUywgMSk7CiAKZGlmZiAtLWdpdCBhL210NzkyeF9kbWEuYyBiL210NzkyeF9k
bWEuYwppbmRleCAwMDJhZWNlLi4wNGMwNjYzIDEwMDY0NAotLS0gYS9tdDc5MnhfZG1hLmMKKysr
IGIvbXQ3OTJ4X2RtYS5jCkBAIC05MCw3ICs5MCwyMyBAQCBFWFBPUlRfU1lNQk9MX0dQTChtdDc5
MnhfcnhfcG9sbF9jb21wbGV0ZSk7CiAjZGVmaW5lIFBSRUZFVENIKGJhc2UsIGRlcHRoKQkoKGJh
c2UpIDw8IDE2IHwgKGRlcHRoKSkKIHN0YXRpYyB2b2lkIG10NzkyeF9kbWFfcHJlZmV0Y2goc3Ry
dWN0IG10NzkyeF9kZXYgKmRldikKIHsKLQlpZiAoaXNfbXQ3OTI1KCZkZXYtPm10NzYpKSB7CisJ
aWYgKGlzX210NjYzOSgmZGV2LT5tdDc2KSkgeworCQkvKiBUcmlnZ2VyIHByZWZldGNoIGNvbnRy
b2xsZXIgcmVzZXQgYmVmb3JlIHJlcHJvZ3JhbW1pbmcgKi8KKwkJbXQ3Nl93cihkZXYsIE1UX1dG
RE1BX1BSRUZFVENIX0NUUkwsCisJCQltdDc2X3JyKGRldiwgTVRfV0ZETUFfUFJFRkVUQ0hfQ1RS
TCkpOworCQkvKiBNVDY2MzkgdXNlcyBwYWNrZWQgcHJlZmV0Y2ggcmVnaXN0ZXJzICovCisJCW10
NzZfd3IoZGV2LCBNVF9XRkRNQV9QUkVGRVRDSF9DRkcwLCAweDY2MDA3Nyk7CisJCW10NzZfd3Io
ZGV2LCBNVF9XRkRNQV9QUkVGRVRDSF9DRkcxLCAweDExMDApOworCQltdDc2X3dyKGRldiwgTVRf
V0ZETUFfUFJFRkVUQ0hfQ0ZHMiwgMHgzMDAwNGYpOworCQltdDc2X3dyKGRldiwgTVRfV0ZETUFf
UFJFRkVUQ0hfQ0ZHMywgMHg1NDIyMDApOworCQkvKiBwZXItcmluZyBFWFRfQ1RSTCAqLworCQlt
dDc2X3dyKGRldiwgTVRfV0ZETUEwX1JYX1JJTkc0X0VYVF9DVFJMLCBQUkVGRVRDSCgweDAwMDAs
IDB4OCkpOworCQltdDc2X3dyKGRldiwgTVRfV0ZETUEwX1JYX1JJTkc2X0VYVF9DVFJMLCBQUkVG
RVRDSCgweDAwODAsIDB4OCkpOworCQltdDc2X3dyKGRldiwgTVRfV0ZETUEwX1JYX1JJTkc3X0VY
VF9DVFJMLCBQUkVGRVRDSCgweDAxMDAsIDB4NCkpOworCQltdDc2X3dyKGRldiwgTVRfV0ZETUEw
X1RYX1JJTkcxNl9FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwMTQwLCAweDQpKTsKKwkJbXQ3Nl93cihk
ZXYsIE1UX1dGRE1BMF9UWF9SSU5HMTVfRVhUX0NUUkwsIFBSRUZFVENIKDB4MDE4MCwgMHgxMCkp
OworCQltdDc2X3dyKGRldiwgTVRfV0ZETUEwX1RYX1JJTkcwX0VYVF9DVFJMLCBQUkVGRVRDSCgw
eDAyODAsIDB4NCkpOworCX0gZWxzZSBpZiAoaXNfbXQ3OTI1KCZkZXYtPm10NzYpKSB7CiAJCS8q
IHJ4IHJpbmcgKi8KIAkJbXQ3Nl93cihkZXYsIE1UX1dGRE1BMF9SWF9SSU5HMF9FWFRfQ1RSTCwg
UFJFRkVUQ0goMHgwMDAwLCAweDQpKTsKIAkJbXQ3Nl93cihkZXYsIE1UX1dGRE1BMF9SWF9SSU5H
MV9FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwMDQwLCAweDQpKTsKQEAgLTE2Niw2ICsxODIsMTQgQEAg
aW50IG10NzkyeF9kbWFfZW5hYmxlKHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYpCiAJbXQ3Nl9zZXQo
ZGV2LCBNVF9XRkRNQTBfR0xPX0NGRywKIAkJIE1UX1dGRE1BMF9HTE9fQ0ZHX1RYX0RNQV9FTiB8
IE1UX1dGRE1BMF9HTE9fQ0ZHX1JYX0RNQV9FTik7CiAKKwlpZiAoaXNfbXQ2NjM5KCZkZXYtPm10
NzYpKSB7CisJCW10NzZfc2V0KGRldiwgTVRfV0ZETUEwX0dMT19DRkcsCisJCQkgTVRfV0ZETUEw
X0dMT19DRkdfQUREUl9FWFRfRU4gfAorCQkJIE1UX1dGRE1BMF9HTE9fQ0ZHX0ZXX0RXTERfQllQ
QVNTX0RNQVNIREwpOworCQltdDc2X2NsZWFyKGRldiwgTVRfV0ZETUEwX0dMT19DRkcsCisJCQkg
ICBNVF9XRkRNQTBfR0xPX0NGR19DU1JfTEJLX1JYX1FfU0VMX0VOKTsKKwl9CisKIAlpZiAoaXNf
bXQ3OTI1KCZkZXYtPm10NzYpKSB7CiAJCW10NzZfcm13KGRldiwgTVRfVVdGRE1BMF9HTE9fQ0ZH
X0VYVDEsIEJJVCgyOCksIEJJVCgyOCkpOwogCQltdDc2X3NldChkZXYsIE1UX1dGRE1BMF9JTlRf
UlhfUFJJLCAweDBGMDApOwpkaWZmIC0tZ2l0IGEvbXQ3OTJ4X3JlZ3MuaCBiL210NzkyeF9yZWdz
LmgKaW5kZXggZDgzMTcxMy4uNjIxYjZiMyAxMDA2NDQKLS0tIGEvbXQ3OTJ4X3JlZ3MuaAorKysg
Yi9tdDc5MnhfcmVncy5oCkBAIC0zMDEsOSArMzAxLDExIEBACiAjZGVmaW5lIE1UX1dGRE1BMF9H
TE9fQ0ZHX0ZJRk9fTElUVExFX0VORElBTglCSVQoMTIpCiAjZGVmaW5lIE1UX1dGRE1BMF9HTE9f
Q0ZHX1JYX1dCX0RET05FCUJJVCgxMykKICNkZWZpbmUgTVRfV0ZETUEwX0dMT19DRkdfQ1NSX0RJ
U1BfQkFTRV9QVFJfQ0hBSU5fRU4gQklUKDE1KQorI2RlZmluZSBNVF9XRkRNQTBfR0xPX0NGR19D
U1JfTEJLX1JYX1FfU0VMX0VOCUJJVCgyMCkKICNkZWZpbmUgTVRfV0ZETUEwX0dMT19DRkdfT01J
VF9SWF9JTkZPX1BGRVQyCUJJVCgyMSkKICNkZWZpbmUgTVRfV0ZETUEwX0dMT19DRkdfT01JVF9S
WF9JTkZPCUJJVCgyNykKICNkZWZpbmUgTVRfV0ZETUEwX0dMT19DRkdfT01JVF9UWF9JTkZPCUJJ
VCgyOCkKKyNkZWZpbmUgTVRfV0ZETUEwX0dMT19DRkdfQUREUl9FWFRfRU4JCUJJVCgyNikKICNk
ZWZpbmUgTVRfV0ZETUEwX0dMT19DRkdfQ0xLX0dBVF9ESVMJQklUKDMwKQogCiAjZGVmaW5lIEhP
U1RfUlhfRE9ORV9JTlRfRU5BMAkJQklUKDApCkBAIC0zNjUsNiArMzY3LDEzIEBACiAjZGVmaW5l
IE1UX1dGRE1BX0VYVF9DU1JfSElGX01JU0MJTVRfV0ZETUFfRVhUX0NTUigweDQ0KQogI2RlZmlu
ZSBNVF9XRkRNQV9FWFRfQ1NSX0hJRl9NSVNDX0JVU1kJQklUKDApCiAKKy8qIE1UNjYzOSBwYWNr
ZWQgcHJlZmV0Y2ggcmVnaXN0ZXJzICovCisjZGVmaW5lIE1UX1dGRE1BX1BSRUZFVENIX0NUUkwJ
CU1UX1dGRE1BX0VYVF9DU1IoMHgzMCkKKyNkZWZpbmUgTVRfV0ZETUFfUFJFRkVUQ0hfQ0ZHMAkJ
TVRfV0ZETUFfRVhUX0NTUigweGYwKQorI2RlZmluZSBNVF9XRkRNQV9QUkVGRVRDSF9DRkcxCQlN
VF9XRkRNQV9FWFRfQ1NSKDB4ZjQpCisjZGVmaW5lIE1UX1dGRE1BX1BSRUZFVENIX0NGRzIJCU1U
X1dGRE1BX0VYVF9DU1IoMHhmOCkKKyNkZWZpbmUgTVRfV0ZETUFfUFJFRkVUQ0hfQ0ZHMwkJTVRf
V0ZETUFfRVhUX0NTUigweGZjKQorCiAjZGVmaW5lIE1UX1NXREVGX0JBU0UJCQkweDQxZjIwMAog
I2RlZmluZSBNVF9TV0RFRihvZnMpCQkJKE1UX1NXREVGX0JBU0UgKyAob2ZzKSkKICNkZWZpbmUg
TVRfU1dERUZfTU9ERQkJCU1UX1NXREVGKDB4M2MpCg==
--0000000000003da882065537b7d4
Content-Type: text/x-patch; charset="US-ASCII"; name="mt6639-bt-6.19.patch"
Content-Disposition: attachment; filename="mt6639-bt-6.19.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mqw2l4210>
X-Attachment-Id: f_mqw2l4210

LS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuYworKysgYi9kcml2ZXJzL2JsdWV0b290aC9i
dG10ay5jCkBAIC0xMTIsNyArMTEyLDExIEBACiB2b2lkIGJ0bXRrX2Z3X2dldF9maWxlbmFtZShj
aGFyICpidWYsIHNpemVfdCBzaXplLCB1MzIgZGV2X2lkLCB1MzIgZndfdmVyLAogCQkJICAgdTMy
IGZ3X2ZsYXZvcikKIHsKLQlpZiAoZGV2X2lkID09IDB4NzkyNSkKKyAgICAgICAgaWYgKGRldl9p
ZCA9PSAweDY2MzkpCisgICAgICAgICAgICAgICAgc25wcmludGYoYnVmLCBzaXplLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICJtZWRpYXRlay9tdCUwNHgvQlRfUkFNX0NPREVfTVQlMDR4XzJf
JXhfaGRyLmJpbiIsCisgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2lkICYgMHhmZmZmLCBk
ZXZfaWQgJiAweGZmZmYsIChmd192ZXIgJiAweGZmKSArIDEpOworICAgICAgICBlbHNlIGlmIChk
ZXZfaWQgPT0gMHg3OTI1KQogCQlzbnByaW50ZihidWYsIHNpemUsCiAJCQkgIm1lZGlhdGVrL210
JTA0eC9CVF9SQU1fQ09ERV9NVCUwNHhfMV8leF9oZHIuYmluIiwKIAkJCSBkZXZfaWQgJiAweGZm
ZmYsIGRldl9pZCAmIDB4ZmZmZiwgKGZ3X3ZlciAmIDB4ZmYpICsgMSk7CkBAIC0xNjYsNiArMTcw
LDE1IEBACiAJCXNlY3Rpb25fb2Zmc2V0ID0gbGUzMl90b19jcHUoc2VjdGlvbm1hcC0+c2Vjb2Zm
c2V0KTsKIAkJZGxfc2l6ZSA9IGxlMzJfdG9fY3B1KHNlY3Rpb25tYXAtPmJpbl9pbmZvX3NwZWMu
ZGxzaXplKTsKIAorICAgICAgICAgICAgICAgIC8qIE1UNjYzOTogb25seSBkb3dubG9hZCBzZWN0
aW9ucyB3aGVyZSBkbG1vZGUgYnl0ZTAgPT0gMHgwMSwKKyAgICAgICAgICAgICAgICAgKiBtYXRj
aGluZyB0aGUgV2luZG93cyBkcml2ZXIgYmVoYXZpb3Igd2hpY2ggc2tpcHMgV2lGaS9vdGhlcgor
ICAgICAgICAgICAgICAgICAqIHNlY3Rpb25zIHRoYXQgd291bGQgY2F1c2UgdGhlIGNoaXAgdG8g
aGFuZy4KKyAgICAgICAgICAgICAgICAgKi8KKyAgICAgICAgICAgICAgICBpZiAoZGxfc2l6ZSA+
IDAgJiYKKyAgICAgICAgICAgICAgICAgICAgKGxlMzJfdG9fY3B1KHNlY3Rpb25tYXAtPmJpbl9p
bmZvX3NwZWMuZGxtb2RlY3JjdHlwZSkgJiAweGZmKSAhPSAweDAxKSB7CisgICAgICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsKKyAgICAgICAgICAgICAgICB9CisKIAkJaWYgKGRsX3NpemUg
PiAwKSB7CiAJCQlyZXRyeSA9IDIwOwogCQkJd2hpbGUgKHJldHJ5ID4gMCkgewpAQCAtODQwLDcg
Kzg1Myw3IEBACiAJCWlmIChlcnIgPCAwKQogCQkJcmV0dXJuIGVycjsKIAkJbXNsZWVwKDEwMCk7
Ci0JfSBlbHNlIGlmIChkZXZfaWQgPT0gMHg3OTI1KSB7CisJfSBlbHNlIGlmIChkZXZfaWQgPT0g
MHg3OTI1IHx8IGRldl9pZCA9PSAweDY2MzkpIHsKIAkJZXJyID0gYnRtdGtfdXNiX3Vod19yZWdf
cmVhZChoZGV2LCBNVEtfQlRfUkVTRVRfUkVHX0NPTk5WMywgJnZhbCk7CiAJCWlmIChlcnIgPCAw
KQogCQkJcmV0dXJuIGVycjsKQEAgLTEzMjQsMjMgKzEzMzcsMzggQEAKIAkJZnduYW1lID0gRklS
TVdBUkVfTVQ3NjY4OwogCQlicmVhazsKIAljYXNlIDB4NzkyMjoKKwljYXNlIDB4NjYzOToKIAlj
YXNlIDB4NzkyNToKIAljYXNlIDB4Nzk2MToKIAkJYnRtdGtfZndfZ2V0X2ZpbGVuYW1lKGZ3X2Jp
bl9uYW1lLCBzaXplb2YoZndfYmluX25hbWUpLCBkZXZfaWQsCiAJCQkJICAgICAgZndfdmVyc2lv
biwgZndfZmxhdm9yKTsKIAorCQkvKiBNVDY2Mzk6IGZpcm13YXJlIHBlcnNpc3RzIGFjcm9zcyBC
VCBzb2Z0IHBvd2VyIGN5Y2xlcworCQkgKiAoc2h1dGRvd24gb25seSBzZW5kcyBXTVRfRlVOQ19D
VFJMPTApLiBTa2lwIHJlLWRvd25sb2FkCisJCSAqIG9uIHN1YnNlcXVlbnQgc2V0dXBzIHRvIGF2
b2lkIH4yLjZzIGRlbGF5LgorCQkgKi8KKwkJaWYgKGRldl9pZCA9PSAweDY2MzkgJiYKKwkJICAg
IHRlc3RfYml0KEJUTVRLX0ZJUk1XQVJFX0xPQURFRCwgJmJ0bXRrX2RhdGEtPmZsYWdzKSkgewor
CQkJYnRfZGV2X2luZm8oaGRldiwgIk1UNjYzOTogZmlybXdhcmUgYWxyZWFkeSBsb2FkZWQsIHNr
aXBwaW5nIGRvd25sb2FkIik7CisJCQlnb3RvIHNraXBfZndfc2V0dXBfNzl4eDsKKwkJfQorCiAJ
CWVyciA9IGJ0bXRrX3NldHVwX2Zpcm13YXJlXzc5eHgoaGRldiwgZndfYmluX25hbWUsCiAJCQkJ
CQlidG10a191c2JfaGNpX3dtdF9zeW5jKTsKIAkJaWYgKGVyciA8IDApIHsKIAkJCWJ0X2Rldl9l
cnIoaGRldiwgIkZhaWxlZCB0byBzZXQgdXAgZmlybXdhcmUgKCVkKSIsIGVycik7CiAJCQlyZXR1
cm4gZXJyOwogCQl9CiAKKwkJaWYgKGRldl9pZCA9PSAweDY2MzkpCisJCQlzZXRfYml0KEJUTVRL
X0ZJUk1XQVJFX0xPQURFRCwgJmJ0bXRrX2RhdGEtPmZsYWdzKTsKKworc2tpcF9md19zZXR1cF83
OXh4OgogCQkvKiBJdCdzIERldmljZSBFbmRQb2ludCBSZXNldCBPcHRpb24gUmVnaXN0ZXIgKi8K
IAkJZXJyID0gYnRtdGtfdXNiX3Vod19yZWdfd3JpdGUoaGRldiwgTVRLX0VQX1JTVF9PUFQsCiAJ
CQkJCSAgICAgIE1US19FUF9SU1RfSU5fT1VUX09QVCk7CiAJCWlmIChlcnIgPCAwKQogCQkJcmV0
dXJuIGVycjsKIAogCQkvKiBFbmFibGUgQmx1ZXRvb3RoIHByb3RvY29sICovCiAJCXBhcmFtID0g
MTsKLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuaAorKysgYi9kcml2ZXJzL2JsdWV0b290
aC9idG10ay5oCkBAIC03LDYgKzcsNyBAQAogI2RlZmluZSBGSVJNV0FSRV9NVDc5MjIJCSJtZWRp
YXRlay9CVF9SQU1fQ09ERV9NVDc5MjJfMV8xX2hkci5iaW4iCiAjZGVmaW5lIEZJUk1XQVJFX01U
Nzk2MQkJIm1lZGlhdGVrL0JUX1JBTV9DT0RFX01UNzk2MV8xXzJfaGRyLmJpbiIKICNkZWZpbmUg
RklSTVdBUkVfTVQ3OTI1CQkibWVkaWF0ZWsvbXQ3OTI1L0JUX1JBTV9DT0RFX01UNzkyNV8xXzFf
aGRyLmJpbiIKKyNkZWZpbmUgRklSTVdBUkVfTVQ3OTI3CQkibWVkaWF0ZWsvbXQ2NjM5L0JUX1JB
TV9DT0RFX01UNjYzOV8yXzFfaGRyLmJpbiIKIAogI2RlZmluZSBIQ0lfRVZfV01UIDB4ZTQKICNk
ZWZpbmUgSENJX1dNVF9NQVhfRVZFTlRfU0laRQkJNjQKLS0tIGEvZHJpdmVycy9ibHVldG9vdGgv
YnR1c2IuYworKysgYi9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jCkBAIC03MzMsNiArNzMzLDE0
IEBACiAJCQkJCQkgICAgIEJUVVNCX1dJREVCQU5EX1NQRUVDSCB9LAogCXsgVVNCX0RFVklDRSgw
eDA0ODksIDB4ZTEzOSksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX01FRElBVEVLIHwKIAkJCQkJCSAg
ICAgQlRVU0JfV0lERUJBTkRfU1BFRUNIIH0sCisJeyBVU0JfREVWSUNFKDB4MDQ4OSwgMHhlMTNh
KSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfTUVESUFURUsgfAorCQkJCQkJICAgICBCVFVTQl9XSURF
QkFORF9TUEVFQ0ggfSwKKwl7IFVTQl9ERVZJQ0UoMHgwNDg5LCAweGUwZmEpLCAuZHJpdmVyX2lu
Zm8gPSBCVFVTQl9NRURJQVRFSyB8CisJCQkJCQkgICAgIEJUVVNCX1dJREVCQU5EX1NQRUVDSCB9
LAorCXsgVVNCX0RFVklDRSgweDA0ODksIDB4ZTExNiksIC5kcml2ZXJfaW5mbyA9IEJUVVNCX01F
RElBVEVLIHwKKwkJCQkJCSAgICAgQlRVU0JfV0lERUJBTkRfU1BFRUNIIH0sCisJeyBVU0JfREVW
SUNFKDB4MTNkMywgMHgzNTg4KSwgLmRyaXZlcl9pbmZvID0gQlRVU0JfTUVESUFURUsgfAorCQkJ
CQkJICAgICBCVFVTQl9XSURFQkFORF9TUEVFQ0ggfSwKIAl7IFVTQl9ERVZJQ0UoMHgwNDg5LCAw
eGUxNGUpLCAuZHJpdmVyX2luZm8gPSBCVFVTQl9NRURJQVRFSyB8CiAJCQkJCQkgICAgIEJUVVNC
X1dJREVCQU5EX1NQRUVDSCB9LAogCXsgVVNCX0RFVklDRSgweDA0ODksIDB4ZTE0ZiksIC5kcml2
ZXJfaW5mbyA9IEJUVVNCX01FRElBVEVLIHwK
--0000000000003da882065537b7d4
Content-Type: text/x-patch; charset="US-ASCII"; name="mt6639-wifi-init.patch"
Content-Disposition: attachment; filename="mt6639-wifi-init.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mqw2l42o2>
X-Attachment-Id: f_mqw2l42o2

ZGlmZiAtLWdpdCBhL210NzZfY29ubmFjLmggYi9tdDc2X2Nvbm5hYy5oCmluZGV4IDUxNDIzYzcu
LmZmZjQ5OGQgMTAwNjQ0Ci0tLSBhL210NzZfY29ubmFjLmgKKysrIGIvbXQ3Nl9jb25uYWMuaApA
QCAtMTc0LDcgKzE3NCwxMiBAQCBleHRlcm4gY29uc3Qgc3RydWN0IHdpcGh5X3dvd2xhbl9zdXBw
b3J0IG10NzZfY29ubmFjX3dvd2xhbl9zdXBwb3J0OwogCiBzdGF0aWMgaW5saW5lIGJvb2wgaXNf
bXQ3OTI1KHN0cnVjdCBtdDc2X2RldiAqZGV2KQogewotCXJldHVybiBtdDc2X2NoaXAoZGV2KSA9
PSAweDc5MjU7CisJcmV0dXJuIG10NzZfY2hpcChkZXYpID09IDB4NzkyNSB8fCBtdDc2X2NoaXAo
ZGV2KSA9PSAweDc5Mjc7Cit9CisKK3N0YXRpYyBpbmxpbmUgYm9vbCBpc19tdDY2Mzkoc3RydWN0
IG10NzZfZGV2ICpkZXYpCit7CisJcmV0dXJuIG10NzZfY2hpcChkZXYpID09IDB4NzkyNzsKIH0K
IAogc3RhdGljIGlubGluZSBib29sIGlzX210NzkyMChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldikKQEAg
LTI3OSw2ICsyODQsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfbXQ3Nl9md190eHAoc3RydWN0
IG10NzZfZGV2ICpkZXYpCiAJY2FzZSAweDc5MjI6CiAJY2FzZSAweDc5MDI6CiAJY2FzZSAweDc5
MjU6CisJY2FzZSAweDc5Mjc6CiAJY2FzZSAweDc2NjM6CiAJY2FzZSAweDc2MjI6CiAJCXJldHVy
biBmYWxzZTsKZGlmZiAtLWdpdCBhL210NzkyNS9wY2kuYyBiL210NzkyNS9wY2kuYwppbmRleCBj
NDE2MTc1Li5kYjA1M2JkIDEwMDY0NAotLS0gYS9tdDc5MjUvcGNpLmMKKysrIGIvbXQ3OTI1L3Bj
aS5jCkBAIC0xNiw2ICsxNiwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQg
bXQ3OTI1X3BjaV9kZXZpY2VfdGFibGVbXSA9IHsKIAkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91
bG9uZ190KU1UNzkyNV9GSVJNV0FSRV9XTSB9LAogCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lE
X01FRElBVEVLLCAweDA3MTcpLAogCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpTVQ3
OTI1X0ZJUk1XQVJFX1dNIH0sCisJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfTUVESUFURUss
IDB4NzkyNyksCisJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdClNVDc5MjdfRklSTVdB
UkVfV00gfSwKKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9NRURJQVRFSywgMHg2NjM5KSwK
KwkJLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KU1UNzkyN19GSVJNV0FSRV9XTSB9LAog
CXsgfSwKIH07CiAKQEAgLTI2Niw2ICsyNzAsNjAgQEAgc3RhdGljIGludCBtdDc5MjVfZG1hX2lu
aXQoc3RydWN0IG10NzkyeF9kZXYgKmRldikKIAlyZXR1cm4gbXQ3OTJ4X2RtYV9lbmFibGUoZGV2
KTsKIH0KIAorc3RhdGljIGludCBtdDY2MzlfY2hpcF9pbml0KHN0cnVjdCBtdDc5MnhfZGV2ICpk
ZXYpCit7CisJc3RydWN0IG10NzZfZGV2ICptZGV2ID0gJmRldi0+bXQ3NjsKKwl1MzIgdmFsOwor
CisJLyogRU1JIHNsZWVwIHByb3RlY3QgKi8KKwltdDc2X3Jtd19maWVsZChkZXYsIE1UX0hXX0VN
SV9DVEwsIE1UX0hXX0VNSV9DVExfU0xQUFJPVF9FTiwgMSk7CisKKwkvKiBXRiBzdWJzeXN0ZW0g
cmVzZXQgdmlhIENCSW5mcmEgUkdVICovCisJbXQ3Nl9zZXQoZGV2LCBNVF9DQklORlJBX1JHVV9X
Rl9SU1QsIE1UX0NCSU5GUkFfUkdVX1dGX1JTVF9XRl9TVUJTWVMpOworCW1zbGVlcCgxKTsKKwlt
dDc2X2NsZWFyKGRldiwgTVRfQ0JJTkZSQV9SR1VfV0ZfUlNULAorCQkgICBNVF9DQklORlJBX1JH
VV9XRl9SU1RfV0ZfU1VCU1lTKTsKKwltc2xlZXAoNSk7CisKKwkvKiBNQ1Ugb3duZXJzaGlwICov
CisJbXQ3Nl93cihkZXYsIE1UX0NCSU5GUkFfTUNVX09XTl9TRVQsIEJJVCgwKSk7CisKKwkvKiBQ
b2xsIFJPTUNPREVfSU5ERVggZm9yIE1DVSBpZGxlICovCisJaWYgKCFfX210NzZfcG9sbF9tc2Vj
KG1kZXYsIE1UX1JPTUNPREVfSU5ERVgsCisJCQkgICAgICAweGZmZmYsIE1UX01DVV9JRExFX1ZB
TFVFLCAyMDAwKSkgeworCQl2YWwgPSBtdDc2X3JyKGRldiwgTVRfUk9NQ09ERV9JTkRFWCk7CisJ
CWRldl9lcnIobWRldi0+ZGV2LAorCQkJIk1UNjYzOSBNQ1UgaWRsZSB0aW1lb3V0IChST01DT0RF
X0lOREVYPTB4JTA0eClcbiIsCisJCQl2YWwgJiAweGZmZmYpOworCQlyZXR1cm4gLUVUSU1FRE9V
VDsKKwl9CisKKwkvKiBNQ0lGIHJlbWFwIC0gTUNVIG5lZWRzIHRoaXMgdG8gRE1BIHRvIGhvc3Qg
bWVtb3J5ICovCisJbXQ3Nl93cihkZXYsIE1UX01DSUZfUkVNQVBfV0ZfMV9CQSwgTVRfTUNJRl9S
RU1BUF9XRl8xX0JBX1ZBTCk7CisKKwkvKiBEaXNhYmxlIFBDSWUgc2xlZXAgKi8KKwltdDc2X3dy
KGRldiwgTVRfQ0JJTkZSQV9TTFBfQ1RSTCwgMHhmZmZmZmZmZik7CisKKwkvKiBDbGVhciBDT05O
SU5GUkEgd2FrZXVwICovCisJbXQ3Nl93cihkZXYsIE1UX0NCSU5GUkFfV0FLRVBVX1RPUCwgMHgw
KTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCBtdDY2MzlfY2J0b3BfcmVtYXAoc3Ry
dWN0IG10NzkyeF9kZXYgKmRldikKK3sKKwkvKiBDT05OSU5GUkEgd2FrZXVwIC0gcmVxdWlyZWQg
YmVmb3JlIENCSW5mcmEgcmVnaXN0ZXIgYWNjZXNzICovCisJbXQ3Nl93cihkZXYsIE1UX0NCSU5G
UkFfV0FLRVBVX1RPUCwgMHgxKTsKKwl1c2xlZXBfcmFuZ2UoMTAwMCwgMjAwMCk7CisKKwkvKiBD
b25maWd1cmUgQ0JUT1AgUENJZSBhZGRyZXNzIHJlbWFwIGZvciBXRiBhbmQgQlQgKi8KKwltdDc2
X3dyKGRldiwgTVRfQ0JJTkZSQV9NSVNDMF9SRU1BUF9XRiwgTVRfQ0JJTkZSQV9SRU1BUF9XRl9W
QUwpOworCW10NzZfd3IoZGV2LCBNVF9DQklORlJBX01JU0MwX1JFTUFQX0JULCBNVF9DQklORlJB
X1JFTUFQX0JUX1ZBTCk7CisKKwkvKiBSZWFkYmFjayB0byBwdXNoIHdyaXRlcyAqLworCW10NzZf
cnIoZGV2LCBNVF9DQklORlJBX01JU0MwX1JFTUFQX1dGKTsKK30KKwogc3RhdGljIGludCBtdDc5
MjVfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAogCQkJICAgIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkICppZCkKIHsKQEAgLTMxMCw2ICszNjgsNyBAQCBzdGF0aWMgaW50IG10Nzky
NV9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCiAJc3RydWN0IG10NzZfYnVzX29wcyAq
YnVzX29wczsKIAlzdHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2OwogCXN0cnVjdCBtdDc2X2RldiAqbWRl
djsKKwlib29sIGlzX210NjYzOV9odyA9IChwZGV2LT5kZXZpY2UgPT0gMHg2NjM5IHx8IHBkZXYt
PmRldmljZSA9PSAweDc5MjcpOwogCXU4IGZlYXR1cmVzOwogCWludCByZXQ7CiAJdTE2IGNtZDsK
QEAgLTM4NSwyMCArNDQ0LDM5IEBAIHN0YXRpYyBpbnQgbXQ3OTI1X3BjaV9wcm9iZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwKIAlpZiAocmV0KQogCQlnb3RvIGVycl9mcmVlX2RldjsKIAotCXJldCA9
IF9fbXQ3OTJ4ZV9tY3VfZHJ2X3BtY3RybChkZXYpOwotCWlmIChyZXQpCi0JCWdvdG8gZXJyX2Zy
ZWVfZGV2OworCWlmICghaXNfbXQ2NjM5X2h3KSB7CisJCXJldCA9IF9fbXQ3OTJ4ZV9tY3VfZHJ2
X3BtY3RybChkZXYpOworCQlpZiAocmV0KQorCQkJZ290byBlcnJfZnJlZV9kZXY7CisJfQorCisJ
aWYgKGlzX210NjYzOV9odykKKwkJbXQ2NjM5X2NidG9wX3JlbWFwKGRldik7CiAKIAltZGV2LT5y
ZXYgPSAobXQ3Nl9ycihkZXYsIE1UX0hXX0NISVBJRCkgPDwgMTYpIHwKIAkJICAgIChtdDc2X3Jy
KGRldiwgTVRfSFdfUkVWKSAmIDB4ZmYpOwogCiAJZGV2X2luZm8obWRldi0+ZGV2LCAiQVNJQyBy
ZXZpc2lvbjogJTA0eFxuIiwgbWRldi0+cmV2KTsKIAotCW10NzZfcm13X2ZpZWxkKGRldiwgTVRf
SFdfRU1JX0NUTCwgTVRfSFdfRU1JX0NUTF9TTFBQUk9UX0VOLCAxKTsKKwkvKiBGb3JjZSBjaGlw
IElEIGZvciBNVDY2MzkgaGFyZHdhcmUgaWYgQ0hJUElEIHJlYWQgcmV0dXJucyBnYXJiYWdlICov
CisJaWYgKGlzX210NjYzOV9odyAmJiAobWRldi0+cmV2ID4+IDE2KSAhPSAweDc5MjcpIHsKKwkJ
ZGV2X2luZm8obWRldi0+ZGV2LAorCQkJICJNVDY2MzkgcmF3IENISVBJRD0weCUwNHgsIGZvcmNp
bmcgY2hpcD0weDc5MjdcbiIsCisJCQkgKHUxNikobWRldi0+cmV2ID4+IDE2KSk7CisJCW1kZXYt
PnJldiA9ICgweDc5MjcgPDwgMTYpIHwgKG1kZXYtPnJldiAmIDB4ZmYpOworCX0KIAotCXJldCA9
IG10NzkyeF93ZnN5c19yZXNldChkZXYpOwotCWlmIChyZXQpCi0JCWdvdG8gZXJyX2ZyZWVfZGV2
OworCWlmIChpc19tdDY2MzlfaHcpIHsKKwkJcmV0ID0gbXQ2NjM5X2NoaXBfaW5pdChkZXYpOwor
CQlpZiAocmV0KQorCQkJZ290byBlcnJfZnJlZV9kZXY7CisJfSBlbHNlIHsKKwkJbXQ3Nl9ybXdf
ZmllbGQoZGV2LCBNVF9IV19FTUlfQ1RMLAorCQkJICAgICAgIE1UX0hXX0VNSV9DVExfU0xQUFJP
VF9FTiwgMSk7CisJCXJldCA9IG10NzkyeF93ZnN5c19yZXNldChkZXYpOworCQlpZiAocmV0KQor
CQkJZ290byBlcnJfZnJlZV9kZXY7CisJfQogCiAJbXQ3Nl93cihkZXYsIGlycV9tYXAuaG9zdF9p
cnFfZW5hYmxlLCAwKTsKIApAQCAtNjMzLDYgKzcxMSw4IEBAIG1vZHVsZV9wY2lfZHJpdmVyKG10
NzkyNV9wY2lfZHJpdmVyKTsKIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBtdDc5MjVfcGNpX2Rl
dmljZV90YWJsZSk7CiBNT0RVTEVfRklSTVdBUkUoTVQ3OTI1X0ZJUk1XQVJFX1dNKTsKIE1PRFVM
RV9GSVJNV0FSRShNVDc5MjVfUk9NX1BBVENIKTsKK01PRFVMRV9GSVJNV0FSRShNVDc5MjdfRklS
TVdBUkVfV00pOworTU9EVUxFX0ZJUk1XQVJFKE1UNzkyN19ST01fUEFUQ0gpOwogTU9EVUxFX0FV
VEhPUigiRGVyZW4gV3UgPGRlcmVuLnd1QG1lZGlhdGVrLmNvbT4iKTsKIE1PRFVMRV9BVVRIT1Io
IkxvcmVuem8gQmlhbmNvbmkgPGxvcmVuem9Aa2VybmVsLm9yZz4iKTsKIE1PRFVMRV9ERVNDUklQ
VElPTigiTWVkaWFUZWsgTVQ3OTI1RSAoUENJZSkgd2lyZWxlc3MgZHJpdmVyIik7CmRpZmYgLS1n
aXQgYS9tdDc5MnguaCBiL210NzkyeC5oCmluZGV4IDFmMzgxYWIuLmJiMzA4ZjEgMTAwNjQ0Ci0t
LSBhL210NzkyeC5oCisrKyBiL210NzkyeC5oCkBAIC00NiwxMiArNDYsMTQgQEAKICNkZWZpbmUg
TVQ3OTIxX0ZJUk1XQVJFX1dNCSJtZWRpYXRlay9XSUZJX1JBTV9DT0RFX01UNzk2MV8xLmJpbiIK
ICNkZWZpbmUgTVQ3OTIyX0ZJUk1XQVJFX1dNCSJtZWRpYXRlay9XSUZJX1JBTV9DT0RFX01UNzky
Ml8xLmJpbiIKICNkZWZpbmUgTVQ3OTI1X0ZJUk1XQVJFX1dNCSJtZWRpYXRlay9tdDc5MjUvV0lG
SV9SQU1fQ09ERV9NVDc5MjVfMV8xLmJpbiIKKyNkZWZpbmUgTVQ3OTI3X0ZJUk1XQVJFX1dNCSJt
ZWRpYXRlay9tdDc5MjcvV0lGSV9SQU1fQ09ERV9NVDY2MzlfMl8xLmJpbiIKIAogI2RlZmluZSBN
VDc5MDJfUk9NX1BBVENICSJtZWRpYXRlay9XSUZJX01UNzkwMl9wYXRjaF9tY3VfMV8xX2hkci5i
aW4iCiAjZGVmaW5lIE1UNzkyMF9ST01fUEFUQ0gJIm1lZGlhdGVrL1dJRklfTVQ3OTYxX3BhdGNo
X21jdV8xYV8yX2hkci5iaW4iCiAjZGVmaW5lIE1UNzkyMV9ST01fUEFUQ0gJIm1lZGlhdGVrL1dJ
RklfTVQ3OTYxX3BhdGNoX21jdV8xXzJfaGRyLmJpbiIKICNkZWZpbmUgTVQ3OTIyX1JPTV9QQVRD
SAkibWVkaWF0ZWsvV0lGSV9NVDc5MjJfcGF0Y2hfbWN1XzFfMV9oZHIuYmluIgogI2RlZmluZSBN
VDc5MjVfUk9NX1BBVENICSJtZWRpYXRlay9tdDc5MjUvV0lGSV9NVDc5MjVfUEFUQ0hfTUNVXzFf
MV9oZHIuYmluIgorI2RlZmluZSBNVDc5MjdfUk9NX1BBVENICSJtZWRpYXRlay9tdDc5MjcvV0lG
SV9NVDY2MzlfUEFUQ0hfTUNVXzJfMV9oZHIuYmluIgogCiAjZGVmaW5lIE1UNzkyeF9TRElPX0hE
Ul9UWF9CWVRFUwlHRU5NQVNLKDE1LCAwKQogI2RlZmluZSBNVDc5MnhfU0RJT19IRFJfUEtUX1RZ
UEUJR0VOTUFTSygxNywgMTYpCkBAIC00NTgsNiArNDYwLDggQEAgc3RhdGljIGlubGluZSBjaGFy
ICptdDc5MnhfcmFtX25hbWUoc3RydWN0IG10NzkyeF9kZXYgKmRldikKIAkJcmV0dXJuIE1UNzky
Ml9GSVJNV0FSRV9XTTsKIAljYXNlIDB4NzkyNToKIAkJcmV0dXJuIE1UNzkyNV9GSVJNV0FSRV9X
TTsKKwljYXNlIDB4NzkyNzoKKwkJcmV0dXJuIE1UNzkyN19GSVJNV0FSRV9XTTsKIAlkZWZhdWx0
OgogCQlyZXR1cm4gTVQ3OTIxX0ZJUk1XQVJFX1dNOwogCX0KQEAgLTQ3NCw2ICs0NzgsOCBAQCBz
dGF0aWMgaW5saW5lIGNoYXIgKm10NzkyeF9wYXRjaF9uYW1lKHN0cnVjdCBtdDc5MnhfZGV2ICpk
ZXYpCiAJCXJldHVybiBNVDc5MjJfUk9NX1BBVENIOwogCWNhc2UgMHg3OTI1OgogCQlyZXR1cm4g
TVQ3OTI1X1JPTV9QQVRDSDsKKwljYXNlIDB4NzkyNzoKKwkJcmV0dXJuIE1UNzkyN19ST01fUEFU
Q0g7CiAJZGVmYXVsdDoKIAkJcmV0dXJuIE1UNzkyMV9ST01fUEFUQ0g7CiAJfQpkaWZmIC0tZ2l0
IGEvbXQ3OTJ4X3JlZ3MuaCBiL210NzkyeF9yZWdzLmgKaW5kZXggN2RkZGU5Mi4uZDgzMTcxMyAx
MDA2NDQKLS0tIGEvbXQ3OTJ4X3JlZ3MuaAorKysgYi9tdDc5MnhfcmVncy5oCkBAIC00ODYsNCAr
NDg2LDIyIEBACiAjZGVmaW5lIFdGU1lTX1NXX1JTVF9CCQkJQklUKDApCiAjZGVmaW5lIFdGU1lT
X1NXX0lOSVRfRE9ORQkJQklUKDQpCiAKKy8qIENCSW5mcmEgcmVnaXN0ZXJzIC0gTVQ2NjM5L01U
NzkyNyBjb21ibyBjaGlwICovCisjZGVmaW5lIE1UX0NCSU5GUkFfV0FLRVBVX1RPUAkJMHhlMDFh
MAorI2RlZmluZSBNVF9DQklORlJBX01JU0MwX1JFTUFQX1dGCTB4MWY2NTU0CisjZGVmaW5lIE1U
X0NCSU5GUkFfTUlTQzBfUkVNQVBfQlQJMHgxZjY1NTgKKyNkZWZpbmUgTVRfQ0JJTkZSQV9SR1Vf
V0ZfUlNUCQkweDFmODYwMAorI2RlZmluZSBNVF9DQklORlJBX1JHVV9XRl9SU1RfV0ZfU1VCU1lT
CUJJVCg0KQorI2RlZmluZSBNVF9DQklORlJBX01DVV9PV05fU0VUCQkweDFmNTAzNAorI2RlZmlu
ZSBNVF9DQklORlJBX1NMUF9DVFJMCQkweDFmNTAxOAorI2RlZmluZSBNVF9ST01DT0RFX0lOREVY
CQkweGMxNjA0CisjZGVmaW5lIE1UX01DVV9JRExFX1ZBTFVFCQkweDFkMWUKKyNkZWZpbmUgTVRf
TUNJRl9SRU1BUF9XRl8xX0JBCQkweGQxMDM0CisKKy8qIENCSW5mcmEgQ0JUT1AgcmVtYXAgdmFs
dWVzICovCisjZGVmaW5lIE1UX0NCSU5GUkFfUkVNQVBfV0ZfVkFMCQkweDc0MDM3MDAxCisjZGVm
aW5lIE1UX0NCSU5GUkFfUkVNQVBfQlRfVkFMCQkweDcwMDA3MDAwCisKKyNkZWZpbmUgTVRfTUNJ
Rl9SRU1BUF9XRl8xX0JBX1ZBTAkweDE4MDUxODAzCisKICNlbmRpZiAvKiBfX01UNzkyWF9SRUdT
X0ggKi8K
--0000000000003da882065537b7d4
Content-Type: text/x-patch; charset="US-ASCII"; name="mt7902-wifi-6.19.patch"
Content-Disposition: attachment; filename="mt7902-wifi-6.19.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mqw2l42t3>
X-Attachment-Id: f_mqw2l42t3

ZGlmZiAtLWdpdCBhL210NzZfY29ubmFjLmggYi9tdDc2X2Nvbm5hYy5oCmluZGV4IDgxM2Q2MWJm
Zi4uNTE0MjNjNzc0IDEwMDY0NAotLS0gYS9tdDc2X2Nvbm5hYy5oCisrKyBiL210NzZfY29ubmFj
LmgKQEAgLTE4MiwxNCArMTgyLDIwIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19tdDc5MjAoc3Ry
dWN0IG10NzZfZGV2ICpkZXYpCiAJcmV0dXJuIG10NzZfY2hpcChkZXYpID09IDB4NzkyMDsKIH0K
IAorc3RhdGljIGlubGluZSBib29sIGlzX210NzkwMihzdHJ1Y3QgbXQ3Nl9kZXYgKmRldikKK3sK
KwlyZXR1cm4gbXQ3Nl9jaGlwKGRldikgPT0gMHg3OTAyOworfQorCiBzdGF0aWMgaW5saW5lIGJv
b2wgaXNfbXQ3OTIyKHN0cnVjdCBtdDc2X2RldiAqZGV2KQogewogCXJldHVybiBtdDc2X2NoaXAo
ZGV2KSA9PSAweDc5MjI7CiB9CiAKLXN0YXRpYyBpbmxpbmUgYm9vbCBpc19tdDc5MjEoc3RydWN0
IG10NzZfZGV2ICpkZXYpCitzdGF0aWMgaW5saW5lIGJvb2wgaXNfY29ubmFjMihzdHJ1Y3QgbXQ3
Nl9kZXYgKmRldikKIHsKLQlyZXR1cm4gbXQ3Nl9jaGlwKGRldikgPT0gMHg3OTYxIHx8IGlzX210
NzkyMihkZXYpIHx8IGlzX210NzkyMChkZXYpOworCXJldHVybiBtdDc2X2NoaXAoZGV2KSA9PSAw
eDc5NjEgfHwgaXNfbXQ3OTIyKGRldikgfHwgaXNfbXQ3OTIwKGRldikgfHwKKwkJCQlpc19tdDc5
MDIoZGV2KTsKIH0KIAogc3RhdGljIGlubGluZSBib29sIGlzX210NzY2MyhzdHJ1Y3QgbXQ3Nl9k
ZXYgKmRldikKQEAgLTI3MSw2ICsyNzcsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfbXQ3Nl9m
d190eHAoc3RydWN0IG10NzZfZGV2ICpkZXYpCiAJY2FzZSAweDc5NjE6CiAJY2FzZSAweDc5MjA6
CiAJY2FzZSAweDc5MjI6CisJY2FzZSAweDc5MDI6CiAJY2FzZSAweDc5MjU6CiAJY2FzZSAweDc2
NjM6CiAJY2FzZSAweDc2MjI6CmRpZmYgLS1naXQgYS9tdDc2X2Nvbm5hY19tYWMuYyBiL210NzZf
Y29ubmFjX21hYy5jCmluZGV4IDMzMDRiNTk3MS4uZGEyYmEwM2JhIDEwMDY0NAotLS0gYS9tdDc2
X2Nvbm5hY19tYWMuYworKysgYi9tdDc2X2Nvbm5hY19tYWMuYwpAQCAtMTczLDcgKzE3Myw3IEBA
IHZvaWQgbXQ3Nl9jb25uYWNfd3JpdGVfaHdfdHhwKHN0cnVjdCBtdDc2X2RldiAqZGV2LAogCiAJ
dHhwLT5tc2R1X2lkWzBdID0gY3B1X3RvX2xlMTYoaWQgfCBNVF9NU0RVX0lEX1ZBTElEKTsKIAot
CWlmIChpc19tdDc2NjMoZGV2KSB8fCBpc19tdDc5MjEoZGV2KSB8fCBpc19tdDc5MjUoZGV2KSkK
KwlpZiAoaXNfbXQ3NjYzKGRldikgfHwgaXNfY29ubmFjMihkZXYpIHx8IGlzX210NzkyNShkZXYp
KQogCQlsYXN0X21hc2sgPSBNVF9UWERfTEVOX0xBU1Q7CiAJZWxzZQogCQlsYXN0X21hc2sgPSBN
VF9UWERfTEVOX0FNU0RVX0xBU1QgfApAQCAtMjE3LDcgKzIxNyw3IEBAIG10NzZfY29ubmFjX3R4
cF9za2JfdW5tYXBfaHcoc3RydWN0IG10NzZfZGV2ICpkZXYsCiAJdTMyIGxhc3RfbWFzazsKIAlp
bnQgaTsKIAotCWlmIChpc19tdDc2NjMoZGV2KSB8fCBpc19tdDc5MjEoZGV2KSB8fCBpc19tdDc5
MjUoZGV2KSkKKwlpZiAoaXNfbXQ3NjYzKGRldikgfHwgaXNfY29ubmFjMihkZXYpIHx8IGlzX210
NzkyNShkZXYpKQogCQlsYXN0X21hc2sgPSBNVF9UWERfTEVOX0xBU1Q7CiAJZWxzZQogCQlsYXN0
X21hc2sgPSBNVF9UWERfTEVOX01TRFVfTEFTVDsKQEAgLTMwOSw3ICszMDksNyBAQCB1MTYgbXQ3
Nl9jb25uYWMyX21hY190eF9yYXRlX3ZhbChzdHJ1Y3QgbXQ3Nl9waHkgKm1waHksCiAJY2hhbmRl
ZiA9IG12aWYtPmN0eCA/ICZtdmlmLT5jdHgtPmRlZiA6ICZtcGh5LT5jaGFuZGVmOwogCWJhbmQg
PSBjaGFuZGVmLT5jaGFuLT5iYW5kOwogCi0JaWYgKGlzX210NzkyMShtcGh5LT5kZXYpKSB7CisJ
aWYgKGlzX2Nvbm5hYzIobXBoeS0+ZGV2KSkgewogCQlyYXRlaWR4ID0gZmZzKGNvbmYtPmJhc2lj
X3JhdGVzKSAtIDE7CiAJCWdvdG8gbGVnYWN5OwogCX0KQEAgLTU0Nyw3ICs1NDcsNyBAQCB2b2lk
IG10NzZfY29ubmFjMl9tYWNfd3JpdGVfdHh3aShzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgX19sZTMy
ICp0eHdpLAogCXZhbCA9IE1UX1RYRDFfTE9OR19GT1JNQVQgfAogCSAgICAgIEZJRUxEX1BSRVAo
TVRfVFhEMV9XTEFOX0lEWCwgd2NpZC0+aWR4KSB8CiAJICAgICAgRklFTERfUFJFUChNVF9UWEQx
X09XTl9NQUMsIG9tYWNfaWR4KTsKLQlpZiAoIWlzX210NzkyMShkZXYpKQorCWlmICghaXNfY29u
bmFjMihkZXYpKQogCQl2YWwgfD0gTVRfVFhEMV9WVEE7CiAJaWYgKHBoeV9pZHggfHwgYmFuZF9p
ZHgpCiAJCXZhbCB8PSBNVF9UWEQxX1RHSUQ7CkBAIC01NTYsNyArNTU2LDcgQEAgdm9pZCBtdDc2
X2Nvbm5hYzJfbWFjX3dyaXRlX3R4d2koc3RydWN0IG10NzZfZGV2ICpkZXYsIF9fbGUzMiAqdHh3
aSwKIAl0eHdpWzJdID0gMDsKIAogCXZhbCA9IEZJRUxEX1BSRVAoTVRfVFhEM19SRU1fVFhfQ09V
TlQsIDE1KTsKLQlpZiAoIWlzX210NzkyMShkZXYpKQorCWlmICghaXNfY29ubmFjMihkZXYpKQog
CQl2YWwgfD0gTVRfVFhEM19TV19QT1dFUl9NR01UOwogCWlmIChrZXkpCiAJCXZhbCB8PSBNVF9U
WEQzX1BST1RFQ1RfRlJBTUU7CkBAIC01OTgsNyArNTk4LDcgQEAgdm9pZCBtdDc2X2Nvbm5hYzJf
bWFjX3dyaXRlX3R4d2koc3RydWN0IG10NzZfZGV2ICpkZXYsIF9fbGUzMiAqdHh3aSwKIAkJdHh3
aVs2XSB8PSBjcHVfdG9fbGUzMih2YWwpOwogCQl0eHdpWzNdIHw9IGNwdV90b19sZTMyKE1UX1RY
RDNfQkFfRElTQUJMRSk7CiAKLQkJaWYgKCFpc19tdDc5MjEoZGV2KSkgeworCQlpZiAoIWlzX2Nv
bm5hYzIoZGV2KSkgewogCQkJdTggc3BlX2lkeCA9IG10NzZfY29ubmFjX3NwZV9pZHgobXBoeS0+
YW50ZW5uYV9tYXNrKTsKIAogCQkJaWYgKCFzcGVfaWR4KQpAQCAtODMwLDcgKzgzMCw3IEBAIG10
NzZfY29ubmFjMl9tYWNfZGVjb2RlX2hlX211X3JhZGlvdGFwKHN0cnVjdCBtdDc2X2RldiAqZGV2
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiCiAJfTsKIAlzdHJ1Y3QgaWVlZTgwMjExX3JhZGlvdGFwX2hl
X211ICpoZV9tdTsKIAotCWlmIChpc19tdDc5MjEoZGV2KSkgeworCWlmIChpc19jb25uYWMyKGRl
dikpIHsKIAkJbXVfa25vd24uZmxhZ3MxIHw9IEhFX0JJVFMoTVVfRkxBR1MxX1NJR19CX0NPTVBf
S05PV04pOwogCQltdV9rbm93bi5mbGFnczIgfD0gSEVfQklUUyhNVV9GTEFHUzJfUFVOQ19GUk9N
X1NJR19BX0JXX0tOT1dOKTsKIAl9CkBAIC0xMDQ2LDcgKzEwNDYsNyBAQCBpbnQgbXQ3Nl9jb25u
YWMyX21hY19maWxsX3J4X3JhdGUoc3RydWN0IG10NzZfZGV2ICpkZXYsCiAJCXN0YmMgPSBGSUVM
RF9HRVQoTVRfUFJYVl9IVF9TVEJDLCB2MCk7CiAJCWdpID0gRklFTERfR0VUKE1UX1BSWFZfSFRf
U0dJLCB2MCk7CiAJCSptb2RlID0gRklFTERfR0VUKE1UX1BSWFZfVFhfTU9ERSwgdjApOwotCQlp
ZiAoaXNfbXQ3OTIxKGRldikpCisJCWlmIChpc19jb25uYWMyKGRldikpCiAJCQlkY20gPSAhIShp
ZHggJiBNVF9QUlhWX1RYX0RDTSk7CiAJCWVsc2UKIAkJCWRjbSA9IEZJRUxEX0dFVChNVF9QUlhW
X0RDTSwgdjApOwpkaWZmIC0tZ2l0IGEvbXQ3Nl9jb25uYWNfbWN1LmMgYi9tdDc2X2Nvbm5hY19t
Y3UuYwppbmRleCAwNDU3NzEyMjguLmYwMzJiNGM3NiAxMDA2NDQKLS0tIGEvbXQ3Nl9jb25uYWNf
bWN1LmMKKysrIGIvbXQ3Nl9jb25uYWNfbWN1LmMKQEAgLTQsNiArNCw3IEBACiAjaW5jbHVkZSA8
bGludXgvZmlybXdhcmUuaD4KICNpbmNsdWRlICJtdDc2X2Nvbm5hYzJfbWFjLmgiCiAjaW5jbHVk
ZSAibXQ3Nl9jb25uYWNfbWN1LmgiCisjaW5jbHVkZSAibXQ3OTJ4X3JlZ3MuaCIKIAogaW50IG10
NzZfY29ubmFjX21jdV9zdGFydF9maXJtd2FyZShzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgdTMyIGFk
ZHIsIHUzMiBvcHRpb24pCiB7CkBAIC02NSw3ICs2Niw3IEBAIGludCBtdDc2X2Nvbm5hY19tY3Vf
aW5pdF9kb3dubG9hZChzdHJ1Y3QgbXQ3Nl9kZXYgKmRldiwgdTMyIGFkZHIsIHUzMiBsZW4sCiAJ
aW50IGNtZDsKIAogCWlmICgoIWlzX2Nvbm5hY192MShkZXYpICYmIGFkZHIgPT0gTUNVX1BBVENI
X0FERFJFU1MpIHx8Ci0JICAgIChpc19tdDc5MjEoZGV2KSAmJiBhZGRyID09IDB4OTAwMDAwKSB8
fAorCSAgICAoaXNfY29ubmFjMihkZXYpICYmIGFkZHIgPT0gMHg5MDAwMDApIHx8CiAJICAgIChp
c19tdDc5MjUoZGV2KSAmJiAoYWRkciA9PSAweDkwMDAwMCB8fCBhZGRyID09IDB4ZTAwMDI4MDAp
KSB8fAogCSAgICAoaXNfbXQ3OTl4KGRldikgJiYgYWRkciA9PSAweDkwMDAwMCkpCiAJCWNtZCA9
IE1DVV9DTUQoUEFUQ0hfU1RBUlRfUkVRKTsKQEAgLTQwMiw3ICs0MDMsNyBAQCB2b2lkIG10NzZf
Y29ubmFjX21jdV9zdGFfYmFzaWNfdGx2KHN0cnVjdCBtdDc2X2RldiAqZGV2LCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLAogCXN3aXRjaCAodmlmLT50eXBlKSB7CiAJY2FzZSBOTDgwMjExX0lGVFlQRV9N
RVNIX1BPSU5UOgogCWNhc2UgTkw4MDIxMV9JRlRZUEVfQVA6Ci0JCWlmICh2aWYtPnAycCAmJiAh
aXNfbXQ3OTIxKGRldikpCisJCWlmICh2aWYtPnAycCAmJiAhaXNfY29ubmFjMihkZXYpKQogCQkJ
Y29ubl90eXBlID0gQ09OTkVDVElPTl9QMlBfR0M7CiAJCWVsc2UKIAkJCWNvbm5fdHlwZSA9IENP
Tk5FQ1RJT05fSU5GUkFfU1RBOwpAQCAtNDEwLDcgKzQxMSw3IEBAIHZvaWQgbXQ3Nl9jb25uYWNf
bWN1X3N0YV9iYXNpY190bHYoc3RydWN0IG10NzZfZGV2ICpkZXYsIHN0cnVjdCBza19idWZmICpz
a2IsCiAJCWJhc2ljLT5haWQgPSBjcHVfdG9fbGUxNihsaW5rX3N0YS0+c3RhLT5haWQpOwogCQli
cmVhazsKIAljYXNlIE5MODAyMTFfSUZUWVBFX1NUQVRJT046Ci0JCWlmICh2aWYtPnAycCAmJiAh
aXNfbXQ3OTIxKGRldikpCisJCWlmICh2aWYtPnAycCAmJiAhaXNfY29ubmFjMihkZXYpKQogCQkJ
Y29ubl90eXBlID0gQ09OTkVDVElPTl9QMlBfR087CiAJCWVsc2UKIAkJCWNvbm5fdHlwZSA9IENP
Tk5FQ1RJT05fSU5GUkFfQVA7CkBAIC04NzQsNyArODc1LDcgQEAgdm9pZCBtdDc2X2Nvbm5hY19t
Y3Vfc3RhX3RsdihzdHJ1Y3QgbXQ3Nl9waHkgKm1waHksIHN0cnVjdCBza19idWZmICpza2IsCiAJ
CXN0cnVjdCBzdGFfcmVjX3ZodCAqdmh0OwogCQlpbnQgbGVuOwogCi0JCWxlbiA9IGlzX210Nzky
MShkZXYpID8gc2l6ZW9mKCp2aHQpIDogc2l6ZW9mKCp2aHQpIC0gNDsKKwkJbGVuID0gaXNfY29u
bmFjMihkZXYpID8gc2l6ZW9mKCp2aHQpIDogc2l6ZW9mKCp2aHQpIC0gNDsKIAkJdGx2ID0gbXQ3
Nl9jb25uYWNfbWN1X2FkZF90bHYoc2tiLCBTVEFfUkVDX1ZIVCwgbGVuKTsKIAkJdmh0ID0gKHN0
cnVjdCBzdGFfcmVjX3ZodCAqKXRsdjsKIAkJdmh0LT52aHRfY2FwID0gY3B1X3RvX2xlMzIoc3Rh
LT5kZWZsaW5rLnZodF9jYXAuY2FwKTsKQEAgLTg4NSw3ICs4ODYsNyBAQCB2b2lkIG10NzZfY29u
bmFjX21jdV9zdGFfdGx2KHN0cnVjdCBtdDc2X3BoeSAqbXBoeSwgc3RydWN0IHNrX2J1ZmYgKnNr
YiwKIAkvKiBzdGFyZWMgdWFwc2QgKi8KIAltdDc2X2Nvbm5hY19tY3Vfc3RhX3VhcHNkKHNrYiwg
dmlmLCBzdGEpOwogCi0JaWYgKCFpc19tdDc5MjEoZGV2KSkKKwlpZiAoIWlzX2Nvbm5hYzIoZGV2
KSkKIAkJcmV0dXJuOwogCiAJaWYgKHN0YS0+ZGVmbGluay5odF9jYXAuaHRfc3VwcG9ydGVkIHx8
IHN0YS0+ZGVmbGluay5oZV9jYXAuaGFzX2hlKQpAQCAtMTc3NCw3ICsxNzc1LDcgQEAgaW50IG10
NzZfY29ubmFjX21jdV9od19zY2FuKHN0cnVjdCBtdDc2X3BoeSAqcGh5LCBzdHJ1Y3QgaWVlZTgw
MjExX3ZpZiAqdmlmLAogCXJlcS0+c3NpZF90eXBlX2V4dCA9IG5fc3NpZHMgPyBCSVQoMCkgOiAw
OwogCXJlcS0+c3NpZHNfbnVtID0gbl9zc2lkczsKIAotCWR1cmF0aW9uID0gaXNfbXQ3OTIxKHBo
eS0+ZGV2KSA/IDAgOiBNVDc2X0NPTk5BQ19TQ0FOX0NIQU5ORUxfVElNRTsKKwlkdXJhdGlvbiA9
IGlzX2Nvbm5hYzIocGh5LT5kZXYpID8gMCA6IE1UNzZfQ09OTkFDX1NDQU5fQ0hBTk5FTF9USU1F
OwogCS8qIGluY3JlYXNlIGNoYW5uZWwgdGltZSBmb3IgcGFzc2l2ZSBzY2FuICovCiAJaWYgKCFz
cmVxLT5uX3NzaWRzKQogCQlkdXJhdGlvbiAqPSAyOwpAQCAtMTgxNyw3ICsxODE4LDcgQEAgaW50
IG10NzZfY29ubmFjX21jdV9od19zY2FuKHN0cnVjdCBtdDc2X3BoeSAqcGh5LCBzdHJ1Y3QgaWVl
ZTgwMjExX3ZpZiAqdmlmLAogCQlyZXEtPmllc19sZW4gPSBjcHVfdG9fbGUxNihzcmVxLT5pZV9s
ZW4pOwogCX0KIAotCWlmIChpc19tdDc5MjEocGh5LT5kZXYpKQorCWlmIChpc19jb25uYWMyKHBo
eS0+ZGV2KSkKIAkJcmVxLT5zY2FuX2Z1bmMgfD0gU0NBTl9GVU5DX1NQTElUX1NDQU47CiAKIAlt
ZW1jcHkocmVxLT5ic3NpZCwgc3JlcS0+YnNzaWQsIEVUSF9BTEVOKTsKQEAgLTE4OTMsNyArMTg5
NCw3IEBAIGludCBtdDc2X2Nvbm5hY19tY3Vfc2NoZWRfc2Nhbl9yZXEoc3RydWN0IG10NzZfcGh5
ICpwaHksCiAJCWdldF9yYW5kb21fbWFza19hZGRyKGFkZHIsIHNyZXEtPm1hY19hZGRyLAogCQkJ
CSAgICAgc3JlcS0+bWFjX2FkZHJfbWFzayk7CiAJfQotCWlmIChpc19tdDc5MjEocGh5LT5kZXYp
KSB7CisJaWYgKGlzX2Nvbm5hYzIocGh5LT5kZXYpKSB7CiAJCXJlcS0+bXQ3OTIxLmJzc19pZHgg
PSBtdmlmLT5pZHg7CiAJCXJlcS0+bXQ3OTIxLmRlbGF5ID0gY3B1X3RvX2xlMzIoc3JlcS0+ZGVs
YXkpOwogCX0KQEAgLTIwMzMsNyArMjAzNCw3IEBAIG10NzZfY29ubmFjX21jdV9idWlsZF9za3Uo
c3RydWN0IG10NzZfZGV2ICpkZXYsIHM4ICpza3UsCiAJCQkgIHN0cnVjdCBtdDc2X3Bvd2VyX2xp
bWl0cyAqbGltaXRzLAogCQkJICBlbnVtIG5sODAyMTFfYmFuZCBiYW5kKQogewotCWludCBtYXhf
cG93ZXIgPSBpc19tdDc5MjEoZGV2KSA/IDEyNyA6IDYzOworCWludCBtYXhfcG93ZXIgPSBpc19j
b25uYWMyKGRldikgPyAxMjcgOiA2MzsKIAlpbnQgaSwgb2Zmc2V0ID0gc2l6ZW9mKGxpbWl0cy0+
Y2NrKTsKIAogCW1lbXNldChza3UsIG1heF9wb3dlciwgTVRfU0tVX1BPV0VSX0xJTUlUKTsKQEAg
LTIwNjEsNyArMjA2Miw3IEBAIG10NzZfY29ubmFjX21jdV9idWlsZF9za3Uoc3RydWN0IG10NzZf
ZGV2ICpkZXYsIHM4ICpza3UsCiAJCW9mZnNldCArPSAxMjsKIAl9CiAKLQlpZiAoIWlzX210Nzky
MShkZXYpKQorCWlmICghaXNfY29ubmFjMihkZXYpKQogCQlyZXR1cm47CiAKIAkvKiBoZSAqLwpA
QCAtMjExNyw3ICsyMTE4LDcgQEAgbXQ3Nl9jb25uYWNfbWN1X3JhdGVfdHhwb3dlcl9iYW5kKHN0
cnVjdCBtdDc2X3BoeSAqcGh5LAogCQkJCSAgZW51bSBubDgwMjExX2JhbmQgYmFuZCkKIHsKIAlz
dHJ1Y3QgbXQ3Nl9kZXYgKmRldiA9IHBoeS0+ZGV2OwotCWludCBza3VfbGVuLCBiYXRjaF9sZW4g
PSBpc19tdDc5MjEoZGV2KSA/IDggOiAxNjsKKwlpbnQgc2t1X2xlbiwgYmF0Y2hfbGVuID0gaXNf
Y29ubmFjMihkZXYpID8gOCA6IDE2OwogCXN0YXRpYyBjb25zdCB1OCBjaGFuX2xpc3RfMmdoeltd
ID0gewogCQkxLCAyLCAgMywgIDQsICA1LCAgNiwgIDcsCiAJCTgsIDksIDEwLCAxMSwgMTIsIDEz
LCAxNApAQCAtMjE1OCw3ICsyMTU5LDcgQEAgbXQ3Nl9jb25uYWNfbWN1X3JhdGVfdHhwb3dlcl9i
YW5kKHN0cnVjdCBtdDc2X3BoeSAqcGh5LAogCWlmICghbGltaXRzKQogCQlyZXR1cm4gLUVOT01F
TTsKIAotCXNrdV9sZW4gPSBpc19tdDc5MjEoZGV2KSA/IHNpemVvZihza3VfdGxidikgOiBzaXpl
b2Yoc2t1X3RsYnYpIC0gOTI7CisJc2t1X2xlbiA9IGlzX2Nvbm5hYzIoZGV2KSA/IHNpemVvZihz
a3VfdGxidikgOiBzaXplb2Yoc2t1X3RsYnYpIC0gOTI7CiAJdHhfcG93ZXIgPSAyICogcGh5LT5o
dy0+Y29uZi5wb3dlcl9sZXZlbDsKIAlpZiAoIXR4X3Bvd2VyKQogCQl0eF9wb3dlciA9IDEyNzsK
QEAgLTIyNDIsNiArMjI0Myw5IEBAIG10NzZfY29ubmFjX21jdV9yYXRlX3R4cG93ZXJfYmFuZChz
dHJ1Y3QgbXQ3Nl9waHkgKnBoeSwKIAkJCQkJICAgIGZhbHNlKTsKIAkJaWYgKGVyciA8IDApCiAJ
CQlnb3RvIG91dDsKKworCQkvKiByZWFkIGEgQ1IgdG8gYXZvaWQgUFNFIGJ1ZmZlciB1bmRlcmZs
b3cgKi8KKwkJbXQ3Nl9jb25uYWNfbWN1X3JlZ19ycihkZXYsIE1UX1BTRV9CQVNFKTsKIAl9CiAK
IG91dDoKQEAgLTMwNzIsNyArMzA3Niw3IEBAIHN0YXRpYyB1MzIgbXQ3Nl9jb25uYWMyX2dldF9k
YXRhX21vZGUoc3RydWN0IG10NzZfZGV2ICpkZXYsIHUzMiBpbmZvKQogewogCXUzMiBtb2RlID0g
RExfTU9ERV9ORUVEX1JTUDsKIAotCWlmICgoIWlzX210NzkyMShkZXYpICYmICFpc19tdDc5MjUo
ZGV2KSkgfHwgaW5mbyA9PSBQQVRDSF9TRUNfTk9UX1NVUFBPUlQpCisJaWYgKCghaXNfY29ubmFj
MihkZXYpICYmICFpc19tdDc5MjUoZGV2KSkgfHwgaW5mbyA9PSBQQVRDSF9TRUNfTk9UX1NVUFBP
UlQpCiAJCXJldHVybiBtb2RlOwogCiAJc3dpdGNoIChGSUVMRF9HRVQoUEFUQ0hfU0VDX0VOQ19U
WVBFX01BU0ssIGluZm8pKSB7CmRpZmYgLS1naXQgYS9tdDc2X2Nvbm5hY19tY3UuaCBiL210NzZf
Y29ubmFjX21jdS5oCmluZGV4IDhkNTljZjQzZi4uZTllYzNiN2M3IDEwMDY0NAotLS0gYS9tdDc2
X2Nvbm5hY19tY3UuaAorKysgYi9tdDc2X2Nvbm5hY19tY3UuaApAQCAtMTg2NSw3ICsxODY1LDcg
QEAgbXQ3Nl9jb25uYWNfbWN1X2dlbl9kbF9tb2RlKHN0cnVjdCBtdDc2X2RldiAqZGV2LCB1OCBm
ZWF0dXJlX3NldCwgYm9vbCBpc193YSkKIAogCXJldCB8PSBmZWF0dXJlX3NldCAmIEZXX0ZFQVRV
UkVfU0VUX0VOQ1JZUFQgPwogCSAgICAgICBETF9NT0RFX0VOQ1JZUFQgfCBETF9NT0RFX1JFU0VU
X1NFQ19JViA6IDA7Ci0JaWYgKGlzX210NzkyMShkZXYpIHx8IGlzX210NzkyNShkZXYpKQorCWlm
IChpc19jb25uYWMyKGRldikgfHwgaXNfbXQ3OTI1KGRldikpCiAJCXJldCB8PSBmZWF0dXJlX3Nl
dCAmIEZXX0ZFQVRVUkVfRU5DUllfTU9ERSA/CiAJCSAgICAgICBETF9DT05GSUdfRU5DUllfTU9E
RV9TRUwgOiAwOwogCXJldCB8PSBGSUVMRF9QUkVQKERMX01PREVfS0VZX0lEWCwKZGlmZiAtLWdp
dCBhL210NzkyMS9pbml0LmMgYi9tdDc5MjEvaW5pdC5jCmluZGV4IDI5NzMyMzE1YS4uOGU3Nzkw
NzAyIDEwMDY0NAotLS0gYS9tdDc5MjEvaW5pdC5jCisrKyBiL210NzkyMS9pbml0LmMKQEAgLTMw
Miw3ICszMDIsOSBAQCBpbnQgbXQ3OTIxX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgbXQ3OTJ4X2Rl
diAqZGV2KQogCWRldi0+cG0uaWRsZV90aW1lb3V0ID0gTVQ3OTJ4X1BNX1RJTUVPVVQ7CiAJZGV2
LT5wbS5zdGF0cy5sYXN0X3dha2VfZXZlbnQgPSBqaWZmaWVzOwogCWRldi0+cG0uc3RhdHMubGFz
dF9kb3plX2V2ZW50ID0gamlmZmllczsKLQlpZiAoIW10NzZfaXNfdXNiKCZkZXYtPm10NzYpKSB7
CisKKwlpZiAoIW10NzZfaXNfdXNiKCZkZXYtPm10NzYpICYmCisJICAgICFpc19tdDc5MDIoJmRl
di0+bXQ3NikpIHsKIAkJZGV2LT5wbS5lbmFibGVfdXNlciA9IHRydWU7CiAJCWRldi0+cG0uZW5h
YmxlID0gdHJ1ZTsKIAkJZGV2LT5wbS5kc19lbmFibGVfdXNlciA9IHRydWU7CmRpZmYgLS1naXQg
YS9tdDc5MjEvbXQ3OTIxLmggYi9tdDc5MjEvbXQ3OTIxLmgKaW5kZXggODNmYzdmNDlmLi5kMzVl
NmQ1N2MgMTAwNjQ0Ci0tLSBhL210NzkyMS9tdDc5MjEuaAorKysgYi9tdDc5MjEvbXQ3OTIxLmgK
QEAgLTE1LDYgKzE1LDkgQEAKICNkZWZpbmUgTVQ3OTIxX1JYX01DVV9SSU5HX1NJWkUJCTgKICNk
ZWZpbmUgTVQ3OTIxX1JYX01DVV9XQV9SSU5HX1NJWkUJNTEyCiAKKy8qIE1UNzkwMiBSeCBSaW5n
MCBpcyBmb3IgYm90aCBSeCBFdmVudCBhbmQgVHggRG9uZSBFdmVudCAqLworI2RlZmluZSBNVDc5
MDJfUlhfTUNVX1JJTkdfU0laRQkJNTEyCisKICNkZWZpbmUgTVQ3OTIxX0VFUFJPTV9TSVpFCQkz
NTg0CiAjZGVmaW5lIE1UNzkyMV9UT0tFTl9TSVpFCQk4MTkyCiAKQEAgLTExNyw2ICsxMjAsMTcg
QEAgZW51bSBtdDc5MjFfcnhxX2lkIHsKIAlNVDc5MjFfUlhRX01DVV9XTSA9IDAsCiB9OwogCisv
KiBNVDc5MDIgYXNzaWducyBpdHMgTUNVLVdNIFRYUSBhdCBpbmRleCAxNSAqLworZW51bSBtdDc5
MDJfdHhxX2lkIHsKKwlNVDc5MDJfVFhRX01DVV9XTSA9IDE1LAorfTsKKworc3RydWN0IG10Nzky
MV9kbWFfbGF5b3V0IHsKKwl1OCBtY3Vfd21fdHhxOworCXUxNiBtY3Vfcnhkb25lX3Jpbmdfc2l6
ZTsKKwlib29sIGhhc19tY3Vfd2E7Cit9OworCiBlbnVtIHsKIAlNVDc5MjFfQ0xDX1BPV0VSLAog
CU1UNzkyMV9DTENfQ0hBTiwKZGlmZiAtLWdpdCBhL210NzkyMS9wY2kuYyBiL210NzkyMS9wY2ku
YwppbmRleCBlYzk2ODYxODMuLjg2N2IzMTMwOCAxMDA2NDQKLS0tIGEvbXQ3OTIxL3BjaS5jCisr
KyBiL210NzkyMS9wY2kuYwpAQCAtMjYsNiArMjYsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBj
aV9kZXZpY2VfaWQgbXQ3OTIxX3BjaV9kZXZpY2VfdGFibGVbXSA9IHsKIAkJLmRyaXZlcl9kYXRh
ID0gKGtlcm5lbF91bG9uZ190KU1UNzkyMl9GSVJNV0FSRV9XTSB9LAogCXsgUENJX0RFVklDRShQ
Q0lfVkVORE9SX0lEX01FRElBVEVLLCAweDc5MjApLAogCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVs
X3Vsb25nX3QpTVQ3OTIwX0ZJUk1XQVJFX1dNIH0sCisJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1Jf
SURfTUVESUFURUssIDB4NzkwMiksCisJCS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdClN
VDc5MDJfRklSTVdBUkVfV00gfSwKIAl7IH0sCiB9OwogCkBAIC0xNjcsOCArMTY5LDI5IEBAIHN0
YXRpYyB1MzIgbXQ3OTIxX3JtdyhzdHJ1Y3QgbXQ3Nl9kZXYgKm1kZXYsIHUzMiBvZmZzZXQsIHUz
MiBtYXNrLCB1MzIgdmFsKQogCiBzdGF0aWMgaW50IG10NzkyMV9kbWFfaW5pdChzdHJ1Y3QgbXQ3
OTJ4X2RldiAqZGV2KQogeworCXN0cnVjdCBtdDc5MjFfZG1hX2xheW91dCBsYXlvdXQgPSB7CisJ
CS8qIEdlbmVyYWwgY2FzZTogTVQ3OTIxIC8gTVQ3OTIyIC9NVDc5MjAgKi8KKwkJLm1jdV93bV90
eHEgICAgICAgICAgICA9IE1UNzkyMV9UWFFfTUNVX1dNLAorCQkubWN1X3J4ZG9uZV9yaW5nX3Np
emUgID0gTVQ3OTIxX1JYX01DVV9SSU5HX1NJWkUsCisJCS5oYXNfbWN1X3dhICAgICAgICAgICAg
PSB0cnVlLAorCX07CisJYm9vbCBpc19tdDc5MDI7CiAJaW50IHJldDsKIAorCWlzX210NzkwMiA9
IG10NzkyMV9sMV9ycihkZXYsIE1UX0hXX0NISVBJRCkgPT0gMHg3OTAyOworCisJLyoKKwkgKiBN
VDc5MDIgc3BlY2lhbCBjYXNlOgorCSAqICAgLSBNQ1UtV00gVFhRIHVzZXMgaW5kZXggMTUKKwkg
KiAgIC0gUlggUmluZzAgaXMgbGFyZ2VyIGFuZCBzaGFyZWQgZm9yIGV2ZW50L1RYLWRvbmUKKwkg
KiAgIC0gTVQ3OTAyIGRvZXMgbm90IHVzZSB0aGUgTUNVX1dBIHJpbmcKKwkgKi8KKwlpZiAoaXNf
bXQ3OTAyKSB7CisJCWxheW91dC5tY3Vfd21fdHhxICAgICAgICAgICA9IE1UNzkwMl9UWFFfTUNV
X1dNOworCQlsYXlvdXQubWN1X3J4ZG9uZV9yaW5nX3NpemUgPSBNVDc5MDJfUlhfTUNVX1JJTkdf
U0laRTsKKwkJbGF5b3V0Lmhhc19tY3Vfd2EgICAgICAgICAgID0gZmFsc2U7CisJfQorCiAJbXQ3
Nl9kbWFfYXR0YWNoKCZkZXYtPm10NzYpOwogCiAJcmV0ID0gbXQ3OTJ4X2RtYV9kaXNhYmxlKGRl
diwgdHJ1ZSk7CkBAIC0xODUsNyArMjA4LDcgQEAgc3RhdGljIGludCBtdDc5MjFfZG1hX2luaXQo
c3RydWN0IG10NzkyeF9kZXYgKmRldikKIAltdDc2X3dyKGRldiwgTVRfV0ZETUEwX1RYX1JJTkcw
X0VYVF9DVFJMLCAweDQpOwogCiAJLyogY29tbWFuZCB0byBXTSAqLwotCXJldCA9IG10NzZfaW5p
dF9tY3VfcXVldWUoJmRldi0+bXQ3NiwgTVRfTUNVUV9XTSwgTVQ3OTIxX1RYUV9NQ1VfV00sCisJ
cmV0ID0gbXQ3Nl9pbml0X21jdV9xdWV1ZSgmZGV2LT5tdDc2LCBNVF9NQ1VRX1dNLCBsYXlvdXQu
bWN1X3dtX3R4cSwKIAkJCQkgIE1UNzkyMV9UWF9NQ1VfUklOR19TSVpFLCBNVF9UWF9SSU5HX0JB
U0UpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CkBAIC0xOTksMTggKzIyMiwyMCBAQCBzdGF0
aWMgaW50IG10NzkyMV9kbWFfaW5pdChzdHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2KQogCS8qIGV2ZW50
IGZyb20gV00gYmVmb3JlIGZpcm13YXJlIGRvd25sb2FkICovCiAJcmV0ID0gbXQ3Nl9xdWV1ZV9h
bGxvYyhkZXYsICZkZXYtPm10NzYucV9yeFtNVF9SWFFfTUNVXSwKIAkJCSAgICAgICBNVDc5MjFf
UlhRX01DVV9XTSwKLQkJCSAgICAgICBNVDc5MjFfUlhfTUNVX1JJTkdfU0laRSwKKwkJCSAgICAg
ICBsYXlvdXQubWN1X3J4ZG9uZV9yaW5nX3NpemUsCiAJCQkgICAgICAgTVRfUlhfQlVGX1NJWkUs
IE1UX1JYX0VWRU5UX1JJTkdfQkFTRSk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAotCS8q
IENoYW5nZSBtY3UgcXVldWUgYWZ0ZXIgZmlybXdhcmUgZG93bmxvYWQgKi8KLQlyZXQgPSBtdDc2
X3F1ZXVlX2FsbG9jKGRldiwgJmRldi0+bXQ3Ni5xX3J4W01UX1JYUV9NQ1VfV0FdLAotCQkJICAg
ICAgIE1UNzkyMV9SWFFfTUNVX1dNLAotCQkJICAgICAgIE1UNzkyMV9SWF9NQ1VfV0FfUklOR19T
SVpFLAotCQkJICAgICAgIE1UX1JYX0JVRl9TSVpFLCBNVF9XRkRNQTAoMHg1NDApKTsKLQlpZiAo
cmV0KQotCQlyZXR1cm4gcmV0OworCWlmIChsYXlvdXQuaGFzX21jdV93YSkgeworCQkvKiBDaGFu
Z2UgbWN1IHF1ZXVlIGFmdGVyIGZpcm13YXJlIGRvd25sb2FkICovCisJCXJldCA9IG10NzZfcXVl
dWVfYWxsb2MoZGV2LCAmZGV2LT5tdDc2LnFfcnhbTVRfUlhRX01DVV9XQV0sCisJCQkJICAgICAg
IE1UNzkyMV9SWFFfTUNVX1dNLAorCQkJCSAgICAgICBNVDc5MjFfUlhfTUNVX1dBX1JJTkdfU0la
RSwKKwkJCQkgICAgICAgTVRfUlhfQlVGX1NJWkUsIE1UX1dGRE1BMCgweDU0MCkpOworCQlpZiAo
cmV0KQorCQkJcmV0dXJuIHJldDsKKwl9CiAKIAkvKiByeCBkYXRhICovCiAJcmV0ID0gbXQ3Nl9x
dWV1ZV9hbGxvYyhkZXYsICZkZXYtPm10NzYucV9yeFtNVF9SWFFfTUFJTl0sCkBAIC0zMjYsNiAr
MzUxLDIwIEBAIHN0YXRpYyBpbnQgbXQ3OTIxX3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRl
diwKIAlkZXYtPmhpZl9vcHMgPSAmbXQ3OTIxX3BjaWVfb3BzOwogCWRldi0+aXJxX21hcCA9ICZp
cnFfbWFwOwogCW10NzZfbW1pb19pbml0KCZkZXYtPm10NzYsIHBjaW1faW9tYXBfdGFibGUocGRl
dilbMF0pOworCisJaWYgKGlkLT5kZXZpY2UgPT0gMHg3OTAyKSB7CisJCXN0cnVjdCBtdDc5Mnhf
aXJxX21hcCAqbWFwOworCisJCS8qIE1UNzkwMiBuZWVkcyBhIG11dGFibGUgY29weSBiZWNhdXNl
IHdtMl9jb21wbGV0ZV9tYXNrIGRpZmZlcnMgKi8KKwkJbWFwID0gZGV2bV9rbWVtZHVwKCZwZGV2
LT5kZXYsICZpcnFfbWFwLAorCQkJCSAgIHNpemVvZihpcnFfbWFwKSwgR0ZQX0tFUk5FTCk7CisJ
CWlmICghbWFwKQorCQkJcmV0dXJuIC1FTk9NRU07CisKKwkJbWFwLT5yeC53bTJfY29tcGxldGVf
bWFzayA9IDA7CisJCWRldi0+aXJxX21hcCA9IG1hcDsKKwl9CisKIAl0YXNrbGV0X2luaXQoJm1k
ZXYtPmlycV90YXNrbGV0LCBtdDc5MnhfaXJxX3Rhc2tsZXQsICh1bnNpZ25lZCBsb25nKWRldik7
CiAKIAlkZXYtPnBoeS5kZXYgPSBkZXY7CkBAIC01NzksNiArNjE4LDggQEAgTU9EVUxFX0ZJUk1X
QVJFKE1UNzkyMV9GSVJNV0FSRV9XTSk7CiBNT0RVTEVfRklSTVdBUkUoTVQ3OTIxX1JPTV9QQVRD
SCk7CiBNT0RVTEVfRklSTVdBUkUoTVQ3OTIyX0ZJUk1XQVJFX1dNKTsKIE1PRFVMRV9GSVJNV0FS
RShNVDc5MjJfUk9NX1BBVENIKTsKK01PRFVMRV9GSVJNV0FSRShNVDc5MDJfRklSTVdBUkVfV00p
OworTU9EVUxFX0ZJUk1XQVJFKE1UNzkwMl9ST01fUEFUQ0gpOwogTU9EVUxFX0FVVEhPUigiU2Vh
biBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPiIpOwogTU9EVUxFX0FVVEhPUigiTG9yZW56
byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPiIpOwogTU9EVUxFX0RFU0NSSVBUSU9OKCJN
ZWRpYVRlayBNVDc5MjFFIChQQ0llKSB3aXJlbGVzcyBkcml2ZXIiKTsKZGlmZiAtLWdpdCBhL210
NzkyMS9wY2lfbWFjLmMgYi9tdDc5MjEvcGNpX21hYy5jCmluZGV4IDVlYzA4NDQzMi4uMGRiN2Fj
YjNhIDEwMDY0NAotLS0gYS9tdDc5MjEvcGNpX21hYy5jCisrKyBiL210NzkyMS9wY2lfbWFjLmMK
QEAgLTcxLDkgKzcxLDkgQEAgaW50IG10NzkyMWVfbWFjX3Jlc2V0KHN0cnVjdCBtdDc5MnhfZGV2
ICpkZXYpCiAJbXQ3Nl90eHFfc2NoZWR1bGVfYWxsKCZkZXYtPm1waHkpOwogCiAJbXQ3Nl93b3Jr
ZXJfZGlzYWJsZSgmZGV2LT5tdDc2LnR4X3dvcmtlcik7Ci0JbmFwaV9kaXNhYmxlKCZkZXYtPm10
NzYubmFwaVtNVF9SWFFfTUFJTl0pOwotCW5hcGlfZGlzYWJsZSgmZGV2LT5tdDc2Lm5hcGlbTVRf
UlhRX01DVV0pOwotCW5hcGlfZGlzYWJsZSgmZGV2LT5tdDc2Lm5hcGlbTVRfUlhRX01DVV9XQV0p
OworCW10NzZfZm9yX2VhY2hfcV9yeCgmZGV2LT5tdDc2LCBpKSB7CisJCW5hcGlfZGlzYWJsZSgm
ZGV2LT5tdDc2Lm5hcGlbaV0pOworCX0KIAluYXBpX2Rpc2FibGUoJmRldi0+bXQ3Ni50eF9uYXBp
KTsKIAogCW10NzZfY29ubmFjMl90eF90b2tlbl9wdXQoJmRldi0+bXQ3Nik7CmRpZmYgLS1naXQg
YS9tdDc5MjEvc2Rpby5jIGIvbXQ3OTIxL3NkaW8uYwppbmRleCAzNDIxZTUzZGMuLjkxNTBmMTg1
NyAxMDA2NDQKLS0tIGEvbXQ3OTIxL3NkaW8uYworKysgYi9tdDc5MjEvc2Rpby5jCkBAIC0xOSw2
ICsxOSw4IEBACiBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaW9fZGV2aWNlX2lkIG10NzkyMXNfdGFi
bGVbXSA9IHsKIAl7IFNESU9fREVWSUNFKFNESU9fVkVORE9SX0lEX01FRElBVEVLLCAweDc5MDEp
LAogCQkuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpTVQ3OTIxX0ZJUk1XQVJFX1dNIH0s
CisJeyBTRElPX0RFVklDRShTRElPX1ZFTkRPUl9JRF9NRURJQVRFSywgMHg3OTAyKSwKKwkJLmRy
aXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KU1UNzkwMl9GSVJNV0FSRV9XTSB9LAogCXsgfQkv
KiBUZXJtaW5hdGluZyBlbnRyeSAqLwogfTsKIApAQCAtMzE3LDYgKzMxOSw4IEBAIHN0YXRpYyBp
bnQgbXQ3OTIxc19yZXN1bWUoc3RydWN0IGRldmljZSAqX19kZXYpCiBNT0RVTEVfREVWSUNFX1RB
QkxFKHNkaW8sIG10NzkyMXNfdGFibGUpOwogTU9EVUxFX0ZJUk1XQVJFKE1UNzkyMV9GSVJNV0FS
RV9XTSk7CiBNT0RVTEVfRklSTVdBUkUoTVQ3OTIxX1JPTV9QQVRDSCk7CitNT0RVTEVfRklSTVdB
UkUoTVQ3OTAyX0ZJUk1XQVJFX1dNKTsKK01PRFVMRV9GSVJNV0FSRShNVDc5MDJfUk9NX1BBVENI
KTsKIAogc3RhdGljIERFRklORV9TSU1QTEVfREVWX1BNX09QUyhtdDc5MjFzX3BtX29wcywgbXQ3
OTIxc19zdXNwZW5kLCBtdDc5MjFzX3Jlc3VtZSk7CiAKZGlmZiAtLWdpdCBhL210NzkyeC5oIGIv
bXQ3OTJ4LmgKaW5kZXggODM4ODYzOGVkLi4xZjM4MWFiMzUgMTAwNjQ0Ci0tLSBhL210NzkyeC5o
CisrKyBiL210NzkyeC5oCkBAIC00MSwxMSArNDEsMTMgQEAKICNkZWZpbmUgTVQ3OTJ4X01DVV9J
TklUX1JFVFJZX0NPVU5UCTEwCiAjZGVmaW5lIE1UNzkyeF9XRlNZU19JTklUX1JFVFJZX0NPVU5U
CTIKIAorI2RlZmluZSBNVDc5MDJfRklSTVdBUkVfV00JIm1lZGlhdGVrL1dJRklfUkFNX0NPREVf
TVQ3OTAyXzEuYmluIgogI2RlZmluZSBNVDc5MjBfRklSTVdBUkVfV00JIm1lZGlhdGVrL1dJRklf
UkFNX0NPREVfTVQ3OTYxXzFhLmJpbiIKICNkZWZpbmUgTVQ3OTIxX0ZJUk1XQVJFX1dNCSJtZWRp
YXRlay9XSUZJX1JBTV9DT0RFX01UNzk2MV8xLmJpbiIKICNkZWZpbmUgTVQ3OTIyX0ZJUk1XQVJF
X1dNCSJtZWRpYXRlay9XSUZJX1JBTV9DT0RFX01UNzkyMl8xLmJpbiIKICNkZWZpbmUgTVQ3OTI1
X0ZJUk1XQVJFX1dNCSJtZWRpYXRlay9tdDc5MjUvV0lGSV9SQU1fQ09ERV9NVDc5MjVfMV8xLmJp
biIKIAorI2RlZmluZSBNVDc5MDJfUk9NX1BBVENICSJtZWRpYXRlay9XSUZJX01UNzkwMl9wYXRj
aF9tY3VfMV8xX2hkci5iaW4iCiAjZGVmaW5lIE1UNzkyMF9ST01fUEFUQ0gJIm1lZGlhdGVrL1dJ
RklfTVQ3OTYxX3BhdGNoX21jdV8xYV8yX2hkci5iaW4iCiAjZGVmaW5lIE1UNzkyMV9ST01fUEFU
Q0gJIm1lZGlhdGVrL1dJRklfTVQ3OTYxX3BhdGNoX21jdV8xXzJfaGRyLmJpbiIKICNkZWZpbmUg
TVQ3OTIyX1JPTV9QQVRDSAkibWVkaWF0ZWsvV0lGSV9NVDc5MjJfcGF0Y2hfbWN1XzFfMV9oZHIu
YmluIgpAQCAtNDQ4LDYgKzQ1MCw4IEBAIHZvaWQgbXQ3OTJ4X2NvbmZpZ19tYWNfYWRkcl9saXN0
KHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYpOwogc3RhdGljIGlubGluZSBjaGFyICptdDc5MnhfcmFt
X25hbWUoc3RydWN0IG10NzkyeF9kZXYgKmRldikKIHsKIAlzd2l0Y2ggKG10NzZfY2hpcCgmZGV2
LT5tdDc2KSkgeworCWNhc2UgMHg3OTAyOgorCQlyZXR1cm4gTVQ3OTAyX0ZJUk1XQVJFX1dNOwog
CWNhc2UgMHg3OTIwOgogCQlyZXR1cm4gTVQ3OTIwX0ZJUk1XQVJFX1dNOwogCWNhc2UgMHg3OTIy
OgpAQCAtNDYyLDYgKzQ2Niw4IEBAIHN0YXRpYyBpbmxpbmUgY2hhciAqbXQ3OTJ4X3JhbV9uYW1l
KHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYpCiBzdGF0aWMgaW5saW5lIGNoYXIgKm10NzkyeF9wYXRj
aF9uYW1lKHN0cnVjdCBtdDc5MnhfZGV2ICpkZXYpCiB7CiAJc3dpdGNoIChtdDc2X2NoaXAoJmRl
di0+bXQ3NikpIHsKKwljYXNlIDB4NzkwMjoKKwkJcmV0dXJuIE1UNzkwMl9ST01fUEFUQ0g7CiAJ
Y2FzZSAweDc5MjA6CiAJCXJldHVybiBNVDc5MjBfUk9NX1BBVENIOwogCWNhc2UgMHg3OTIyOgpk
aWZmIC0tZ2l0IGEvbXQ3OTJ4X2NvcmUuYyBiL210NzkyeF9jb3JlLmMKaW5kZXggZjJlZDE2ZmVi
Li44ZmNhM2VkNjIgMTAwNjQ0Ci0tLSBhL210NzkyeF9jb3JlLmMKKysrIGIvbXQ3OTJ4X2NvcmUu
YwpAQCAtMTUxLDcgKzE1MSw3IEBAIHZvaWQgbXQ3OTJ4X3N0b3Aoc3RydWN0IGllZWU4MDIxMV9o
dyAqaHcsIGJvb2wgc3VzcGVuZCkKIAljYW5jZWxfd29ya19zeW5jKCZkZXYtPnJlc2V0X3dvcmsp
OwogCW10NzZfY29ubmFjX2ZyZWVfcGVuZGluZ190eF9za2JzKCZkZXYtPnBtLCBOVUxMKTsKIAot
CWlmIChpc19tdDc5MjEoJmRldi0+bXQ3NikpIHsKKwlpZiAoaXNfY29ubmFjMigmZGV2LT5tdDc2
KSkgewogCQltdDc5MnhfbXV0ZXhfYWNxdWlyZShkZXYpOwogCQltdDc2X2Nvbm5hY19tY3Vfc2V0
X21hY19lbmFibGUoJmRldi0+bXQ3NiwgMCwgZmFsc2UsIGZhbHNlKTsKIAkJbXQ3OTJ4X211dGV4
X3JlbGVhc2UoZGV2KTsKQEAgLTY5MSw3ICs2OTEsNyBAQCBpbnQgbXQ3OTJ4X2luaXRfd2lwaHko
c3RydWN0IGllZWU4MDIxMV9odyAqaHcpCiAJaWVlZTgwMjExX2h3X3NldChodywgU1VQUE9SVFNf
TVVMVElfQlNTSUQpOwogCWllZWU4MDIxMV9od19zZXQoaHcsIFNVUFBPUlRTX09OTFlfSEVfTVVM
VElfQlNTSUQpOwogCi0JaWYgKGlzX210NzkyMSgmZGV2LT5tdDc2KSkgeworCWlmIChpc19jb25u
YWMyKCZkZXYtPm10NzYpKSB7CiAJCWllZWU4MDIxMV9od19zZXQoaHcsIENIQU5DVFhfU1RBX0NT
QSk7CiAJfQogCkBAIC05MjcsNiArOTI3LDEzIEBAIGludCBtdDc5MnhfbG9hZF9maXJtd2FyZShz
dHJ1Y3QgbXQ3OTJ4X2RldiAqZGV2KQogewogCWludCByZXQ7CiAKKwltdDc2X2Nvbm5hY19tY3Vf
cmVzdGFydCgmZGV2LT5tdDc2KTsKKworCWlmICghbXQ3Nl9wb2xsX21zZWMoZGV2LCBNVF9DT05O
X09OX01JU0MsIE1UX1RPUF9NSVNDX0ZXX1NUQVRFLAorCQkJICAgIE1UX1RPUF9NSVNDMl9GV19Q
V1JfT04sIDEwMDApKQorCQlkZXZfd2FybihkZXYtPm10NzYuZGV2LAorCQkJICJNQ1UgaXMgbm90
IHJlYWR5IGZvciBmaXJtd2FyZSBkb3dubG9hZFxuIik7CisKIAlyZXQgPSBtdDc2X2Nvbm5hYzJf
bG9hZF9wYXRjaCgmZGV2LT5tdDc2LCBtdDc5MnhfcGF0Y2hfbmFtZShkZXYpKTsKIAlpZiAocmV0
KQogCQlyZXR1cm4gcmV0OwpkaWZmIC0tZ2l0IGEvbXQ3OTJ4X2RtYS5jIGIvbXQ3OTJ4X2RtYS5j
CmluZGV4IDFkZGVjNzc4OC4uMDAyYWVjZTg1IDEwMDY0NAotLS0gYS9tdDc5MnhfZG1hLmMKKysr
IGIvbXQ3OTJ4X2RtYS5jCkBAIC0xMDMsNiArMTAzLDIyIEBAIHN0YXRpYyB2b2lkIG10NzkyeF9k
bWFfcHJlZmV0Y2goc3RydWN0IG10NzkyeF9kZXYgKmRldikKIAkJbXQ3Nl93cihkZXYsIE1UX1dG
RE1BMF9UWF9SSU5HM19FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwNDAwLCAweDEwKSk7CiAJCW10NzZf
d3IoZGV2LCBNVF9XRkRNQTBfVFhfUklORzE1X0VYVF9DVFJMLCBQUkVGRVRDSCgweDA1MDAsIDB4
NCkpOwogCQltdDc2X3dyKGRldiwgTVRfV0ZETUEwX1RYX1JJTkcxNl9FWFRfQ1RSTCwgUFJFRkVU
Q0goMHgwNTQwLCAweDQpKTsKKwl9IGVsc2UgaWYgKGlzX210NzkwMigmZGV2LT5tdDc2KSkgewor
CQkvKiByeCByaW5nICovCisJCW10NzZfd3IoZGV2LCBNVF9XRkRNQTBfUlhfUklORzBfRVhUX0NU
UkwsIFBSRUZFVENIKDB4MDAwMCwgMHg0KSk7CisJCW10NzZfd3IoZGV2LCBNVF9XRkRNQTBfUlhf
UklORzFfRVhUX0NUUkwsIFBSRUZFVENIKDB4MDA0MCwgMHg0KSk7CisJCW10NzZfd3IoZGV2LCBN
VF9XRkRNQTBfUlhfUklORzJfRVhUX0NUUkwsIFBSRUZFVENIKDB4MDA4MCwgMHg0KSk7CisJCW10
NzZfd3IoZGV2LCBNVF9XRkRNQTBfUlhfUklORzNfRVhUX0NUUkwsIFBSRUZFVENIKDB4MDBjMCwg
MHg0KSk7CisJCS8qIHR4IHJpbmcgKi8KKwkJbXQ3Nl93cihkZXYsIE1UX1dGRE1BMF9UWF9SSU5H
MF9FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwMTAwLCAweDQpKTsKKwkJbXQ3Nl93cihkZXYsIE1UX1dG
RE1BMF9UWF9SSU5HMV9FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwMTQwLCAweDQpKTsKKwkJbXQ3Nl93
cihkZXYsIE1UX1dGRE1BMF9UWF9SSU5HMl9FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwMTgwLCAweDQp
KTsKKwkJbXQ3Nl93cihkZXYsIE1UX1dGRE1BMF9UWF9SSU5HM19FWFRfQ1RSTCwgUFJFRkVUQ0go
MHgwMWMwLCAweDQpKTsKKwkJbXQ3Nl93cihkZXYsIE1UX1dGRE1BMF9UWF9SSU5HNF9FWFRfQ1RS
TCwgUFJFRkVUQ0goMHgwMjAwLCAweDQpKTsKKwkJbXQ3Nl93cihkZXYsIE1UX1dGRE1BMF9UWF9S
SU5HNV9FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwMjQwLCAweDQpKTsKKwkJbXQ3Nl93cihkZXYsIE1U
X1dGRE1BMF9UWF9SSU5HNl9FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwMjgwLCAweDQpKTsKKwkJbXQ3
Nl93cihkZXYsIE1UX1dGRE1BMF9UWF9SSU5HMTVfRVhUX0NUUkwsIFBSRUZFVENIKDB4MDJjMCwg
MHg0KSk7CisJCW10NzZfd3IoZGV2LCBNVF9XRkRNQTBfVFhfUklORzE2X0VYVF9DVFJMLCBQUkVG
RVRDSCgweDAzMDAsIDB4NCkpOwogCX0gZWxzZSB7CiAJCS8qIHJ4IHJpbmcgKi8KIAkJbXQ3Nl93
cihkZXYsIE1UX1dGRE1BMF9SWF9SSU5HMF9FWFRfQ1RSTCwgUFJFRkVUQ0goMHgwLCAweDQpKTsK
QEAgLTM1Niw3ICszNzIsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChtdDc5MnhfcG9sbF9yeCk7CiAK
IGludCBtdDc5Mnhfd2ZzeXNfcmVzZXQoc3RydWN0IG10NzkyeF9kZXYgKmRldikKIHsKLQl1MzIg
YWRkciA9IGlzX210NzkyMSgmZGV2LT5tdDc2KSA/IDB4MTgwMDAxNDAgOiAweDdjMDAwMTQwOwor
CXUzMiBhZGRyID0gaXNfY29ubmFjMigmZGV2LT5tdDc2KSA/IDB4MTgwMDAxNDAgOiAweDdjMDAw
MTQwOwogCiAJbXQ3Nl9jbGVhcihkZXYsIGFkZHIsIFdGU1lTX1NXX1JTVF9CKTsKIAltc2xlZXAo
NTApOwpkaWZmIC0tZ2l0IGEvbXQ3OTJ4X3JlZ3MuaCBiL210NzkyeF9yZWdzLmgKaW5kZXggYWNm
NjI3YWVkLi43ZGRkZTkyODYgMTAwNjQ0Ci0tLSBhL210NzkyeF9yZWdzLmgKKysrIGIvbXQ3OTJ4
X3JlZ3MuaApAQCAtMjUsNiArMjUsOCBAQAogI2RlZmluZSBNVF9QTEVfQUNfUUVNUFRZKF9uKQkJ
TVRfUExFKDB4NTAwICsgMHg0MCAqIChfbikpCiAjZGVmaW5lIE1UX1BMRV9BTVNEVV9QQUNLX01T
RFVfQ05UKG4pCU1UX1BMRSgweDEwZTAgKyAoKG4pIDw8IDIpKQogCisjZGVmaW5lIE1UX1BTRV9C
QVNFCQkJMHg4MjBjODAwMAorCiAvKiBUTUFDOiBiYW5kIDAoMHgyMTAwMCksIGJhbmQgMSgweGEx
MDAwKSAqLwogI2RlZmluZSBNVF9XRl9UTUFDX0JBU0UoX2JhbmQpCQkoKF9iYW5kKSA/IDB4ODIw
ZjQwMDAgOiAweDgyMGU0MDAwKQogI2RlZmluZSBNVF9XRl9UTUFDKF9iYW5kLCBvZnMpCQkoTVRf
V0ZfVE1BQ19CQVNFKF9iYW5kKSArIChvZnMpKQo=
--0000000000003da882065537b7d4
Content-Type: text/x-python; charset="US-ASCII"; name="extract_firmware.py"
Content-Disposition: attachment; filename="extract_firmware.py"
Content-Transfer-Encoding: base64
Content-ID: <f_mqw2ll2m4>
X-Attachment-Id: f_mqw2ll2m4

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoKaW1wb3J0IG9zCmltcG9ydCBzdHJ1Y3QKaW1wb3J0IHN5
cwoKIyBBbGwgZmlybXdhcmUgYmxvYnMgdG8gZXh0cmFjdCBmcm9tIG10a3dsYW4uZGF0CkZJUk1X
QVJFX0JMT0JTID0gWwogICAgIkJUX1JBTV9DT0RFX01UNjYzOV8yXzFfaGRyLmJpbiIsCiAgICAi
V0lGSV9NVDY2MzlfUEFUQ0hfTUNVXzJfMV9oZHIuYmluIiwKICAgICJXSUZJX1JBTV9DT0RFX01U
NjYzOV8yXzEuYmluIiwKXQoKCmRlZiBleHRyYWN0X2J5X25hbWUoZGF0YSwgbmFtZSwgb3V0cHV0
X3BhdGgpOgogICAgIiIiRXh0cmFjdCBhIG5hbWVkIGZpcm13YXJlIGJsb2IgZnJvbSBhIG10a3ds
YW4uZGF0IGNvbnRhaW5lci4KCiAgICBUaGUgY29udGFpbmVyIGZvcm1hdCBoYXMgZW50cmllcyB3
aXRoOgogICAgICAtIEEgbnVsbC10ZXJtaW5hdGVkIEFTQ0lJIG5hbWUKICAgICAgLSBQYWRkaW5n
IG51bGxzICsgYSAxNC1kaWdpdCBudW1lcmljIHRpbWVzdGFtcAogICAgICAtIDQtYnl0ZSBhbGln
bmVkIG9mZnNldCBhbmQgc2l6ZSBmaWVsZHMgKGxpdHRsZS1lbmRpYW4gdTMyKQogICAgICAtIFRo
ZSBmaXJtd2FyZSBibG9iIGF0IHRoZSBnaXZlbiBvZmZzZXQKICAgICIiIgogICAgbmFtZV9ieXRl
cyA9IG5hbWUuZW5jb2RlKCkgaWYgaXNpbnN0YW5jZShuYW1lLCBzdHIpIGVsc2UgbmFtZQogICAg
aWR4ID0gZGF0YS5maW5kKG5hbWVfYnl0ZXMpCiAgICBpZiBpZHggPT0gLTE6CiAgICAgICAgcmFp
c2UgUnVudGltZUVycm9yKGYiRmlybXdhcmUgZW50cnkgJ3tuYW1lfScgbm90IGZvdW5kIGluIGNv
bnRhaW5lciIpCgogICAgZW50cnlfcG9zID0gaWR4ICsgbGVuKG5hbWVfYnl0ZXMpCgogICAgIyBT
a2lwIG51bGwgcGFkZGluZyBhZnRlciBuYW1lCiAgICB3aGlsZSBlbnRyeV9wb3MgPCBsZW4oZGF0
YSkgYW5kIGRhdGFbZW50cnlfcG9zXSA9PSAweDAwOgogICAgICAgIGVudHJ5X3BvcyArPSAxCgog
ICAgIyBTa2lwIDE0LWRpZ2l0IG51bWVyaWMgdGltZXN0YW1wIGlmIHByZXNlbnQKICAgIGlmIGFs
bCg0OCA8PSBiIDw9IDU3IGZvciBiIGluIGRhdGFbZW50cnlfcG9zIDogZW50cnlfcG9zICsgMTRd
KToKICAgICAgICBlbnRyeV9wb3MgKz0gMTQKCiAgICAjIEFsaWduIHRvIDQtYnl0ZSBib3VuZGFy
eQogICAgZW50cnlfcG9zID0gKGVudHJ5X3BvcyArIDMpICYgfjMKCiAgICBkYXRhX29mZnNldCA9
IHN0cnVjdC51bnBhY2tfZnJvbSgiPEkiLCBkYXRhLCBlbnRyeV9wb3MpWzBdCiAgICBkYXRhX3Np
emUgPSBzdHJ1Y3QudW5wYWNrX2Zyb20oIjxJIiwgZGF0YSwgZW50cnlfcG9zICsgNClbMF0KCiAg
ICBibG9iID0gZGF0YVtkYXRhX29mZnNldCA6IGRhdGFfb2Zmc2V0ICsgZGF0YV9zaXplXQoKICAg
IGlmIGxlbihibG9iKSAhPSBkYXRhX3NpemU6CiAgICAgICAgcmFpc2UgUnVudGltZUVycm9yKAog
ICAgICAgICAgICBmIlNpemUgbWlzbWF0Y2ggZm9yICd7bmFtZX0nOiBleHBlY3RlZCB7ZGF0YV9z
aXplfSwgZ290IHtsZW4oYmxvYil9IgogICAgICAgICkKCiAgICBvdXRfZGlyID0gb3MucGF0aC5k
aXJuYW1lKG91dHB1dF9wYXRoKQogICAgaWYgb3V0X2RpcjoKICAgICAgICBvcy5tYWtlZGlycyhv
dXRfZGlyLCBleGlzdF9vaz1UcnVlKQoKICAgIHdpdGggb3BlbihvdXRwdXRfcGF0aCwgIndiIikg
YXMgZjoKICAgICAgICBmLndyaXRlKGJsb2IpCgogICAgcHJpbnQoZiJFeHRyYWN0ZWQge25hbWV9
OiB7bGVuKGJsb2IpfSBieXRlcyAtPiB7b3V0cHV0X3BhdGh9IikKCgpkZWYgZXh0cmFjdF9hbGwo
bXRrd2xhbl9wYXRoLCBvdXRwdXRfZGlyKToKICAgICIiIkV4dHJhY3QgYWxsIGtub3duIGZpcm13
YXJlIGJsb2JzIHRvIGEgZGlyZWN0b3J5LiIiIgogICAgd2l0aCBvcGVuKG10a3dsYW5fcGF0aCwg
InJiIikgYXMgZjoKICAgICAgICBkYXRhID0gZi5yZWFkKCkKCiAgICBvcy5tYWtlZGlycyhvdXRw
dXRfZGlyLCBleGlzdF9vaz1UcnVlKQoKICAgIGZvciBuYW1lIGluIEZJUk1XQVJFX0JMT0JTOgog
ICAgICAgIG91dHB1dF9wYXRoID0gb3MucGF0aC5qb2luKG91dHB1dF9kaXIsIG5hbWUpCiAgICAg
ICAgZXh0cmFjdF9ieV9uYW1lKGRhdGEsIG5hbWUsIG91dHB1dF9wYXRoKQoKCmlmIF9fbmFtZV9f
ID09ICJfX21haW5fXyI6CiAgICBpZiBsZW4oc3lzLmFyZ3YpICE9IDM6CiAgICAgICAgcHJpbnQo
InVzYWdlOiBleHRyYWN0X2Zpcm13YXJlLnB5IDxtdGt3bGFuLmRhdD4gPG91dHB1dC1kaXItb3It
ZmlsZT4iKQogICAgICAgIHByaW50KAogICAgICAgICAgICAiICBJZiBvdXRwdXQgaXMgYSBkaXJl
Y3Rvcnkgb3IgaGFzIG5vIGV4dGVuc2lvbjogZXh0cmFjdCBhbGwgZmlybXdhcmUgYmxvYnMiCiAg
ICAgICAgKQogICAgICAgIHByaW50KCIgIElmIG91dHB1dCBpcyBhIC5iaW4gZmlsZTogZXh0cmFj
dCBCVCBmaXJtd2FyZSBvbmx5IChsZWdhY3kgbW9kZSkiKQogICAgICAgIHN5cy5leGl0KDEpCgog
ICAgbXRrd2xhbl9wYXRoID0gc3lzLmFyZ3ZbMV0KICAgIG91dHB1dCA9IHN5cy5hcmd2WzJdCgog
ICAgIyBMZWdhY3kgbW9kZTogaWYgb3V0cHV0IGxvb2tzIGxpa2UgYSBzcGVjaWZpYyAuYmluIGZp
bGUsIGV4dHJhY3QgQlQgb25seQogICAgaWYgb3V0cHV0LmVuZHN3aXRoKCIuYmluIik6CiAgICAg
ICAgd2l0aCBvcGVuKG10a3dsYW5fcGF0aCwgInJiIikgYXMgZjoKICAgICAgICAgICAgZGF0YSA9
IGYucmVhZCgpCiAgICAgICAgZXh0cmFjdF9ieV9uYW1lKGRhdGEsIEZJUk1XQVJFX0JMT0JTWzBd
LCBvdXRwdXQpCiAgICBlbHNlOgogICAgICAgIGV4dHJhY3RfYWxsKG10a3dsYW5fcGF0aCwgb3V0
cHV0KQo=
--0000000000003da882065537b7d4--

