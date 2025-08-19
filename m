Return-Path: <linux-wireless+bounces-26443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC46B2B7EA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 05:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0273A797D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 03:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816023741;
	Tue, 19 Aug 2025 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HiBiODR9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF19BA4A
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 03:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575132; cv=none; b=CameLvwpiJMp+mRflDRDd5OibKNMGwAvC70Oe2UnfyxIZ+5qiqTqDvmczuYCSUYNo/CMuqnh6TQqyVNZ9L1X89cWX/zi7jOlv/fiL9BMqsDD4PPl5gvI+QkU1yuoKy+wfqQHGOT/eSXG76WYWXAztF75Sr42ejt4Lwh8LS9XDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575132; c=relaxed/simple;
	bh=5KNuYX1suTC/zQllKE6yro0Gr/TMZBNaBcq1o7WZjRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qhU0t480DmWz4BYpD7nsUfGo1BpE57rGHINa02eM/omXlqBFaYJgSktuP9gB30CxsFPZWpyHNt03v1ICWUrmBEEue8vN30VDX+n8yUHVY/DN+kLgjvl0gjnWrXxNiMIsNErasoi/ybFU5tu8MfB3dtzvucj50TpyB3Uds3PKYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HiBiODR9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57J3jP9t92064790, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755575125; bh=cK1FReMMxURuhNYbLrKTEri6773dGyB2GmTXh4sQDp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=HiBiODR9sFPEffoQ4e32IpU5PVXnWHO581v1EnVzpgHvsVKqrsRnXli11VSoFTU5t
	 uujbwDZRAJtVCVjUwpbXhQh59/7Ar0HxWsuHSPrvM39dMt0B72yd1eZFnwkLCVWwaW
	 lkeU7jWntnitNLDINrhk/T9kytN+tTsi3TqrDXwLJdTxZ/AhZ2+Ol49TI6M4IkPCVx
	 NKRfucy+6yf84uGz7HonrXiBbPGJpqJ5I0jtgbBZY8gLU8pRisOQoM8tuzwSk/dOt+
	 Ck+B9DdEk3shWZGrbqxv6lwnfV0dtI/P3m1BqZpmMLP4UZNcD2LPcdH9rqU3xCKQML
	 la/2GZX9YL3Uw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57J3jP9t92064790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 11:45:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 11:45:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 19 Aug
 2025 11:45:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 0/4] wifi: rtw89: report per-channel noise level to get better user experience
Date: Tue, 19 Aug 2025 11:44:24 +0800
Message-ID: <20250819034428.26307-1-pkshih@realtek.com>
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
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

First two patches are to add feature of reporting noise level, so
supplicant has more clues to make decision when doing roaming.

Third and forth patches are to update firmware feature and BT coexistence
parameters by the way.

Ching-Te Ku (1):
  wifi: rtw89: coex: Limit Wi-Fi scan slot cost to avoid A2DP glitch

Ping-Ke Shih (1):
  wifi: rtw89: 8852c: update firmware crash trigger type for newer
    firmware

Po-Hao Huang (2):
  wifi: rtw89: 8852a: report per-channel noise level by get_survey ops
  wifi: rtw89: 8852a: report average RSSI to avoid unnecessary scanning

 drivers/net/wireless/realtek/rtw89/coex.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +
 drivers/net/wireless/realtek/rtw89/core.h     |  22 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |   4 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  35 ++
 drivers/net/wireless/realtek/rtw89/phy.c      | 306 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |  20 ++
 drivers/net/wireless/realtek/rtw89/phy_be.c   |   9 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  42 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  45 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   3 +
 15 files changed, 497 insertions(+), 8 deletions(-)

-- 
2.25.1


