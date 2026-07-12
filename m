Return-Path: <linux-wireless+bounces-38901-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PW3DHwYOU2p+WQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38901-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED5A743B70
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:46:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=lR3TnU2+;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38901-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38901-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F0583002D36
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0841846A;
	Sun, 12 Jul 2026 03:46:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088502BDC26
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:46:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783827968; cv=none; b=oH4k21tzGPHuoEpTWk4PhAKvDMJgrAx0f0bU1XRK363h7m8oYTUZDLsW9zujrxq1SutniP2LU1E18oRQW3Ie3B1FWvNl/PcOaGSdLGTRZBUYC6dWk6y8UERlvcxhtlD0qiTwM7UEaoE4FuvLWQscoRAJzthXPcIraa2U6SoIL+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783827968; c=relaxed/simple;
	bh=DtJu+74HkfLvEXHK/4TukUMSVqEL4r8cJsPff/1Zft4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DUn4DDhTFq7iYaTvbv8ylt5m68PfFXCpk6IFnD0ISnpgltdBeAKZwOLkfTqay6fw+i3K9sHpAd0MwhjtGS81TCJ+5yGqH95f6h4CnUtZasP5M+mTxC+rVEsI8b1VZfI4YwcSIDj56D7e061x5wCzoVphf3DL4m5Cy1A93SLj6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lR3TnU2+; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C3k4Wc9535579, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783827964; bh=04UJBjKcY7jS3CaogdhNr+rfcbi4l9poFkcBXDTsb5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=lR3TnU2+9NkRRWGheSTkSpZMX5YXcWigQXTxPBgWdx5IsnuhU2Ndu9B+QKKUVS1Ee
	 e0seW6w/K//jH7YT+GFIZrS83UBHQ2p+OZ+x/gtpBbdIup43HRcgVk6oI+TbQX5+hB
	 ReLo1wXdtgDsm6I64a7d/M5y9MSC0UKti3sB3j2qOmZUjlOq8JzB+/uxx3pXOCATlh
	 tbyYGsSk3J1sEupn9wkSX5+ytb2gM1RBSzW6YxNtVWmkOgOacEOR6iwoc3QYHaHHHr
	 7rENCr3fQP681dGEp6Jx1AFpI9RAYd3F2wJ3xzPhXMdHNJ8wdn6kl/RidyN76NOT9T
	 W4qzv9EamSTRA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C3k4Wc9535579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:46:04 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:46:04 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:46:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/8] wifi: rtw89: add RF diagnosis and update random patches
Date: Sun, 12 Jul 2026 11:44:58 +0800
Message-ID: <20260712034506.53209-1-pkshih@realtek.com>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38901-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:echuang@realtek.com,m:kevin_yang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ED5A743B70

First patch is to reduce IO time for USB device, which is addressed by real
time measurement.

The second patch is to abstract a register for WiFi 6 and 7 chips to read
firmware state for boot debugging.

Patch 3/8 is to resolve RTL8922DE interoperability issue operating in 2GHz
channels. Limit the TX time to prevent peer can't receive packets properly.

Patch 4-6/8 are to extend TX shape per 2/5/6 GHz bands to satisfy
regulation for each bands.

Patch 7/8 is to properly co-work with BB registers access in firmware, so
driver should power-on BB circuit to ensure possibly accessing.

The last patch is to add RF diagnosis assisting in debugging.

Eric Huang (1):
  wifi: rtw89: pack I/O during bb_sethw to reduce API execution time

Ping-Ke Shih (3):
  wifi: rtw89: mac: abstract register definition of firmware boot debug
  wifi: rtw89: 8922d: add TX time limit for 2GHz band
  wifi: rtw89: fw: do bb_preinit before downloading firmware

Zong-Zhe Yang (4):
  wifi: rtw89: introduce helper to get tx shape index
  wifi: rtw89: add tx shape v0 to keep built-in arrays compatible during
    transitions
  wifi: rtw89: extend tx shape format for regulatory 6 GHz power type
  wifi: rtw89: debug: add diagnosis for RF

 drivers/net/wireless/realtek/rtw89/core.c     |  83 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  74 ++++++++++-
 drivers/net/wireless/realtek/rtw89/debug.c    | 115 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  21 +++-
 drivers/net/wireless/realtek/rtw89/fw.h       |   2 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  28 ++++-
 drivers/net/wireless/realtek/rtw89/mac.h      |   4 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  62 ++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h      |   3 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   7 +-
 .../wireless/realtek/rtw89/rtw8851b_table.c   |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   6 +-
 .../wireless/realtek/rtw89/rtw8852b_table.c   |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   7 +-
 .../wireless/realtek/rtw89/rtw8852c_table.c   |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  10 +-
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  18 +--
 22 files changed, 400 insertions(+), 61 deletions(-)


base-commit: 56d32cdc6040440b08edfd5d7262250a721233f8
-- 
2.25.1


