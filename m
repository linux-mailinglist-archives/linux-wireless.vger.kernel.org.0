Return-Path: <linux-wireless+bounces-38089-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xKECAGMbPWp4xAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38089-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 14:13:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D46C572F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 14:13:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=qS4jsola;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38089-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38089-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33AE6306BB8D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2A3DE45A;
	Thu, 25 Jun 2026 12:10:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11C3DDDA8;
	Thu, 25 Jun 2026 12:10:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389427; cv=none; b=pqjngWpotIaBCfjCPK6W3P4ZT94R63RQpbGXP7PEzThnqRA9olX8CoIc19tjRv5Mg+SE+CnBW5/q0GSdKD2fsR7SVLDkW17gMYwzK7Oe7IXS64nBcy4CMuVVpClND1UJWDSyyu9hUCOqT8DAttvOF186gigmrPMawSyV54w8TvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389427; c=relaxed/simple;
	bh=aEqGl/t2oeE3z5GCNLJYJ3vk5L2f28hG2tdsN4d5BLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=klJbIGnNZOzjkP2VE5/xFeWixqXYsDq/OCuB9W8J+B2h23SGFFqvABKYZbLdiAt/EaVYGZgao92OOXj9bxM6EgtPVQfHuhpR52j7u6IVyVEO5+vxELCAgd34NQ/3tOy7DLawT26aaqzAR6lPaOyTyjG2RNH9OEalP9ikv3SPOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS4jsola; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 150BCC2BCB4;
	Thu, 25 Jun 2026 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782389427;
	bh=aEqGl/t2oeE3z5GCNLJYJ3vk5L2f28hG2tdsN4d5BLI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qS4jsolariue/Qa5Yhu/dzHltsP3icGVPnQ4OcO2wQdkYLCDeC0SrPcTo/OawaO3u
	 qFC5xGZVAsARGHikM+dk528euNhbeLaMwgoO4bOWLVN4VBzWp6KCI6faaFRSPtP7ML
	 3zfN1q2i1E5RIZiRsvVOqd9CW5JK4syGKlMnuO92FuKDy/6P23cwF0xGoMPwjKw3BK
	 8+mo+Z9vui1DDdbGuoa8P84GOWrva4CECt8pJo8VS06Uurkmf/gNY3i2YoBv7r/EOm
	 5TrEZjd01D23FkSr9PfEhoXXPTpdRgBrq5UsUZMA+ajYSrm/fpBDslVnFWIbZmyG8O
	 qNgaUp7O13KSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED9BCDB479;
	Thu, 25 Jun 2026 12:10:26 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Subject: [PATCH 0/2] wifi: mt76: bound the device-reported EEPROM address
Date: Thu, 25 Jun 2026 07:10:25 -0500
Message-Id: <20260625-b4-disp-16f99062-v1-0-aee52ecf61b9@proton.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALEaPWoC/x2MQQqAMAzAviI9W9iGVuZXxIOzVXuZsoEIsr87P
 CaQvJAlqWQYmxeS3Jr1jBVs28B6LHEXVK4Mzjgy5HoMHbLmCy1t3leDhpkseQ5+CFCzK8mmz7+
 c5lI+pfRdiGIAAAA=
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc: Sean Wang <sean.wang@mediatek.com>, linux-mediatek@lists.infradead.org, 
 Shayne Chen <shayne.chen@mediatek.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782389425; l=1450;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=aEqGl/t2oeE3z5GCNLJYJ3vk5L2f28hG2tdsN4d5BLI=;
 b=WbuVeuUOSSAzABLV05jlMQnSZpj/raKBFDPyhwD8be073heZMHbwiVoYI6fAQpTaqNsazavWJ
 23UyCJqyU2hAq4LnYOQK+5yYicaiaORXEMLHfn0uQiomcyovRq4UWmY
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38089-lists,linux-wireless=lfdr.de,hexlabsecurity.proton.me];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:nbd@nbd.name,m:sean.wang@mediatek.com,m:linux-mediatek@lists.infradead.org,m:shayne.chen@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,eeprom.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C1D46C572F

Both mt76 get_eeprom handlers copy a device-reported EFUSE block into
dev->mt76.eeprom.data at an offset taken from the MCU response (res->addr /
event->addr, a device-controlled __le32). They clamp the copy length but
never the destination offset, so an adapter that reports an out-of-range
address drives an out-of-bounds write past eeprom.data -- 16 bytes on mt7915,
up to 1024 on mt7996. Both patches reject such an address before deriving the
pointer; a device that echoes the requested in-bounds offset is unaffected.

It is adapter-side only -- there is no unprivileged user path -- so this
hardens against a malicious or compromised device, not a remote attacker.

An out-of-tree KASAN module that reproduces each handler's destination
arithmetic faults the unpatched path (slab-out-of-bounds write past
eeprom.data) and runs clean both with the bound and on an in-range control.

---
Bryam Vargas (2):
      wifi: mt76: mt7915: bound the device EEPROM address before the EFUSE copy
      wifi: mt76: mt7996: bound the device EEPROM address before the EFUSE copy

 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 11 +++++++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c |  9 ++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)
---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260625-b4-disp-16f99062-0dd6169db97b

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



