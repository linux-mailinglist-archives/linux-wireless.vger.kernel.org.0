Return-Path: <linux-wireless+bounces-13002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD797C5A0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601C91F23622
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF5198E90;
	Thu, 19 Sep 2024 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gLjlamAp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E43198A29
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733584; cv=none; b=k/AZDpxF/jlM2gYBXAF9MM93bBLxGoQHYmiaOqCuA7KQGbibS2L3v6PhnuDZUNSyTOtpQCI8rDw1us07S/QbDcXVJaE0/govB/jBdnyANdBS2chP+8kNB4AEdJRcXsTdO5A4m8+lb+VmX0m+hNWQCvmZwJegv2BnvRntQh4ctzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733584; c=relaxed/simple;
	bh=ccWHVbckbJkbDWNw+b5gRYQHlgSFG2RbGKehmYDL9vA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dtWmxRV1Kr+rUfdy0+LJGMbKdRm2KX08O7AxObKCXaQyxB8m2RX5d47aBW9LFnyr0acIzM2yh2VTzOc0YCEjiUUaq5R9qAl4dfVVJ29cVGrrhO22aogqumI2paC/16gUEK5IERBsuIwfNx0W2apsuT7tSjLZROL8rv1rdBgxvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gLjlamAp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48J8CwpU63453177, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726733578; bh=ccWHVbckbJkbDWNw+b5gRYQHlgSFG2RbGKehmYDL9vA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=gLjlamAp6cOWeyPoxKaZzw8hqK9FPi4bvkNoYmNPohlHrQTns9pZ19y2BNP2Tg8YI
	 il5kdZKypzZYHAIo1brK9kDFbvI6GsKm+cS6bYB6d7pVSxKjmupIO+8754mGMRrShP
	 huQ6bgDX5oCOzi4nLfFciLXmxGSF3m6IhKzDIjr0QYwI2ViFFXJXvvlzkdFf1zveMH
	 TqTKxNBzYPVMN3wvCFPnzhJVssTPgz3dp0bw+l8qNgkAXPxLD7m3UD+/Wia4KKKHFt
	 SvczfPIvRg7sWXTM1fNAw9o0xOiCA0XVfFL5RKZxlO2dcpjgdDRtTdEBCSKpO1fu0m
	 SrAWdbFXFbaYw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48J8CwpU63453177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 16:12:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:12:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 19 Sep
 2024 16:12:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/3] wifi: rtw89: fix some coverity warnings
Date: Thu, 19 Sep 2024 16:12:13 +0800
Message-ID: <20240919081216.28505-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

These warnings are minor because they could happen rarely or harmless,
but worth to fix them.

Ping-Ke Shih (3):
  wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
  wifi: rtw89: coex: initialize local .dbcc_2g_phy in _set_btg_ctrl()
  wifi: rtw89: 8852c: rfk: remove unnecessary assignment of return value
    of _dpk_dgain_read()

 drivers/net/wireless/realtek/rtw89/coex.c         | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.c           | 3 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.25.1


