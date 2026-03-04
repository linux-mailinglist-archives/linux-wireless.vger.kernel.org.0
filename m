Return-Path: <linux-wireless+bounces-32459-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIIPI7sWqGlTnwAAu9opvQ
	(envelope-from <linux-wireless+bounces-32459-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:25:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D21FEF27
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 12:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ED063033AA4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726D3ACA74;
	Wed,  4 Mar 2026 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="geXO56BO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F43A8738;
	Wed,  4 Mar 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623505; cv=none; b=cejdFnWLbOkdr/w13LqY85SuMQt4WsFPii4oEnQd1A94LA4GAvWV+WO5EraA6Cb3hZbmyIoYoHVcpa26DFX8UEJlIJCMyBxzLDrYwUTrz1dpAypfT0JmHW5dqHtYAK14nrM4bBCBcJl+tlN0PyJ9ROG3C5REz5n51cQnIoOJJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623505; c=relaxed/simple;
	bh=T1MqSj4t02fYLwrDUd4BceSRqO9Y7bt8oS2LbSoXV+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=loc5aKKclr4n+OkrKdyC/hVorwOmdLKJr2yRJJfFU/c+Z3oWCmUt4RPToYmiqV0aBvMmTQmeCO3bRc39PmsHhlcunY2Wcw38T11Aab3NJBQyZEjiUljE0xhGVoHiKEwf7mibi1HJ0KMGNWa8hI8CYXUtXVwtE9r+pfuL5dVklcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=geXO56BO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=bkOgEIlWHb2dcsrAoQ0NNF/UqerkSCmXqlLQzBvfEZc=; t=1772623504; x=1773833104; 
	b=geXO56BORWFfEhCgA668eetxKSULZhlcdPw+aeBUQdkxAdzU0d4lxPP7pOeOx9Wd5TKHT8UOhRB
	ayYe+2pj+y+WYmu3Uvz85OgQHuRwjC/1E8o+8sxUxYPUHhvaVIxEaz1vuHNajKViSd+tySE6EPmzW
	Q7VLN99y2AvJnWZ1kki78TxU42jauVUE5A7pv3PaNW94iEkCyKqUb8fbeGkjNoO1gvbgCFFAHMGAQ
	aRRp2rQ8Nid9CfZiNt7pPnNDKgy7969eP+kSGkW8Bnd4D30Es2bFNYjyu8PNEMB69WBon2H/dMdKh
	nuCLpenEMAvx01q8B830ujgYsSGYd35B/F8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxkLe-000000082jc-1kqN;
	Wed, 04 Mar 2026 12:25:02 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-03-04
Date: Wed,  4 Mar 2026 12:24:37 +0100
Message-ID: <20260304112500.169639-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 150D21FEF27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32459-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

Hi,

A couple more fixes, I'm mostly sending this for the mt76
fixes which conflict with some other upcoming work for
-next, so I can put it all together next week.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit b9c8fc2caea6ff7e45c6942de8fee53515c66b34:

  Merge tag 'net-7.0-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-26 08:00:13 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-03-04

for you to fetch changes up to 4e10a730d1b511ff49723371ed6d694dd1b2c785:

  wifi: mt76: Fix possible oob access in mt76_connac2_mac_write_txwi_80211() (2026-03-03 12:13:36 +0100)

----------------------------------------------------------------
Some more fixes:
 - mt76 gets three almost identical new length checks
 - cw1200 & ti: locking fixes
 - mac80211 has a fix for the recent EML frame handling
 - rsi driver no longer oddly responds to config, which
   had triggered a warning in mac80211
 - ath12k has two fixes for station statistics handling

----------------------------------------------------------------
Baochen Qiang (2):
      wifi: ath12k: use correct pdev id when requesting firmware stats
      wifi: ath12k: fix station lookup failure when disconnecting from AP

Bart Van Assche (2):
      wifi: cw1200: Fix locking in error paths
      wifi: wlcore: Fix a locking bug

Johannes Berg (1):
      Merge tag 'ath-current-20260302' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Lorenzo Bianconi (3):
      wifi: mt76: mt7996: Fix possible oob access in mt7996_mac_write_txwi_80211()
      wifi: mt76: mt7925: Fix possible oob access in mt7925_mac_write_txwi_80211()
      wifi: mt76: Fix possible oob access in mt76_connac2_mac_write_txwi_80211()

MeiChia Chiu (1):
      wifi: mac80211: fix missing ieee80211_eml_params member initialization

Sebastian Krzyszkowiak (1):
      wifi: rsi: Don't default to -EOPNOTSUPP in rsi_mac80211_config

 drivers/net/wireless/ath/ath12k/mac.c              |  6 ++--
 drivers/net/wireless/ath/ath12k/wmi.c              | 36 ++++++++--------------
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |  1 +
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    |  1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  1 +
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |  2 +-
 drivers/net/wireless/st/cw1200/pm.c                |  2 ++
 drivers/net/wireless/ti/wlcore/main.c              |  4 +--
 net/mac80211/eht.c                                 |  1 +
 9 files changed, 25 insertions(+), 29 deletions(-)

