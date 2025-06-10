Return-Path: <linux-wireless+bounces-23927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF21AD3885
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6081BA3A1A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E4A29A321;
	Tue, 10 Jun 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="nS6O/ziC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220F2D1F75
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560463; cv=none; b=PQq5KXSzslX4gDIYslXToDi5n4Avvtu7bT7CBtcJjFk6+/bAgU8GDGIh3fB5J/6cD3WjJyEzpU7fg8sPyk43lyBD1ALt983V077B1bHfJVt5Aqb/teAuEYz3oZ7beganpW0MB+m34k1wBmpF8Fob6a5PlV/M3UU9tdFwF4INo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560463; c=relaxed/simple;
	bh=cXfJGSKmXm4ODBddp213/Kn3SUdnevDwyp3fhHUJ/Ks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVyLKnOkHHM4JEJRM3t3BkEdX0dR8Kjc6UWtqzmhNj23QDDLVK6fAGYc8Apl1v4uT3uESR+obYoKC1n1fc+ocmmbJjNTy0kYftbfYev+bZwxAKfcyCfcMsM80oQDWPLN3wlN7AKq/HfwzdiPGtDdQv0DF1rlblVFmyUkYD5nTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=nS6O/ziC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD0vqsE2995411, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560457; bh=RlbReyvBvDD4KQAI6b5qbPSythVgONnK/CIUOjx8EAo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=nS6O/ziCXnnMaZlEKBPLt/W+q+FbaablJgbkiFshuIMuEgP0jiUthWNQPQ7nXIcZU
	 9RBwU4GjN9+9TGj8M4x956R8QPMo5qLGaf8iQntEy3VUMMwDp3ZiFGvSuopuyhh7VE
	 nVDuwyQJYT+bG9Axn31CJcPd5D/NZW0LbB6tXj3Ksv37+GvXg95mea/zz72nnld9R+
	 zEG8ctiNT0Y8OQ4D9IyD4Z3klnJ9RZfrYHOgP6zrp8GgMs2E9gcO8+9bx3ObZxa39R
	 hIflbDPGsXZbo5sM2FSljkgoILFGRGONOwmj2xyPSpYNWo/csAv9ioLj4d8N7V71Pe
	 rzQGSU+maNXiw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD0vqsE2995411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:00:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:00:57 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:00:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/12] wifi: rtw89: more improvement of STA + P2P MCC
Date: Tue, 10 Jun 2025 21:00:22 +0800
Message-ID: <20250610130034.14692-1-pkshih@realtek.com>
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

When MCC is working, scan operation should be extended on scanning channel
and back to two OP channels interleavedly, and handle scan abort, issuing
nulldata, and scan time to coordinate multiple channels operations.

More, update firmware H2C command format for MCC. Update the frequency
of received packets by MAC ID reported by hardware.

Chih-Kang Chang (11):
  wifi: rtw89: mcc: update format of RF notify MCC H2C command
  wifi: rtw89: mcc: correct frequency when MCC
  wifi: rtw89: mcc: adjust beacon filter when MCC and detect connection
  wifi: rtw89: mcc: stop TX during MCC prepare
  wifi: rtw89: TX nulldata 0 after scan complete
  wifi: rtw89: mcc: adjust TX nulldata early time from 3ms to 7ms
  wifi: rtw89: mcc: enlarge scan time of GC when GO in MCC
  wifi: rtw89: mcc: clear normal flow NoA when MCC start
  wifi: rtw89: mcc: use anchor pattern when bcn offset less than min of
    tob
  wifi: rtw89: mcc: enlarge TX retry count when GC auth
  wifi: rtw89: scan abort when assign/unassign_vif

Zong-Zhe Yang (1):
  wifi: rtw89: extend HW scan of WiFi 6 chips for extra OP chan when
    concurrency

 drivers/net/wireless/realtek/rtw89/chan.c |  94 +++++++++++
 drivers/net/wireless/realtek/rtw89/chan.h |   7 +-
 drivers/net/wireless/realtek/rtw89/core.c |  73 ++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  17 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 182 ++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h   |  19 ++-
 drivers/net/wireless/realtek/rtw89/mac.c  |  66 ++++++--
 drivers/net/wireless/realtek/rtw89/ps.c   |  24 ++-
 drivers/net/wireless/realtek/rtw89/ps.h   |   3 +
 9 files changed, 431 insertions(+), 54 deletions(-)

-- 
2.25.1


