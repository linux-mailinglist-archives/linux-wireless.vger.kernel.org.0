Return-Path: <linux-wireless+bounces-18461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706BCA27A1A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4403A1A68
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF17217F53;
	Tue,  4 Feb 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+YBy9YE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AB3217707
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694138; cv=none; b=SnW0k6e9TBoBc8V79lIU8pdduKDMQXtsm7v3MvrMJ/CYAd6hzmUemCWaTmd0Z9E4ELfUtnS7V8YapdE4IfLbVs6lUSas+TipY24ABOLW9NSsn13ZZwXj7Kmc17aVkpuL+n9KgYBDMU7POVCv9Fxbok3fKtKl39C9nw1/Ne3ztAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694138; c=relaxed/simple;
	bh=zctEv5husV2ceReknPyXdsKXH/qaBEuDmPeWuD/wGS4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=oeDW4BBrA3r4BS/fFxQF8bmt5SQycodVUUHWoauhnKht+OZeKqkdykOMiuDpPpoLo4tSitCu/Wtvuk1XjkJxG5lP4Lpc0EB98D1d5LHC2+q9ZVi59yHeoj8HwbKK7Ui1GO5Y21IIjxkj+dNfe7uErLdnAQ+x/QahDuBNjbyWqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+YBy9YE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dcb060ca2dso4578521a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694135; x=1739298935; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f0AHDqAkuuJpl5aAcnV9OQOjaXEW6kucIZX7Qe1oj8=;
        b=m+YBy9YEh/tscxMES+EOO/GtjQP+WK/5K6DgtHU9Xo061jfiMkdZQ+uFtvXbtF+DVQ
         U5bUDjL2irCQ7sI9aUQeqqUMe4yzOPs8vVQS55vHNWJg5KbDn1E/qvBqS7ARAszGcfZF
         QJpCzWsRC7XfeLJmBKvo41OkcZdVg4fO4g+xP7g+jBZaCnvlLVWOkauZtXzH3c47h1E5
         6eRYLwx150LuAenFyZKGVYvLIcA4E/YkfPCrCVFtxQC4ZP7NqUW5A4kStyyiVjNGkGlM
         3eLCzTXG3FeJR0VDuuh5mcFy+6ELDRR01WWxjPv2LTHUdRRI0kVs7hlzFBUH9M5mmNdf
         wxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694135; x=1739298935;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8f0AHDqAkuuJpl5aAcnV9OQOjaXEW6kucIZX7Qe1oj8=;
        b=oDsSyig6sVyNzkCO/JTRSMofXCKsPvKyYEIoV+gcYlFnYzv8JjFgaZYT+pvjpXgTqx
         k4a6oCGJuQQZj2SD6QNH/nHLUEx9UdFpU88yvW7iH86LMPbL5FMPPfDBwm5fLSV7kPPr
         NNq1yo5G0R6HL8sxLGolxZVq+kRZwT8xCoRjeVKL7qlxO0XhT0Uxdadmny4VBfCFEGnq
         39//po5sUfyHClRVCCaKwD/MJ467AbmXVv/FmNR0AfSCypXuB9OntVDaYaPfqKyh/bdh
         vZe6RLVQ0x66lIThvAlVobD2auIIepRb7BKVNk76MNiQhkl70qr75pbms8Yt5kBdJxKB
         ZXEQ==
X-Gm-Message-State: AOJu0YzB/MmbB2jpIIcTxBuo77nj7KweLmHdzv1kRDK3Dfrl98pQhms5
	LlP7cDqTG2yV/1CAkJj0iKVynb/WSFWAq0UK/4lseaoCgiVTDgHVJZdSxg==
X-Gm-Gg: ASbGncuT2QRsQlzjo1umILMWCSR0gw+PrHVmQ1zWtJnfgiI6mzx7fI+ou+Ovjn92q9K
	LbCCDIHclUZrXT5K3vRdlgjCPpNP4VQKrL3/4TL/IP/Ja+SKzxkcbLgFV4BfoOuhbF1pgoi5Twx
	Op1kV5sep3Ap352uTccDK/OomGAIMLo34kbzPz4yX6dqRrkwq0hdfpfyAxu/HtN4kB5ViCu3o6u
	/buJbcKbAtnEsVNnP2uEDSsvyVG13HqIPHO76GbHvNAlFZT1lYD+4Si9/nL6CzOcbcvRMbJ5YZE
	3U4iQ0rrMc/gvnZPJmRd7Ufi
X-Google-Smtp-Source: AGHT+IHDXYxmNGk/cvOg1qipGfSXKLmS3afCnNXsoCna3qOhzuzHf2co3Cj2kE54h0E5unm9hnmGbg==
X-Received: by 2002:a05:6402:278f:b0:5dc:7f96:6263 with SMTP id 4fb4d7f45d1cf-5dcdb755d37mr56823a12.15.1738694134460;
        Tue, 04 Feb 2025 10:35:34 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723d0036sm9875252a12.6.2025.02.04.10.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:35:34 -0800 (PST)
Message-ID: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Date: Tue, 4 Feb 2025 20:35:32 +0200
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
Subject: [PATCH v2 0/9] wifi: rtw88: Prepare to support RTL8814AU (part 1/2)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A few small changes for RTL8814AU. Mostly it's about supporting more
than 2 RF paths and spatial streams.

Part 2 will have 8 more patches to prepare things.

Part 3 will be mostly the new files for RTL8814AU.

Part 4 will improve performance.

Bitterblue Smith (9):
  wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
  wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
  wifi: rtw88: Extend struct rtw_pwr_track_tbl for RTL8814AU
  wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for RTL8814AU
  wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
  wifi: rtw88: Constify some more structs and arrays
  wifi: rtw88: Rename RTW_RATE_SECTION_MAX to RTW_RATE_SECTION_NUM
  wifi: rtw88: Extend TX power stuff for 3-4 spatial streams
  wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU

 drivers/net/wireless/realtek/rtw88/fw.c       |  15 ++
 drivers/net/wireless/realtek/rtw88/fw.h       |   1 +
 drivers/net/wireless/realtek/rtw88/mac.c      |   6 +-
 drivers/net/wireless/realtek/rtw88/main.c     |  18 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  36 +++-
 drivers/net/wireless/realtek/rtw88/pci.c      |   4 +-
 drivers/net/wireless/realtek/rtw88/phy.c      | 191 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/phy.h      |  20 +-
 drivers/net/wireless/realtek/rtw88/reg.h      |   3 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c |   2 +-
 drivers/net/wireless/realtek/rtw88/sar.c      |   2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c     |   2 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |   2 +-
 16 files changed, 205 insertions(+), 103 deletions(-)

-- 
2.48.1


