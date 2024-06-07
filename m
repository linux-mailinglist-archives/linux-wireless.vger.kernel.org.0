Return-Path: <linux-wireless+bounces-8699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65975900840
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 17:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD38C1F2743C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3BC199EBC;
	Fri,  7 Jun 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKkkbWe7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9A19309E
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772745; cv=none; b=Tumj/Eumg+r2UQM3/xmo326IsYiOFSo4SqeMO02FFCQMwcdZ4tlmO2mpdTFAUusCy5zXSIrWbQKJ9fOXQ+dWyq2xU1kL2eg1Vlzub998kam4ICtm3ehomM7dJwMikK7hSq9Tn12uKcnvtDJ0D+L+s6P7Sncp2ZzrQeGfhw+iTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772745; c=relaxed/simple;
	bh=6+M1JH11Mb2efu4/ycH0lgxFUh3iMiVBfAnxsFlKlZw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uUE2ZhllLAMUE35g7FTyNxIamhWQB70D8sHRFZzAuLrqd9eb/f7lJNm+ac1je2NHCR0sIA9rsf5p3Q/5xb1UbjNlALkSavq1hboDkZZQJDJtt6YG+slB2fdvFFoeb60s1YDFjuq/iBV07fDTR9P3j+JPKfMJgNj55PD7xDwIRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKkkbWe7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6819b3c92bbso1752710a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2024 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717772743; x=1718377543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ck0CLYD+cixkmL+avSg/TjXe6XEqBMMOdo5rsWZT9Co=;
        b=hKkkbWe7ul75MS8u99leIwxT1ux0rua0b/wPLYKr6omTH3qtn46UXgQiFOpprsdmqW
         isd/UrcUfLING9o/LIQ3DY6RWS9wl8E5xFnmYLvQv7rO6+ozq8zfaA4TSloWyWJ2bjuR
         YeLH1pGzkWeeUSpEmLtFbyfflkDlVUB7PY1LyBN/VOIqJzFea6Dcp0Rtr7FNib9m1rJx
         82AVQQJJfx7BUAxOvylYm5tcQMlWLVd6wkROAjP5GfIpGxrZovIjmpyYPWP+KxAcf6o0
         wN+rUjB7AMLaw20LbyHblvZ4PukFWdG/Px3bpLikzSzaDPmxnTn4k4EGuZMfZwLdZSHy
         z8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717772743; x=1718377543;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ck0CLYD+cixkmL+avSg/TjXe6XEqBMMOdo5rsWZT9Co=;
        b=O3PeQOXgxDZD2U6eKRH5RGhUL88rloc0Dg2WYRGMHZ0lgpFxWXrvFJjsEcMxEB5+LX
         UoBqKI+XK6oVRk8oF8dJAKWpzLZH6drA+7iSYV9sKlydkaxODbZ080dFJk9sLko+V16e
         3VVFXnIiGFjFRn8VnSjHCweSaxmmVNLd/HQNyDBTd7NgXCfDHZ5g+F8sMTDNrxsEOpqk
         L56FoqdISNXj3tcKl8k88ewIpK2liBB5tS59tdGpHCcIHLxn0KBycrx+LqB3W+RXpEpC
         84ojncV+GFPJD8t1Ps/cpWjMjEeB4YRTfERLNnoa3LCsGXxd+NoN9KXRSQ5FnF3kHmBR
         vnkA==
X-Gm-Message-State: AOJu0YzvFWC5cx0wZn6jzeb7ox/IzP+DZYKTjUyT79At+eYaZeku3NEx
	2Lg0MC/y2Ph6GQGggHE/sNLGiQeBHKP2T/pnJBWgSBK++p5ngxMyVdJ9odY8iJWUavFGMeqM0nD
	dt7cG7hMRiPSJYF1QR7VydBO5kpIgRZY/
X-Google-Smtp-Source: AGHT+IGHzEfhZIsEbBh0/Aqmx+k7XPi061VOBJfe93yB79qQjtRckdHk080fuYXoDljat7LTynoMxzJiqwWXtU75xm4=
X-Received: by 2002:a17:90a:5b14:b0:2bd:744a:1131 with SMTP id
 98e67ed59e1d1-2c2bcc65362mr2776149a91.30.1717772742601; Fri, 07 Jun 2024
 08:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Fri, 7 Jun 2024 17:05:32 +0200
Message-ID: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
Subject: rtw88 multicast failure in AP mode
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, 
	=?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Let's assume we have 3 systems: A and B use 8821CU chip, and C uses
another chip from a different vendor.

If A is in AP mode and A and B use the rtw88 driver, pinging A from B
and C by local name doesn't work because name resolution fails: avahi
on B and C sends a multicast request to resolve A.local, A sees it and
responds, but neither B nor C sees the response.

