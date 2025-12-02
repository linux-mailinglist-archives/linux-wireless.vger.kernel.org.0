Return-Path: <linux-wireless+bounces-29456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 457B4C9AD69
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Dec 2025 10:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 335644E1305
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Dec 2025 09:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE93081B1;
	Tue,  2 Dec 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="It4+4ucv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABEE2FFDC0
	for <linux-wireless@vger.kernel.org>; Tue,  2 Dec 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667518; cv=none; b=p4dvGg25RBD6G+aPPdwSDmu0uE3BsaVH9fwyPH135aGRpKaj1FLYfep3TaIBb0g7zSRL8feZLzJ9m6OHjgogeuYtR60ugtuvDlz07cindfhG8ZvTXNh9w51mxYyhYULNnDg13Q/LrnyiHIjI90fkSTa2cXoSHOFiGq2I8zNgbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667518; c=relaxed/simple;
	bh=AMDbDsp83vA+QZDZNoXew8xF68jO2rE8j04RJOCBvBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSVGsk/tOUPdCA24LDroSbt+tgBaam1GPx7JaCyryf+gSd2jq3kF7b9o0cxoBTenLIBjrEOTa6lo0JOJGS/1bBQqOHXXJHMJ2uNG6ZkAcn91opb2FsPPp2meQiTo6YV3IBO+wr49z5K44f0J92O6nBWbttxro9zlxyXr6oM6Q7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=It4+4ucv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=9gLUe1hsBsySnXkbVVrLkPfCtRs6H8A+YXP9k7Jh4TI=; t=1764667516; x=1765877116; 
	b=It4+4ucvBDJp/GTiV5Y6ucbaFjvMDLORG9MF+LPlqP0tmFvuz3rAoRNcvPzgEXUGrfz2LS9md2n
	PqQfL0uYQDbmkRCDcNXo/k4EDnwDHFyfqWYftwgkshUbN8+sA8d4UkfdQo0EvIhrwkPglZVGJjTrX
	sJvZgsthjJxezBA7QBPWWMD0fjhRWUbpJ8py8ZtBiYJneIOG/8TBTfoaUnpgm03DulCoMYnszTieh
	7XmMkhilGQcQjJ0s/01eHTbJludqxskFQP7YB+uoJ2C8k8q82qjVj7aWY8hPrG9me5vGAaRuOVz7j
	+J2HeRYcZYrzoNCwxykspbNtV6BAhVWZ371A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vQMdF-0000000FjX2-38TQ;
	Tue, 02 Dec 2025 10:25:13 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+639af5aa411f2581ad38@syzkaller.appspotmail.com
Subject: [PATCH wireless v2] wifi: mac80211: don't WARN for connections on invalid channels
Date: Tue,  2 Dec 2025 10:25:11 +0100
Message-ID: <20251202102511.5a8fb5184fa3.I961ee41b8f10538a54b8565dbf03ec1696e80e03@changeid>
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
v2: remove trailing whitespace
---
 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e56ad4b9330f..ad53dedd929c 100644
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


