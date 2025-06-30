Return-Path: <linux-wireless+bounces-24646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CC1AED3CE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 07:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E38173092
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 05:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC91F1A23BD;
	Mon, 30 Jun 2025 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jPpNPSz6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76E4A01
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261339; cv=none; b=ZWJ4PleBravGaSqSZ8YNRskX5+S27UbSi46P3vvVdYS7ZCLHkJrpxxw3Ae3teqB+q1uI6ojLhUkCrqHCaiY7MDryMZBlMfNIionJL6wyL9qEBBC3867UKgWXEkJfiw37lTlvT/YnoXGEwKTQltpEicYkmM3jHVzvcQxz856eQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261339; c=relaxed/simple;
	bh=iHGQ81MgO2wExw9YWN0BZ9h3SmM7rFPOBmha0JZM6f4=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=dicCCexo7sMM4KYcPiEUhBu+UVmZzPl6qZF2TZSKRaYUoiYVvTX6lo/EMtebgQaT/f9m43/7HL6tWYwY7sbNsM10X5kgOry7YJgIGuPCkXaBHkCBSBa1jytKc5q6eDl8LA1A5E3qMPuv7/Tz8+Mn1RvJE0u6R7ZPhjqDVbJW/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jPpNPSz6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55U5Snm264142727, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751261329; bh=QcZCmqiwv9uwV7FWxUCDGMra4lTmfw9/hHPeBaFgafc=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=jPpNPSz6XhziekHOW8ywM8BHUqi916WOMtOMRaj93ekQejiIV2vNfNu0Ey4kWhVfG
	 FAiVvdTVeZHydKVRsYdMKIxfvHNpvFg1MQllPquur6KJ3Y6wVH7v1vOY1EVDinZOQJ
	 7Nrwuse5GsWoBo8UqjMtWBGjHnpp7T/Hc4f1VHs8v3jDlRQnZ+c/cPcvCL2DiEBUDG
	 n46BOkVWKh58d7QKb53nC1gU63DwUD5P3QSggWEm0QbcwefQubdlDH83QxRRrOAnSi
	 YTQbQ3ItEEVQd6DmOmCODxnsn7X38K8hMOPGkP4pLSXsw9wCFiQ3rk+rn2ECPGfIp4
	 g+cU4WOmMen3Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55U5Snm264142727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 13:28:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 13:29:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 30 Jun
 2025 13:29:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: pull-request: update rtw firmware rtw-fw-2025-06-30
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <eb81e590-2a34-4578-a9e4-e83b8bd6819d@RTEXMBS04.realtek.com.tw>
Date: Mon, 30 Jun 2025 13:29:09 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

Update firmware of RTL8852C and RTL8922A for rtw89 WiFi driver.

Thank you
Ping-Ke

---

The following changes since commit f40eafe216833d083f4e5598b7f45e894c373ad1:

  Merge branch 'license' into 'main' (2025-06-27 11:45:29 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-06-30

for you to fetch changes up to 78478bfc44319c14eeb35d4098c3a84f55fc6bb5:

  rtw89: 8922a: update fw to v0.35.80.0 (2025-06-30 13:26:58 +0800)

----------------------------------------------------------------
Chin-Yen Lee (1):
      rtw89: 8852c: update fw to v0.27.128.0

Ping-Ke Shih (2):
      rtw89: 8852c: update fw to v0.27.129.1
      rtw89: 8922a: update fw to v0.35.80.0

 WHENCE                  |   1 +
 rtw89/rtw8852c_fw-2.bin | Bin 2444568 -> 2461176 bytes
 rtw89/rtw8922a_fw-4.bin | Bin 0 -> 1259006 bytes
 3 files changed, 1 insertion(+)
 create mode 100644 rtw89/rtw8922a_fw-4.bin

