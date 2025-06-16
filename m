Return-Path: <linux-wireless+bounces-24155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CCADB51D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 17:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2581016F3A3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82220A5F5;
	Mon, 16 Jun 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kPVZnpoj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879B1DF749
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087127; cv=none; b=P3kfHqxzg8MROM9HX+VuHbuV8wNYzemmYg5NjtuqWy1taCULyLVYq6uT8IY9cc+YN77vOEDclLWyTjG4HONxlFr3vGTbDbWS1vR5Gylgrk/grliPUeXVR+322pmgnmDQ9YoSPOlC+IF8KEHuT1r0nDpa+r7ayHmYgfPuOUIfkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087127; c=relaxed/simple;
	bh=5wKoQ76fhoQG4XnPwK7P9b/qzSj019Omh69/foZx0iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5KhNA49DAT9mF4oD6RwhdogOLZXoDzpsXsNIsxcxu/btk1tE4VI1WC6B40ePjALmSZkOeZpabji6KhI6kmn7S9LUvAQbJEMMAMLpcQ6I7igybiT+/qDeocK1NvWRsZN3TAMBcRS6mpeFjyeDQffkzdJvI4t3K8iwkJuyWUgCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kPVZnpoj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2oVX+Y69rLD552ixqWXFbuXHYeJYYBUK/qqgqdai77E=; t=1750087125; x=1751296725; 
	b=kPVZnpojRjClzxDGkqmBsIe1LBCS3ovdTKMlq7tSDOBLaVU1VTzgW4ZxmV1iAUo5qzy+tuIiQ9W
	OHNIIOOaONETsdM6mgz2ODOz4uNozmwQnyXCH4JulA31EOyeI1qJ1QesdvB5tJypcxkP0tj504Nv8
	K/XQikRuNj12sOuKnNHH8M36WE0kJN8aWKawlCf3UGVTckQsRQzSmwsv0LfGZ6RvN8Iwwh1hQB5aL
	xFrp8O0S9Zim378Cn98XGimriX4zUMFLhshzLwwQ1GPNkANmRxdjekTUdW9rX16XyHvzaKRE1ToJf
	cv02Pzq7ineXp9NQVisZ0Xy/luOk64q3GFMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRBbe-0000000CQfl-0Im6;
	Mon, 16 Jun 2025 17:18:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com
Subject: [PATCH wireless v2] wifi: mac80211: drop invalid source address OCB frames
Date: Mon, 16 Jun 2025 17:18:38 +0200
Message-ID: <20250616171838.7433379cab5d.I47444d63c72a0bd58d2e2b67bb99e1fea37eec6f@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In OCB, don't accept frames from invalid source addresses
(and in particular don't try to create stations for them),
drop the frames instead.

Reported-by: syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6788d2d9.050a0220.20d369.0028.GAE@google.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
#syz test
---
 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..e73431549ce7 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4432,6 +4432,10 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		if (!multicast &&
 		    !ether_addr_equal(sdata->dev->dev_addr, hdr->addr1))
 			return false;
+		/* reject invalid/our STA address */
+		if (!is_valid_ether_addr(hdr->addr2) ||
+		    ether_addr_equal(sdata->dev->dev_addr, hdr->addr2))
+			return false;
 		if (!rx->sta) {
 			int rate_idx;
 			if (status->encoding != RX_ENC_LEGACY)
-- 
2.49.0


