Return-Path: <linux-wireless+bounces-33236-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id puhBKoKJtmlmDAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33236-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FCC29065D
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 11:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 892903012EB4
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7D26ED41;
	Sun, 15 Mar 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRBkCMy9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92522068D
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773570431; cv=none; b=Y45PSvxZ1Lg0KykFwN1GKlbS3D1pYdlnDuzNsiHgNG1G6x0LTuJ379QQn+3PhdoniZVr/pAPvhNXCOpAHqOykXsJMHLbXkqevwotH9VNG092d0H6URpHZCB0rHmDsZdzr08q2thSQrMAkFEybmLaRpyyOB5c6NpvUnYhron96DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773570431; c=relaxed/simple;
	bh=9eAzYooisbP12oFc8Fb2q0lVRb3E7ZJX32SroUaFStQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=reoPct3hAlllcX5rhwK+1HKft8ndi5kAJTotWEPwqZvieP6up8STSDW7GF2/NRAQW51UDOuQSvqjwKzmQVYtHQpcfQxdcJTK/jRAWhKwUItOHA9qGtoElnGLXlXMhHMX62tJzXaDshsa+hkaKayofYWooqSSdx/J0t0gSREzpi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRBkCMy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6FEC19424;
	Sun, 15 Mar 2026 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773570431;
	bh=9eAzYooisbP12oFc8Fb2q0lVRb3E7ZJX32SroUaFStQ=;
	h=From:Subject:Date:To:Cc:From;
	b=mRBkCMy9F69Keoh+WtONtq7vPc6ZwdtwagaN9exgvKWRSNxLz4w3rbJkn/kRLzLX8
	 9+PihIjxmpyhPzNqxuYVl8XvfodSH357CC94DG3zw2eyUSOeKsbk86E1RB/wkwgFPP
	 Io9H7dBUOwr7wQcqMbFlXSTp6yl5hM9fLZpPly6m6HLmZOEBz4gcGEhSLtPa0disgX
	 UEsVX5sUpCeGTP4zCi0Klc/ajExh+BVCAuTH7lh2kgMYO4OpLJpOg0PMMWepYXrmgg
	 IhY0sAoM57DU8dqq1+//V1lC7h+HAVDwblq7pb/JvUqb1tsReIjnSvU22/JdQ6+COd
	 Th7oSGuDrK5vQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH mt76 0/6] wifi: mt76: mt7996: Rework vif/sta links
 management for link reconfiguration
Date: Sun, 15 Mar 2026 11:26:23 +0100
Message-Id: <20260315-mt7996-mlo-link-reconf-v1-0-a8a634fbc927@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrDuQjDVNehVx0cZRh2oiiZSC5
 O4NLv/i/RMyJ+EMz+aExF/JEkMNfWvAL68wM8pYG0iRUUQat+PhnMFtjbhK+GBiH8OEXctvy6O
 7k1VQ8Z54kt817qEaA0Mpfx85TFhuAAAA
X-Change-ID: 20260221-mt7996-mlo-link-reconf-53eb8ed94280
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33236-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03FCC29065D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rework vif/sta links management since MT7996 hw requires to remove AP MLD
links from MCU configuration during AP tear-down process (e.g. running
mt7996_remove_interface() for vif links or mt7996_mac_sta_remove() for
sta links).

---
Lorenzo Bianconi (3):
      wifi: mt76: mt7996: Rely on msta_link link_id in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Destroy vif active links in mt7996_remove_interface()
      wifi: mt76: mt7996: Destroy active sta links in mt7996_mac_sta_remove()

Shayne Chen (3):
      wifi: mt76: mt7996: Account active links in valid_links fields
      wifi: mt76: mt7996: Move mlink deallocation in mt7996_vif_link_remove()
      wifi: mt76: mt7996: Add mcu APIs to enable/disable vif links.

 drivers/net/wireless/mediatek/mt76/channel.c       |   9 -
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  22 +--
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 208 ++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  66 +++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  34 ++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  11 +-
 7 files changed, 255 insertions(+), 97 deletions(-)
---
base-commit: dab5edc5546c90674cfff033abc2b797b3ad4bf4
change-id: 20260221-mt7996-mlo-link-reconf-53eb8ed94280

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


