Return-Path: <linux-wireless+bounces-29752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3DCCBD178
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 10:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1CE302B10C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F3313525;
	Mon, 15 Dec 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sVXJu8nD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AC2459C5
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765789031; cv=none; b=uN4+fJDotPF9ZY6YMJAOaaHVWG3uxrDEvKr65vDrc4ICrKq5JQh4gKY2WiNT7cchIBximuhvdpp3vpygors3esuwCXBFPEPdd82wDvPUN/rl+q1TP23aqDKj8ZGs6gBMiosCEdmYh1liYWarVdDZm5BerRwJr4PruabOeP3AgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765789031; c=relaxed/simple;
	bh=1OgMoV7lTB5fj8MssFhDJJ4sAJiuePEmult3UbCSpkA=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=K2ZH1tvVKDjTI7YIMHIUI96tjcIcP4iqBF+N2q1MXqw5UN0vpeVEzwcIK3jmzc/8YIrqQjb1JzNG7xJhKE/mYYM3FqDiXuPSNPHZmc1B9FziQL7n7t5S6Oc4BW3IZO8ZxujmhExtCKBKuu202lH9zRNECFxc/goH9qFuOFwxMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sVXJu8nD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BF8v5uO51507803, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765789025; bh=j0/nY0eYVlXt7SM1PdR9chxwEyJ1oxNzTMGLSQKGQOU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type;
	b=sVXJu8nDapVbaUXX1m7BApmwyHSNasCdErx+LgmxSZQ1HAmsRc5QGiZUC2//ddRCu
	 oAAcPmAYxGKAMo8sIauYv28Ev8VCY+WYzg/M3c57Ggz2zS0ynRT/VE9r+J3XkSXKeB
	 0TAXF4aKc1W3HGwTmxZrjvf4geFG+6BpwQdXJC7s4PuA/4pEvMzHUmPzX40i4TGEXk
	 Hvqju5PLy1cqz10iyWhnWDXDX/lVMTjnIp7BfC47NkLIgb3nRuhzjTVmPcPBr7h9wt
	 T5ccrN+cf0LaSdQhd1bVaFi3QKMB0wUEtkrn1W8BWtzSXrwM9ta+JmG4f/VsnyvqSE
	 BdscPjATaEk/A==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BF8v5uO51507803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 16:57:05 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 15 Dec 2025 16:57:05 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 15 Dec 2025 16:57:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw fixes rtw-2025-12-15
Message-ID: <d2da38e4-2c6e-45ea-867a-11e3ddf44e71@RTKEXHMBS03.realtek.com.tw>
Date: Mon, 15 Dec 2025 16:57:05 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

A pull-request of rtw fixes to wireless tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:

  Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-2025-12-15

for you to fetch changes up to 0ff5e81e1518868286d7a1cda192c23db3110b7c:

  Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users" (2025-12-15 16:48:47 +0800)

----------------------------------------------------------------
rtw patches for v6.19-rc1

Fix two regressions of rtw88 and one existing issue that TID out of range
in rtlwifi.

----------------------------------------------------------------
Bitterblue Smith (1):
      Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users"

Morning Star (1):
      wifi: rtlwifi: 8192cu: fix tid out of range in rtl92cu_tx_fill_desc()

Ping-Ke Shih (1):
      wifi: rtw88: limit indirect IO under powered off for RTL8822CS

 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 3 ++-
 drivers/net/wireless/realtek/rtw88/sdio.c            | 4 +++-
 drivers/net/wireless/realtek/rtw88/usb.c             | 3 +--
 3 files changed, 6 insertions(+), 4 deletions(-)

