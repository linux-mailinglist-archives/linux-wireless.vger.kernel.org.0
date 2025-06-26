Return-Path: <linux-wireless+bounces-24575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A4BAEA8AE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDACE1642DF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF0B25F78D;
	Thu, 26 Jun 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnoLEaqX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2125CC61
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972828; cv=none; b=SL6FhJ046Bxw5dmTUfbXzPlFGAGzwQHXnZnOrIuzIKxVWnF7TpSv9K9EHyTehQmBE+UyzD+2B68IzvPxJjMpSvFnBAnijWwC2pVzIpsYFA0hfC4+Q6l9Guyr/PB7+aMWvFiH+KHDn2hcXX5NklD9hZ2wpCNQdMB5SQwl9b8+CNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972828; c=relaxed/simple;
	bh=JTOIdshMZ9ovk0BdJQDlSsRK7feuxYzR0wYrSOkUGHQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ov5TO+YH42OYGc/3SxjNPHGjaH/1Y2BrHAax+BiKZl0fbST/eD31WZ1M0mT4fZhbhQrFGwePR6xv6nXLDdWdEhfabycmPGEqX/upwD9rkSYllWxg1T4gIeFugLtXfU/A6tt6tEgVEuwafnd/frwcmJhdRnli3OBONydpAEUatR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnoLEaqX; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e7f367ea11so417396137.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750972825; x=1751577625; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XewSEcR6+ANivF2cJwWlcQVA6N8wdn+qNOsUlFP36gg=;
        b=EnoLEaqXcdQd9J5746gEe9QGkctPXSLc73MUakMHL3vS2I0NrYjcRK7iu2wKmwkRLD
         JxFRgBPrS5odlGDf3KWQBp3I4MwAN5S2ghoCIhZs1i1E7fasMhtvAuAw6H7eqKVzIXD0
         WTkHQ6KrJZoD6bzdrHx9st0+cx3Zs/utKXguK6f/PfzfXjDnoB+g5Fo0XuTb0YGwaZ2K
         oMIhLVRt2RLlEM8e99KHLsa9ctj+56vR/vTNrq5RshyX9H9mQ5N1CWo/uOnh26ueKdAi
         v6UsSShVwVLOuV+gWf+ZtM0na4COeOt1/ToDNxeboflY/b5+cis8tXsQUFAJzv3zbR28
         9T7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750972825; x=1751577625;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XewSEcR6+ANivF2cJwWlcQVA6N8wdn+qNOsUlFP36gg=;
        b=bv+UYbXs1O82zmLktEsgCiZR+6hrH+dadF4moOO7TomFrO0A+0ohJCvrhUbGb0yUfC
         ZH49rB41rVYYHFQeLWrohk7IAyqZncUQW6J0LMZPM6O/6O3QgtLb7JSF0SAjDY5cZOpd
         FH/t6nfUt+8zHilj7Irkgb7iwU0hFInjJxnjYtEsCyV+a5klZ+vxjF2jeMyC0G0jJhjy
         AQHlBaBcLC57kAOfDCEVXg/hHlr48+SetodtOrKD6ivooxW2opjdvVBY7DNx+tPtx4Q+
         N2/tfGmEwkYYTC9o0aB4gQjScNUG4YhKgLvIl3WNVkCYvbMWXoh2XKslhkUiSS2E8GTn
         zVuQ==
X-Gm-Message-State: AOJu0YwxLmTQcXn9HH88N9TUFnAX+PWW0hY2xK85JB48kn1O5avKhfb0
	hZKly+Ra/Y0jftNNhhczC/D6qLBQgZ8rSWoAbpsYSaIBrSe31/X9zHBIYUjmfl3NAYCtggVzaja
	u6/NquKH7y2UUf0DkZzd3HGDZSzgc5ZqdbET4D+kpCg==
X-Gm-Gg: ASbGncsH09cZFo7IlIxeuecoOdO9pUN8Ns3nEpRoCTox6og6CaBTxRBxU+zCtuMIDI/
	TNww0cCfewBnojzqrXQqsUN4xbTVdGhaNSwy4uY0WYhW/V3ia7nvXfg2gfu1740ONpXkjPn/YSj
	QBh41WiMuqN18QpS8XeB9/V68h15pBh257B2Uex+oKfno=
X-Google-Smtp-Source: AGHT+IElLBjSLsjU7IysTu8GC9TQGqFDTfi6pvd/5eNXBrIpxOn1reybuPzPMnj/c7OyG7K6wwGIv1OGulwFBeWn7sI=
X-Received: by 2002:a05:6102:688c:b0:4e7:7787:1c2a with SMTP id
 ada2fe7eead31-4ee4f832c0amr1182572137.23.1750972825118; Thu, 26 Jun 2025
 14:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Thu, 26 Jun 2025 23:20:13 +0200
X-Gm-Features: Ac12FXxjLVbKnCBOu59nSrvcyo5X6Ap8obwHiCdrivrkacap9zrDwYj1RE0Pn3U
Message-ID: <CAA85sZsTtL_Amydo+N6O5OY9U7U1ZKyQAOnqBQx7kAOwY7amZQ@mail.gmail.com>
Subject: mt7925 performance issues?
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I just got a new laptop with
c0:00.0 Network controller: MEDIATEK Corp. MT7925 (RZ717) Wi-Fi 7 160MHz

