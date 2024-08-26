Return-Path: <linux-wireless+bounces-11952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0846495ECA0
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890CDB21970
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00781741;
	Mon, 26 Aug 2024 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="o6CW9Cz0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37AEAFA
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663096; cv=none; b=VD+ajtmEPfV+9efKs9w5MvSqEJGxIJck5U3cdurvmDfMNVubv0FGas+sbX5a4p5JgR0y9Z+iJebKoegdSfamz45u+qZ0KjwqnKvQEyBKpdgcI71RVUt+Ogf4caqPzMMplZIMPjnl8IFLOVswQaxKBgGIl2DxD2AyG4H2AmVdL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663096; c=relaxed/simple;
	bh=xhchbgVCPuGZsX8ApzF5OvZm703OWYIUgwkHi2MOuBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iiyKHceQn4J1wLPuKiDF+bxsxKFdLFqbdfDqqc3ThbMHBKLpDUbeTUGGo+8zZgZUDo8g+hLVTWhP6AqBQt0xk8MsYCMDrEwrmKJTPAPx9GMEXz+KXEd8h3KMmtd0DKjMadWGBoHVdq6V9oXqDcb9UBn8T2PlQTA8GjBDCyDbZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=o6CW9Cz0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47Q94onC63828650, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724663090; bh=xhchbgVCPuGZsX8ApzF5OvZm703OWYIUgwkHi2MOuBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=o6CW9Cz0ZftzmfEbSFD0DOVxcAuisr/QBujQOAmwNc0zdltpb7GUDkFXuTqkXyrC9
	 GyazfOfkxYpsSd9a53lQgpmJtJj3uz5HerPHiBH2N3H444j2qPMjxEjXx6E5ZtLths
	 vU8Drx8wpmLpz+bigiz1IYWm5scfi8/m3NMaff2B6mbPUdfjfp8DjZnAGVdMm6aFac
	 FEnMxwnhXVbMsjgD8PWfrlqQWU1EVhlYvP1iyexAwlnFlIlhKtCpIWs9QXahT2gvOJ
	 /7flcCE7EFdQWBpgJfkq5sUT7we7PyZS4+7NDuUA+pqqYrDbJ3D7aDHaTZFnkvLNHz
	 SK6eHQ0G5EOqg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47Q94onC63828650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 17:04:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 17:04:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Aug
 2024 17:04:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 0/4] wifi: rtw89: wow: support WOWLAN net-detect for 8922a mainly
Date: Mon, 26 Aug 2024 17:04:35 +0800
Message-ID: <20240826090439.17242-1-pkshih@realtek.com>
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

After verification, declare support of 8922A net-detect by patch 3/4.

First two patches are to wait for completion of firmware H2C commands by
C2H events, otherwise the events (RX data for drivers) aren't properly
read before entering WoWLAN and firmware get stuck.

The last patch is to apply scan interval of net-detect from cfg80211
instead of a fixed value.

Chin-Yen Lee (3):
  wifi: rtw89: wow: add wait for H2C of FW-IPS mode
  wifi: rtw89: wow: add net-detect support for 8922ae
  wifi: rtw89: wow: add scan interval option for net-detect

Zong-Zhe Yang (1):
  wifi: rtw89: wow: fix wait condition for AOAC report request

 drivers/net/wireless/realtek/rtw89/core.c     |  2 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  5 ++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 19 ++++-----------
 drivers/net/wireless/realtek/rtw89/fw.h       | 23 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/mac.c      | 19 +++++++++++----
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/wow.c      |  3 ++-
 7 files changed, 49 insertions(+), 26 deletions(-)

-- 
2.25.1


