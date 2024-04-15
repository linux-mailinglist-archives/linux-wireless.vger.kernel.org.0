Return-Path: <linux-wireless+bounces-6341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC688A5C26
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 22:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C5F284A68
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 20:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B1156871;
	Mon, 15 Apr 2024 20:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtZH+2GQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCC13AA31
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212616; cv=none; b=JYykfdYsKrBSZMtGQL1xt4KFpgzlcIj+1Xbg1ynfVbG0lxyN0sb2N1OA63CC8/r75FKDI/w8vNwNlAvRZwNJCTlzIMmGHgnusEo+SDBoSAMsUtAjFlbc5OsNLFNC6wsylfqb7A4mSd2HRQgaSzNWxBB9Sui9EJoNwrBuGH1dMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212616; c=relaxed/simple;
	bh=cd119whK147bUWRPfCBFbWiiXZP/UfooZK4VKLEbfuI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OmLppy9sJ1ERepSsdRCxIVVN8rv0C54ouqTehlnFCz6xvAwRuAVJnl1kLA8E5yagzxcR+BW5eIQZ+3foZUcRR1DoJHBRH1Fbft+cn3vgTVWgGFXcWVwflvWGqLbqQmlFia9kcNpWbSOfh/oZTDL+XuGkHjAASi4x27SzAWSz/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtZH+2GQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-418910df758so34315e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713212614; x=1713817414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0LTTtKx1uW/CocmSU+gdDaQKThgGoQOsrzjULLo5fA=;
        b=FtZH+2GQMjtO4coQFTRqQ2jouzVt1M8ZV/ckrZaBVQilZQ2SAJjSKWc0UpNo13kTO1
         Hm//b56o5eqy9LS4sWaeUQZhu3y6A9Jmkk466VWmAOO2+8NJH2oeMFXFXfuy1SWrv4eW
         xCAn7LRS1f4a//HX2uXSgt/zQG0ELoV3i7w6xC5poqJ/kNa3btoBkCF2RV0RlPYgFaja
         IH/2Po5CoycYaHU99ENF8iiGdoxUKNgf81ucM4JZfxbjfmRXNhfEJ01rpuVpfRTyAnrm
         STp0W3cbXjfYvYKlb9ceQJqxCkGtM7fLnyuMyS5RFMBZT14B5EdlQkwRSpix1XkwtbLh
         h0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212614; x=1713817414;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C0LTTtKx1uW/CocmSU+gdDaQKThgGoQOsrzjULLo5fA=;
        b=IT9xhO9+G6FDitC/6bgZSRsbMZUAhgoty9CSGPiZJVhExxoANQfxpm/VWzXN3xcD15
         SWuNa2HNQEEMF0Uh+n/fPrbh8AMg5ltT9jDAgayVDcQLC9Q2mt+o6fZwen6/8TNdfX9U
         5xDYgrzaPFU6nsQDOAixQe5vnUAt6C97ORJf/ArNRnUMWJN1FsKLVBSw5yds/ni2J4bm
         6AU4krL0dX2Gw+A0rzx1qtv+QfR3TuXMsJOOLlIPLAxm4i+85OXW/Cm7S9iv5G7tKG8T
         L9Fy1+HjhY3iMk4CJrBDeQdlC0I3ji1ufzmBxLGwdPLky/dm1Z0YUTcIHhTcPbO4SMYu
         QhUA==
X-Gm-Message-State: AOJu0Yx7RLEDtOzurYgbV5hsl1kMENGzHU65Zti0BH0TKbPRnO+n1m07
	SF6FmBREksgrw1uhbUAri+yhnoXsIM1ZiCRQehW8BEn5Hkdjgekd9nUOA7S6
X-Google-Smtp-Source: AGHT+IFdCi9ChfYaf6ZQFmc7Nz28DTcKvVHdwCW6eV4vjnG9LxX7iEFb/f0wAGbHZlYFWDzFkzsq2A==
X-Received: by 2002:a05:600c:3ba8:b0:418:3f32:7304 with SMTP id n40-20020a05600c3ba800b004183f327304mr4008495wms.7.1713212613595;
        Mon, 15 Apr 2024 13:23:33 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id fm15-20020a05600c0c0f00b004186f979543sm3755838wmb.33.2024.04.15.13.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:23:33 -0700 (PDT)
