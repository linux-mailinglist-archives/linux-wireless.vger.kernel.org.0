Return-Path: <linux-wireless+bounces-38069-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SKSIH7N4PGqxoQgAu9opvQ
	(envelope-from <linux-wireless+bounces-38069-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:39:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F03B96C203C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 02:39:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38069-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38069-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 770363047042
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 00:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B642335E940;
	Thu, 25 Jun 2026 00:38:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A135E1A0;
	Thu, 25 Jun 2026 00:38:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782347908; cv=none; b=I2JYPGzF2FcUBSTdTcjRgHSMI/7+bqdLscQAjriJ0+UhVDNw/DRTh5rxJ8kVHIxumbcEuWHQVDrDgmeKC7fvCfaxMqb2iMIRfDhCoHRKJeUtMKiON4PeTN9Dvv1HHZ45QnW5ytQuMpYLREZOTPf1KVbK8j9Qud6EjPuyKnRqbQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782347908; c=relaxed/simple;
	bh=XpbG+yr2hOG5NvjrXe7VsWNLa947lX88AbKfOU3y4XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+D1kuAJpn6w1FgMR0SkCcCaUqhL7Rlra/mtlzk5OXaJ08nOx5IcQm9hdGg0Eazf8eDgJx6OJjPBFrQOH5meWBykQqdxCiLbFSo/sXY9EyjuEECOKmFZsswF4yuTV9SxznfOYC0Yrr4Rz7+9ZEYwuM6HSPkCykKG2Hf7el7LKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowADH4dh2eDxqD+zCFQ--.4839S2;
	Thu, 25 Jun 2026 08:38:14 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Felix Fietkau <nbd@nbd.name>
Cc: pengpeng@iscas.ac.cn,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC PATCH] wifi: mt76: fail channel switch when TX queues do not drain
Date: Thu, 25 Jun 2026 08:38:12 +0800
Message-ID: <20260625003812.37895-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADH4dh2eDxqD+zCFQ--.4839S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyrWr4rur1rGFy5uF45Jrb_yoW8Kw4DpF
	WDt3yj9F1DJFn0g3WxJ3Z5JFWY9F48Kw1DGrZYy34rA3Z8Zrn0yF15Ga4jkr15ArZ2yayY
	grs8ta17WFyDWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbtxhJUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38069-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:pengpeng@iscas.ac.cn,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[iscas.ac.cn,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F03B96C203C

__mt76_set_channel() disables the TX worker, schedules pending TX queues,
sets MT76_RESET, and waits for pending TX to drain before changing the PHY
channel state and calling the driver set_channel() callback.

The wait result is ignored.  If TX does not drain within the timeout, the
function still publishes the new channel state and asks the driver to
switch channels while old-channel TX may remain pending.

Return -ETIMEDOUT when the drain wait expires.  Keep the survey update on
the old channel, then clear MT76_RESET and re-enable the TX worker through
the existing exit path.

This is marked RFC because the existing channel switch path treats the TX
drain wait as best-effort.  Maintainer feedback is needed on whether a TX
drain timeout should fail the channel switch for all mt76 devices or
whether the current force-forward behavior is intentional.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 13c4e8abe..37474d64c 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1033,6 +1033,7 @@ int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 		       bool offchannel)
 {
 	struct mt76_dev *dev = phy->dev;
+	long time_left;
 	int timeout = HZ / 5;
 	int ret;
 
@@ -1040,8 +1041,13 @@ int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 	mt76_txq_schedule_pending(phy);
 
 	set_bit(MT76_RESET, &phy->state);
-	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy), timeout);
+	time_left = wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(phy),
+				       timeout);
 	mt76_update_survey(phy);
+	if (!time_left) {
+		ret = -ETIMEDOUT;
+		goto out;
+	}
 
 	if (phy->chandef.chan->center_freq != chandef->chan->center_freq ||
 	    phy->chandef.width != chandef->width)
@@ -1059,6 +1065,7 @@ int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 
 	ret = dev->drv->set_channel(phy);
 
+out:
 	clear_bit(MT76_RESET, &phy->state);
 	mt76_worker_enable(&dev->tx_worker);
 	mt76_worker_schedule(&dev->tx_worker);
-- 
2.50.1 (Apple Git-155)


