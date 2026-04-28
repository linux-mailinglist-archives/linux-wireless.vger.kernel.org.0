Return-Path: <linux-wireless+bounces-35502-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGycI+nX8GkLaQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35502-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 17:53:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2B488478
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 17:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65B2630C479E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996A1410D02;
	Tue, 28 Apr 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxM7K8bj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75143C07D
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386547; cv=pass; b=JqGRbV7ngrh6zxHutAEvAsILFGNPzYZDlfJafnUdnnnSYNABG3iyl7260OFkHlVp/BRFW2xCD3cnhyztjPRT+3xaxrMipiwYHpaKyG1bto57uy1AZusjVRwhdPA5FmQvtY19QTV0vVgWcHrQ2lcpS0c/IKQZhNieNvNA7Md6LXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386547; c=relaxed/simple;
	bh=1IokHuQGzwnJNd6L/gsJWyQg4KcmG22MANGwB/jX7b0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=p3nBdjwGCV3OLVam3rv/zW5OtoIV1LG9sKiC2M2YaEF2R/Je1pkdoRwWpr+7+dDcVXFunF93Umj0lVic4CZmzqeQeAhxiiuHgy9e8IGwhYZ3y+UntyxVvEPbciRSuygM3WfkXVlfUVgE6mpOVfP11bqBMgg9aWzFSjAwrkfjarA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxM7K8bj; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479ef2b7979so5367310b6e.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:29:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386540; cv=none;
        d=google.com; s=arc-20240605;
        b=I9HS/iir/9kTtOcbw8tgCHvDI/6TMCiIX9GMgiCxDHVoRg4xvd5MtHaqb9BMSGsvf9
         PDgN83/2xCo+y4ryv9Jbx+fg/KHEeLGUunwuox/svgG/KvUWWZ7c3X4zR7Dd4mv9nJuT
         6AhKkAbRzEkUtXTpmHH3wLQ7ad7FtmiFwtXN4Yjhc454Mo0L1C4lxXjW/j9LJ4OPf+eb
         PxN/Gc44j/c2u9ka8s5A41fRfyFWbgNIec3NdtLk7tVvI4ZUYvmYH/5IxSJpLR1pSQpP
         RQ8mWcr4LntjVQU8xe9Rx/ogSzP32hea8B2Qt8ZF6aSF87stcNTmRhBIkr5eDji6ZrB0
         vLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GI1ISceRm3JTWJBds0vnqhvTttrC15nIKzYUYxEJH/A=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=LqDoDfP9gUB+yDOf3VM5QjgnxVp9yUGqQq1C1Te67KhrpSAdRbZwFeWp6sOdf7QDx9
         wiba7WzAzpww3Wmes4RNxP5qLvSVoQ6v5MfMwvZejwd1ft3b2q4PSM0DPSF3p5EqD5Mk
         +6mwkvP0H5kvz6hV/v1R3OL6A8n6XlPt5DxxeHZVX7a7Jm/1VUzzIe5NIa8sCEIw/0me
         SM4beiYjQr/h3v5kaWX9LdZZ2hAG46hp05tAT8+B+UZXv3Zn117NVrJSMpx8ydvaqWKr
         uP9phYfQVSbskdK+aPrfla9eBKXyW32JQRacTAee2jKQTA0IVJQVKKUcevdXzhvoewpt
         AMTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777386540; x=1777991340; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GI1ISceRm3JTWJBds0vnqhvTttrC15nIKzYUYxEJH/A=;
        b=lxM7K8bjFv1DFPisSk9xLtB2HQqDqJUHg8C4dJvUJs+pqhatlE3n2cPip0K7OgAYRb
         koyTN2b7PNABchR1Cwd7TSxqo4bqNTGP2ESfWC5TRC9sjzf5lcWKK9nx6X02iqzRb0di
         bE67v2Aemd8mkqUuhIqkpPohkt4KpWeN8zxi2VqACWnT/O2/SuUjQPz4wx2mVqesXZEg
         oXN/6BBxUdlrFx0W8JFELgSEgAED8S+P5ZMmSPs+g+riv3eo/C1yosq0uao/RAwuKYrI
         J6nOlw/vqp/WqtQHykGJhDt6e4RHbdqUPkuOjJ3RQzPNDGBm6CEqLh5AvB6DWYTehxae
         Izpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386540; x=1777991340;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GI1ISceRm3JTWJBds0vnqhvTttrC15nIKzYUYxEJH/A=;
        b=k9wXwxl3f99p2Ef5jn7itq9LXTsXvEAu3MCtE+jPvAtzRo4xhZfCv81MtRgXU5pWms
         eja6Cz/McJ+WODSkWG5dFlWd+vFPPz6AA95sPIDNWc1lzFk8RmUeHcajlBcccgx9IsW6
         m50byQ8vJbA33Nq9nJ4b0KzKDGGXEMYwDGC+2GDD/HeySSOVrPbcB2g3PqYduJQq53Ih
         5qtSS0KYAJxf1oUFyJc9HlU+SpkchJAdc5XiLxrq3erNyUbT/XHSvZcCYeVNf/r05vF0
         QqLSQQOShpoSRfvo9LScY1XzpJ7sjth4UIejLVrtexfcvZY5ZfJWgOknBJo9a7t9qa/+
         WzVA==
