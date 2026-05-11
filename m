Return-Path: <linux-wireless+bounces-36196-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKxKAbN/AWqkbQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36196-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:05:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB32508D93
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 09:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED6F30234FB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 07:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7128296BAF;
	Mon, 11 May 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RL4XfHUu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F033B6D5
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482917; cv=none; b=raKvGhlUZGf6C1hfwzQS7ZMnlrpXh4E0OcrRcOu95qfcQ2GSB1JR/2TW244A5sC2K7KqXfu0npdpvOjwDUXCkW4hNHEAx4E6lMkUhH8zPsrpoa+UQHf3j4Ngl6YxexCReOS58osQG9/AsqnU97VA5JrnElHk3oVwEEX2d7T2ldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482917; c=relaxed/simple;
	bh=ezeSzgit+nAeAOpFRKxYmSqlNwh6b/S97GokTikjLa4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eTPZWID9ZtXSoHUQR43t1O+ITTapck4qoYhhx0aug3pHm+oBdc0cl40We3Y1/ACy6svjlDqBgqM6Ig/+WymQMhhvy/Z9Lpsas7HsjqQTFRXTAKD76zHqXJUpurrTOiYu1OkA1J3fPKJtQprk6OCC8ww62dR+RwXKrJWIiX/pHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RL4XfHUu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64B71qqmE2540377, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778482913; bh=DT4NZB1zl4yopLdygyq3OxsVTtszhU0I3SP4wLOu1WM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=RL4XfHUuzUmIprMzKT4iNu9BKWF3Ny7qegoOBRpFR/PZ+Fse2I01RZm1xVIBxaqcd
	 XkjfvrakaQ9oYa1F8c55C9TCAnsuTc5DqmBWBILdl8pTLpHH3B1OrCqEGYtkQswYne
	 20hBBZO6gpsOY2rIPFcOYyg1vuJFsfjeQ+Lg7jCCj+nQ9gUwUdWrYxKPMS6iDnEUya
	 AH0JufgOP8E9Ik9cAvIryet3ui7Zp6OOIRlrF/xwZHnBU6HRk4WsR/tprMIlTmnYbU
	 QpWzFa5bxSUauBm7psYWoEMKcVPg10rskixJ99ozacrTFRWBNxMUcz1MPR6MAa1/BK
	 2Lvm7aARyN4TA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64B71qqmE2540377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:01:53 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:01:53 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 11 May 2026 15:01:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 11 May 2026 15:01:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 00/11] wifi: rtw89: update BB wrap for RTL8922D
Date: Mon, 11 May 2026 15:01:37 +0800
Message-ID: <20260511070148.25257-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 8EB32508D93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36196-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The BB wrap is a set of registers to control TX power and shape.

The RTL8922D add more registers to fine tune performance by QAM, bandwidth
and etc. Add them according to hardware design.

Ping-Ke Shih (11):
  wifi: rtw89: phy: define BB wrap data for RTL8922D variants
  wifi: rtw89: phy: set BB wrap of out-of-band DPD
  wifi: rtw89: phy: set BB wrap of DPD by bandwidth
  wifi: rtw89: phy: set BB wrap of control options
  wifi: rtw89: phy: set BB wrap of QAM threshold
  wifi: rtw89: phy: set BB wrap of QAM options
  wifi: rtw89: phy: set BB wrap of trigger-base partial band
  wifi: rtw89: phy: set BB wrap of CIM3K
  wifi: rtw89: phy: change order to align register order
  wifi: rtw89: phy: configure control options of BB wrapper by RFSI band
  wifi: rtw89: phy: add BB wrapper generation 3 for RTL8922D variant

 drivers/net/wireless/realtek/rtw89/chan.c     |   2 +
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +
 drivers/net/wireless/realtek/rtw89/core.h     |  21 +
 drivers/net/wireless/realtek/rtw89/phy.h      |  88 +++
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 517 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/reg.h      |  73 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 160 +++++-
 13 files changed, 699 insertions(+), 172 deletions(-)


base-commit: c1ed02655f9134d6af6a01a58b734329c2f4f22c
-- 
2.25.1


