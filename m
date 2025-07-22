Return-Path: <linux-wireless+bounces-25861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E27EB0DAD5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7627D7B135A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B92DFA46;
	Tue, 22 Jul 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klrcRBVb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3E1DFE0B
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190995; cv=none; b=cGuiVABEgBSXn8igPVoCQHmMMB+lHC9chZdU41BeYhXiGdVJRvk2ptwO7mVJltLwobBMzUTvZwlpXykfUqM2YwQQZgdvi3LYtYKgX1FQ1dNpmHTUKYdRXLoXEjYOXBxjWXcZbaYmf0nYf3owDEuCLvw5wagBaMQCJecUBvHCDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190995; c=relaxed/simple;
	bh=uyY460yuIUcqGCkrsqUyqABms3ymyiZnLJJvCCt3bnY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=KRojg+TeZ8fZkVY7xP5r1ss67SoJBD2/4QDvp/ZpEl55I8rq0xFsSF7USQtC76fRDU3Q/NpVW2JgV3FfT8fKauBWgdmebCFQzQHJrnnPv9pAl+/hYcdK9V6dzBbY/9Sl8O4tSSDzqK6lhbNjkFHnlG6xQM5A6VWkoAFqRnj/MPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klrcRBVb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso916349466b.1
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753190991; x=1753795791; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9L5eLWfpRVGDTkgGEXsNQBhY87X0Ks9hRpBU+RjKfPg=;
        b=klrcRBVbVj/Vwga+eVH/QXlt7KN5PGECKmc4Lqru+SS3TUtluQGj3Q52JyRasANmws
         BIyCKbaJXqSOQXxnd9b7oYVZQzkcH8q8kmXAEwdcWLDngd/uSwBerfvYczXeBBY+pKW6
         4oz/z7D2MLdxlVAQHq0iPIW5fIJxtMpNuUpusf2kBYLpeFSGlNGzxL+Y35K2Mih9i34X
         mEoeohQOrncI4H9JoQN50sx3LeBCDN/toYPQ3Qx0mfVmvuS2uox86RmG5/yIch+Q4DR/
         9j0qH5Ts66UIz7iNyAXUYtNL8oXP07Ne/4FKz0bdOdk+0hzEySlhhxlxNKz5UA61Bc9t
         JHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753190991; x=1753795791;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9L5eLWfpRVGDTkgGEXsNQBhY87X0Ks9hRpBU+RjKfPg=;
        b=Xl3yOVOOK8gc+t3g1neGMeKJkic4+ZcO5pDc28q8JTZxMgYybRS0aGtNm4mOrAeRVm
         nr3+x+9d+yDqWNMZ0DI6aaTutRlydjRDsh9ZzROyvomFDAKNFc504u5ehCbilqCnuOxQ
         m50iK8BxebSB5v+JQqqFxcA1fTJnv4nS00Mpf+wgse1tPopvgDF6Urme29Gb44PdhTvE
         73l9hpom+GJwpw2Nv4KT8Ixs8/nrZYl9IbiFAMvc4u0Mz/1fIMw+juJFeAjKkSnOet2T
         uD++en2hv0jwViK8CKS10VoVHlVa57yBY8Y7sUrH/r4SalmoQXwkSL7OCtyq+mk/BBVI
         2nGw==
X-Gm-Message-State: AOJu0YzM2OjuNJRkok+yNDJt8f2yrovDQETwIUykL5+u3sIdbbereLEm
	QE4jAITBbnAkcbqLiXAF0/di1Mgn/tnFjLgZ9+unHzFi0x2M6YgMiUH7FFR35A==
X-Gm-Gg: ASbGnct1q4zrcXe2qGLlmqYVOC5Riv6dvN7Hk2VnXMpzHRNmHT4o+KvZks2dGDK4+tO
	r7Xk8iml3FpDwmBu4rsQ5cQaVYUvEoYuLsqvqiv5qQ8S9OS/PUSk12N45KyCwL5o6WJeaOVMd49
	Y5+x5iUgAApUhzHUPfYtA2VE+HTz+Fq1TVpJo7eoAinugBC4Z5Y8M3Lyjul1k1X5ctcu+rWEqO1
	rvswnNMe6Scv2HKIA+QmfDE80+vJBFKpExTZrisjlNgxh+7G9+pKJWKw/tRlnvm5iAZSYtWiDqA
	+LCMA4FTbrRYozsTdqJZnIoH6So4H/V7JC/IQ+5+pfjUPGSx2qrGTZkxr0eyXBcVrdx6lnvc9Cq
	qUrGY7PVpNL73lLFLva+TnMOZbJZA9ZuObYPbPGIFuGlgT8c4a4A0oiroh9hcL5D+/8XqZGirpm
	F5
