Return-Path: <linux-wireless+bounces-38574-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i10HN9yhR2qDcgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38574-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:49:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1B7702066
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 13:49:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="BgG/qGJ5";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38574-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38574-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0894304C962
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886BB386440;
	Fri,  3 Jul 2026 11:43:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695B32EEE7C
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 11:43:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078996; cv=none; b=HQYr3LH6k8iJyxkmPJYjLtLvx0saIgHacU274W1cDSrzz9eg7otV+L0S5+QmNWGrC+bW6N5jS4JoNBs015J5O+GSgYrL/Ws3jZ72BUo46ka2W1975rrAJLHhS5XceYrx7r9EoommaPN9W/FQ/kjfICCe5J2yIR+pQQo8GP9wL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078996; c=relaxed/simple;
	bh=mgP8p7JmwpZkS6T2JBXHH0yGes/DEAzmsAkP339zyP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NtCBzcIwwjUjckC6zDZCHKPqu+umuJs7xf5H70p3sPyny1DflkN3KVll+Sk48IRdL2iuxEDP6Xt4jqHwY9vy7X7lIFYXizowNM6qMNSdPM75qLmw2hT6CtY9kwZfkWa4iBPIUpGo53nsVuSlVE31Cbb1kqcqtvbUV5pnGMCrhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BgG/qGJ5; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 663BhCvT52636859, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783078992; bh=zX5Kr0MNBND4NOEMn7vUBUqcBiVbEUjGW1oKOQnJQGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=BgG/qGJ5L99Eu4kukTOjwEdkI0wvgEegMQHf1YIIzxT/C/mqjMvtF2Vj8fdaxlv0l
	 8/XgaXrHnOtDUOZl3L+FVC/fgnuK5dQA2BV4lyLTComk0VgxaI9thExst+g/YQhxHQ
	 yX2V7Uv0yZWujppn/oj7EcgzvqD5+WaSEPrs8vHo4lQn58qL9/m9mLBurAT2wLsKaC
	 WfAbAZ9WEj/RRl+FQ+ml/EgFg3p7+FUpZQqCx6V6zVdFWWzO/yOEOEe8Ho1NnQiwMo
	 9oIk2y6C845+b5A/kk0mqzhmCIcplfhj6OPeIbUZX4bIcMZi3vk6zsKE+3fy609jsP
	 IIULBm2B3MJrQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 663BhCvT52636859
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 19:43:12 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 19:43:12 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 19:43:11 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 19:43:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 0/9] wifi: rtw89: coex: implement components for dual Bluetooth
Date: Fri, 3 Jul 2026 19:43:02 +0800
Message-ID: <20260703114311.2609942-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38574-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:dkim,realtek.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F1B7702066

Extend more components of BT-coexitence to support dual Bluetooth,
including TDMA descriptor, TX power, RX gain, scoreboard and etc.

Ching-Te Ku (9):
  wifi: rtw89: coex: Add Init info version 10
  wifi: rtw89: coex: add rtw89_btc_init() entry for initialization once
  wifi: rtw89: coex: Update TDMA descriptor for dual MAC
  wifi: rtw89: coex: Add Bluetooth binding for Bluetooth TX power
    setting
  wifi: rtw89: coex: Add Bluetooth binding for Bluetooth RX gain setting
  wifi: rtw89: coex: Add WiFi/Bluetooth adapter binding info
  wifi: rtw89: coex: Add TDMA binding for dual MAC
  wifi: rtw89: coex: Update scoreboard related logic for dual Bluetooth
  wifi: rtw89: coex: Add Co-RX logic

 drivers/net/wireless/realtek/rtw89/coex.c     | 1493 +++++++++++------
 drivers/net/wireless/realtek/rtw89/coex.h     |   16 +
 drivers/net/wireless/realtek/rtw89/core.c     |    5 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  241 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       |   41 +
 drivers/net/wireless/realtek/rtw89/fw.h       |    9 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |    2 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |    1 -
 .../wireless/realtek/rtw89/rtw8852b_common.c  |    1 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |    1 -
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |    1 -
 11 files changed, 1298 insertions(+), 513 deletions(-)


base-commit: 2b7858891b100587c10c136cf07205335a897be0
-- 
2.25.1


