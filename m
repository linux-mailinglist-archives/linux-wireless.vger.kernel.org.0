Return-Path: <linux-wireless+bounces-26614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E692B357AA
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F4494E3F0F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E002FDC24;
	Tue, 26 Aug 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i/D2xs90"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B10227E82
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198381; cv=none; b=mEpET8FYlELhXSf1TgdG0o/2j3M+MVzDwbItkpg2HiLynjOGJFej5hW0fbbGB+1z5jCxvTAZ31irSCNB7ScZN4aP0mrRX2s4VD9/Hf6LAUOk2o9uQpMv/o8tPjbXbTwGs2Brx147x0qGckKwOqtP2kAyOJvLtYP/DbEGA1MNA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198381; c=relaxed/simple;
	bh=WK/AidBLM3M27bIiiDMF7ajtYtPYfh8iKUWgsSPLLmc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CsuE9ObYq2nkP4sqGd+wxVvQBbjqKZMCX9Jku1BD87ENNSTc+N6GJ7jjMIakcMyo8Zbgy/ZtHgpq2GXPWqt2ectHMyAA0xMVH734IlsDibO/COIOg4JkaOwEoL9grBwwVsiI/YUmcwU+ZyTB00y1sWw9wbt9ZpdDwTI7+iocuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i/D2xs90; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8qsQuB1261919, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198375; bh=cAS099hFgvInY7+EzqtwY1vTzxjHSQP35taBSkf/nrA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=i/D2xs90vj+e+hksaWvJT2gI9xLX4XKUkssYdaAZiUtJvdYugV9lqSfN42PoHTeRi
	 DrWnPsbvv1gLdn743uNmrh7pLtDzsIgNAUH78RcVWPUnBNzk07FjX4jJtqveN6dTqS
	 U2z9QrCXP0bXC/BWuDvy2zlRNHvqovLVD2cfpatMruFONzeI2flysGluMg5jCYOeNr
	 Luz/sAQuCQTRZt2b4zGvJC0L6G/LnWXjPXLvLw1xc9hsHSLsCyZ4PbaKqBa8wQuSvK
	 UTvXeQs7en8DQa//4IsW3k/c4FzL1c40kzH2xypMkm36MlL7EnP2JRbr5g7e0VznTr
	 nDT/mq9xW2DDg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8qsQuB1261919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:52:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:52:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:52:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 00/10] wifi: rtw89: adjust PCI handle for coming chip RTL8922DE
Date: Tue, 26 Aug 2025 16:51:42 +0800
Message-ID: <20250826085152.28164-1-pkshih@realtek.com>
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
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

The RTL8922DE is the next WiFi 7 chip. Because of changes of PCI interrupt,
PCI TX/RX buffer rings, TX completion report and DMA channel, use this
patchset to adjust PCI handlers accordingly.

Ping-Ke Shih (10):
  wifi: rtw89: pci: move chip ISR definition out from chip generation
  wifi: rtw89: pci: prepare interrupt related registers and functions
    for 8922DE
  wifi: rtw89: pci: use RDU status of R_BE_PCIE_DMA_IMR_0_V1 instead for
    8922DE
  wifi: rtw89: pci: add struct rtw89_{tx,rx}_rings to put related fields
  wifi: rtw89: pci: define TX/RX buffer descriptor pool
  wifi: rtw89: pci: add group BD address design
  wifi: rtw89: pci: abstract RPP parser
  wifi: rtw89: pci: add RPP parser v1
  wifi: rtw89: abstract getting function of DMA channel
  wifi: rtw89: add getting function of DMA channel v1

 drivers/net/wireless/realtek/rtw89/core.c     |  68 ++-
 drivers/net/wireless/realtek/rtw89/core.h     |  11 +
 drivers/net/wireless/realtek/rtw89/pci.c      | 451 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/pci.h      | 119 ++++-
 drivers/net/wireless/realtek/rtw89/pci_be.c   |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8851be.c    |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |   4 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |   4 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |  37 --
 18 files changed, 581 insertions(+), 153 deletions(-)

-- 
2.25.1


