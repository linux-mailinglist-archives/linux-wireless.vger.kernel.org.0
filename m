Return-Path: <linux-wireless+bounces-22231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9FBAA42EC
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 08:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352A77ADC80
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 06:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113B14901B;
	Wed, 30 Apr 2025 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tQVvyRf9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5333C2F5B
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745993382; cv=none; b=utnXuxk4hpr1JD9jVC9HWq9HBrqneiq/3uT0Md2SKcicke4yIdf4Sji0BLcNI0s4spDW+Ui0WR+AhfZqD+YvkN4yww9H/BLW9HY+bBLhrip5eyaqcBqI+qVO2jK2ezT2NXXjk4i9uOKV8N4o52kD8AKHIOK0H47JvcjYDw3XoOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745993382; c=relaxed/simple;
	bh=nysZutRqDRdmf9N/VPWFSQ+OAhGUZMFDZ8JWw8/9GOg=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=X3OzuZhnmNwAM7EEeASyvvH+wENo9gF/aHurB7X2e/1iemefHtJCnEjuTis96YfLuWHhZtJiKOf7NhISKrupPB7R6UPcwq4phSsZBj2qgkH4xYZ/4jo34R7tGQWicm3xBqOGZAk1ASncL1dq6p3/Adj8bpL1dfGACDALUJyALPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tQVvyRf9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53U69XF602529431, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745993373; bh=nysZutRqDRdmf9N/VPWFSQ+OAhGUZMFDZ8JWw8/9GOg=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=tQVvyRf94wFu5SEeSN/gQvJYHkm6uJuTRXPdQfg1pWpKjCDZPQwMmr6Lbxj5GbJ+p
	 mMzazDYsy60Ic0TwncjdaTunM1+Tts5J0jgZ3L4ey36XMSAlbzmXFNroud/Y1oWP7R
	 BjP2LoFqjxHELnRFrWrlglgsrkSXTVyT7aPVhKQwgFx6+IHo7nM8wfa8uwXamEFRQB
	 8XGtTnc4KKOMhUTRVxN+maEIhzjNc2FoYMyuXw7KNZ3Iv+Xo02Nt8SzZCTil3j5LkL
	 luw95NUdm/uV3ij8gcqvUse/kdmB/2oLy6jkoZ3Kg/FrsP0E9gj/F7Ma9/FtaVW7TY
	 7ejS987pMyH9g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53U69XF602529431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:09:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Apr 2025 14:09:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Apr
 2025 14:09:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>
Subject: pull-request: update firmware for rtw89 driver along with tag rtw-fw-2025-04-30
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <35d55e0b-8cc9-41f4-b48b-08d7e9f39f97@RTEXMBS04.realtek.com.tw>
Date: Wed, 30 Apr 2025 14:09:33 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

Update firmware to fix problem of disconnection from AP, and add table
for DAG mechanism.

Thank you
Ping-Ke

---

The following changes since commit 0d104598cd5bfff9e1f1a3d0eb86568710cfb4a7:

  Merge branch 'rock-pi-x' into 'main' (2025-04-28 13:14:38 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-04-30

for you to fetch changes up to f56a4436ffe343c5e605050dd174a988950f0699:

  rtw89: 8852c: add tables for dynamic antenna TXPWR (2025-04-30 14:00:05 +0800)

----------------------------------------------------------------
Kuan-Chung Chen (2):
      rtw89: 8922a: update fw to v0.35.71.0
      rtw89: 8852c: add tables for dynamic antenna TXPWR

 rtw89/rtw8852c_fw-2.bin | Bin 2411688 -> 2444568 bytes
 rtw89/rtw8922a_fw-3.bin | Bin 1224798 -> 1238542 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

