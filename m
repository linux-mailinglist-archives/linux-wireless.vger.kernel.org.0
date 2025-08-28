Return-Path: <linux-wireless+bounces-26835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC54B3AC8A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 23:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7646C1B2775F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 21:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BADD293B75;
	Thu, 28 Aug 2025 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rYvs4/pU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FA27EFEB;
	Thu, 28 Aug 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415585; cv=none; b=Axya2twpsg6/K5a/k16N8XmoJsXjEBA57hC9ExqT7hjGZJxmfKm887rBuF5fEXMg1qjeWUcUmMbQsNvvNvWfc1RbqvwJJZQYj1p6V7NtOKszdT9iNmUBZLQ0Rgblla1S1q/pRNx5OfL0Uitu1YS4bNdI/U+6/yd1W70xA0FgIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415585; c=relaxed/simple;
	bh=PUcf8NcS3nWbY79efhChohbxyp+uiXP2iemVLTAQVJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZN8yOJ2D1xdkKK3CmuyvZNhU648KFWnJFK0o2ZUBAYKxfSNeKWWFjmTp+a71Tr0VWuddIKQhStqV1wxGvYVowmoAhXAIcbU2LJViQBsqHWHrbGYflrCUXBRnWeE8+JgygUqi+bZCZk5N90H+Zra6Om9tGI2Fy05VzPH4E82u9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rYvs4/pU; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1A48B40A3268;
	Thu, 28 Aug 2025 21:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1A48B40A3268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756415577;
	bh=KIKoS/QYT6bCkaD2RiPgFZxYY5a9WgBLGHB9nXt1JlY=;
	h=From:To:Cc:Subject:Date:From;
	b=rYvs4/pUBJ43njTzrqvL4+r2gdw3B9qyy8LbnHWFVZ9sEWIYDxY0Ktrf5hxrgulBJ
	 ch5ZIm+8Z/CIFSUH0FqvbIigHsAIKR0QSt5MOeV45RaGpTABG9Gq/YpxuwyGF1IqCf
	 qnTKozTmtgrw5tboUWpQrVEugpHdByU/gkbAT/hc=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Po-Hao Huang <phhuang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw v3 0/5] wifi: fixes for rtw89
Date: Fri, 29 Aug 2025 00:11:56 +0300
Message-ID: <20250828211245.178843-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: - further improvements for fix for use-after-free in
      rtw89_core_tx_kick_off_and_wait(), see changelog below --- in the patch
    - add patch 3/5 for USB case

v2: https://lore.kernel.org/linux-wireless/20250827120603.723548-1-pchelkin@ispras.ru/
    - rework fix for use-after-free in rtw89_core_tx_kick_off_and_wait() (Zong-Zhe)
    - add patches 2/4 and 3/4 for another issues discovered while reworking
    - use rtw tree instead of rtw-next

v1: https://lore.kernel.org/linux-wireless/20250820141441.106156-1-pchelkin@ispras.ru/ 

Fedor Pchelkin (5):
  wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
  wifi: rtw89: fix tx_wait initialization race
  wifi: rtw89: perform tx_wait completions for USB part
  wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
  wifi: rtw89: avoid circular locking dependency in ser_state_run()

 drivers/net/wireless/realtek/rtw89/core.c | 57 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h | 38 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/pci.c  |  5 +-
 drivers/net/wireless/realtek/rtw89/ser.c  |  5 +-
 drivers/net/wireless/realtek/rtw89/usb.c  | 36 ++++++++------
 5 files changed, 105 insertions(+), 36 deletions(-)

-- 
2.51.0


