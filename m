Return-Path: <linux-wireless+bounces-37888-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kT9dGf+oM2owEwYAu9opvQ
	(envelope-from <linux-wireless+bounces-37888-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 10:14:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C210669E5FC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 10:14:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37888-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37888-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30D203045A9A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F213DC84E;
	Thu, 18 Jun 2026 08:14:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF643ACEF8;
	Thu, 18 Jun 2026 08:14:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770484; cv=none; b=nO+Pbd7PkoVYqM0BsiQzj3mRdxocO3LE9LSdOIh3Pl9WHPgIDTDiq+QjdFWYpeCw/ReV+wiAOUpebyNX4AU6qQP1qDe+oBjH8KezFjTv9fzF0eU3dBO+Nc6A9KWHezo12jDUgQiOZyIzln2GmkFaJOMtHSz9Bg+mneU/8j2vWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770484; c=relaxed/simple;
	bh=ZwhK/h4Q+VjqHenPjc7/UjM+BFXsGU2cwA04kE9ylDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9YeFsI9uoquosfkpr7aH0i3ozkkHvJdCPHZZRKTXa+RGT/0XT3lx13harN+zJOAXcXqB1J6XphDUWZgj1gCxzwyhqeshMbL6G4JlQKmUdWPVzN9vmYXOlmgWqPOEeJ5TLnUQreaeN07QppEwYe0K7sOkOQFEZLCYiR/hkuQFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id A48CD233AC;
	Thu, 18 Jun 2026 11:14:34 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	nbd@nbd.name,
	linux-wireless@vger.kernel.org,
	Leon Yen <leon.yen@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	David Ruth <druth@chromium.org>,
	Ajrat Makhmutov <rauty@altlinux.org>
Subject: [PATCH 6.12.y v3 1/3] wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain
Date: Thu, 18 Jun 2026 11:14:11 +0300
Message-ID: <20260618081413.17812-2-rauty@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260618081413.17812-1-rauty@altlinux.org>
References: <20260617130826.1667503-1-rauty@altlinux.org>
 <20260618081413.17812-1-rauty@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37888-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[nbd.name:server fail,chromium.org:server fail,vger.kernel.org:server fail,tor.lore.kernel.org:server fail,mediatek.com:server fail,msgid.link:server fail,altlinux.org:server fail];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:leon.yen@mediatek.com,m:mingyen.hsieh@mediatek.com,m:druth@chromium.org,m:rauty@altlinux.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[altlinux.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rauty@altlinux.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rauty@altlinux.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,vger.kernel.org:from_smtp,nbd.name:email,msgid.link:url,mediatek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C210669E5FC

From: Leon Yen <leon.yen@mediatek.com>

commit 2425dc7beaadc39c2636f97f8bdc22dc3cf88149 upstream.

Some countries have strict RF restrictions where changing the regulatory
domain dynamically based on the connected AP is not acceptable.
This patch disables Beacon country IE hinting when a valid country code
is set from usersland (e.g., by system using iw or CRDA).

Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: David Ruth <druth@chromium.org>
Link: https://patch.msgid.link/20240412085357.13756-1-mingyen.hsieh@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>
---
v2: drop redundant "cherry picked from" trailer; add backporter
    Signed-off-by. No code change.
v3: add cover letter with upstream/stable references; mark target 6.12.y.

 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 4bd533c4ba9a1..276dfb9c26e0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -137,6 +137,13 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 	dev->mt76.region = request->dfs_region;
 	dev->country_ie_env = request->country_ie_env;
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_USER) {
+		if (dev->mt76.alpha2[0] == '0' && dev->mt76.alpha2[1] == '0')
+			wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
+		else
+			wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	}
+
 	if (pm->suspended)
 		return;
 
-- 
2.50.1


