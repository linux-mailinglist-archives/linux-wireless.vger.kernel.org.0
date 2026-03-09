Return-Path: <linux-wireless+bounces-32733-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEKbILhjrmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32733-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:07:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A4234167
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29683300CE76
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECFD34E777;
	Mon,  9 Mar 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Qn5fF8HH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF834D932
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036464; cv=none; b=hgbd89gUaG8cydbq/LK3CXVimjpmHXpDDQrfzhZMjggItiMCpmFQcUnoR8YKbSfYdMP1uZgZNJ9NwA33Jkv8sHcKhqJiNHg60iTu3NNZfAP4YfkyyKsQUZLK+/9zCZ5F3Zo1lQDSXE5P/P2FEbkmUnuCyUU4yHkGihYE26joUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036464; c=relaxed/simple;
	bh=2DnkMeKmf5KsMk2HIJpjP9XhajSV2q2u73cQwbGqqmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwH4UZZJKscFFsN/kMD8pqp2bsFxpsbOZlcq9mi+GdW39sfCQw+mY43dj1MgRGL1/9TMtq5c+0if4ac35rAg69xOBtjFMfxw2QpxAJQocj+cRG6jUyiVuqov4do6qlxU0Z08oMAvuHcMvBTQqQgOeNLPgGxGttuMt0QtU+2kdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Qn5fF8HH; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XRtb8UXlxJoG8Dp4Z6agtCvg6ELcQXsUXpC3zhul3Ow=; b=Qn5fF8HHSrV/Oe5PPQj1qw2alz
	IB/e0VGkkDWDXTMq13v1+BY5IyXi12Bi+J1dZgrqLsD8bky6McLtjYw+la7IH7bIu+46G++2QWSMn
	yH2I2EAZKSvDbMtwoB86YWctqxU4usWtF9/W0qQ0YB8vbpHhF7jL+B+L3Ws3Up1tC5ls=;
Received: from p200300cadf236500000000000000085c.dip0.t-ipconnect.de ([2003:ca:df23:6500::85c] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vzTmB-00GH43-00;
	Mon, 09 Mar 2026 07:07:35 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>
Subject: [PATCH mt76 01/11] wifi: mt76: fix multi-radio on-channel scanning
Date: Mon,  9 Mar 2026 06:07:20 +0000
Message-ID: <20260309060730.87840-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D78A4234167
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32733-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nbd.name:-];
	NEURAL_HAM(-0.00)[-0.310];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nbd.name:mid,nbd.name:email]
X-Rspamd-Action: no action

From: Chad Monroe <chad@monroe.io>

avoid unnecessary channel switch when performing an on-channel scan
using a multi-radio device.

Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
Signed-off-by: Chad Monroe <chad@monroe.io>
Link: https://patch.msgid.link/20251118102723.47997-1-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/scan.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index ff9176cdee3d..89f16c23e352 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -16,7 +16,7 @@ static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
 
 	clear_bit(MT76_SCANNING, &phy->state);
 
-	if (dev->scan.chan && phy->main_chandef.chan &&
+	if (dev->scan.chan && phy->main_chandef.chan && phy->offchannel &&
 	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
 		mt76_set_channel(phy, &phy->main_chandef, false);
 	mt76_put_vif_phy_link(phy, dev->scan.vif, dev->scan.mlink);
@@ -87,6 +87,7 @@ void mt76_scan_work(struct work_struct *work)
 	struct cfg80211_chan_def chandef = {};
 	struct mt76_phy *phy = dev->scan.phy;
 	int duration = HZ / 9; /* ~110 ms */
+	bool offchannel = true;
 	int i;
 
 	if (dev->scan.chan_idx >= req->n_channels) {
@@ -94,7 +95,7 @@ void mt76_scan_work(struct work_struct *work)
 		return;
 	}
 
-	if (dev->scan.chan && phy->num_sta) {
+	if (dev->scan.chan && phy->num_sta && phy->offchannel) {
 		dev->scan.chan = NULL;
 		mt76_set_channel(phy, &phy->main_chandef, false);
 		goto out;
@@ -102,20 +103,26 @@ void mt76_scan_work(struct work_struct *work)
 
 	dev->scan.chan = req->channels[dev->scan.chan_idx++];
 	cfg80211_chandef_create(&chandef, dev->scan.chan, NL80211_CHAN_HT20);
-	mt76_set_channel(phy, &chandef, true);
+	if (phy->main_chandef.chan == dev->scan.chan) {
+		chandef = phy->main_chandef;
+		offchannel = false;
+	}
+
+	mt76_set_channel(phy, &chandef, offchannel);
 
 	if (!req->n_ssids ||
 	    chandef.chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR))
 		goto out;
 
-	duration = HZ / 16; /* ~60 ms */
+	if (phy->offchannel)
+		duration = HZ / 16; /* ~60 ms */
 	local_bh_disable();
 	for (i = 0; i < req->n_ssids; i++)
 		mt76_scan_send_probe(dev, &req->ssids[i]);
 	local_bh_enable();
 
 out:
-	if (dev->scan.chan)
+	if (dev->scan.chan && phy->offchannel)
 		duration = max_t(int, duration,
 			         msecs_to_jiffies(req->duration +
 						  (req->duration >> 5)));
-- 
2.51.0


