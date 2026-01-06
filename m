Return-Path: <linux-wireless+bounces-30381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1F4CF68F1
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 04:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 918E9304D8F2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D671FC0EF;
	Tue,  6 Jan 2026 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ke76Tx+f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678C3A1E95
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668978; cv=none; b=n1NR6cc0dVu/Jz5R+Zs498y8mXCxx4C8UrhRJoolTGeZ4GknYlvsxsP9B0ZtEVF3kPE9/lVNUK+dTIY8+uqVNJvJiG+XaCE35CPswCgDr7FXKE6K8TklTb+VM0KgDWT0ZZZJc54sJGe4zgzrkOGQJ51cWTiVbD4SxKAbO9reGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668978; c=relaxed/simple;
	bh=TKXEWzypyt84Z3TpeKK/Y0udaizmA2JxtzNikOz/cis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rLMsT9ULhyf/2AD1nohq3GFFq+gVgTBDyMH+kOq5btXKEmmRTHblFCnHcMkekqaVmp2oAGc/J8HyHOTgjRwsOiiQFWjnYivrXe347x+brhCeltc4ZRo2wWO+0chuOiotvQL3YLlu6qRDlct4qDVAftoh4kelVhygsKJNudW2Vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ke76Tx+f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60639YRW04168988, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767668974; bh=BI+PGr4al1OZqC5fuKqAKiL9eWKgzHF0Bs1Zw1K6K48=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Ke76Tx+fGuRGdqnyb43nmu/ocNKQeHCDaJmadg+MUcUh2da6fYr6jUZf8zQfDzEq3
	 TETjmVCt3t1kMvzu7bwZI9waXTttJXu8fKF28vWWrbS1TJ2qmu9aDziCLoxc4iHjlY
	 UhUMCiJJn6PdgHAvMAuZYkikBwqKxgfvd5Cg+H6MJY2NAhqvdAqByYKGfvnvb1VhTn
	 cYH1dEYdZxjhr6xPIXQQ9mlryXw5cy0WeJg3guvLfsgxuBh3u47hLTbvJJqu5Igbph
	 j76WsJQ3nXQqSZCiePKra2FeMd4miqzzfsgOGXJ23tAVwQrVvaWz/L1E9C1C7BIYva
	 LzZqMnJ+lJbCw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60639YRW04168988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 11:09:34 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:09:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 6 Jan 2026 11:09:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next v2 00/10] wifi: rtw89: prepare TX/RX WD and D/C-MAC H2C command for RTL8922D
Date: Tue, 6 Jan 2026 11:09:01 +0800
Message-ID: <20260106030911.15528-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8922D use different TX/RX WD (to assist in TX and RX per packets) and
D/C-MAC command format (to assist in TX/RX per association). Add them
accordingly.

Patch 9/10 is to consider hardware AID in firmware element.
Patch 10/10: The RACK (received ack by firmware) every 4 commands are not
             necessary for WiFi 7 chips. Remove the logic.

v2:
  - patch 2/10: add missed bb_sel field which can report received link.

Ping-Ke Shih (10):
  wifi: rtw89: update TXWD v3 for RTL8922D
  wifi: rtw89: update query RXDESC v3 for RTL8922D
  wifi: rtw89: fw: add DMAC v3 H2C command for RTL8922D
  wifi: rtw89: fw: add CMAC H2C command to initialize default value for
    RTL8922D
  wifi: rtw89: fw: add CMAC H2C command for association for RTL8922D
  wifi: rtw89: fw: add CMAC H2C command for TX AMPDU for RTL8922D
  wifi: rtw89: fw: add CMAC H2C command for TX time for RTL8922D
  wifi: rtw89: fw: add CMAC H2C command for punctured for RTL8922D
  wifi: rtw89: fw: consider hardware AID for firmware elements
  wifi: rtw89: fw: set RACK bit every 4 H2C command for WiFi 6 chips
    only

 drivers/net/wireless/realtek/rtw89/cam.c  | 134 ++++++
 drivers/net/wireless/realtek/rtw89/cam.h  | 129 ++++++
 drivers/net/wireless/realtek/rtw89/core.c | 132 ++++++
 drivers/net/wireless/realtek/rtw89/core.h |  28 ++
 drivers/net/wireless/realtek/rtw89/fw.c   | 514 +++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   | 171 ++++++-
 drivers/net/wireless/realtek/rtw89/mac.h  |  12 +
 drivers/net/wireless/realtek/rtw89/txrx.h |  22 +
 8 files changed, 1126 insertions(+), 16 deletions(-)


base-commit: 6a0b7392a6f5487fb58704926a24b1e2ee2762e9
-- 
2.25.1