I have read that there is a lot of theories, and ideas about what
could be going wrong in the driver...

I did some tests, wifi5 is a google wifi next ap, which seems to work
fine for this card.

Wifi 7 is a unifi wifi7 ap -. max measured with other clients is 931
mbit - with the same measuring server but with a iwlwifi
card reporting a txpower of 22dbm

Also interesting that i get 0 at times with wifi 7 and especially with MLO
this is testing with 6.16 HEAD e34a79b96ab9d49ed8b605fee11099cf3efbb428

Any benchmarks/tests i can do to help fix this?
----
Wifi 5

        channel 36 (5180 MHz), width: 80 MHz, center1: 5210 MHz
        txpower 3.00 dBm
        multicast TXQ:
                qsz-byt qsz-pkt flows   drops   marks   overlmt
hashcol tx-bytes        tx-packets
                0       0       0       0       0       0       0
 0               0


[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  59.8 MBytes   501 Mbits/sec    2    724 KBytes
[  5]   1.00-2.00   sec  32.0 MBytes   268 Mbits/sec    0    863 KBytes
[  5]   2.00-3.00   sec  42.8 MBytes   359 Mbits/sec    0   1.11 MBytes
[  5]   3.00-4.00   sec  10.6 MBytes  89.1 Mbits/sec    0   1.17 MBytes
[  5]   4.00-5.00   sec  21.1 MBytes   177 Mbits/sec    0   1.22 MBytes
[  5]   5.00-6.00   sec  21.4 MBytes   179 Mbits/sec    1   1.24 MBytes
[  5]   6.00-7.00   sec  21.5 MBytes   180 Mbits/sec    0   1012 KBytes
[  5]   7.00-8.00   sec  21.4 MBytes   179 Mbits/sec    0   1004 KBytes
[  5]   8.00-9.00   sec  43.4 MBytes   364 Mbits/sec    0    897 KBytes
[  5]   9.00-10.00  sec  32.6 MBytes   274 Mbits/sec    2    993 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   306 MBytes   257 Mbits/sec    5            sender
[  5]   0.00-10.00  sec   284 MBytes   238 Mbits/sec                  receiver
---

Wifi 7

        type managed
        wiphy 0
        multicast TXQ:
                qsz-byt qsz-pkt flows   drops   marks   overlmt
hashcol tx-bytes        tx-packets
                0       0       0       0       0       0       0
 0               0
        MLD with links:
         - link ID  0 link addr ce:67:53:b2:b1:9d
           channel 6 (2437 MHz), width: 40 MHz, center1: 2447 MHz
         - link ID  1 link addr c2:e3:9b:67:2b:67
         - link ID  2 link addr 1e:5a:37:e5:97:b2
           channel 37 (6135 MHz), width: 160 MHz, center1: 6185 MHz

[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  5.50 MBytes  46.1 Mbits/sec    1    160 KBytes
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    0    136 KBytes
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0    137 KBytes
[  5]   3.00-4.00   sec  2.00 MBytes  16.8 Mbits/sec    0    110 KBytes
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0    178 KBytes
[  5]   5.00-6.00   sec  2.25 MBytes  18.9 Mbits/sec    0   82.0 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   73.5 KBytes
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   82.0 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   96.2 KBytes
[  5]   9.00-10.00  sec  2.12 MBytes  17.8 Mbits/sec    0    184 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  11.9 MBytes  9.96 Mbits/sec    1            sender
[  5]   0.00-10.02  sec  5.50 MBytes  4.60 Mbits/sec                  receiver
----

        type managed
        wiphy 0
        channel 37 (6135 MHz), width: 160 MHz, center1: 6185 MHz
        txpower 3.00 dBm
        multicast TXQ:
                qsz-byt qsz-pkt flows   drops   marks   overlmt
hashcol tx-bytes        tx-packets
                0       0       0       0       0       0       0
 0               0

[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  25.6 MBytes   215 Mbits/sec    0    461 KBytes
[  5]   1.00-2.00   sec  13.4 MBytes   112 Mbits/sec    0    413 KBytes
[  5]   2.00-3.00   sec  26.6 MBytes   223 Mbits/sec    0    390 KBytes
[  5]   3.00-4.00   sec  13.4 MBytes   112 Mbits/sec    0    413 KBytes
[  5]   4.00-5.00   sec  20.0 MBytes   168 Mbits/sec    0    515 KBytes
[  5]   5.00-6.00   sec  20.1 MBytes   169 Mbits/sec    0    390 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    1    444 KBytes
[  5]   7.00-8.00   sec  13.4 MBytes   112 Mbits/sec    1    348 KBytes
[  5]   8.00-9.00   sec  20.2 MBytes   170 Mbits/sec    0    379 KBytes
[  5]   9.00-10.00  sec  20.6 MBytes   173 Mbits/sec    0    373 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   173 MBytes   145 Mbits/sec    2            sender
[  5]   0.00-10.01  sec   160 MBytes   134 Mbits/sec                  receiver
----

