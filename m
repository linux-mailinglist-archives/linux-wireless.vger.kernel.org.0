Return-Path: <linux-wireless+bounces-29797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BBDCC2071
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 238FD300578B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133512BCF6C;
	Tue, 16 Dec 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tAvjrjU4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F6314D10;
	Tue, 16 Dec 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882369; cv=none; b=OJIZbfIGh4tO6El0pD1oP8YQfdNU/xIq+18BQLifEujIgrzh6KZtb5ZmYgDR9MZFs9WimncN8y+YHTQL1SwsGLXGb3wOF+X1kg/WZO7845K1aZXvp7M9w0XB+35M2/VahqvoCMc8+CXBU+sg+ZIH2itkQCxjUc/PwOIDMPLpZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882369; c=relaxed/simple;
	bh=I0h6HGmsPedyp9zbOJr6dGA5Zw4udd6o95UXI+HCTok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4I7zzCCLvI5L7qjT6p6nWnWMBhU7meFxB1k9FSrFHKNJOKg4LVTqxKhcUyr1/B6LLsBhwRRzwS0cMyRmkGVjrtodkpLPBGfezRaZXYU1cZNakewMOqpHQR85+GNCfGwWgSDMC9kCVSa/x0nAv4uD4y9xKJUCehKtGjNwcprGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tAvjrjU4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=At/pb4efTswgSzrAJFRIH5qTGg1BaK7V4ILmOy6yDXY=; t=1765882367; x=1767091967; 
	b=tAvjrjU4Hzst0cItFdy6YvccRV5oTHBa4kPOWwSmAdhP3nSxnIRUim+lx1iKdbDPx6UlvT8I4u6
	oZUE3AlMQxsxSntjyFgym95YyU6uBSrXkv49KULLeBK89XEoUPo8fmicME41pim2huSdZsUnBzVec
	HjpdHMWOL3LguLkkFy/XosYxN3chmA7Sb0iNNcK7J89zGahPpF3w+weCqATVl5DoLL/DSuRBLbqZI
	gKJM8nJIe9Q7rx50hr8kOzS1q6TpnSKcmTLWrOGjOutE/SmZ+0sYyPyQy6XYZWepFpgoLt4KxB+aB
	cRFoHwu5aKVuoTiIs5VLlYhLicDvzKQlPBsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVSfc-0000000AJub-0qiH;
	Tue, 16 Dec 2025 11:52:44 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org,
	Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>
Subject: [PATCH] wifi: mac80211: restore non-chanctx injection behaviour
Date: Tue, 16 Dec 2025 11:52:42 +0100
Message-ID: <20251216105242.18366-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

During the transition to use channel contexts throughout, the
ability to do injection while in monitor mode concurrent with
another interface was lost, since the (virtual) monitor won't
have a chanctx assigned in this scenario.

It's harder to fix drivers that actually transitioned to using
channel contexts themselves, such as mt76, but it's easy to do
those that are (still) just using the emulation. Do that.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218763
Reported-and-tested-by: Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>
Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 9d8b0a25f73c..1b55e8340413 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2397,6 +2397,8 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 
 	if (chanctx_conf)
 		chandef = &chanctx_conf->def;
+	else if (local->emulate_chanctx)
+		chandef = &local->hw.conf.chandef;
 	else
 		goto fail_rcu;
 
-- 
2.52.0


