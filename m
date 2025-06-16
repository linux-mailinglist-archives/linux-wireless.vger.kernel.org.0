Return-Path: <linux-wireless+bounces-24152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC9BADB262
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CB23B9097
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31AD2877E9;
	Mon, 16 Jun 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="u5dgqib+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F32877C1
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081251; cv=none; b=IeXXxisTnHwlvXVa/7p1PXy3KxdmBOU6IUt/iB6ewhm30TB3IpYHvJQ1kOGqHJPTMTS0kSt720tmRx8PZkvu6IOh/w4hrkmKU09GOsAvvQW5GGPtQsv+64hT4a2MUxmWl4D5DqFtC7zNZKXNjnRu3V0PKPynWYGcpD3IcHjWmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081251; c=relaxed/simple;
	bh=MQaPxb4rT52JnfnezRz1PXLmCmriu5HydUgDOUCDMew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBHQnmNKMH64sEzbKhMtHUh+g9mSm6W9SQNeVDCoduMWkqaNhAa/N1rD4cXPOLjmQoWrlLlNkqQoMHG08YteAiG5bnpU6LVLNyf7TuaC/xPwxFH4YkGyGrXiBvWiHQRmcMsYs5z6HTqkNbiLTENdM+GMpazFzhEEe+qTB7hO6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=u5dgqib+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=TjzdQoh1UlsfOQqLoIioIvU68pGG8nIfDN3X8weSAro=; t=1750081250; x=1751290850; 
	b=u5dgqib+5XYcIGCLRN6rIhmfQoHlQ30eJLyLAz/59GoE+ExXVP0zHvV+NYmIB4jzA6rGcvEHA2l
	42aBzMAIl9upI02Boq+1tgfLWX/yxleRIqkkP+s/FAil+nf61G7cnCUMUsb3eRCvlf77tauJRxp8U
	qiBQm2xzX2GMFmllYceZ0u7aCE7rfJrRtbTc7hFsfScO2TcOr+wd/vO4AQQWhvl0/ghxYCETCR4WE
	GUGtRFjV2OvSeWP4OEj1kORJgV6UYyZB2rJj2QY3lwRaB0yVCtKoryNT3weuvZQigFcl7ycJXaGTj
	+ZDz4DCVTQ/fKMQ+afhcEzN+umwRtp+m+8+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uRA4t-0000000CKnX-0D9z;
	Mon, 16 Jun 2025 15:40:47 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+8b512026a7ec10dcbdd9@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: drop invalid source address OCB frames
Date: Mon, 16 Jun 2025 15:40:40 +0200
Message-ID: <20250616154041.f0a3109dfa90.I47444d63c72a0bd58d2e2b67bb99e1fea37eec6f@changeid>
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
index 09beb65d6108..fe53c664e7c2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4432,6 +4432,10 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		if (!multicast &&
 		    !ether_addr_equal(sdata->dev->dev_addr, hdr->addr1))
 			return false;
+		/* reject invalid/our STA address */
+		if (!ether_addr_valid(hdr->addr2) ||
+		    ether_addr_equal(sdata->dev->dev_addr, hdr->addr2))
+			return false;
 		if (!rx->sta) {
 			int rate_idx;
 			if (status->encoding != RX_ENC_LEGACY)
-- 
2.49.0


