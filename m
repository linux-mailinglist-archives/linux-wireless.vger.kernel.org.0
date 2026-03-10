Return-Path: <linux-wireless+bounces-32809-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oItQC4/Qr2kfcgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32809-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:04:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DEC246E78
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 09:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16E43013A90
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE6C3ECBCD;
	Tue, 10 Mar 2026 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R0WC3uDf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DB3ECBE9
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129721; cv=none; b=V9gfuC4jNo4vx8aZiB9cvv/WXlCLTTwo7dbBdkNrgsVY+V4ii1kWDuLJ+e36wmnko+Wx+WDA9cgD5lOCC5V00P2MC2bRQ3t7crst3GeDS29jV5naL8CtGxjIVHvbqP63ZaNnK8octS+yh8OoClBW7fp1NmQ9hYMOkWQ5QkA7dBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129721; c=relaxed/simple;
	bh=0skMCWAIWcws8PW/ykTE3dNJ6ru9AjXBIEMkAsjn5I4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fd/fTli6Zw57AqOEMn5UVz6VNz00rTkbY0gheBboPT31TfjV/WldDIwlCVEhefXRx+LTU9Wf+GKklj7Ri3WDDrrsW/cNsdyE3KDTY9JJd8KkXJorueYKMocgkb9+5kJ1AZs9f/pRib339ERhJfedI4Zs0idYrCmigt7DbhFUUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R0WC3uDf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62A81t2Z22208369, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1773129715; bh=yLuKtnNfg7cISv+rj0M9DYdCGM8N6HqMBlOTIgaqIuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=R0WC3uDfQXzHDBbCrCrzl9kRBzc+yZCabsTc+wVsCxek1TVSUx3FthsBUN0mgmIXf
	 IYKMVvUy4bbAvg2ULdGOHc2QGISlnYKjso1myrcQFGeIJ9xFLXph6BuOvD/fJMrlgf
	 ij9a3j4EG/MQbkqrm6D4kr1ldLlCUbhjvUZI6pr/5OCPTht52pUodJaH0iGcc29hnd
	 gFnYVm2Vhc8/hWwRhJLInDtGm6RWIsq0cRjsUl//Jb/u5+mFovLTxavBTj7gEQTedh
	 uEV4wtvppubfRxgMpeq8mHEcgz4NGlAMp27OBD93RzETm0LdMkO3zzjictuPl7V1uH
	 lhFM1IotKRFmA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62A81t2Z22208369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:01:55 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Mar 2026 16:01:53 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Mar 2026 16:01:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Mar 2026 16:01:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/13] wifi: rtw89: update hardware settings and tweak for MLO
Date: Tue, 10 Mar 2026 16:01:33 +0800
Message-ID: <20260310080146.31113-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 01DEC246E78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32809-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:dkim,realtek.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Mainly, this patchset is to add hardware settings, and tweak code related
to hardware MLO mode value. Others are almost random fixes.

The first four patches are to configure hardware settings, which are
written according to internal patches.

Patches 5-8 are to refine hardware MLO mode.

Patch 9 is WoWLAN related, which is to add retry times to let WoWLAN
being reliable.

Patch 10 is to remove mutex lock from driver. Since driver has used
wiphy_lock, it should be not necessary.

Patch 11 is a workaround to deal with AP interoperability problem.

Patch 12 is to recalculate AMSDU length to improve performance.

The last patch is for firmware crash simulation.

Chin-Yen Lee (1):
  wifi: rtw89: wow: add retry for ensuring packet are processed

Ping-Ke Shih (4):
  wifi: rtw89: mac: finish active TX immediately without waiting for
    DMAC
  wifi: rtw89: pci: update SER parameters for suspend/resume
  wifi: rtw89: mac: remove A-die off setting for RTL8852C and RTL8922A
  wifi: rtw89: phy: limit AMPDU number for RA try rate

Po-Hao Huang (2):
  wifi: rtw89: Drop malformed AMPDU frames with abnormal PN
  wifi: rtw89: Recalculate station aggregates when AMSDU length changes
    for MLO links

Zong-Zhe Yang (6):
  wifi: rtw89: move disabling dynamic mechanism functions to core
  wifi: rtw89: tweak settings of TX power and channel for Wi-Fi 7
  wifi: rtw89: chan: simplify link handling related to ROC
  wifi: rtw89: chan: recalc MLO DBCC mode based on current entity mode
  wifi: rtw89: replace RF mutex with wiphy lock assertion
  wifi: rtw89: debug: simulate Wi-Fi 7 SER L0/L1 without PS mode

 drivers/net/wireless/realtek/rtw89/chan.c     |  72 +++++----
 drivers/net/wireless/realtek/rtw89/core.c     | 150 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  29 ++--
 drivers/net/wireless/realtek/rtw89/debug.c    |  45 ++----
 drivers/net/wireless/realtek/rtw89/mac.c      |  17 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   6 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   5 +
 drivers/net/wireless/realtek/rtw89/pci.h      |   1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c   |  52 +++++-
 drivers/net/wireless/realtek/rtw89/phy.c      |  46 +++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |   1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  28 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   2 +-
 drivers/net/wireless/realtek/rtw89/util.h     |  17 ++
 drivers/net/wireless/realtek/rtw89/wow.c      |   2 +
 drivers/net/wireless/realtek/rtw89/wow.h      |   7 -
 18 files changed, 386 insertions(+), 98 deletions(-)


base-commit: 039cd522dc70151da13329a5e3ae19b1736f468a
-- 
2.25.1


