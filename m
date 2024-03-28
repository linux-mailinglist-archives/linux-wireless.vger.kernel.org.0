Return-Path: <linux-wireless+bounces-5423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE888F738
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 06:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D31F25B9A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3923FE22;
	Thu, 28 Mar 2024 05:28:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFE2C19B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603705; cv=none; b=ZMHM0gafTsoKqOzzVrNlt2AEczgEHP6aD75bcHHlXPsfoZqveFwIg4uy4V8XUH2LCKP4wv40JhQmzbQsxMmRaB/JAqvO0t0f++9ehXvcufcomIYzk7h3YCSIhnLobcER2GFdqBH3/NvkZUVgnF6Jb5dB8NGnAWxH8MbKC1BGu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603705; c=relaxed/simple;
	bh=Jsj8SFa42NVbgDypUJ58Vi/PYKBZoZ33sK3ivc5baw8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KbBoOEdBN7/xEe0sqsnHAaGUFvZUpFDf+DcI3/U3IGESX8i56wCnOiYaLBoEPBkMHhnm5amQRrnwTqmzEYe2U6BK4stUMqyGxOEnhPrKvmYE9l6Z78A9fe3IzDGudbQ7T52OElNZ3f4dYxaVH+kIBXlP8MrxsfPL3sZ3cPv9a7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42S5SJ3401958911, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42S5SJ3401958911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 13:28:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 13:28:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 28 Mar
 2024 13:28:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH 0/3] wifi: rtw89: 8922a: update 8922A settings along with current firmware
Date: Thu, 28 Mar 2024 13:26:53 +0800
Message-ID: <20240328052656.18823-1-pkshih@realtek.com>
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

We have sent 8922A firmware 0.35.18.0 as the first release, and this
patchset is to align the features of the firmware, including command format
of scanning, probe request template for 6GHz scan, and beacon filter
support.

Chih-Kang Chang (1):
  wifi: rtw89: 8922a: update scan offload H2C fields

Po-Hao Huang (2):
  wifi: rtw89: 8922a: download template probe requests for 6 GHz band
  wifi: rtw89: 8922a: add beacon filter and CQM support

 drivers/net/wireless/realtek/rtw89/core.c     |  6 +++-
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 29 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h       |  4 ++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 9 files changed, 37 insertions(+), 8 deletions(-)

-- 
2.25.1


