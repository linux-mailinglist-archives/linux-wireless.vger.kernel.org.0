Return-Path: <linux-wireless+bounces-10962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD873947CC1
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A699282BB0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA913A41F;
	Mon,  5 Aug 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="cLrYov1w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0A13A878
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867761; cv=none; b=SJU4TtenSVXa36Yw/mJ9I13acnhiQVHkGC9bZ/7FmmcoorpV2pVQ3WJfDbiyAq8ZgJetE9B3ARDg2QfRSDYfZVwp0nVvSwcLgYA3ugyjk7iISrkTv3IoVbF97UijV1soB9VTeiIIAo8cEZkSo2VpOJOmxZUNpGhWOuaEmYG0UkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867761; c=relaxed/simple;
	bh=PT+dQzbuFS2MhShjH9OoJ6q2i0ha9UBVLsQYaIajI9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RK1sBX63xR47Te8qcGQn82EqvNqNhEpzNrKlt4fuUdM1gQMrzmVxV+mIjWHEgtwvYJtI4MobkpAuUUW+p5INb+CSxQiKOl+QLLbzk9mM/JZyrg5bRb11irJuwWqHd5Z45EBe2M2VoChbGd3N/zRZWIqdsgKsqBVzjpcw8SHnUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=cLrYov1w; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:38d:0:640:9af4:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 4007460A3C;
	Mon,  5 Aug 2024 17:22:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SMcAiB0pI4Y0-PsosaBsR;
	Mon, 05 Aug 2024 17:22:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722867749; bh=NJYv1DSY7P9gpCs9lZW7N0vK9JJikhAJIbPiVqkO0Lo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=cLrYov1wODlmBBFfG1Ctt6AtTpqewFR3xZTMeoYPlWtnoFShdFj0YM1VyJOcrapR+
	 YYoFmUl+jzoc7IGLmelJDobzLOjH5o+YzMbqFTWuZ+dMxhwI6zdoLPwIZDhMmSI5jJ
	 ixTQmrELs/50EZX6cuMAYHgUCwrRqShYfB+N3JcM=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mac80211: free skb on error path in ieee80211_beacon_get_ap()
Date: Mon,  5 Aug 2024 17:20:35 +0300
Message-ID: <20240805142035.227847-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ieee80211_beacon_get_ap()', free allocated skb in case of error
returned by 'ieee80211_beacon_protect()'. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac80211/tx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 72a9ba8bc5fd..506c2ca29b64 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5347,8 +5347,10 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	if (beacon->tail)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
-	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
+	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0) {
+		dev_kfree_skb(skb);
 		return NULL;
+	}
 
 	ieee80211_beacon_get_finish(hw, vif, link, offs, beacon, skb,
 				    chanctx_conf, csa_off_base);
-- 
2.45.2


