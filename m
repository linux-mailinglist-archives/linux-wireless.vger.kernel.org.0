Return-Path: <linux-wireless+bounces-36824-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNsZIlRlEWr7lQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36824-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 10:29:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B105BDDBE
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 10:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF6A30166CF
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2026 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7983733DEC2;
	Sat, 23 May 2026 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZEPNHQK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7B25B080
	for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779524945; cv=pass; b=pAtBbfsjz240e3O2Z67L1gmMiP3GBpST6T7RHM57kPC1igQIzc8wh5w/gRriSL1zKP/kW8+g6qNty3hZy56+2JWIVUbHAZ8YUJV9sjgBUX6I6B9FUO906dm3FQwNDFSuLgMpv4tk88aE0e3eFWeP9fQr5w46otMJhHknag841b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779524945; c=relaxed/simple;
	bh=cigXC0DSstqLG0JFcDfXo35deQO5MQiqKj51Kr2z2YU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UNL4d1I1zN8PpHqwOa1AEpRq8mRLmVZJXu6XkvEOyl55cwwYzoihBUB146rD8I2wIxQ72iI3xP7zJwN65yCxjN/tEdUBoeiS5hDLiKDzT0cERiNHO+MA+za2fP38QbBPEm0J1OeCXlmn/AbesRL/g0p+OWhHn1jrloKS88kgWLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZEPNHQK; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67cac5ece75so15324221a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 23 May 2026 01:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779524942; cv=none;
        d=google.com; s=arc-20240605;
        b=LDKu4t0xg5Ux+dEQbaQgJj3soqa8G+vSro42cxf/vqEkGE/zaKQdG3TwB1APfZ4fYQ
         ai7oLuHHlA4IuaRoMOGOuIo9xGyNONRSMih362tixnNRiuIKTVAMQSYrp7YUlzfudeWd
         4jAhByKj94esttsgcZg4xfVY/awpXOqHNVbxzReahSS+ktHQssV1z61x2JC7sHfhHHMJ
         80mnhSbteKoDrjuxaQP0stvajU9eBPuEEWsefY2lbUkp56bCMn4RpJD0Ky4u2foVEd6u
         uw1BytTbN81D9CcOX3LMIeXa94+nRjanY8jODs/1WeXl4BgJjeye7Qu1i1qqSBsjYmAN
         LkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=VeGJZ1Q2xWRdnqmLzLMyBU9VN3WE4Yh0XJ2WruoO+Z8=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=Hoql67wG1InX4c/yolTs/f/SbEhGWonjgz+f8knAc5C1nC4zdAal5AnUpf5rHT1og0
         64tXOvH6vlHqtWaKbzoFcXXYoZcgXdDBLHAKQ/LDK74xyQDZZHvXovw6nNsqti0oXIq4
         +LkKwvnDlJVF1t2y4HSroQYVp7ywIv/ybJl+TpFEJYX7Qp8dFrTtlMEGnnS3+o5hLNAp
         kLvzeBF7o4ChDN898mplDzgfVjvx+ZCH9qqiGDp11wwqUu/vU6KeoapV12A1zMNXohrv
         oeKG8SalGKpZiNcBlxMANSLiOeJIeD7zIVdtA1YwNk3XVFv+dkXl2R3NBL6YF+9Yd6Vn
         rlgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779524942; x=1780129742; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VeGJZ1Q2xWRdnqmLzLMyBU9VN3WE4Yh0XJ2WruoO+Z8=;
        b=YZEPNHQKkWvHMenmCDxn+j+kkCBjjy06YnNUsmKjRkcaiRums+JSHBm92bcIIs7KnB
         3RwgxrzcMisN39KMjueBkdi8bRQa4Wz1DlrQfhDqZCkHOP9cqsx1Od+aSntba67wkf/f
         fcOOy0Eo/XBu4gt9O+ks9Q4pMyx1p3Yum3rvQNr3M2B8S6PPbYxZl9IAcf17QeJdpEx8
         8pAr/xDlJSCn2AcWZdK+EnIjlG0oJLexEPk3+Rb8PDKkG6kRFomYfLZkKeErNdHuuEEt
         5cYMO3f7qlco68BBqLcqf2wvHuKFZgDpxPYxrusSZMSi1OJjHgdNZesWSmou21KbOg//
         t0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779524942; x=1780129742;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeGJZ1Q2xWRdnqmLzLMyBU9VN3WE4Yh0XJ2WruoO+Z8=;
        b=buXvAe0lUcasuiclQXCcgKYtDgice7WJ/j5kAaAiOngfek5hw0ybighnADj/7LhsVF
         i/37Jx8YYUXh7sSmLb5uZvzV/7F+dW7pv8dHrgZFAzgC2pluImwXPT7/54d8j83yJnjz
         39axACtjJbClC5B/lq16ZhLuEEjAw5vOUNcC7zraRrQY9pzBGbiG2g5liu54nCqxScY2
         hL+VKlY37N2BY+5K3sQ4U/nCW93EbeXuQVMX/1Jm2oO/c2LH1EKhiLhzjNjo8BCp4mcA
         Z+e2lGZqTEbMtl++6cJQ8cpJITGcdYhxhw/WCQxB7BNRKh5sH+0yfXgrePGxZoU9XarH
         mMmA==
