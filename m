Return-Path: <linux-wireless+bounces-31748-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAw4OwATjWl/ygAAu9opvQ
	(envelope-from <linux-wireless+bounces-31748-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 00:38:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D8128542
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 00:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04A68301DEE4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 23:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE073126C6;
	Wed, 11 Feb 2026 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtUCrbYA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFE30BF6A
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853116; cv=none; b=BRHxmryEpB40Ag8SuSOUq8piFC3pU3CS+4hf/wub9wQ1NZtB1mqDDz+9deVDhms2i+OPry4mBAOeHKC21uL+5mqhE5iyhZNlFXiy0RjkVgvVWTjfgzxkKsZL7qqavhDu+inNLvtXZdthwZzo6msqbHSD3k1OYpcWHZIYAL33VzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853116; c=relaxed/simple;
	bh=it7xxqR3nRf+CWdhr3flpBFaO+KXJCAoNFC9nnWszxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q+te6/jE62CsUHFhqVRe6cC+96HbFzhw3laRUwLZHZV39KkqfXyiSjYlS1oKYcWmgfi2Riv7oKsz3ewdawbOCJ8TUy6SjBZTw//D/K+TCSCb8mSS55Qlx4SU77WL/R7ll/W209fdHwZbZD1iiy6yID7rFv6MLryPWBvYZBGBhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtUCrbYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F80C4CEF7;
	Wed, 11 Feb 2026 23:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770853116;
	bh=it7xxqR3nRf+CWdhr3flpBFaO+KXJCAoNFC9nnWszxM=;
	h=From:Subject:Date:To:Cc:From;
	b=TtUCrbYACGpciyM1n42bkifcm+nlbRdf4HbtPAUW3Ty6YogNiA/lb/OdcA/g8TjSe
	 9f4r1oUUozspNN0h+8KLogq+odaOWdvX3d31WHnFfVU3ofkGHt14oLc2Ga9s5szp/E
	 AHFBPDPiuhsa4sxqF2MHXwOY+VRoKpJOVb/4SPYVWiH0PmNC3xHdKQcAxJ2iPeDjmH
	 zgvNjK/T4BGjvRL9IIcqzUbHjxnC6z2+FO7tN45fdGxRaq4InEIPLjehcjJEUZyxn4
	 mylprGQ8pIUNVlCkW3AsT27YXEH8ykA+ujIjVVuWLNgaBLsJW61QtYv48K86RfuiOK
	 b+SiaaexhXaXw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH RFC 0/2] Add the capability to offload MLO link
 reconfiguration countdown in the NIC fw
Date: Thu, 12 Feb 2026 00:38:10 +0100
Message-Id: <20260212-mt7996-link-reconf-v1-0-2b110340d6c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwMT3dwSc0tLM92czLxs3aLU5Py8NF1DM1NLs1TTJAsDczMloMaCotS
 0zAqwodFKQW7OSrG1tQA8XSbkaQAAAA==
X-Change-ID: 20260204-mt7996-link-reconf-16596e5b8076
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>, 
 Ping-Ke Shih <pkshih@realtek.com>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31748-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,nbd.name,mediatek.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 664D8128542
X-Rspamd-Action: no action

Introduce the capability to offload the countdown for MLO link
reconfiguration IE if supported by the underlay driver/firmware.
The driver is supposed to set the WIPHY_FLAG_MLO_RECONF_ADV_OFFLOAD flag
to notify mac80211/hostapd it supports this capability in hw/fw.
Moreover, the driver is supposed to generate an event to notify
mac80211/hostapd when the countdown is completed.

---
Lorenzo Bianconi (1):
      wifi: mac80211: Add the capability to offload MLO link reconfiguration countdown in the NIC fw

Shayne Chen (1):
      wifi: mt76: mt7996: Add beacon_reconf IE parsing support

 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   5 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 185 +++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |  69 +++++++-
 include/net/cfg80211.h                             |  13 ++
 include/net/mac80211.h                             |  13 ++
 include/uapi/linux/nl80211.h                       |  12 ++
 net/mac80211/cfg.c                                 |  16 ++
 net/mac80211/ieee80211_i.h                         |   5 +
 net/mac80211/iface.c                               |  14 ++
 net/wireless/nl80211.c                             |  61 +++++++
 11 files changed, 394 insertions(+), 2 deletions(-)
---
base-commit: 4eefc435c985f4dfdba9afb1c705f0e17377c084
change-id: 20260204-mt7996-link-reconf-16596e5b8076

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


