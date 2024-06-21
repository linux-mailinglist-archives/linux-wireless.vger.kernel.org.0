Return-Path: <linux-wireless+bounces-9359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF67911CEB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040351F22E4B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A8A3AC1F;
	Fri, 21 Jun 2024 07:35:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFC12BEBE
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955317; cv=none; b=QdMSuNnQIHU2mv+xwPn9Cs2bPYM71nEXBGZSO7oydxbDVWuoxr0zT74sB7TaR5rRwSCTayTbNvBuB8yTqUbYj+Rbm0Ev7mAQNmJvkBg+cQdqZvMIeYbJSHnkmTU5Xe+rHeqs63J6mPx88uK1vi9PpjOogLMAoHTY6nvRGBjLdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955317; c=relaxed/simple;
	bh=ssFOPIDbqX8m9SVxrJ53tG9IprYzX0W+hE+ITRH9y1A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lspa8S3Jyb2wnGGbW9Hi/BT4vWEIpdD6bNq4ZUr5Pe+9jujpb5fpZGsGNL+mn3ouHliIhMkdjioBIiP/8NE0lBVuUTMSFX8bZLvRjM9a9aj3BvxtamYvWknZekgsiONTBC6MvakeZpw00fOcU3yysE+Z1jlJo5hEqJLEQmdt6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45L7ZBBH03868842, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45L7ZBBH03868842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 15:35:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 15:35:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 21 Jun
 2024 15:35:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/2] wifi: rtw89: 8852bt: add RF calibrations of TSSI and DPK
Date: Fri, 21 Jun 2024 15:34:56 +0800
Message-ID: <20240621073458.55187-1-pkshih@realtek.com>
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

8852BT needs many RF calibrations and this patchset is to add TSSI and DPK,
which are related to TX power. TSSI is to ensure TX power as expected, not
affected by thermal value (temperature). DPK is to improve EVM for high
TX power cases.

Ping-Ke Shih (2):
  wifi: rtw89: 8852bt: rfk: add TSSI
  wifi: rtw89: 8852bt: rfk: add DPK

 drivers/net/wireless/realtek/rtw89/core.h     |    2 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   25 +
 .../net/wireless/realtek/rtw89/rtw8852bt.h    |   13 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 2540 +++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   18 +
 .../realtek/rtw89/rtw8852bt_rfk_table.c       |  490 ++++
 .../realtek/rtw89/rtw8852bt_rfk_table.h       |   38 +
 7 files changed, 3126 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.h

-- 
2.25.1