In the same situation, but with A and B using the rtl8821cu driver
(from https://github.com/morrownr/8821cu-20210916.git), everything
works - B and C see A's response and can resolve A.local.

If C is in AP mode, resolving C from A and B also works.

This leads me to believe there's something wrong with rtw88 when
sending multicast packets in AP mode.

When it works:
AP:
13:42:01.393649 IP 10.21.12.9.45190 > 10.21.12.1.53: 1519+ SOA? local. (23)
13:42:01.394137 IP 10.21.12.1.53 > 10.21.12.9.45190: 1519 Refused 0/0/0 (23)
13:42:01.395767 IP 10.21.12.9.49431 > 10.21.12.1.53: 1519+ SOA? local. (23)
13:42:01.395968 IP 10.21.12.1.53 > 10.21.12.9.49431: 1519 Refused 0/0/0 (23)
13:42:01.498904 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:42:01.499612 IP 10.21.12.1.5353 > 224.0.0.251.5353: 0*- [0q] 1/0/0
(Cache flush) A 10.21.12.1 (62)
13:42:01.502771 IP 10.21.12.9 > 10.21.12.1: ICMP echo request, id 597,
seq 0, length 64
13:42:01.502870 IP 10.21.12.1 > 10.21.12.9: ICMP echo reply, id 597,
seq 0, length 64
13:42:02.502636 IP 10.21.12.9 > 10.21.12.1: ICMP echo request, id 597,
seq 1, length 64
13:42:02.502832 IP 10.21.12.1 > 10.21.12.9: ICMP echo reply, id 597,
seq 1, length 64
13:42:03.503137 IP 10.21.12.9 > 10.21.12.1: ICMP echo request, id 597,
seq 2, length 64
13:42:03.503332 IP 10.21.12.1 > 10.21.12.9: ICMP echo reply, id 597,
seq 2, length 64

station:
13:41:55.542970 IP 10.21.12.9.45190 > 10.21.12.1.53: 1519+ SOA? local. (23)
13:41:55.545556 IP 10.21.12.1.53 > 10.21.12.9.45190: 1519 Refused 0/0/0 (23)
13:41:55.545888 IP 10.21.12.9.49431 > 10.21.12.1.53: 1519+ SOA? local. (23)
13:41:55.547212 IP 10.21.12.1.53 > 10.21.12.9.49431: 1519 Refused 0/0/0 (23)
13:41:55.648755 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:41:55.651057 IP 10.21.12.1.5353 > 224.0.0.251.5353: 0*- [0q] 1/0/0
(Cache flush) A 10.21.12.1 (62)
13:41:55.652154 IP 10.21.12.9 > 10.21.12.1: ICMP echo request, id 597,
seq 0, length 64
13:41:55.654220 IP 10.21.12.1 > 10.21.12.9: ICMP echo reply, id 597,
seq 0, length 64
13:41:56.652499 IP 10.21.12.9 > 10.21.12.1: ICMP echo request, id 597,
seq 1, length 64
13:41:56.654529 IP 10.21.12.1 > 10.21.12.9: ICMP echo reply, id 597,
seq 1, length 64
13:41:57.652892 IP 10.21.12.9 > 10.21.12.1: ICMP echo request, id 597,
seq 2, length 64
13:41:57.654789 IP 10.21.12.1 > 10.21.12.9: ICMP echo reply, id 597,
seq 2, length 64

when it doesn't:
AP:
13:47:00.331053 IP 10.21.12.9.53078 > 10.21.12.1.53: 43258+ SOA? local. (23)
13:47:00.331459 IP 10.21.12.1.53 > 10.21.12.9.53078: 43258 Refused 0/0/0 (23)
13:47:00.334759 IP 10.21.12.9.37501 > 10.21.12.1.53: 43258+ SOA? local. (23)
13:47:00.334955 IP 10.21.12.1.53 > 10.21.12.9.37501: 43258 Refused 0/0/0 (23)
13:47:00.438593 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:47:00.438923 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:47:00.441040 IP 10.21.12.1.5353 > 224.0.0.251.5353: 0*- [0q] 1/0/0
(Cache flush) A 10.21.12.1 (62)
13:47:01.443349 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:47:01.443771 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:47:01.445513 IP 10.21.12.1.5353 > 224.0.0.251.5353: 0*- [0q] 1/0/0
(Cache flush) A 10.21.12.1 (62)
13:47:03.441963 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:47:03.442094 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:47:03.442747 IP 10.21.12.1.5353 > 224.0.0.251.5353: 0*- [0q] 1/0/0
(Cache flush) A 10.21.12.1 (62)

station:
13:46:54.483807 IP 10.21.12.9.53078 > 10.21.12.1.53: 43258+ SOA? local. (23)
13:46:54.486122 IP 10.21.12.1.53 > 10.21.12.9.53078: 43258 Refused 0/0/0 (23)
13:46:54.487262 IP 10.21.12.9.37501 > 10.21.12.1.53: 43258+ SOA? local. (23)
13:46:54.489352 IP 10.21.12.1.53 > 10.21.12.9.37501: 43258 Refused 0/0/0 (23)
13:46:54.590785 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:46:55.593347 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)
13:46:57.594809 IP 10.21.12.9.5353 > 224.0.0.251.5353: 0 A (QM)? A.local. (52)

If all systems connect to an external AP, A and B use rtw88 or
rtl8821cu, pinging A from B and C by local name (hostname.local)
works, but this goes through normal DNS service, so it doesn't prove
anything. I did some experiments with iperf though.

If A and B are connected to an external AP this works:
A: iperf -s -B 224.0.0.55 -u
B: iperf -c 224.0.0.55 -u

B: iperf -s -B 224.0.0.55 -u
A: iperf -c 224.0.0.55 -u

if A is in AP mode and uses rtw88 OR rtl8821cu, iperf fails both in
server and client mode:
iperf -s -B 224.0.0.55 -u
multicast join failed: No such device
------------------------------------------------------------
Server listening on UDP port 5001
Binding to local address 224.0.0.55
Joining multicast group  224.0.0.55
Receiving 1470 byte datagrams
UDP buffer size:  176 KByte (default)
------------------------------------------------------------

iperf -c 224.0.0.55 -u
connect failed: Network is unreachable

If A is in AP mode and uses rtl8821cu, iperf between B (rtl8821cu) and
C works in both directions.
If A is in AP mode and uses rtw88, iperf between B (rtw88) and C
doesn't work (in both directions, no errors, just no traffic is
registered on the other side).

This indicates that there's something wrong with both sending and
receiving multicast packets in rtw88 in AP mode.

Please help me resolve this issue.

Cheers,
Marcin

