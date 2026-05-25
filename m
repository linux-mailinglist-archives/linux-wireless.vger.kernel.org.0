Return-Path: <linux-wireless+bounces-36868-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAuILzsOFGpeJQcAu9opvQ
	(envelope-from <linux-wireless+bounces-36868-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:54:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 642705C82BE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A7CE301106B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB03E51C4;
	Mon, 25 May 2026 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ie261ieM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B43CDBD5;
	Mon, 25 May 2026 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699137; cv=none; b=aBUa8XWQLqXnOkWoSRTYQBG2rFDnNIt6dG9mHTEVzVm9t0E2Ix1y8OuddPPzefHrM4XGQ1lJA9Pnv3Z+bTsAHROkudToYc+HYYaWyNNlvg41R0gLzFsF0WPeKtYk/o1JFYBKri2HyvosYNCLPYTXRwlOKwDHceVKaLOhmI+sDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699137; c=relaxed/simple;
	bh=htkAsL3WKBlT9mVp5KMho9yanyMre/aP3fW+xmhaWFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M3Q863Lhe2XRXgJSeIsO/cA4IUJ6Rg8+vfhBpBYJIq/HrBkbMvoWfGPTiOQiWpwgKJlIKHEqwIKaeXJ+ZeavQ0ugmTaXzVIdEuILrGUAr/xl/3lUU5V9Q27hPBUjLZgKN2SL929P2ZnLpSaOg8ARDKJw6IiNtUPS5aXS4ki+43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ie261ieM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P8q5VF1936455, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779699125; bh=ZhKE+tzmaPmSdtXVkVtokReCY1wcjvyP19cU/2l3HCU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Ie261ieM5Q7LwWy0/Ojf5/nd6F6fgtID+DsTFxdU+0rjdObELCzH5M7uNJCtK8SVO
	 p5lrTZKlMFZZAE2CYwTXALnM2gmdRj8f6wK4JCeyr0GQcmShTRYDQiu3TchivBSZlR
	 qX+zQSa14SvG5unbuVU5A4o/LX8wIsgbC0R+OBJS3hMyMXbrKC5O9FAMeh81XcPlSz
	 9epWkp/2/YebLi/vWMiv8oki9cvp15xFEf96YWLvP3ivELcwSdf0snI4C2HOS9Xnpq
	 YEgJy77c6Hq8iXHgepw8qL++nIzXlTJRKdNBa7uwKsYluawFncqWv50OkaOp1uLue3
	 IV6hkd5oX8d6Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P8q5VF1936455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 May 2026 16:52:05 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 16:52:05 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 16:52:05 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 16:52:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <driver-core@lists.linux.dev>, <johannes@sipsolutions.net>,
	<wenjie.tsai@realtek.com>, <mh_chen@realtek.com>,
	<charlesl@valvesoftware.com>, <sabae@valvesoftware.com>
Subject: [PATCH v2 rtw-next 0/2] wifi: rtw89: usb: read serial_number and uuid via sysfs
Date: Mon, 25 May 2026 16:51:46 +0800
Message-ID: <20260525085148.35180-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-36868-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 642705C82BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As what we learned in RFC v1, add sysfs entries
 - /sys/class/ieee80211/phy0/rtw89_usb/serial_number
 - /sys/class/ieee80211/phy0/rtw89_usb/uuid

These entries only present if specific USB device is in use. We add a
quirk as a flag for this.

Above info is fully documented in
Documentation/ABI/testing/sysfs-class-ieee80211-rtw89

v2:
 - add specific sysfs entries in /sys/class/ieee80211/phy0/rtw89_usb/
   * serial_number and uuid
 - add Documentation/ABI/testing/sysfs-class-ieee80211-rtw89 to
   describe ABI
 - add sysfs entries by quirk according to specific device ID
 - include patch 1/2 which does quirk infrastructure by device ID

v1 (RFC):
 - https://lore.kernel.org/linux-wireless/20260519072415.25746-1-pkshih@realtek.com/

Johnson Tsai (2):
  wifi: rtw89: add dev_id_quirks to driver_info for per-device quirk
    control
  wifi: rtw89: usb: add serial_number and uuid sysfs attributes for
    0x28de:0x2432

 .../ABI/testing/sysfs-class-ieee80211-rtw89   | 24 ++++++++
 drivers/net/wireless/realtek/rtw89/core.c     |  9 ++-
 drivers/net/wireless/realtek/rtw89/core.h     | 10 +++-
 drivers/net/wireless/realtek/rtw89/pci.c      |  3 +-
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8851bu.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852au.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bu.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 10 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |  6 +-
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852cu.c    | 13 +++-
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8922au.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922de.c    |  2 +
 drivers/net/wireless/realtek/rtw89/usb.c      | 60 ++++++++++++++++++-
 19 files changed, 138 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ieee80211-rtw89


base-commit: 6b964941bbfe6e0f18b1a5e008486dbb62df440a
-- 
2.25.1


