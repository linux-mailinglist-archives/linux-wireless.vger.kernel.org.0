Return-Path: <linux-wireless+bounces-31794-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLhZIdjBjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31794-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:16:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0129413334F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0A0C3028108
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449125487B;
	Fri, 13 Feb 2026 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="S8tNjtqe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443442288E3
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963412; cv=none; b=Asc/TB3IflVL8OT1fSXnSV2NB5Cm6tvdbUtYdR5pdgX6TcNhRej0fsPB5a2wh95Qc1f8aHjczvfu23JlsFiEmFpI74woGK5E0ux80gnyyl6LpGDVvPbeGA50w4MadEH4mXKw098nNRgWFAwxFoMMsRLtFvJ+rcrK9sGF6zaxslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963412; c=relaxed/simple;
	bh=u9JZ0Fg/KvPP6sUsjCfrKE/9Cw/J4SEcTHChIPlwViE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=haLyOAPvoJqq87RaEs3aiatGcGaAUTcKJhddRCtf78eCk+36ls0olH8GUK99o1cVZAq7fUIBY4vYoT7bc7PBcvUvG54OCbkmxeiBjl3pi3cpYuW0gD84PrAb2qU9LEO+HWZJ0JQo2pOxLk+kQYL1z69gzKM+lZCcdURWwVDvm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=S8tNjtqe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6GkqaE1418798, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963406; bh=PdM/0KHNBHRebHOHcJoNW3/FtbBaOE0w5ShZ6wizQcw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=S8tNjtqe8D6SBOl8EmMdikzuVJHQDj0ifYPBeKgEzBGPpiepGRlpXpIqU5DX08IDw
	 dtzZiOgMR7G7SlJwegaeZdhOBJJD12VudLNidFz+hOCq/TcuqSZGc4FgSlxWjAfF0s
	 4XvDz+bVjJOwKkUuI/IBmpoa9r9+rCR0sMb7cDjdC2jfg1s9BvYD6c+U2UZwyL+Fdx
	 WSgg+L6XVitRQt4PkaqNDe7vxxHiMZ5vAZdGPgJhfV9A6c0ip14vZVWF3qae+EBC+c
	 YVH+N3Sa7zTcqfSWm/rAUiSTRcWROBqJwj4kDZfkwqDGyA1hsHWCYxMuXln5rxaeT7
	 5hQR6f4ihcBVg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6GkqaE1418798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:16:46 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:16:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:16:46 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:16:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/12] wifi: rtw89: refine to read HW parameters from file, and update SER code
Date: Fri, 13 Feb 2026 14:15:40 +0800
Message-ID: <20260213061552.29997-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31794-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0129413334F
X-Rspamd-Action: no action

First two patches are to support variants of RTL8922DE and RTL8922DE-VS,
which they have very similar features except to 4K and 1K QAM and they
use different firmware file. And, even RTL8922DE-VS has more than one
sub-variant that uses another type of firmware in the same file. Adjust
to support these variants.

Patches 3-7 are the first step to move hardware parameters to file. For
newer chips (after RTL8852CE), we have done that. But early chips, such as
RTL8852AE, RTL8851BE, RTL8852BE) still use driver built-in tables.
In order to remove these tables eventually after two TLS kernel (about
two years). We have submitted firmware into linux-firmware repository,
and driver support these new firmware by increasing firmware version
number.

Patches 8-9: update along internal developing RTL8922DE.

Patches 10-12 are related to SER simulation. In order to make recovery
more usable and stable in field, add more simulation cases and tests.

Kuan-Chung Chen (1):
  wifi: rtw89: add H2C command to protect TX/RX for unused PHY

Ping-Ke Shih (4):
  wifi: rtw89: fw: add fw_def struct to put firmware name and format
    version
  wifi: rtw89: fw: recognize firmware type B by AID
  wifi: rtw89: 8852b: update supported firmware format to 2
  wifi: rtw89: rfk: add hardware version to rtw89_fw_h2c_rf_pre_ntfy_mcc
    for new WiFi 7 firmware

Zong-Zhe Yang (7):
  wifi: rtw89: add general way to generate module firmware string
  wifi: rtw89: 8852a: move DIG tables to rtw8852a.c
  wifi: rtw89: 8852a: update supported firmware format to 1
  wifi: rtw89: 8851b: update supported firmware format to 1
  wifi: rtw89: debug: add SER SW counters to count simulation
  wifi: rtw89: ser: Wi-Fi 7 reset HALT C2H after reading it
  wifi: rtw89: ser: post-recover DMAC state to prevent LPS

 drivers/net/wireless/realtek/rtw89/core.c     |   3 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  46 ++++++-
 drivers/net/wireless/realtek/rtw89/debug.c    |   6 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 117 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h       |  54 ++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  17 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   5 +
 drivers/net/wireless/realtek/rtw89/phy.c      |   8 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |   4 +
 drivers/net/wireless/realtek/rtw89/ps.c       |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  11 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  62 +++++++++-
 .../wireless/realtek/rtw89/rtw8852a_table.c   |  51 --------
 .../wireless/realtek/rtw89/rtw8852a_table.h   |   1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  11 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   9 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   9 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  10 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |   2 +
 19 files changed, 339 insertions(+), 89 deletions(-)


base-commit: 333225e1e9ead7b06e5363389403bdac72ba3046
-- 
2.25.1


