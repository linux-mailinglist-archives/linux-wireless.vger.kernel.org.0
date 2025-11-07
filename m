Return-Path: <linux-wireless+bounces-28680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6969C40BF4
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 380FE4F2E8E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E71261B67;
	Fri,  7 Nov 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhvJlT7p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B1256C9E
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531483; cv=none; b=MwxLdvTeSWfUFNHX+AtIut/mQCYCvnsfpTc3YT2FHVjYDGBYL7e2Xurnjy6b8/xft6UOf9oOktY4G7IgUUEqaDx47suHdmthV4CYcPjdq+VhDk+vkvQzFkZ3H34Rgn67MWsV0TXPs/1zTZ0vP9M60VlcTnJdOmjki8c5FjEh5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531483; c=relaxed/simple;
	bh=L6/OytdrNTBpY7t0hutcFfOH2ZEVbj7O3miZpVxVSwg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UCPcE6eLfXof/1iulh5r+TX6AKj8zFcAVcq9Y1+H39uB10aHxXP77p3baZkfR40rHyzesVRad9Q6eHoq4EKAEWdLZS5CGKDCWixEFArxLO1dwRAX/E9O13A+tgaUEHvSUwmTc/qX3cllYGErxuyNkzZmlxWYmNwd9ac3oAxiees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhvJlT7p; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c7f4f8a2so480894f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 08:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531480; x=1763136280; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdPnxwm95optEi7JBTccXSE8V3tYyiQtxJuT6k5myUY=;
        b=FhvJlT7pF/vBjCfSq3P3MgcNESr9/8oke6TsXEVjOgd09efP18tPW1xzBnQToczw3F
         hWedDir0m3DFSMHeNLaenWZbrnz9X356Q6Sgxx/krV3mVajny3zG30KoSbCTn+/7AY0l
         zgxlu7rHaZJZjanK3WIvpdHuNgNsTSS+4DSdQa+4b4oIM3unF75yx0qieDHwKBJ/k37V
         jsxqmT4QddS3RtKA7Wxms1A520YG9j+9/TAN1QLqbblydPjUNe1G72Ol2xRqmtJ6VjKQ
         e3dk73CpCHV00IFKuYOl5N0EFYVh5vJ2Kstl4jiYjzpy03h+b6Jaf60INslQRuJ1Y8ng
         mMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531480; x=1763136280;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdPnxwm95optEi7JBTccXSE8V3tYyiQtxJuT6k5myUY=;
        b=E1RUTuCn19ObxeBmAOePjxVm19qNsHqAdbhHEylNcDTZrdY2vtjmySLg07eAFIDof/
         utmY6D5ar7yZQRnBTAUtYt/u9a+fVdIlumGrfjEBoi8ZvfxvCXAlXREfB5ORkdj4KS0d
         v040lzEPri0MFw8K10AToV6KNP1llkrdlrtRU0cPT5MfH9PsLGFdfNxwxDtbpho2YUlJ
         TFCTR/4ZaCZHMz93qaXy4hz8TTUVX9iqRZwLxwRm8aPZvTDYoETwcRtELTUH2BGwvtKZ
         AKV4PnjRI6jDSUp1Gf7yJsXSA00M9zfQ/hGjjW1fqP1HL4vvOKBI26/CC0Fynx+Vigzl
         VTag==
X-Gm-Message-State: AOJu0YyzzS3g7OyYE46Nu4dF+abU7dTBH60BosKqpxDKSyxSEB8Dq/e3
	+rBJH5M4eXUqNJhtsyjm6Y18DRYSNrHLAgQOBEEkRO9jnigQP4lEEjn2pCj0/g==
X-Gm-Gg: ASbGncvdtgKDKRMkpS+NZY6NlHYy+DMPE5T3NyDJgAPx4zjkdZn+33f1pMw1T+5PWs0
	cckfGxAVGn1saPct/9BjMXFDNEjlB465kVzlt1mdQLMJDEYccKW1cQuonUbydUwdovng2dtQ8Yi
	6pWEfISCBppB4/3BiSpj5DJLbi8cUG8A9Gvt/E/Y0OPMG/UtawvuPYOh1Unwii/UEQwr1uT6a3S
	bZem9pufbku6Zw0OJpim1eRb4XXfIDgzpcE7IvXlTKfNfZklRwEoaoIN5updaUoumCO8LaKTooW
	3aGXt9mIsDpOvsphYZlieUVVFI9CE7Z5PnI6DZ33Jv7o+wIJPR37SxYwM7o48Xw1KFSH9KDTUIN
	iHfzqKrXcRRHa/JzsDGB7FvKRbBbXoOSzW/smt8ERh8sQ/ktfP/9IkI1PZDCBSq91NjqRXFwhQa
	/fGxHqz5BkFHWSdqj6J7s=
X-Google-Smtp-Source: AGHT+IGSCkDY0mCr3XAcX9CO3YTdfKbbe579K4VAyrCx2H56jCe+4hgdU8xCmJy//S6oAILu750m1A==
X-Received: by 2002:a05:6000:4212:b0:429:c7d9:2f3e with SMTP id ffacd0b85a97d-42b26fc16bemr2501138f8f.21.1762531479717;
        Fri, 07 Nov 2025 08:04:39 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca47sm5888615f8f.24.2025.11.07.08.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 08:04:39 -0800 (PST)
Message-ID: <f0021b8c-efc7-4993-b0a8-8954c682d13b@gmail.com>
Date: Fri, 7 Nov 2025 18:04:37 +0200
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
Subject: [PATCH rtw-next 0/6] Add support for RTL8852AU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Just in time for the last of these devices disappearing from the
market.

Bitterblue Smith (6):
  wifi: rtw89: Use the correct power sequences for USB/SDIO
  wifi: rtw89: Add rtw8852a_dle_mem_usb
  wifi: rtw89: Add rtw8852a_hfc_param_ini_usb
  wifi: rtw89: 8852a: Accept USB devices and load their MAC address
  wifi: rtw89: Add rtw8852au.c
  wifi: rtw89: Enable the new rtw89_8852au module

 drivers/net/wireless/realtek/rtw89/Kconfig    | 11 +++
 drivers/net/wireless/realtek/rtw89/Makefile   |  3 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 26 +++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |  5 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 80 ++++++++++++++++---
 .../net/wireless/realtek/rtw89/rtw8852au.c    | 79 ++++++++++++++++++
 6 files changed, 192 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852au.c

-- 
2.51.1


