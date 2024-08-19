Return-Path: <linux-wireless+bounces-11604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACEE9566AA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDBCB24419
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFACC15D5A1;
	Mon, 19 Aug 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YU+1Juk0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0C15CD60
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059060; cv=none; b=CoZKRpLfl275XGQUJcaa5eVFfofSBeCUgWDyQSlE1auFH7L0RpxlSUn3vwjdmNDOlC1g8b4oURx7GHl3yUeebipRiQ8pn2jxU+/jT1UBNMa/BJ4MZcUFSpYAkY52jjQVGnhATMQksl1VxiWgMRw/CBXFpILoYahWgW6XiFLUYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059060; c=relaxed/simple;
	bh=gpYcAn/ieuljSvStirnDBU+8gSXgoPXNbQtKusVUKlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W7OEiXCCN5m8DgW2nfw0OWVjgtl39YY8clSVxWmbPYLfZ1dsskHArxT/1dT8+R+FOjy2UQJc76dhIdpRnyl72lNqnQyx1soaMYo9bXt0Ibtmm+35s0jCBdU3SjuwYXztocvv7WyYQWIvuBF4qyp0/GXArEzkmMO4KtUN6YwYRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YU+1Juk0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9HY7r84125995, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059054; bh=gpYcAn/ieuljSvStirnDBU+8gSXgoPXNbQtKusVUKlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=YU+1Juk0q531UogorXwBEfhsBMy7lKCHfMU/nLqdj6bQ6XnfgAz2ibxyPHJk/k9M8
	 lavNBi/fpItjxIWJMcSZFFcGPAnQaX61U/fcpk+cls2gUsJtpcR96VaJgvRjwiyluW
	 n71kAKC84o/zLncK2bfD7mWZalRCta9jfu//pw5+mRBKiiCjxv1waFlbgCTngJ1dki
	 eWNwYMOrFxr1lcwal/OR+c76noB+MTd5hRVRmGjNvjQiifdbdMM0nCyOclXlSS5vJA
	 WF77oFgr26sR2hM4tWjB7zprGgZK3wzDZxccRs1UImoNKSa1z7LLn8kmvdOj4ATyXi
	 1XIqt/TlD8rfw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9HY7r84125995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:17:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:17:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:17:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 0/8] wifi: rtw89: use and propagate chanctx properly
Date: Mon, 19 Aug 2024 17:17:16 +0800
Message-ID: <20240819091724.33730-1-pkshih@realtek.com>
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

Previously rtw89 hardcode the chanctx to single one, because it only
support one channel at once. Now we are going to support MLO that
we want to support more than one chanctx at the same time, so adjust
the code to propagate chanctx to callee.

The last patch is to add a flag 'support_mlo", which value is decided
at probe stage, and then we can use this flag as clue how to configure
hardware corresponding to operating modes.

Zong-Zhe Yang (8):
  wifi: rtw89: pass chan to rfk_band_changed()
  wifi: rtw89: 8851b: use right chanctx whenever possible in RFK flow
  wifi: rtw89: 8852a: use right chanctx whenever possible in RFK flow
  wifi: rtw89: 8852bx: use right chanctx whenever possible in RFK flow
  wifi: rtw89: 8852c: use right chanctx whenever possible in RFK flow
  wifi: rtw89: 8922a: use right chanctx whenever possible in RFK flow
  wifi: rtw89: rename roc_entity_idx to roc_chanctx_idx
  wifi: rtw89: introduce chip support link number and driver MLO
    capability

 drivers/net/wireless/realtek/rtw89/chan.c     |  12 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  30 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  14 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  25 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |  17 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  18 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |   6 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  19 +-
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 138 +++++----
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |  18 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  27 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.h |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c | 292 ++++++++++--------
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.h |  17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  21 +-
 .../wireless/realtek/rtw89/rtw8852b_common.c  |  15 +-
 .../wireless/realtek/rtw89/rtw8852b_common.h  |  15 +-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 211 +++++++------
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |  20 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  29 +-
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 188 +++++------
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  19 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 162 +++++-----
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |  17 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  26 +-
 26 files changed, 766 insertions(+), 614 deletions(-)

-- 
2.25.1