Message-ID: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
Date: Mon, 15 Apr 2024 23:23:31 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v5 0/6] wifi: rtlwifi: Move common code from rtl8192de to
 rtl8192d-common
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches fix some bugs in rtl8192de and move some of the code to
a new rtl8192d-common module, in order to share that code with the new
rtl8192du driver.

v4 of the series included the new rtl8192du driver as well, but it was
becoming too long. The new driver will be added in another series of
patches.

v5:
 - Fix some endianness issues in rtl8192de.
 - Clean up the common code a bit.
 - Drop the patches which added the new driver.
 - More details about the changes can be found in each patch.

v4:
 - Fix slow speeds with WPA3-SAE.
 - Move global variables into struct rtl_priv.
 - Implement requested changes.
 - More details about the changes can be found in each patch.

v3:
 - Fix compilation error and sparse/smatch warnings.
 - Add another USB ID.
 - More details about the changes can be found in each patch.

v2:
 - Add cover letter.
 - Implement feedback.
 - Fix more problems reported by checkpatch.
 - Split the new driver into several patches (4-12) for easier
   reviewing.
 - More details about the changes can be found in each patch.

Bitterblue Smith (6):
  wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
  wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
  wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path
  wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
  wifi: rtlwifi: Clean up rtl8192d-common a bit
  wifi: rtlwifi: Adjust rtl8192d-common for USB

 drivers/net/wireless/realtek/rtlwifi/Kconfig  |    6 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
 drivers/net/wireless/realtek/rtlwifi/cam.c    |    5 +-
 drivers/net/wireless/realtek/rtlwifi/cam.h    |    6 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c  |    2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h  |    2 +-
 .../realtek/rtlwifi/rtl8192d/Makefile         |   11 +
 .../rtlwifi/{rtl8192de => rtl8192d}/def.h     |    0
 .../realtek/rtlwifi/rtl8192d/dm_common.c      | 1061 ++++++++++++++
 .../realtek/rtlwifi/rtl8192d/dm_common.h      |   79 ++
 .../realtek/rtlwifi/rtl8192d/fw_common.c      |  365 +++++
 .../realtek/rtlwifi/rtl8192d/fw_common.h      |   49 +
 .../realtek/rtlwifi/rtl8192d/hw_common.c      | 1226 +++++++++++++++++
 .../realtek/rtlwifi/rtl8192d/hw_common.h      |   24 +
 .../wireless/realtek/rtlwifi/rtl8192d/main.c  |    9 +
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  851 ++++++++++++
 .../realtek/rtlwifi/rtl8192d/phy_common.h     |  111 ++
 .../rtlwifi/{rtl8192de => rtl8192d}/reg.h     |  160 ++-
 .../realtek/rtlwifi/rtl8192d/rf_common.c      |  357 +++++
 .../realtek/rtlwifi/rtl8192d/rf_common.h      |   13 +
 .../realtek/rtlwifi/rtl8192d/trx_common.c     |  516 +++++++
 .../realtek/rtlwifi/rtl8192d/trx_common.h     |  405 ++++++
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 1072 +-------------
 .../wireless/realtek/rtlwifi/rtl8192de/dm.h   |   91 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   |  375 +----
 .../wireless/realtek/rtlwifi/rtl8192de/fw.h   |   37 -
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 1168 +---------------
 .../wireless/realtek/rtlwifi/rtl8192de/hw.h   |   11 -
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  |  918 +-----------
 .../wireless/realtek/rtlwifi/rtl8192de/phy.h  |   59 +-
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  375 +----
 .../wireless/realtek/rtlwifi/rtl8192de/rf.h   |    5 -
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   |   12 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  515 +------
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  |  433 ------
 drivers/net/wireless/realtek/rtlwifi/usb.c    |    3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |   12 +
 38 files changed, 5359 insertions(+), 4988 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/Makefile
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/def.h (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h (90%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h

-- 
2.44.0


