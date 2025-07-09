Return-Path: <linux-wireless+bounces-25142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DEDAFF4C5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 00:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B12D5884C7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C623D28E;
	Wed,  9 Jul 2025 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnRtpgSz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52224169E;
	Wed,  9 Jul 2025 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100548; cv=none; b=o1mMktLG0DwInx/vUK2Y6zGCMDra3wirMAx67O8dtXecLT3OOPQcyEJVwHQIi3vweOo100s3BBf/DpG+9qDFg/VL/WjEVLF1EvP5gc7mhpT8O1eMJ6ADiJaayg3vezOisA67m83kfVCmpyuFemyY7b96d8qvEXT1kEThUIqm8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100548; c=relaxed/simple;
	bh=sULMcYrhk/P21oUDljvXkYqiB5WnScGRJWxL7JVhhEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vor4+03oqlc7qDZZiljSiLtXRvzNvswFj1THjbH4UXVZCqjj/8Al32RCOsuApudtoHxxjL2gkOx2jKijrPpm1UwrAYTFOMO9Qf9p5zpc3HJuJhxh6R4cPQydc5mut3MokltXUgkbT7dHRsZSeUMiAHQAx3MmhWFlpZdZkS9q/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnRtpgSz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553d52cb80dso391738e87.1;
        Wed, 09 Jul 2025 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752100545; x=1752705345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir6bCtYm4fia7bROozGM2Ot9X8/Wd1vmANsM3uxNKa4=;
        b=fnRtpgSzaWlJQYa0XKSc20+uYRToRcF6DMenGi0gmTrpiEEXO+nRGLlfJIIALM7uRD
         A0LYB31b/A6YZ8Djivvq0vYW0PEm+hfAluf66JHXHk+gMqA04mSj6NOFDSTlL49i9UZp
         CqpiVa+diYaOVq+MBB7BiFRcLqhXQGSZy5UroX2+JeDRjVhoY3UMq5h5PBuw1MP6GfI3
         aq1UUAfBmPh5PjTBHmSEdXCd0IPiABbudCvGK/cKE14LB7jmo8R6BXuPYk/RhnwGr2No
         Tl13Th20KjK7h62SkhERmxdifUyNXmrg5YcsWnwCyW6D1Zw7wGYM6gi+1WxIwNeGw/j4
         Hh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752100545; x=1752705345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ir6bCtYm4fia7bROozGM2Ot9X8/Wd1vmANsM3uxNKa4=;
        b=RXWS3P+R7ZMD27c/cqC9Ji0ZBePkR8I2e8OHB62A/BRZGCE9qxWJm2DRtjKPCDI3hm
         LhsDQzIW/rBj+XSnUpvQ/+3YwaSVGGaQI6Mn6n3KSm4uBNzLTpDc3afuSxQ2kWOwSB1i
         t+UkxKVgJQSj0XYCAg+J3Y0uD3PeSc7aktcCDaJRZV2LZe2BoqfSLF/dfxARm+6iVrwW
         rHPJ0ljW9Zyu4JuBhsyiiIthYEn1quOIPS7eYee+IyEmyZOUnltFzqxArdRsrEKkAkOO
         7+Zlr9b7drLCfI551hE8J9sfhTNcPlHlau1b6uYfAa5lX5b+57FHec2lVWkq9CiO/M+S
         6qGA==
X-Forwarded-Encrypted: i=1; AJvYcCUx3/JmFfLdNGU2SuEmqkB2f7JzwFhFLbac4a2ncI1Lpxs3mRIX4VNM3KECnjnyktwM21xbUfySH9vkiABEpZw=@vger.kernel.org, AJvYcCXnWL8qqeYmQQkr7B34ihlz/Hu0JK75HJWCSzMGQi7IHk8r0ddIBOsdgGVg2aPDSiA7H5HBFwa1JFUzxD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlaj3dvwlBnxy9gaVjdmPDFXPIPLnwx91M3ibJYjIpSafDpK1
	t4Ezt1fbaZgkaSN/GetTicYkSnCLqduBfJG9/t8NIM5QmRTsX+MMEbnlQMilbA==
X-Gm-Gg: ASbGncvwbTP3Wh2SGp0EiXWl1R0RVuVGd3YPhGzsYP7Zfmlws1XVwe/84BTob6R+ttp
	Z6WcJyt3Cenf0tfjjm3h/xWaJdfZUcOUVxuDrg0va4v+cv4SrMj4Q7zNXO6YRsQ2rnBy6lLoA0i
	7PKBprVrbq9/zZNCpndmTgJ60fAGCpEtM8NE0sIET9A40hhnN6ck/T+6HRBxXR7TNn1nWRAE7Y9
	yex0vIXM4vF5BOyR9fA039yBydDHYExFOrZ79f4qSGAM3sgEk4XHsL11JHmT7Nc7ZMnHfDdBgYS
	JIkvRMWoOBXbqOgjfuTyADHfpRFD/fuKnmussuu1i0WWQ0NtzKS5TXENz6ZZ/CU01UieHF/rlJF
	BQkj2SE8=
X-Google-Smtp-Source: AGHT+IGcUdqIBW9JiIt8hMnoIa+GU78RZrTj9lpatle54nRW3BQylW3MXAZ/LPCz/1CVjXoX+MYXlg==
X-Received: by 2002:ac2:4e01:0:b0:553:cb0b:4dc7 with SMTP id 2adb3069b0e04-559006ba806mr383310e87.9.1752100545122;
        Wed, 09 Jul 2025 15:35:45 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b74335sm54149e87.215.2025.07.09.15.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:35:44 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Fiona Klute <fiona.klute@gmx.de>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 0/2] wifi: rtw88: enable TX reports for the management queue
Date: Thu, 10 Jul 2025 01:31:57 +0300
Message-ID: <20250709223159.2787192-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed for AP mode. Otherwise client sees the network, but
can't connect to it.

REG_FWHW_TXQ_CTRL+1 is set to WLAN_TXQ_RPT_EN (0x1F) in common mac
init function (__rtw8723x_mac_init), but the value was overwritten
from mac table later. mac_postinit is run after registers from mac
table are set, this allows to set correct values.

Tested on rtl8723cs, that reuses rtw8703b driver.

Changes in v2:
- introduce mac_postinit callback to avoid changing register tables

Andrey Skvortsov (2):
  wifi: rtw88: introduce callback to override phy parameters from tables
  wifi: rtw88: enable TX reports for the management queue

 drivers/net/wireless/realtek/rtw88/mac.c      | 11 +++++++++++
 drivers/net/wireless/realtek/rtw88/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw88/main.c     |  6 ++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  9 ++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  6 ++++++
 8 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.47.2


