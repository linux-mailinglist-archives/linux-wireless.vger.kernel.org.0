Return-Path: <linux-wireless+bounces-38770-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id naesAi93TWp10gEAu9opvQ
	(envelope-from <linux-wireless+bounces-38770-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 00:01:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43371FF4E
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 00:01:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VJ9uDcQQ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38770-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38770-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994E2300678F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75E31ED81;
	Tue,  7 Jul 2026 21:59:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8DA47F2FA
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 21:59:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461552; cv=none; b=kqlwVqVF8NllHgz0ivrdbDGrBiD/vpvt25BGMafEfkf8fMFk6+z99w2UVDhmoAJamfTgKSEc1+RHc9KsSmllNBH/up6FsteCx5P+upe62iCY/MKpbX4bz9HK22abIRNZvHjKpz4Z1fY6ST2mZ+N/p86HH5W/J1OB1nNU/NAya3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461552; c=relaxed/simple;
	bh=ztbAAL4KMxc1jB12QrnRNd6Vt1yI6uJizTOovMulFv0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bMcMK6kobC7kBoftaC1jVrSR9MAvGyIMzlwnLnJqUklC3L00uGzWjVFn/EyAeyENhXZS3TFhVWni5GOFpYVLg1sGJj0h2MiHdVbZxZEImNI0rdAQON+1/APqA5kuK2dA+2TwJy9XFdMJ/veRREvXYpT71iuJddu+ySaca6yI/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ9uDcQQ; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso29680075e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jul 2026 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461550; x=1784066350; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XO7RebYdvaS9UKvJ8d0M5ZUraI+91sPhUhPHHz43cA4=;
        b=VJ9uDcQQ/jfeAgCybjpq1d4rovsggC9RI6UCJzJC5Y/zZuUeOw00VsCP3egtxYXN7k
         yvOxX0lOQSM6PVNcl9lrGwhGxe9uG+B9nYnp5AvC/HADZi3PuHCJ9G9lmq4qdYDlLDwc
         8XoYX/HTfzK6hlO7N9ecc0x/ZVIQZH0gTVIMsOn0YbPcNbzZiM4wYy78g6zc2IOWo1p8
         uKnkjqeU63ToN2Z2u+XEeJk1kwzWlstNO+eB0K1v6kvC6PQdtnQtE1kzXuNtGFWBbR8r
         oWDwicv6X0H85Ihwv/FxsC11hzm4t7BXXD+COPyvD8WqvLCma0x0K/jQ/oKlya0WikTG
         NKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461550; x=1784066350;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XO7RebYdvaS9UKvJ8d0M5ZUraI+91sPhUhPHHz43cA4=;
        b=Y+IjK5q1stK+xgciK+3z+GwpSgWmsJK3twk2qMit7mQutXxQwzFfl7MUpbaNMrvry2
         qx2vJTrYvOmvaVLZK03JTUwKlLpvWX6CVIxJjeRCQPuIWxnCBxgRaTOqE1xcBHdBsnPv
         +7QJVjnDNJr873buVNSPW+2H3vRD4EXWt9qhitiATGLx0UmNFNXb97z7kX1cGgDmOS+a
         34NPjGYiMfqwvv7C21CTeELpSKlHYl9beGtkl+DwnrE2A1KEF1GrSSN9x+bQC6nq58cK
         ZqPgAomRsduV9g6m7IGM7nZMaAnjRmPfiDG+63pB+QvrebAlxn+7smvk9hgZgcmmcewN
         Ar8A==
X-Gm-Message-State: AOJu0Yy1oh46SGT8vWPgxuBAGm+Kp8Lcf6xOIrCc3WW/kveaIbdiclxV
	R6I97lIl1k9Gz0bGJN6lj4sHA2eVJJPp3A8BhWiMiHmXB01Ba21DAUE9p/LtHALtErU=
X-Gm-Gg: AfdE7cn0BXDRLqTPJKZ4YKWO1GEb5IiR9dHHcg/aEjneOaozd6rBXQyYnQwilLymIEe
	wRiMO2qAj8GmQkPEbksraftbyIE4pQsRs4ZHbHKMrN9Z0LFc+w6yaaQz7p5Rg9sY2llLMjx1qOv
	XOStKganaj5MnIrrcD7xqNB/DngGfxP4oR1OvTwDa5DM0MGiAn/O5+XrwZBP+N5b4Pn54/D7/6L
	0j2BDdhr9QHSozFnnoDVJgXcsxNg4lOAdGqnWv/32lDaevRMJOm/31PqDhyTEf+yj/0UvsgDWWx
	OAgepCzl3trV2A5XYD9rcHUCPyGYXa+8AU3phwfXk97XMy5t6PvMH078SWpLIjrBDy6dDl4GszS
	Veep8L6WgCwH0cjnBgqpBzEREZkk5bI7eTO8bG2uvB3J7rMJcK5ZnhDRoJ2Cepfx9xnB2kCB8fr
	n4f4bzZ/6jTX78BdnL
X-Received: by 2002:a05:600c:a011:b0:493:e53a:4b24 with SMTP id 5b1f17b1804b1-493e6176bfbmr828365e9.6.1783461549336;
        Tue, 07 Jul 2026 14:59:09 -0700 (PDT)
Received: from fedora.localnet ([2a02:2f04:c302:8b00:f5de:b8b:368d:3609])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960af0sm33948535f8f.30.2026.07.07.14.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:59:08 -0700 (PDT)
From: or1k <tixzit@gmail.com>
To: linux-wireless@vger.kernel.org, pkshih@realtek.com, kvalo@kernel.org
Subject:
 [BUG] rtw89: RTL8852CE RX_DCK timeout + Bluetooth A2DP coexistence failures
 (fw-2.bin 0.27.129.4)
Date: Wed, 08 Jul 2026 00:59:06 +0300
Message-ID: <OduUSxVfSVayC9OVEeIrxw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tixzit@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38770-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:kvalo@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tixzit@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B43371FF4E

Hi,

Reporting a Wi-Fi/Bluetooth coexistence issue on RTL8852CE that also has an
open Fedora/Red Hat tracker (bugzilla.redhat.com #2349675), but that report
was filed against an older firmware (rtw8852c_fw-1.bin, 0.27.97.0). I'm
seeing what looks like the same class of failure on the newer
rtw8852c_fw-2.bin, firmware version 0.27.129.4 (3f1a5302), so it may not be
fully fixed by whatever changed between those firmware revisions.

Hardware:
  Wi-Fi:      Realtek RTL8852CE [10ec:c852] rev 01, Lenovo subsystem=20
[17aa:5852]
              PCI 0000:02:00.0, driver rtw89_8852ce
  Bluetooth:  same combo chip, USB 0bda:5852 "Realtek Bluetooth Radio",
              driver btusb/btrtl, BT firmware rtl8852cu_fw_v2.bin (0x040d72=
25)
  Platform:   Lenovo laptop, AMD Ryzen APU (unrelated to this bug, just for
              context =E2=80=94 ruled out as a factor)

Software:
  Kernel 7.1.3-200.fc44.x86_64 (Fedora 44), linux-firmware-20260622-1.fc44

Symptom: intermittent Wi-Fi disconnects/reauth together with Bluetooth A2DP
audio transport failures, both traced to the same physical combo chip.

dmesg (Wi-Fi side), recurring several times/day in short clusters:

  rtw89_8852ce 0000:02:00.0: [RX_DCK] S1 RXDCK timeout
  rtw89_8852ce 0000:02:00.0: timed out to flush queues

journalctl (Bluetooth side), same time frame, device 85:42:36:51:B1:D1
(Bluetooth headphones, A2DP sink):

  wireplumber: spa.bluez5.sink.media: Misscket
    (0 suppressed): Bluetooth adapter firm
  bluetoothd: src/profile.c:ext_io_disconn for
    Hands-Free Voice gateway: getpeername:
    connected (107)
  wireplumber: spa.bluez5: Failure in Bluetooth audio transport
    /org/bluez/hci0/dev_85_42_36_51_B1_D1/

Direct correlation captured with mtr: a WireGuard-tunneled ping test
(ultimately routed over wlp2s0) showed 5.9 the
same ~60s window as 8 consecutive "Missingines
for the same device (00:12:51) and an HFP 1).
Both radios degraded together, which pointmware
fault rather than two unrelated bugs.

Workarounds tried, partial effect only:
  - USB autosuspend disabled for the BT ad
  - rtw89_core.disable_ps_mode=3D1, rtw89_pc
  - A2DP codec forced to SBC instead of AA

Is this expected to be covered by the same fix path as RH#2349675, or is it
worth tracking separately since it reprodu?
Happy to test candidate firmware/patches o

Thanks,
Oleh



