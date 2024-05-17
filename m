Return-Path: <linux-wireless+bounces-7801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F58C8D8D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 23:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEE41C20AA3
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E7238DE0;
	Fri, 17 May 2024 21:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqVCnvHz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA93C489
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980408; cv=none; b=WMOU5pyLabITi4JlCV4baiEBEz6W1oSk26CQaSABSgLdcFhJxrYV8YkhTvME4xZle6NJgfVfJ0QE7qP9VEnnGpyf45Yvyrhk9FMMrISMAoe8g/tc8Ie24luO3AxqqNAdn80XcqwlzKh+Q70reQxbd9Qd8jM03EhzvIzDPL3oNJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980408; c=relaxed/simple;
	bh=npBOyCyuMmPfiDK3L+Pcd830VaJH8VfWFTiHcW6ZcMw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=FumefLOR4VMv2u66gHWT7A5hzb4uR47GpI+2GH22UI6Etr4lCVeIFyHxbC6U9Nge7vwsMEhd7uz6HPxtii6T4EkRPlRLtaZN0K9v0TexSDvZagllZ5UFWDoMFuzlVKoOhGGGQirVcUTLC+/tYErUzJJcP77KOOgYBtKm6tiFBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqVCnvHz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso316555f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980405; x=1716585205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSQM7yHvKoTTPzrfnVjgG0A/cuOCRDJx77UhnfWZKrs=;
        b=lqVCnvHzTTtmseFrO+6Ex449lGpzwXaOP9fXch27g5tewuOVr+xFQomi8XylkGlS4s
         511sBgtqezkz2zJE0AdOXR4YaR87vg1WA6s2UFta8XB9qwlg9wMVkbabQWR8HAzfM6gn
         aUwf5KGnflD5pzjOnCGwi2lu8hJ9nlpr3w1bZxOog+PZDF/3QfhtiY3xEc8MQDCrWC9E
         LKR/13E6kIUpPYpB4THADQA6BBOHJi+s7DIt8O1sU1ptknVSsWEhN3oBptd24kXnMb1o
         b0r2KuF/1nBgJ9uw5U89Kn0MTOC6MdyAdAK6JItSo6FqcU8x8PYicFQSbTXqcpRYDARI
         SFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980405; x=1716585205;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sSQM7yHvKoTTPzrfnVjgG0A/cuOCRDJx77UhnfWZKrs=;
        b=OCwrFwXhjsCj2AIiJRY2JlQoN5la03w54pxj9Y9MOrQNrQWO4hYYd36EsmNwdCNk85
         3KmjJgZhUZFDATW0oA9XIRWGNGFzMlUEpR6Hog7cBnO+5YCFt5aLEoPPqspVioLvOE74
         omaS59vKoVPniMYuhpelqMDtwlBSQhSUMTuOK4JmFSneapo9nnzpoS13dQia9bztU/yg
         UtAMKLilM+uM3yOEGUSWfyvwWfqjw/LO+rfRt45RVcu4jSAnI8kx9BCatfjrrUl+Ipki
         5kDSbsYne89Jz14QZlGSI7pUOtmQRjuElvnhuX4MZA7VvXJO7/ZW9LWSgkU+PhHaTHSZ
         MnsA==
X-Gm-Message-State: AOJu0YwmhHGUaiSr0ykd7OdWX4QR2AqjT4blNdlAn3V67Dp1locQSa05
	dtQHIsxpH+bidYyfvkYMX3lon7vvDpQJOT4e1/V/cibfoB5fvr4ohywLw/s3
X-Google-Smtp-Source: AGHT+IFVHInkLhzzIzaWkGFl5FFICso03i1h2BfwJrhYalHFJboGC/k6Vd1uUgoFJYsCM49YI0bYag==
X-Received: by 2002:adf:a18c:0:b0:34c:cae0:c989 with SMTP id ffacd0b85a97d-354b8e38ec8mr173115f8f.33.1715980404538;
        Fri, 17 May 2024 14:13:24 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354b89d27b6sm230697f8f.96.2024.05.17.14.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 14:13:23 -0700 (PDT)
Message-ID: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
Date: Sat, 18 May 2024 00:13:22 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v6 00/11] wifi: rtlwifi: Add new rtl8192du driver
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches add a driver for the RTL8192DU chip.

Power saving is disabled by default because it's not working.

Dual MAC chips are not tested.

Until Ping-Ke Shih will add the firmware to the linux-firmware
repository, the driver can be tested with the firmware from Larry
Finger's repository:
https://github.com/lwfinger/rtl8192du/blob/master/rtl8192dufw.bin

v4 of the series also included the creation of the rtl8192d-common
module, but it was becoming too long. rtl8192d-common was sent
separately and it's merged already.

v6:
 - Avoid "allyesconfig" build errors.
 - Update the copyright year.
 - A little cleanup.
 - More details about the changes can be found in each patch.

v5:
 - Call it 802.11n instead of 802.11an in the module description and
   Kconfig.
 - Patch 2 is new.

Bitterblue Smith (11):
  wifi: rtlwifi: Add rtl8192du/table.{c,h}
  wifi: rtlwifi: Add new members to struct rtl_priv for RTL8192DU
  wifi: rtlwifi: Add rtl8192du/hw.{c,h}
  wifi: rtlwifi: Add rtl8192du/phy.{c,h}
  wifi: rtlwifi: Add rtl8192du/trx.{c,h}
  wifi: rtlwifi: Add rtl8192du/rf.{c,h}
  wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
  wifi: rtlwifi: Add rtl8192du/dm.{c,h}
  wifi: rtlwifi: Constify rtl_hal_cfg.{ops,usb_interface_cfg} and
    rtl_priv.cfg
  wifi: rtlwifi: Add rtl8192du/sw.c
  wifi: rtlwifi: Enable the new rtl8192du driver

 drivers/net/wireless/realtek/rtlwifi/Kconfig  |   12 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
 drivers/net/wireless/realtek/rtlwifi/base.c   |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/sw.c   |    3 +-
 .../realtek/rtlwifi/rtl8192du/Makefile        |   13 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.c   |  120 +
 .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.c   |   63 +
 .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/hw.c   | 1212 +++++++
 .../wireless/realtek/rtlwifi/rtl8192du/hw.h   |   22 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.c  |   10 +
 .../wireless/realtek/rtlwifi/rtl8192du/led.h  |    9 +
 .../wireless/realtek/rtlwifi/rtl8192du/phy.c  | 3128 +++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/phy.h  |   32 +
 .../wireless/realtek/rtlwifi/rtl8192du/rf.c   |  240 ++
 .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |   11 +
 .../wireless/realtek/rtlwifi/rtl8192du/sw.c   |  395 +++
 .../realtek/rtlwifi/rtl8192du/table.c         | 1675 +++++++++
 .../realtek/rtlwifi/rtl8192du/table.h         |   29 +
 .../wireless/realtek/rtlwifi/rtl8192du/trx.c  |  372 ++
 .../wireless/realtek/rtlwifi/rtl8192du/trx.h  |   60 +
 drivers/net/wireless/realtek/rtlwifi/usb.c    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h    |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   12 +-
 25 files changed, 7436 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h

-- 
2.44.0


