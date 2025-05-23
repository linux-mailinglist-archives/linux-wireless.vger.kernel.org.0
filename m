Return-Path: <linux-wireless+bounces-23341-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8663FAC1CF6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14C7A24A4F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178EE224AED;
	Fri, 23 May 2025 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QukcEhBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE292DCBF9
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981669; cv=none; b=kYQ4j3xHPyOBK1QZvjcl5cGy9HPdhExEcUHZx+DgW8LUeLHSKJzZZZe6VxGGRJtuF6poXP5Gmfaiw9alJ3JwAWWa0XGfJxgwBSCrYukTAqTDvHTJV4cYmwnmBQzcoC8r1vbkX37usw7Nq3ETaaITMwtjo0fLaxYEZ1jqzVx2gD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981669; c=relaxed/simple;
	bh=Xeqwm9AL4Ua4y1NEg0rN3fFpdymt1TuJiA2VdKI0uwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GKfEnghw8X62usKXFH5HEDVF0VtyDA9nvMEPTEZ3/t0DlNBvU3y67HZx/j+rowBJEXbtQe9q3+832SazbTqEbQUQZvP1U22iEv35zZchrKbQMkvVjRzkEJzrmVHxlOVK7O6FD+iopFmUToIDiFHPZ9bHgfJDiaPw8zMxM6P8vpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QukcEhBm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54N6RgIM21769104, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1747981662; bh=BZ/wRG9x0RwQxNx5XJWNtl7mlKyL3QM5Ots1ZMWo2/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=QukcEhBmbnN+e8iGJr3EBfJzOJ/IZM7kCz4oqnqB8untQ0nT8sLvjQ0oygLDtFc2W
	 m8Yc1TzZ7cqTehHmi1bqS06fuCHCPwi4fcifp8a+w/ZOZen4K+Bo/XkPzZKyq+OUHH
	 SAomSvnEc+GZEv9Z7Kf6SIL/OmkPsOdIPPcL4ROfBIqz9qejQEVB8QZIwk0q2g3CkB
	 1L6LXFkLFcToy7Ea3qNs2He9ojHoLVKh8dBV4Rj+mPAyLxi7vlm9Lfk3auXYr8TwRN
	 nq9RvxgQiTMt6quKftOazEQM8W2aVQwUC4i66MeJ0fG/SzaJJOA+rFGq99Wl+9FNz8
	 93+xdhp7G7o1A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54N6RgIM21769104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 14:27:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 May 2025 14:27:42 +0800
Received: from [127.0.1.1] (10.22.225.244) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 May
 2025 14:27:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH rtw-next 0/2] wifi: rtw88/rtw89: pci: add PCIE error handling
Date: Fri, 23 May 2025 14:27:09 +0800
Message-ID: <20250523062711.27213-1-pkshih@realtek.com>
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

The WiFi devices might encounter PCIE error in certain platforms. Sometimes
it can still work, but sometimes it causes hardware or firmware error and
become unavailable for users. Add handling to power on/off WiFi devices and
restart firmware to cure silently to improve user experience.

Chin-Yen Lee (2):
  wifi: rtw88: pci: add PCI Express error handling
  wifi: rtw89: pci: add PCI Express error handling

 drivers/net/wireless/realtek/rtw88/main.c     |  1 +
 drivers/net/wireless/realtek/rtw88/pci.c      | 37 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/pci.h      |  1 +
 .../net/wireless/realtek/rtw88/rtw8723de.c    |  1 +
 .../net/wireless/realtek/rtw88/rtw8821ce.c    |  1 +
 .../net/wireless/realtek/rtw88/rtw8822be.c    |  1 +
 .../net/wireless/realtek/rtw88/rtw8822ce.c    |  1 +
 drivers/net/wireless/realtek/rtw89/pci.c      | 37 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      |  1 +
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 15 files changed, 87 insertions(+)

-- 
2.25.1


