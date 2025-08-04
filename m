Return-Path: <linux-wireless+bounces-26108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4707DB199CF
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 03:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2683B0566
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 01:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8961E9B3A;
	Mon,  4 Aug 2025 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BZnELL+P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892829A1
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270625; cv=none; b=aWrJrDLbwmxNVq/YqoXvj7APnzmXgIBl1fVoHix3FHFwG3YEAOzGArO54hR6pv7178iVZTh/fFer+rY4xY9Cb4gOF362Xz2sfdS9lDGYZ4h3eWeIM9BVFlw1HhyYzHkQg6eEdnKa9IsIpL+ZZ4jwT0zZEHQJ9Eg6dAL/4ZDIDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270625; c=relaxed/simple;
	bh=ZitirlSsQANY6t3x7thDMaC10Ip+3Ne8gJYNksv3dog=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fX6agIfPMA5TQFnnp8MA5bhPJb5bn0Iok1kvNlGt28RuQps50CiZSw4bPKp7hjP34FsNSOk3eUgues9N7RWXTo3QtLOw8GPOhX2VYDr7wCa8sRQ2nRMS9VrVSl9pHGmeDmkIFzzw2NJ1SLnzWuqTPJn3fMxAqKmPWXPSSy9LGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BZnELL+P; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5741NGcuC3190077, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754270596; bh=3VwCz/v1c6MJndp+h2zt7m0+N1ao7CAV+Gwj25wbIM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=BZnELL+PcL5TAvgFhYbWw7hcx0GksHikV9xXSLhhBCyxyvJE4TbpZr+LSWM95Gn2d
	 bEPBHvOMGyIURp7GmKdyr0sygyvuV94jyoO+QskpRy+g0Xmjx0sgBX2BMvKa5T3Qz4
	 Df8HvHCycIzutZ7PHx9s2D+SzXBe/YPsgIbx6OqrZQkBrFd4VzjtDJ4OUW2eyM3GY0
	 mTt7LSDi6fJMXqJqHWOdb8ne3gS+UDvWRgYkdZZ8w1rBNR/gSFlnRh6yaFXkPl6jwm
	 cEG7MgRxLUzYcv2EQdLf1wJ4ClAB3Qv6QINFrVBGnZI7Z/LQTMFelzpZYievqEsHmm
	 tZ8yQn5L6aFaA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5741NGcuC3190077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:23:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:23:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 09:23:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>, <sean.anderson@linux.dev>
Subject: [PATCH rtw-next 0/2] wifi: rtw89: only print once for unknown C2H events
Date: Mon, 4 Aug 2025 09:22:32 +0800
Message-ID: <20250804012234.8913-1-pkshih@realtek.com>
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

The unknown C2H events are printed once driver receives, causing thousands
of messages. Since this is only for developers who must implement the
handlers during development, to print once is enough to be a hint. Also,
to avoid somehow missing to implement causes messages to users.

Ping-Ke Shih (2):
  wifi: rtw89: print just once for unknown C2H events
  wifi: rtw89: add dummy C2H handlers for BCN resend and update done

 drivers/net/wireless/realtek/rtw89/debug.h |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c   | 20 +++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/mac.h   |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c   |  7 +++----
 4 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.25.1


