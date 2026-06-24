Return-Path: <linux-wireless+bounces-38031-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2DXDBbFRO2pqWAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38031-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:40:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE556BB22D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:40:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=C31ER2Q7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38031-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38031-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67B7A300E624
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523E930B53A;
	Wed, 24 Jun 2026 03:40:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1F2F360A
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272429; cv=none; b=sdxLkIys5rkgv/uwOhUtNAFwDgvd8U1+GRJddpgxUtXYjuzbqxWLmxSRofY5zw2Zsq+8q68GLWUDLQDbaMsKPTUWA/AHkkJlUJZKTIE6AVSKpfDSlA/cZ4SRVL8zpruCXtGZqjUUmewQpFhtrA6RivCMIR1n3HRgskvtNpViyVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272429; c=relaxed/simple;
	bh=2SzVx+YXU14xFWtQwSjkbyk36pdgt5/sasQ3DVcvgmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NSs4s9Xqk1Sp+qtgUYhZ4+XMNiy3jOUXM96XYRGSh8OYkz7cgthccvgr9ZnffqvrdhylFOqRzfrLpFiJmRDYppI09Ms+Y2FoG4SSd+JjGnk3WTWr/dzPbU6F1T3K8OAozt8TnB8oS4quA+iPNvLRGNKZfYpDm1XbKh1jIB5LhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=C31ER2Q7; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65O3eOvS53888577, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1782272424; bh=+uA6pJsvRlcRInUnaQ2ZsPTYAbL4kF1Qac2UXa1W+Pk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=C31ER2Q76E1wcG71ZuIFMDDU/NJml2pmIHjMfax0ye4jaKDk32EOkS4bA1OX3AtXL
	 g8l+AFR3goOTiNK84rbEZABel/vk1gSXWQLZzdr8rteSaS21T4GLqcth2FVCZwitu9
	 UJxFF2spEQmawZAdMPv8Ncuji+8uhW/aBHpLyTfgGq/M2jVw2g8hRIYkoS+MzjQUin
	 HMeaps8vRKZp1wSIQG8l8YFyYXqniC4OdbrVRBttEvd0we45oRmRAIvhf07DZ4QfVI
	 3Qq9khxrFKKtrIEPUXq/x8BQsPcg2TN2Xa/LIOv9/N2S3YTLNi2gNLi2Xfa+fAMIBB
	 LM6VWGb6oJP2Q==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65O3eOvS53888577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 11:40:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Jun 2026 11:40:24 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Jun 2026 11:40:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 00/10] wifi: rtw89: coex: update BT coexistence to support dual BT for RTL8922D
Date: Wed, 24 Jun 2026 11:39:31 +0800
Message-ID: <20260624033941.45918-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38031-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:ku920601@realtek.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:dkim,realtek.com:mid,realtek.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BE556BB22D

The RTL8922D is a dual BT combo card. To work with two BT well, extend
the BT coexistence mechanism to consider two BT cases.

Mainly the patches are to adjust struct fields related to BT from one
field to two element size array, and then add new format to support
more parameters needed by RTL8922D.

Ching-Te Ku (10):
  wifi: rtw89: coex: force to exit Wi-Fi LPS while Bluetooth profile
    exist
  wifi: rtw89: coex: offset current BT info to BT0 for dual BT
    configuration
  wifi: rtw89: coex: Move wifi related counters to wifi info
  wifi: rtw89: coex: Extend bt_slot_req for dual MAC wifi
  wifi: rtw89: coex: Move Bluetooth related counters to BT info
  wifi: rtw89: coex: Refine third party module related coexistence
  wifi: rtw89: coex: Add TX/RX RF parameter format version 9
  wifi: rtw89: coex: Renaming drvinfo_type to drvinfo_ver
  wifi: rtw89: coex: Add Wi-Fi firmware 0.35.94.1 support for RTL8922D
  wifi: rtw89: coex: Add RTL8922D chip string

 drivers/net/wireless/realtek/rtw89/coex.c     | 843 +++++++++++-------
 drivers/net/wireless/realtek/rtw89/coex.h     |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  90 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 252 +++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 160 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  20 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  12 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  14 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  44 +
 12 files changed, 948 insertions(+), 525 deletions(-)


base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.25.1


