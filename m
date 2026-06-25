Return-Path: <linux-wireless+bounces-38088-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SOeKAGIbPWp3xAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38088-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 14:13:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA036C572A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 14:13:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=IcbDSo07;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38088-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38088-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED2C5306AA2B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6453DE452;
	Thu, 25 Jun 2026 12:10:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BC3DDDAE;
	Thu, 25 Jun 2026 12:10:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389427; cv=none; b=S1GW8GNSHicZLA0Pfkny3e3i+ZnIku1EYSe5lgmfCwoM6qvQNug8Mu8NslATyJmH0xQicyw2Qw8RC/XIknjJeHwirwtNcMRHGlZJVdWOfmt9oc4N9YlblqEqtL5HWf35+sX9Pcdekusoks8q+WTfnmir0ylwzRwh0xrhn8t4zCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389427; c=relaxed/simple;
	bh=ba/68qyLW4RJgqhb23CSgIV/K9uiVqn6kZrVBreVKm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oti3YK4XycQWhOYldldlaSBkeASt1F7y7uHTf51imSJb8+Ok2rOUWjbWmCYkkTi/U4KpoALHkmew9pR8XG5STsss2nihdYGQBymvrbZRtjyMGFsAGI0pRDaUibWz3aUfMVywat+A5/maTlBZJImUSCTkk4RxmdyJ2s/hs/+GrB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcbDSo07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4070FC2BCF4;
	Thu, 25 Jun 2026 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782389427;
	bh=ba/68qyLW4RJgqhb23CSgIV/K9uiVqn6kZrVBreVKm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IcbDSo0759wPfaItgWUYu6iNa0PiJe8/f0a2fRkgIkghvRn4Ywa1cHiegqcS8TpMc
	 ky6ARcjXOFGnGPLNXBVNQWK3Fo2OdUZpAvy+M5qu2AObGIrm32q9TZylhKsROnTQuZ
	 lJrjCjM7qdFz3RSzbNNKIVavB1PyILN2en91Huyd/5C6OrNuBsBK2HPqU0pdHypCwr
	 /8L4OAEjHOynA989XxMjJ6GWpVc2nB5cd/HRY6bnppfJE2ZTKQ6OQioPzQJ4ZrkCGo
	 DEnvAT6tgW1Tf2+UV65ccsLYb/vfVapYUBR1Jo78X4T/dYATgpfD2KJINXpzaHwjqs
	 lg7clX9MHMA6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344BCCDE001;
	Thu, 25 Jun 2026 12:10:27 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Thu, 25 Jun 2026 07:10:27 -0500
Subject: [PATCH 2/2] wifi: mt76: mt7996: bound the device EEPROM address
 before the EFUSE copy
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-disp-16f99062-v1-2-aee52ecf61b9@proton.me>
References: <20260625-b4-disp-16f99062-v1-0-aee52ecf61b9@proton.me>
In-Reply-To: <20260625-b4-disp-16f99062-v1-0-aee52ecf61b9@proton.me>
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc: Sean Wang <sean.wang@mediatek.com>, linux-mediatek@lists.infradead.org, 
 Shayne Chen <shayne.chen@mediatek.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782389425; l=1841;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=5P3fKrvZnuhhzy5SyS2bn1gs3Kjjy/aad3X2rpiBcW8=;
 b=TzCsJWAssrI7MlgIxRUv7fUA8WIpBL8zgXK9SEJ+kpD7XCKVFah0X2W0VMmAPNTcyBz8sGKgd
 EwFEZjQZrSUA/ZEhUDno/MD/fCtQkyxLt0J5Z8GlzaSOiITTVCGO6/4
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38088-lists,linux-wireless=lfdr.de,hexlabsecurity.proton.me];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,eeprom.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FA036C572A

From: Bryam Vargas <hexlabsecurity@proton.me>

mt7996_mcu_get_eeprom() derives the destination of the EFUSE/EXT block
copy from the address reported by the MCU response (event->addr, a
device-controlled __le32) and clamps only the copy length, never the
destination offset into dev->mt76.eeprom.data. A malicious or
malfunctioning device can report an arbitrary address and drive an
out-of-bounds write of up to MT7996_EXT_EEPROM_BLOCK_SIZE bytes past
eeprom.data.

Reject a response whose address would place the copy outside eeprom.data
before deriving the destination pointer. Devices that echo the requested
in-bounds offset are unaffected.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index f119f023bcd5..01c9adbca68b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -4345,11 +4345,18 @@ int mt7996_mcu_get_eeprom(struct mt7996_dev *dev, u32 offset, u8 *buf, u32 buf_l
 	event = (struct mt7996_mcu_eeprom_access_event *)skb->data;
 	if (event->valid) {
 		u32 ret_len = le32_to_cpu(event->eeprom.ext_eeprom.data_len);
+		u32 block = mode == EEPROM_MODE_EXT ? MT7996_EXT_EEPROM_BLOCK_SIZE :
+						      MT7996_EEPROM_BLOCK_SIZE;
 
 		addr = le32_to_cpu(event->addr);
 
-		if (!buf)
+		if (!buf) {
+			if (addr > dev->mt76.eeprom.size - block) {
+				dev_kfree_skb(skb);
+				return -EINVAL;
+			}
 			buf = (u8 *)dev->mt76.eeprom.data + addr;
+		}
 
 		switch (mode) {
 		case EEPROM_MODE_EFUSE:

-- 
2.43.0



