Return-Path: <linux-wireless+bounces-34767-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFT3OGN532nFTgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34767-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:41:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1113B403F13
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952FD300823C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E1246781;
	Wed, 15 Apr 2026 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Si79Lpj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AFA1CFBA;
	Wed, 15 Apr 2026 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253160; cv=none; b=lIR9o0yuQnEZGtSMh+p6c4j/279XqsXhQvfbxivDieRtBe6Wg1mlk6TL8kymuP9985R+aX+W3b9oQLtpkGgyTksLORp+KdcEZe3mZpDuAceBq8H62FfT0VY8eIDiai0ORLwZjy2YsNwwIIZtu0RPJ3+TrwvUm+RuaiRp/Cz+hQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253160; c=relaxed/simple;
	bh=JxotkZNGGVp6+Jfj35t3XJ8WSJ91VDrnPfRI530PwRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QQpkESJsvsBwYh10mtc8C+Vwanat7Vz9sZ7J5mIxpbYRxtBE62YaeJCxZaZhPt1RIkaxQWAJ+W3JIbJoVGdZS97YYvm4uT6+d/nhDocTysLHOs929xKj9U9NGQSp918dD2AyWIE48qukXcW1LIJaJuae+Ypi2UyhB7BrGOK6528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Si79Lpj9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776253150;
	bh=JxotkZNGGVp6+Jfj35t3XJ8WSJ91VDrnPfRI530PwRw=;
	h=From:Date:Subject:To:Cc:From;
	b=Si79Lpj9kP7EF51Yk6vjhjTvDNw8ncA4HIZtiMvoWpNUHA5xwFI5s2vX1dXlw5cXs
	 RT2XiuHb6o4+kIXzHrW7buAjITQAoPWulGH41VxZrLFMWOJwv6cxjYbDKRtYZtSJ9w
	 bki4UN+/s8r2q2apOpCyV/5BK2NFNKGL7SNlLXQqDCgaSlP31WXoYedwneVFRW2hJU
	 u90JqvtclcEgt9lHnmYXvSnwfaNFQdCXYB7FxSQST7JoMEHCyP6Z86PMQJ3i0R2Lym
	 +MM55Ea2R+Xf3tgePEVXDRXGuX9WLAvHujAF5FsT/C2UR3J35Pkyv4bTws48ZDx0B2
	 w6QGx3XkI5OCQ==
Received: from [192.168.1.53] (unknown [100.64.0.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 461CD17E1356;
	Wed, 15 Apr 2026 13:39:10 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Wed, 15 Apr 2026 12:39:02 +0100
Subject: [PATCH v2] ath11k: fix peer resolution on rx path when peer_id=0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-ath11k-null-peerid-workaround-v2-1-2abae3bbac16@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBREr0K69ht+CYiuvIdhUdoildqSX0AN6
 d0teAGXL5l5MysLmowO7JKtjPRigvEuAT9kTPbC3TUYlZjxnFd5wSsQU484gJuthVGnsoKXp0G
 Qn52CipcC+flUY4ssOUbSnXnv/lvz4zC3Dy2nTbolehMmT5/9wIJb7t+tBQEhl7xTZZEqXX2V3
 lrRehJH6Z+siTF+AbW8HBPgAAAA
X-Change-ID: 20260326-ath11k-null-peerid-workaround-625a129781b1
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Matthew Leach <matthew.leach@collabora.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	TAGGED_FROM(0.00)[bounces-34767-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1113B403F13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It has been observed that on certain chipsets a peer can be assigned
peer_id=0. For reception of standard MPDUs this is fine as
ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
based upon the source mac address.

However, on an aggregated link, reception of AMSDUs results in the peer
not being resolved for the second (any any subsequent) sub-MSDUs due to
the peer_id guard in ath11k_dp_rx_h_find_peer(). This causes the
encryption type of the frame to be set to an incorrect value, resulting
in the sub-MSDUs being dropped by ieee80211.

ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1

This patch removes the null peer_id check in ath11k_dp_rx_h_find_peer(),
allowing peer's with an assigned ID of 0 to be resolved.

Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
---
Changes in v2:

- Since peer_id=0 is a valid condition on some chips, remove the guard
  that prevented the peer lookup.
- Link to v1: https://patch.msgid.link/20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com

To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: ath11k@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 49d959b2e148..ff2c78a4e5f3 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2215,8 +2215,7 @@ ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
 
 	lockdep_assert_held(&ab->base_lock);
 
-	if (rxcb->peer_id)
-		peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
+	peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
 
 	if (peer)
 		return peer;

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260326-ath11k-null-peerid-workaround-625a129781b1

Best regards,
--  
Matt


