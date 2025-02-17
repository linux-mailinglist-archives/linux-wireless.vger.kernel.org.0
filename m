Return-Path: <linux-wireless+bounces-19043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A1A37BA0
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1113A6E67
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FFC18F2C3;
	Mon, 17 Feb 2025 06:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CumFsBmk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0618DB3A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774636; cv=none; b=BOPo15aM2J7bo9ZcrWi4JNR4MTzTOZ7QDNfiqMmdlls6lIUhW4z+omfrJwjHvF6vKvQ5KkUVzgR8k8rtmiA9x4QQcPdlm3AUQNpJ2oDESDoIPGGZ0ZD3rMCGB45tTaWosJXTz9ACLdfULh0rO31GAm9G8Opyo/Dq3ocIBFxggBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774636; c=relaxed/simple;
	bh=Wh2FuFkZt4vTFoUPAluaLNxcGmbUJhAFczQsKgt0rIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dXk8W5TzvbfLZtPZdKue6bqON6lr9FO5YksSbYjeTGVMbuSZpH1HVtVqYwRY8PY6o6WehuIZRagYqLEbjlUhCk3LfIc8ONtLBQAeeas0TGJaJ71m0PEVC9ay3YDH/S03LQY7b6iRVTqzNG8ylszYc2HpoDsM7KU7xOAHXVgUb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CumFsBmk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6hqClB2646640, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739774632; bh=Wh2FuFkZt4vTFoUPAluaLNxcGmbUJhAFczQsKgt0rIw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=CumFsBmkK0R5b0xoXziStApK1EZkp+KxsRUDwYx+0XQP6h7SBtMyqfPWLYN5duMra
	 f/sQzxLMQcZ05FkZCIOHBy2DnKsxvgiN5EF3asfR0vifDpj+2JklmlHClGiidwepMp
	 pHkrzDjxmeP38Y8KL9KpFEu1QM6+QEYSq9nWWNANzY9M5aFloKWygI2WF9qK/jHXJY
	 JdLg62FF3fy0q6BsSt6t+WJZczPUjcC2mMo8VAxREep2CF5Ndv47CPxhyV0rSEJbtv
	 36yKXYg/jAVrMwr8b7GSGl+DrfqTF4+FeDp1stmEQYNCeJaAzuj9AU8w+4KG3cbvq3
	 j1Z7L3ab9cPUg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6hqClB2646640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:43:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:43:52 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:43:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/5] wifi: rtw89: fw: add firmware blacklist to avoid obsolete secure firmware
Date: Mon, 17 Feb 2025 14:43:03 +0800
Message-ID: <20250217064308.43559-1-pkshih@realtek.com>
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

Considering weak or flaw firmware is not safe. Refuse using obsolete
firmware on secure chips. Add and update a blacklist in driver, when
a firmware is considered not secure.

The remaining four patches are to refine firmware codes by the way.

Ping-Ke Shih (5):
  wifi: rtw89: fw: add blacklist to avoid obsolete secure firmware
  wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
  wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
  wifi: rtw89: fw: add debug message for unexpected secure firmware
  wifi: rtw89: fw: safely cast mfw_hdr pointer from firmware->data

 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 91 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       | 12 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 9 files changed, 100 insertions(+), 11 deletions(-)

-- 
2.25.1


