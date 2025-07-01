Return-Path: <linux-wireless+bounces-24732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66C0AEFEC6
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 18:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71815174F5F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9181B0F0A;
	Tue,  1 Jul 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsVTyW1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926EF1DDC15
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385628; cv=none; b=RR6KcFmNNB4lisVbLG+VJv1PdWNspkKYhb5ei93aGX/od0Gik0pI4uNl8WxNdjZs/Cl0ynCIH+VGC/QdBu5P/k5qk66kFkw8xDFzcypY1L9+d5qbVeWb4Pj7aJhRd2/5vlOrFlwWRsoQhzyFe+FHZbeyUwLe7u/JKdTD7uG3AcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385628; c=relaxed/simple;
	bh=kUuezi0zS2cNQ1vNIXhu5l066zZ6ctrWE0NwLA5wCCw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lQ9fAG0QDvTaahTv45mzpM/URqqPA9nchZHwajPKikH4vKWTgb7PL5aYQ48dLtOKgr9RacS+t3GP+NvrV6k1btk9B8Oaq1q4vZlCQJs9hBlkAeliMwBz/s7DQhJB1hogeJMpUTFEXuZc0xrjt+VKaS8fz+Q/hCVdcyHxNvVj5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsVTyW1r; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453634d8609so41878565e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751385625; x=1751990425; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYh9hpCxCAkAibXxuOyAASoRtZ0zFch+392LqyJlJVw=;
        b=VsVTyW1rf1jollZLIURYOcVrndmtHnQLPX9LCfFiyzNLIcdrDRCPNvRW6KA11fHQE6
         KVLGUjI0gR8Q1sjgSK5Uc/Ms4tjFFAcfz91nJK7Iu8hn4zxt91V0BqqMN0qMAA/+G+lW
         x+z1rJX3HPKm9sNUbm4w8L17E5XlgYVWH+2Z6y763FFml9f4KF07XhTk/AncRmFVqlKq
         RFrrxDyRkMd/R1+UGc0F+rjklDcq2UH9kSX5tGriaIUluLSPNV5K0SgHJPCxzz9yxsyT
         LD0zgYum0CRBtlsDq+E5J5V0/5F8mpmGdKHM3H50TbQXowIWrIQXopbwJvs8j56JtfdQ
         Eddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751385625; x=1751990425;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oYh9hpCxCAkAibXxuOyAASoRtZ0zFch+392LqyJlJVw=;
        b=FnOzLIcJgMsFYunT3CU8VLNV1S5iz6Y+QCpJ69QHXHIHWnNVZYHNRzmBlHRyGj+zbK
         HIREF8CzoPS6M4PRNTW49vz1S/Y0B8ZbZSvnYXqYH83WLuhPIEekrHvD44cVmM8vTlBn
         A+oS8qYeDB11Tzb4LI7yRDiW7p1inmP8WWFFLRWwB2phKFz+1yMC5MVuSFekxzvfc8bE
         TJGZEyCQZiIlX5W8byHH4yxe7U/jrCicvQXEbVuP2robxCoQMPtSdrAeRiwpx/4t0xsn
         8q47DHZ0mbVgWNqMKwA23t2nIIs17LwHqRdQ5Th4wkty1VDt0Zxs5qlV8scZfAEsSjJT
         52vA==
X-Gm-Message-State: AOJu0YwfViwADF6hbBPAHlgl1Cy6z91zgkw8Uy+YyL2GuT8O760BztFO
	JH0yXgOqiK/kMdXjJ83hsYZEUnz+tebY3cAIwcR43yRCNJxpus+x8KqNjEWL5Q==
X-Gm-Gg: ASbGncuF8tSuV/aadyFp7vxszuWbSP0UOc5YDlkpRIXPhL7pCISFb7cDRFreEvppzk1
	3prT33hij4qmnPCKQx9JW5ZCkGZQdISOFHNoyD4EwhCUXVv2PHjtPCHeEK1n+g/+d1o3lJdZckL
	R/bclLQszxnbicp6aOtddHoXFX0MbaTp49u/7o7TCh/lk7HnUzAiO8Rd6B8GHDqlkPv5yeWLELk
	s1Qgxp4BETxk/4FRLoBkTkKVorWU6cMTs5UH1+Odm2ulwZ12UhdRg8Noc7J3/HZ8MgcqsQk4LGM
	dLpX7Y79YM46eGQAcMAI7pr7DoZkdACtePctsuCJUtKVoqZUicjgqwKMeU156nekFGrHQg==
X-Google-Smtp-Source: AGHT+IF1rqKWaIA32T63jWi1jfD0qs3L4T+rrcNIW3iKqr+lSY2xOX+viFI0aTxmJwTBEGGijqmuSg==
X-Received: by 2002:a05:600c:6214:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-4538ee59e00mr185095385e9.9.1751385624487;
        Tue, 01 Jul 2025 09:00:24 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad01csm201335515e9.22.2025.07.01.09.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:00:24 -0700 (PDT)
Message-ID: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
Date: Tue, 1 Jul 2025 19:00:22 +0300
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
Subject: [PATCH rtw-next 0/6] wifi: rtw89: Add support for RTL8852BU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for RTL8852BU. The changes needed for this chip are very
similar to the changes needed for RTL8851BU.

These patches depend on the initial USB support, of course:
https://patchwork.kernel.org/project/linux-wireless/list/?series=977480

Bitterblue Smith (6):
  wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
  wifi: rtw89: 8852b: Fix rtw8852b_pwr_{on,off}_func() for USB
  wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
  wifi: rtw89: 8852b: Add rtw8852b_hfc_param_ini_usb
  wifi: rtw89: Add rtw8852bu.c
  wifi: rtw89: Enable the new rtw89_8852bu module

 drivers/net/wireless/realtek/rtw89/Kconfig    | 12 +++
 drivers/net/wireless/realtek/rtw89/Makefile   |  3 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 85 +++++++++++++++++--
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 16 ++--
 .../net/wireless/realtek/rtw89/rtw8852bu.c    | 55 ++++++++++++
 5 files changed, 156 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bu.c

-- 
2.49.0


