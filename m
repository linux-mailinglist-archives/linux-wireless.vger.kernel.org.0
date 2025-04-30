Return-Path: <linux-wireless+bounces-22227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D7AA42AF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 07:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B67A452B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E090B1E3DF2;
	Wed, 30 Apr 2025 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LFXYb2FI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0CA1E0E1A
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992367; cv=none; b=qq+ijkHuMIQdn4iOSf+oCD08TzVg65BwKtQIQfEH+iN5rntslkmeZujq/4eseAHzvQa5lD4UDEx09Gfn2fSnrrs6byrwKNmFCKu+RZPQjMhe+uWdklHvI5yE3vtT3m8cI7Z43MTVtUTpyqp2bykLJk4aj8E6v4YXuRrE6xTu0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992367; c=relaxed/simple;
	bh=9ikGD1lcsxZri287c4KcU5LlKpp9izZnFVR6Le1IITw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jixN+pWeRGb8mLCWPquXgQCUw5Cw8Eowd3mqhwURy70B8zoECnZrd3OgAm/Vri7NT4B8ZmBGR1lXAWvJBxa1SunXveKFkGu9/9kzz2N3pG6rWsDvJHMNAZk47ko9pbtqrip08H+aw6ZPH7iSEXFWmfmuHN+a0MjrX9HWk6VZ4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LFXYb2FI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53U5qe1A32508512, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745992360; bh=9ikGD1lcsxZri287c4KcU5LlKpp9izZnFVR6Le1IITw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=LFXYb2FI1lyebnvH8M1E3p/7a/aie84SmSTAOJ3xWySPEhmvwceJUrp0bIbnur1oB
	 4NbKRg4sZh3WGx/2vjQLTt1Qn89i2p6YDJ02VgTn4m1roV2Y9J9Lsm9mNcpJu/laX1
	 IjnNhggb+rHfCRn15pKqWEKI1VaY0w9x/UUrhpcJb6FiwsBR4VmtgqM6+691rn+Kgd
	 NU8y8pgqA/KPqFG2ldi2y0k71CP44vF5cIQvQoRX5v2/0mFyPuC8SH6ujOD0HBYhJV
	 ItT7FxXL4Fqv9cnvNeqSSngbbUdl+NTvMIa/bPhot5CXLuJ0rJvSnH04lXeKRMCGgA
	 cm2muD2xJGExw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53U5qe1A32508512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 13:52:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Apr 2025 13:52:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Apr
 2025 13:52:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 0/2] wifi: rtw89: consider TX power limit of DAG
Date: Wed, 30 Apr 2025 13:51:55 +0800
Message-ID: <20250430055157.13623-1-pkshih@realtek.com>
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

The DAG (dynamic antenna power) can increase TX power, and should be under
the numbers of DA limit tables. Add this by patch 2/2.

The patch 1/2 is added to handle C2H event related to FW scan for new
firmware. The event is to show status. No functional changes.

Kuan-Chung Chen (2):
  wifi: rtw89: phy: add C2H event handler for report of FW scan
  wifi: rtw89: constrain TX power according to dynamic antenna power
    table

 drivers/net/wireless/realtek/rtw89/core.h |  10 ++
 drivers/net/wireless/realtek/rtw89/fw.c   |  76 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  19 ++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 119 ++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/phy.h  |   1 +
 5 files changed, 196 insertions(+), 29 deletions(-)

-- 
2.25.1


