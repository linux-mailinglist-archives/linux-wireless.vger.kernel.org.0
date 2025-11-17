Return-Path: <linux-wireless+bounces-29016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7234C623E1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 04:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A0DB4E36F6
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2FD313544;
	Mon, 17 Nov 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VIruAdFH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8D15A864
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350201; cv=none; b=rbORhjQjd8Cr6EN75chpm702FKuzeTMQzoQGLsRU+suuWpjR0JSQr4FG/mIY3QZrHReX6Alg5OqyN7KnP141fEZ/pWBNd49oY7IqjSXhxck8ooF/HgmBaGuTECxYlNGmsXq4p+C4J3ZGsSvEINc3mk2Bcrrka/DGzSzlZS41ftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350201; c=relaxed/simple;
	bh=+4tfmuEHCzDjhO7P+pmy0NIB0Nb4TXn1mmW3OJ37odw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Reqpj8isTTVsH7YLCkesOPSvBTDk63IyuhpOhJKrl8MvqoSvupticgYy9zu0slK/aWkozXmaFAoNyhUnDkg1HjbhSqnYf4nyKVcTRVJBl5a9eJFP5n2K7dTGB5kNX+YQGEYg2Z9ytCVNRoe85tGOPZJGWHUM2CsHg/udIIedzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VIruAdFH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AH3TmFK22763582, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763350188; bh=up6wzSZtcvCTzu8DEipKe9OlItjaYzLYXTWr6IvIPAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=VIruAdFHPC4IgYIz728H4+0hOg7pO/e9Wn09cOZseNQDALUd3dY/ppRmV/Q4GChid
	 XbUFPprr6CXtxVqN3Lg2gR5XYpIwQyXOtaGafoRZH6pHjEIEghOmx95E8vlOyQseCz
	 NF1zlVxvTJ9ec8n6HkpfNBu3T/70IwXfzCK7gbeqLbzhgv6WoAOttHWmvSJLFhKX8Z
	 OGOKv5XKrAn8rsgy6DhCleQp7k593dG727lULnP/Taa/ZrXE1A51idwxYbSpUPEydQ
	 UuTOOd1jy3LnGPlRJQbdyM9QxavJ3K+RzzXu2fBJqgiCFJW0AQXZhrno6VyVU3J7lx
	 BtcGMFzUUAPkg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AH3TmFK22763582
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 11:29:48 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 11:29:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Mon, 17 Nov 2025 11:29:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: [PATCH rtw-next 0/2] wifi: rtw89: adjust code to fit coming field_prep()
Date: Mon, 17 Nov 2025 11:29:08 +0800
Message-ID: <20251117032910.11224-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

As Geert mentioned [1], two more tricky cases are pointed out by
implementation of field_prep(). Change the code to resolve the tricks.

[1] https://lore.kernel.org/linux-wireless/fccadfe07e4244b993f44ac7315d3d52@realtek.com/T/#mbdfd08117f67b39fabb72dd71acb00f4b3c22bd8

Ping-Ke Shih (2):
  wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO
  wifi: rtw89: avoid to use not consecutive mask in __write_ctrl()

 drivers/net/wireless/realtek/rtw89/mac.h      | 20 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 26 +++++--------------
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  8 +++---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 26 +++++--------------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 26 +++++--------------
 5 files changed, 45 insertions(+), 61 deletions(-)

-- 
2.25.1


