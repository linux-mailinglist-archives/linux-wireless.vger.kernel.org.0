Return-Path: <linux-wireless+bounces-29098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3428EC68EC7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 11:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E9BA4EC325
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57033148D6;
	Tue, 18 Nov 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="nQdPxXUD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF542EACEF
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463171; cv=none; b=gzZXeIrt3XW/DHsc/MAIzH2+NrqY6D2Fbkz5IDr5XQyIQFqjhY2sVt8cTTtJwOeBmSuVdE56S54RRn8XpQScuh/C4awbjkGR7H93XWJe0BALyR1c9SYf0Tv6KSTRZRdkVBjgeqVHUu75u9D5+Bb1+yHkIFkfe/UO7jG8Iz5/JwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463171; c=relaxed/simple;
	bh=FUhAPS3sqPHsX6pAvchZ31Py0z1bUVPKQz3KmQrSEvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0GBBW3XJFd7oUp4dS0v30L68VygMYwr/hIl0+t6jaOjywXL7OpX04O31HTdigklht6gwB4c6SdeufQWgitKRP0QqcVnhJpuzgCmkAWPkOboEr9rNoA87mQj4vlFBmnzP7/BRfLPB2nZuFxskOKImSfUiYrqTwb1DQI2l0X7d/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=nQdPxXUD; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wcOwEVTJm7PVZ1QhaYQbreX4BIKGxouXkB6DSTlJ230=; b=nQdPxXUDKmtgBuwWL6nX54WE+N
	lbLC2RVzw84WKwGKckEE0VcggizDlNgdOZm4TGvo+8Uz7lFjDTpocL/Z02jwvfmRn4mDTZ7RRS+pX
	1H/pifzdLZ7V/UqQiRfoyFF1WPND4XdC/OHKymx6DkOKwBEAKOMKdGbqTN9ByoSJQUt0=;
Received: from p5b206646.dip0.t-ipconnect.de ([91.32.102.70] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vLIvk-005In0-0n;
	Tue, 18 Nov 2025 11:27:24 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>
Subject: [PATCH 1/2] wifi: mt76: fix multi-radio on-channel scanning
Date: Tue, 18 Nov 2025 11:27:22 +0100
Message-ID: <20251118102723.47997-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chad Monroe <chad@monroe.io>

avoid unnecessary channel switch when performing an on-channel scan
using a multi-radio device.

Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
Signed-off-by: Chad Monroe <chad@monroe.io>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/scan.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index ff9176cdee3d..0b1922f7792e 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -16,7 +16,7 @@ static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
 
 	clear_bit(MT76_SCANNING, &phy->state);
 
-	if (dev->scan.chan && phy->main_chandef.chan &&
+	if (dev->scan.chan && phy->main_chandef.chan && phy->offchannel &&
 	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
 		mt76_set_channel(phy, &phy->main_chandef, false);
 	mt76_put_vif_phy_link(phy, dev->scan.vif, dev->scan.mlink);
@@ -94,7 +94,7 @@ void mt76_scan_work(struct work_struct *work)
 		return;
 	}
 
-	if (dev->scan.chan && phy->num_sta) {
+	if (dev->scan.chan && phy->num_sta && phy->offchannel) {
 		dev->scan.chan = NULL;
 		mt76_set_channel(phy, &phy->main_chandef, false);
 		goto out;
@@ -102,20 +102,22 @@ void mt76_scan_work(struct work_struct *work)
 
 	dev->scan.chan = req->channels[dev->scan.chan_idx++];
 	cfg80211_chandef_create(&chandef, dev->scan.chan, NL80211_CHAN_HT20);
-	mt76_set_channel(phy, &chandef, true);
+	if (dev->scan.chan != phy->main_chandef.chan)
+		mt76_set_channel(phy, &chandef, true);
 
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


