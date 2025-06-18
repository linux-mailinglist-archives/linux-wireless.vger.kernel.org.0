Return-Path: <linux-wireless+bounces-24247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66796ADECF6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 14:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91131883241
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DF32AD18;
	Wed, 18 Jun 2025 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kYbAwB8y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79E2586C8
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250845; cv=none; b=PPxEqad+ISrjwceEyXyJnv2jWEpAqiE/sxLnLuGHtR96hAVzki3spb536AMm5WkHgrGhV3mhNxjnOwFAEy7DuC5DdCpsz72U6CoFq5s0MiFXNE5R6aEKURG2637HBPCBB2ozsy5vul2fGbH4+s0nCwGed3XRCeV9UaswJHHDhsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250845; c=relaxed/simple;
	bh=VkGzbC3oC3t6w68VNr1WWqtzTBe+Rk0qStcp8+bl1s4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0p6Z2RA+A/9FMqmKI8gIT2yJDQxaNC8xhl+TVJBgcGs/JfmHYPsE18+c59wblvtn4iOJhf+JBTMmPjBbi9rc3pnyXnNkWy9SKhaPdAtBvKh8KkxYDhK0SuT/7bo/l4Awq84YsKe+xlE4RUWTtoghHQWU3KpoDiCfQ/VaWY/kVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kYbAwB8y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55IClJx754151142, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750250839; bh=UopYn+D12Qm1WXke0IUjaLeZhdr9KT322qIFUaWbiu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kYbAwB8yy0ElHnz1ks9bfyV4V3TLcUs+GZSm+pEHiC7Zdt4VxKBZA9UUAtbEff2c7
	 tIe/xzdbahcbQNwYK6sJ2hWuC9C1MyLrgiL9qlkPP82dm98O06G2EbWz7NeOqVuoAL
	 EN3No0LPfNiVucDcTBE2oLdLmAZoDKWnRrLFFIPcZhzR5R3Z+kE0kvTqwKNnfCN/5l
	 DN/Vs/AdRLzUv7Gu9iXknzeWh7IBYudYMJitx9ED6/sBSqIqwLsb7JcMbIkr54HER/
	 hQnEXlkvgeYJBLE0DaI3Yxw96IASCuYF1Sg64ohHYgfrvL9IrGlx9IceUeq5QpVVWF
	 zIvy7rf0ZUKkg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55IClJx754151142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 20:47:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Jun 2025 20:47:26 +0800
Received: from [127.0.1.1] (10.22.224.135) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 18 Jun
 2025 20:47:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/6] wifi: rtw89: update debug stuffs and enter PS mode aggressively
Date: Wed, 18 Jun 2025 20:46:43 +0800
Message-ID: <20250618124649.11436-1-pkshih@realtek.com>
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

First three patches are to correct/update registers settings for debug.
Patch 4/6 is to avoid crash for a very very rare case, which almost can't
reproduce. The cause looks like hardware report abnormal value somehow.
The last patch is to enter PS mode aggressively to reduce power consumption
for certain use case.

Chin-Yen Lee (1):
  wifi: rtw89: enter power save mode aggressively

Eric Huang (2):
  wifi: rtw89: update EDCCA report for subband 40M/80M/sub-20M
  wifi: rtw89: correct length for IE18/19 PHY report and IE parser

Kuan-Chung Chen (1):
  wifi: rtw89: mac: differentiate mem_page_size by chip generation

Zong-Zhe Yang (2):
  wifi: rtw89: avoid NULL dereference when RX problematic packet on
    unsupported 6 GHz band
  wifi: rtw89: report boottime of receiving beacon and probe response

 drivers/net/wireless/realtek/rtw89/core.c     | 106 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/core.h     |  20 +++-
 drivers/net/wireless/realtek/rtw89/debug.c    |  13 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      |   1 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |  14 ++-
 drivers/net/wireless/realtek/rtw89/wow.c      |   2 +-
 drivers/net/wireless/realtek/rtw89/wow.h      |  14 ++-
 11 files changed, 145 insertions(+), 45 deletions(-)

-- 
2.25.1


