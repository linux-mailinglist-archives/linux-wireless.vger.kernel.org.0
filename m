Return-Path: <linux-wireless+bounces-36854-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB8vKVDmE2rhHAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36854-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:04:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B385C62B2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BC5A3002B70
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 06:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04B7374736;
	Mon, 25 May 2026 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="WhFGyqWs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A40358375;
	Mon, 25 May 2026 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689022; cv=none; b=hd6PqxlV77CC8vY6rYiFXC4W9eTcLBYH9LqoLX5lPnydactdIOW9HuXMdPimqGkkpRz6MgFyYWzk6r8IGlBO38n7MJu7VVAUBA4M8bYJoKPy+fzPZUlYvFN/cKjO7vHzT2Zv093KNh+3q8igxswET6FFzjehd9Da1X57ufZwfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689022; c=relaxed/simple;
	bh=M11jHMT5Ir/WrS8vwUnco3nI1PPClK1HlRkDcheaekQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CuKbB8R5CaEkJRJXueSm9QMwxpLZvOxB7gMphQnIF6rkl/mG+GuMYTzsvU2CxSo9ckLxQubETwEeDU26O6OKWChTvFSe7zapyQFl7LmZuGzAJ7vi1k7XvNkge3fkyYxCcagH25aCITeQkD2Tpue2mt5jYCEgfhTJPjLBnROO+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=WhFGyqWs; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=WhFGyqWs8c1Fw3Y4hj//ST9/xHGFQ/wTux/FRY3WylPXcAHA3bJefhxebpa8vkadQi5rGBhFMTXXi
	 1xtBMeiL8cs4hz4tf/WK1+yM26SHqUYDHQfok+qf+iT0LWrHQWaYwB402K7gpmlwz7B53A3gkiQDNr
	 RmdYBsLC/rn7h4rk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-43-12057 (RichMail) with SMTP id 2f196a13e635cb3-09d6e;
	Mon, 25 May 2026 14:03:37 +0800 (CST)
X-RM-TRANSID:2f196a13e635cb3-09d6e
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	kartikey406@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	johannes.berg@intel.com
Subject: [PATCH 5.15.y] wifi: mac80211: check tdls flag in ieee80211_tdls_oper
Date: Mon, 25 May 2026 14:03:36 +0800
Message-Id: <20260525060336.2460138-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-36854-lists,linux-wireless=lfdr.de];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.657];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sipsolutions.net:email,appspotmail.com:email,intel.com:email,139.com:mid,139.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: A8B385C62B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit 7d73872d949c488a1d7c308031d6a9d89b5e0a8b ]

When NL80211_TDLS_ENABLE_LINK is called, the code only checks if the
station exists but not whether it is actually a TDLS station. This
allows the operation to proceed for non-TDLS stations, causing
unintended side effects like modifying channel context and HT
protection before failing.

Add a check for sta->sta.tdls early in the ENABLE_LINK case, before
any side effects occur, to ensure the operation is only allowed for
actual TDLS peers.

Reported-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=56b6a844a4ea74487b7b
Tested-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Link: https://patch.msgid.link/20260313092417.520807-1-kartikey406@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Li hongliang <1468888505@139.com>
---
 net/mac80211/tdls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index c2d7479c119a..d25dfeb347f2 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1380,7 +1380,7 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 		mutex_lock(&local->sta_mtx);
 		sta = sta_info_get(sdata, peer);
-		if (!sta) {
+		if (!sta || !sta->sta.tdls) {
 			mutex_unlock(&local->sta_mtx);
 			ret = -ENOLINK;
 			break;
-- 
2.34.1



