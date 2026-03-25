Return-Path: <linux-wireless+bounces-33809-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANKnCOSNw2lVrgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33809-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:25:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FD3320A8A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 08:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26B07303967E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0036492E;
	Wed, 25 Mar 2026 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="P6r0G3g5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E373644D1
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423315; cv=none; b=PAHx6S9UeaonzwRIJT9ZxaDo2IAkUiY5LS0PkvlIro0GgcJXYAJXyNLVc8HnvbKDPljj9TWxKr+hbkpX8my1PIF4CXctxR3NNRMyxNUhifZk2Uv1k+vAor1S8UzF6vfF6iLBtjX5V+JWzjf4X/sa+MW2qdX16haZUeKoUF9ewNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423315; c=relaxed/simple;
	bh=XWqrwxPSWozFd9b73tcHTARdBLQu6ZnCWCbVenaqSbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A0HN5aMSXS/0CMqkpbTv0aa4EqEWmNk0+/qEIxwQJ2+M1S5uotgxT1UZwAh/xv8gvTjlZZk63c6ly9Lgad7roZPb6ImXzs0q42FmTl8F9QHQzzgGOGsWwzMxKhCqwsI36pKfhr1p3laQg87hseGLS82mgWw3wzXxr5Jfvj4Tl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=P6r0G3g5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P7LoJB22938744, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774423310; bh=Exq1IYQRE+pIBV/6F8/9ImMPieVgScw4XbTmV/NUb74=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=P6r0G3g5fIYr80x/b1Fd/Ul/N78Nxjev0spTX4YiGbWITFiK0Q0vS1oTAMVZcpAsO
	 dIPIPhjKLWgWm4b3Ywrq3CIjVQMzyNzPyvNAKznuz6iHe3JuGrmWwdafRQ0GZlCS/z
	 p+98TAdHbbpgbSEM4HpgTOh/JP206xIVHPx7MTj2CxlVKAckYIGR8+6fArbeyvqhKE
	 2ChK3zfOxr8FaHtQ4THUCMz8yleoVh7XHWiSjojiWQxZIHdXerpWXqm5giHLRJfCQ9
	 B7H7wMvuOO6tTozQVXTVsSWWzrtpcKsULx40v2Feaf2/o/1EqYb7yw6ugFeSopPOU2
	 yxNXBrcH0PKUQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62P7LoJB22938744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:21:50 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 15:21:49 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Mar 2026 15:21:49 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 25 Mar 2026 15:21:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/8] wifi: rtw89: MAC and PHY changes for RTL8922D and WoWLAN for MLD magic packet
Date: Wed, 25 Mar 2026 15:21:22 +0800
Message-ID: <20260325072130.41751-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33809-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 24FD3320A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

First two patches are to support WoWLAN MLD magic packet.

The remaining patches are changes related to RTL8922D, including MAC, PHY,
and PCIE settings.

Chin-Yen Lee (2):
  wifi: rtw89: wow: use struct style to fill WOW wakeup control H2C
    command
  wifi: rtw89: wow: enable MLD address for Magic packet wakeup

Eric Huang (1):
  wifi: rtw89: phy: expand PHY page for RTL8922D

Ping-Ke Shih (4):
  wifi: rtw89: pci: clear SER ISR when initial and leaving WoWLAN for
    WiFi 7 chips
  wifi: rtw89: mac: add specific case to dump mac memory for RTL8922D
  wifi: rtw89: mac: disable pre-load function for RTL8922DE
  wifi: rtw89: phy: load RF parameters relying on ACV for RTL8922D

Zong-Zhe Yang (1):
  wifi: rtw89: fw: load TX power elements according to AID

 drivers/net/wireless/realtek/rtw89/debug.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c     | 34 ++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h     | 57 +++++----------------
 drivers/net/wireless/realtek/rtw89/mac.c    |  4 +-
 drivers/net/wireless/realtek/rtw89/mac.h    | 16 +++++-
 drivers/net/wireless/realtek/rtw89/pci.h    |  3 ++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 52 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/phy.c    | 15 +++---
 drivers/net/wireless/realtek/rtw89/phy_be.c |  2 +-
 drivers/net/wireless/realtek/rtw89/ser.c    |  2 +-
 10 files changed, 113 insertions(+), 74 deletions(-)


base-commit: eef6d4449e8a540fde792968a26d8aa514af8089
-- 
2.25.1


