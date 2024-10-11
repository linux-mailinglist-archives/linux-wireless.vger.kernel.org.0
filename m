Return-Path: <linux-wireless+bounces-13900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE699AD91
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6E7288869
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2831C689D;
	Fri, 11 Oct 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVNzta0J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB351CF7A0
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728678665; cv=none; b=J8DpUX6X+OSIdJ3QI0+3Gsa3xajaPevit3+pG+FtiCUqK3riB/ej7wApCOqELLEy4sgZNRXc7gkPddTzzduxq7uVogIEJjbajjswDm1HEdwbgdath1q0DbwfikIjIUpM4ZhT24bQEo/jtLMDri0aiWSN6HsmmFw7LLg35SvqKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728678665; c=relaxed/simple;
	bh=vVX7/CXVwBuUkY3LwqqoZmbnjuNWo+uG/k7NFKUYv7k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ii98dgNUhl3y6NvJgM2NhxtkzD8gn2cHO4sHQWU2XmXGQBKp49hlMOgRsHT1vC7dc9DECMI3Z5SZkhTXyjgyEfrQTlybGplpAmprO8RGyDZYXpzfAYu/FOynI23nywrA8BxReZAEBHZPoDFxkzN7/e+etrVD9FKBZzZBd2BvQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVNzta0J; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so22111495e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728678662; x=1729283462; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrNhLYtQGPO0E3mXuEnsVbFS0W5qSpYweCCAmuJ0iGE=;
        b=WVNzta0JG8y4GhPr/Tn8V1ZgWyYHQuvB0r1cuOmxSu2CPbBGde21JcemVovmUeILcI
         QB9/pa3m1yjRT8WERH9HJfJ7tGbsU0yYdaWcE00dGKRh0qjhzgVrayJXTHzg4dhXZZLb
         uPw31EkybCiyrZ/Cw37USIwdZXSddk8tIpxi8Cw5sYsymorr3cMOyHGhrKUdmVJeoH29
         DQsr1S+o0N6leVOp/UI4v9JLGN6WqCNh/QT/WDHxLU5NaPN9o5/4flQLaWoWNwdsjWpf
         r+R0a3X7rhkwlFz0aR6KX3KypLykxoWmFX3+Y6Q9SEYA2Hv8nLh8JoCjxSEln3kwNSGo
         sBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728678662; x=1729283462;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XrNhLYtQGPO0E3mXuEnsVbFS0W5qSpYweCCAmuJ0iGE=;
        b=Z7eiDZaQzRZgAawjujfz7T5DPQkIseHOenpOTHo5j0OX8/HrTNUQMGU0SSqGrS0/6u
         IdsFVs6GFjjeUXRXjPqG4nBZrk0SXAb2k52J9+aRF+qUP1lGMdLUFR4aUie+so8h6rzM
         sL3QHY/3/1xpwq47wAOzs3u+JlrBlhT2X0ULd/5EA5f+K7idMRAQ3cTU2o6ZsBgYvhcr
         s7O8IIWQhrDEjU3LDyjxfEC6o9EL/wmyZJu/MJud0W4N4EPymGAFcWKtcSX5BOcd1Lg8
         WhjTJWUxMtUMaKnvaT202oIExBe6ZoOuu/e/P9VPIZEmrDcHj375s7RlxFIOEhbvPoCV
         BYVA==
X-Gm-Message-State: AOJu0Yw9Fm6UZ/2XlOigI13YQNWAXNUVBC+yxCOyNVVzhcRQyrqDkA5w
	BCAWOYNEYMQulWLC3XMR9O/A61kVxNLcGRPbukPn4vOqaDJ+AsshS7zkiQ==
X-Google-Smtp-Source: AGHT+IE7P5Ra+RBU6KSJDZtiz5Ga0emWMBUIiU8mKEfdD/ujUoUaZVPmXO6au9d+OKptXvKjiKo6UQ==
X-Received: by 2002:a05:600c:350f:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-4311dee8073mr36094905e9.17.1728678662147;
        Fri, 11 Oct 2024 13:31:02 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183062b5sm50274985e9.26.2024.10.11.13.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:31:01 -0700 (PDT)
Message-ID: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Date: Fri, 11 Oct 2024 23:31:00 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 00/22] wifi: rtw88: Add support for RTL8821AU and RTL8812AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patches 1..15 prepare things, patches 16..21 add the new files,
and patch 22 enables their compilation.

There are five new modules: rtw88_88xxa, which contains shared code,
rtw88_8821a and rtw88_8812a, which contain code specific to each chip,
rtw88_8821au, and rtw88_8812au.

More device IDs will be added later because they are not my patches
and I assume they won't need (as m)any revisions. 22 patches is already
a lot.

Also to be added later: USB 3 support for RTL8812AU and RX aggregation
for both chips.

Compared to v1, the code is split into three modules instead of having
it all in a single one.

Bitterblue Smith (22):
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
  wifi: rtw88: Add rtw88xxa.{c,h}
  wifi: rtw88: Add rtw8821a.{c,h}
  wifi: rtw88: Add rtw8812a.{c,h}
  wifi: rtw88: Add rtw8821au.c and rtw8812au.c
  wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers

 drivers/net/wireless/realtek/rtw88/Kconfig    |   33 +
 drivers/net/wireless/realtek/rtw88/Makefile   |   15 +
 drivers/net/wireless/realtek/rtw88/coex.c     |   37 +-
 drivers/net/wireless/realtek/rtw88/coex.h     |   11 +
 drivers/net/wireless/realtek/rtw88/debug.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c       |   34 +-
 drivers/net/wireless/realtek/rtw88/fw.h       |   18 +-
 drivers/net/wireless/realtek/rtw88/mac.c      |   13 +-
 drivers/net/wireless/realtek/rtw88/mac.h      |    3 +
 drivers/net/wireless/realtek/rtw88/main.c     |   35 +-
 drivers/net/wireless/realtek/rtw88/main.h     |   39 +-
 drivers/net/wireless/realtek/rtw88/pci.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/phy.c      |   75 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |  174 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c | 1102 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8812a.h |   10 +
 .../wireless/realtek/rtw88/rtw8812a_table.c   | 2812 +++++++++++++++++
 .../wireless/realtek/rtw88/rtw8812a_table.h   |   26 +
 .../net/wireless/realtek/rtw88/rtw8812au.c    |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c | 1197 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.h |   10 +
 .../wireless/realtek/rtw88/rtw8821a_table.c   | 2350 ++++++++++++++
 .../wireless/realtek/rtw88/rtw8821a_table.h   |   21 +
 .../net/wireless/realtek/rtw88/rtw8821au.c    |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   22 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |   24 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   20 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |   12 -
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   28 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c | 1989 ++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw88xxa.h |  175 +
 drivers/net/wireless/realtek/rtw88/sdio.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.h       |    4 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |    5 +-
 38 files changed, 10272 insertions(+), 135 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.h

-- 
2.46.0


