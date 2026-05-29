Return-Path: <linux-wireless+bounces-37103-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEKfFkhGGWrHuAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37103-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 09:54:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A63935FED7A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 09:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE81F30C6CC0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 07:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9B33ADBF;
	Fri, 29 May 2026 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="W3Jc7t+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA572E739B;
	Fri, 29 May 2026 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041059; cv=none; b=cl+CxV1AGK+RbKBBkIcU7zVB906ucSiAP5Nc7VvjTaQWuWR90XGUQeF3q6KXGlk8qYko66bVZCvofo0kPFrd+ChQzVDxt63/+LqCo++AZpCaLKs9Lt5IJS6yTNXDhDNVHH54CuroqSY0YxOuwfd8IRAqWnQtxq7pYChbeTcYc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041059; c=relaxed/simple;
	bh=EstwLubWSjWqk+HFRl2jJt9s59sJINAC34RY6DA31CU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uZPFPba5E0IrEczPMXyMeGo84tpnbTnH3s6gXHyeaQQMf6xdjC01I+PDxQXK1osR88nd/eU+5KQgDsPCnqLNbvCQ48U/uquWvHgMXEf14W9PkSgmogHc32rDxbrxXrD8ZfgmdO7Ov0nEFJJxzSnMaM6J5uJF7X1/BKE50lcXPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=W3Jc7t+9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64T7or6P33998901, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780041053; bh=KrD3qKN3vikxdqi7Nwg3lGTTPh/7aWU68TmFXg8PaPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=W3Jc7t+9XeO4bJpKG79iDgLHYec5DLoMqKFW0EN6H325UHISfZJbGgcpJ2aFUFWKc
	 r0UxfxGfsrsPNX/+WBKhrPeW/5gm/FFLlnxuexEyOFaa1245q9dCpfgwjugTYB5kYT
	 a3Fl2luXeOnrIL10G2Uvpi/SloKmeW+TV3C2pvhpcCPDEaslUVgjxPTw+oc5UNCm5F
	 m7caWs+lD0sPdRjX3s2zMsIGUJeWnDm14oszQdLiRTS7NW8A/qzonV7o9BwelYdcNy
	 PMuwRPeLNWirtR59wzoRQvQtNa8HM1a7cSlORByH2/ECRt2+YxXcRNy8JctC78am8E
	 prDxuUKrmNK1w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64T7or6P33998901
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:50:53 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 May 2026 15:50:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 29 May 2026 15:50:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <driver-core@lists.linux.dev>, <johannes@sipsolutions.net>,
	<mh_chen@realtek.com>, <wenjie.tsai@realtek.com>,
	<charlesl@valvesoftware.com>, <sabae@valvesoftware.com>
Subject: [PATCH v3 rtw-next 0/2] wifi: rtw89: usb: read serial_number and uuid via sysfs
Date: Fri, 29 May 2026 15:50:30 +0800
Message-ID: <20260529075032.16807-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37103-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Queue-Id: A63935FED7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As what we learned from RFC v1 and v2, add sysfs entries via dev default
group (dev->groups)
 - /sys/class/ieee80211/phy0/rtw89_usb/serial_number
 - /sys/class/ieee80211/phy0/rtw89_usb/uuid

These entries only present if specific USB device is in use. We add a
quirk as a flag for this.

Above info is fully documented in
Documentation/ABI/testing/sysfs-class-ieee80211-rtw89

v3:
 - create sysfs by dev default group (dev->groups) instead of
   sysfs_create_groups() to avoid racing with user space

v2:
 - add specific sysfs entries in /sys/class/ieee80211/phy0/rtw89_usb/
   * serial_number and uuid
 - add Documentation/ABI/testing/sysfs-class-ieee80211-rtw89 to
   describe ABI
 - add sysfs entries by quirk according to specific device ID
 - include patch 1/2 which does quirk infrastructure by device ID
 - https://lore.kernel.org/linux-wireless/20260525085148.35180-1-pkshih@realtek.com/

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
 .../net/wireless/realtek/rtw89/rtw8852cu.c    | 13 ++++-
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8922au.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8922de.c    |  2 +
 drivers/net/wireless/realtek/rtw89/usb.c      | 55 ++++++++++++++++++-
 19 files changed, 133 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ieee80211-rtw89


base-commit: 8368970b62404ce2ce70d04c1cfff62700d7d8d5
-- 
2.25.1