X-Gm-Message-State: AOJu0Yw1NTvjA4acTHTEniU8ZFHT5k0yXFys6r0H5ZguZOttEfB8FE/+
	821YKPmQ0jCdRKnPuGLLbDUnQzXg8Hvd5f+Q3r41gIqoGyzdgwG0NDn0iOgLN11j9xGwkuYEp2M
	2KScLH9Dag9yNoLACFoQOkwPEFqlVWoZv1mJh
X-Gm-Gg: AeBDieuUoBE1P3HPqB2m9s7iBDUkFYgka94Ye8tvXGcuV8bZsoXemQILf6Uaw8RzfD/
	FSsGc33aP59SPqzuWbX+/ZBTONfkdu+b2zGvqpg0U83whIq2vjWIHLTpoXVj3N+LBw6YzmZ3OvU
	jDFSmD3PYP9SecIX8Rg7WoIjJFd5qUfAG12ouvsMzEDQS9yqAYE1U9kkoE/3hwNBurBhBSgDyAC
	OjpSXD68ao2BNo/2mXpX/syRHWXKfGvYktf+N37GM4B+ecuF694X5kCtuLZcA/zw5iDb4+7ougF
	OpfwvB7tRVj4cMKYo3BZOXKIR7ywWYphUTisRhz0CmNf7qyStg==
X-Received: by 2002:a05:6808:1929:b0:46a:ccae:5517 with SMTP id
 5614622812f47-47c28f9a01cmr1839391b6e.28.1777386540311; Tue, 28 Apr 2026
 07:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sivanantham Chinnaiyan <sivananth321@gmail.com>
Date: Tue, 28 Apr 2026 19:58:49 +0530
X-Gm-Features: AVHnY4IqxISUVwPK2Nbb_0b14q2gSbQDX5Y2n0H3JUi61Vhwzwe2vD8a2CDxMys
Message-ID: <CAEAGRPaA+Cw3wykVXpFHfs=qwQCv-=VuBpxisg6VjOPGaGfXDw@mail.gmail.com>
Subject: RTL8922AE: Severe latency spikes (>200ms) during wifi scan triggers
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 77A2B488478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-35502-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sivananth321@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Severe latency spikes (200ms+) occur whenever a Wi-Fi scan is
triggered (e.g., clicking Wi-Fi menu in GUI). This happens
consistently on both 2.4 GHz and 5 GHz networks, though it is much
more evident in 2.4GHz channel. I know that latency spikes during
scans are normal. But I am not sure if 150+ms is considered normal.

Hardware:
Chipset: Realtek rtw89_8922ae
Device: Lenovo Ideapad pro 5
Firmware version: [from dmesg | grep firmware] 0.35.80.3 (8ef4f0cf)
Kernel: fedora 6.19.13-200.fc43.x86_64

