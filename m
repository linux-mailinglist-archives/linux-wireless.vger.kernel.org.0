Return-Path: <linux-wireless+bounces-22403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79DAA8940
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 22:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C26173352
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555717A2E6;
	Sun,  4 May 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXvVogL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EBEDF42
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746391675; cv=none; b=eXO6W66oafsxvq31zE2YgOvQ6Uo91YGodVS/i0BTs0hixIXOtJZHc9mPqxj4bS1m6yjPdTAB2RxFSsQSvVLSAk9ENv9mQKbqo+CKNSGX/+UbbzhUbEhneh7j5qg4JsP89H/eJuPV3dDSeXP6Tb3hP+Y773+IMmD8oS75Wjg4J3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746391675; c=relaxed/simple;
	bh=TC6W5Oho4+GKOQKYTBKgC0niitTpHAx25dEBuC96lHs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=If1ePNq6CVoNKQp/CTq/8GursirYOX6dekeYk5FoH+Yqlo0Hu9JM1UAMJ4fT5cj9gWXGs4liiwnhzOnCHOWMu+Eps3buctSSC2oBDtJfrZ8TUpxDqnMYt7FPNLH3xIccGhhoYEK3SzrS2YEVX6mIN9/YDR87aAjUtQF8lUpyg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXvVogL1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ace94273f0dso841871066b.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746391671; x=1746996471; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xkPug/f5tuobS71UobO1rCIuX2iTftGYP6OnHiBi+0=;
        b=ZXvVogL1l3yW1xfgY/6yDyrwjSUCk+aJe32B+uk00zWpJdaU1uT+bJU4C6mniQtBNX
         H8NOVHDjJx+ktI+V/EdHnnxM+Cnyqy5MNcLcpojH9Bd1ynzVe3sY0nYPx2Io2NCNihSS
         +OsnWqhWoP+I5ta+oFmR3yY8Wt5D6oCs+t4HIOtBlCp4M1mZ+s+9Pt2kR2uQ+R6sevS2
         ozRbJJEMtnlqTOli0naVhzwCpv74gMo8rFbY3eP6rAvt+AmF7bo/XOIlxxe0zgkNUpBY
         p2LnmlVu8tvbkQq8PSQIrVdwQJFy2Riu/FntBoZrlKtmkkjuyWDjZRXf9Lfnyxo57u60
         WpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746391671; x=1746996471;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2xkPug/f5tuobS71UobO1rCIuX2iTftGYP6OnHiBi+0=;
        b=JxuYQog5ZxCWC/3H0uJ+KT6cJmCwVerDYUm1OUEIzD0WuxFf2oZyG658Hm0VgXxMej
         Igc8T6p03d1mRbtPDuifVh83mFAQXtN1iAZOIHxmDoXG2wPK/ebCRWMRbWjTzvG/MrOB
         fM+5ZHqCdY3FAzdpsLSt7hzjPGVq8ivdWEwxOjTCGLbTpvWF/RJERPf8fD71nJyYsSwj
         rr3YEGk63cQuP3bE2A0Osm4xTJCOTU+/AFgDf+B9sUb3wP/HVrkeeU1nYCWOrTMQJD3s
         lA+Hw4iQ4rFYg3EJ/NwGG6OJREPxV3cjkD+y5XvtkstJYTTBD/aAsZqB0TyHWfp7h3Vc
         SBGw==
X-Gm-Message-State: AOJu0Yw5cz3Pktnj69/F/hbgattzZzKazRxduWjvFcRHScsSR//0nNoT
	Oy9PWReqP2QXzMesa38bnGdaqvCKy1b4HnnqUGuDMCFRbSk8pMZgfTUaqQ==
X-Gm-Gg: ASbGncuWEOZlovU6Oj2LHSKBeVDFdZ/NE8Gw+M5Q7XtwkQ0EknmKW5MWh7IStDg61Wh
	b1e/sOUjZzT2ugm2UgPZuQghq/5eLGfnqp6upXtbC+rfOO+HdteAGVIUMJ0jw/TM54uQXKJVxjC
	l7uyTco994+FZjR6tRIPmg1pKz48Em98Z8cbugHIMrFi2/vQ9SiXg6Fhwziux4bnTcBy4z1l5pJ
	NeIenALq4ZSABneAojtMQl13+mAfEbkzMBdYJPG/YqhxVNEemynA+eeI265bvc5WkOEQjDeMCEA
	8/tm5WFlpyjRQ2gqUV+sNSvYK8u+gmwIhkumjO1ilxiFVfIZAA==
X-Google-Smtp-Source: AGHT+IGCU4eWWzrk5EO3gRi+x7PhCELjVApfSs01l71jCcg6YgJQpyKHxs7DDj1mccySNrQxnio/gg==
X-Received: by 2002:a17:907:2cc2:b0:ac2:6910:a12f with SMTP id a640c23a62f3a-ad1a4abba70mr453245466b.46.1746391671156;
        Sun, 04 May 2025 13:47:51 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad18950ac90sm371557766b.150.2025.05.04.13.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 13:47:50 -0700 (PDT)
Message-ID: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
Date: Sun, 4 May 2025 23:47:49 +0300
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
Subject: [PATCH rtw-next v1 00/13] wifi: rtw89: Add support for USB devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for USB devices, starting with just RTL8851BU.
RTL8832BU/RTL8852BU can be supported easily later. RTL8832CU/RTL8852CU
can be supported as well, but it keeps losing the connection.

This is based on rtw88_usb and the official rtl8851bu driver
v1.19.10-70-g84e35c28d.20231019 from here:
https://github.com/fofajardo/rtl8851bu

I didn't test with any PCI devices.

Bitterblue Smith (13):
  wifi: rtw89: 8851b: Accept USB devices and load their MAC address
  wifi: rtw89: Get dle_mem via rtw89_hci_dle_mem()
  wifi: rtw89: Rename hfc_param_ini to hfc_param_ini_pcie
  wifi: rtw89: Add dle_mem_usb2 and dle_mem_usb3
  wifi: rtw89: Add hfc_param_ini_usb
  wifi: rtw89: Disable some power saving for USB
  wifi: rtw89: Add extra TX headroom for USB
  wifi: rtw89: Hide some errors when the device is unplugged
  wifi: rtw89: Fix rtw89_mac_power_switch() for USB
  wifi: rtw89: Add some definitions for USB
  wifi: rtw89: Add usb.{c,h}
  wifi: rtw89: Add rtw8851bu.c
  wifi: rtw89: Enable the new USB modules

 drivers/net/wireless/realtek/rtw89/Kconfig    |   14 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    6 +
 drivers/net/wireless/realtek/rtw89/core.c     |    3 +
 drivers/net/wireless/realtek/rtw89/core.h     |   16 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   49 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |    8 +
 drivers/net/wireless/realtek/rtw89/pci.c      |    8 +
 drivers/net/wireless/realtek/rtw89/phy.c      |    3 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   30 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   91 +-
 .../net/wireless/realtek/rtw89/rtw8851bu.c    |   33 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |    7 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |    7 +-
 drivers/net/wireless/realtek/rtw89/txrx.h     |    1 +
 drivers/net/wireless/realtek/rtw89/usb.c      | 1030 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h      |   61 +
 20 files changed, 1359 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h

-- 
2.49.0


