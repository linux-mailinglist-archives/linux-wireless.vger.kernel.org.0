Return-Path: <linux-wireless+bounces-6723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813148AE750
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EFA28D5D3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F5185C48;
	Tue, 23 Apr 2024 13:05:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604778C6E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877531; cv=none; b=Xhnxh+IMw6p5433vk8Kq/tl0G1GoBF8fPGykN0Zbe1P6R823TNWB0aF04ka3vrETljI19KZVM9S0EZ1deP0AS8Pf/GBZH5WNorE5R7rn1oq30q4Ue9FpaKz0eQ5BUfeQDQ9BA8cklJPi+q7v1hgZnektOgyQy9/v26qKxlg0xkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877531; c=relaxed/simple;
	bh=/GOuTZEhQZM1GPp0csUxrPF8ZMYPO4nD1deOqIzA5jk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UU+50bK8lJs/IYMHbZyWnYyYHLJ5aAb36yb7cCfjwmXsDa/NeClb8J1S7HGuj+0+5s3R9loiixTTcbQ6uSH4J+gfp3fQLFWESVxj27czvwBTQ+chTWCFfjKK41QYr5mS35KEmW13XhJk0QTMJdY1fVi4Ou86C6u2lGa7ER457eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND5PZw81251170, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND5PZw81251170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:05:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:05:25 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:05:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 0/8] wifi: rtw89: coex: complete BT-coexistence mechanism for 8922A
Date: Tue, 23 Apr 2024 21:04:54 +0800
Message-ID: <20240423130502.32682-1-pkshih@realtek.com>
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

Second patchset to add new firmware commands/events format used by 8922A
firmware, and then 8922A can use WiFi and Bluetooth simultaneously with
smooth A2DP and HID.

Ching-Te Ku (8):
  wifi: rtw89: coex: Add Wi-Fi null data status version 7
  wifi: rtw89: coex: Add Bluetooth scan parameter report version 7
  wifi: rtw89: coex: Add Bluetooth frequency hopping map version 7
  wifi: rtw89: coex: Add Bluetooth version report version 7
  wifi: rtw89: coex: Fix unexpected value in version 7 slot parameter
  wifi: rtw89: coex: Add Wi-Fi role v8 condition when set Bluetooth
    channel
  wifi: rtw89: coex: Add Wi-Fi role v8 condition when set BTG control
  wifi: rtw89: coex: Check and enable reports after run coex

 drivers/net/wireless/realtek/rtw89/coex.c | 175 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h |  53 ++++++-
 2 files changed, 205 insertions(+), 23 deletions(-)

-- 
2.25.1


