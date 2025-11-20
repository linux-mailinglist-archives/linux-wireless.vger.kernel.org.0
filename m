Return-Path: <linux-wireless+bounces-29151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B61C72210
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 05:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 99E2128C74
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 04:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418471A23B1;
	Thu, 20 Nov 2025 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="u0NKvdzu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AE43FF1
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763611308; cv=none; b=kzFS0XGFk01PfgZtZXmsj22POWL856E2e+oUsL4wy6gQm63EAO50BhH2zGB7o82LJTXS3AlF0y/oSNYB4IARKhWBN4Y6C5rWMfNKSEulmOXgnXpYMSZkcudCTI+Qy25f5NQuvyxcftKsQyVGt0rqR/01ecNUrAIrfhERp3ssGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763611308; c=relaxed/simple;
	bh=CGmSftq2V2ybNQyUOVttMzwELymZwL/s39NArF/Bx3I=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=imdRu0CS74Uunx76BPDQEQ9+3K5U9fgPVL8KjInArdarvG6ijxhF9TcKwqF2tULXFcIfh58DXccBJfGggAN5wOogYuIDhKxfimKVr5aXtzdAYe6FE/37P86JZzGoTOA5oUxWWdNlZ4n42eBniGrWVfOrkbzqRybpMNPXOr1hiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=u0NKvdzu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AK41g6Z2767554, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763611302; bh=NYsHWttQRsvK6pEzs5LUPugiZ3CUlnDYoDWhDqyNnBE=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type;
	b=u0NKvdzuCSfzLTdqjo9uXucJYmnjOYG9sHJBaU9TzIzp9Np6lU02XeTra1BF+44FC
	 NYv1LqPx5F8AzYO9qAADFEbLkWeWXMZ4jJgp1yMP+RjsVHBJ5XqIBcL8WYhdh4E95d
	 I2TLA8b4lEQlyhoPOeg4wNGrVqSxh3SJNYwnh/SUWW2k0D0zNtJXmPIQE4WwJOp6xd
	 aiooSoapkojKkahycZNeYqlWF1VpbtVpGz8gTXE0i+Ecd9etMyAY++3LxVEbE4sqMu
	 pdg88ttITltbMF2NAN4H5JLGAUMVoDh6Kx+uuaizT1ZyDWLoz+P/6Yl9s+E/4b81ir
	 g4InS6ofBDgCw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AK41g6Z2767554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 12:01:42 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 12:01:43 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 20 Nov 2025 12:01:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 20 Nov 2025 12:01:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-2025-11-20 to v6.18-rc7
Message-ID: <8217bee0-96c4-44c1-9593-2e9ca12eccc5@RTKEXHMBS03.realtek.com.tw>
Date: Thu, 20 Nov 2025 12:01:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

A pull-request of rtw to wireless tree, more info below.

This is my first time to send pull-request for urgent fixes. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit d0309c054362a235077327b46f727bc48878a3bc:

  Merge tag 'net-6.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-13 11:20:25 -0800)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-2025-11-20

for you to fetch changes up to e837b9091b277ae6f309d7e9fc93cb0308cf461f:

  wifi: rtw89: hw_scan: Don't let the operating channel be last (2025-11-20 11:36:01 +0800)

----------------------------------------------------------------
rtw patches for v6.18-rc7

Fix firmware goes wrong and causes device unusable after scanning. This
issue presents under certain regulatory domain reported from end users.

----------------------------------------------------------------
Bitterblue Smith (1):
      wifi: rtw89: hw_scan: Don't let the operating channel be last

 drivers/net/wireless/realtek/rtw89/fw.c | 7 +++++++
 1 file changed, 7 insertions(+)

