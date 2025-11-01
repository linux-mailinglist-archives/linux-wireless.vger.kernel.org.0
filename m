Return-Path: <linux-wireless+bounces-28456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95CC28602
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 992A34E04F2
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03D32D0C9F;
	Sat,  1 Nov 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU1K8U+d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079EB224B0E
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024678; cv=none; b=VaTJM2wt6mTb7HJCEvwoRNmVdFocedzbEcti5VAA1gLpGeIeBiXaZ04B8hB/CwEVF3lIOvTc3eQEcLLXMtZsJMWOgiaPtvDk4IO1OVTffVq5kjiCNQsCA2/0XuM2ba10Wp33qXF+srPGekKeWNtVMRstQ2TM8gocij0daUc/taE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024678; c=relaxed/simple;
	bh=e4BCiM9of4231lH5n0E/EPTql6XlzD8oC5pFTRYmR+8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=c2fd51EkzGwu320ZZoc+A6ORXDQnAdycwbm4ZgymQN8j6kaAqc2sA2GSR7eK/pwgeZuCdN1A4TN23RVbIom2iVX4sIwt7QX56Ww2iu6ZqSESKC1XATx2pFIXtYMmjbv5JhkzAjhE7Z6ogMRmHCqQDv5NunH6e/ueLTKEvR9x15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gU1K8U+d; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-474975af41dso24097025e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762024675; x=1762629475; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lI5u8M8I93vNKCU9NaONuHipjJZLcG0rNl5B81+3H/g=;
        b=gU1K8U+db24rDxQOvDwqA2oC6OdoSAto8SAsVj6SFWx0iB65xvSsQESp3beRXotZH6
         lLbAgBDhCy8frdb8qkbetlAQ/MY7CeX5SFbbi7MMdXOWl46aS2du2wDmyH0TkIrC/ojc
         zZwQHIf6ahAsRCTq5HqoZhptF+43FZ9DROs4xjmz3HhBKVHo4yK6BZj/ed072NeVlvPp
         TqPy03pf0rtdQrjuCjXmDUXhGZCtmA1hC+AdD2IfBhH4Zk4P81DFug+0IaNycLtT4iDP
         OVTVHqoabx9JZ6EqKaCMndz3lqMsOAgbct3TKui7S2GNpiaIuy4NeukWKHxFWRUSNUrY
         lhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762024675; x=1762629475;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lI5u8M8I93vNKCU9NaONuHipjJZLcG0rNl5B81+3H/g=;
        b=X4BevmjPe5HmiuNdjjeU2kfwvx7t119HBWcJQ8ZYITPSjOMeQCvR7BmlATWYw7Zlpj
         JK2GvE2aZriCT6tHgDs66yTweVCbYeYoNIDqAjcyN0izA2D4q/O++rTQSxDZE/hKNUoL
         o7/L0QFow2j2bW42inpdZO+zfSmVzNdVXXAqsZA5cfv3w/GxYbkhRsSwMMYGtO3QNW+b
         wH+NZlc15oZTtnGUr3QOn3SntmRepHc0Oi0HzcUyPwcOXWDvyxAs2yycfuXO0ONc2X2o
         V+rIwoOMwpvMGMhBVBHeWT5ZleCfeP//4066nA09Dg04LPs+KlRcqOosgWRAnYeg1s4z
         pyYA==
X-Gm-Message-State: AOJu0YxkJ/s7tJe12AcwtH48nUYEZyETN73RtI4nn6sRm9rXP7FbZ+yp
	3PlblJWAU3lGz2hAd829Esftp62c356cNYSXZqZv/Q3hJP9T48GUSqwrnleY1g==
X-Gm-Gg: ASbGncvAlNBMVas0Y9HNtAXC3uMYh3Dd+ufaOIY35eIjso9KFMCv7lCqqBEU9pFhi6Y
	J/IQYt/3gluiFu4hhIjEBEVej2C/+BS33RIPtUCJDQXSJHQFh8zQIW1yH8bSZNim4LF71gaiTC6
	ib1uPrtV08NVBGtnsgEDeJ6oP3f5yaZ08yE3MjGyUPLA3dnm5LeLBMXNFW5AzEQJB8H7X2GqSEC
	ltOycuvLIBUuNphr8KN4+Zz/KJE+5u9ZjITz30PxeiUImW5a9oLab/X+fhN2bs3cTZGEYqkau9O
	+kcQ7rJPaoW0cv79DsFv5DbOpYWrNlaFREzBCy2AGbWwE1cEDcxURIsjXQacggmy7wFOGjQLe1h
	DBV9n7+AdwjMhOvE7OyMohImp137A81KmFvRTDbCadsAulQ1LBz9M7HeCzrQf4Tm7/LhNZdwpf6
	XDYWRkJxMaPWyPJPDGmmI=
X-Google-Smtp-Source: AGHT+IHxt9MK2eV9CPnbrqbsCBb3rPsO2bPwl1s1aMMsQr6edp3dq+SC/m/b1tWo6+KuClcMSkegyA==
X-Received: by 2002:a05:600d:8316:b0:477:43b7:a804 with SMTP id 5b1f17b1804b1-47743b7ab13mr10402235e9.10.1762024675065;
        Sat, 01 Nov 2025 12:17:55 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc070b2sm46083575e9.5.2025.11.01.12.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:17:54 -0700 (PDT)
Message-ID: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Date: Sat, 1 Nov 2025 21:17:52 +0200
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
Subject: [PATCH rtw-next v4 00/12] wifi: rtw89: Add support for RTL8852CU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

v3 was here:
https://lore.kernel.org/linux-wireless/fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com/

The only changes since v3 are in patch 1 (it's new) and patch 9,
to fix the disconnection problems.

Bitterblue Smith (11):
  wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
  wifi: rtw89: usb: Move bulk out map to new struct rtw89_usb_info
  wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_pre_init() for RTL8852CU
  wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_post_init() for RTL8852CU
  wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
  wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
  wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
  wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
  wifi: rtw89: 8852c: Accept USB devices and load their MAC address
  wifi: rtw89: Add rtw8852cu.c
  wifi: rtw89: Enable the new rtw89_8852cu module

Ping-Ke Shih (1):
  wifi: rtw89: 8832cu: turn off TX partial mode

 drivers/net/wireless/realtek/rtw89/Kconfig    |  11 ++
 drivers/net/wireless/realtek/rtw89/Makefile   |   3 +
 drivers/net/wireless/realtek/rtw89/core.c     |  19 +++
 drivers/net/wireless/realtek/rtw89/core.h     |   7 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  34 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  10 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8851bu.c    |  22 +++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852bu.c    |  22 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 128 +++++++++++++++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852cu.c    |  69 ++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   4 +-
 drivers/net/wireless/realtek/rtw89/usb.c      |  45 ++----
 drivers/net/wireless/realtek/rtw89/usb.h      |  11 ++
 18 files changed, 343 insertions(+), 60 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c

-- 
2.51.1


