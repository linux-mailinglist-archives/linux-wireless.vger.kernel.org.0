Return-Path: <linux-wireless+bounces-26398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C082EB27B2F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7B55C583F
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E221E51EE;
	Fri, 15 Aug 2025 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wm7fTs8e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CC225A4F
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247003; cv=none; b=J6kRLky5x+R6YOnv87kfAitrADVl24lrYKZ/g6/Bw1J2uk862fmWWFxKdBFXYcc99J7t2eXU8GYG8gdy9HtrmhxFzpFLyhGbEvSmOJYaS29cCsEBpcgOCEebOVxisF2kNuKyrCz9xrHsZJ8Pecoh6KZ/HnYYEk1zFRFde9wi+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247003; c=relaxed/simple;
	bh=RjV9Urs7B+PWRrROMgEaCKAVKZcQJ95NOYkyHrQaM38=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=kqXaw4jdCwLJhIsT7IUMwhhc0gSaax20GEOMxmA7siURoaNYPspGmlfWaxy0pXfsDPdSZIHjeZr6GD8h7KR4eSWhU2ZmVzkec7i2MBRiZ1XnpgHNQOpVhxfrNzNsoi80XirT5YK527rJRh2TICvw3lru08Ye6JAVKFPGMp6oHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wm7fTs8e; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57F8aTnH53277712, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755246990; bh=gRDSwI3sBKT4WZhAkKtbkVrSMfoaHyo5WJdKym+r+yU=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=wm7fTs8esyPZePD8K04whhswDCijcN+2Qd1YhqGiT+Rw7VejrEVJaV4dQ3e1fp8qw
	 DoN65K6yOyRzpS98ImWZfDVDvue62CpjAdYwYQTPqT61xYRxYuNie6d+iUlyAggzWW
	 efJCp6aXsNap+jQMf7HSvTmbVYUb4TZ0Ax0vBVa9dPInYZUSfRZpwwk9VcmIgzpDWu
	 y5E/ZYFgun+9rEaUKAwYkn99kMs9NsHH37OqvPcG7savbqBleFFWj9sNWftat5S+Dt
	 AHMxXefhcDYKdjajzIt0uL2ZkyJUmMhsWQAKHh5yH5gRQTsYQRgeF2iMFlnszN83H4
	 X13xAto954glg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57F8aTnH53277712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 16:36:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 16:36:30 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 15 Aug
 2025 16:36:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>
Subject: pull-request: update rtw firmware with tag rtw-fw-2025-08-15
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <9761c994-0066-4de1-9b26-171a2baf3e0b@RTKEXHMBS06.realtek.com.tw>
Date: Fri, 15 Aug 2025 16:36:29 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Hi,

Update firmware of Realtwk WiFi driver rtw89. Main update is to correct
WoWLAN feature.

Thank you
Ping-Ke

---

The following changes since commit a312f85c8033086f0cdc96822453089da624c328:

  Merge branch 'rt1321' into 'main' (2025-08-14 16:48:34 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-08-15

for you to fetch changes up to 61ae23e359c6dff2795701779cfb2b5994c47247:

  rtw89: 8922a: update fw to v0.35.80.3 (2025-08-15 16:30:44 +0800)

----------------------------------------------------------------
Kuan-Chung Chen (3):
      rtw89: 8852c: update fw to v0.27.129.3
      rtw89: 8852c: update fw to v0.27.129.4
      rtw89: 8922a: update fw to v0.35.80.3

 rtw89/rtw8852c_fw-2.bin | Bin 2463394 -> 2466994 bytes
 rtw89/rtw8922a_fw-4.bin | Bin 1263938 -> 1263938 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

