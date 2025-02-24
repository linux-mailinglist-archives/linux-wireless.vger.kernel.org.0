Return-Path: <linux-wireless+bounces-19361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF25A413E7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 04:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4533B2DD7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2025 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E918F4E2;
	Mon, 24 Feb 2025 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WYr17gWn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A8199E89
	for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2025 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740366681; cv=none; b=fRyGY5bfwhnRMFvaZ066DLODvchohdtIPZkMESsNPPHkxvQSW7LhcHJ1G0ZDCCmYl0+bbVgK4w6A0hPyP7qIKfAirx24HGv9zdQATshJP6fyP687JY7j82pm99sLG7ipBxEazJHsu+HKP7YU7luPG5L3ChMCon955bBYq1wLJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740366681; c=relaxed/simple;
	bh=N0TcQ8qghapDCkrwBdAHgINsWtIsEhYirVz5F9Pv3AQ=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=WBvAXb3YQjhznh6oMMb0eHXjnzyC/CThjjCxzu0G8m9og09eybHb10hX+7vwbtNSu/7baOV1dEdwyB0jDRWdOPu8oygszU83BKGYsBUnFkk69Atz1C+ocG9sYy2Fah07n93Z6YdtkHgeiWLYtR+pnNZ1pFFP7Jd2wCx/uUu8rBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WYr17gWn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51O3B23Q02952550, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740366662; bh=N0TcQ8qghapDCkrwBdAHgINsWtIsEhYirVz5F9Pv3AQ=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=WYr17gWnCQKbL3aAFV+dJ5GVI0fhsYjtod/nPdAibn3CF1oW2j2/EQcSNWnzuVlzn
	 H2cC0YVMgkwe3CreOSzWZU0imuEVLNCGiaWGH9iXPsUufnhakrSNmMx6e0I+V9A92O
	 UZzt4CofzUd2B8wsbw6UyadTAB3m7UTPpRT3ABG9i21QMU/Zv3+GcyuF/LekT8HeW/
	 IF8bbdxby6UYjWuZoIqjIpmX6JbMN62QRkZQO/yAjCV5F5o018056I/rmQ/iC6+G//
	 KAUPgyJdcjdh8BHNG6+u/rgvfPWBmaPLlrhU/JeqpXKNmUJG9YjKCNfFtMdH56pT/e
	 COFwK99rWah9w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51O3B23Q02952550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 11:11:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Feb 2025 11:11:02 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 24 Feb
 2025 11:11:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: pull-request: rtw89: 8852bt: update fw to v0.29.122.0 and BB parameter to 07
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <81e6a3ea-70a9-41ff-ba13-6121aa66d487@RTEXMBS04.realtek.com.tw>
Date: Mon, 24 Feb 2025 11:11:00 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

Update firmware of RTL8852BT to v0.29.122.0 including BB parameters 07.

Thank you
Ping-Ke

---

The following changes since commit 6cf959daab2a38d074b059f73c24aab9d4dbcbc3:

  Merge branch 'amd-sev-fw' into 'main' (2025-02-20 18:38:39 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-02-24

for you to fetch changes up to 0a69dcd33a4b2d9ec7286146c99cf6c37714d09e:

  rtw89: 8852bt: update fw to v0.29.122.0 and BB parameter to 07 (2025-02-24 10:54:49 +0800)

----------------------------------------------------------------
Chin-Yen Lee (1):
      rtw89: 8852bt: update fw to v0.29.122.0 and BB parameter to 07

 rtw89/rtw8852bt_fw.bin | Bin 913992 -> 918376 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

