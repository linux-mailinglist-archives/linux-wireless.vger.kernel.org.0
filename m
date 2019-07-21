Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D43866F357
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2019 15:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGUNKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jul 2019 09:10:42 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:38875 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfGUNKl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jul 2019 09:10:41 -0400
Received: by mail-io1-f49.google.com with SMTP id j6so35809391ioa.5
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jul 2019 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=k4si//NXgYmtIPn0cLthl8Gd5IAYC4ATfjagyYMyjyY=;
        b=Bd/4ThJwbzRS7if7k8vOyIAONcmD5enxBmKvWMoJ8HlJt3nCn/tVrkS68gk9bZTK1V
         s816c7VEh87Z5dQXJqoxE5ViBhVInxclSgWeREd75EmXSjNdfWLy0585fejQh2HrFMgR
         BMGBWsR9x9HubgDPcGiTvXBjrshEXsfTyM29THUAbSiaqp3rc5cOWzNLEBrGkyPeXSda
         RLBsVt3/aIKC+wP5gQhODmNdEFw3Qi5R38RC+VJyzOxvjIpyRxDefjX1cvDZBMw0/jNY
         ona8Vz5URZFD5JXVPHBsh75q7FtS4fD4jj/L9NzDlDT3JcIvty2U1Q9Ih/NOsbIjqC3y
         Cnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k4si//NXgYmtIPn0cLthl8Gd5IAYC4ATfjagyYMyjyY=;
        b=GcO9oKe7GBkuY3LA3QJkTh5SOIJNrLi8qXiBtlQGz9BugiIaXO+Pu3WndY9NjpZYSJ
         uFMnuS7oavPS50YrUza+NWbiUcccKqnDfPxzW27YR9p2gt6vlzJBLHUcfKRTouyldwiH
         s+AQsV8npzTS5LZhxd1IZ1fDh7V+A1uTitIleBqOSbUiX7OkkZWeY5gGhRLgMKqFdi/c
         dCLJZT0YaIrmyFDHCCo20kZEBe6ONlzzqrEbc9CHpw7QRzrxnV/1p1ZAAb486S3fI2xM
         uXHYRgmooVjGn1DZSF8D+453etEE1KXsCAv0RyritOApqwBJvhZF+/sSfeor5YwOT7UU
         7tag==
X-Gm-Message-State: APjAAAXUu7SBiK/3pbPbUIlMCI+0+4dwpC7eBot4zt5aOyd6OO/zVvIX
        Sjq4vGg9e5RFatHZCiNJraR1oLM3nxytZNWjzI0d532j
X-Google-Smtp-Source: APXvYqyvSAKgPvtlqwtBZ3hBr5craA4JDvVb5Da0c+Mp9M15Zrguy7cl6f/hfsP2KlxOLdbmiwfH1PEiPug9b0yCoXY=
X-Received: by 2002:a5d:88c6:: with SMTP id i6mr37574082iol.107.1563714640727;
 Sun, 21 Jul 2019 06:10:40 -0700 (PDT)
MIME-Version: 1.0
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Sun, 21 Jul 2019 15:10:29 +0200
Message-ID: <CAKfDRXhVQvJYAiacyMx0sGqrh6L7KR606FaBdh4nhznsKY0TMg@mail.gmail.com>
Subject: Problems loading ath9k (ar93xx) calibration data
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I am currently trying to bring up a ramips-based board with a built-in
wifi based on ar93xx. The wifi does not have an eeprom, instead the
calibration data is stored on the flash storage. I have set the
"qca,no-eeprom" option in the node in the dts, extracted the
calibration data and stored it in a file with the correct name in
/lib/firmware. The content of calibration data file can be seen here:
https://pastebin.com/zF6cRetV

I can see that the firmware file is loaded when I boot my board, but
initialization of the wifi device fails. The error message I get is:

[   12.314349] bus=0x1, slot = 0x0, irq=0xff
[   12.318839] ath9k 0000:01:00.0: Direct firmware load for
ath9k-eeprom-pci-0000:01:00.0.bin failed with error -2
[   12.328932] ath9k 0000:01:00.0: Falling back to user helper
[   12.424131] ath: phy0: both bands are disabled
[   12.428713] ath: phy0: Unable to initialize hardware;
initialization status: -22
[   12.436127] ath9k 0000:01:00.0: Failed to initialize device
[   12.441890] ath9k: probe of 0000:01:00.0 failed with error -22

When looking into the content of the eeprom-file, I see that the byte
matching opFlags has the value 0x08. Based on my understanding of the
driver, the only valid values are 0x1, 0x2 and 0x3.

Considering that the next byte has the value 0x1, I suspect the issue
might be related to endianess. However, I haven't found a way to
trigger an endianess-conversion when the calibration data is read for
file. Is there something I am missing or is this not supported?

Could endianess be an explanation for the error I am seeing, or are
there other things in the calibration data the looks like it could
cause problems as well?

Thanks in advance for any help.

BR,
Kristian
