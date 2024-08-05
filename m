Return-Path: <linux-wireless+bounces-10946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7B9477DC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0F5B22387
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BED14A609;
	Mon,  5 Aug 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IzvKpBz/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36E1514E1
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848463; cv=none; b=Rhmjj4ohytKRXYCN/cyb+ERMMTPvLgSrT8xrvdjRuPySV8Xhqigekl6JK6c8KPXMLdCsOIU4L0aXUz3OJu5AGEjLVL29wxWIMdMq10oKMjamAZnJ1u5SmWDa4hqtO013CdqaVlgzQZwUXdzfi8buqqDypQ8ecNNbKARhAzN8fkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848463; c=relaxed/simple;
	bh=Xi3pdGHWKdDdAyvTVwZZ2c+DVnQ3O+1ZemnwdTlznkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PcSJIVWevYAmZhyAgObKvNi1K2Ad5YiuJpF8Q4i591KbGMvUukq+u/iWgNulwxaKZCVKdjgMiXnfo4fXKglTL9ZqNbgAyp4Elv/Riz/D/3X5cRbA3LXyPDRc5v+qWGHWI41zXlLT6+7rtW53MPMF3m813aOcgBUfc2ZOdcc6TdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IzvKpBz/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47590vbB63834716, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722848457; bh=Xi3pdGHWKdDdAyvTVwZZ2c+DVnQ3O+1ZemnwdTlznkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=IzvKpBz/2pR7PkYTJGIJvLnwXYqZ7KGiGrgsYduSZvBCfgFo994z5FnV1NFMkpDRP
	 hJBHmcVCPhBvxOhOxv7gvBFj8UjUGnLlbx3+6QCHVwvb8HJ76gbhKOodXPaBfLajtc
	 7yW+o3PBvtP57MHYH6HfkjNfCHuAtY2WIAenHTJRLbfZXR2jRMgKcOjm5MwDcAxyQj
	 aYf0yJsbJBnUCzXMXhYtKchR3a822rwl9szSlGQJgVWSuEiwRsAWQBntHXxg/zcXL+
	 B2g/CgxrVpXZ04XtCpukYuGueWpcL6s5isecDdGNvbq4rk/Kz0BWqbwbOW0m6W17Jf
	 Fags47GeBoDJA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47590vbB63834716
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 Aug 2024 17:00:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 17:00:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 Aug
 2024 17:00:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH 0/5] wifi: rtw89: wow: support net-detect
Date: Mon, 5 Aug 2024 17:00:23 +0800
Message-ID: <20240805090028.27768-1-pkshih@realtek.com>
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

Add more one WoWLAN feature net-detect, which firmware scan periodically
and wake up system if given SSID is found. After this feature, we are
going to update firmware so update firmware format to v1.

Chin-Yen Lee (4):
  wifi: rtw89: wow: implement PS mode for net-detect
  wifi: rtw89: wow: add WoWLAN net-detect support
  wifi: rtw89: wow: add delay option for net-detect
  wifi: rtw89: wow: add net-detect support for 8852c

Ping-Ke Shih (1):
  wifi: rtw89: 8852c: support firmware format up to v1

 drivers/net/wireless/realtek/rtw89/core.c     |   1 +
 drivers/net/wireless/realtek/rtw89/core.h     |   7 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 337 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  56 ++-
 drivers/net/wireless/realtek/rtw89/mac.c      |   5 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   8 +-
 drivers/net/wireless/realtek/rtw89/wow.c      | 337 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/wow.h      |  23 ++
 10 files changed, 689 insertions(+), 91 deletions(-)

-- 
2.25.1


