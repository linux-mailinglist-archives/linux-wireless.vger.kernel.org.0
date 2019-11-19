Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF92101980
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 07:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKSGoG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 01:44:06 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35750 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKSGoF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 01:44:05 -0500
Received: by mail-ot1-f41.google.com with SMTP id c14so9933429oth.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 22:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eXiOz/hR6vJ7DErxaSj5RGKiNNDX6SRE8Cmx9yoZqyw=;
        b=NX6bBSTmlS2uKrJOJJk+SoLH6qAdtW6Yuee2TGV45GYYWqpFA+U6O3O9kfg5C7SZ6r
         2nHnEjx72XZWSirZ9YBVtAxjBL9eFBzCffmUvJmVC92zQanB9fs0Ek9a0WvZYDi6tnXk
         kqFZ8fuczYTR80vuyib/kpIcDSvzsBL8eh7hpirP8gBWOL0D8l/PfFqz+0yZR0iVLgb8
         YiLpGpiOzDG8dMMKmRE5HeniCjKDM8xtYJrMBO7DFck1IcAGUoiR//MtaK7ykcc8jOMs
         DL6JEfiV3AAwjzjGIJyTh5AUxHzkZfIYtceVITEzSZHw9Pw1URGf5oUon/vB78PgrEHt
         +V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eXiOz/hR6vJ7DErxaSj5RGKiNNDX6SRE8Cmx9yoZqyw=;
        b=rr+5fAaaQqRcXShRacSiFJzuaWc8C2XH68iNj8cCXNbNya2JFGU59O94o98hUHjJKR
         F2+Be15UUg/KDv2BkJ8Avku8wBtA2eS3qUfXawFybwSa2QqbsvMXieO8TnaRhvA4DbzT
         DDHv880gRl3eA7OOARqnM6gSveCCqaqQ8EEUBjrzQACOeKgr/e1qGDzBztbve9g7NkIV
         D0EW4t98QrTP7qmrXbYJLmHqnMaduo25jyyYKIcxFa/ZvFaQQohBGGoM8heikYPHKWkj
         OMBMAbFcuHAvHQF+aubNQ2z3fNElGLtkgooVWTu+xLjwlM2kUYjslzt3ctntUqCxlKuh
         4RYg==
X-Gm-Message-State: APjAAAXEHiuDJR2y37MqlNLTxPJEUlcsXLfpGUlK0KkizMIlQyEcc/Oe
        CbccaQdPwlqag+WBw/fVvkLrywAIeIBoLYVvwIFsUnKK
X-Google-Smtp-Source: APXvYqxmnupopyMVYOvnarcRJj/x23YyGQ/vBKBDfzX5IxdmUr92hVOgZ0Inpk6cPGijMbJ/hefJNgFodHAHb2kwMzw=
X-Received: by 2002:a9d:2c25:: with SMTP id f34mr2366370otb.27.1574145840374;
 Mon, 18 Nov 2019 22:44:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:384:0:0:0:0:0 with HTTP; Mon, 18 Nov 2019 22:43:59 -0800 (PST)
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 19 Nov 2019 07:43:59 +0100
Message-ID: <CAKR_QVLabBXcsPfcCt8MdQXUrkgw5aNVAJD9XUke-G7XhsTwAA@mail.gmail.com>
Subject: [RFC] ath10k: possible RSSI recalibration bug?
To:     ath10k <ath10k@lists.infradead.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

Upon connecting to an AP I notice reception level drops by several dB
on my client machines running QCA9880 in STA mode within exactly 30
sec. period.

This has been reproduced with multiple devices, all QCA9880
On a long range link the difference is about 3-6dB, close to an AP the
difference is bigger, sometimes even up to 10dB
Doesn't that look like a firmware issue? I'm using
firmware-5.bin_10.2.4-1.0-00047
This happens only on 5GHz band, as I've seen no difference on 2.4

Debug log from a laptop:

