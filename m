Return-Path: <linux-wireless+bounces-16902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDA9FE3EE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 09:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594D418823C6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E8CEAD2;
	Mon, 30 Dec 2024 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P0ymjIaO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA625948E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735548507; cv=none; b=ODY4IDqlvn99OY8ux/KH8V1vZ9XuSXdM76gVDpUEJCvEvQQnkBsRLOORcBGFU1Da8fhLONwCnQKBNZOMf/XE/kMPmt+KajHSgyi4wj+HzxNq+wR0KqlCLLh7ps3dX3e+hrjk80E6hXlEuxuA2iipZlrJeYcGglu8/UAUffa1mdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735548507; c=relaxed/simple;
	bh=P1mbX01IwVpvZu0gVB6JW1fHjRgtZvLhFTpeeWbnxRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mREkL8uaCB7IzXg2hWKvjQIElJWr1L9cCL7k/8fOx9IsAglxH0Ku1ZWxP5X627oHlpO1HrHv5T922y/5k4zrEDcPFR80OAVC5I4yeQC7Z9O4P1TPy1UIoJowBa+nJrP05QCzzHxbLigVVTbO+ZY9sj7hZG+fsnFCCMVGExGbIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P0ymjIaO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4DqyjHKHlbd5gZRRJX1Zoy4DveCy0HdkhaaVS5okZoA=; t=1735548505; x=1736758105; 
	b=P0ymjIaOojYaMgeTWmW3tPlYzJi5NeVxNFOaklGLVACMIaeiNYKE4EWzrEcfdmJKlnwHlA0VgIE
	zizO8mZuNIezlNdRDFPhr1+B85xaLMyQ9XbTuD+lpOM7zAkLlXDnyYCsj+JHNhXTLhud2sEiIFide
	tjAZVwZ1P7J9R9K056jiCL8IgFUEcKE2qO9vgNAqUhiDHFOb94ucrj6k3Wz779K4QjHc7TkX8Ekij
	HJ1QU4N3Q0RMnxTAc6h3VBphcetSUEMJIu/YQzuXedv3fZgUAOjZaXRmAdpIF70RpYffzXZDK3P2G
	35TeRKYJKohfC+BKh+SlApgH1y3juXVhfLQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tSAug-0000000FtWF-1v0r;
	Mon, 30 Dec 2024 09:14:10 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+0c5d8e65f23569a8ffec@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: mac80211: prohibit deactivating all links
Date: Mon, 30 Dec 2024 09:14:07 +0100
Message-ID: <20241230091408.505bd125c35a.Ic3c1f9572b980a952a444cad62b09b9c6721732b@changeid>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the internal API this calls this is a WARN_ON, but that
should remain since internally we want to know about bugs
that may cause this. Prevent deactivating all links in the
debugfs write directly.

Reported-by: syzbot+0c5d8e65f23569a8ffec@syzkaller.appspotmail.com
Fixes: 3d9011029227 ("wifi: mac80211: implement link switching")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index a9bc2fd59f55..e7687a7b1683 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -727,7 +727,7 @@ static ssize_t ieee80211_if_parse_active_links(struct ieee80211_sub_if_data *sda
 {
 	u16 active_links;
 
-	if (kstrtou16(buf, 0, &active_links))
+	if (kstrtou16(buf, 0, &active_links) || !active_links)
 		return -EINVAL;
 
 	return ieee80211_set_active_links(&sdata->vif, active_links) ?: buflen;
-- 
2.47.1


