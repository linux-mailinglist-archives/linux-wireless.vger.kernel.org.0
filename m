Return-Path: <linux-wireless+bounces-1739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BED82B319
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D72A1F21CE9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46624F8A1;
	Thu, 11 Jan 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4eOAst4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7/8W8d2j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D64F8B9
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704990995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JCVDYHPyhJKZKWC2GUVEgh2eqzUsoKdVv+V1GpsjV+M=;
	b=J4eOAst4veBuvhU0P7aCwC9XqubsGznuJEW7NOyDhFn7gx6dBRc9QLiBwWCE8G0RVC50JB
	/evb1XYkhnKrnbMoyogSKiiPVjukpEFaMa7gjM1pa9dYTJSePnc5kIhtfjUXDWanDegFN+
	S8/XEXukOmjqDG8JLizb9WK9165lt+rfFTpe6kTGIb4Ry2CKDPit0NfKGoG8SdB1NLYht9
	mamiLt1YaFb7ekXDP03t8Pt5QpU8kcGZfpROaM4OausWtfg1KMh8yWONdZEdxxlKPuAwF4
	5h3yoDihY0kPsto0gE8iVqcPmApRo/rd7wdI1eSJPRqd5tjViNzZKtIUi5evXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704990995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JCVDYHPyhJKZKWC2GUVEgh2eqzUsoKdVv+V1GpsjV+M=;
	b=7/8W8d2jxaac3nUVp08iIzhSK1kkHj46585Thxv5wLQMdYlGqzgVamkyFpf6iio5olABrT
	ZXQ1PeBxX+LhtgCQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 0/2] wifi: rtl8xxxu: channel switch support
Date: Thu, 11 Jan 2024 17:36:26 +0100
Message-Id: <20240111163628.320697-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes v2->v3:
- add cancel_work_sync() for c2hcmd_work
- add cancel_delayed_work_sync() for update_beacon_work
changes v1->v2:
- use delayed_work instead of usleep_range

v1: https://lore.kernel.org/linux-wireless/20240108111103.121378-1-martin.kaistra@linutronix.de/
v2: https://lore.kernel.org/linux-wireless/20240110103909.240514-1-martin.kaistra@linutronix.de/

Martin Kaistra (2):
  wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
  wifi: rtl8xxxu: enable channel switch support

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  2 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 20 +++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.39.2


