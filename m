Return-Path: <linux-wireless+bounces-22831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A08AB2663
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 05:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D0347AAFD2
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 03:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A701017799F;
	Sun, 11 May 2025 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pE3WyTX2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9CBA45
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746935567; cv=none; b=bA6KVusUNQ95T5dhHE4ONzb8fZ+1OtpTYp3ZDER/fJLDe+F+iB8FmWhKQ4CnblR0YkUUbP2oQlKjbDZtixNF5aWqW02mCBuN02dYN87p7U/cWtuN/jTSVcTFlGNRGFR6NZhUAbSM5XsDHpAsspjq9Gbd7bw3ejP71+QNpt6Jho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746935567; c=relaxed/simple;
	bh=Hmdr2gYinR9BhmnHdwpRIqo5jPH+QR7gDvh1aBBL6U8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DlzIBQYYl3zsc4DLFTmJrtdT5u3xJ/OVupHJoOjPDbxUSANjPCinVMmWh7PHdANhJgYicsJIhIaF8cfNzWGog3spRyBuh30r07HTJkT/oJaXY3xEqjqtqeoEAsgC/99PZ1XE7b5LP2T4B8KksqxRkDs6WgHWWWryaQ4bbT5jSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pE3WyTX2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54B3qYnF53302873, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746935554; bh=Hmdr2gYinR9BhmnHdwpRIqo5jPH+QR7gDvh1aBBL6U8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=pE3WyTX2hovdlOIuFU5jkJ9cIBAPwdpIShXUbPe7QtewXRPa4b1PjrEPIfXqlhNeH
	 MzlYUZhtqmR8HRbb4BPsjgJtxa8fTQyLXEmlNFZNWsQualTzpMNND0EudvJ33bkm2x
	 yd8kWc1gPZu88KCHsGOEyFNMBVBjKeADAd1CHe8dZTAAiADaPg8OSnqrKX3+aKswJ3
	 wS1cckP50Z9r533rUizNV9ukIq3KJ2TgOTZRjKW1Eb5Kmg258JrJLG4mM4YkoqrgZE
	 o19LdX4VFoSFSWBuAg20ZCrri4xsu0MJvs8h/Iv06h6b7OzCAlT5raY1EYCqopthFc
	 AhnBzI8x9lLtQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54B3qYnF53302873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 11:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 May 2025 11:52:35 +0800
Received: from [127.0.1.1] (10.22.224.86) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 11 May
 2025 11:52:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/6] wifi: rtw89: mcc: improve user experience of P2P concurrency
Date: Sun, 11 May 2025 11:52:11 +0800
Message-ID: <20250511035217.10410-1-pkshih@realtek.com>
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

Since concurrency is based on time slot assignment method, the TBTT of
STA and P2P could be very close, and beacon loss occurs on STA or GC role.
Add more rules to consider that cases.

Zong-Zhe Yang (6):
  wifi: rtw89: mcc: pass whom to stop at when pausing chanctx
  wifi: rtw89: mcc: drop queued chanctx changes when stopping
  wifi: rtw89: mcc: add courtesy mechanism conditions to P2P roles
  wifi: rtw89: mcc: introduce calculation of anchor pattern
  wifi: rtw89: mcc: deal with non-periodic NoA
  wifi: rtw89: mcc: avoid redundant recalculations if no chance to
    improve

 drivers/net/wireless/realtek/rtw89/chan.c     | 176 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/chan.h     |   7 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   9 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   9 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   6 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   3 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   4 +
 drivers/net/wireless/realtek/rtw89/ps.c       | 147 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/ps.h       |   3 +
 drivers/net/wireless/realtek/rtw89/ser.c      |   2 +
 10 files changed, 348 insertions(+), 18 deletions(-)

-- 
2.25.1


