Return-Path: <linux-wireless+bounces-25441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF34B05147
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 07:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EAB18986D0
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044D11A275;
	Tue, 15 Jul 2025 05:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o66cjgRR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D85C96
	for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558814; cv=none; b=KobkdtMKBhLpcCjVL2dFRw7uI0/CLULeSLNIvS+LBEBooAl9oriMdZtjD8x7ONIjmAhCf9ltDhx5RsK2ijtiuN+5eWi0hK5qqFNo+GQckUfWVl5VXSby+XiAxC0F3M9fBy0+j8XGpsMxJzAsMHQzYLOsR2pl86GIlr1X+GMZkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558814; c=relaxed/simple;
	bh=Ij/mQ+RHPua0HBXgzms/hjA0gm2CYsVFLxzq3zoPUrA=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=l/Doch6oGPiUo9NxkitH0wPMhM4W+5iseTiflfo+r4Qw2WUfnabcEaTyG+MvFCp92nhiEcFOKv2HJY39pf0xotXomrMn6NTSS22LkTlF3xWem0O2U2Tf1u+qfi5aaQWOmUAHZpwBkUZBz+LCgCh+qLhOLxaihRx6/C7E8orHbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o66cjgRR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56F5rN7K14102918, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752558803; bh=xclZmh2xRITrmzsHcCyo1PMvRxfYEpWHUhZzeGJzLMM=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=o66cjgRRHIvAgJfVyBsqK48aoTW2mjkhAOvJnGReAWQP2iJTKfveSfvyDe1BF5yT7
	 NVwQFH5pNbpSfIifT0lT+kn5ZRkCnMJVFYzkjh9YrxcLPYiZNqAOhI5KzWRAjFfjmx
	 UDsTmd5JSVbblkNgY2M8IK9rtFsq/vJUtoVbUapmOLDRA131yqA96fJrxexucm2yhm
	 LV1OZmB4737FY/0Pd7FsZqrDRrJiIgnu0or8UTiQGAewOqBWtqi2nfsCc9caqpp7Bx
	 6qFDF0VOL/MQlztuaraTj8cRXbIfUrWi4UQLf3REl+xxXb+TQ/QQ7afxaenjkwz4N1
	 EaokdNsF2+lug==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56F5rN7K14102918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:53:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 13:53:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 15 Jul
 2025 13:53:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>,
        <damon.chen@realtek.com>
Subject: pull-request: update rtw firmware rtw-fw-2025-07-15
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <880417d5-c1ae-4423-9019-e3dcc2673c43@RTEXMBS04.realtek.com.tw>
Date: Tue, 15 Jul 2025 13:53:23 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

Update firmware of Realtek WiFi driver rtw89 to update BB and regd
parameters, and to support MCC P2P feature.

Thank you
Ping-Ke

---

The following changes since commit ecdbd2b8af04b515732fbf11113cec16651915f0:

  Merge branch 'robot/pr-0-1752505495' into 'main' (2025-07-14 15:45:59 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-07-15

for you to fetch changes up to eb03c8ce595d75f2a2f81cbe87698c2539f64377:

  rtw89: 8852b: update fw to v0.29.128.0 (2025-07-15 13:49:01 +0800)

----------------------------------------------------------------
Kuan-Chung Chen (1):
      rtw89: 8922a: update BB parameter V49

Zong-Zhe Yang (4):
      rtw89: 8852c: add regd fw element with version R72-R57
      rtw89: 8922a: add regd fw element with version R72-R6
      rtw89: 8852bt: update fw to v0.29.127.0
      rtw89: 8852b: update fw to v0.29.128.0

 rtw89/rtw8852b_fw-1.bin | Bin 1244784 -> 1290952 bytes
 rtw89/rtw8852bt_fw.bin  | Bin 918376 -> 937688 bytes
 rtw89/rtw8852c_fw-2.bin | Bin 2461176 -> 2463394 bytes
 rtw89/rtw8922a_fw-4.bin | Bin 1259006 -> 1263938 bytes
 4 files changed, 0 insertions(+), 0 deletions(-)

