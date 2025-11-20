Return-Path: <linux-wireless+bounces-29137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A482C71EF6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 04:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 029CD34694C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 03:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182729B8D9;
	Thu, 20 Nov 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FnHC2j++"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E226FA77
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763608299; cv=none; b=IeKVlK8Rywpm+hcHVieP/uJNSHKL+GBUXyyLZCImbUtQKJtkJ0M5P0QBYI5WuEmCC0ROBvXll1nU/wwRrBYY0QlPT6meVtY4cLuC945hpkqMtjvKDgtCWmJ9A/bYSXAlF20tewrTlH3W4ZqSX9FNJfOhQOsweFTF+iAJ6NOzUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763608299; c=relaxed/simple;
	bh=NUbI6yeCEEWAlPSZJJmGGlcp/Hilt0Tvw0d8cupUlBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=st/tzQcbAonjL+yaQKaRPtPzLDgoFnleEhDll+U3CrYuw+M7YaAvftKRrbUSuBayzz9SV8NPzH0vYIOoFxPM5YJLzn1bVWb+cqF5BxqSIhjnSrfiv5mOLAK9lSAYRh6buuEjKCmez0NgUFoRBj9o9oKJfOWy7Ggnr1lT2/oph/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FnHC2j++; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AK3BPdgC696569, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763608285; bh=4kuEZQMlRT+WMuBRB5dN4pYpOM8rbrU76R7vbafdBWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=FnHC2j++5vqsSMHcup5UfYslqJ0PeqxDd3/dL8uzCTXRkH18iuKUGFDh+yrFSJ0fd
	 mRVCGo/BjlwIBc2bi5dE3WuwDTWwozolUq0D2Vz294fAm/gvimMIxrmEvbLooDSTi+
	 ou7H4L2iD9BgeBatrQDN5oxCbB1ly3ZDtQXl04tJ9WzLr5I3Vhya0nLFXu6z5wYHgr
	 Q7+0fE1ko531tXidOgWG23OtC44uloszk+YxPSctENL3uXdj7MZXTQJrQqMxvmK+Nv
	 YJhIH5S+xs3X/3QloiuTH8GizVLveCiK0A6YQ6gQZqTL168fFnynr+qHIiu6h2W28Y
	 KsmdZXYF81y4w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AK3BPdgC696569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 11:11:25 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:11:26 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 11:11:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 20 Nov 2025 11:11:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: [PATCH v2 rtw-next 0/2] wifi: rtw89: adjust code to fit coming field_prep()
Date: Thu, 20 Nov 2025 11:10:42 +0800
Message-ID: <20251120031044.12493-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

As Geert mentioned [1], two more tricky cases are pointed out by
implementation of field_prep(). Change the code to resolve the tricks.

[1] https://lore.kernel.org/linux-wireless/fccadfe07e4244b993f44ac7315d3d52@realtek.com/T/#mbdfd08117f67b39fabb72dd71acb00f4b3c22bd8

v2:
 - add Reported-by to patch 1/2
 - use a macro to use u32_encode_bits() to generate mask before calling
   inline function to prevent __bad_mask() warning.

Ping-Ke Shih (2):
  wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO
  wifi: rtw89: avoid to use not consecutive mask in __write_ctrl()

 drivers/net/wireless/realtek/rtw89/mac.h      | 26 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 26 +++++--------------
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  8 +++---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 26 +++++--------------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 26 +++++--------------
 5 files changed, 51 insertions(+), 61 deletions(-)

-- 
2.25.1