[ 8632.623254] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8632.623270] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc1d600 len 178 ftype 00 stype 50
[ 8632.623278] ath10k_pci 0000:03:00.0: event mgmt rx freq 2432 band 0
snr -49, rate_idx 4
[ 8632.646846] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8632.646858] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc1de00 len 184 ftype 00 stype 80
[ 8632.646861] ath10k_pci 0000:03:00.0: event mgmt rx freq 2432 band 0
snr -49, rate_idx 0
[ 8632.749305] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8632.749331] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3600 len 184 ftype 00 stype 80
[ 8632.749338] ath10k_pci 0000:03:00.0: event mgmt rx freq 2442 band 0
snr -54, rate_idx 0
[ 8632.851672] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8632.851689] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa99f00 len 184 ftype 00 stype 80
[ 8632.851697] ath10k_pci 0000:03:00.0: event mgmt rx freq 2452 band 0
snr -80, rate_idx 0
[ 8633.179262] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8633.179295] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013901b600 len 225 ftype 00 stype 50
[ 8633.179303] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -50, rate_idx 0
[ 8633.181865] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8633.181879] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013901b800 len 231 ftype 00 stype 80
[ 8633.181883] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -50, rate_idx 0
[ 8634.616943] wlan0: authenticate with 18:e8:29:30:a7:7d
[ 8634.625472] wlan0: send auth to 18:e8:29:30:a7:7d (try 1/3)
[ 8634.628180] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8634.628188] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958900 len 30 ftype 00 stype b0
[ 8634.628192] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8634.628325] wlan0: authenticated
[ 8634.629789] wlan0: associate with 18:e8:29:30:a7:7d (try 1/3)
[ 8634.631724] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8634.631728] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958100 len 149 ftype 00 stype 10
[ 8634.631730] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8634.631910] wlan0: RX AssocResp from 18:e8:29:30:a7:7d (capab=0x11
status=0 aid=3)
[ 8634.634255] wlan0: associated
[ 8634.640638] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8634.640645] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958d00 len 27 ftype 00 stype d0
[ 8634.640648] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8634.718124] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8634.718138] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a15dc00 len 231 ftype 00 stype 80
[ 8634.718142] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8634.820415] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8634.820437] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339f6000 len 231 ftype 00 stype 80
[ 8634.820441] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8634.922710] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8634.922726] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a135b00 len 231 ftype 00 stype 80
[ 8634.922728] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8635.025154] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.025174] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c65200 len 231 ftype 00 stype 80
[ 8635.025181] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8635.127486] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.127495] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e580d00 len 231 ftype 00 stype 80
[ 8635.127497] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8635.229993] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.230014] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133993a00 len 231 ftype 00 stype 80
[ 8635.230016] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8635.332454] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.332468] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af99b600 len 231 ftype 00 stype 80
[ 8635.332471] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8635.434743] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.434752] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb4f00 len 231 ftype 00 stype 80
[ 8635.434754] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8635.537234] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.537253] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880139789400 len 231 ftype 00 stype 80
[ 8635.537257] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8635.639600] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.639612] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133992d00 len 231 ftype 00 stype 80
[ 8635.639616] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8635.742025] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.742033] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013afdbf00 len 231 ftype 00 stype 80
[ 8635.742035] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8635.844438] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.844447] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a13f300 len 231 ftype 00 stype 80
[ 8635.844449] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8635.946748] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8635.946760] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339e7b00 len 231 ftype 00 stype 80
[ 8635.946764] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8636.049203] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.049212] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801369a6100 len 231 ftype 00 stype 80
[ 8636.049214] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8636.151611] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.151622] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af99be00 len 231 ftype 00 stype 80
[ 8636.151626] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8636.254031] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.254042] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801392c8200 len 231 ftype 00 stype 80
[ 8636.254046] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8636.356446] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.356465] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013ad44c00 len 231 ftype 00 stype 80
[ 8636.356469] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8636.458904] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.458922] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e727c00 len 231 ftype 00 stype 80
[ 8636.458926] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8636.564447] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.564473] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013afdb300 len 231 ftype 00 stype 80
[ 8636.564480] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8636.663698] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.663724] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3f00 len 231 ftype 00 stype 80
[ 8636.663731] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8636.765980] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.766008] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a132f00 len 231 ftype 00 stype 80
[ 8636.766015] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8636.868530] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.868561] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801346cbd00 len 231 ftype 00 stype 80
[ 8636.868568] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8636.970818] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8636.970842] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc1ef00 len 231 ftype 00 stype 80
[ 8636.970849] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8637.073309] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.073330] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133bdb100 len 231 ftype 00 stype 80
[ 8637.073337] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8637.175676] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.175692] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5e60c00 len 231 ftype 00 stype 80
[ 8637.175696] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8637.278027] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.278042] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bed0900 len 231 ftype 00 stype 80
[ 8637.278046] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8637.380485] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.380509] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880139697a00 len 231 ftype 00 stype 80
[ 8637.380516] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8637.482874] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.482904] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880100ebad00 len 231 ftype 00 stype 80
[ 8637.482912] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8637.585230] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.585251] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e50bf00 len 231 ftype 00 stype 80
[ 8637.585258] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8637.687665] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.687687] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be4b00 len 231 ftype 00 stype 80
[ 8637.687693] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8637.790146] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.790178] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be4d00 len 231 ftype 00 stype 80
[ 8637.790185] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8637.892547] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.892579] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be4c00 len 231 ftype 00 stype 80
[ 8637.892587] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8637.994898] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8637.994925] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be4a00 len 231 ftype 00 stype 80
[ 8637.994933] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8638.097319] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.097342] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3d00 len 231 ftype 00 stype 80
[ 8638.097349] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8638.199701] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.199724] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3c00 len 231 ftype 00 stype 80
[ 8638.199730] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8638.302153] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.302171] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3a00 len 231 ftype 00 stype 80
[ 8638.302178] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8638.404470] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.404497] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3900 len 231 ftype 00 stype 80
[ 8638.404504] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8638.506848] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.506879] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3500 len 231 ftype 00 stype 80
[ 8638.506887] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8638.609318] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.609336] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3b00 len 231 ftype 00 stype 80
[ 8638.609344] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8638.711713] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.711742] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3800 len 231 ftype 00 stype 80
[ 8638.711749] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8638.814126] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.814144] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013952bc00 len 231 ftype 00 stype 80
[ 8638.814152] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8638.916501] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8638.916521] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013952b000 len 231 ftype 00 stype 80
[ 8638.916529] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8639.018912] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.018938] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b300 len 231 ftype 00 stype 80
[ 8639.018945] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8639.121305] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.121327] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12bd00 len 231 ftype 00 stype 80
[ 8639.121335] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8639.223684] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.223707] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b100 len 231 ftype 00 stype 80
[ 8639.223714] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8639.326227] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.326252] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b500 len 231 ftype 00 stype 80
[ 8639.326260] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8639.428518] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.428537] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2800 len 231 ftype 00 stype 80
[ 8639.428544] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8639.530909] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.530941] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2d00 len 231 ftype 00 stype 80
[ 8639.530948] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8639.633402] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.633428] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2000 len 231 ftype 00 stype 80
[ 8639.633435] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8639.735837] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.735870] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2900 len 231 ftype 00 stype 80
[ 8639.735878] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8639.838220] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.838253] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2e00 len 231 ftype 00 stype 80
[ 8639.838260] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8639.940724] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8639.940759] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2b00 len 231 ftype 00 stype 80
[ 8639.940766] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.043136] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.043149] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2100 len 231 ftype 00 stype 80
[ 8640.043152] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.145552] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.145573] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2a00 len 231 ftype 00 stype 80
[ 8640.145580] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.248055] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.248083] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2f00 len 231 ftype 00 stype 80
[ 8640.248090] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.350482] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.350510] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2700 len 231 ftype 00 stype 80
[ 8640.350517] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.452842] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.452868] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2300 len 231 ftype 00 stype 80
[ 8640.452876] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.555270] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.555293] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2c00 len 231 ftype 00 stype 80
[ 8640.555300] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8640.657696] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.657719] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc1d200 len 231 ftype 00 stype 80
[ 8640.657726] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.760193] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.760218] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2500 len 231 ftype 00 stype 80
[ 8640.760225] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.862488] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.862525] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133bdab00 len 231 ftype 00 stype 80
[ 8640.862533] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8640.964920] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8640.964951] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880134685a00 len 231 ftype 00 stype 80
[ 8640.964958] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8641.067361] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.067382] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc1d600 len 231 ftype 00 stype 80
[ 8641.067390] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8641.169735] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.169749] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a36900 len 231 ftype 00 stype 80
[ 8641.169757] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8641.272179] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.272210] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880125bf8600 len 231 ftype 00 stype 80
[ 8641.272217] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8641.374418] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.374433] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a36500 len 231 ftype 00 stype 80
[ 8641.374436] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8641.476939] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.476956] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880125bf8000 len 231 ftype 00 stype 80
[ 8641.476960] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8641.579324] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.579351] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a36800 len 231 ftype 00 stype 80
[ 8641.579358] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8641.681759] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.681789] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880100ef1200 len 231 ftype 00 stype 80
[ 8641.681796] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8641.784119] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.784148] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3b00 len 231 ftype 00 stype 80
[ 8641.784155] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8641.886516] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.886548] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3900 len 231 ftype 00 stype 80
[ 8641.886555] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8641.989015] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8641.989047] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3000 len 231 ftype 00 stype 80
[ 8641.989054] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8642.091308] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.091331] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3500 len 231 ftype 00 stype 80
[ 8642.091338] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8642.193712] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.193734] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3e00 len 231 ftype 00 stype 80
[ 8642.193741] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8642.296178] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.296213] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3200 len 231 ftype 00 stype 80
[ 8642.296220] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8642.398561] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.398590] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa99700 len 231 ftype 00 stype 80
[ 8642.398597] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8642.500877] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.500896] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa99b00 len 231 ftype 00 stype 80
[ 8642.500900] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8642.603313] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.603342] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013af61200 len 231 ftype 00 stype 80
[ 8642.603349] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8642.705751] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.705781] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130900900 len 231 ftype 00 stype 80
[ 8642.705788] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8642.808142] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.808165] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa99900 len 231 ftype 00 stype 80
[ 8642.808172] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8642.910585] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8642.910620] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130900600 len 231 ftype 00 stype 80
[ 8642.910627] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8643.012911] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.012941] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130900800 len 231 ftype 00 stype 80
[ 8643.012948] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8643.115291] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.115315] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130900d00 len 231 ftype 00 stype 80
[ 8643.115322] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8643.217727] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.217740] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e434a00 len 231 ftype 00 stype 80
[ 8643.217747] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8643.320112] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.320122] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130900f00 len 231 ftype 00 stype 80
[ 8643.320124] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8643.422573] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.422593] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56fc00 len 231 ftype 00 stype 80
[ 8643.422597] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8643.524870] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.524883] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e434800 len 231 ftype 00 stype 80
[ 8643.524887] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8643.627430] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.627454] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56fe00 len 231 ftype 00 stype 80
[ 8643.627458] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8643.729816] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.729837] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56fa00 len 231 ftype 00 stype 80
[ 8643.729845] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8643.832172] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.832194] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56f700 len 231 ftype 00 stype 80
[ 8643.832198] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8643.934585] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8643.934617] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56f300 len 231 ftype 00 stype 80
[ 8643.934624] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8644.037046] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.037060] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56f400 len 231 ftype 00 stype 80
[ 8644.037064] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8644.139287] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.139296] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56ff00 len 231 ftype 00 stype 80
[ 8644.139298] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8644.241749] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.241762] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56f600 len 231 ftype 00 stype 80
[ 8644.241766] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8644.344234] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.344265] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88012be50600 len 231 ftype 00 stype 80
[ 8644.344273] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8644.446593] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.446607] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88012be50d00 len 231 ftype 00 stype 80
[ 8644.446611] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8644.548913] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.548933] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88012be50800 len 231 ftype 00 stype 80
[ 8644.548937] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8644.651393] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.651412] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88012be50e00 len 231 ftype 00 stype 80
[ 8644.651420] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8644.753859] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.753899] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958800 len 231 ftype 00 stype 80
[ 8644.753907] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8644.856197] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.856227] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958b00 len 231 ftype 00 stype 80
[ 8644.856234] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8644.958568] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8644.958589] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958500 len 231 ftype 00 stype 80
[ 8644.958597] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.060959] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.060982] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801390b0800 len 231 ftype 00 stype 80
[ 8645.060990] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.163393] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.163417] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e5f3a00 len 231 ftype 00 stype 80
[ 8645.163425] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.265757] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.265779] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958e00 len 231 ftype 00 stype 80
[ 8645.265786] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.368153] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.368174] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958d00 len 231 ftype 00 stype 80
[ 8645.368181] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.470586] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.470605] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013093e600 len 231 ftype 00 stype 80
[ 8645.470613] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.572919] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.572930] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f056000 len 231 ftype 00 stype 80
[ 8645.572938] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.675349] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.675362] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013901bf00 len 231 ftype 00 stype 80
[ 8645.675366] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.777771] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.777791] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133bd8800 len 231 ftype 00 stype 80
[ 8645.777797] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.880175] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.880197] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af94ec00 len 231 ftype 00 stype 80
[ 8645.880203] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8645.982590] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8645.982617] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013af60600 len 231 ftype 00 stype 80
[ 8645.982624] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8646.084926] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.084948] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013092b500 len 231 ftype 00 stype 80
[ 8646.084955] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8646.187306] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.187324] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a253300 len 231 ftype 00 stype 80
[ 8646.187330] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8646.289821] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.289849] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e6db900 len 231 ftype 00 stype 80
[ 8646.289856] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8646.392179] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.392206] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bed0000 len 231 ftype 00 stype 80
[ 8646.392213] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8646.494695] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.494725] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013901b600 len 231 ftype 00 stype 80
[ 8646.494733] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8646.597009] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.597032] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339e4000 len 231 ftype 00 stype 80
[ 8646.597039] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8646.699469] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.699491] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a145b00 len 231 ftype 00 stype 80
[ 8646.699498] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8646.801720] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.801744] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801338b9e00 len 231 ftype 00 stype 80
[ 8646.801751] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8646.904293] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8646.904318] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133bdac00 len 231 ftype 00 stype 80
[ 8646.904325] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8647.006608] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.006631] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801390b0a00 len 231 ftype 00 stype 80
[ 8647.006638] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8647.109068] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.109091] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e6a6e00 len 231 ftype 00 stype 80
[ 8647.109098] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8647.211359] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.211378] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af919b00 len 231 ftype 00 stype 80
[ 8647.211385] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8647.313822] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.313845] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013092ad00 len 231 ftype 00 stype 80
[ 8647.313852] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8647.416304] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.416326] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e52e500 len 231 ftype 00 stype 80
[ 8647.416333] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8647.518621] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.518653] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f03b900 len 231 ftype 00 stype 80
[ 8647.518661] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8647.621063] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.621086] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af99be00 len 231 ftype 00 stype 80
[ 8647.621093] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8647.723432] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.723455] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133bd8d00 len 231 ftype 00 stype 80
[ 8647.723462] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8647.825934] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.825957] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8c0a00 len 231 ftype 00 stype 80
[ 8647.825964] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8647.928151] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8647.928172] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a149900 len 231 ftype 00 stype 80
[ 8647.928179] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.030688] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.030719] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5e60c00 len 231 ftype 00 stype 80
[ 8648.030727] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.132948] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.132970] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bed0900 len 231 ftype 00 stype 80
[ 8648.132977] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.235385] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.235403] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc20a00 len 231 ftype 00 stype 80
[ 8648.235410] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8648.337915] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.337938] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa93700 len 231 ftype 00 stype 80
[ 8648.337945] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.440288] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.440324] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f03ba00 len 231 ftype 00 stype 80
[ 8648.440331] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.542651] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.542669] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880100ebad00 len 231 ftype 00 stype 80
[ 8648.542673] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.645013] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.645041] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880100ef7700 len 231 ftype 00 stype 80
[ 8648.645048] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.747425] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.747456] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be4b00 len 231 ftype 00 stype 80
[ 8648.747463] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.849763] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.849786] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3400 len 231 ftype 00 stype 80
[ 8648.849793] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8648.952210] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8648.952232] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc20e00 len 231 ftype 00 stype 80
[ 8648.952239] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8649.054607] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.054626] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a49e00 len 231 ftype 00 stype 80
[ 8649.054633] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8649.157073] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.157098] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c64200 len 231 ftype 00 stype 80
[ 8649.157106] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8649.259489] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.259524] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3700 len 231 ftype 00 stype 80
[ 8649.259531] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8649.361905] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.361929] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f056800 len 231 ftype 00 stype 80
[ 8649.361936] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8649.464241] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.464277] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a49600 len 231 ftype 00 stype 80
[ 8649.464284] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8649.566704] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.566733] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130901900 len 231 ftype 00 stype 80
[ 8649.566740] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8649.669004] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.669044] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339f6200 len 231 ftype 00 stype 80
[ 8649.669051] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8649.771502] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.771538] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b200 len 231 ftype 00 stype 80
[ 8649.771546] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8649.873978] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.874005] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e5f3c00 len 231 ftype 00 stype 80
[ 8649.874013] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8649.976306] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8649.976328] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af818800 len 231 ftype 00 stype 80
[ 8649.976335] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.078662] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.078685] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3c00 len 231 ftype 00 stype 80
[ 8650.078692] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.181103] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.181121] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3a00 len 231 ftype 00 stype 80
[ 8650.181128] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.283485] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.283502] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b600 len 231 ftype 00 stype 80
[ 8650.283509] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.385854] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.385880] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be4a00 len 231 ftype 00 stype 80
[ 8650.385887] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.488368] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.488394] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3800 len 231 ftype 00 stype 80
[ 8650.488402] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.590630] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.590652] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2800 len 231 ftype 00 stype 80
[ 8650.590659] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.693094] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.693119] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880139695800 len 231 ftype 00 stype 80
[ 8650.693123] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.795492] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.795503] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2400 len 231 ftype 00 stype 80
[ 8650.795507] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8650.897915] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8650.897930] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b500 len 231 ftype 00 stype 80
[ 8650.897932] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8651.000277] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.000297] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339e4d00 len 231 ftype 00 stype 80
[ 8651.000305] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8651.102665] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.102678] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2a00 len 231 ftype 00 stype 80
[ 8651.102681] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8651.205117] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.205136] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c64300 len 231 ftype 00 stype 80
[ 8651.205140] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8651.307465] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.307473] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880134685900 len 231 ftype 00 stype 80
[ 8651.307476] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8651.409883] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.409906] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880125b74b00 len 231 ftype 00 stype 80
[ 8651.409910] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8651.512314] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.512326] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2700 len 231 ftype 00 stype 80
[ 8651.512331] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8651.614732] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.614748] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e554900 len 231 ftype 00 stype 80
[ 8651.614750] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8651.717129] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.717141] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a2a00 len 231 ftype 00 stype 80
[ 8651.717143] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8651.819675] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.819695] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880125bf8b00 len 231 ftype 00 stype 80
[ 8651.819702] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8651.921982] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8651.921995] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a149e00 len 231 ftype 00 stype 80
[ 8651.921999] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.024342] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.024360] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2300 len 231 ftype 00 stype 80
[ 8652.024362] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.126817] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.126834] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc1d200 len 231 ftype 00 stype 80
[ 8652.126838] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.229146] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.229158] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb6100 len 231 ftype 00 stype 80
[ 8652.229165] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.331474] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.331496] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3400 len 231 ftype 00 stype 80
[ 8652.331504] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.433956] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.433969] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f0b2800 len 231 ftype 00 stype 80
[ 8652.433976] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.536390] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.536416] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339cc400 len 231 ftype 00 stype 80
[ 8652.536424] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.638770] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.638792] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880139697a00 len 231 ftype 00 stype 80
[ 8652.638799] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.741114] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.741136] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2000 len 231 ftype 00 stype 80
[ 8652.741143] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.843656] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.843688] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3300 len 231 ftype 00 stype 80
[ 8652.843695] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8652.945992] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8652.946016] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c64000 len 231 ftype 00 stype 80
[ 8652.946023] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8653.048443] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.048469] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a36800 len 231 ftype 00 stype 80
[ 8653.048477] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8653.150718] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.150743] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3e00 len 231 ftype 00 stype 80
[ 8653.150750] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8653.253256] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.253281] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa99400 len 231 ftype 00 stype 80
[ 8653.253288] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8653.355676] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.355698] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880125bf8000 len 231 ftype 00 stype 80
[ 8653.355705] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8653.458004] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.458029] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a36500 len 231 ftype 00 stype 80
[ 8653.458036] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8653.560349] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.560371] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2b00 len 231 ftype 00 stype 80
[ 8653.560378] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8653.662782] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.662797] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880100ef1200 len 231 ftype 00 stype 80
[ 8653.662801] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8653.765185] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.765209] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130900e00 len 231 ftype 00 stype 80
[ 8653.765216] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8653.867563] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.867586] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2e00 len 231 ftype 00 stype 80
[ 8653.867593] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8653.970030] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8653.970055] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b100 len 231 ftype 00 stype 80
[ 8653.970062] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8654.072343] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.072368] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801385a3300 len 231 ftype 00 stype 80
[ 8654.072375] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8654.174788] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.174810] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e6a6400 len 231 ftype 00 stype 80
[ 8654.174817] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8654.277143] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.277170] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a21cb00 len 231 ftype 00 stype 80
[ 8654.277177] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8654.379611] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.379637] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a05f900 len 231 ftype 00 stype 80
[ 8654.379644] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8654.482105] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.482129] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa8a700 len 231 ftype 00 stype 80
[ 8654.482136] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8654.584348] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.584373] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3900 len 231 ftype 00 stype 80
[ 8654.584380] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8654.686837] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.686850] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133af0a00 len 231 ftype 00 stype 80
[ 8654.686852] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8654.789282] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.789291] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56f200 len 231 ftype 00 stype 80
[ 8654.789293] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8654.891631] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.891666] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af990200 len 231 ftype 00 stype 80
[ 8654.891673] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8654.994024] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8654.994051] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133bdae00 len 231 ftype 00 stype 80
[ 8654.994058] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8655.096354] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.096376] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e6a6f00 len 231 ftype 00 stype 80
[ 8655.096383] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8655.198789] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.198814] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a134d00 len 231 ftype 00 stype 80
[ 8655.198820] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8655.301239] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.301266] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88012be50c00 len 231 ftype 00 stype 80
[ 8655.301273] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8655.403626] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.403649] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880139789a00 len 231 ftype 00 stype 80
[ 8655.403656] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8655.506013] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.506038] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2c00 len 231 ftype 00 stype 80
[ 8655.506041] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8655.608401] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.608415] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a06f000 len 231 ftype 00 stype 80
[ 8655.608418] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8655.710818] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.710844] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958b00 len 231 ftype 00 stype 80
[ 8655.710851] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8655.813227] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.813250] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958200 len 231 ftype 00 stype 80
[ 8655.813257] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8655.915601] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8655.915627] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56fe00 len 231 ftype 00 stype 80
[ 8655.915634] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.017958] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.017983] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013ad44000 len 231 ftype 00 stype 80
[ 8656.017990] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.120396] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.120412] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339f6d00 len 231 ftype 00 stype 80
[ 8656.120416] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.222847] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.222869] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130958100 len 231 ftype 00 stype 80
[ 8656.222877] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.325236] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.325263] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133afcf00 len 231 ftype 00 stype 80
[ 8656.325271] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.427678] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.427701] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f0b2d00 len 231 ftype 00 stype 80
[ 8656.427708] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.530001] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.530037] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801345cce00 len 231 ftype 00 stype 80
[ 8656.530044] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.632407] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.632434] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af94e900 len 231 ftype 00 stype 80
[ 8656.632441] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.734845] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.734868] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a06fa00 len 231 ftype 00 stype 80
[ 8656.734875] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.837260] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.837290] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133bda600 len 231 ftype 00 stype 80
[ 8656.837298] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8656.939666] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8656.939693] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bed0200 len 231 ftype 00 stype 80
[ 8656.939701] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8657.041997] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.042023] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a149800 len 231 ftype 00 stype 80
[ 8657.042030] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8657.144399] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.144421] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e67a000 len 231 ftype 00 stype 80
[ 8657.144428] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8657.246822] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.246844] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa94000 len 231 ftype 00 stype 80
[ 8657.246852] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8657.349209] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.349231] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339f6500 len 231 ftype 00 stype 80
[ 8657.349237] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8657.451648] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.451685] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af94e300 len 231 ftype 00 stype 80
[ 8657.451692] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8657.554124] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.554150] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e766200 len 231 ftype 00 stype 80
[ 8657.554157] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8657.656401] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.656427] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af94e800 len 231 ftype 00 stype 80
[ 8657.656434] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8657.758788] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.758807] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af919500 len 231 ftype 00 stype 80
[ 8657.758814] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8657.861315] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.861337] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa94f00 len 231 ftype 00 stype 80
[ 8657.861344] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8657.963640] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8657.963662] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb6400 len 231 ftype 00 stype 80
[ 8657.963669] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8658.066005] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.066031] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af919f00 len 231 ftype 00 stype 80
[ 8658.066038] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8658.168436] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.168459] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af94e200 len 231 ftype 00 stype 80
[ 8658.168466] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8658.270811] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.270837] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f03b300 len 231 ftype 00 stype 80
[ 8658.270844] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8658.373345] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.373367] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af94ef00 len 231 ftype 00 stype 80
[ 8658.373374] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8658.475750] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.475785] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801390b0a00 len 231 ftype 00 stype 80
[ 8658.475793] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8658.578084] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.578105] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133afce00 len 231 ftype 00 stype 80
[ 8658.578112] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8658.680582] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.680603] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af94e400 len 231 ftype 00 stype 80
[ 8658.680610] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8658.782906] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.782930] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f03b400 len 231 ftype 00 stype 80
[ 8658.782937] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8658.885340] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.885375] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801308cef00 len 231 ftype 00 stype 80
[ 8658.885382] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8658.987702] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8658.987725] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a149900 len 231 ftype 00 stype 80
[ 8658.987732] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8659.090098] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.090130] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e6db900 len 231 ftype 00 stype 80
[ 8659.090137] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8659.192434] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.192457] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e56f400 len 231 ftype 00 stype 80
[ 8659.192464] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8659.294910] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.294936] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e50bf00 len 231 ftype 00 stype 80
[ 8659.294943] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8659.397378] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.397397] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013092b900 len 231 ftype 00 stype 80
[ 8659.397404] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8659.499660] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.499686] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880100ebad00 len 231 ftype 00 stype 80
[ 8659.499694] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8659.602172] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.602194] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013092ad00 len 231 ftype 00 stype 80
[ 8659.602201] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8659.704511] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.704527] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb4d00 len 231 ftype 00 stype 80
[ 8659.704529] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8659.806920] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.806940] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb4300 len 231 ftype 00 stype 80
[ 8659.806947] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8659.909293] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8659.909318] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be4c00 len 231 ftype 00 stype 80
[ 8659.909325] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8660.011608] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.011634] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133992d00 len 231 ftype 00 stype 80
[ 8660.011641] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8660.114093] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.114115] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc20e00 len 231 ftype 00 stype 80
[ 8660.114123] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8660.216499] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.216521] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e434a00 len 231 ftype 00 stype 80
[ 8660.216528] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8660.318851] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.318874] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3d00 len 231 ftype 00 stype 80
[ 8660.318881] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8660.421399] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.421421] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c64e00 len 231 ftype 00 stype 80
[ 8660.421427] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8660.523668] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.523699] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339f6200 len 231 ftype 00 stype 80
[ 8660.523707] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8660.626139] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.626165] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801395cfb00 len 231 ftype 00 stype 80
[ 8660.626172] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8660.728610] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.728631] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130901900 len 231 ftype 00 stype 80
[ 8660.728638] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8660.830989] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.831008] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013952b000 len 231 ftype 00 stype 80
[ 8660.831015] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8660.933273] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8660.933295] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801395cf200 len 231 ftype 00 stype 80
[ 8660.933302] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8661.035795] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.035818] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801395cfa00 len 231 ftype 00 stype 80
[ 8661.035825] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8661.138163] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.138188] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f0b2100 len 231 ftype 00 stype 80
[ 8661.138195] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8661.240530] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.240552] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801395cff00 len 231 ftype 00 stype 80
[ 8661.240559] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8661.342890] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.342913] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2d00 len 231 ftype 00 stype 80
[ 8661.342920] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8661.445450] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.445480] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a3a00 len 231 ftype 00 stype 80
[ 8661.445488] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8661.547835] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.547858] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013092b500 len 231 ftype 00 stype 80
[ 8661.547865] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8661.650126] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.650153] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c76f00 len 231 ftype 00 stype 80
[ 8661.650160] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8661.752568] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.752593] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013ad3a400 len 231 ftype 00 stype 80
[ 8661.752600] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8661.854938] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.854961] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801345c6f00 len 231 ftype 00 stype 80
[ 8661.854969] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8661.957308] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8661.957333] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa93700 len 231 ftype 00 stype 80
[ 8661.957341] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -55, rate_idx 0
[ 8662.059735] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.059759] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2400 len 231 ftype 00 stype 80
[ 8662.059765] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.162135] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.162158] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a49400 len 231 ftype 00 stype 80
[ 8662.162165] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.264508] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.264520] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2100 len 231 ftype 00 stype 80
[ 8662.264526] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.367007] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.367033] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130900000 len 231 ftype 00 stype 80
[ 8662.367040] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.469399] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.469429] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af990500 len 231 ftype 00 stype 80
[ 8662.469436] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.571841] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.571870] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88012be50d00 len 231 ftype 00 stype 80
[ 8662.571877] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.674162] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.674187] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e766c00 len 231 ftype 00 stype 80
[ 8662.674194] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.776604] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.776622] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801344ce300 len 231 ftype 00 stype 80
[ 8662.776629] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.879058] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.879070] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88009f056000 len 231 ftype 00 stype 80
[ 8662.879077] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8662.981465] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8662.981493] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af919300 len 231 ftype 00 stype 80
[ 8662.981500] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.083699] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.083722] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc20b00 len 231 ftype 00 stype 80
[ 8663.083729] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.186115] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.186138] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb6100 len 231 ftype 00 stype 80
[ 8663.186145] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.288592] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.288615] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a14a500 len 231 ftype 00 stype 80
[ 8663.288621] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.391011] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.391032] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa93300 len 231 ftype 00 stype 80
[ 8663.391038] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.493444] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.493472] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a49600 len 231 ftype 00 stype 80
[ 8663.493479] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.595776] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.595799] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e6a6000 len 231 ftype 00 stype 80
[ 8663.595806] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.698246] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.698264] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afa99b00 len 231 ftype 00 stype 80
[ 8663.698271] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.800610] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.800629] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013952bc00 len 231 ftype 00 stype 80
[ 8663.800636] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8663.902975] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8663.902994] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c64000 len 231 ftype 00 stype 80
[ 8663.903001] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -53, rate_idx 0
[ 8664.005321] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.005338] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3e00 len 231 ftype 00 stype 80
[ 8664.005345] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8664.107845] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.107867] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133be3300 len 231 ftype 00 stype 80
[ 8664.107875] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8664.210319] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.210341] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bed0900 len 231 ftype 00 stype 80
[ 8664.210348] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8664.312716] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.312738] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b300 len 231 ftype 00 stype 80
[ 8664.312745] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8664.414950] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.414972] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013ad3a100 len 231 ftype 00 stype 80
[ 8664.414979] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8664.517324] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.517349] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013af60f00 len 231 ftype 00 stype 80
[ 8664.517356] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -54, rate_idx 0
[ 8664.619761] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.619786] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af99b000 len 231 ftype 00 stype 80
[ 8664.619793] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8664.722174] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.722191] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133a36900 len 231 ftype 00 stype 80
[ 8664.722193] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8664.824629] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.824662] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880130900d00 len 231 ftype 00 stype 80
[ 8664.824670] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8664.926981] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8664.927009] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013a12b100 len 231 ftype 00 stype 80
[ 8664.927016] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8665.029358] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.029382] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013092b300 len 231 ftype 00 stype 80
[ 8665.029389] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8665.131774] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.131803] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb4200 len 231 ftype 00 stype 80
[ 8665.131809] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8665.234216] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.234234] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880125bf8000 len 231 ftype 00 stype 80
[ 8665.234241] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8665.336735] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.336754] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c8dd00 len 231 ftype 00 stype 80
[ 8665.336758] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8665.439120] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.439146] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801346caa00 len 231 ftype 00 stype 80
[ 8665.439154] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8665.541470] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.541483] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb4a00 len 231 ftype 00 stype 80
[ 8665.541486] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8665.643817] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.643830] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800a5c64a00 len 231 ftype 00 stype 80
[ 8665.643834] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8665.746282] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.746309] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880136bb4800 len 231 ftype 00 stype 80
[ 8665.746315] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8665.848653] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.848679] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af961600 len 231 ftype 00 stype 80
[ 8665.848686] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8665.951110] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8665.951129] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880133bdae00 len 231 ftype 00 stype 80
[ 8665.951133] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8666.053401] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.053417] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800afac2700 len 231 ftype 00 stype 80
[ 8666.053420] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8666.155881] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.155905] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013092b800 len 231 ftype 00 stype 80
[ 8666.155912] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8666.258286] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.258308] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011bc1d600 len 231 ftype 00 stype 80
[ 8666.258315] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8666.360641] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.360664] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88013093e600 len 231 ftype 00 stype 80
[ 8666.360671] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8666.463117] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.463146] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff88011e6a6b00 len 231 ftype 00 stype 80
[ 8666.463154] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8666.565483] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.565515] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801390b0500 len 231 ftype 00 stype 80
[ 8666.565522] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8666.667803] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.667829] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af919a00 len 231 ftype 00 stype 80
[ 8666.667836] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8666.770261] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.770287] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8801339e4700 len 231 ftype 00 stype 80
[ 8666.770294] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -62, rate_idx 0
[ 8666.872659] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.872687] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff880100ef1500 len 231 ftype 00 stype 80
[ 8666.872694] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
[ 8666.975026] ath10k_pci 0000:03:00.0: event mgmt rx status 00000040
[ 8666.975051] ath10k_pci 0000:03:00.0: event mgmt rx skb
ffff8800af8a2900 len 231 ftype 00 stype 80
[ 8666.975058] ath10k_pci 0000:03:00.0: event mgmt rx freq 5180 band 1
snr -61, rate_idx 0
