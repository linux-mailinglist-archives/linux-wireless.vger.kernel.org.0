Return-Path: <linux-wireless+bounces-25073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815DAFE086
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 08:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEA3A087C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C19189905;
	Wed,  9 Jul 2025 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AWyfutwM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FA26D4DF
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043837; cv=none; b=ATIJcEoe6nQfJQvj7gSghwjKF5e4FuR4dMix7oCBO8hSZdsQhigaEWB5WLAuy2zvQWLeQJu5sSXaKPNe7S9xzsugxcjIAZ0k4S9GOaawTw9VbrE2EN67Pd/qYa5DTHMNqYGkp3SZAH+BfgAm/GLXIXKcMUMIU0t1xP/UDZ5NL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043837; c=relaxed/simple;
	bh=R0ZIaLIhj25piEeHiy/DPUnZXYpiQrEFA9dam7RSZac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sdwSAKHjcVuHEuokgcDFZ7m2WlzMhH/yZ+7Ai9lvNOGwUYIjF2EGZLEMzPi8k3gGQ7A9fPkxXvEwHFJmkMjti+yDjsJVuUn5ftQ8mrgUZF+MbnnyGT5JpkQj10utE9LRN34oYTIxBwBgDzgoOF4gh6xR4VCDDKYBYlR10gYr3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AWyfutwM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5696oULI1863694, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752043831; bh=xyuz+LAkM4EclrlKoBCRgufqKFmjp7ZYP4f3BWKQy1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=AWyfutwM8Wmu4/4QeF0TntTY3IVWfpdH1oujm9SbaPC/61cSWhoRft7N+66uZCEjm
	 sQ3+36Q9oBvnaUbeTTxDp/BN129zSRU5L6idnUf/4dBF1CSjEu182x5CnLCJHlmrpe
	 u/9QQvPM+Lrjn++xr0JQsQQjCDqQrgUHNlaJfFljR1rL2Pq/YDAMkIy6MP+IyokSJ3
	 vND5WX3QpAw1VB2dSTMxNbaJWoEOhRfOHNQx9d4Laml+WuimJuUxBzUB6s1rRYRClJ
	 tQdxp5DioOi3FcSnVuWDQDO+sOsd6tYlcHK/cS4qcOuRtQFd96qCu1TwD7CTfzH80j
	 HwQoMQHBjQZRg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5696oULI1863694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 14:50:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 14:51:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Jul
 2025 14:50:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/4] wifi: rtw89: parse and apply ACPI DSM functions
Date: Wed, 9 Jul 2025 14:50:02 +0800
Message-ID: <20250709065006.32028-1-pkshih@realtek.com>
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

The ACPI DSM functions define some regulations used by Realtek Windows WiFi
driver. Since rtw89 is also working on PC platforms, follow these settings
to have the same behavior.

Zong-Zhe Yang (4):
  wifi: rtw89: regd/acpi: support country CA by BIT(1) in 6 GHz SP conf
  wifi: rtw89: regd/acpi: update field definition to specific country in
    UNII-4 conf
  wifi: rtw89: regd/acpi: support regulatory rules via ACPI DSM and
    parse rule of regd_UK
  wifi: rtw89: regd/acpi: support 6 GHz VLP policy via ACPI DSM

 drivers/net/wireless/realtek/rtw89/acpi.c |  95 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h |  33 ++++-
 drivers/net/wireless/realtek/rtw89/core.h |   1 +
 drivers/net/wireless/realtek/rtw89/regd.c | 149 +++++++++++++++++-----
 4 files changed, 242 insertions(+), 36 deletions(-)

-- 
2.25.1