X-Gm-Message-State: AOJu0YwUFXYcCb4sLZs3sa9wcou6Cwxv4t59/DGtQR6ObkhCC01UXCmA
	7LWTUPUfWGB+UmNYXWPRtnQAg/DVJ1YKC5CN/Mj+yUL5llFVykBWkv1mppCXH5BMq3bJ0Ng6eub
	7WTP4lX4tCnLe7sCq3OF0CST/U2Z7M/gx13yXfKA=
X-Gm-Gg: Acq92OGNnwVxbB17CcveB5IMNOT0x+hJoU8Mqg2Ua59MWLawJ4R73Gw0EF3fV2BV5JS
	sr+rHDtY/zrQFzZHLr6Yah5Nlx1RBsk56C/3bB+giWF60m6g6iAWTL3cjzcvYC+kSZbdXQqFfZL
	W5iXIz0EwGYgugl59Znj5sE3zwLYksW8Q7OsjMsVMUlQhZpcitDSvt1ZuHRHfgdHYKoKQBPl2wB
	VbbDVceM9ZsYKRnIUS1lY8P7O5TwX68DszVHpUuKu4tMW/T3+Z+MnSsmFPSZHVRx6fAZ+Mi+nJJ
	JsIQrjetMua2G6K1zjoxzaBkT54L0y8fIyKajkYeqYF2olh4oSUO42AXOlCMUFFQiuD7QmGb/Oz
	afUFk+Gir
X-Received: by 2002:a05:6402:43c5:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-6889c42ccb8mr3494135a12.1.1779524942229; Sat, 23 May 2026
 01:29:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Blake <mgblake7@gmail.com>
Date: Sat, 23 May 2026 10:28:49 +0200
X-Gm-Features: AVHnY4Ktgps1ne3kJCyMN8bdncQA-yPbuYNUOO6lbbkLO6GFQB9wP96zXvuuM60
Message-ID: <CAAecyrWNVtgywvchgHe1XLoGKcubEm_pgSQiv+i=6F4zdQhStQ@mail.gmail.com>
Subject: iwlwifi: HE not negotiated on Wi-Fi 7 BE201 (iwlmld, kernel 7.0.9)
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36824-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgblake7@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 05B105BDDBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On an Intel Wi-Fi 7 BE201 card with the iwlmld driver, associations
never negotiate HE (802.11ax) rates despite both the card and the AP
supporting HE. Connections come up as HT-MCS on 2.4 GHz and VHT-MCS on
5 GHz. HE-MCS rates are never observed in `iw dev wlan0 link` output.

Hardware:
  PCI ID:     8086:7740 (Arrow Lake CNVi WiFi)
  Subsystem:  8086:00e4
  Card:       Intel Wi-Fi 7 BE201 320 MHz (per dmesg)
  MIMO:       2x2 (Available Antennas: TX 0x3 RX 0x3)
  Driver:     iwlwifi + iwlmld

Software:
  Kernel:          7.0.9-arch1-1 (Arch Linux, mainline)
  linux-firmware:  20260410
  Firmware loaded: 101.6e695a70.0 bz-b0-fm-c0-c101.ucode op_mode iwlmld
  NetworkManager:  1.56.1
  Tested backends: iwd 3.12 and wpa_supplicant 2:2.11-5

Module parameters at runtime (no userspace blockers):
  disable_11ac:  N
  disable_11ax:  N
  disable_11be:  N
  power_save:    N

AP details:
  TP-Link Deco XE75 mesh, both BSSes broadcasting the same SSID:
    2.4 GHz BSS (ch 3, 40 MHz): HE40/2.4GHz advertised, HE Operation
                                 and HE Capability IEs present
    5 GHz BSS  (ch 36, 80 MHz): HE advertised, HE Operation IE present
  iPhone clients in the same location negotiate HE successfully.

Reproducer:
  Connect to either BSS through NetworkManager (with either
  wpa_supplicant or iwd as the backend). Association succeeds and is
  stable, but rate selection never reaches HE-MCS rates.

Observed link state:

  # 2.4 GHz BSS, iwd backend
  rx bitrate: 300.0 MBit/s MCS 15 40MHz short GI
  tx bitrate: 144.4 MBit/s MCS 15 short GI

  # 2.4 GHz BSS, wpa_supplicant backend
  rx bitrate: 300.0 MBit/s MCS 15 40MHz short GI
  tx bitrate: 104.0 MBit/s MCS 13

  # 5 GHz BSS, wpa_supplicant backend
  rx bitrate: 351.0 MBit/s VHT-MCS 4 160MHz VHT-NSS 1
  tx bitrate: 260.0 MBit/s VHT-MCS 5 80MHz short GI VHT-NSS 1

Expected:
  HE-MCS rates in the bitrate output, consistent with card and AP HE
  capabilities. Tested over many minutes of sustained traffic so this
  is not transient minstrel_ht warm-up.

Additional observation, possibly related: dmesg shows a firmware
crash and restart on the cTDP config command at every boot. The
driver recovers and the device operates normally, but this may
indicate a wider issue with the BE201 firmware path:

  iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 7 BE201 320MHz
  iwlwifi 0000:00:14.3: loaded firmware version 101.6e695a70.0
                       bz-b0-fm-c0-c101.ucode op_mode iwlmld
  iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.
  iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
  iwlwifi 0000:00:14.3: FW error in SYNC CMD CTDP_CONFIG_CMD
  iwlwifi 0000:00:14.3: cTDP command failed (err=-5)

Is HE expected to engage on BE201 with the current iwlmld driver?
Happy to capture more detailed logs (mac80211 trace, iwlwifi debug
masks, association IE dumps) or test patches if useful.

Thanks,
--
Michael Blake
mgblake7@gmail.com

