Return-Path: <linux-wireless+bounces-32175-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMveKXTenml9XgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32175-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 12:35:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DE1968EA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 12:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3A9230D45D0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D74356A3E;
	Wed, 25 Feb 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BAalCMZ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4A35A93B;
	Wed, 25 Feb 2026 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019128; cv=none; b=NVsCri6vshiEPSIdP+95a0qO2j6BTtGY/S6wzI8jQL0nTUG/nbBN+oWGw9zCXq53Q7DmJYmNOJDlDxmbSGrfaWf6tEzyRzDOXUu/uK+ja7P1Z3zuPWj0FcApmxOL0PBh8xg8Tu9FoRCFrQs2P/OeQ7qcc7oegaBcjVWbB+hxiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019128; c=relaxed/simple;
	bh=zhpfY0tW6mUlM/LrUd2CtAhKkrj45rbYAgdl/BFwYoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8oP5ZlOGOKzQPYPgroaqWNfF6NzW89DSDOm+7AKvS+lN9dQQzWwyGnAzHcYAeMV4VVG10wbPuWq65S13p86vjEt/NmKB30rlSQYBCALXG7aQvk9+d+SuMdASotclNufTgQpFAMLa2cTmF8FLlufiYgbezhdcduLtvRVPDjvBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BAalCMZ/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=UBOnCtJsXwUvWJZdCobnV9ydQHVTu9HMk4QIxx/wMd4=; t=1772019125; x=1773228725; 
	b=BAalCMZ/RV6RHJ1HtZzdWXsNrYmIH4Qqw76MrQ8I4c4iRAIoAggQSx0+z6GrYdq9u8V+aLYVa94
	kr0ewJM7UQJ+SiXZUiQEvyjeq/q3U4RRyQa8d+HKZTY4LjpH9z69RSGTyBiJht383UPrusz2GzbYb
	e6gnlxAbMoUvbwKsiR6x5A3FOyd3JTyvAxYIqekb1tIE+2cG+zqCdKol97wHlX6zKG+buM9Fw/o58
	nT7NEByYwQvzWbwXXhY9v4GRBFl70ub8OS3eMLOTVsbbGNzYHkgP9qZt8PjufJhvUNIw/vyCFxbSi
	REEEUGuAvh00UArwhIIKP2iYfbPIojlu5MTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vvD7b-00000001PYZ-0PdV;
	Wed, 25 Feb 2026 12:32:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-02-25
Date: Wed, 25 Feb 2026 12:30:47 +0100
Message-ID: <20260225113159.360574-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32175-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: CB2DE1968EA
X-Rspamd-Action: no action

Hi,

So for some reason a whole bunch of fixes came in recently,
including quite a few (potential) crashes and similar. Most
even are long-standing issues.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 8bf22c33e7a172fbc72464f4cc484d23a6b412ba:

  Merge tag 'net-7.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-19 10:39:08 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-02-25

for you to fetch changes up to 017c1792525064a723971f0216e6ef86a8c7af11:

  wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame() (2026-02-24 10:03:10 +0100)

----------------------------------------------------------------
A good number of fixes:
 - cfg80211:
   - cancel rfkill work appropriately
   - fix radiotap parsing to correctly reject field 18
   - fix wext (yes...) off-by-one for IGTK key ID
 - mac80211:
   - fix for mesh NULL pointer dereference
   - fix for stack out-of-bounds (2 bytes) write on
     specific multi-link action frames
   - set default WMM parameters for all links
 - mwifiex: check dev_alloc_name() return value correctly
 - libertas: fix potential timer use-after-free
 - brcmfmac: fix crash on probe failure

----------------------------------------------------------------
Ariel Silver (1):
      wifi: mac80211: bounds-check link_id in ieee80211_ml_reconfiguration

Chen-Yu Tsai (1):
      wifi: mwifiex: Fix dev_alloc_name() return value check

Daniel Hodges (1):
      wifi: libertas: fix use-after-free in lbs_free_adapter()

Daniil Dulov (1):
      wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()

Johannes Berg (2):
      wifi: cfg80211: wext: fix IGTK key ID off-by-one
      wifi: radiotap: reject radiotap with unknown bits

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential kernel oops when probe fails

Ramanathan Choodamani (1):
      wifi: mac80211: set default WMM parameters on all links

Vahagn Vardanian (1):
      wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 7 +++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 7 ++++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   | 2 +-
 drivers/net/wireless/marvell/libertas/main.c              | 4 ++--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c           | 2 +-
 net/mac80211/link.c                                       | 2 ++
 net/mac80211/mesh.c                                       | 3 +++
 net/mac80211/mlme.c                                       | 3 +++
 net/wireless/core.c                                       | 1 +
 net/wireless/radiotap.c                                   | 4 ++--
 net/wireless/wext-compat.c                                | 2 +-
 11 files changed, 23 insertions(+), 14 deletions(-)