Software Stack:
Network Manager: NetworkManager (iwd backend)
Distribution: Fedora
Configuration: default

Steps to Reproduce:
1. Connect to a Wi-Fi network (2.4 GHz or 5 GHz)
2. Start continuous ping:
3. ```ping 8.8.8.8```
4.Open Wi-Fi menu in GUI (triggers scan)

Behavior:
Latency spikes to 200ms+ periodically
Happens every time a scan is triggered

Additional Observations:
Issue reproducible 100% of the time

Logs:
1. sudo dmesg | grep rtw

[    7.466016] rtw89_8922ae 0000:63:00.0: loaded firmware
rtw89/rtw8922a_fw-4.bin
[    7.466182] rtw89_8922ae 0000:63:00.0: enabling device (0000 -> 0003)
[    7.473628] rtw89_8922ae 0000:63:00.0: Firmware version 0.35.80.3
(8ef4f0cf), cmd version 1, type 1
[    7.473635] rtw89_8922ae 0000:63:00.0: Firmware version 0.35.80.3
(8ef4f0cf), cmd version 1, type 3
[    7.491846] rtw89_8922ae 0000:63:00.0: chip rfe_type is 1
[    7.494234] rtw89_8922ae 0000:63:00.0: Firmware version 0.1.0.0
(7b393818), cmd version 0, type 64
[    7.494239] rtw89_8922ae 0000:63:00.0: Firmware element BB version:
00 49 00 00
[    7.494244] rtw89_8922ae 0000:63:00.0: Firmware element radio A
version: 00 33 00 00
[    7.494252] rtw89_8922ae 0000:63:00.0: Firmware element NCTL
version: 00 0f 00 00
[    7.494296] rtw89_8922ae 0000:63:00.0: Firmware element TXPWR
version: 00 46 00 00
[    7.494297] rtw89_8922ae 0000:63:00.0: Firmware element TXPWR
version: 00 46 00 00
[    7.494297] rtw89_8922ae 0000:63:00.0: Firmware element TXPWR
version: 00 46 00 00
[    7.494307] rtw89_8922ae 0000:63:00.0: Firmware element PWR_TRK
version: 00 33 00 00
[    7.494313] rtw89_8922ae 0000:63:00.0: Firmware element REGD
version: 00 49 00 08
[    7.707799] rtw89_8922ae 0000:63:00.0: rfkill hardware state
changed to enable
[    7.717083] rtw89_8922ae 0000:63:00.0 wlp99s0: renamed from wlan0

2. ping -i 0.2 8.8.8.8 while connected to 2.4GHz( scan simulated using
`watch --interval=3 nmcli dev wifi rescan`)
)

