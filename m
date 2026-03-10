Return-Path: <linux-wireless+bounces-32919-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF4zByNHsGnFhgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32919-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:30:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7A254CDC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 17:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0807132D200D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FDF3B9D87;
	Tue, 10 Mar 2026 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBNgBfjN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09D631715E
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158423; cv=none; b=Wu9THi0HoJb20sALhOpbLpk4Z9plGR6uAywis4Uaw+gw6bNlZ+7pYy3fEONLfX+rvvN9iM+hk9l8q6AnVlObdj0v9dTX1QKYtsyebzQhxGcRv0yL6KNe393VtLjyFP/mi+7yvgb5oMnLvltORPitQOcC/1NONio5EudO2AK/5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158423; c=relaxed/simple;
	bh=TRuvZ4S1MzXyaUkOso+Dc7l046VDE4OoSzr5jLgg6zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DA+/R1v3vxTbF7+RmZG1z3nwMc2FTdBLAkr7fIA6zk5ESvGU8yIIJj37LHXxobNpv/totnutbS6rUIW4wQMIokDubK4wQkVgYu3sZy3Al6r+98qL2O0zu2HwVs3YN6IArumGPtNGKcZfYjQDVyOIX/FTxWaw/fhslkL29C7I8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBNgBfjN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad617d5b80so88211115ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773158421; x=1773763221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5K+H/IceKxyox6ZakgYOlccZsAjUOP17fRgxkl+6MeM=;
        b=jBNgBfjNlAqCewkpIVNTA5zv5kQQsflRLvyaovxjSMnCGAnMCGwMRVkelaroZD+4LP
         MpQDlouxDBGb54WZpNOBfjqkI8qvzwl6piKRLvfXKya60IjyAngWVHRQQW9JtBUAj1mS
         TMnV7b3tpalmbTraJpba0G3cJlzeDnj7AiIUq6+qWgv1+CHG9ueUE1m9dUmObxIBWhmJ
         +V5Nui/i0a/8Vv6UGd8hG9k7J3L6JxhBNO5c4+S/EyCWCvgu2q3VgDyDTOtcMU3nwcHZ
         A3rRWYW3Z6Ut9slhfxRB1NNICEeOQan7jyUh9uLFvfKvKC6IsYEgHQiCJUMZGfS7BPXq
         ExGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158421; x=1773763221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K+H/IceKxyox6ZakgYOlccZsAjUOP17fRgxkl+6MeM=;
        b=Z5Oyft6bDs8W4r7aAf30VQDvaf7DpAoZeNQ+UJr7+PwVCuMqNZCa79xAYzS71CU42L
         tVDo0TC+clQFSdOtCvxoBxxTMgkFCELzWiijrk0Oh0CUI+GDNOmTOjj2e3/ZsGkQallp
         c/XurKboEXK6q9QAMDOeD+VZWZk5S2ZNUzit4kl0ksRjUDqWKrpukEc0gEuJ9nWIAqgK
         rHHxGG5gSj2/Az+EWdpnwGvYuEmLA2lmrOJQtCZOnIgQG+WIe6ZcXV7Q+AusGz/VS8ej
         pZWyHH23CKK4II4ApPDC2dLyTNgMWy4owkVsMCI09/zavo49MXQ9lGEDYuXO/HC3uSJl
         xvDg==
X-Gm-Message-State: AOJu0YwGvxvqLJ8xwxbHGBCHwAgjLCrtB8FOzsMqKdS+lOKXNZ5OlH6N
	lp5lstO6Aw0fP7fUkDxinE+DTb2HBNxATl6R1s0JKFuZm26U1CGzZZjX1edV+lBr
X-Gm-Gg: ATEYQzxDH/qKTQhjwWDJJRgAYz8g/ZpdLJySvUdUNC3PnMMZiwH/3PJp3nu8xcjSzX9
	eqmp3Ih6nqqTdctloJsFi603CXKW2svDqrKR99i6bijS1zbM7Ncs382qTcWEru/LukbwDD7t05O
	Tnw2cfEuXdTFt29hs1ym4BPaKuG1na3aM1VR8wFtYLUyxyUeRNUBsfTQuueSqY4TrYfF+BLOupo
	/JidXJfpillPywCYsShsi604dcZxBHFY8r5Pm1ll7wzTzuZUtyqZrYfMlNbChwqkd6xtxyinuCQ
	rby3W6dhOoGHrhpBfaB5W/xkQt140UV/H8BEeOwKumg/D1KBIJCucgrUxv/XGVskBHKMqqvIuvo
	QB2igfTQoN7YvTve0ObdKhPdUTt8vnXVWsF/R+9FuaFyEq7CGT5eyWtqN7fz4TiqOI6y11Ohsuy
	ET9VnT6eU35QDsiqBaqwaH3YwgqffHOeTIqKzWmavIAARgVg4pND1bv0p6gFhJsXi/2s/Qg+yDa
	mXGPZE=
X-Received: by 2002:a17:902:e790:b0:2aa:d630:cd5d with SMTP id d9443c01a7336-2ae82505f47mr153997235ad.44.1773158421024;
        Tue, 10 Mar 2026 09:00:21 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:556d:5acf:90c3:ea17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8a629sm194496085ad.62.2026.03.10.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:00:20 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: fix WARN_ON_ONCE in ieee80211_tdls_oper
Date: Tue, 10 Mar 2026 21:30:13 +0530
Message-ID: <20260310160013.515096-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8BC7A254CDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32919-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,56b6a844a4ea74487b7b];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

NL80211_TDLS_ENABLE_LINK can be called without completing the TDLS
setup handshake, or after the TDLS_PEER_SETUP_TIMEOUT (15 seconds)
has expired and tdls_peer_del_work has zeroed out the peer address.
In both cases the WARN_ON_ONCE triggers because tdls_peer is either
zero or mismatched with the requested peer.

Replace the WARN_ON_ONCE with a proper check that returns -ENOLINK
to enforce that ENABLE_LINK can only proceed after a successful TDLS
handshake.

Reported-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=56b6a844a4ea74487b7b
Tested-by: syzbot+56b6a844a4ea74487b7b@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/mac80211/tdls.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index dbbfe2d6842f..d7d8b2fcc3ee 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1457,8 +1457,9 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 		set_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH);
 
-		WARN_ON_ONCE(is_zero_ether_addr(sdata->u.mgd.tdls_peer) ||
-			     !ether_addr_equal(sdata->u.mgd.tdls_peer, peer));
+		if (is_zero_ether_addr(sdata->u.mgd.tdls_peer) ||
+		    !ether_addr_equal(sdata->u.mgd.tdls_peer, peer))
+			return -ENOLINK;
 		break;
 	case NL80211_TDLS_DISABLE_LINK:
 		/*
-- 
2.43.0


