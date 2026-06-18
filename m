Return-Path: <linux-wireless+bounces-37889-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id seeMKPuoM2ovEwYAu9opvQ
	(envelope-from <linux-wireless+bounces-37889-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 10:14:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875069E5F7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 10:14:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37889-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37889-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C1423011E82
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F1E3DCD8A;
	Thu, 18 Jun 2026 08:14:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECF2F7462;
	Thu, 18 Jun 2026 08:14:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770484; cv=none; b=ORlS9XSUCxzh0AVBLJVWoUDQZPJzcslIoS8kM840on6Wjh+YyEaduGPbYLL+Begf7LVKAooskNj+jO6kIUX9tm6PDDJCRS8cjQhwrPq/A6sxBsuxxCBnYr/1VMdFkIetiLkxbLG/EQuR0UCXl8pcuzOf2mpUPefoEcYh6pG2Vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770484; c=relaxed/simple;
	bh=FKfoYrImvuyLUV+uyDG0xSvluVDC+iypR1Ro2I9pbhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLAT8MpOIU/npHQHNZcyRPV99mLKK/szuv6hMVaefPFitpw9cDW5uG/bKakaE+X3zNeY5CBVHYaqGakopW0tai+0gpvix49s2s38Ixv0g4w36wQ77YD1Xb1qEF+Kh+D6SKeabtIVinPD+uIg6Bff39bzaW29SbyMpFJ2HTGQ0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Received: from ajratkogda.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	(Authenticated sender: ajratma)
	by air.basealt.ru (Postfix) with ESMTPSA id 6E0BC233AF;
	Thu, 18 Jun 2026 11:14:35 +0300 (MSK)
From: Ajrat Makhmutov <rauty@altlinux.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	nbd@nbd.name,
	linux-wireless@vger.kernel.org,
	Quan Zhou <quan.zhou@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	David Ruth <druth@chromium.org>,
	Ajrat Makhmutov <rauty@altlinux.org>
Subject: [PATCH 6.12.y v3 2/3] wifi: mt76: mt7921: fix a potential scan no APs
Date: Thu, 18 Jun 2026 11:14:12 +0300
Message-ID: <20260618081413.17812-3-rauty@altlinux.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37889-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[chromium.org:server fail,mediatek.com:server fail,vger.kernel.org:server fail,sto.lore.kernel.org:server fail,altlinux.org:server fail,msgid.link:server fail,nbd.name:server fail];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:nbd@nbd.name,m:linux-wireless@vger.kernel.org,m:quan.zhou@mediatek.com,m:sean.wang@mediatek.com,m:druth@chromium.org,m:rauty@altlinux.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[altlinux.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rauty@altlinux.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3875069E5F7

From: Quan Zhou <quan.zhou@mediatek.com>

commit 5ed54896b6bd444223092cab361b0785932119ab upstream.

In multi-channel scenarios, the granted channel must be aborted before
station remove. Otherwise, the firmware will be put into a wrong state,
resulting in have chance to make subsequence scan no APs.
With this patch, the granted channel will be always aborted before
station remove.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: David Ruth <druth@chromium.org>
Reviewed-by: David Ruth <druth@chromium.org>
Link: https://patch.msgid.link/1ac1ae779db86d4012199a24ea2ca74050ed4af6.1721300411.git.quan.zhou@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>
---
v2: drop redundant "cherry picked from" trailer; add backporter
    Signed-off-by. No code change.
v3: add cover letter with upstream/stable references; mark target 6.12.y.

 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index a93ae4e44f16a..f2fffca868b51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -368,9 +368,9 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
 	del_timer_sync(&phy->roc_timer);
 	cancel_work_sync(&phy->roc_work);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		ieee80211_iterate_active_interfaces(mt76_hw(dev),
-						    IEEE80211_IFACE_ITER_RESUME_ALL,
-						    mt7921_roc_iter, (void *)phy);
+		ieee80211_iterate_interfaces(mt76_hw(dev),
+					     IEEE80211_IFACE_ITER_RESUME_ALL,
+					     mt7921_roc_iter, (void *)phy);
 }
 EXPORT_SYMBOL_GPL(mt7921_roc_abort_sync);
 
@@ -881,6 +881,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
+	mt7921_roc_abort_sync(dev);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->deflink.wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
 
-- 
2.50.1