64 bytes from 8.8.8.8: icmp_seq=24 ttl=118 time=34.9 ms
64 bytes from 8.8.8.8: icmp_seq=25 ttl=118 time=44.2 ms
64 bytes from 8.8.8.8: icmp_seq=26 ttl=118 time=6.61 ms
64 bytes from 8.8.8.8: icmp_seq=27 ttl=118 time=4.51 ms
64 bytes from 8.8.8.8: icmp_seq=28 ttl=118 time=92.3 ms
64 bytes from 8.8.8.8: icmp_seq=29 ttl=118 time=82.8 ms
64 bytes from 8.8.8.8: icmp_seq=30 ttl=118 time=20.4 ms
64 bytes from 8.8.8.8: icmp_seq=31 ttl=118 time=306 ms
64 bytes from 8.8.8.8: icmp_seq=32 ttl=118 time=102 ms
64 bytes from 8.8.8.8: icmp_seq=33 ttl=118 time=59.3 ms
64 bytes from 8.8.8.8: icmp_seq=34 ttl=118 time=183 ms
64 bytes from 8.8.8.8: icmp_seq=35 ttl=118 time=10.5 ms
64 bytes from 8.8.8.8: icmp_seq=36 ttl=118 time=116 ms
64 bytes from 8.8.8.8: icmp_seq=38 ttl=118 time=112 ms
64 bytes from 8.8.8.8: icmp_seq=39 ttl=118 time=108 ms
64 bytes from 8.8.8.8: icmp_seq=40 ttl=118 time=231 ms
64 bytes from 8.8.8.8: icmp_seq=41 ttl=118 time=24.0 ms
64 bytes from 8.8.8.8: icmp_seq=42 ttl=118 time=28.2 ms
64 bytes from 8.8.8.8: icmp_seq=43 ttl=118 time=32.0 ms
64 bytes from 8.8.8.8: icmp_seq=44 ttl=118 time=140 ms
64 bytes from 8.8.8.8: icmp_seq=45 ttl=118 time=146 ms
64 bytes from 8.8.8.8: icmp_seq=46 ttl=118 time=47.6 ms
64 bytes from 8.8.8.8: icmp_seq=47 ttl=118 time=52.0 ms
64 bytes from 8.8.8.8: icmp_seq=48 ttl=118 time=57.1 ms
64 bytes from 8.8.8.8: icmp_seq=49 ttl=118 time=60.9 ms
64 bytes from 8.8.8.8: icmp_seq=50 ttl=118 time=67.0 ms
64 bytes from 8.8.8.8: icmp_seq=51 ttl=118 time=3.90 ms
64 bytes from 8.8.8.8: icmp_seq=52 ttl=118 time=20.3 ms
64 bytes from 8.8.8.8: icmp_seq=53 ttl=118 time=4.81 ms
64 bytes from 8.8.8.8: icmp_seq=54 ttl=118 time=87.0 ms
64 bytes from 8.8.8.8: icmp_seq=55 ttl=118 time=92.9 ms
64 bytes from 8.8.8.8: icmp_seq=56 ttl=118 time=200 ms
64 bytes from 8.8.8.8: icmp_seq=57 ttl=118 time=4.52 ms
64 bytes from 8.8.8.8: icmp_seq=58 ttl=118 time=5.47 ms
64 bytes from 8.8.8.8: icmp_seq=59 ttl=118 time=98.4 ms
64 bytes from 8.8.8.8: icmp_seq=61 ttl=118 time=120 ms
64 bytes from 8.8.8.8: icmp_seq=62 ttl=118 time=133 ms
64 bytes from 8.8.8.8: icmp_seq=63 ttl=118 time=128 ms
64 bytes from 8.8.8.8: icmp_seq=64 ttl=118 time=235 ms
64 bytes from 8.8.8.8: icmp_seq=65 ttl=118 time=30.6 ms
64 bytes from 8.8.8.8: icmp_seq=66 ttl=118 time=139 ms
64 bytes from 8.8.8.8: icmp_seq=67 ttl=118 time=245 ms
64 bytes from 8.8.8.8: icmp_seq=68 ttl=118 time=41.3 ms
64 bytes from 8.8.8.8: icmp_seq=69 ttl=118 time=138 ms
64 bytes from 8.8.8.8: icmp_seq=70 ttl=118 time=253 ms
64 bytes from 8.8.8.8: icmp_seq=71 ttl=118 time=47.8 ms
64 bytes from 8.8.8.8: icmp_seq=72 ttl=118 time=51.9 ms
64 bytes from 8.8.8.8: icmp_seq=73 ttl=118 time=56.8 ms
64 bytes from 8.8.8.8: icmp_seq=74 ttl=118 time=62.3 ms
64 bytes from 8.8.8.8: icmp_seq=75 ttl=118 time=67.8 ms
64 bytes from 8.8.8.8: icmp_seq=76 ttl=118 time=206 ms
64 bytes from 8.8.8.8: icmp_seq=77 ttl=118 time=4.67 ms
64 bytes from 8.8.8.8: icmp_seq=78 ttl=118 time=148 ms
64 bytes from 8.8.8.8: icmp_seq=79 ttl=118 time=207 ms
64 bytes from 8.8.8.8: icmp_seq=80 ttl=118 time=3.99 ms
64 bytes from 8.8.8.8: icmp_seq=81 ttl=118 time=4.59 ms
64 bytes from 8.8.8.8: icmp_seq=82 ttl=118 time=38.8 ms
64 bytes from 8.8.8.8: icmp_seq=83 ttl=118 time=4.59 ms
64 bytes from 8.8.8.8: icmp_seq=84 ttl=118 time=82.3 ms
64 bytes from 8.8.8.8: icmp_seq=85 ttl=118 time=105 ms
64 bytes from 8.8.8.8: icmp_seq=86 ttl=118 time=54.2 ms
64 bytes from 8.8.8.8: icmp_seq=87 ttl=118 time=15.2 ms
64 bytes from 8.8.8.8: icmp_seq=88 ttl=118 time=4.62 ms
64 bytes from 8.8.8.8: icmp_seq=89 ttl=118 time=104 ms
64 bytes from 8.8.8.8: icmp_seq=90 ttl=118 time=69.6 ms
64 bytes from 8.8.8.8: icmp_seq=91 ttl=118 time=28.3 ms
64 bytes from 8.8.8.8: icmp_seq=92 ttl=118 time=6.45 ms
64 bytes from 8.8.8.8: icmp_seq=93 ttl=118 time=113 ms
64 bytes from 8.8.8.8: icmp_seq=94 ttl=118 time=77.2 ms
64 bytes from 8.8.8.8: icmp_seq=95 ttl=118 time=38.4 ms
64 bytes from 8.8.8.8: icmp_seq=96 ttl=118 time=6.64 ms
64 bytes from 8.8.8.8: icmp_seq=97 ttl=118 time=120 ms
64 bytes from 8.8.8.8: icmp_seq=98 ttl=118 time=60.1 ms
64 bytes from 8.8.8.8: icmp_seq=99 ttl=118 time=155 ms
64 bytes from 8.8.8.8: icmp_seq=100 ttl=118 time=107 ms
64 bytes from 8.8.8.8: icmp_seq=101 ttl=118 time=56.9 ms
64 bytes from 8.8.8.8: icmp_seq=102 ttl=118 time=14.3 ms
64 bytes from 8.8.8.8: icmp_seq=103 ttl=118 time=5.59 ms
64 bytes from 8.8.8.8: icmp_seq=104 ttl=118 time=4.53 ms
64 bytes from 8.8.8.8: icmp_seq=105 ttl=118 time=117 ms
64 bytes from 8.8.8.8: icmp_seq=106 ttl=118 time=4.51 ms
64 bytes from 8.8.8.8: icmp_seq=107 ttl=118 time=4.54 ms
64 bytes from 8.8.8.8: icmp_seq=108 ttl=118 time=150 ms
64 bytes from 8.8.8.8: icmp_seq=109 ttl=118 time=5.36 ms
64 bytes from 8.8.8.8: icmp_seq=110 ttl=118 time=10.1 ms
64 bytes from 8.8.8.8: icmp_seq=111 ttl=118 time=32.2 ms
64 bytes from 8.8.8.8: icmp_seq=112 ttl=118 time=70.1 ms
64 bytes from 8.8.8.8: icmp_seq=113 ttl=118 time=23.4 ms
64 bytes from 8.8.8.8: icmp_seq=114 ttl=118 time=4.57 ms
64 bytes from 8.8.8.8: icmp_seq=115 ttl=118 time=122 ms
64 bytes from 8.8.8.8: icmp_seq=116 ttl=118 time=84.8 ms
64 bytes from 8.8.8.8: icmp_seq=117 ttl=118 time=45.8 ms
64 bytes from 8.8.8.8: icmp_seq=118 ttl=118 time=7.48 ms
64 bytes from 8.8.8.8: icmp_seq=119 ttl=118 time=4.42 ms
^C
--- 8.8.8.8 ping statistics ---
119 packets transmitted, 116 received, 2.52101% packet loss, time 23754ms
rtt min/avg/max/mdev = 3.624/70.204/305.533/64.207 ms, pipe 2

