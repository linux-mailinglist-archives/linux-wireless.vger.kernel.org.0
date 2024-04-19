Return-Path: <linux-wireless+bounces-6569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57E8AAF6E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD871C2293B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB7128366;
	Fri, 19 Apr 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Z0mxCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD685938
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533687; cv=none; b=ceNs5uYltooRNWe+k6OsTk9ZFfVM5ESvsLC3nqZEUSacEMaSSrfHRKmgIJnLU0J1sKl1Kt+fBMPRg+AzUHj5YTtOffuo77lX8uC+IijtmpenjL3K7//9copazzTS2db4Cz7HQEaUlCKoQ9Ey8Ak0KbK/hcDxZTQikmLMOyy9ODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533687; c=relaxed/simple;
	bh=f2Ow0CFRjLDZHPa1wKprHfncUA3sVhBN6KDCXHdxa6Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=s36dTyqNTFt7DHgH8p92JgjN+BG+5HWeezZQGCEHMxC4LovubhQgzm30BynE8LqjsNp1M2CT5MmPzOQj8aGOlFeVrHWl+fYpbhlDVfRq+1EHj5KH8JjIjxkp0D0DsKTXffwPAv9EE7AMK+PNNYVbAi94e4JpFLf3FvoMSTsnU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Z0mxCa; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5193363d255so2659872e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713533684; x=1714138484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aibZt32sc+ahrAkNBhdLwc+zbXl99Yy5nxlimQsSpwg=;
        b=J0Z0mxCaen/q8wmb/HvsIwSCsT+zWMG18lvmaNbbpixa4Jc7mdfhlnl8pkqjnjegcG
         slHEluf4bXd40YGcmbiIaOdBKVYJaOiLv5AfDePjoUCXK5GkDWafxO2az5RxzqWaFp1H
         0Rx+4K0b28jW7UHbDARzV5jXrA9v/6BvlPh6Ji80mLLis/Oh2y4NU+JPQz9xWGg8lYcy
         orE50w4JK0QVs5G5G0+31VI9g7N1ROWHeh0tJWVCZLwQPWbEqnDqkAzaCySHICENkKM0
         1V4ol3R9vV+P3PyGbKnz31KbwIqh/KdnNjzxmwxC5BnkMtMSPnSuJtxb7Vk1MA5hcZeR
         /zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533684; x=1714138484;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aibZt32sc+ahrAkNBhdLwc+zbXl99Yy5nxlimQsSpwg=;
        b=UXQ/7jiDar7XTp8U2+2+ne1Q66nsYYSICi7zGaoRKx0V2u2zLBN/mwzPhtCLT1q7bR
         eDjdkww67FeBO6q9mxiThkXL6v4Yk/KfqYUIChQl0K+T8/mGa0nsCC/ig7QupEQBciJe
         gH4YBmgO1GmKLL/blLCjnAujHMNPqrDtlhf0VtZ/Q3EVtZdfyTBqnghlTTks+V7gAPrC
         EAMMDshbrxGQ4y/lQHmmSoMfgJZDRMtbBDsh6bMxgpveBuIbJNojk9KLGmZYsajUIGcj
         2vfPC3fSxe+6l5tY2NDo49m6ASJ4E/YLw7bZKEgO2cZ+FJADo/yBICxJmt+q4fjBJY4k
         uSuQ==
X-Gm-Message-State: AOJu0Yyr/2Z+BJSsw31A5kjuWT0c2aRUlXtNphkemygaoCjljCACccsQ
	1CT7QNF8j8zsSWpatsAsexomXX7VIz8sFcOC95/yXdiY/HOAp9Gvxa3heexi
X-Google-Smtp-Source: AGHT+IFoNSyUTv8fGy2iL1+N2Ouu/Hoq4LTl/pcGqexlBzE4NvvfAeWnWJEdYn3UDLO+zgO9OWD5bg==
X-Received: by 2002:a19:740f:0:b0:518:d212:75dd with SMTP id v15-20020a19740f000000b00518d21275ddmr1306466lfe.35.1713533678259;
        Fri, 19 Apr 2024 06:34:38 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906504600b00a4e26377bf1sm2229580ejk.175.2024.04.19.06.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:34:38 -0700 (PDT)
Message-ID: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
Date: Fri, 19 Apr 2024 16:34:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v6 0/6] wifi: rtlwifi: Move common code from rtl8192de to
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

v6:
 - More cleanup.
 - More details about the changes can be found in each patch.

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

 drivers/net/wireless/realtek/rtlwifi/Kconfig  |    4 +
 drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
 drivers/net/wireless/realtek/rtlwifi/cam.c    |    5 +-
 drivers/net/wireless/realtek/rtlwifi/cam.h    |    6 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c  |    2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h  |    2 +-
 .../realtek/rtlwifi/rtl8192d/Makefile         |   11 +
 .../rtlwifi/{rtl8192de => rtl8192d}/def.h     |    0
 .../realtek/rtlwifi/rtl8192d/dm_common.c      | 1061 ++++++++++++++
 .../realtek/rtlwifi/rtl8192d/dm_common.h      |   79 ++
 .../realtek/rtlwifi/rtl8192d/fw_common.c      |  370 +++++
 .../realtek/rtlwifi/rtl8192d/fw_common.h      |   49 +
 .../realtek/rtlwifi/rtl8192d/hw_common.c      | 1217 +++++++++++++++++
 .../realtek/rtlwifi/rtl8192d/hw_common.h      |   24 +
 .../wireless/realtek/rtlwifi/rtl8192d/main.c  |    9 +
 .../realtek/rtlwifi/rtl8192d/phy_common.c     |  856 ++++++++++++
 .../realtek/rtlwifi/rtl8192d/phy_common.h     |  111 ++
 .../rtlwifi/{rtl8192de => rtl8192d}/reg.h     |  162 ++-
 .../realtek/rtlwifi/rtl8192d/rf_common.c      |  359 +++++
 .../realtek/rtlwifi/rtl8192d/rf_common.h      |   13 +
 .../realtek/rtlwifi/rtl8192d/trx_common.c     |  516 +++++++
 .../realtek/rtlwifi/rtl8192d/trx_common.h     |  405 ++++++
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 1072 +--------------
 .../wireless/realtek/rtlwifi/rtl8192de/dm.h   |   91 +-
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   |  375 +----
 .../wireless/realtek/rtlwifi/rtl8192de/fw.h   |   37 -
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 1168 +---------------
 .../wireless/realtek/rtlwifi/rtl8192de/hw.h   |   11 -
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  |  918 +------------
 .../wireless/realtek/rtlwifi/rtl8192de/phy.h  |   59 +-
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  375 +----
 .../wireless/realtek/rtlwifi/rtl8192de/rf.h   |    5 -
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   |   12 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  515 +------
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  |  433 ------
 drivers/net/wireless/realtek/rtlwifi/usb.c    |    3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h   |    6 +
 38 files changed, 5356 insertions(+), 4988 deletions(-)
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



