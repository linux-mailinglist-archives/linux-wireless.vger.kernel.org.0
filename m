Return-Path: <linux-wireless+bounces-20293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B331EA5EA0E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 04:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F3A3AAF33
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 03:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CE213AA2F;
	Thu, 13 Mar 2025 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q7/KcXL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191818635E
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834931; cv=none; b=Y9iC+anvnqVga9WoRrgP7m3AUU7Hjz0NEd0kA7oc/zzCHojkvJ3QNgpfcOqHHtSGxtpcF3nhlHVO5UiW/D9wyAL7q9lEZY8yn0sFtlQoY6fGTH5Qj7g+xx3atgEwxJwbiSzXhQnEPYSaaOvHW7ydzwBZNs7Evhsv8QC4vgXbsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834931; c=relaxed/simple;
	bh=3lB2CeSPev5Z/NoS7+29BuH9Uc/oIdbpXuOX/XjWe6c=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date; b=qjY+Tq5lZ+kB9ZZj66HzybWQSis0Kp7SKXVe7UAYaAtzWpLxP6XBB+GVHGpRf+W+uOoKbqPIoonxgAd/++qg3MMy8zCnTkcpvEUXxgRSogH1mtbBHPzjgcOWnDFCTzTYCPRPTVt9eu8MoJVe183of9JCgA/CWlaAyuAk3e/xN8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q7/KcXL1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52D31tqxE427077, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741834915; bh=3lB2CeSPev5Z/NoS7+29BuH9Uc/oIdbpXuOX/XjWe6c=;
	h=From:To:CC:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=Q7/KcXL1e7TtARKLus3jyW4kNK1kTy14FGfZNyamVMQvk4GD1tFuoePdSg8tGZ4q0
	 Ro6T4Az0zc4rDgllOo+BPfcFtbuKTpfVsWD/N7eTUEOwX9ewRlNSWDpxiE50H34Et1
	 WpkSyd21XJeTgL3Ntrgyo5DopeX67X4WL16lFQEFRVblE/n6xeHz1tKl5pxN7sPf9e
	 TJ9krEvKIg1gPvJmZcm5fyskTMF+j29ZfxhbWGrgNGY/X0wlx+bSJKj5zxP5BP05th
	 OZ2BwnRlfQTKAjEHn+6V+s5boqOC1ZS/YnaJ2m/ykTL2/ILlfDKb+5f59WcBUpzBGE
	 P/Wm0ROiwHffg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52D31tqxE427077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 11:01:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 11:01:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 13 Mar
 2025 11:01:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-firmware@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>
Subject: pull-request: update rtw89 fw for RTL8852C and RTL8922A
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6784cbe4-7afe-48ca-8d74-e30339c72ca9@RTEXMBS04.realtek.com.tw>
Date: Thu, 13 Mar 2025 11:01:54 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

Update firmware of rtw89 divers including RTL8852C and RTL8922A with
support of secure boot.

Thank you
Ping-Ke

---

The following changes since commit 89ba9b7ce05c8dac3b659b6a0ebc87a601fc35b1:

  Merge branch 'robot/pr-0-1741722400' into 'main' (2025-03-12 13:09:10 +0000)

are available in the Git repository at:

  https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-03-13

for you to fetch changes up to da086994b2ad7ca25167baa78cd0a5385092c584:

  rtw89: 8922a: update fw to v0.35.64.0 (2025-03-13 10:58:03 +0800)

----------------------------------------------------------------
Kuan-Chung Chen (1):
      rtw89: 8922a: update fw to v0.35.64.0

Ping-Ke Shih (2):
      rtw89: 8852c: update fw to v0.27.125.0
      rtw89: 8922a: update fw to v0.35.63.0

 rtw89/rtw8852c_fw-1.bin | Bin 2375560 -> 2399272 bytes
 rtw89/rtw8922a_fw-3.bin | Bin 1725278 -> 1188926 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

