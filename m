Return-Path: <linux-wireless+bounces-11271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026DA94E31E
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED0CB21A5D
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 20:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6C71537DB;
	Sun, 11 Aug 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncep8UVk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678351537A7
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409593; cv=none; b=CmdiPUi6Ba5VynBuj1Shs3LKZ/jjtyXgEnuR1xV8mdy6lE8c+4cUiC7ieECtUf4Bx/avOd3l0j7XpwVYm4auFw7ibi707qsnbIVeRGPxTskNqLDwxgeXvhFiudJqQM97Ze1LSZnovwpbdsimYWvvNz3P7nfCS+FfEzDxdnCJHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409593; c=relaxed/simple;
	bh=zbDwyHuzTvDGYWoDgtfEglqMdGeFZtY4kUDarbIUukE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Z8V0g9opAIjrIIdE4cEjmmOalaShE5uDa9S1GHyJH/0K02q4bitVN/BgyFXZZcyBdyMb6KLSB+aMjnS7riW8EE7pvA1hvEFzIYvF8OgRhoUCFjr2O5qQSif6M8lL9jmY7yQrsWskgf92VLklI7Lwg7XK/ICUjx7LVbSuPIV0ZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ncep8UVk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bd1a9bdce4so1599836a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723409590; x=1724014390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS0YhVhUhJxfG5kJoxZaFCOYUASj4XJJXZQviL5KJlA=;
        b=Ncep8UVkkdNBLrg6S7RR6QgqC1m99AF8Vg9BacUMfZWUTF6op/Pw1yyn13B0OnRfl+
         9IvNF7aPN/TnsfsNinb6sOy+RHfh8GziMKNREDrcPKf2UzdyenxBgwGlf4X7KrCBBUoH
         eevvv0IT2/p2bviLVmnOf4YFQVNP83tzpgw96FumM+ZHFtP6ji6m9cANmMJxZaLBXIwP
         V8XOP3QufIVynfYF6f+giudknJi2bTmXUKCoPwGX4WHqZfBHXEG86hQ0ZWAVdZVEEf1v
         AI8fr3IclfX8njY/ReGCnL930AdsiDAnWDP5pFpxD9cFMyJd2cNHHmYso7ztXV7i9Buv
         Ul7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723409590; x=1724014390;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VS0YhVhUhJxfG5kJoxZaFCOYUASj4XJJXZQviL5KJlA=;
        b=rczagTWrsSVJFUdDaIhAclelndnCt22HkgErwNj+NmDDGg8edrc9/y64ufeEIrpsNS
         gv0u8oumzhHaB74/9hrSj5Y+96gmDYOMBPsU+CHjQLSTXk6gxZfreA7goXrbUVGTbH0/
         aYeOI+d8KzSIK83wRD/+MhqSrCFQvDBIN5IEA6vCsqWJG5lXQt7Y5Y33OouP/6sV/+NY
         YqGJsh1dk+9hepLb1mhRpyFCOmYxrRbQAU2FdqoflDTADlgUqp04awXOX7RbjCUk60u6
         u6Mg8C0IAumrmCDGA3ZusTsykWErCVpzCnM9KzRx+8KgqYG9LBa+lvEeU6rUn1Z7iiIk
         y9Tw==
X-Gm-Message-State: AOJu0YzJ8HD7xvh5g/iyUSA8iYPLQYb0H9+l+n6xr9j9yOqUnuoEipPU
	WcP4Vmi070LqX55mdF+mjw5nLBx1PHFVI2dWbGMtRHfZqi0CVRW9BqwwVw==
X-Google-Smtp-Source: AGHT+IFv8DLz4KlbxL4Ezp87GG3tR7mSb9jG++/Cpi/0M9UcbWne+Uk/810NDBGCECB/4XT75ceFKA==
X-Received: by 2002:a17:907:f715:b0:a7d:a29e:5c41 with SMTP id a640c23a62f3a-a80aa5ebb2emr532388466b.40.1723409589395;
        Sun, 11 Aug 2024 13:53:09 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb090a47sm171244366b.41.2024.08.11.13.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 13:53:08 -0700 (PDT)
Message-ID: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Date: Sun, 11 Aug 2024 23:53:06 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH 00/20] wifi: rtw88: Add support for RTL8821AU and RTL8812AU
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patches 1..15 prepare things, patches 16..19 add the new files,
and patch 20 enables their compilation.

There are three new modules: rtw88_8821a, which handles all the logic
for both chips (like rtl8821ae in rtlwifi), rtw88_8821au, and
rtw88_8812au.

More device IDs will be added later because those are not my patches
and I assume they won't need (as m)any revisions. 20 patches is already
a lot.

Also to be added later: USB 3 support for RTL8812AU and RX aggregation
for both chips.

There are still some bugs. Sometimes all RX stops, including C2H,
but I see the chip transmitting probe requests on multiple channels.
It's pretty rare, difficult to trigger. It happened to me four times
in three months.

Bitterblue Smith (20):
  wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
  wifi: rtw88: Dump the HW features only for some chips
  wifi: rtw88: Allow different C2H RA report sizes
  wifi: rtw88: Extend the init table parsing for RTL8812AU
  wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
  wifi: rtw88: Let each driver control the power on/off process
  wifi: rtw88: Enable data rate fallback for older chips
  wifi: rtw88: Make txagc_remnant_ofdm an array
  wifi: rtw88: Support TX page sizes bigger than 128
  wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
  wifi: rtw88: usb: Set pkt_info.ls for the reserved page
  wifi: rtw88: Detect beacon loss with chips other than 8822c
  wifi: rtw88: coex: Support chips without a scoreboard
  wifi: rtw88: 8821a: Regularly ask for BT info updates
  wifi: rtw88: 8812a: Mitigate beacon loss
  wifi: rtw88: Add rtw8812a_table.{c,h}
  wifi: rtw88: Add rtw8821a_table.{c,h}
  wifi: rtw88: Add rtw8821a.{c,h}
  wifi: rtw88: Add rtw8821au.c and rtw8812au.c
  wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers

 drivers/net/wireless/realtek/rtw88/Kconfig    |   25 +
 drivers/net/wireless/realtek/rtw88/Makefile   |    9 +
 drivers/net/wireless/realtek/rtw88/coex.c     |   37 +-
 drivers/net/wireless/realtek/rtw88/coex.h     |    1 +
 drivers/net/wireless/realtek/rtw88/debug.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c       |   21 +-
 drivers/net/wireless/realtek/rtw88/mac.c      |   13 +-
 drivers/net/wireless/realtek/rtw88/mac.h      |    3 +
 drivers/net/wireless/realtek/rtw88/main.c     |   31 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   39 +-
 drivers/net/wireless/realtek/rtw88/pci.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/phy.c      |   71 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |    3 +-
 .../wireless/realtek/rtw88/rtw8812a_table.c   | 2812 +++++++++++
 .../wireless/realtek/rtw88/rtw8812a_table.h   |   26 +
 .../net/wireless/realtek/rtw88/rtw8812au.c    |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 4139 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.h |  385 ++
 .../wireless/realtek/rtw88/rtw8821a_table.c   | 2350 ++++++++++
 .../wireless/realtek/rtw88/rtw8821a_table.h   |   21 +
 .../net/wireless/realtek/rtw88/rtw8821au.c    |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   19 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   27 +-
 drivers/net/wireless/realtek/rtw88/sdio.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.h       |    4 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |    5 +-
 30 files changed, 10083 insertions(+), 89 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821au.c

-- 
2.46.0


