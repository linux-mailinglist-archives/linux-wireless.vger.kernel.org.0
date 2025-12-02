Return-Path: <linux-wireless+bounces-29455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACA6C9AD66
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Dec 2025 10:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D332A4E2FDA
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Dec 2025 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1563081B1;
	Tue,  2 Dec 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wyu/xgjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5F30B508
	for <linux-wireless@vger.kernel.org>; Tue,  2 Dec 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667471; cv=none; b=mAXAKNfFPebpxiOZnUp9arfpN1YxguKllxASuqhr4Yf9oXpTaf8f7l8h5+hhLjdvDTyn4gFhDD0M3mrm3gBn7pnOYVzwVufd16HXYYkMxWHAL1VI8pAP7MmMCyLBO+nqpDOxSR6Frp2kIoqGUiNJFRvYvqMC5mgHMt4fWtOZXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667471; c=relaxed/simple;
	bh=a87o1bR5oeKRetUmxf9BGDnyASVei2eYWbvo76xhQFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ia7NxLDCBfZpPRRc5TAlj2L+lUf3+qdj/QSeBEhHAETRx8h6iJCOidetfVtDYgHmQ4nJT1bwtGW1DeB/7+vzEHGGw3Q5xAm0EJ7czLWoCyYDDw87kMfiKiDoe8nv+AUCOK46P1lbE/htJAUjnIC2jSvLdVU2PBcsfgz72NZQymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wyu/xgjK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ZbftF0CCcSFYhSfy4d/LCqHFtKhjDTMuzCSdT9PsYoA=; t=1764667469; x=1765877069; 
	b=wyu/xgjKDcFaXPOGGzfNtwDhBGL4YZzXz24saufQcgTuoftz0AMTgsnVOGCDPa9nTSUd9sth9nq
	JXJyejp/s8aa76TKH8GaYa8J6JfctwQM9sglFOpRdYxaMMyqJP8Z3+xbEXmkr2Tb7pJSBihp/0pX3
	IF2YRw6jRn6NCfzFTn/nCnV14kGA7l1yo5DZTyy4fUMMadhaqPYAxJ4uls66ZiDbIwtm4Pvky6Hrq
	A9VSC+EX+jGWRzG0ILZJVVsThlxuIxpMNhTwvWYocfA5XUnAJsaJO7Mlr7/JRAtB+cYQwI8gcL+Dr
	JWKVhdqPHewu+7pqIUIktQB2MVOGFA0GLHkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vQMcT-0000000FjSg-11Pn;
	Tue, 02 Dec 2025 10:24:25 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+639af5aa411f2581ad38@syzkaller.appspotmail.com
Subject: [PATCH wireless] wifi: mac80211: don't WARN for connections on invalid channels
Date: Tue,  2 Dec 2025 10:24:20 +0100
Message-ID: <20251202102420.b3fd67491a21.I961ee41b8f10538a54b8565dbf03ec1696e80e03@changeid>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

It's not clear (to me) how exactly syzbot managed to hit this,
but it seems conceivable that e.g. regulatory changed and has
disabled a channel between scanning (channel is checked to be
usable by cfg80211_get_ies_channel_number) and connecting on
the channel later.

With one scenario that isn't covered elsewhere described above,
the warning isn't good, replace it with a (more informative)
error message.

Reported-by: syzbot+639af5aa411f2581ad38@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e56ad4b9330f..e1f5dafe8f53 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1126,7 +1126,10 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 
 	while (!ieee80211_chandef_usable(sdata, &chanreq->oper,
 					 IEEE80211_CHAN_DISABLED)) {
-		if (WARN_ON(chanreq->oper.width == NL80211_CHAN_WIDTH_20_NOHT)) {
+		if (chanreq->oper.width == NL80211_CHAN_WIDTH_20_NOHT) { 
+			link_id_info(sdata, link_id,
+				     "unusable channel (%d MHz) for connection\n",
+				     chanreq->oper.chan->center_freq);
 			ret = -EINVAL;
 			goto free;
 		}
-- 
2.51.1