X-Google-Smtp-Source: AGHT+IG6mByNAMv+sSN4YPOu8NBVlwO3lk/3SoWRcRY+/eAEnTwvFFQZwCV0fLYWG5QyxNtj+IPhhg==
X-Received: by 2002:a17:907:2d0b:b0:ae1:f1e3:ccea with SMTP id a640c23a62f3a-ae9cdda2b2emr2512285466b.7.1753190991064;
        Tue, 22 Jul 2025 06:29:51 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.play.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79a067sm866647766b.1.2025.07.22.06.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:29:50 -0700 (PDT)
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf path' 
Message-Id: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
Date: Tue, 22 Jul 2025 15:29:39 +0200
Cc: pkshih@realtek.com,
 rtl8821cerfe2@gmail.com,
 martin.blumenstingl@googlemail.com
To: linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Guys,

I=E2=80=99m bringing rk3576 sbc (nanopi-r76s) to mainline linux.

All works well except 8822cs wifi (m2 key module; sdio intf)

my user spacce is iwd 3.9.
linux-fw is current master.
6.16-rc7 without any rtw88 related patches.

8822cs is recognised by kernel but works ok only in 1 per 10 or so =
boots.
In other 9 non-working cases i=E2=80=99m getting:

1. no any networks are discovered
2. dmesg is stormed with

[  106.684159] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.684667] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.685169] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.716150] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.718596] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.721630] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.722132] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.722632] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.723132] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.723683] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  106.730767] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
[  109.357579] rtw88_8822cs mmc1:0001:1: unsupported rf path (1)

(full dmesg: https://termbin.com/i1db )

3. comparing debug output of iwd for working and non working states i =
see:

non-working=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94:

Wiphy: 0, Name: phy0
        Permanent Address: 70:68:71:a2:a8:0d
        2.4GHz Band:
                Bitrates (non-HT):
                         1.0 Mbps
                         2.0 Mbps
                         5.5 Mbps
                        11.0 Mbps
                         6.0 Mbps
                         9.0 Mbps
                        12.0 Mbps
                        18.0 Mbps
                        24.0 Mbps
                        36.0 Mbps
                        48.0 Mbps
                        54.0 Mbps
                HT Capabilities:
                        HT40
                        Short GI for 20Mhz
                        Short GI for 40Mhz
                HT RX MCS indexes:
                        0-7
                        32
        5GHz Band:
                Bitrates (non-HT):
                         6.0 Mbps
                         9.0 Mbps
                        12.0 Mbps
                        18.0 Mbps
                        24.0 Mbps
                        36.0 Mbps
                        48.0 Mbps
                        54.0 Mbps
                HT Capabilities:
                        HT40
                        Short GI for 20Mhz
                        Short GI for 40Mhz
                HT RX MCS indexes:
                        0-7
                        32
                VHT Capabilities:
                        Short GI for 80Mhz
                        Max RX MCS: 0-9 for NSS: 1
                        Max TX MCS: 0-9 for NSS: 1
        Ciphers: BIP-CMAC-256 BIP-GMAC-256 BIP-GMAC-128 CCMP-256
                 GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
                 TKIP
        Supported iftypes: station


working--------------------------:

Wiphy: 0, Name: phy0
        Permanent Address: 70:68:71:a2:a8:0d
        2.4GHz Band:
                Bitrates (non-HT):
                         1.0 Mbps
                         2.0 Mbps
                         5.5 Mbps
                        11.0 Mbps
                         6.0 Mbps
                         9.0 Mbps
                        12.0 Mbps
                        18.0 Mbps
                        24.0 Mbps
                        36.0 Mbps
                        48.0 Mbps
                        54.0 Mbps
                HT Capabilities:
                        HT40
                        Short GI for 20Mhz
                        Short GI for 40Mhz
                HT RX MCS indexes:
                        0-15
                        32
        5GHz Band:
                Bitrates (non-HT):
                         6.0 Mbps
                         9.0 Mbps
                        12.0 Mbps
                        18.0 Mbps
                        24.0 Mbps
                        36.0 Mbps
                        48.0 Mbps
                        54.0 Mbps
                HT Capabilities:
                        HT40
                        Short GI for 20Mhz
                        Short GI for 40Mhz
                HT RX MCS indexes:
                        0-15
                        32
                VHT Capabilities:
                        Short GI for 80Mhz
                        Max RX MCS: 0-9 for NSS: 2
                        Max TX MCS: 0-9 for NSS: 2
        Ciphers: BIP-CMAC-256 BIP-GMAC-256 BIP-GMAC-128 CCMP-256
                 GCMP-256 GCMP-128 BIP-CMAC-128 CCMP-128
                 TKIP
        Supported iftypes: station


As you see main diff is in HT RX MCS indexes and VHT caps.=20

Working: HT RX MCS indexes: 0-15
Non-working: HT RX MCS indexes: 0-7

Isn=E2=80=99t that 8-15 are for 2x2mimo?=20
So maybe - by some reason - hw sometimes reports support for only 1x =
mimo but receives from air 2x mimo (2 streams) and thats why I see hell =
of "unsupported rf path"  errors from driver?  =20

My kernel is compiled with  CONFIG_RTW88_DEBUG=3Dy =
CONFIG_RTW88_DEBUGFS=3Dy - so if there is need for any extra debug info =
- i=E2=80=99ll be more than happy to provide=E2=80=A6.

If you have any ideas how to move forward with this - i=E2=80=99ll be =
more than happy to listen.
 =20


