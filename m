Return-Path: <linux-wireless+bounces-21593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA45A8B306
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A871904910
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FEE22F15C;
	Wed, 16 Apr 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="FL5DGq46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F9158520
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791206; cv=none; b=h9JR7Md2th+XuQi/qpZKkKEnepBJvZvzRmvKEUiS9aPYDdYnWhRuh+x5cctIViwzdBVt4u+M9WMZAlyyv2NpuV2/XL20q1WJ6Rba2ebv6UkLK+/pJmdiUfikKaZHYBClrKwnmZ/B0Moqroq3qYq5nReucsUUrec1WeKFPjJneYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791206; c=relaxed/simple;
	bh=9jC532QOyxtEPWJ/M3uGdXXTAnzDkhtsd+bIkUmStrk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HXsDtMOPtsnQ7F+uIUiBU/PS7ZAJXfN77of+kFwgOa1jyE10/6y9bqEdDK1rvVWjt900/Q5NZ84ggn2oqugsYgZm0xr6urZP1JphY32djS0q6NGVBHmSBiue1R93U2+lg1L6L55WHdgZTwIECJLOcZ1+4oUfXK9HDe9EU4wmPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=FL5DGq46; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G8DDOE02935195, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744791193; bh=9jC532QOyxtEPWJ/M3uGdXXTAnzDkhtsd+bIkUmStrk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=FL5DGq46SiRt6lQbqk74caH/m/858zvYEwPOcGD3lke8nT33TM4zoM0yFM+Bfe0fZ
	 NQF0I5BGgerr19MebBi4tlA6NTCdAOCMAV5fkEDHwhy74Y5b7OjZwnS9J7xgWx5YJR
	 en1wMurk307yVn1hTECweRujpVyRkn0bgUhS1uxAKapUZhTYu8YN62i9aQx6suaPDE
	 Nts7A1NetRp6AEq5Ba04XxcWy4yuSbI/saoGb014ybTxDwLLWK0kirYnK6rIOdIzxV
	 4lpFzyucwRNt+cdzGvVeQG95/BcM0EOvN8lfpKippajmDZzzheKY0WpPXUF6VCXY7U
	 5AmCKlzq5RiTA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G8DDOE02935195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 16:13:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 16:13:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 16:13:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/4] wifi: rtw89: update 8852C firmware format version 2 and etc
Date: Wed, 16 Apr 2025 16:12:37 +0800
Message-ID: <20250416081241.36138-1-pkshih@realtek.com>
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

First patch is to update RTL8852C supported firmware format to 2. This is
because firmware v0.27.125.0 uses new format that old driver can't
recognize, so increase format number to 2 after the firmware, and only
the latest driver with this patch can use the new firmware.

Patches 2/4 and 4/4 are to correct settings for field issues.

Patch 3/4 is to limit TX power of UK under regulation depending on
platform certified.

Kuan-Chung Chen (2):
  wifi: rtw89: 8922a: fix TX fail with wrong VCO setting
  wifi: rtw89: set pre-calculated antenna matrices for HE trigger frame

Ping-Ke Shih (1):
  wifi: rtw89: 8852c: update supported firmware format to 2

Zong-Zhe Yang (1):
  wifi: rtw89: regd: indicate if regd_UK TX power settings follow
    regd_ETSI

 drivers/net/wireless/realtek/rtw89/core.c         | 13 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h         | 11 +++++++++--
 drivers/net/wireless/realtek/rtw89/debug.c        |  3 +++
 drivers/net/wireless/realtek/rtw89/regd.c         |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c     |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c |  5 -----
 6 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.25.1


