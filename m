Return-Path: <linux-wireless+bounces-16929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3419FED27
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 07:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871143A2AAA
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CF1547DE;
	Tue, 31 Dec 2024 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Bf+6ePyN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F31662E7
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735625439; cv=none; b=a0bFUYDhdOzvKm2I4/xiETtqfRtzXx28gApzhCO8dgzdJQccu1OK9ILPYkrR8pQ7sqCXrEYQr6wYRYPkWQ3V7Ugn699fWkWHqBkfCBlWWHTJtEJcHkNPlA95CLLFfdUkR2Xdtz7gGGW9LSOh+ToLZIuCE+HIbomILWblbX5ZVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735625439; c=relaxed/simple;
	bh=UhvQK49xzLXTs03bTOnyr3TBGh+M7tbtev7beUiSbrY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDv9pxG7tZstSF3eeBVMrf4nEG4D6Oi41ZROtdb3as2itHZhDx1xiYTKe256+uubYvFTad7j1ySqRm5q1AsMoxP/rP4YXPYOuHcBEFTnBLpBGqEL4JkUNy7FK8h58IKvApiNBPWa8ywzvEDxknnP5/IkzZhrv68kRX1vYk3a6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Bf+6ePyN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BV6AXdqC1172309, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735625433; bh=UhvQK49xzLXTs03bTOnyr3TBGh+M7tbtev7beUiSbrY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Bf+6ePyNoQiRlMEqAyvLuJYv2q9reEnVt2iKHvVdG+KOJ+ChtKmEd8j1ppVCr1Ij4
	 OYk/RlPYkZeYtZfxa9AKsLbIzOT1vpGSI/5jFMk9haGYPMQoDwj4Se1MDdZ0nTrNTs
	 1sBC8zz3wayHLjTYjDXW/1C4/Vz5CjHtXwywfBznRnjLer2UBmsfb8sQAw5n6751BR
	 jQ/jnFi8pR7hq1cJOvNEYSfZoGMVlJFK8J43eGqQBIX3RbUbxO6BD2YzMySCIy3yMN
	 FchdvUIukuB6Zokdsrj1zdKpHfMjoOKS9HVYuW+2WPgxFq/Ek0r6kIh1HCZRb7KJ56
	 ienHKQGMZFksg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BV6AXdqC1172309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 14:10:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 31 Dec 2024 14:10:33 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 31 Dec
 2024 14:10:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/2] wifi: rtw89: support RTL8922AE-VS
Date: Tue, 31 Dec 2024 14:09:54 +0800
Message-ID: <20241231060956.41314-1-pkshih@realtek.com>
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

RTL8922AE-VS is a variant of RTL8922AE. They are very similar and can
share almost all code except RTL8922AE-VS is only up to MCS 11.
Add this chip accordingly.

Ping-Ke Shih (2):
  wifi: rtw89: read hardware capabilities part 1 via firmware command
  wifi: rtw89: 8922ae: add variant info to support RTL8922AE-VS

 drivers/net/wireless/realtek/rtw89/Kconfig    |  6 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 18 +++-
 drivers/net/wireless/realtek/rtw89/core.h     | 13 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 26 +++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 16 ++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 94 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 10 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |  4 +
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  6 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.h |  1 +
 .../net/wireless/realtek/rtw89/rtw8922ae.c    | 16 +++-
 17 files changed, 196 insertions(+), 21 deletions(-)

-- 
2.25.1


