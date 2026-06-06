Return-Path: <linux-wireless+bounces-37459-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xF7RNitIJGp24wEAu9opvQ
	(envelope-from <linux-wireless+bounces-37459-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 18:17:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA1064DE9C
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 18:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="DuPM5I/P";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37459-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37459-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0773301C590
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480F02D3A7B;
	Sat,  6 Jun 2026 16:17:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9753D7404E
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 16:17:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780762664; cv=pass; b=TSDwD7ecOxkFi2o2RsdfUwLaoNR2wc1nMLxYLN60Ok0drHrVFgSZlKbjjhKc5TqmQx2A2ys3q1o9Hp4L+dARV/E/l8mQeKbaMUgOjFRqlV6lLGFebBZNHCFpTa03F0ruXYk6lPuia97XAdkwMmymuP0fC0qdDSUaJrxglD7hja0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780762664; c=relaxed/simple;
	bh=skeU1rXbWD077+Wmr7JaK+ua9NPb5sdanVUugBlFKJs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sRrD4xNeU84CJ+WLt/bAZz0uvYZksvLxjgocVqeJ7DeHX0AR+aaZbTZYYOMKxwVwIRjykLH++Nq/lhglGvVBo1Ou7KLdTwLqwYZ6CRFfDwQ8/pUFIH86+kBoqCE/cAAotvbBfLWlT2D6HoJFusb+jnpJX4nHeugpJoypqcvea+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuPM5I/P; arc=pass smtp.client-ip=74.125.224.41
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6604176b575so2822887d50.1
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 09:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780762661; cv=none;
        d=google.com; s=arc-20240605;
        b=a6endoMymOJLKmpuqZLarcn+kYsqSLI6wFsZGQfUMyhTKL57l5x11tpVKqGHO5Yj9o
         8b+AZpPWk/ic0fwuquKvlEqYKRz8n1u4GKyMyg1cughCHeDjaNgSWF9bzED/Rw8X5El1
         hH1ju0SHuSQuXnpEc/OpA60+iABIN7pCQQSdnSJbFKnkAiMDe8JPPv4CVJjPtTivsMyo
         2qjFeHNdOJL3EnBj9GZaGItVWEgqVl/PoBWxGxwrafd2/gCAZvvZICQlIRGlI0t0saaa
         BchRvhyyj7HjFrtCACKk1aW2WdZYHL9QuEN/pXwu1UG3iW3roK3kpZh7aGULKZKCqagI
         012w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=job/bXmyeAQ5WUHXvJq0GUPaer2D+J27sg7ATyqXDKI=;
        fh=RVdA82raBtuzdl7VoBuPL4hDEobYafxCKqry1vryR+U=;
        b=ECGWi7eUN4AroAcOlSC+MK5HYyRzdzY56eiWcjlk+6OxYi+POIfVqtR7NAfCij72tt
         z+fgRUqPLeFffVTNUZl7wiTUcDaKpxyDVtNp6WI0HS2Or1wYyzK4+a2g4EXzU6Vyaqhx
         ujvpfR7VUQss6v5OaYVot78+qIexyHDyzz+JPOo+gqwKa3jhZd0/fXKtkb41BI57dnFF
         kIx8wuUOu38oFUA7srm+eVvJMxiRnjdF8x1pW60EM4MGT36dIjwrqo+GiqsmkMsksBFb
         1ShvLtLVxjyRxKasJcr1zOgQuLx9swVNpFPVaUirmcETKWhpIbbTS/jitIEc06BFZiHh
         Pp3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780762661; x=1781367461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=job/bXmyeAQ5WUHXvJq0GUPaer2D+J27sg7ATyqXDKI=;
        b=DuPM5I/P1HC6U8lMrrTPPzcvwEtT109KZi+VzLifw4bl3bSz8eDtKTwud7qZbYX/Gq
         VIO2QBBuFXLDHhF06p8EIeQbqOk9sQU7n19qWMzC8a0j6s3397km3s6q9CJ6XzFZgWpF
         HSXjLwmNoUkWjScAUWZ/9krtY1ZGj8l1rqo30HhDmg0onDAHOCRMaj11l0XlJZqwimhR
         FGhlkKc7+KPEY/YfBbrIMKCtUUa2G5BeOo8SH3+FtI9q89VU2HNNn1sWayfb3VZsGIjv
         Mvw3ncW0p1wdFIKN1U/AFU3YrnyusDZofNiCeX/MNsr67rKCsAheAxK7yvL+dzeYP5t1
         m90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780762661; x=1781367461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=job/bXmyeAQ5WUHXvJq0GUPaer2D+J27sg7ATyqXDKI=;
        b=XL1UuCCbUIgiueU9mXJ6CLPu+H2WAT7ZakG5+1xfZDHC/Q6/Ps8YCpak7qN/2ffVNn
         k2q3xWZUOBvxOaqmhQvwbMq+DNn4VgCChf2dTx80XNws2jrI7plIYokhSVgmyqm1B3au
         TaiIfUKqtcnQMK8kg+AuyfL0CFRstiIss4BUAqb8yTS0lmXO/JDGgagNbhPVNViaJ/jx
         HimXqErNo/oPH9754f0WUJpDL5kYnn3LlbpDUTbOZTKfX8NJVjE2bbDCnC3SZ0IRcxbK
         waOuyQ5sGpRXlPvKX9HW7bn6H0fbHDN+Q//jRQmfOMKozz/+RtFPN7nzOoxs8JzQVVzP
         tyDA==
X-Gm-Message-State: AOJu0YywdWdKKj/WXVqh6G5VeosGrmoBvsvsVSV2E2jM0+feHBCzqa+f
	gatoGxU2OzwWgfhGtDmSESJoPovq2/cAR4/D98rtCh1thLt8I0tkljUHDQm0z7lM/ek6ia7y59r
	UmZP1SGlYK8MkEXjg/P2/AxMzoHS8oASPGMIV
X-Gm-Gg: Acq92OFVRvmzIO9g5iv+HZlOzkTv7IV4oP1ZzveK0NupfVR4rZt2GZcS00qrmszV/Np
	n5L11eqwjymaKbvjk3bO+J5D0IHLyp1/kmh5/on2Q/XCD5E7aNUK+kX1pe6YMP6z1ASXiZTLGdn
	SO8mUHZQk2sF22zxT95EmFYebWSh5yRyXOJAzhg3qfWe3cY0xNQrVN87SzDymMor63N6GZ5f8Wu
	x8UpBRasc0M1ObSD6bxHN474qJczbJuKF3hXmZAn2IaCPztQ8MWb7dS13LoeSrNQvVQ5OfeyWrW
	LIpPM2dY8HzU8kGV9eBvp5Nsxo+XyuxrhFpnUdA01ZSG3N45V6ne
X-Received: by 2002:a05:690e:4144:b0:660:a653:4495 with SMTP id
 956f58d0204a3-66106e01386mr7610764d50.4.1780762661533; Sat, 06 Jun 2026
 09:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: dheeraj y <yssdhiraj@gmail.com>
Date: Sat, 6 Jun 2026 21:47:06 +0530
X-Gm-Features: AVVi8Cfh7glDdUSab3oFE-SmxojRD8kpUwLaLrtx7HsRwSLPpQomVfaspZ9hQYM
Message-ID: <CACKHTu78z7x0cczrptivFwXYEK0xJgfWQpGxBtU=QbrLssMcPw@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_iwlwifi=3A_Intel_3160_system_freeze_on_suspend_w?=
	=?UTF-8?Q?ith_WoWLAN_magic=2Dpacket_armed_=E2=80=94_persists_on_kernel_6=2E17_de?=
	=?UTF-8?Q?spite_recent_d3=2Ec_patches?=
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, johannes@sipsolutions.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37459-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:kvalo@kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yssdhiraj@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yssdhiraj@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DA1064DE9C

Hi linux-wireless,

Note: I encountered this issue myself, discussed it with Claude, and
asked it to help draft this email.

I am reporting a reproducible system freeze on the Intel Dual Band Wireless
AC 3160 when WoWLAN magic-packet wake is armed. This persists on kernel 6.1=
7
which already includes the recent d3.c patches. I explain below why those
patches do not address this specific failure.

---

SYSTEM INFORMATION
------------------

  Hostname:    yoga-node
  CPU:         Intel Core i7-5500U @ 2.40GHz (x86_64)
  RAM:         7.2 GiB
  OS:          Ubuntu 25.10
  Kernel:      6.17.0-23-generic

  Wi-Fi card:  Intel Dual Band Wireless AC 3160 [Wilkins Peak 1]
  PCI ID:      8086:08b4 (rev 93)
  Subsystem:   8086:8270
  Driver:      iwlwifi / iwlmvm
  Firmware:    17.bfb58538.0 (3160-17.ucode) =E2=80=94 final firmware relea=
se

  $ lspci -nn | grep -i network
  02:00.0 Network controller [0280]: Intel Corporation Wireless 3160
[8086:08b4] (rev 93)

  $ lspci -k -s 02:00.0
  02:00.0 Network controller: Intel Corporation Wireless 3160 (rev 93)
          Subsystem: Intel Corporation Dual Band Wireless AC 3160
[Wilkins Peak 1]
          Kernel driver in use: iwlwifi
          Kernel modules: iwlwifi

  $ dmesg | grep "loaded firmware version"
  iwlwifi 0000:02:00.0: loaded firmware version 17.bfb58538.0
3160-17.ucode op_mode iwlmvm

  $ cat /sys/power/mem_sleep
  s2idle [deep]

  $ cat /proc/acpi/wakeup | grep -E "RP03|PXSX"
  PXSX      S4    *disabled
  PXSX      S4    *disabled
  RP03      S4    *enabled   pci:0000:00:1c.2
  PXSX      S4    *enabled   pci:0000:02:00.0   =E2=86=90 Wi-Fi card, ACPI =
wake enabled
  PXSX      S4    *disabled  pci:0000:03:00.0

  $ cat /etc/modprobe.d/iwlwifi.conf
  options iwlwifi power_save=3D0 bt_coex_active=3D0

---

WOWLAN CAPABILITIES ADVERTISED BY DRIVER
-----------------------------------------

  $ iw phy | grep -A20 "WoWLAN support"
  WoWLAN support:
   * wake up on disconnect
   * wake up on magic packet
   * wake up on pattern match, up to 20 patterns of 16-128 bytes
   * can do GTK rekeying
   * wake up on GTK rekey failure
   * wake up on EAP identity request
   * wake up on 4-way handshake
   * wake up on rfkill release
   * wake up on network detection, up to 11 match sets

The driver fully advertises WoWLAN magic-packet support.

---

STEPS TO REPRODUCE
------------------

1. Arm WoWLAN:
   $ sudo iw phy phy0 wowlan enable magic-packet

2. Verify:
   $ sudo iw phy phy0 wowlan show
   WoWLAN is enabled:
    * wake up on magic packet

3. Suspend:
   $ sudo systemctl suspend

4. Result: system freezes. Power LED stays solid (not blinking).
   SSH becomes unreachable. Only force shutdown recovers the machine.

5. Without WoWLAN armed (default 0x1):
   $ nmcli -f 802-11-wireless.wake-on-wlan connection show "SSID"
   802-11-wireless.wake-on-wlan: 0x1 (default)
   =E2=86=92 suspend and resume work perfectly every time.

---

WHAT I TESTED
-------------

Test 1: Manual iw arm
  $ sudo iw phy phy0 wowlan enable magic-packet
  $ sudo systemctl suspend
  Result: freeze

Test 2: NetworkManager profile set to magic (0x8)
  $ sudo nmcli connection modify "SSID" 802-11-wireless.wake-on-wlan magic
  $ sudo nmcli connection down "SSID" && sudo nmcli connection up "SSID"
  $ sudo iw phy phy0 wowlan show
  WoWLAN is enabled:
   * wake up on magic packet
  $ sudo systemctl suspend
  Result: freeze

Test 3: iwlwifi module options to disable deep power states
  $ echo "options iwlwifi power_save=3D0 bt_coex_active=3D0" \
      | sudo tee /etc/modprobe.d/iwlwifi.conf
  Result: fixed the 30-second pre-suspend delay but freeze still occurs

Test 4: systemd sleep hook to arm WoWLAN after NetworkManager sleeps
  Created /lib/systemd/system-sleep/wowlan-arm.sh:
    #!/bin/bash
    if [ "$1" =3D "pre" ]; then
        /usr/sbin/iw phy phy0 wowlan enable magic-packet
    fi
  Result: freeze =E2=80=94 hook itself caused the hang even earlier in susp=
end path

---

SUSPEND JOURNAL LOG (last freeze attempt)
------------------------------------------

  Jun 06 19:41:11 NetworkManager: sleep requested
  Jun 06 19:41:11 NetworkManager: device (p2p-dev-wlp2s0):
disconnected -> unmanaged (unmanaged-sleeping)
  Jun 06 19:41:11 systemd: Reached target sleep.target
  Jun 06 19:41:11 systemd: Starting systemd-suspend.service
  Jun 06 19:41:11 systemd-sleep: Performing sleep operation 'suspend'...
  Jun 06 19:41:11 kernel: PM: suspend entry (deep)
  [log ends here =E2=80=94 machine froze, never returned from suspend]

Note: with power_save=3D0 the previous 30-second delay between
"sleep requested" and "sleep.target reached" was eliminated,
confirming the module option helps but does not fix the core issue.

---

KNOWN CRASH PATH
----------------

From Debian Bug #1065112 (identical symptoms on kernels 6.1 and 6.7):
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1065112

  drivers/net/wireless/intel/iwlwifi/iwl-trans.c
    :: iwl_trans_txq_enable_cfg() =E2=80=94 reports "bad state"

  drivers/net/wireless/intel/iwlwifi/mvm/d3.c
    :: iwl_mvm_send_wowlan_get_status() =E2=80=94 "failed to query wakeup s=
tatus (-5)"

Prior discussion on this list (2017), Johannes Berg concluded this is
likely broken system/card firmware since it reproduced on Windows too:
https://www.mail-archive.com/linux-wireless@vger.kernel.org/msg32540.html

---

WHY THE RECENT d3.c PATCHES DO NOT FIX THIS
---------------------------------------------

Kernel 6.17 already includes both recent d3.c patches, yet the freeze
persists. Here is why neither patch applies to this case:

1. "Use the sync timepoint API in suspend" (Nov 2024, Daniel Gabay)
   Fixes a race between async debug dump worker and suspend flow:
   "Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)"
   This is a debug dump path race =E2=80=94 unrelated to the WoWLAN arm
   handshake. The 3160 freeze happens in iwl_mvm_send_wowlan_get_status,
   not in the debug timepoint path.

2. "fix WoWLAN command version lookup" (Jun 2024, Yedidya Benshimol)
   Fixes IWL_FW_CMD_VER_UNKNOWN for the notification-based WoWLAN
   status API introduced for newer firmware. The 3160 uses 17.ucode
   which predates this notification API entirely =E2=80=94 the lookup fix h=
as
   no effect on the legacy command path the 3160 uses.

Both patches target device families newer than the 3160. The 3160
uses a legacy firmware interface that has never been patched.

---

ROOT CAUSE ASSESSMENT
----------------------

The Intel 3160 firmware (17.ucode) fails the WoWLAN arm handshake
during the D3 suspend transition. The firmware enters a bad state
before the host CPU completes the sleep sequence, causing a full
system hang. This is a firmware defect =E2=80=94 the driver is doing its jo=
b
correctly but receives no valid acknowledgement from the firmware.

Since 17.ucode is the final firmware release for this card with no
further updates planned, the only viable fix would be a driver-level
workaround, specifically one of:

  a) Runtime detection of the broken capability and graceful skip of
     WoWLAN arming on affected 3160 hardware (PCI ID 8086:08b4), or

  b) A known-broken device quirk entry for 8086:08b4 that prevents
     WoWLAN from being armed, avoiding the freeze while keeping
     normal suspend functional.

---

REQUEST
-------

Is there a known patch or workaround for PCI ID 8086:08b4?
If not, would a quirk patch be acceptable upstream?

I am willing to test any proposed patch.

Thank you.

