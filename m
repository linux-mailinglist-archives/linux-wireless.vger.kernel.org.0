Return-Path: <linux-wireless+bounces-34161-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILYKMwggymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34161-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:02:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C760A3562CE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 09:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B42630037E4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE36D36492D;
	Mon, 30 Mar 2026 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kpTsclaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE940286D73
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853931; cv=none; b=tGPHvxYA/2dHcoe1dAPl1U2hWuSrt5QQ3yml4TnPkXWVM+Bq7dQ1BseQ6I9CGpnC32yuXBrHpZLe+yYyVvzcqFG/zOjPVenuasoJ29t8sHgCRy5SWEWrFjBjw+zfcyqfee/r4bpklCL1gNlVDbk3BMeMeR1cXW+rwUvTzAc7e/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853931; c=relaxed/simple;
	bh=zZlTTyflrIfmQoW1F0VPmYgLnzP0qtbSUT3TqZiINuM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RzHIT6DhtTVpLsfFDiF6WFFPlQZI5ylM3HWbTxgcgekhf9/Udm9NRMV2Up5PLzNJ7r0MWFDLLuv6hjcePeaXLisd5NawHv9Hmmw9/QFF5aXfpS/ukIu4L/eQhSIs08kDAzIkdbVSynDUP7ndstZOBzBrNstMt+MaCWj+TxV7ecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kpTsclaj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6wlWM3673778, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853927; bh=IdzdeDlNuut7p3qWlNd2hnbYOm+TC7E//ZN0r49rd5A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kpTsclajAddkLv+7UFm+jznrZUf5M51gqVp1OsdTUOLN9t3mvkxRgar3SHcTJCJms
	 /qg4hQcvzZbeaRuVNdsxtrApV+gK+X+CGd42cWatCGmnYLmbEIX9NwlokR88yCdoic
	 oRBX3sV7fO/KuPP6qAwRpmeHmPePsIKAwI06I9F8sytWqPa5gl6GQinZRHYQ6RqTAs
	 BE4UFJFzdBg6Cfzg8xsd0FvGjIGekiRaKAnS6Aq7HE1+GRcff9Pkx9zLQI9MEy6AQ7
	 c1/9arC+qMsoZRDq3q7Ywr5iDcl9fEBXHa85+uc9xThQOoV/NZ4LsfB662vGBVyVGj
	 ALY+6fUm/98Ew==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6wlWM3673778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:58:47 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:58:47 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:58:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 0/9] wifi: rtw89: 8922d: add RTL8922DE part 2/2
Date: Mon, 30 Mar 2026 14:58:38 +0800
Message-ID: <20260330065847.48946-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34161-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C760A3562CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add part 2/2 of RTL8922DE, but yet enable it by Kconfig/Makefile because
we are still developing and testing BT coexistence mechanism, which is a
shared component and can affect all existing chips. Otherwise, RTL8922DE
can work with the highest rate and STA/AP modes.

Since we are continuously adjusting common flow to support new hardware
settings of RTL8922D, I'd add RTL8922D first followed by patches of new
settings, so people can be easier to understand why/how actually it does.

Ping-Ke Shih (9):
  wifi: rtw89: 8922d: BB hardware pre-/post-init, TX/RX path and power
    settings
  wifi: rtw89: 8922d: add set channel with pre-/post- helpers
  wifi: rtw89: 8922d: add RF calibration ops
  wifi: rtw89: 8922d: add set TX power callback
  wifi: rtw89: 8922d: configure TX/RX path assisting in BT coexistence
  wifi: rtw89: 8922d: add RF ops of init hardware and get thermal
  wifi: rtw89: 8922d: add ops related to BT coexistence mechanism
  wifi: rtw89: 8922d: add chip_info and chip_ops struct
  wifi: rtw89: 8922d: add PCI ID of RTL8922DE and RTL8922DE-VS

 drivers/net/wireless/realtek/rtw89/core.h     |   21 +
 drivers/net/wireless/realtek/rtw89/fw.h       |   23 +-
 drivers/net/wireless/realtek/rtw89/pci.h      |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  127 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |    4 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |    4 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 1338 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.h |    3 +
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c |  339 +++++
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.h |    8 +
 .../net/wireless/realtek/rtw89/rtw8922de.c    |  119 ++
 15 files changed, 1996 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922de.c


base-commit: 658e3c836969e1624a7572c75684f54ec503c2ed
-- 
2.25.1


